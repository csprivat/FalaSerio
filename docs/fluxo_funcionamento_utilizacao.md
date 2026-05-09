# Lógica, Fluxo de Funcionamento e Utilização — Fala Sério

Este documento descreve o fluxo prático de uso do **Fala Sério** para público final e para administração editorial.

---

## 1. Fluxo do usuário final

### 1.1 Acesso inicial

Rota:

```text
GET /
```

O usuário acessa a página inicial e encontra a apresentação do projeto e os caminhos para iniciar o quiz.

### 1.2 Escolha do tema

Rota:

```text
GET /temas
```

A aplicação consulta os temas cadastrados e permite selecionar o assunto do quiz.

### 1.3 Início do quiz

Rota:

```text
POST /quiz/iniciar
```

Fluxo resumido:

1. o backend valida o payload recebido;
2. valida a presença de `theme_id`;
3. busca apenas perguntas ativas daquele tema;
4. embaralha as perguntas;
5. limita a sessão a até 10 perguntas;
6. registra dados da sessão do quiz;
7. mantém a resposta correta fora da sessão pública.

### 1.4 Exibição da pergunta

Rota:

```text
GET /quiz/pergunta
```

O backend retorna a pergunta atual e os dados necessários para o frontend renderizar:

- índice e total;
- texto da pergunta;
- opções;
- tipo de conteúdo;
- contexto;
- dica;
- pontuação atual.

Regra importante:

```text
context_text preenchido  -> exibe contexto
context_text vazio/nulo  -> oculta contexto
```

### 1.5 Envio da resposta

Rota:

```text
POST /quiz/responder
```

Fluxo resumido:

1. o backend valida o estado do quiz;
2. lê a pergunta atual da sessão;
3. busca a resposta correta no banco;
4. compara a resposta enviada;
5. atualiza pontuação e progresso;
6. retorna feedback, explicação e estado de término.

### 1.6 Resultado e ranking

Rotas:

```text
GET /resultado
GET /ranking
```

Ao fim do quiz, a aplicação exibe o resultado final e, quando elegível, grava a pontuação para exibição no ranking público.

---

## 2. Fluxo administrativo

### 2.1 Login administrativo

Rotas:

```text
GET  /admin/login
POST /admin/login
```

Fluxo:

1. o administrador acessa `/admin/login`;
2. informa usuário e senha;
3. a aplicação valida as credenciais administrativas configuradas no ambiente;
4. em caso de sucesso, inicia a sessão administrativa;
5. a navegação segue para `/admin`.

### 2.2 Painel administrativo

Rota:

```text
GET /admin
```

Função:

- servir como entrada do admin;
- oferecer acesso à gestão de perguntas;
- oferecer logout administrativo.

### 2.3 Listagem de perguntas

Rota:

```text
GET /admin/questions
```

Fluxo básico:

1. acessar a listagem;
2. aplicar filtros por tema, tipo e status;
3. revisar a base cadastrada;
4. navegar para detalhe, criação ou ferramentas CSV.

Parâmetros de filtro:

```text
theme_id
content_type
is_active
```

Comportamento visual:

- desktop: tabela ajustada para evitar rolagem horizontal;
- mobile: cards verticais para preservar leitura e ações.

Blocos de ação disponíveis:

- `Gestão`: nova pergunta e voltar ao painel;
- `Arquivos CSV`: importar CSV, baixar modelo CSV e exportar CSV.

### 2.4 Detalhe de pergunta

Rota:

```text
GET /admin/questions/<question_id>
```

A tela exibe os dados completos da pergunta e centraliza as ações editoriais:

- editar;
- desativar ou reativar;
- excluir definitivamente, somente quando a pergunta estiver inativa.

### 2.5 Criação de pergunta

Rotas:

```text
GET  /admin/questions/new
POST /admin/questions/new
```

Fluxo básico:

1. abrir o formulário;
2. preencher os campos;
3. enviar;
4. validar dados;
5. criar a pergunta;
6. redirecionar para o detalhe da nova pergunta.

Validação central:

```text
correct_answer deve ser igual a option_1 ou option_2
content_type deve ser fact_check ou scenario
```

