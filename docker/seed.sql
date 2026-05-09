-- FNGame – Perguntas de teste para ambiente local / Docker
-- 10 perguntas por tema (50 total) — cobre MAX_QUESTIONS_PER_SESSION = 10
-- Aplicado automaticamente após schema.sql na primeira inicialização do container MariaDB
-- NÃO usar em produção

USE fngame;

INSERT IGNORE INTO questions (question_text, option_1, option_2, correct_answer, category, source, theme_id) VALUES

-- ----------------------------------------------------------------
-- SAÚDE (theme_id = 3)
-- ----------------------------------------------------------------
('A vacina contra COVID-19 foi desenvolvida em tempo recorde graças a pesquisas anteriores sobre outros coronavírus. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Saúde', 'https://www.fiocruz.br', 3),

('Tomar vitamina C em altas doses previne completamente a gripe e resfriados. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Saúde', 'https://www.who.int', 3),

('O Brasil possui um dos maiores programas públicos de vacinação do mundo, o PNI. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Saúde', 'https://www.gov.br/saude', 3),

('Antibióticos são eficazes no tratamento de infecções causadas por vírus, como gripe e resfriado. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Saúde', 'https://www.who.int', 3),

('O uso excessivo de antibióticos pode gerar bactérias resistentes, tornando infecções mais difíceis de tratar. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Saúde', 'https://www.fiocruz.br', 3),

('Beber água com limão em jejum cura o câncer, segundo estudos científicos comprovados. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Saúde', 'https://www.inca.gov.br', 3),

('A dengue é transmitida pelo mosquito Aedes aegypti, que se reproduz em água parada. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Saúde', 'https://www.gov.br/saude', 3),

('A automedicação sem orientação médica é uma prática segura se o remédio for vendido sem receita. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Saúde', 'https://www.anvisa.gov.br', 3),

('O tabagismo está associado ao desenvolvimento de câncer de pulmão e doenças cardiovasculares. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Saúde', 'https://www.inca.gov.br', 3),

('Pessoas com diabetes tipo 2 não precisam mudar hábitos alimentares se tomarem medicamentos regularmente. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Saúde', 'https://www.diabetes.org.br', 3),

-- ----------------------------------------------------------------
-- POLÍTICA (theme_id = 2)
-- ----------------------------------------------------------------
('Fake news podem influenciar o resultado de eleições. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Política', 'https://www.tse.jus.br', 2),

('O voto no Brasil é obrigatório para todos os cidadãos independentemente da idade. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Política', 'https://www.tse.jus.br', 2),

('No Brasil, cidadãos com mais de 70 anos têm o voto facultativo, não obrigatório. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Política', 'https://www.tse.jus.br', 2),

('O Tribunal Superior Eleitoral (TSE) é o órgão responsável por organizar as eleições no Brasil. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Política', 'https://www.tse.jus.br', 2),

('No Brasil, partidos políticos são financiados exclusivamente por doações de empresas privadas. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Política', 'https://www.tse.jus.br', 2),

('A urna eletrônica brasileira já foi hackeada durante uma eleição oficial, segundo auditoria do TSE. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Política', 'https://www.tse.jus.br', 2),

('O Congresso Nacional brasileiro é composto pela Câmara dos Deputados e pelo Senado Federal. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Política', 'https://www.camara.leg.br', 2),

('O mandato de um senador brasileiro tem duração de quatro anos. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Política', 'https://www.senado.leg.br', 2),

('Compartilhar notícias falsas sobre candidatos nas eleições pode ser considerado crime eleitoral no Brasil. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Política', 'https://www.tse.jus.br', 2),

('O presidente do Brasil pode ser reeleito por um número ilimitado de mandatos consecutivos. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Política', 'https://www.planalto.gov.br', 2),

-- ----------------------------------------------------------------
-- TECNOLOGIA (theme_id = 4)
-- ----------------------------------------------------------------
('Antivírus instalado no celular garante proteção total contra golpes de engenharia social. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Tecnologia', 'https://www.cert.br', 4),

('A autenticação em dois fatores aumenta significativamente a segurança de contas online. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Tecnologia', 'https://www.cert.br', 4),

