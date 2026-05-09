# -*- coding: utf-8 -*-
"""
Projeto: FNGame - Quiz Educacional Anti Fake News
Autor: Cristian Privat

Descrição:
Este módulo cuida da inserção de perguntas no banco de dados MariaDB.
"""

import logging
import mysql.connector
from mysql.connector import Error
import os
from dotenv import load_dotenv

# Carrega variáveis de ambiente do .env
load_dotenv()

DB_CONFIG = {
    'host': os.getenv("DB_HOST"),
    'port': int(os.getenv("DB_PORT", 3306)),
    'user': os.getenv("DB_USER"),
    'password': os.getenv("DB_PASSWORD"),
    'database': os.getenv("DB_NAME"),
}

def insert_question(data_tuple, theme_id):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        query = (
            "INSERT INTO questions "
            "(question_text, option_1, option_2, correct_answer, category, source, theme_id) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)"
        )
        question_text, option_1, option_2, correct_answer, category, source = data_tuple
        cursor.execute(query, (question_text, option_1, option_2, correct_answer, category, source, theme_id))
        connection.commit()

    except mysql.connector.IntegrityError as e:
        logging.error("Erro de integridade ao inserir pergunta: %s", e)
        if "a foreign key constraint fails" in str(e):
            logging.warning("theme_id=%s não existe na tabela 'themes'.", theme_id)

    except Error as e:
        logging.error("Erro no banco de dados ao inserir pergunta: %s", e)

    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def get_connection():
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        return connection
    except Error as e:
        logging.error("Erro ao conectar no banco de dados: %s", e)
        raise


