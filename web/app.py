# -*- coding: utf-8 -*-
"""
Projeto: FNGame - Quiz Educacional Anti Fake News (Módulo Web)
Autor: Cristian Privat

Descrição:
Módulo web responsivo do FNGame, focado no combate à desinformação
através de quizzes interativos usando Flask + Bootstrap 5.

Licença: AGPLv3
"""

import os
import sys
import uuid
import random
import time
import csv
import io
from functools import wraps

from flask import Flask, render_template, request, session, jsonify, redirect, url_for, make_response
from dotenv import load_dotenv
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from flask_wtf.csrf import CSRFProtect

# Importar db.py do diretório pai
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
from db import (
    fetch_questions,
    fetch_themes,
    fetch_theme_ids,
    fetch_existing_question_keys,
    save_web_score,
    get_ranking,
    get_correct_answer,
    fetch_admin_questions,
    fetch_admin_questions_for_export,
    fetch_admin_question_by_id,
    update_admin_question,
    create_admin_question,
    create_admin_questions_bulk,
    delete_admin_question,
    set_admin_question_active,
)  # noqa: E402

load_dotenv()

app = Flask(__name__)
secret_key = os.getenv("FLASK_SECRET_KEY")
if not secret_key:
    raise RuntimeError("FLASK_SECRET_KEY não configurada.")
app.secret_key = secret_key
# Configurações de endurecimento de sessão
app.config.update(
    SESSION_COOKIE_HTTPONLY=True,
    SESSION_COOKIE_SAMESITE='Lax',
    SESSION_COOKIE_SECURE=os.getenv("SESSION_COOKIE_SECURE", "false").lower() == "true",
)

# Proteção CSRF
csrf = CSRFProtect(app)

# Inicializar o Limiter (padrão: armazenamento em memória)
limiter = Limiter(
    key_func=get_remote_address,
    app=app,
    default_limits=["500 per day", "100 per hour"],
    storage_uri="memory://",
)

@app.errorhandler(429)
def ratelimit_handler(e):
    return jsonify(error="Limite de requisições excedido. Tente novamente mais tarde."), 429

MAX_QUESTIONS_PER_SESSION = 10
ALLOWED_CONTENT_TYPES = {'fact_check', 'scenario'}
CSV_IMPORT_FIELDNAMES = [
    'question_text',
    'option_1',
    'option_2',
    'correct_answer',
    'content_type',
    'context_text',
    'explanation',
    'tip_text',
    'category',
    'source',
    'theme_id',
    'is_active',
]
ALLOWED_IS_ACTIVE_VALUES = {
    '1': 1,
    '0': 0,
    'true': 1,
    'false': 0,
    'sim': 1,
    'não': 0,
    'nao': 0,
    'ativo': 1,
    'inativo': 0,
}


def is_admin_authenticated():
    return session.get('admin_authenticated') is True


def admin_login_required(view_func):
    @wraps(view_func)
    def wrapped_view(*args, **kwargs):
        if not is_admin_authenticated():
            return redirect(url_for('admin_login'))
        return view_func(*args, **kwargs)
    return wrapped_view


def normalize_optional_text(value):
    cleaned = (value or '').strip()
    return cleaned or None


def normalize_import_text(value):
    return (value or '').strip()


def parse_import_is_active(value):
    normalized = normalize_import_text(value).lower()
    if not normalized:
        return 1, None
    if normalized in ALLOWED_IS_ACTIVE_VALUES:
        return ALLOWED_IS_ACTIVE_VALUES[normalized], None
    return None, 'is_active inválido. Use 1, 0, true, false, sim, não, ativo ou inativo.'


def build_import_question_key(row):
    return (
        row['question_text'],
        row['option_1'],
        row['option_2'],
        row['correct_answer'],
        row['theme_id'],
    )