('Usar a mesma senha em vários sites é uma prática segura se a senha for longa. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Tecnologia', 'https://www.cert.br', 4),

('O phishing é um tipo de golpe digital que tenta enganar o usuário para obter dados pessoais. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Tecnologia', 'https://www.cert.br', 4),

('Redes Wi-Fi públicas e abertas são seguras para acessar internet banking sem precauções extras. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Tecnologia', 'https://www.cert.br', 4),

('Inteligência Artificial pode ser usada para criar vídeos falsos chamados deepfakes. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Tecnologia', 'https://www.safernet.org.br', 4),

('Clicar em links desconhecidos recebidos por WhatsApp não representa nenhum risco de segurança. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Tecnologia', 'https://www.cert.br', 4),

('Manter o sistema operacional do celular atualizado ajuda a corrigir falhas de segurança. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Tecnologia', 'https://www.cert.br', 4),

('Aplicativos baixados fora das lojas oficiais (APK) podem conter malware. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Tecnologia', 'https://www.cert.br', 4),

('O "cadeado" no navegador (HTTPS) garante que o site é confiável e legítimo. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Tecnologia', 'https://www.cert.br', 4),

-- ----------------------------------------------------------------
-- EDUCAÇÃO (theme_id = 1)
-- ----------------------------------------------------------------
('O Brasil tem mais de 200 universidades federais distribuídas pelo país. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Educação', 'https://www.mec.gov.br', 1),

('O analfabetismo funcional afeta pessoas que sabem ler, mas têm dificuldade em interpretar textos. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.ibge.gov.br', 1),

('O ENEM é utilizado como critério de acesso a universidades públicas pelo SISU. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.mec.gov.br', 1),

('No Brasil, a educação básica obrigatória vai dos 4 aos 17 anos de idade. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.mec.gov.br', 1),

('O Brasil erradicou completamente o analfabetismo adulto até o ano de 2020. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Educação', 'https://www.ibge.gov.br', 1),

('O ProUni oferece bolsas de estudo integrais e parciais em faculdades privadas para estudantes de baixa renda. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.mec.gov.br', 1),

('Verificar a fonte antes de compartilhar uma notícia é uma habilidade importante da educação midiática. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.unesco.org', 1),

('Escolas públicas no Brasil são proibidas por lei de ensinar educação digital e uso crítico da internet. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Educação', 'https://www.mec.gov.br', 1),

('O letramento midiático ajuda as pessoas a identificar notícias falsas e manipulação de informação. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.unesco.org', 1),

('Crianças que leem com frequência tendem a ter melhor desempenho escolar em todas as disciplinas. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Educação', 'https://www.ibge.gov.br', 1),

-- ----------------------------------------------------------------
-- MEIO AMBIENTE (theme_id = 5)
-- ----------------------------------------------------------------
('O desmatamento da Amazônia não tem relação com as mudanças climáticas globais. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Meio Ambiente', 'https://www.inpe.br', 5),

('O Brasil é um dos países com maior biodiversidade do planeta. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.ibama.gov.br', 5),

('O aquecimento global é causado exclusivamente por fenômenos naturais, sem influência humana. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Meio Ambiente', 'https://www.ipcc.ch', 5),

('O derretimento das calotas polares contribui para o aumento do nível dos oceanos. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.ipcc.ch', 5),

('Reciclar alumínio consome menos energia do que produzir alumínio a partir do minério bruto. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.mma.gov.br', 5),

('Plásticos descartados em rios e mares não afetam a vida marinha de forma significativa. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Meio Ambiente', 'https://www.ibama.gov.br', 5),

('O Cerrado brasileiro é considerado a savana com maior biodiversidade do mundo. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.mma.gov.br', 5),

('Queimadas na Amazônia ocorrem exclusivamente de forma natural, sem interferência humana. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Falso', 'Meio Ambiente', 'https://www.inpe.br', 5),

('A Mata Atlântica já perdeu mais de 85% de sua cobertura original. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.sosma.org.br', 5),

