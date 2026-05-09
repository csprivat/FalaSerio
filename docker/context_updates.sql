UPDATE questions
SET context_text = 'Em uma conversa sobre a pandemia, alguém comenta que uma vacina foi criada muito rápido para ser confiável. Analise se esse desenvolvimento pode ter aproveitado estudos anteriores.'
WHERE id = 1
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante o inverno, circula a dica de tomar grandes quantidades de vitamina C para evitar ficar doente. Pense se essa promessa é totalmente garantida.'
WHERE id = 2
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma aula de saúde pública, a turma discute como funcionam as campanhas de vacinação no Brasil. Avalie se o país realmente tem um programa público muito amplo nessa área.'
WHERE id = 3
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Numa farmácia, alguém diz que antibiótico demais pode fazer alguns tratamentos perderem efeito com o tempo. Reflita se esse risco existe na prática.'
WHERE id = 5
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Nas redes sociais, aparece uma receita caseira prometendo curar doenças graves com água e limão. Analise se essa afirmação combina com o que a ciência costuma exigir de um tratamento.'
WHERE id = 6
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em casa, a família organiza uma limpeza para evitar criadouros de mosquito no quintal. Pense se a água parada tem relação com a transmissão da dengue.'
WHERE id = 7
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Uma pessoa sente um mal-estar leve e decide tomar remédio por conta própria só porque ele é vendido sem receita. Avalie se isso torna o uso automaticamente seguro.'
WHERE id = 8
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante uma campanha de prevenção, estudantes conversam sobre hábitos que aumentam o risco de doenças graves. Analise se fumar está ligado apenas ao pulmão ou a outros problemas também.'
WHERE id = 9
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma consulta, o paciente acredita que só o remédio já resolve o diabetes tipo 2. Reflita se a rotina alimentar e outros hábitos continuam importantes no tratamento.'
WHERE id = 10
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante uma eleição, mensagens enganosas começam a circular rapidamente em grupos e redes sociais. Pense se esse tipo de conteúdo pode afetar a escolha dos eleitores.'
WHERE id = 11
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Numa conversa sobre eleições, alguém afirma que todas as pessoas são obrigadas a votar da mesma forma. Reflita se a lei brasileira realmente não prevê exceções.'
WHERE id = 12
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante um debate sobre cidadania, surge a dúvida se pessoas idosas precisam votar obrigatoriamente. Analise o que a legislação brasileira determina nesse caso.'
WHERE id = 13
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em época de eleição, muita gente ouve falar de órgãos que organizam a votação no país. Pense qual instituição cuida desse processo no Brasil.'
WHERE id = 14
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Numa discussão sobre política, alguém diz que os partidos recebem dinheiro de uma única fonte. Avalie se o financiamento partidário funciona de forma tão simples assim.'
WHERE id = 15
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante as eleições, circulam boatos sobre a segurança da urna eletrônica. Reflita se uma invasão em votação oficial já foi comprovada por auditoria reconhecida.'
WHERE id = 16
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma aula de política, a turma conversa sobre como o Poder Legislativo federal é organizado. Analise quais casas formam o Congresso Nacional.'
WHERE id = 17
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante um estudo sobre cargos políticos, um aluno tenta lembrar quanto tempo um senador permanece no cargo. Pense se esse período é igual ao de outros mandatos conhecidos.'
WHERE id = 18
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em um debate sobre presidência, alguém comenta que um governante pode se reeleger sem limite no Brasil. Reflita se existem regras que restringem mandatos consecutivos.'
WHERE id = 20
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Uma pessoa instala antivírus no celular e passa a acreditar que nenhum golpe online pode mais atingi-la. Analise se a proteção digital depende só do aplicativo.'
WHERE id = 21
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Ao criar uma conta, um site oferece uma etapa extra além da senha para confirmar o acesso. Pense se esse cuidado pode realmente aumentar a proteção da conta.'
WHERE id = 22
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Uma pessoa decide usar a mesma senha em vários serviços porque ela parece difícil de adivinhar. Reflita se repetir a senha pode trazer riscos para outras contas.'
WHERE id = 23
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Chega uma mensagem pedindo clique urgente em um link para confirmar dados pessoais. Analise se esse tipo de abordagem pode fazer parte de um golpe digital.'
WHERE id = 24
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Nas redes sociais, surge um vídeo muito realista mostrando alguém dizendo algo polêmico. Pense se tecnologias atuais conseguem fabricar esse tipo de conteúdo falso.'
WHERE id = 26
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em um grupo de mensagens, chega um link desconhecido com promessa de prêmio ou notícia urgente. Reflita se abrir esse tipo de link pode trazer algum problema.'
WHERE id = 27
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'O celular avisa que há uma atualização do sistema disponível, mas a pessoa pensa em adiar por muito tempo. Analise se essas atualizações ajudam só no visual ou também na segurança.'
WHERE id = 28
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Alguém encontra um aplicativo interessante fora da loja oficial e pensa em instalá-lo mesmo assim. Pense se esse caminho pode trazer riscos ao aparelho.'
WHERE id = 29
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante a navegação, aparece um cadeado ao lado do endereço do site, e a pessoa conclui que tudo ali é confiável. Reflita se esse símbolo sozinho basta para garantir legitimidade.'
WHERE id = 30
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma conversa sobre ensino superior, alguém cita um número muito alto de universidades federais no Brasil. Analise se essa quantidade parece compatível com a realidade do país.'
WHERE id = 31
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Um estudante consegue ler palavras e frases, mas encontra dificuldade para entender o sentido de textos do dia a dia. Pense se esse tipo de situação tem relação com alfabetização funcional.'
WHERE id = 32
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Na hora de buscar vaga em universidade pública, muitos estudantes usam a nota de uma prova nacional. Reflita se esse exame tem ligação com o ingresso pelo SISU.'
WHERE id = 33
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma conversa sobre escola, alguém comenta que a obrigação de estudar começa só quando a criança já é maior. Analise se a faixa etária exigida pela lei brasileira é essa mesmo.'
WHERE id = 34
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante um debate sobre educação, uma pessoa afirma que o analfabetismo adulto já foi totalmente superado no Brasil. Reflita se esse problema realmente desapareceu.'
WHERE id = 35
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Um estudante procura formas de entrar no ensino superior privado com ajuda financeira. Pense se existe um programa voltado a bolsas para alunos de baixa renda.'
WHERE id = 36
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Numa discussão sobre escola e internet, alguém diz que as redes públicas não podem trabalhar educação digital em sala de aula. Analise se existe uma proibição geral desse tipo.'
WHERE id = 38
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Ao receber uma notícia duvidosa, uma turma conversa sobre habilidades para analisar fontes e mensagens. Reflita se esse aprendizado ajuda a perceber manipulação de informação.'
WHERE id = 39
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Uma professora incentiva a leitura frequente e diz que esse hábito pode ajudar no desempenho escolar. Pense se ler costuma trazer benefícios só em uma matéria ou em várias situações.'
WHERE id = 40
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em um debate sobre meio ambiente, alguém afirma que destruir florestas na Amazônia não interfere no clima do planeta. Analise se essa relação pode mesmo ser ignorada.'
WHERE id = 41
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante uma aula de ciências, a turma compara a variedade de plantas, animais e ambientes de diferentes países. Reflita se o Brasil está entre os lugares com maior diversidade biológica.'
WHERE id = 42
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Numa conversa sobre clima, alguém diz que o aquecimento global acontece sem participação humana. Pense se as ações das pessoas entram ou não nessa discussão.'
WHERE id = 43
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Ao ver notícias sobre gelo derretendo nas regiões polares, um estudante se pergunta se isso afeta o mar em outras partes do mundo. Analise se existe relação entre esses fenômenos.'
WHERE id = 44
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma conversa sobre reciclagem, alguém comenta que reaproveitar latas pode economizar muitos recursos. Reflita se isso também faz diferença no gasto de energia.'
WHERE id = 45
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante um debate sobre lixo, a turma discute o destino de plásticos jogados em rios e oceanos. Pense se esse descarte causa ou não prejuízos importantes para os seres vivos.'
WHERE id = 46
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma aula sobre biomas, surge a pergunta sobre a importância ecológica do Cerrado. Analise se ele está entre os ambientes com maior variedade de vida do planeta.'
WHERE id = 47
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Ao ver fumaça em áreas de floresta, alguém afirma que queimadas na Amazônia acontecem apenas por causas naturais. Reflita se a ação humana pode ou não participar desse cenário.'
WHERE id = 48
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Durante uma conversa sobre conservação, uma pessoa diz que a Mata Atlântica já perdeu grande parte da vegetação original. Pense se essa perda é realmente muito alta.'
WHERE id = 49
  AND (context_text IS NULL OR TRIM(context_text) = '');

UPDATE questions
SET context_text = 'Em uma discussão sobre energia, aparecem exemplos de fontes ligadas ao sol e ao vento. Analise se essas formas de produção entram no grupo das energias renováveis.'
WHERE id = 50
  AND (context_text IS NULL OR TRIM(context_text) = '');
