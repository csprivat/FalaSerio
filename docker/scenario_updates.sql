USE fngame;

-- ----------------------------------------------------------------
-- SCENARIO CONTENT
-- Atualização pontual para banco já existente.
-- Altera somente perguntas previamente aprovadas para cenário.
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

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Alguém da família recomenda vitamina C em dose alta como forma certa de evitar resfriado.'
WHERE question_text = 'Tomar vitamina C em altas doses previne completamente a gripe e resfriados. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em época de eleição, um amigo afirma que votar é obrigatório para todo mundo, sem exceção.'
WHERE question_text = 'O voto no Brasil é obrigatório para todos os cidadãos independentemente da idade. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Você cria contas novas e pensa em repetir a mesma senha longa para não esquecer.'
WHERE question_text = 'Usar a mesma senha em vários sites é uma prática segura se a senha for longa. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante uma limpeza na praia, alguém diz que o plástico jogado no mar quase não afeta os animais.'
WHERE question_text = 'Plásticos descartados em rios e mares não afetam a vida marinha de forma significativa. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Num cursinho, alguém comenta que o ENEM pode ajudar na entrada em universidades públicas.'
WHERE question_text = 'O ENEM é utilizado como critério de acesso a universidades públicas pelo SISU. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma família quer saber se a escola é obrigada a atender crianças e adolescentes nessa faixa etária.'
WHERE question_text = 'No Brasil, a educação básica obrigatória vai dos 4 aos 17 anos de idade. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre eleições, alguém diz que notícias falsas não mudam a decisão de voto de ninguém.'
WHERE question_text = 'Fake news podem influenciar o resultado de eleições. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'No posto de saúde, uma pessoa escuta que antibiótico demais pode fazer o remédio perder efeito com o tempo.'
WHERE question_text = 'O uso excessivo de antibióticos pode gerar bactérias resistentes, tornando infecções mais difíceis de tratar. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao ver água acumulada no quintal, um morador lembra do risco de mosquito e comenta com os vizinhos.'
WHERE question_text = 'A dengue é transmitida pelo mosquito Aedes aegypti, que se reproduz em água parada. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao configurar uma conta, um site sugere ativar uma etapa extra de confirmação no login.'
WHERE question_text = 'A autenticação em dois fatores aumenta significativamente a segurança de contas online. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Um estudante ouve que o país teria mais de 200 universidades federais e fica em dúvida sobre esse número.'
WHERE question_text = 'O Brasil tem mais de 200 universidades federais distribuídas pelo país. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa reunião escolar, surge a discussão sobre pessoas que leem, mas ainda têm dificuldade para entender textos.'
WHERE question_text = 'O analfabetismo funcional afeta pessoas que sabem ler, mas têm dificuldade em interpretar textos. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante uma conversa sobre eleições, alguém lembra que idosos acima de certa idade não são obrigados a votar.'
WHERE question_text = 'No Brasil, cidadãos com mais de 70 anos têm o voto facultativo, não obrigatório. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa aula de cidadania, um aluno pergunta qual órgão organiza e supervisiona as eleições no país.'
WHERE question_text = 'O Tribunal Superior Eleitoral (TSE) é o órgão responsável por organizar as eleições no Brasil. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em casa, alguém compartilha a ideia de começar tratamento só com água e limão depois de ler um boato online.'
WHERE question_text = 'Beber água com limão em jejum cura o câncer, segundo estudos científicos comprovados. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma pessoa pensa em tomar remédio por conta própria porque ele é vendido sem receita na farmácia.'
WHERE question_text = 'A automedicação sem orientação médica é uma prática segura se o remédio for vendido sem receita. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em casa, alguém afirma que o analfabetismo adulto teria acabado completamente no Brasil há alguns anos.'
WHERE question_text = 'O Brasil erradicou completamente o analfabetismo adulto até o ano de 2020. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Um estudante pesquisa bolsas e ouve que o ProUni pode ajudar quem quer entrar numa faculdade privada.'
WHERE question_text = 'O ProUni oferece bolsas de estudo integrais e parciais em faculdades privadas para estudantes de baixa renda. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre financiamento eleitoral, alguém diz que os partidos viveriam só de doações de empresas.'
WHERE question_text = 'No Brasil, partidos políticos são financiados exclusivamente por doações de empresas privadas. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante um debate político, alguém comenta que o presidente poderia se reeleger sem limite de mandatos seguidos.'
WHERE question_text = 'O presidente do Brasil pode ser reeleito por um número ilimitado de mandatos consecutivos. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa campanha antitabagismo, um profissional explica por que fumar aumenta vários riscos à saúde.'
WHERE question_text = 'O tabagismo está associado ao desenvolvimento de câncer de pulmão e doenças cardiovasculares. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao instalar um aplicativo de segurança, uma pessoa acredita que agora está totalmente protegida de qualquer golpe online.'
WHERE question_text = 'Antivírus instalado no celular garante proteção total contra golpes de engenharia social. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa reunião pedagógica, alguém afirma que escolas públicas não poderiam abordar educação digital com os alunos.'
WHERE question_text = 'Escolas públicas no Brasil são proibidas por lei de ensinar educação digital e uso crítico da internet. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em sala de aula, um professor explica por que saber ler criticamente notícias ajuda a evitar manipulação.'
WHERE question_text = 'O letramento midiático ajuda as pessoas a identificar notícias falsas e manipulação de informação. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma família comenta que o hábito de leitura costuma influenciar o rendimento escolar das crianças.'
WHERE question_text = 'Crianças que leem com frequência tendem a ter melhor desempenho escolar em todas as disciplinas. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Num debate sobre política, alguém pergunta quais instituições formam o Congresso Nacional brasileiro.'
WHERE question_text = 'O Congresso Nacional brasileiro é composto pela Câmara dos Deputados e pelo Senado Federal. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma pessoa recebe uma mensagem suspeita pedindo dados e tenta entender que tipo de golpe é esse.'
WHERE question_text = 'O phishing é um tipo de golpe digital que tenta enganar o usuário para obter dados pessoais. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre meio ambiente, alguém lembra que o Brasil reúne muitos ecossistemas e espécies diferentes.'
WHERE question_text = 'O Brasil é um dos países com maior biodiversidade do planeta. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em uma roda de conversa, alguém afirma que a urna já teria sido invadida numa eleição oficial.'
WHERE question_text = 'A urna eletrônica brasileira já foi hackeada durante uma eleição oficial, segundo auditoria do TSE. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Um estudante pergunta quanto tempo dura o mandato de um senador no Brasil.'
WHERE question_text = 'O mandato de um senador brasileiro tem duração de quatro anos. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa campanha de vacinação, alguém comenta que a estrutura pública do país alcança muita gente por meio do PNI.'
WHERE question_text = 'O Brasil possui um dos maiores programas públicos de vacinação do mundo, o PNI. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante uma consulta, uma pessoa acredita que só o remédio basta e que não precisa rever hábitos de alimentação.'
WHERE question_text = 'Pessoas com diabetes tipo 2 não precisam mudar hábitos alimentares se tomarem medicamentos regularmente. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao ver um vídeo muito convincente na internet, alguém pergunta se inteligência artificial consegue produzir esse tipo de falsificação.'
WHERE question_text = 'Inteligência Artificial pode ser usada para criar vídeos falsos chamados deepfakes. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma mensagem chega no WhatsApp com um link estranho, e a pessoa pensa em abrir sem se preocupar.'
WHERE question_text = 'Clicar em links desconhecidos recebidos por WhatsApp não representa nenhum risco de segurança. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao baixar um arquivo APK fora da loja oficial, alguém comenta que isso pode trazer risco para o celular.'
WHERE question_text = 'Aplicativos baixados fora das lojas oficiais (APK) podem conter malware. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre clima, alguém diz que destruir floresta não teria efeito nenhum fora da região.'
WHERE question_text = 'O desmatamento da Amazônia não tem relação com as mudanças climáticas globais. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em uma discussão sobre aquecimento global, uma pessoa afirma que tudo seria apenas obra da natureza, sem influência humana.'
WHERE question_text = 'O aquecimento global é causado exclusivamente por fenômenos naturais, sem influência humana. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante uma coleta seletiva, alguém comenta que reciclar alumínio economiza energia em comparação com produzir o metal do zero.'
WHERE question_text = 'Reciclar alumínio consome menos energia do que produzir alumínio a partir do minério bruto. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre vacinação, alguém lembra que a rapidez da vacina veio de pesquisas acumuladas ao longo de anos.'
WHERE question_text = 'A vacina contra COVID-19 foi desenvolvida em tempo recorde graças a pesquisas anteriores sobre outros coronavírus. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao adiar uma atualização do celular, alguém comenta que isso pode deixar falhas de segurança abertas por mais tempo.'
WHERE question_text = 'Manter o sistema operacional do celular atualizado ajuda a corrigir falhas de segurança. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Uma pessoa vê o cadeado no navegador e conclui que o site inteiro deve ser confiável sem checar mais nada.'
WHERE question_text = 'O "cadeado" no navegador (HTTPS) garante que o site é confiável e legítimo. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Em uma aula sobre clima, surge a dúvida se o gelo polar derretendo interfere no nível do mar.'
WHERE question_text = 'O derretimento das calotas polares contribui para o aumento do nível dos oceanos. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa conversa sobre biomas, alguém comenta a importância ecológica do Cerrado e sua variedade de espécies.'
WHERE question_text = 'O Cerrado brasileiro é considerado a savana com maior biodiversidade do mundo. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Ao ver notícias sobre queimadas, uma pessoa repete que incêndios na Amazônia aconteceriam só por causas naturais.'
WHERE question_text = 'Queimadas na Amazônia ocorrem exclusivamente de forma natural, sem interferência humana. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Falso';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Numa discussão sobre conservação, alguém menciona o quanto da cobertura original da Mata Atlântica já se perdeu.'
WHERE question_text = 'A Mata Atlântica já perdeu mais de 85% de sua cobertura original. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';

UPDATE questions
SET content_type = 'scenario',
    context_text = 'Durante um trabalho escolar, um grupo compara fontes de energia e pergunta quais delas se renovam naturalmente.'
WHERE question_text = 'Energia solar e eólica são consideradas fontes renováveis de energia. Isso é verdadeiro ou falso?'
  AND correct_answer = 'Verdadeiro';