('Energia solar e eólica são consideradas fontes renováveis de energia. Isso é verdadeiro ou falso?',
 'Verdadeiro', 'Falso', 'Verdadeiro', 'Meio Ambiente', 'https://www.mma.gov.br', 5);

-- ----------------------------------------------------------------
-- SCENARIO CONTENT
-- Converter apenas um subconjunto pequeno de perguntas existentes
-- para validar a experiência com context_text sem alterar a lógica.
-- ----------------------------------------------------------------
UPDATE questions
SET content_type = 'scenario',
    context_text = 'Num grupo da família, alguém diz que antibiótico sempre resolve gripe em poucos dias.'
WHERE question_text = 'Antibióticos são eficazes no tratamento de infecções causadas por vírus, como gripe e resfriado. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante a eleição, um conhecido recebe uma corrente com acusações sem fonte sobre um candidato.'
WHERE question_text = 'Compartilhar notícias falsas sobre candidatos nas eleições pode ser considerado crime eleitoral no Brasil. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Você está fora de casa e pensa em acessar o app do banco usando uma rede Wi-Fi aberta do local.'
WHERE question_text = 'Redes Wi-Fi públicas e abertas são seguras para acessar internet banking sem precauções extras. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Na escola, uma turma debate se checar a origem de uma notícia faz diferença antes de repassar.'
WHERE question_text = 'Verificar a fonte antes de compartilhar uma notícia é uma habilidade importante da educação midiática. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