def validate_import_csv_rows(rows, theme_ids, existing_question_keys):
    validated_rows = []
    errors = []
    seen_csv_keys = set()

    for index, row in enumerate(rows, start=2):
        normalized_row = {field: normalize_import_text(row.get(field)) for field in CSV_IMPORT_FIELDNAMES}
        if not any(normalized_row.values()):
            continue

        if not normalized_row['question_text']:
            errors.append(f'Linha {index}: question_text é obrigatório.')
        if not normalized_row['option_1']:
            errors.append(f'Linha {index}: option_1 é obrigatório.')
        if not normalized_row['option_2']:
            errors.append(f'Linha {index}: option_2 é obrigatório.')
        if not normalized_row['correct_answer']:
            errors.append(f'Linha {index}: correct_answer é obrigatório.')
        elif normalized_row['correct_answer'] not in {normalized_row['option_1'], normalized_row['option_2']}:
            errors.append(f'Linha {index}: correct_answer deve ser igual a option_1 ou option_2.')

        if not normalized_row['content_type']:
            errors.append(f'Linha {index}: content_type é obrigatório.')
        elif normalized_row['content_type'] not in ALLOWED_CONTENT_TYPES:
            errors.append(f'Linha {index}: content_type inválido. Use fact_check ou scenario.')

        parsed_theme_id = None
        if not normalized_row['theme_id']:
            errors.append(f'Linha {index}: theme_id é obrigatório.')
        else:
            try:
                parsed_theme_id = int(normalized_row['theme_id'])
            except ValueError:
                errors.append(f'Linha {index}: theme_id deve ser um número inteiro.')
            else:
                if parsed_theme_id not in theme_ids:
                    errors.append(f'Linha {index}: theme_id {parsed_theme_id} não existe.')

        parsed_is_active, is_active_error = parse_import_is_active(normalized_row['is_active'])
        if is_active_error:
            errors.append(f'Linha {index}: {is_active_error}')

        validated_rows.append({
            'question_text': normalized_row['question_text'],
            'option_1': normalized_row['option_1'],
            'option_2': normalized_row['option_2'],
            'correct_answer': normalized_row['correct_answer'],
            'content_type': normalized_row['content_type'],
            'context_text': normalized_row['context_text'] or None,
            'explanation': normalized_row['explanation'] or None,
            'tip_text': normalized_row['tip_text'] or None,
            'category': normalized_row['category'] or 'geral',
            'source': normalized_row['source'] or None,
            'theme_id': parsed_theme_id,
            'is_active': parsed_is_active,
        })

        if parsed_theme_id is not None:
            question_key = build_import_question_key(validated_rows[-1])
            if question_key in existing_question_keys:
                errors.append(
                    f'Linha {index}: pergunta duplicada. Já existe uma pergunta com o mesmo texto, opções, resposta correta e tema.'
                )
            elif question_key in seen_csv_keys:
                errors.append(f'Linha {index}: pergunta duplicada no próprio arquivo CSV.')
            else:
                seen_csv_keys.add(question_key)

    if not validated_rows and not errors:
        return [], ['O arquivo CSV não possui linhas de dados para importar.']
    if errors:
        return [], errors
    return validated_rows, []


def build_admin_question_form_data(form_data):
    return {
        'question_text': (form_data.get('question_text') or '').strip(),
        'option_1': (form_data.get('option_1') or '').strip(),
        'option_2': (form_data.get('option_2') or '').strip(),
        'correct_answer': (form_data.get('correct_answer') or '').strip(),
        'content_type': (form_data.get('content_type') or '').strip(),
        'context_text': normalize_optional_text(form_data.get('context_text')),
        'explanation': normalize_optional_text(form_data.get('explanation')),
        'tip_text': normalize_optional_text(form_data.get('tip_text')),
        'category': normalize_optional_text(form_data.get('category')),
        'source': normalize_optional_text(form_data.get('source')),
        'theme_id': (form_data.get('theme_id') or '').strip(),
    }


