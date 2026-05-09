# Funcionalidades — Fala Sério

Este documento resume as funcionalidades implementadas no projeto **Fala Sério** e separa claramente a área pública da área administrativa.

---

## 1. Funcionalidades públicas

### 1.1 Página inicial

Rota:

```text
GET /
```

Função:

- apresentar o projeto;
- reforçar a proposta educacional;
- direcionar o usuário para a escolha de temas.

### 1.2 Seleção de temas

Rota:

```text
GET /temas
```

Função:

- listar temas disponíveis no banco;
- iniciar o fluxo do quiz a partir do tema escolhido.

Temas atualmente previstos:

- Educação;
- Política;
- Saúde;
- Tecnologia;
- Meio Ambiente.

### 1.3 Quiz público

Rotas:

```text
GET  /quiz
POST /quiz/iniciar
GET  /quiz/pergunta
POST /quiz/responder
POST /quiz/reiniciar
GET  /quiz/pontuacao
GET  /resultado
GET  /ranking
```

Funcionalidades:

- iniciar quiz por tema;
- registrar apelido do participante na sessão;
- sortear apenas perguntas ativas do tema selecionado;
- limitar a sessão a até 10 perguntas;
- exibir uma pergunta por vez;
- exibir duas opções de resposta;
- validar a resposta no backend;
- exibir feedback e explicação após a resposta;
- avançar manualmente para a próxima pergunta;
- reiniciar o quiz do mesmo tema;
- exibir resultado final;
- salvar pontuação elegível no ranking.

### 1.4 Contexto antes da resposta

Campo usado:

```text
questions.context_text
```

Comportamento:

- se `context_text` estiver preenchido, o bloco aparece antes das opções;
- se `context_text` estiver vazio ou nulo, o bloco não aparece;
- a exibição não depende de `content_type`.

### 1.5 Explicação após a resposta

Campo usado:

```text
questions.explanation
```

Comportamento:

- a explicação aparece somente depois da resposta;
- o usuário recebe feedback de acerto ou erro;
- o fluxo não avança automaticamente.

### 1.6 Ranking

Rota:

```text
GET /ranking
```

Funções:

- exibir os melhores resultados;
- ordenar participantes por pontuação;
- usar dados persistidos em `user_scores`.

Regras atuais:

- a pontuação é salva apenas ao final do quiz;
- a aplicação evita salvar a mesma sessão mais de uma vez;
- existe validação simples contra duração improvável de sessão.

---

## 2. Funcionalidades administrativas

### 2.1 Acesso administrativo

Rotas:

```text
GET  /admin/login
POST /admin/login
GET  /admin/logout
```

Funcionalidades:

- autenticar administrador por mecanismo simples de sessão;
- usar credenciais administrativas definidas em variável de ambiente;
- proteger as rotas administrativas por autenticação;
- permitir logout administrativo.

Limites de escopo:

- não há múltiplos administradores persistidos no banco;
- não há recuperação de senha;
- não há autenticação externa ou papéis avançados.

### 2.2 Painel administrativo

Rota:

```text
GET /admin
```

Funções:

- servir como página inicial do admin;
- oferecer link para gestão de perguntas;
- restringir acesso a usuários autenticados.

### 2.3 Listagem de perguntas

Rota:

```text
GET /admin/questions
```

Funções:

- exibir perguntas cadastradas;
- mostrar status ativa/inativa;
- permitir acesso ao detalhe de cada pergunta;
- expor ações administrativas relacionadas à gestão e aos arquivos CSV.

Filtros disponíveis:

- `theme_id` por tema;
- `content_type` por tipo de conteúdo;
- `is_active` por status.

Status disponíveis:

- ativa;
- inativa.

Blocos de ação documentados na interface:

- `Gestão`: nova pergunta e voltar ao painel;
- `Arquivos CSV`: importar CSV, baixar modelo CSV e exportar CSV.

Comportamento de layout:

- no desktop, a tabela usa colunas fixas para evitar rolagem horizontal desnecessária;
- no mobile, a listagem é renderizada em cards verticais para evitar quebra visual.

### 2.4 Detalhe de pergunta

Rota:

```text
GET /admin/questions/<question_id>
```

Funções:

- exibir os dados completos da pergunta;
- mostrar status atual;
- oferecer edição;
- oferecer ativação ou reativação;
- exibir a ação de exclusão definitiva apenas quando a pergunta estiver inativa.

Campos exibidos:

- pergunta;
- opção 1;
- opção 2;
- resposta correta;
- tipo de conteúdo;
- contexto;
- explicação;
- dica;
- categoria;
- fonte;
- tema;
- status.

### 2.5 Criação de perguntas

Rotas:

```text
GET  /admin/questions/new
POST /admin/questions/new
```

