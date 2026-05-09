-- FNGame – Migração: suporte multi-plataforma na tabela user_scores
-- Adiciona colunas 'platform' e 'platform_user_id' para identificar
-- usuários de diferentes plataformas (telegram, web, etc.)
--
-- Compatível com MySQL 8+ / MariaDB 10.5+
-- Executar uma única vez sobre o banco existente.

USE fngame;

-- 1. Adicionar novas colunas
ALTER TABLE user_scores
  ADD COLUMN platform VARCHAR(20) NOT NULL DEFAULT 'telegram',
  ADD COLUMN platform_user_id VARCHAR(255) DEFAULT NULL;

-- 2. Migrar dados existentes: copiar telegram_user_id para platform_user_id
UPDATE user_scores
  SET platform_user_id = CAST(telegram_user_id AS CHAR);

-- 3. Tornar platform_user_id obrigatório e criar constraint única
ALTER TABLE user_scores
  MODIFY platform_user_id VARCHAR(255) NOT NULL,
  DROP INDEX uq_telegram_user_id,
  ADD UNIQUE KEY uq_platform_user (platform, platform_user_id);