-- ----------------------------------------------------------------
-- EXPLANATIONS
-- Preencher apenas perguntas sem explanation para permitir teste funcional
-- sem sobrescrever conteúdo já existente.
-- ----------------------------------------------------------------
UPDATE questions
SET explanation = 'É verdadeiro. A vacina foi desenvolvida mais rápido porque já existiam pesquisas sobre outros coronavírus e tecnologias prontas para uso.'
WHERE question_text = 'A vacina contra COVID-19 foi desenvolvida em tempo recorde graças a pesquisas anteriores sobre outros coronavírus. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Vitamina C pode fazer parte de uma rotina saudável, mas não previne completamente gripe ou resfriado.'
WHERE question_text = 'Tomar vitamina C em altas doses previne completamente a gripe e resfriados. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O PNI é um grande programa público de vacinação e alcança milhões de pessoas em todo o país.'
WHERE question_text = 'O Brasil possui um dos maiores programas públicos de vacinação do mundo, o PNI. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Antibióticos agem contra bactérias, não contra vírus como os da gripe e do resfriado.'
WHERE question_text = 'Antibióticos são eficazes no tratamento de infecções causadas por vírus, como gripe e resfriado. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O uso excessivo de antibióticos favorece bactérias resistentes e pode dificultar o tratamento de infecções.'
WHERE question_text = 'O uso excessivo de antibióticos pode gerar bactérias resistentes, tornando infecções mais difíceis de tratar. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Não há comprovação científica de que água com limão cure câncer. O tratamento deve seguir orientação médica.'
WHERE question_text = 'Beber água com limão em jejum cura o câncer, segundo estudos científicos comprovados. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. A dengue é transmitida pelo Aedes aegypti, que se reproduz em água parada.'
WHERE question_text = 'A dengue é transmitida pelo mosquito Aedes aegypti, que se reproduz em água parada. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Mesmo remédios sem receita podem causar efeitos adversos, interações e uso inadequado.'
WHERE question_text = 'A automedicação sem orientação médica é uma prática segura se o remédio for vendido sem receita. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O tabagismo aumenta o risco de câncer de pulmão e de doenças cardiovasculares, como infarto e AVC.'
WHERE question_text = 'O tabagismo está associado ao desenvolvimento de câncer de pulmão e doenças cardiovasculares. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. No diabetes tipo 2, a medicação ajuda, mas a alimentação e outros hábitos saudáveis continuam sendo parte do tratamento.'
WHERE question_text = 'Pessoas com diabetes tipo 2 não precisam mudar hábitos alimentares se tomarem medicamentos regularmente. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Fake news podem confundir eleitores e influenciar decisões de voto, afetando o processo eleitoral.'
WHERE question_text = 'Fake news podem influenciar o resultado de eleições. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. No Brasil, há exceções ao voto obrigatório, como para jovens de 16 e 17 anos e pessoas com mais de 70 anos.'
WHERE question_text = 'O voto no Brasil é obrigatório para todos os cidadãos independentemente da idade. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Para pessoas com mais de 70 anos, o voto é facultativo e não obrigatório.'
WHERE question_text = 'No Brasil, cidadãos com mais de 70 anos têm o voto facultativo, não obrigatório. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O TSE é o órgão responsável por organizar e supervisionar as eleições no Brasil.'
WHERE question_text = 'O Tribunal Superior Eleitoral (TSE) é o órgão responsável por organizar as eleições no Brasil. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Os partidos não são financiados só por empresas privadas. Também há fundos públicos e outras formas previstas em lei.'
WHERE question_text = 'No Brasil, partidos políticos são financiados exclusivamente por doações de empresas privadas. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Não há registro de invasão comprovada em eleição oficial reconhecido pelo TSE. Os testes públicos existem para encontrar falhas e melhorar o sistema.'
WHERE question_text = 'A urna eletrônica brasileira já foi hackeada durante uma eleição oficial, segundo auditoria do TSE. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O Congresso Nacional é formado pela Câmara dos Deputados e pelo Senado Federal.'
WHERE question_text = 'O Congresso Nacional brasileiro é composto pela Câmara dos Deputados e pelo Senado Federal. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O mandato de senador dura oito anos, e não quatro.'
WHERE question_text = 'O mandato de um senador brasileiro tem duração de quatro anos. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Compartilhar notícias falsas sobre candidatos pode gerar punição e, em alguns casos, configurar crime eleitoral.'
WHERE question_text = 'Compartilhar notícias falsas sobre candidatos nas eleições pode ser considerado crime eleitoral no Brasil. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. No Brasil, o presidente pode ter apenas uma reeleição consecutiva.'
WHERE question_text = 'O presidente do Brasil pode ser reeleito por um número ilimitado de mandatos consecutivos. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Antivírus ajuda, mas não impede golpes de engenharia social, que exploram o comportamento da pessoa.'
WHERE question_text = 'Antivírus instalado no celular garante proteção total contra golpes de engenharia social. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. A autenticação em dois fatores adiciona uma camada extra de proteção à conta.'
WHERE question_text = 'A autenticação em dois fatores aumenta significativamente a segurança de contas online. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Usar a mesma senha em vários sites aumenta o risco de várias contas serem comprometidas de uma vez.'
WHERE question_text = 'Usar a mesma senha em vários sites é uma prática segura se a senha for longa. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Phishing é um golpe que usa mensagens, sites ou links falsos para roubar dados pessoais.'
WHERE question_text = 'O phishing é um tipo de golpe digital que tenta enganar o usuário para obter dados pessoais. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Redes Wi-Fi públicas podem expor dados sensíveis, especialmente em acessos financeiros.'
WHERE question_text = 'Redes Wi-Fi públicas e abertas são seguras para acessar internet banking sem precauções extras. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Inteligência artificial pode ser usada para criar deepfakes, que imitam pessoas em vídeos ou áudios falsos.'
WHERE question_text = 'Inteligência Artificial pode ser usada para criar vídeos falsos chamados deepfakes. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Links desconhecidos podem levar a golpes, roubo de dados ou instalação de programas maliciosos.'
WHERE question_text = 'Clicar em links desconhecidos recebidos por WhatsApp não representa nenhum risco de segurança. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Atualizações corrigem falhas conhecidas e ajudam a reduzir riscos de segurança.'
WHERE question_text = 'Manter o sistema operacional do celular atualizado ajuda a corrigir falhas de segurança. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Aplicativos fora das lojas oficiais podem vir adulterados e conter malware.'
WHERE question_text = 'Aplicativos baixados fora das lojas oficiais (APK) podem conter malware. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O cadeado indica conexão protegida, mas não garante sozinho que o site seja confiável.'
WHERE question_text = 'O "cadeado" no navegador (HTTPS) garante que o site é confiável e legítimo. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O Brasil não tem mais de 200 universidades federais. A afirmação exagera esse número.'
WHERE question_text = 'O Brasil tem mais de 200 universidades federais distribuídas pelo país. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Analfabetismo funcional afeta quem consegue ler, mas tem dificuldade para compreender e usar a informação.'
WHERE question_text = 'O analfabetismo funcional afeta pessoas que sabem ler, mas têm dificuldade em interpretar textos. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O ENEM é usado pelo SISU como critério de acesso a universidades públicas.'
WHERE question_text = 'O ENEM é utilizado como critério de acesso a universidades públicas pelo SISU. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. No Brasil, a educação básica obrigatória vai dos 4 aos 17 anos.'
WHERE question_text = 'No Brasil, a educação básica obrigatória vai dos 4 aos 17 anos de idade. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O analfabetismo adulto não foi totalmente erradicado no Brasil até 2020.'
WHERE question_text = 'O Brasil erradicou completamente o analfabetismo adulto até o ano de 2020. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O ProUni oferece bolsas integrais e parciais em faculdades privadas para estudantes de baixa renda.'
WHERE question_text = 'O ProUni oferece bolsas de estudo integrais e parciais em faculdades privadas para estudantes de baixa renda. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Verificar a fonte antes de compartilhar ajuda a reduzir a circulação de desinformação.'
WHERE question_text = 'Verificar a fonte antes de compartilhar uma notícia é uma habilidade importante da educação midiática. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Não existe proibição geral para ensinar educação digital e uso crítico da internet nas escolas públicas.'
WHERE question_text = 'Escolas públicas no Brasil são proibidas por lei de ensinar educação digital e uso crítico da internet. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O letramento midiático ajuda a identificar manipulação e notícias falsas.'
WHERE question_text = 'O letramento midiático ajuda as pessoas a identificar notícias falsas e manipulação de informação. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Ler com frequência costuma melhorar vocabulário, compreensão e desempenho escolar.'
WHERE question_text = 'Crianças que leem com frequência tendem a ter melhor desempenho escolar em todas as disciplinas. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O desmatamento da Amazônia afeta o clima porque altera emissões de carbono, chuvas e equilíbrio ambiental.'
WHERE question_text = 'O desmatamento da Amazônia não tem relação com as mudanças climáticas globais. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O Brasil abriga grande variedade de espécies e ecossistemas e está entre os países mais biodiversos do mundo.'
WHERE question_text = 'O Brasil é um dos países com maior biodiversidade do planeta. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. O aquecimento global não é causado só por fenômenos naturais. A ação humana tem papel central nesse processo.'
WHERE question_text = 'O aquecimento global é causado exclusivamente por fenômenos naturais, sem influência humana. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O derretimento das calotas polares contribui para a elevação do nível dos oceanos.'
WHERE question_text = 'O derretimento das calotas polares contribui para o aumento do nível dos oceanos. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Reciclar alumínio consome menos energia do que produzir o metal a partir do minério.'
WHERE question_text = 'Reciclar alumínio consome menos energia do que produzir alumínio a partir do minério bruto. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Plásticos em rios e mares prejudicam animais, contaminam ecossistemas e afetam a vida marinha.'
WHERE question_text = 'Plásticos descartados em rios e mares não afetam a vida marinha de forma significativa. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. O Cerrado é reconhecido por sua alta biodiversidade e grande importância ecológica.'
WHERE question_text = 'O Cerrado brasileiro é considerado a savana com maior biodiversidade do mundo. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É falso. Muitas queimadas na Amazônia têm relação com ação humana, direta ou indireta.'
WHERE question_text = 'Queimadas na Amazônia ocorrem exclusivamente de forma natural, sem interferência humana. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. A Mata Atlântica já perdeu mais de 85% de sua cobertura original ao longo do tempo.'
WHERE question_text = 'A Mata Atlântica já perdeu mais de 85% de sua cobertura original. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');

UPDATE questions
SET explanation = 'É verdadeiro. Energia solar e eólica vêm de fontes que se renovam naturalmente.'
WHERE question_text = 'Energia solar e eólica são consideradas fontes renováveis de energia. Isso é verdadeiro ou falso?'
  AND (explanation IS NULL OR TRIM(explanation) = '');
