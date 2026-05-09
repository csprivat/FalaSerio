-- Migration 002: Adicionar campos para perguntas do tipo scenario
-- Data: 2026-04-21
-- Descrição: Adiciona colunas content_type, context_text, explanation e tip_text à tabela questions

ALTER TABLE questions
  ADD COLUMN content_type VARCHAR(20) NOT NULL DEFAULT 'fact_check' AFTER theme_id,
  ADD COLUMN context_text TEXT DEFAULT NULL AFTER content_type,
  ADD COLUMN explanation TEXT DEFAULT NULL AFTER context_text,
  ADD COLUMN tip_text TEXT DEFAULT NULL AFTER explanation;