def validate_admin_question_form(form_data):
    if not form_data['question_text']:
        return 'O campo pergunta é obrigatório.'
    if not form_data['option_1']:
        return 'O campo opção 1 é obrigatório.'
    if not form_data['option_2']:
        return 'O campo opção 2 é obrigatório.'
    if not form_data['correct_answer']:
        return 'O campo resposta correta é obrigatório.'
    if form_data['correct_answer'] not in {form_data['option_1'], form_data['option_2']}:
        return 'A resposta correta deve ser exatamente igual à opção 1 ou à opção 2.'
    if not form_data['content_type']:
        return 'O campo tipo de conteúdo é obrigatório.'
    if form_data['content_type'] not in ALLOWED_CONTENT_TYPES:
        return 'O tipo de conteúdo deve ser fact_check ou scenario.'

    theme_value = form_data['theme_id']
    if not theme_value:
        form_data['theme_id'] = None
        return None

    try:
        form_data['theme_id'] = int(theme_value)
    except ValueError:
        return 'O campo theme_id deve ser um número inteiro válido.'

    return None

@app.after_request
def add_security_headers(response):
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
    response.headers['X-Frame-Options'] = 'DENY'
    
    # CSP Simples - Permitindo fontes Google, Tailwind CDN e texturas externas utilizadas
    csp = (
        "default-src 'self'; "
        "script-src 'self' 'unsafe-inline' https://cdn.tailwindcss.com; "
        "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; "
        "font-src 'self' https://fonts.gstatic.com; "
        "img-src 'self' data: https://www.transparenttextures.com; "
        "connect-src 'self';"
    )
    response.headers['Content-Security-Policy'] = csp
    return response


# ----------------------------------------------------------------
# Rotas de página (SSR)
# ----------------------------------------------------------------

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/temas')
def temas():
    temas_list = fetch_themes()
    return render_template('temas.html', temas=temas_list)


@app.route('/quiz')
def quiz():
    if 'questions' not in session:
        return redirect(url_for('temas'))
    return render_template('quiz.html')


@app.route('/sobre')
def sobre():
    return render_template('sobre.html')


@app.route('/ranking')
def ranking():
    top_users = get_ranking(limit=10)
    return render_template('ranking.html', top_users=top_users)


@app.route('/resultado')
def resultado():
    score = session.get('score', 0)
    total = session.get('total', 0)
    return render_template('resultado.html', score=score, total=total,
                           feedback=get_feedback(score))


@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    error_message = None

    if request.method == 'POST':
        admin_username = os.getenv('ADMIN_USERNAME')
        admin_password = os.getenv('ADMIN_PASSWORD')
        username = request.form.get('username', '').strip()
        password = request.form.get('password', '')

        if admin_username and admin_password and username == admin_username and password == admin_password:
            session['admin_authenticated'] = True
            return redirect(url_for('admin_index'))

        error_message = 'Usuário ou senha inválidos.'

    return render_template('admin_login.html', error_message=error_message)


@app.route('/admin')
@admin_login_required
def admin_index():
    return render_template('admin_index.html')


@app.route('/admin/questions')
@admin_login_required
def admin_questions():
    filters = {}
    filter_values = {
        'theme_id': request.args.get('theme_id', 'all').strip(),
        'content_type': request.args.get('content_type', 'all').strip(),
        'is_active': request.args.get('is_active', 'all').strip(),
    }
    themes = fetch_themes()

    theme_id = filter_values['theme_id']
    if theme_id not in {'', 'all'}:
        try:
            filters['theme_id'] = int(theme_id)
        except ValueError:
            filter_values['theme_id'] = 'all'

    if filter_values['content_type'] in ALLOWED_CONTENT_TYPES:
        filters['content_type'] = filter_values['content_type']
    elif filter_values['content_type'] not in {'', 'all'}:
        filter_values['content_type'] = 'all'

    if filter_values['is_active'] in {'0', '1'}:
        filters['is_active'] = int(filter_values['is_active'])
    elif filter_values['is_active'] not in {'', 'all'}:
        filter_values['is_active'] = 'all'

    questions = fetch_admin_questions(filters=filters)
    return render_template('admin_questions.html', questions=questions, filter_values=filter_values, themes=themes)


