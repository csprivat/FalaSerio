# Arquitetura Técnica — Fala Sério

Este documento descreve a arquitetura técnica atual do projeto **Fala Sério**, aplicação web educacional de quiz anti fake news.

---

## Visão geral

O Fala Sério é uma aplicação web server-side renderizada com Flask, persistência em MariaDB e execução via Docker Compose.

A arquitetura atual é intencionalmente simples:

```text
Navegador do usuário
        |
        | HTTP/HTTPS
        v
Container web
Python + Flask + Gunicorn
        |
        | Conexão TCP interna Docker
        v
Container db
MariaDB 10.11
        |
        v
Volume Docker fngame_db_data
```

---

## Componentes principais

### 1. Serviço web

Definido no `docker-compose.yml` como serviço `web`.

Responsabilidades:

- renderizar páginas públicas;
- expor rotas do quiz em JSON;
- controlar sessão do usuário;
- aplicar CSRF nas requisições;
- aplicar rate limit;
- servir área administrativa;
- consultar e atualizar o banco via `db.py`.

Tecnologias:

- Python 3.11;
- Flask;
- Gunicorn;
- Flask-WTF;
- Flask-Limiter;
- Jinja templates;
- JavaScript simples no frontend.

Arquivo principal:

```text
web/app.py
```

Dockerfile:

```text
web/Dockerfile.web
```

---

### 2. Serviço de banco de dados

Definido no `docker-compose.yml` como serviço `db`.

Responsabilidades:

- armazenar temas;
- armazenar perguntas;
- armazenar pontuações/ranking;
- preservar dados via volume Docker.

Tecnologia:

- MariaDB 10.11.

Volume persistente:

```text
fngame_db_data:/var/lib/mysql
```

Scripts de inicialização para banco novo:

```text
docker/schema.sql
docker/seed.sql
```

---

### 3. Camada de acesso a dados

Arquivo:

```text
db.py
```

Responsabilidades:

- abrir conexão com MariaDB;
- buscar perguntas públicas ativas por tema;
- buscar temas;
- salvar pontuação web;
- consultar ranking;
- executar operações administrativas de perguntas.

Principais funções:

```text
fetch_questions(theme_id)
fetch_admin_questions(filters=None)
fetch_admin_question_by_id(question_id)
create_admin_question(data)
update_admin_question(question_id, data)
set_admin_question_active(question_id, is_active)
get_correct_answer(question_id)
fetch_themes()
save_web_score(session_id, username, score)
get_ranking(limit=10)
```

---

### 4. Templates e frontend

Templates Jinja:

```text
web/templates/
```

Arquivos relevantes:

```text
base.html
_header.html
_footer.html
index.html
temas.html
quiz.html
resultado.html
ranking.html
sobre.html
admin_login.html
admin_index.html
admin_questions.html
admin_question_detail.html
admin_question_edit.html
admin_question_new.html
```

JavaScript principal do quiz:

```text
web/static/js/quiz.js
```

CSS principal:

```text
web/static/css/style.css
```

---

## Banco de dados

### Tabela `themes`

Armazena os temas do quiz.

Campos principais:

```text
id
title
```

Temas iniciais:

```text
Educação
Política
Saúde
Tecnologia
Meio Ambiente
```

---

### Tabela `questions`

Armazena perguntas do quiz.

Campos principais:

```text
id
question_text
option_1
option_2
correct_answer
category
source
theme_id
is_active
content_type
context_text
explanation
tip_text
```

Regras importantes:

- `correct_answer` deve ser igual a `option_1` ou `option_2`;
- `content_type` aceita `fact_check` ou `scenario`;
- `is_active = 1` permite que a pergunta apareça no quiz público;
- `is_active = 0` mantém a pergunta no admin, mas remove do sorteio público;
- `context_text` é exibido antes da resposta quando preenchido;
- `explanation` é exibido após a resposta quando preenchido.

---

### Tabela `user_scores`

Armazena pontuações do ranking.

Campos principais:

```text
id
telegram_user_id
platform
platform_user_id
username
score
last_played
```

Embora exista compatibilidade com dados legados, o fluxo atual usa `platform = web`.

---

## Rotas públicas

```text
GET  /
GET  /temas
GET  /quiz
GET  /sobre
GET  /ranking
GET  /resultado
POST /quiz/iniciar
GET  /quiz/pergunta
POST /quiz/responder
POST /quiz/reiniciar
GET  /quiz/pontuacao
```

---

## Rotas administrativas

```text
GET  /admin/login
POST /admin/login
GET  /admin
GET  /admin/questions
GET  /admin/questions/new
POST /admin/questions/new
GET  /admin/questions/<question_id>
GET  /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/toggle-active
GET  /admin/logout
```

Todas as rotas administrativas, exceto login e logout, usam `admin_login_required`.

---

## Segurança atual

Medidas já implementadas:

- `FLASK_SECRET_KEY` obrigatório;
- sessão Flask com `HTTPOnly`;
- `SameSite=Lax`;
- `SESSION_COOKIE_SECURE` configurável por ambiente;
- CSRF via Flask-WTF;
- rate limit via Flask-Limiter;
- headers de segurança básicos:
  - `X-Content-Type-Options`;
  - `Referrer-Policy`;
  - `X-Frame-Options`;
  - `Content-Security-Policy`;
- login administrativo por variáveis de ambiente;
- respostas corretas não ficam expostas na sessão pública;
- validação anti-fraude simples por tempo mínimo plausível antes de salvar ranking.

---

## Fluxo de dados do quiz

```text
Usuário escolhe tema
        |
        v
POST /quiz/iniciar
        |
        v
fetch_questions(theme_id)
        |
        v
Sessão recebe perguntas sem resposta correta
        |
        v
GET /quiz/pergunta
        |
        v
Frontend renderiza pergunta, opções, contexto e dica
        |
        v
POST /quiz/responder
        |
        v
Backend consulta resposta correta no banco
        |
        v
Backend atualiza pontuação e progresso
        |
        v
Frontend exibe feedback e explicação
        |
        v
Usuário avança manualmente
        |
        v
Resultado e ranking
```

---

## Estratégia de banco novo e banco existente

### Banco novo

Para instalações novas, usar:

```text
docker/schema.sql
docker/seed.sql
```

Esses arquivos são montados no container MariaDB em `/docker-entrypoint-initdb.d/`.

### Banco existente

Para ambientes já inicializados, usar migrations:

```text
migrations/001_add_platform.sql
migrations/002_add_scenario_fields.sql
migrations/003_add_is_active_to_questions.sql
```

E scripts incrementais de conteúdo quando necessário:

```text
docker/scenario_updates.sql
docker/explanations.sql
docker/context_updates.sql
```

Atenção: scripts de `/docker-entrypoint-initdb.d/` não rodam novamente se o volume de dados já existir.

---

## Restrições arquiteturais recomendadas

Para preservar estabilidade:

- manter evolução em fases pequenas;
- evitar refatoração ampla sem necessidade;
- evitar troca de stack neste estágio;
- não alterar pontuação/ranking sem plano específico;
- não alterar schema sem migration correspondente;
- não instalar dependências novas sem justificativa;
- preservar o fluxo público do quiz enquanto a área administrativa evolui.
