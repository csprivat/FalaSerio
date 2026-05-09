# Funcionalidades — Fala Sério

Este documento lista as funcionalidades atuais do projeto **Fala Sério** e descreve seu comportamento esperado.

---

## 1. Página inicial

Rota:

```text
GET /
```

Função:

- apresentar o projeto;
- direcionar o usuário para os temas;
- reforçar a proposta educacional anti fake news.

---

## 2. Seleção de temas

Rota:

```text
GET /temas
```

Função:

- listar temas disponíveis no banco;
- permitir que o usuário escolha um tema para iniciar o quiz.

Temas previstos:

- Educação;
- Política;
- Saúde;
- Tecnologia;
- Meio Ambiente.

---

## 3. Quiz público

Rotas:

```text
GET  /quiz
POST /quiz/iniciar
GET  /quiz/pergunta
POST /quiz/responder
POST /quiz/reiniciar
GET  /quiz/pontuacao
```

Funcionalidades:

- iniciar quiz por tema;
- registrar apelido do usuário na sessão;
- sortear perguntas ativas do tema selecionado;
- limitar o quiz a até 10 perguntas por sessão;
- exibir pergunta atual;
- exibir duas opções de resposta;
- enviar resposta;
- calcular acerto ou erro no backend;
- exibir explicação após resposta;
- avançar manualmente para a próxima pergunta;
- reiniciar quiz do mesmo tema;
- consultar pontuação atual.

---

## 4. Contexto antes da resposta

Campo usado:

```text
questions.context_text
```

Comportamento:

- se `context_text` estiver preenchido, o texto aparece antes das opções;
- se `context_text` estiver vazio ou nulo, o bloco não aparece;
- a exibição não depende de `content_type`.

Objetivo pedagógico:

- apresentar uma situação, notícia resumida ou dado contextual;
- ajudar o estudante a responder com base em leitura crítica;
- evitar que a explicação seja revelada antes da resposta.

---

## 5. Explicação após a resposta

Campo usado:

```text
questions.explanation
```

Comportamento:

- a explicação aparece somente depois que o usuário responde;
- o feedback informa se a resposta foi correta ou incorreta;
- o usuário precisa avançar manualmente para continuar.

Objetivo pedagógico:

- reforçar o aprendizado;
- explicar por que a afirmação é verdadeira ou falsa;
- transformar o erro em oportunidade de aprendizagem.

---

## 6. Resultado final

Rota:

```text
GET /resultado
```

Funcionalidades:

- exibir pontuação final;
- apresentar mensagem de feedback de acordo com a faixa de pontuação;
- indicar links ou orientações educacionais.

---

## 7. Ranking

Rota:

```text
GET /ranking
```

Funcionalidades:

- exibir os melhores resultados;
- ordenar participantes por pontuação;
- usar dados da tabela `user_scores`.

Regra atual:

- pontuação só é salva ao final do quiz;
- há validação simples contra execução rápida demais;
- a aplicação evita salvar a mesma sessão mais de uma vez.

---

## 8. Login administrativo

Rotas:

```text
GET  /admin/login
POST /admin/login
GET  /admin/logout
```

Funcionalidades:

- autenticar administrador usando `ADMIN_USERNAME` e `ADMIN_PASSWORD` definidos no `.env`;
- registrar autenticação na sessão Flask;
- permitir logout.

Limitação atual:

- não há cadastro de múltiplos administradores no banco;
- não há recuperação de senha;
- o modelo foi mantido simples por decisão de escopo.

---

## 9. Painel administrativo

Rota:

```text
GET /admin
```

Funcionalidades:

- servir como entrada da área administrativa;
- direcionar para gerenciamento de perguntas.

---

## 10. Listagem administrativa de perguntas

Rota:

```text
GET /admin/questions
```

Funcionalidades:

- listar perguntas cadastradas;
- exibir ID, pergunta, tipo, tema, categoria, fonte, presença de contexto, presença de explicação e status;
- acessar o detalhe de cada pergunta;
- acessar criação de nova pergunta.

Filtros atuais:

- tema (`theme_id`);
- tipo de conteúdo (`content_type`);
- status (`is_active`).

---

## 11. Detalhe administrativo de pergunta

Rota:

```text
GET /admin/questions/<question_id>
```

Funcionalidades:

- exibir todos os campos principais da pergunta;
- mostrar status ativa/inativa;
- oferecer link para edição;
- oferecer ação de ativar/desativar;
- retornar página de não encontrado quando o ID não existir.

---

## 12. Criação de perguntas

Rotas:

```text
GET  /admin/questions/new
POST /admin/questions/new
```

Campos aceitos:

```text
question_text
option_1
option_2
correct_answer
content_type
context_text
explanation
tip_text
category
source
theme_id
```

Validações:

- pergunta obrigatória;
- opção 1 obrigatória;
- opção 2 obrigatória;
- resposta correta obrigatória;
- resposta correta deve ser igual à opção 1 ou à opção 2;
- tipo de conteúdo obrigatório;
- tipo de conteúdo deve ser `fact_check` ou `scenario`;
- `theme_id`, quando preenchido, deve ser número inteiro.

---

## 13. Edição de perguntas

Rotas:

```text
GET  /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/edit
```

Funcionalidades:

- editar pergunta existente;
- reaproveitar as mesmas validações da criação;
- redirecionar para o detalhe após salvar;
- exibir mensagem de erro em POST inválido.

---

## 14. Desativação e reativação de perguntas

Rota:

```text
POST /admin/questions/<question_id>/toggle-active
```

Funcionalidades:

- alternar `is_active` entre `1` e `0`;
- manter registro no banco;
- remover pergunta inativa do sorteio público;
- preservar pergunta inativa na listagem administrativa.

Objetivo:

- evitar exclusão física;
- permitir curadoria segura do banco de perguntas.

---

## 15. Scripts de conteúdo

Arquivos relevantes:

```text
docker/seed.sql
docker/scenario_updates.sql
docker/explanations.sql
docker/context_updates.sql
```

Função:

- popular banco novo;
- aplicar ajustes editoriais incrementais;
- inserir ou revisar contextos e explicações.

---

## 16. Funcionalidades fora do escopo atual

Não fazem parte da versão atual:

- bot Telegram ativo;
- autenticação pública de usuários;
- cadastro de alunos;
- painel multiusuário para professores;
- importação automática contínua de perguntas em produção;
- editor avançado de temas;
- exclusão física de perguntas pela interface;
- analytics avançado;
- API pública versionada.