@app.route('/admin/questions/export')
@admin_login_required
def admin_questions_export():
    export_rows = fetch_admin_questions_for_export()
    fieldnames = [
        'id',
        'question_text',
        'option_1',
        'option_2',
        'correct_answer',
        'content_type',
        'context_text',
        'explanation',
        'tip_text',
        'category',
        'source',
        'theme_id',
        'theme_title',
        'is_active',
    ]

    output = io.StringIO(newline='')
    writer = csv.DictWriter(output, fieldnames=fieldnames, delimiter=';', quoting=csv.QUOTE_MINIMAL)
    writer.writeheader()

    for row in export_rows:
        writer.writerow({
            'id': row.get('id'),
            'question_text': row.get('question_text') or '',
            'option_1': row.get('option_1') or '',
            'option_2': row.get('option_2') or '',
            'correct_answer': row.get('correct_answer') or '',
            'content_type': row.get('content_type') or '',
            'context_text': row.get('context_text') or '',
            'explanation': row.get('explanation') or '',
            'tip_text': row.get('tip_text') or '',
            'category': row.get('category') or '',
            'source': row.get('source') or '',
            'theme_id': row.get('theme_id') if row.get('theme_id') is not None else '',
            'theme_title': row.get('theme_title') or '',
            'is_active': row.get('is_active'),
        })

    csv_content = output.getvalue()
    response = make_response('\ufeff' + csv_content)
    response.headers['Content-Type'] = 'text/csv; charset=utf-8-sig'
    response.headers['Content-Disposition'] = 'attachment; filename=perguntas_fala_serio.csv'
    return response


@app.route('/admin/questions/import-template')
@admin_login_required
def admin_questions_import_template():
    output = io.StringIO(newline='')
    writer = csv.DictWriter(output, fieldnames=CSV_IMPORT_FIELDNAMES, delimiter=';', quoting=csv.QUOTE_MINIMAL)
    writer.writeheader()
    writer.writerow({
        'question_text': 'Exemplo de pergunta para importação. Isso é verdadeiro ou falso?',
        'option_1': 'Verdadeiro',
        'option_2': 'Falso',
        'correct_answer': 'Verdadeiro',
        'content_type': 'fact_check',
        'context_text': 'Este campo pode trazer um contexto curto antes da resposta.',
        'explanation': 'Este campo pode trazer uma explicação exibida após a resposta.',
        'tip_text': 'Este campo pode trazer uma dica curta, se necessário.',
        'category': 'geral',
        'source': 'https://exemplo.org',
        'theme_id': '1',
        'is_active': '1',
    })

    csv_content = output.getvalue()
    response = make_response('\ufeff' + csv_content)
    response.headers['Content-Type'] = 'text/csv; charset=utf-8-sig'
    response.headers['Content-Disposition'] = 'attachment; filename=modelo_importacao_perguntas_fala_serio.csv'
    return response


@app.route('/admin/questions/import', methods=['GET', 'POST'])
@admin_login_required
def admin_questions_import():
    error_message = None
    success_message = None
    import_errors = []

    if request.method == 'POST':
        upload = request.files.get('csv_file')

        if not upload or not upload.filename:
            error_message = 'Selecione um arquivo CSV para importar.'
        elif not upload.filename.lower().endswith('.csv'):
            error_message = 'Envie um arquivo com extensão .csv.'
        else:
            try:
                csv_text = upload.stream.read().decode('utf-8-sig')
            except UnicodeDecodeError:
                error_message = 'Não foi possível ler o arquivo. Use CSV em UTF-8.'
            else:
                csv_stream = io.StringIO(csv_text, newline='')
                reader = csv.DictReader(csv_stream, delimiter=';')
                headers = reader.fieldnames or []
                missing_headers = [field for field in CSV_IMPORT_FIELDNAMES if field not in headers]

                if missing_headers:
                    error_message = 'O arquivo CSV não contém todos os cabeçalhos obrigatórios do modelo.'
                    import_errors = [f'Cabeçalho ausente: {field}.' for field in missing_headers]
                else:
                    theme_ids = fetch_theme_ids()
                    existing_question_keys = fetch_existing_question_keys()
                    validated_rows, import_errors = validate_import_csv_rows(
                        list(reader),
                        theme_ids,
                        existing_question_keys,
                    )

                    if not import_errors:
                        inserted_count = create_admin_questions_bulk(validated_rows)
                        if inserted_count is None:
                            error_message = 'Ocorreu um erro inesperado ao gravar as perguntas. Nenhuma pergunta foi importada.'
                        else:
                            success_message = f'Importação concluída com sucesso. {inserted_count} perguntas foram adicionadas.'

    return render_template(
        'admin_question_import.html',
        error_message=error_message,
        success_message=success_message,
        import_errors=import_errors,
    )


