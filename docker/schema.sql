-- FNGame – Schema do banco de dados
-- Compatível com MySQL 8+ / MariaDB 10.5+
-- Colunas alinhadas com db.py e web/app.py

CREATE DATABASE IF NOT EXISTS fngame
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE fngame;

-- ----------------------------------------------------------------
-- Tabela de temas
-- Coluna: title (referenciada em db.py e web/app.py)
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS themes (
  id    INT          NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed dos 5 temas mapeados em FNGame_scraper.py / MAPEAMENTO_CATEGORIA_THEME_ID
INSERT IGNORE INTO themes (id, title) VALUES
  (1, 'Educação'),
  (2, 'Política'),
  (3, 'Saúde'),
  (4, 'Tecnologia'),
  (5, 'Meio Ambiente');

-- ----------------------------------------------------------------
-- Tabela de perguntas
-- Colunas alinhadas com db.py:
--   INSERT: question_text, option_1, option_2, correct_answer, category, source, theme_id
--   SELECT: question_text, option_1, option_2, correct_answer
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS questions (
  id             INT          NOT NULL AUTO_INCREMENT,
  question_text  TEXT         NOT NULL,
  option_1       VARCHAR(255) NOT NULL,
  option_2       VARCHAR(255) NOT NULL,
  correct_answer VARCHAR(255) NOT NULL,
  category       VARCHAR(100) DEFAULT NULL,
  source         VARCHAR(500) DEFAULT NULL,
  theme_id       INT          DEFAULT NULL,
  is_active      TINYINT(1)   NOT NULL DEFAULT 1,
  content_type   VARCHAR(20)  NOT NULL DEFAULT 'fact_check',
  context_text   TEXT         DEFAULT NULL,
  explanation    TEXT         DEFAULT NULL,
  tip_text       TEXT         DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_questions_theme
    FOREIGN KEY (theme_id) REFERENCES themes (id)
      ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- Tabela de pontuações
-- Suporta Web e outras plataformas via platform + platform_user_id
-- O telegram_user_id é mantido como NULL para compatibilidade com dados legados
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_scores (
  id               INT          NOT NULL AUTO_INCREMENT,
  telegram_user_id BIGINT       DEFAULT NULL,
  platform         VARCHAR(20)  NOT NULL DEFAULT 'web',
  platform_user_id VARCHAR(255) NOT NULL,
  username         VARCHAR(255) DEFAULT NULL,
  score            INT          NOT NULL DEFAULT 0,
  last_played      DATETIME     DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_platform_user (platform, platform_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
