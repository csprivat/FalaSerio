-- Migration 003
-- Descrição: Adiciona controle de ativação para perguntas sem exclusão física

ALTER TABLE questions
  ADD COLUMN is_active TINYINT(1) NOT NULL DEFAULT 1;

UPDATE questions
SET is_active = 1
WHERE is_active IS NULL;