@app.route('/admin/questions/new', methods=['GET', 'POST'])
@admin_login_required
def admin_question_new():
    error_message = None
    form_data = {
        'question_text': '',
        'option_1': '',
        'option_2': '',
        'correct_answer': '',
        'content_type': 'fact_check',
        'context_text': '',
        'explanation': '',
        'tip_text': '',
        'category': '',
        'source': '',
        'theme_id': '',
    }

    if request.method == 'POST':
        form_data = build_admin_question_form_data(request.form)
        error_message = validate_admin_question_form(form_data)

        if not error_message:
            new_question_id = create_admin_question(form_data)
            if new_question_id:
                return redirect(url_for('admin_question_detail', question_id=new_question_id))
            error_message = 'Não foi possível criar a pergunta.'

    return render_template('admin_question_new.html', form_data=form_data, error_message=error_message)


@app.route('/admin/questions/<int:question_id>')
@admin_login_required
def admin_question_detail(question_id):
    question = fetch_admin_question_by_id(question_id)
    if not question:
        return render_template('admin_question_detail.html', question=None, question_id=question_id), 404
    return render_template('admin_question_detail.html', question=question, question_id=question_id)


@app.route('/admin/questions/<int:question_id>/toggle-active', methods=['POST'])
@admin_login_required
def admin_question_toggle_active(question_id):
    question = fetch_admin_question_by_id(question_id)
    if not question:
        return render_template('admin_question_detail.html', question=None, question_id=question_id), 404

    updated = set_admin_question_active(question_id, not bool(question.get('is_active')))
    if not updated:
        return render_template('admin_question_detail.html', question=question, question_id=question_id), 500

    return redirect(url_for('admin_question_detail', question_id=question_id))


@app.route('/admin/questions/<int:question_id>/edit', methods=['GET', 'POST'])
@admin_login_required
def admin_question_edit(question_id):
    question = fetch_admin_question_by_id(question_id)
    if not question:
        return render_template('admin_question_edit.html', question=None, question_id=question_id, form_data=None, error_message=None), 404

    error_message = None
    form_data = {
        'question_text': question['question_text'],
        'option_1': question['option_1'],
        'option_2': question['option_2'],
        'correct_answer': question['correct_answer'],
        'content_type': question['content_type'],
        'context_text': question['context_text'] or '',
        'explanation': question['explanation'] or '',
        'tip_text': question['tip_text'] or '',
        'category': question['category'] or '',
        'source': question['source'] or '',
        'theme_id': '' if question['theme_id'] is None else str(question['theme_id']),
    }

    if request.method == 'POST':
        form_data = build_admin_question_form_data(request.form)
        error_message = validate_admin_question_form(form_data)

        if not error_message:
            saved = update_admin_question(question_id, form_data)
            if saved:
                return redirect(url_for('admin_question_detail', question_id=question_id))
            error_message = 'Não foi possível salvar a pergunta.'

    return render_template(
        'admin_question_edit.html',
        question=question,
        question_id=question_id,
        form_data=form_data,
        error_message=error_message,
    )


@app.route('/admin/questions/<int:question_id>/delete', methods=['GET', 'POST'])
@admin_login_required
def admin_question_delete(question_id):
    question = fetch_admin_question_by_id(question_id)
    if not question:
        return render_template('admin_question_detail.html', question=None, question_id=question_id), 404

    error_message = None
    if question.get('is_active'):
        error_message = 'Perguntas ativas não podem ser excluídas. Desative a pergunta antes de solicitar a exclusão definitiva.'
        return render_template(
            'admin_question_delete.html',
            question=question,
            question_id=question_id,
            error_message=error_message,
            deletion_blocked=True,
        ), 400

    if request.method == 'POST':
        confirmation_value = (request.form.get('confirm_delete') or '').strip()
        if confirmation_value != 'EXCLUIR':
            error_message = 'Confirmação inválida. Digite EXCLUIR para confirmar a exclusão definitiva.'
        else:
            deleted = delete_admin_question(question_id)
            if deleted:
                return redirect(url_for('admin_questions'))
            error_message = 'Não foi possível excluir a pergunta.'

    return render_template(
        'admin_question_delete.html',
        question=question,
        question_id=question_id,
        error_message=error_message,
        deletion_blocked=False,
    )


