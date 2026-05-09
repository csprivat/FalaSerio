# Contribuindo com o Fala Sério

Obrigado pelo interesse em contribuir com o **Fala Sério**, uma aplicação educacional de quiz para combate à desinformação.

O projeto prioriza simplicidade, estabilidade e evolução incremental. Antes de propor mudanças grandes, abra uma issue ou descreva claramente o problema que pretende resolver.

---

## Escopo do projeto

A versão atual é uma aplicação web Flask com MariaDB e Docker Compose.

O bot Telegram foi descontinuado. Novas contribuições devem considerar o fluxo web como caminho principal.

---

## Tipos de contribuição bem-vindos

São bem-vindas contribuições como:

- correções de bugs;
- melhorias de acessibilidade;
- melhorias pontuais de interface;
- revisão de textos educacionais;
- novas perguntas para o quiz;
- melhoria de explicações e contextos;
- documentação técnica;
- ajustes simples de segurança;
- testes manuais documentados.

Mudanças estruturais devem ser discutidas antes, especialmente quando envolverem banco de dados, pontuação, ranking, autenticação, fluxo do quiz ou dependências novas.

---

## Diretrizes de desenvolvimento

Ao contribuir, siga estas regras:

- faça alterações pequenas e rastreáveis;
- diagnostique o problema antes de corrigir;
- preserve o que já funciona;
- evite grandes refatorações;
- não altere schema ou migrations sem necessidade explícita;
- não mude ranking, pontuação ou fluxo público do quiz sem justificativa;
- não adicione bibliotecas novas sem explicar o motivo;
- siga a PEP8 em arquivos Python;
- mantenha templates Jinja simples e legíveis;
- mantenha CSS e JavaScript compatíveis com a estrutura atual.

---

## Fluxo recomendado de contribuição

1. Crie uma branch a partir da versão atual.
2. Faça uma alteração pequena e focada.
3. Teste localmente.
4. Registre evidências da validação.
5. Abra um Pull Request explicando o que foi alterado e por quê.

Exemplo:

```bash
git checkout -b ajuste-admin-filtros
```

---

## Ambiente local com Docker

Copie o arquivo de ambiente:

```bash
cp env.example .env
```

Edite as variáveis obrigatórias no `.env`:

```env
DB_HOST=db
DB_PORT=3306
DB_NAME=fngame
DB_USER=fngame
DB_PASSWORD=troque_esta_senha
MARIADB_ROOT_PASSWORD=troque_esta_senha_root
FLASK_SECRET_KEY=troque_este_segredo
SESSION_COOKIE_SECURE=false
ADMIN_USERNAME=admin
ADMIN_PASSWORD=troque_esta_senha_admin
```

Suba a aplicação:

```bash
docker compose up -d --build
```

Acesse:

```text
http://localhost:5000
```

Área administrativa:

```text
http://localhost:5000/admin/login
```

---

## Banco de dados

Para instalações novas, o MariaDB executa automaticamente:

```text
docker/schema.sql
docker/seed.sql
```

Esses arquivos são montados no container como scripts de inicialização.

Atenção: o MariaDB só executa scripts em `/docker-entrypoint-initdb.d/` quando o diretório de dados está vazio. Se o volume `fngame_db_data` já existir, alterações em `docker/schema.sql` ou `docker/seed.sql` não serão aplicadas automaticamente.

Para bancos existentes, use migrations e scripts incrementais:

```text
migrations/001_add_platform.sql
migrations/002_add_scenario_fields.sql
migrations/003_add_is_active_to_questions.sql
docker/scenario_updates.sql
docker/explanations.sql
docker/context_updates.sql
```

Antes de aplicar qualquer migration em ambiente real, faça backup do banco.

---

## Regras para perguntas do quiz

A tabela `questions` trabalha com duas opções de resposta:

- `option_1`
- `option_2`

A resposta correta deve ser exatamente igual a uma das opções.

Campos importantes:

- `question_text`: texto principal da pergunta;
- `option_1`: primeira opção;
- `option_2`: segunda opção;
- `correct_answer`: resposta correta;
- `content_type`: `fact_check` ou `scenario`;
- `context_text`: contexto exibido antes da resposta;
- `explanation`: explicação exibida após a resposta;
- `tip_text`: dica auxiliar, quando aplicável;
- `is_active`: define se a pergunta entra no sorteio público.

Regra validada para contexto:

- se `context_text` estiver preenchido, o contexto deve aparecer;
- se `context_text` estiver vazio ou nulo, o bloco de contexto não deve aparecer;
- essa regra não deve depender de `content_type`.

---

## Segurança e administração

A área administrativa usa login simples baseado em variáveis de ambiente:

```env
ADMIN_USERNAME=
ADMIN_PASSWORD=
```

Não inclua senhas reais em commits.

Também não envie arquivos `.env`, dumps de banco com dados sensíveis ou credenciais de ambiente.

---

## Checklist antes de enviar Pull Request

Antes de abrir um PR, verifique:

- a aplicação sobe com `docker compose up -d --build`;
- a tela inicial carrega;
- a seleção de tema funciona;
- o quiz inicia;
- uma resposta exibe feedback e explicação;
- o botão de próxima pergunta funciona;
- o resultado final é exibido;
- o ranking não foi quebrado;
- o login admin funciona;
- a listagem de perguntas carrega;
- filtros administrativos continuam funcionando;
- nenhuma credencial real foi commitada.

---

## Padrão esperado para Pull Requests

Inclua no PR:

- resumo da alteração;
- arquivos alterados;
- motivo da alteração;
- como foi testado;
- evidências textuais ou capturas quando útil;
- riscos ou limitações conhecidas.

---

## Comunicação

Abra uma issue para dúvidas, bugs ou propostas. Ao relatar erro, inclua:

- mensagem de erro completa;
- rota ou comando executado;
- ambiente usado;
- trecho relevante do log;
- comportamento esperado;
- comportamento observado.
