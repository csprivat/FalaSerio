# Fala Sério — Quiz Educacional Anti Fake News

**Fala Sério** é uma aplicação web educacional voltada ao combate à desinformação. O projeto oferece quizzes temáticos com perguntas de verdadeiro ou falso, contexto antes da resposta, explicação pedagógica após a resposta e ranking de pontuação.

O projeto nasceu como **FNGame**, mas a versão atual está consolidada como **Fala Sério**. 

---

## Objetivo

Ajudar estudantes, educadores e cidadãos a desenvolverem pensamento crítico diante de boatos, fake news e conteúdos enganosos, usando uma experiência simples, gamificada e acessível.

---

## Estado atual do projeto

A versão atual é uma aplicação web baseada em:

- **Backend:** Python + Flask
- **Frontend:** HTML/Jinja, CSS e JavaScript
- **Banco de dados:** MariaDB
- **Execução:** Docker Compose
- **Servidor web da aplicação:** Gunicorn
- **Persistência:** volume Docker nomeado para o MariaDB
- **Administração:** área `/admin` protegida por login simples via variáveis de ambiente



---

## Funcionalidades principais

### Área pública

- Página inicial do projeto.
- Seleção de temas.
- Quiz por tema.
- Perguntas com duas opções de resposta: **Verdadeiro** e **Falso**.
- Exibição de contexto antes da resposta, quando `context_text` estiver preenchido.
- Exibição de explicação após a resposta, quando `explanation` estiver preenchido.
- Avanço manual para a próxima pergunta após o feedback.
- Resultado final do quiz.
- Ranking dos participantes.

### Área administrativa

- Login administrativo em `/admin/login`.
- Painel interno em `/admin`.
- Listagem de perguntas em `/admin/questions`.
- Filtros por tema, tipo de conteúdo e status ativo/inativo.
- Visualização detalhada de perguntas.
- Criação de novas perguntas.
- Edição de perguntas existentes.
- Desativação e reativação de perguntas sem apagar fisicamente os registros.

---

## Tipos de pergunta

A tabela `questions` suporta dois tipos de conteúdo:

- `fact_check`: pergunta baseada em checagem factual.
- `scenario`: pergunta baseada em situação ou cenário.

A exibição do bloco de contexto **não depende** do tipo de conteúdo. A regra correta é:

- se `context_text` existe e não está vazio, o contexto é exibido;
- se `context_text` está vazio ou nulo, o bloco de contexto é ocultado.

---

## Estrutura geral

```text
.
├── db.py                         # Funções de acesso ao MariaDB
├── docker-compose.yml            # Orquestração dos serviços web e db
├── env.example                   # Exemplo de variáveis de ambiente
├── docker/
│   ├── schema.sql                # Estrutura completa para banco novo
│   ├── seed.sql                  # Carga inicial de dados
│   ├── scenario_updates.sql      # Atualizações incrementais de cenários
│   ├── explanations.sql          # Atualizações incrementais de explicações
│   └── context_updates.sql       # Atualizações incrementais de contextos
├── migrations/
│   ├── 001_add_platform.sql
│   ├── 002_add_scenario_fields.sql
│   └── 003_add_is_active_to_questions.sql
├── web/
│   ├── app.py                    # Aplicação Flask
│   ├── Dockerfile.web            # Imagem Docker do serviço web
│   ├── requirements-web.txt      # Dependências do módulo web
│   ├── static/                   # CSS e JavaScript
│   └── templates/                # Templates Jinja
└── docs/
    ├── arquitetura.md
    ├── funcionalidades.md
    └── fluxo_funcionamento_utilizacao.md
```

---

## Configuração rápida com Docker

### 1. Criar o arquivo `.env`

Copie o arquivo de exemplo:

```bash
cp env.example .env
```

Edite o `.env` e defina senhas fortes para:

```env
DB_PASSWORD=
MARIADB_ROOT_PASSWORD=
FLASK_SECRET_KEY=
ADMIN_USERNAME=
ADMIN_PASSWORD=
```

Para ambiente local HTTP, pode ser necessário usar:

```env
SESSION_COOKIE_SECURE=false
```

Para ambiente publicado com HTTPS, use:

```env
SESSION_COOKIE_SECURE=true
```

### 2. Subir os serviços

```bash
docker compose up -d --build
```

### 3. Acessar a aplicação

```text
http://localhost:5000
```

### 4. Acessar a área administrativa

```text
http://localhost:5000/admin/login
```

Use as credenciais definidas no `.env`.

---

## Inicialização do banco de dados

Em uma instalação nova, o MariaDB executa automaticamente os arquivos montados em `/docker-entrypoint-initdb.d/`:

```text
docker/schema.sql  -> 001_schema.sql
docker/seed.sql    -> 002_seed.sql
```

Isso só acontece quando o diretório de dados do MariaDB ainda está vazio.

Se o volume `fngame_db_data` já existir, os scripts de inicialização não serão reaplicados automaticamente. Nesse caso, use as migrations e scripts incrementais manualmente, conforme a necessidade do ambiente.

### Banco novo

Use `docker/schema.sql` e `docker/seed.sql`.

### Banco existente

Use os arquivos de `migrations/` e, quando necessário, os scripts incrementais em `docker/`:

```text
migrations/001_add_platform.sql
migrations/002_add_scenario_fields.sql
migrations/003_add_is_active_to_questions.sql
docker/scenario_updates.sql
docker/explanations.sql
docker/context_updates.sql
```

---

## Desenvolvimento

O projeto deve ser evoluído em fases pequenas, com diagnóstico antes da correção e preservando o que já funciona.

Diretrizes importantes:

- priorizar a solução mais simples primeiro;
- evitar grandes refatorações sem necessidade;
- não alterar schema, ranking, pontuação ou fluxo público sem objetivo explícito;
- não instalar novas bibliotecas sem justificativa e validação;
- manter compatibilidade com Docker Compose;
- validar alterações com evidências textuais diretas.

---

## Documentação técnica

A documentação técnica gerada para esta fase está em:

- [`docs/arquitetura.md`](docs/arquitetura.md)
- [`docs/funcionalidades.md`](docs/funcionalidades.md)
- [`docs/fluxo_funcionamento_utilizacao.md`](docs/fluxo_funcionamento_utilizacao.md)

---

## Licença

Este projeto é distribuído sob a licença **AGPLv3**.

---

## Autoria

Desenvolvido por:

- Cristian Privat

Apoio:

- Ricardo Andrade

Atualizado em 2026-05-06.