@app.route('/admin/logout')
def admin_logout():
    session.pop('admin_authenticated', None)
    return redirect(url_for('admin_login'))


# ----------------------------------------------------------------
# Rotas do quiz (JSON API)
# ----------------------------------------------------------------

@app.route('/quiz/iniciar', methods=['POST'])
@limiter.limit("5 per minute")
def quiz_iniciar():
    data = request.get_json()
    if not data:
        return jsonify(error="Dados inválidos"), 400

    theme_id = data.get('theme_id')
    nickname = data.get('nickname', '').strip() or 'Anônimo'

    if not theme_id:
        return jsonify(error="Tema não selecionado"), 400

    questions = fetch_questions(theme_id=int(theme_id))
    if not questions:
        return jsonify(error="Nenhuma pergunta encontrada para este tema"), 404

    random.shuffle(questions)
    questions = questions[:MAX_QUESTIONS_PER_SESSION]

    # Garantir identificador persistente para o usuário web
    if 'user_id' not in session:
        session['user_id'] = str(uuid.uuid4())

    session['nickname'] = nickname
    # Reduzindo a exposição: salvamos apenas a estrutura da pergunta sem a resposta
    session['questions'] = [{
        'id': q['id'],
        'question': q['question'],
        'options': q['options'],
        'content_type': q.get('content_type', ''),
        'context_text': q.get('context_text'),
        'tip_text': q.get('tip_text'),
        'explanation': q.get('explanation')
    } for q in questions]

    session['theme_id'] = theme_id
    session['theme_title'] = data.get('theme_title', 'Quiz')
    session['progress'] = 0
    session['score'] = 0
    session['total'] = len(session['questions'])
    session['start_time'] = time.time()
    session['score_saved'] = False

    return jsonify(total=len(session['questions']))


@app.route('/quiz/pergunta')
def quiz_pergunta():
    questions = session.get('questions')
    if not questions:
        return jsonify(error="Nenhum quiz ativo. Escolha um tema primeiro."), 400

    progress = session.get('progress', 0)
    total = session.get('total', 0)

    if progress >= total:
        return jsonify(finished=True, score=session.get('score', 0), total=total)

    q = questions[progress]
    return jsonify(
        index=progress + 1,
        total=total,
        question=q['question'],
        options=q['options'],
        content_type=q.get('content_type', ''),
        context_text=q.get('context_text'),
        tip_text=q.get('tip_text'),
        score=session.get('score', 0)
    )


@app.route('/quiz/responder', methods=['POST'])
@limiter.limit("30 per minute")
def quiz_responder():
    questions = session.get('questions')
    if not questions:
        return jsonify(error="Nenhum quiz ativo."), 400

    progress = session.get('progress', 0)
    total = session.get('total', 0)

    if progress >= total:
        return jsonify(error="Quiz já finalizado."), 400

    data = request.get_json()
    if not data or 'answer' not in data:
        return jsonify(error="Resposta não enviada"), 400

    answer = data['answer']
    current_q = questions[progress]
    # Buscar a resposta correta no banco de dados para evitar exposição na sessão
    correct_answer = get_correct_answer(current_q['id'])
    is_correct = (answer == correct_answer)

    if is_correct:
        session['score'] = session.get('score', 0) + 1

    session['progress'] = progress + 1

    # Se era a última pergunta, salvar pontuação com validação anti-fraude
    finished = (session['progress'] >= total)
    if finished:
        duration = time.time() - session.get('start_time', 0)
        min_time_threshold = total * 0.8  # Ex: 0.8s por questão (mínimo irreal para leitura humana)
        
        # Só salva se não foi salvo antes e o tempo de resposta for plausível
        if not session.get('score_saved', False) and duration >= min_time_threshold:
            save_web_score(
                session_id=session.get('user_id', ''),
                username=session.get('nickname', 'Anônimo'),
                score=session.get('score', 0)
            )
            session['score_saved'] = True

    return jsonify(
        correct=is_correct,
        finished=finished,
        score=session.get('score', 0),
        progress=session['progress'],
        total=total,
        explanation=current_q.get('explanation')
    )