def fetch_questions(theme_id):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("""
            SELECT id, question_text, option_1, option_2, correct_answer,
                   content_type, context_text, explanation, tip_text
            FROM questions
            WHERE theme_id = %s AND is_active = 1
            ORDER BY RAND()
            LIMIT 20
        """, (theme_id,))
        results = cursor.fetchall()
        questions = [
            {
                "id": row["id"],
                "question": row["question_text"],
                "options": [row["option_1"], row["option_2"]],
                "answer": row["correct_answer"],
                "content_type": row["content_type"],
                "context_text": row["context_text"],
                "explanation": row["explanation"],
                "tip_text": row["tip_text"]
            }
            for row in results
        ]
        return questions
    except Error as e:
        logging.error("Erro ao buscar perguntas (theme_id=%s): %s", theme_id, e)
        return []
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_admin_questions(filters=None):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        filters = filters or {}
        conditions = []
        params = []

        if filters.get('theme_id') is not None:
            conditions.append("q.theme_id = %s")
            params.append(filters['theme_id'])
        if filters.get('content_type'):
            conditions.append("q.content_type = %s")
            params.append(filters['content_type'])
        if filters.get('is_active') is not None:
            conditions.append("q.is_active = %s")
            params.append(filters['is_active'])

        where_clause = ""
        if conditions:
            where_clause = "WHERE " + " AND ".join(conditions)

        cursor.execute(f"""
            SELECT q.id,
                   q.question_text,
                   q.content_type,
                   q.category,
                   q.source,
                   q.theme_id,
                   q.is_active,
                   q.context_text,
                   q.explanation,
                   t.title AS theme_title
            FROM questions q
            LEFT JOIN themes t ON t.id = q.theme_id
            {where_clause}
            ORDER BY q.id ASC
        """, tuple(params))
        return cursor.fetchall()
    except Error as e:
        logging.error("Erro ao buscar perguntas administrativas: %s", e)
        return []
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_admin_questions_for_export():
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("""
            SELECT q.id,
                   q.question_text,
                   q.option_1,
                   q.option_2,
                   q.correct_answer,
                   q.content_type,
                   q.context_text,
                   q.explanation,
                   q.tip_text,
                   q.category,
                   q.source,
                   q.theme_id,
                   t.title AS theme_title,
                   q.is_active
            FROM questions q
            LEFT JOIN themes t ON t.id = q.theme_id
            ORDER BY q.id ASC
        """)
        return cursor.fetchall()
    except Error as e:
        logging.error("Erro ao buscar perguntas para exportação administrativa: %s", e)
        return []
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_admin_question_by_id(question_id):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("""
            SELECT q.id,
                   q.question_text,
                   q.option_1,
                   q.option_2,
                   q.correct_answer,
                   q.content_type,
                   q.is_active,
                   q.context_text,
                   q.explanation,
                   q.tip_text,
                   q.category,
                   q.source,
                   q.theme_id,
                   t.title AS theme_title
            FROM questions q
            LEFT JOIN themes t ON t.id = q.theme_id
            WHERE q.id = %s
        """, (question_id,))
        return cursor.fetchone()
    except Error as e:
        logging.error("Erro ao buscar pergunta administrativa (id=%s): %s", question_id, e)
        return None
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def update_admin_question(question_id, data):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""
            UPDATE questions
            SET question_text = %s,
                option_1 = %s,
                option_2 = %s,
                correct_answer = %s,
                content_type = %s,
                context_text = %s,
                explanation = %s,
                tip_text = %s,
                category = %s,
                source = %s,
                theme_id = %s
            WHERE id = %s
        """, (
            data['question_text'],
            data['option_1'],
            data['option_2'],
            data['correct_answer'],
            data['content_type'],
            data['context_text'],
            data['explanation'],
            data['tip_text'],
            data['category'],
            data['source'],
            data['theme_id'],
            question_id,
        ))
        connection.commit()
        return cursor.rowcount > 0
    except Error as e:
        logging.error("Erro ao atualizar pergunta administrativa (id=%s): %s", question_id, e)
        return False
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def create_admin_question(data):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO questions (
                question_text,
                option_1,
                option_2,
                correct_answer,
                content_type,
                context_text,
                explanation,
                tip_text,
                category,
                source,
                theme_id
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            data['question_text'],
            data['option_1'],
            data['option_2'],
            data['correct_answer'],
            data['content_type'],
            data['context_text'],
            data['explanation'],
            data['tip_text'],
            data['category'],
            data['source'],
            data['theme_id'],
        ))
        connection.commit()
        return cursor.lastrowid
    except Error as e:
        logging.error("Erro ao criar pergunta administrativa: %s", e)
        return None
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def set_admin_question_active(question_id, is_active):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""
            UPDATE questions
            SET is_active = %s
            WHERE id = %s
        """, (1 if is_active else 0, question_id))
        connection.commit()
        return cursor.rowcount > 0
    except Error as e:
        logging.error("Erro ao atualizar status da pergunta administrativa (id=%s): %s", question_id, e)
        return False
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def delete_admin_question(question_id):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("DELETE FROM questions WHERE id = %s", (question_id,))
        connection.commit()
        return cursor.rowcount > 0
    except Error as e:
        logging.error("Erro ao excluir pergunta administrativa (id=%s): %s", question_id, e)
        return False
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def get_correct_answer(question_id):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT correct_answer FROM questions WHERE id = %s", (question_id,))
        result = cursor.fetchone()
        return result["correct_answer"] if result else None
    except Error as e:
        logging.error("Erro ao buscar resposta (id=%s): %s", question_id, e)
        return None
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_themes():
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT id, title FROM themes ORDER BY id")
        return cursor.fetchall()
    except Error as e:
        logging.error("Erro ao buscar temas: %s", e)
        return []
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_theme_ids():
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("SELECT id FROM themes")
        return {row[0] for row in cursor.fetchall()}
    except Error as e:
        logging.error("Erro ao buscar IDs de temas: %s", e)
        return set()
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def fetch_existing_question_keys():
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("""
            SELECT question_text,
                   option_1,
                   option_2,
                   correct_answer,
                   theme_id
            FROM questions
        """)
        return {
            (
                (row['question_text'] or '').strip(),
                (row['option_1'] or '').strip(),
                (row['option_2'] or '').strip(),
                (row['correct_answer'] or '').strip(),
                row['theme_id'],
            )
            for row in cursor.fetchall()
        }
    except Error as e:
        logging.error("Erro ao buscar chaves de perguntas existentes: %s", e)
        return set()
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def create_admin_questions_bulk(rows):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.executemany("""
            INSERT INTO questions (
                question_text,
                option_1,
                option_2,
                correct_answer,
                content_type,
                context_text,
                explanation,
                tip_text,
                category,
                source,
                theme_id,
                is_active
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, [
            (
                row['question_text'],
                row['option_1'],
                row['option_2'],
                row['correct_answer'],
                row['content_type'],
                row['context_text'],
                row['explanation'],
                row['tip_text'],
                row['category'],
                row['source'],
                row['theme_id'],
                row['is_active'],
            )
            for row in rows
        ])
        connection.commit()
        return cursor.rowcount
    except Error as e:
        if 'connection' in locals() and connection.is_connected():
            connection.rollback()
        logging.error("Erro ao criar perguntas administrativas em lote: %s", e)
        return None
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def save_web_score(session_id, username, score):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            "SELECT score FROM user_scores WHERE platform = 'web' AND platform_user_id = %s",
            (session_id,)
        )
        result = cursor.fetchone()

        if result:
            cursor.execute(
                "UPDATE user_scores SET score = score + %s, username = %s, last_played = NOW() "
                "WHERE platform = 'web' AND platform_user_id = %s",
                (score, username, session_id)
            )
        else:
            cursor.execute(
                "INSERT INTO user_scores (platform, platform_user_id, username, score, last_played) "
                "VALUES ('web', %s, %s, %s, NOW())",
                (session_id, username, score)
            )
        connection.commit()

    except Error as e:
        logging.error("Erro ao salvar pontuação web (session_id=%s): %s", session_id, e)
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def get_ranking(limit=10):
    try:
        connection = get_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute(
            "SELECT username, score, platform FROM user_scores ORDER BY score DESC LIMIT %s",
            (limit,)
        )
        return cursor.fetchall()
    except Error as e:
        logging.error("Erro ao buscar ranking: %s", e)
        return []
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()