Campos principais:

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

- `question_text` obrigatório;
- `option_1` obrigatório;
- `option_2` obrigatório;
- `correct_answer` obrigatório;
- `correct_answer` deve ser exatamente igual a `option_1` ou `option_2`;
- `content_type` obrigatório;
- `content_type` deve ser `fact_check` ou `scenario`;
- `theme_id`, quando informado, deve ser inteiro válido.

### 2.6 Edição de perguntas

Rotas:

```text
GET  /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/edit
```

Funções:

- editar perguntas existentes;
- reaproveitar as mesmas validações da criação;
- salvar os campos administrativos sem alterar schema;
- redirecionar para o detalhe após salvar com sucesso.

Fora de escopo:

- não altera ranking;
- não altera pontuação;
- não altera estrutura do banco.

### 2.7 Ativação e desativação

Rota:

```text
POST /admin/questions/<question_id>/toggle-active
```

Funções:

- ativar ou desativar perguntas sem apagar o registro;
- manter perguntas inativas visíveis no painel;
- retirar perguntas inativas do sorteio público.

Decisão editorial atual:

- desativar ou reativar é a ação principal de curadoria;
- exclusão física é exceção e depende de fluxo separado.

### 2.8 Exclusão definitiva controlada

Rotas:

```text
GET  /admin/questions/<question_id>/delete
POST /admin/questions/<question_id>/delete
```

Regras:

- apenas perguntas inativas podem ser excluídas;
- perguntas ativas são bloqueadas no backend;
- o botão `Excluir definitivamente` só aparece no detalhe de pergunta inativa;
- existe tela dedicada de confirmação;
- a confirmação exige digitar exatamente `EXCLUIR`;
- não existe exclusão em massa.

### 2.9 Exportação CSV

Rota:

```text
GET /admin/questions/export
```

Características:

- rota protegida;
- exporta perguntas ativas e inativas;
- usa o módulo nativo `csv`;
- usa separador `;`;
- usa UTF-8 com BOM;
- gera arquivo `perguntas_fala_serio.csv`.

Campos exportados:

```text
id
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
theme_title
is_active
```

### 2.10 Download de modelo CSV

Rota:

```text
GET /admin/questions/import-template
```

Características:

- rota protegida;
- gera modelo para importação;
- usa separador `;`;
- usa UTF-8 com BOM;
- inclui uma linha de exemplo;
- gera arquivo `modelo_importacao_perguntas_fala_serio.csv`.

### 2.11 Importação CSV

Rota:

```text
GET  /admin/questions/import
POST /admin/questions/import
```

Funções:

- em `GET`, exibir tela de upload com instruções;
- em `POST`, validar o arquivo inteiro antes de qualquer gravação;
- criar novas perguntas em lote quando todas as linhas estiverem válidas.

Regras de escopo:

- a importação não atualiza perguntas existentes;
- a importação não exclui perguntas;
- a importação não altera schema;
- se houver qualquer erro, nada é importado.

Validações principais:

- extensão `.csv`;
- leitura em UTF-8;
- cabeçalhos obrigatórios do modelo;
- `question_text`;
- `option_1`;
- `option_2`;
- `correct_answer`;
- `content_type`;
- `theme_id`;
- `is_active`;
- duplicidade no banco;
- duplicidade dentro do próprio CSV.

Regra de duplicidade:

```text
question_text + option_1 + option_2 + correct_answer + theme_id
```

Normalizações aplicadas:

- `category` vazio vira `geral`;
- `is_active` vazio vira `1`;
- `context_text`, `explanation`, `tip_text` e `source` vazios viram `null`.

Valores aceitos:

- `content_type`: `fact_check` ou `scenario`;
- `is_active`: `1`, `0`, `true`, `false`, `sim`, `não`, `nao`, `ativo`, `inativo`.

Regras adicionais:

- `correct_answer` precisa ser igual a `option_1` ou `option_2`;
- `theme_id` precisa existir;
- linhas totalmente vazias são ignoradas;
- se o arquivo não tiver nenhuma linha útil, a importação é recusada.

Estado validado nesta fase:

- a importação em lote já foi validada com 3 perguntas;
- a reimportação do mesmo CSV é bloqueada com mensagens de duplicidade por linha.

---

## 3. Itens fora do escopo atual

Não fazem parte da versão atual:

- bot Telegram ativo;
- autenticação pública de usuários;
- cadastro de alunos;
- painel multiusuário para professores;
- importação que atualiza registros existentes;
- exclusão em massa de perguntas;
- editor avançado de temas;
- API pública versionada;
- analytics avançado.

Observação histórica:

- o projeto já teve contexto ligado ao antigo FNGame;
- o produto atual deve ser tratado como **Fala Sério**;
- o bot Telegram está descontinuado.