@app.route('/quiz/reiniciar', methods=['POST'])
@limiter.limit("5 per minute")
def quiz_reiniciar():
    theme_id = session.get('theme_id')
    if not theme_id:
        return jsonify(error="Nenhum quiz ativo."), 400

    questions = fetch_questions(theme_id=int(theme_id))
    if not questions:
        return jsonify(error="Erro ao buscar perguntas."), 500

    random.shuffle(questions)
    questions = questions[:MAX_QUESTIONS_PER_SESSION]

    session['questions'] = [{
        'id': q['id'],
        'question': q['question'],
        'options': q['options'],
        'content_type': q.get('content_type', ''),
        'context_text': q.get('context_text'),
        'tip_text': q.get('tip_text'),
        'explanation': q.get('explanation')
    } for q in questions]

    session['progress'] = 0
    session['score'] = 0
    session['total'] = len(session['questions'])
    session['start_time'] = time.time()
    session['score_saved'] = False

    return jsonify(total=len(session['questions']))


@app.route('/quiz/pontuacao')
def quiz_pontuacao():
    return jsonify(
        score=session.get('score', 0),
        progress=session.get('progress', 0),
        total=session.get('total', 0)
    )


# ----------------------------------------------------------------
# Feedback adaptativo (mesmas faixas do bot Telegram)
# ----------------------------------------------------------------

def get_feedback(score):
    if score <= 2:
        return {
            'level': 'beginner',
            'color': 'danger',
            'icon': '⚠️',
            'title': 'Continue aprendendo!',
            'message': (
                'Você ainda está aprendendo a identificar notícias falsas, '
                'e isso é totalmente normal!'
            ),
            'links': [
                {'text': 'Guia SaferNet sobre Fake News', 'url': 'https://www.safernet.org.br/site/prevencao/fake-news'},
                {'text': 'Cartilha do CERT-BR sobre Boatos', 'url': 'https://cartilha.cert.br/fasciculos/boatos/fasciculo-boatos.pdf'},
            ]
        }
    elif score <= 4:
        return {
            'level': 'intermediate',
            'color': 'warning',
            'icon': '🔍',
            'title': 'Bom começo!',
            'message': 'Você já sabe algumas coisas sobre fake news. Ótimo começo!',
            'links': [
                {'text': 'Projeto Comprova', 'url': 'https://projetocomprova.com.br/'},
                {'text': 'Cartilha do CERT-BR', 'url': 'https://cartilha.cert.br/fasciculos/boatos/fasciculo-boatos.pdf'},
            ]
        }
    elif score <= 7:
        return {
            'level': 'good',
            'color': 'info',
            'icon': '✅',
            'title': 'Muito bem!',
            'message': (
                'Você já entende sobre o que é uma fake news. '
                'Continue praticando e ajude seus amigos e familiares!'
            ),
            'links': []
        }
    elif score <= 9:
        return {
            'level': 'great',
            'color': 'success',
            'icon': '🎯',
            'title': 'Mandou muito bem!',
            'message': (
                'Parabéns por saber identificar boatos e notícias falsas. '
                'Que tal ajudar outras pessoas a fazerem o mesmo?'
            ),
            'links': []
        }
    else:
        return {
            'level': 'perfect',
            'color': 'warning',
            'icon': '🏆',
            'title': 'Nota 10! Gabaritou!',
            'message': (
                'Você mostrou que entende muito bem como se proteger das fake news. '
                'Continue espalhando informação de verdade!'
            ),
            'links': []
        }


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
