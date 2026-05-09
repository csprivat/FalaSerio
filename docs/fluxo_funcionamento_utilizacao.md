# Lógica, Fluxo de Funcionamento e Utilização — Fala Sério

Este documento descreve como o **Fala Sério** funciona na prática, tanto para o usuário final quanto para o administrador.

---

## 1. Fluxo do usuário final

### 1.1 Acesso inicial

O usuário acessa a aplicação pelo navegador.

Rota:

```text
GET /
```

A página inicial apresenta o projeto e conduz o usuário para a escolha de tema.

---

### 1.2 Escolha do tema

O usuário acessa a página de temas.

Rota:

```text
GET /temas
```

A aplicação consulta a tabela `themes` e exibe os temas disponíveis.

---

### 1.3 Início do quiz

Ao escolher um tema e informar um apelido, o frontend chama:

```text
POST /quiz/iniciar
```

O backend executa a lógica:

1. valida se recebeu dados;
2. valida se há `theme_id`;
3. busca perguntas ativas daquele tema;
4. embaralha perguntas;
5. limita a sessão a até 10 perguntas;
6. cria identificador persistente de usuário web na sessão, se ainda não existir;
7. salva apelido, tema, progresso, pontuação e horário de início na sessão;
8. armazena as perguntas sem expor a resposta correta na sessão pública.

A resposta correta não fica salva na sessão do quiz. Ela é consultada no banco apenas no momento da resposta.

---

### 1.4 Exibição da pergunta

O frontend solicita a pergunta atual:

```text
GET /quiz/pergunta
```

O backend retorna:

```text
index
total
question
options
content_type
context_text
tip_text
score
```

O frontend renderiza:

- número da pergunta;
- barra de progresso;
- pontuação atual;
- texto da pergunta;
- contexto, se existir;
- dica, se existir;
- botões de resposta.

Regra importante:

```text
context_text preenchido  -> exibe contexto
context_text vazio/nulo  -> oculta contexto
```

Essa regra é independente de `content_type`.

---

### 1.5 Envio da resposta

Quando o usuário clica em uma opção, o frontend envia:

```text
POST /quiz/responder
```

Payload lógico:

```json
{
  "answer": "Verdadeiro"
}
```

O backend executa:

1. verifica se há quiz ativo;
2. verifica se ainda há pergunta pendente;
3. valida se recebeu resposta;
4. identifica a pergunta atual pela sessão;
5. consulta a resposta correta no banco com `get_correct_answer(question_id)`;
6. compara resposta enviada com resposta correta;
7. incrementa pontuação se houver acerto;
8. avança o progresso;
9. verifica se o quiz terminou;
10. se terminou, avalia se a duração foi plausível antes de salvar ranking;
11. retorna resultado da resposta e explicação.

Resposta lógica:

```text
correct
finished
score
progress
total
explanation
```

---

### 1.6 Feedback após resposta

Após receber a resposta do backend, o frontend:

- desabilita os botões de resposta;
- destaca visualmente acerto ou erro;
- atualiza pontuação;
- exibe card de feedback;
- mostra `explanation`, quando preenchido;
- exibe a orientação para ler a explicação antes de continuar;
- libera o botão manual de próxima etapa.

O fluxo não avança automaticamente.

O botão exibido será:

```text
Próxima pergunta
```

ou, se for a última pergunta:

```text
Ver resultado
```

---

### 1.7 Resultado final

Ao final, o usuário é direcionado para:

```text
GET /resultado
```

A página exibe:

- pontuação obtida;
- total de perguntas;
- feedback por faixa de desempenho.

---

### 1.8 Ranking

O ranking é exibido em:

```text
GET /ranking
```

A pontuação é salva apenas se:

- o quiz terminou;
- a pontuação ainda não foi salva naquela sessão;
- o tempo total foi considerado minimamente plausível.

---

## 2. Fluxo administrativo

### 2.1 Login

O administrador acessa:

```text
GET /admin/login
```

Ao enviar o formulário:

```text
POST /admin/login
```

A aplicação compara os dados informados com:

```env
ADMIN_USERNAME
ADMIN_PASSWORD
```

Se forem válidos, grava na sessão:

```text
admin_authenticated = True
```

---

### 2.2 Painel administrativo

Após login, o administrador acessa:

```text
GET /admin
```

Essa página serve como entrada para as funções internas.

---

### 2.3 Listagem de perguntas

Rota:

```text
GET /admin/questions
```

A listagem pode ser filtrada por:

```text
theme_id
content_type
is_active
```

Exemplos:

```text
/admin/questions?theme_id=3
/admin/questions?content_type=scenario
/admin/questions?is_active=0
/admin/questions?theme_id=5&content_type=fact_check&is_active=1
```

Valores inválidos são tratados de forma simples, evitando erro 500.

---

### 2.4 Visualização de pergunta

Rota:

```text
GET /admin/questions/<question_id>
```

A tela exibe os campos da pergunta, incluindo:

- pergunta;
- opções;
- resposta correta;
- tipo de conteúdo;
- contexto;
- explicação;
- dica;
- categoria;
- fonte;
- tema;
- status ativa/inativa.

---

### 2.5 Criação de pergunta

Rota:

```text
GET  /admin/questions/new
POST /admin/questions/new
```

Fluxo:

1. administrador abre o formulário;
2. preenche campos;
3. envia formulário;
4. backend normaliza textos opcionais;
5. backend valida campos obrigatórios;
6. backend insere no banco;
7. aplicação redireciona para o detalhe da nova pergunta.

Validação central:

```text
correct_answer deve ser exatamente igual a option_1 ou option_2
content_type deve ser fact_check ou scenario
```

---

### 2.6 Edição de pergunta

Rota:

```text
GET  /admin/questions/<question_id>/edit
POST /admin/questions/<question_id>/edit
```

Fluxo:

1. administrador abre formulário preenchido;
2. altera campos necessários;
3. envia formulário;
4. backend valida;
5. backend atualiza registro;
6. aplicação redireciona para o detalhe.

---

### 2.7 Ativar ou desativar pergunta

Rota:

```text
POST /admin/questions/<question_id>/toggle-active
```

Lógica:

```text
se is_active = 1 -> muda para 0
se is_active = 0 -> muda para 1
```

Efeito:

- pergunta ativa entra no sorteio público;
- pergunta inativa continua no admin, mas não aparece no quiz.

---

## 3. Fluxo de banco de dados

### 3.1 Ambiente novo

Quando o volume do MariaDB está vazio, o container executa automaticamente:

```text
/docker-entrypoint-initdb.d/001_schema.sql
/docker-entrypoint-initdb.d/002_seed.sql
```

No `docker-compose.yml`, esses arquivos vêm de:

```text
./docker/schema.sql
./docker/seed.sql
```

---

### 3.2 Ambiente já existente

Se o volume `fngame_db_data` já existe, o MariaDB não reaplica `docker/schema.sql` nem `docker/seed.sql` automaticamente.

Nesse caso, para atualizar a estrutura ou conteúdo, deve-se aplicar manualmente os arquivos adequados:

```text
migrations/001_add_platform.sql
migrations/002_add_scenario_fields.sql
migrations/003_add_is_active_to_questions.sql
docker/scenario_updates.sql
docker/explanations.sql
docker/context_updates.sql
```

Sempre fazer backup antes de aplicar migration em banco com dados reais.

---

## 4. Fluxo de implantação local

### 4.1 Preparar variáveis

```bash
cp env.example .env
```

Editar `.env` com senhas fortes.

### 4.2 Subir containers

```bash
docker compose up -d --build
```

### 4.3 Verificar containers

```bash
docker compose ps
```

### 4.4 Ver logs

```bash
docker compose logs -f web
docker compose logs -f db
```

### 4.5 Acessar aplicação

```text
http://localhost:5000
```

---

## 5. Fluxo recomendado de validação manual

Após alterações, validar:

1. página inicial carrega;
2. `/temas` lista temas;
3. quiz inicia com tema escolhido;
4. pergunta aparece;
5. contexto aparece quando preenchido;
6. contexto não aparece quando vazio;
7. resposta envia corretamente;
8. explicação aparece após resposta;
9. botão “Próxima pergunta” funciona;
10. última pergunta leva ao resultado;
11. ranking continua carregando;
12. login admin funciona;
13. listagem admin carrega;
14. filtros admin funcionam;
15. criação de pergunta funciona;
16. edição de pergunta funciona;
17. ativar/desativar pergunta funciona;
18. pergunta inativa não aparece no quiz público.

---

## 6. Pontos de atenção

- Não confundir banco novo com banco existente.
- Não esperar que `docker/schema.sql` rode novamente se o volume MariaDB já foi inicializado.
- Não apagar volume de produção sem backup.
- Não commit-ar `.env` com credenciais reais.
- Não fazer redesign global sem necessidade.
- Não alterar pontuação ou ranking sem fase específica.
- Não alterar schema sem migration.
- Não adicionar biblioteca sem autorização.