### 2.6 Edição de pergunta

Rotas:

```text
GET  /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/edit
```

Fluxo básico:

1. abrir o formulário preenchido;
2. editar os campos necessários;
3. enviar;
4. validar dados;
5. salvar;
6. retornar ao detalhe.

### 2.7 Ativar ou desativar pergunta

Rota:

```text
POST /admin/questions/<question_id>/toggle-active
```

Lógica:

- perguntas ativas podem ser desativadas;
- perguntas inativas podem ser reativadas;
- perguntas inativas continuam visíveis no painel;
- perguntas inativas não entram no quiz público.

Esse é o mecanismo editorial principal de controle do acervo.

### 2.8 Exportar CSV

Rota:

```text
GET /admin/questions/export
```

Fluxo:

1. acessar a listagem de perguntas;
2. acionar `Exportar CSV`;
3. baixar arquivo com perguntas ativas e inativas.

Características:

- exportação protegida;
- separador `;`;
- UTF-8 com BOM;
- uso do módulo nativo `csv`.

### 2.9 Baixar modelo CSV

Rota:

```text
GET /admin/questions/import-template
```

Fluxo:

1. acessar a listagem ou a tela de importação;
2. baixar o modelo oficial;
3. preencher o arquivo mantendo os cabeçalhos.

Características:

- separador `;`;
- UTF-8 com BOM;
- uma linha de exemplo no arquivo.

### 2.10 Importar CSV

Rotas:

```text
GET  /admin/questions/import
POST /admin/questions/import
```

Fluxo recomendado:

1. acessar `/admin/questions/import`;
2. baixar o modelo CSV;
3. preencher uma pergunta por linha;
4. enviar o arquivo;
5. aguardar a validação integral;
6. concluir a importação apenas se todas as linhas estiverem válidas.

Regras de processamento:

- o arquivo inteiro é validado antes da gravação;
- se qualquer linha tiver erro, nada é importado;
- a importação cria apenas novas perguntas;
- a importação não atualiza registros existentes;
- a importação não exclui perguntas;
- linhas em branco são ignoradas.

Validações aplicadas:

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

Regras específicas:

- `correct_answer` deve ser igual a `option_1` ou `option_2`;
- `content_type` aceita apenas `fact_check` e `scenario`;
- `theme_id` deve existir;
- `category` vazia vira `geral`;
- `is_active` vazio vira `1`.

Duplicidade considerada:

```text
question_text + option_1 + option_2 + correct_answer + theme_id
```

Estado já validado:

- a importação já foi validada com 3 perguntas;
- a reimportação do mesmo CSV é bloqueada com mensagens por linha.

### 2.11 Exclusão definitiva controlada

Rotas:

```text
GET  /admin/questions/<question_id>/delete
POST /admin/questions/<question_id>/delete
```

Fluxo:

1. abrir o detalhe de uma pergunta inativa;
2. acionar `Excluir definitivamente`;
3. revisar o resumo da pergunta;
4. digitar exatamente `EXCLUIR`;
5. confirmar a exclusão.

Regras:

- perguntas ativas não podem ser excluídas;
- o backend também bloqueia a exclusão de pergunta ativa;
- não existe exclusão em massa;
- a exclusão definitiva é uma exceção, não o fluxo padrão de curadoria.

### 2.12 Logout administrativo

Rota:

```text
GET /admin/logout
```

Fluxo:

1. encerrar a sessão administrativa;
2. redirecionar de volta para `/admin/login`.

---

## 3. Limites e decisões de escopo

Pontos importantes do estado atual:

- o admin faz parte da própria aplicação Flask;
- a autenticação administrativa é simples;
- não existe autenticação avançada;
- o quiz público usa apenas perguntas ativas;
- a importação CSV não atualiza registros;
- a importação CSV não faz delete;
- não existe exclusão em massa;
- o formato CSV oficial usa `;` e UTF-8 com BOM.

---

## 4. Observações de contexto

- o nome principal do produto atual é **Fala Sério**;
- a referência a **FNGame** deve ser apenas histórica;
- o bot Telegram foi descontinuado e não integra a operação atual do projeto.
