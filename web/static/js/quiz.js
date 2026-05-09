/* FNGame – Quiz AJAX logic (Veritas Flow design) */

var TIPS = [
    'Observe se a notícia cita instituições específicas ou nomes de pesquisadores. Manchetes que prometem resultados "milagrosos" são frequentemente iscas de cliques.',
    'Desconfie de textos com linguagem sensacionalista, letras maiúsculas em excesso ou muitos pontos de exclamação.',
    'Verifique se outras fontes confiáveis também publicaram a mesma informação. Notícias verdadeiras costumam aparecer em múltiplos veículos.',
    'Preste atenção à data da publicação. Notícias antigas podem ser compartilhadas fora de contexto.',
    'Imagens podem ser manipuladas ou retiradas de contexto. Use a busca reversa de imagens para verificar a origem.',
    'Confira se o site possui informações de contato, equipe editorial e política de correções.',
    'Pesquisas científicas legítimas são publicadas em revistas acadêmicas e passam por revisão por pares.',
    'Cuidado com notícias que confirmam exatamente o que você quer acreditar. O viés de confirmação é uma armadilha comum.',
    'Verifique se a URL do site parece legítima. Sites falsos costumam imitar nomes de veículos conhecidos.',
    'Antes de compartilhar, pergunte-se: quem escreveu isso? Qual a fonte? Quando foi publicado?'
];

var pendingFeedbackAction = null;

function getOptionButtonClass(variant, state) {
    var className = 'quiz-option-button';

    if (variant === 'affirmative') {
        className += ' quiz-option-button--affirmative';
    } else {
        className += ' quiz-option-button--negative';
    }

    if (state) {
        className += ' ' + state;
    }

    return className;
}

function getFeedbackCardClass(isCorrect) {
    return isCorrect ?
        'quiz-feedback-card quiz-feedback-card--correct' :
        'quiz-feedback-card quiz-feedback-card--incorrect';
}

function getFeedbackBadgeClass(isCorrect) {
    return isCorrect ?
        'quiz-feedback-badge quiz-feedback-badge--correct' :
        'quiz-feedback-badge quiz-feedback-badge--incorrect';
}

function getFeedbackIconClass(isCorrect) {
    return isCorrect ?
        'material-symbols-outlined quiz-feedback-icon quiz-feedback-icon--correct icon-filled' :
        'material-symbols-outlined quiz-feedback-icon quiz-feedback-icon--incorrect icon-filled';
}

function getFeedbackTextClass(isCorrect) {
    return isCorrect ?
        'quiz-feedback-text quiz-feedback-text--correct' :
        'quiz-feedback-text quiz-feedback-text--incorrect';
}

document.addEventListener('DOMContentLoaded', loadQuestion);

function loadQuestion() {
    fetch('/quiz/pergunta')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.error) { window.location.href = '/temas'; return; }
            if (data.finished) { window.location.href = '/resultado'; return; }
            renderQuestion(data);
        })
        .catch(function() { window.location.href = '/temas'; });
}

function renderQuestion(data) {
    // Progress
    document.getElementById('quiz-progress').textContent =
        'Pergunta ' + data.index + ' de ' + data.total;
    document.getElementById('score-value').textContent = data.score;
    document.getElementById('progress-bar').style.width =
        ((data.index - 1) / data.total * 100) + '%';

    // Question text
    document.getElementById('question-text').textContent = data.question;

    // Reset tonal wash
    document.body.classList.remove('tonal-wash-correct', 'tonal-wash-incorrect');

    // Show quiz area, hide feedback
    document.getElementById('quiz-area').classList.remove('hidden');
    document.getElementById('feedback-area').classList.add('hidden');
    resetNextQuestionButton();

    // Exibir contexto sempre que houver context_text válido, independentemente do content_type
    var contextEl = document.getElementById('scenario-context');
    var contextTextEl = document.getElementById('context-text');
    if (data.context_text && data.context_text.trim()) {
        contextTextEl.textContent = data.context_text;
        contextEl.classList.remove('hidden');
    } else {
        contextTextEl.textContent = '';
        contextEl.classList.add('hidden');
    }

    // Dica: usar tip_text quando existir, fallback para dica padrão
    var tipEl = document.getElementById('tip-text');
    if (tipEl) {
        if (data.tip_text && data.tip_text.trim()) {
            tipEl.textContent = data.tip_text;
        } else {
            tipEl.textContent = TIPS[Math.floor(Math.random() * TIPS.length)];
        }
    }

    // Render option buttons
    var optionsArea = document.getElementById('options-area');
    optionsArea.innerHTML = '';

    data.options.forEach(function(opt, i) {
        var btn = document.createElement('button');
        btn.dataset.value = opt;
        btn.type = 'button';

        if (i === 0) {
            // First option (typically "Verdadeiro") — green style
            btn.className = getOptionButtonClass('affirmative');
            btn.innerHTML =
                '<div class="quiz-option-overlay"></div>' +
                '<span class="material-symbols-outlined quiz-option-icon icon-filled">check_circle</span>' +
                '<span class="quiz-option-label">' + opt + '</span>' +
                '<span class="quiz-option-subtitle">Informação Confiável</span>';
        } else {
            // Second option (typically "Falso") — red style
            btn.className = getOptionButtonClass('negative');
            btn.innerHTML =
                '<div class="quiz-option-overlay"></div>' +
                '<span class="material-symbols-outlined quiz-option-icon icon-filled">cancel</span>' +
                '<span class="quiz-option-label">' + opt + '</span>' +
                '<span class="quiz-option-subtitle">Informação Falsa</span>';
        }

        btn.onclick = function() { submitAnswer(opt); };
        optionsArea.appendChild(btn);
    });
}

function submitAnswer(answer) {
    // Disable all buttons
    var buttons = document.querySelectorAll('#options-area button');
    buttons.forEach(function(btn) {
        btn.disabled = true;
        btn.classList.add('quiz-option-button--disabled');
    });

    var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/quiz/responder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': csrfToken
        },
        body: JSON.stringify({answer: answer})
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
        if (data.error) { alert(data.error); return; }
        showFeedback(data, answer);
    })
    .catch(function() { alert('Erro ao enviar resposta. Tente novamente.'); });
}

function showFeedback(data, selectedAnswer) {
    // Highlight correct/incorrect buttons
    var buttons = document.querySelectorAll('#options-area button');
    buttons.forEach(function(btn) {
        var val = btn.dataset.value;
        if (val === selectedAnswer) {
            btn.className = data.correct ? 
                getOptionButtonClass('affirmative', 'quiz-option-button--correct') :
                getOptionButtonClass('negative', 'quiz-option-button--incorrect');
        } else {
            btn.classList.add('quiz-option-button--muted');
        }
    });

    // Tonal Wash effect on body
    if (data.correct) {
        document.body.classList.add('tonal-wash-correct');
    } else {
        document.body.classList.add('tonal-wash-incorrect');
    }

    // Update score
    document.getElementById('score-value').textContent = data.score;

    // Show feedback card
    var feedbackArea = document.getElementById('feedback-area');
    var feedbackIcon = document.getElementById('feedback-icon');
    var feedbackBadge = document.getElementById('feedback-badge');
    var feedbackText = document.getElementById('feedback-text');
    var feedbackCard = document.getElementById('feedback-card');
    var explanationBox = document.getElementById('explanation-box');
    var explanationText = document.getElementById('explanation-text');
    var feedbackStatus = document.getElementById('feedback-status');
    var nextQuestionBtn = document.getElementById('next-question-btn');
    var nextQuestionLabel = document.getElementById('next-question-label');

    feedbackArea.classList.remove('hidden');
    feedbackStatus.textContent = 'Leia a explicação antes de continuar.';

    // Exibir explicação (se existir)
    if (data.explanation && data.explanation.trim()) {
        explanationText.textContent = data.explanation;
        explanationBox.classList.remove('hidden');
    } else {
        explanationText.textContent = '';
        explanationBox.classList.add('hidden');
    }

    if (data.correct) {
        feedbackCard.className = getFeedbackCardClass(true);
        feedbackBadge.className = getFeedbackBadgeClass(true);
        feedbackIcon.textContent = 'check_circle';
        feedbackIcon.className = getFeedbackIconClass(true);
        feedbackText.textContent = 'Resposta correta.';
        feedbackText.className = getFeedbackTextClass(true);
    } else {
        feedbackCard.className = getFeedbackCardClass(false);
        feedbackBadge.className = getFeedbackBadgeClass(false);
        feedbackIcon.textContent = 'cancel';
        feedbackIcon.className = getFeedbackIconClass(false);
        feedbackText.textContent = 'Resposta incorreta.';
        feedbackText.className = getFeedbackTextClass(false);
    }

    // Update progress bar
    document.getElementById('progress-bar').style.width =
        (data.progress / data.total * 100) + '%';

    pendingFeedbackAction = function() {
        if (data.finished) {
            window.location.href = '/resultado';
        } else {
            loadQuestion();
        }
    };

    nextQuestionLabel.textContent = data.finished ? 'Ver resultado' : 'Próxima pergunta';
    nextQuestionBtn.disabled = false;
    nextQuestionBtn.classList.remove('hidden');
    nextQuestionBtn.onclick = function() {
        if (nextQuestionBtn.disabled) {
            return;
        }

        nextQuestionBtn.disabled = true;
        nextQuestionBtn.classList.add('quiz-next-button--disabled');

        if (pendingFeedbackAction) {
            pendingFeedbackAction();
        }
    };
}

function resetNextQuestionButton() {
    var nextQuestionBtn = document.getElementById('next-question-btn');
    var nextQuestionLabel = document.getElementById('next-question-label');
    var feedbackStatus = document.getElementById('feedback-status');
    if (!nextQuestionBtn || !nextQuestionLabel) {
        return;
    }

    pendingFeedbackAction = null;
    nextQuestionBtn.disabled = true;
    nextQuestionBtn.onclick = null;
    nextQuestionBtn.classList.add('hidden');
    nextQuestionBtn.classList.remove('quiz-next-button--disabled');
    nextQuestionLabel.textContent = 'Próxima pergunta';
    if (feedbackStatus) {
        feedbackStatus.textContent = '';
    }
}

function restartQuiz() {
    var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/quiz/reiniciar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': csrfToken
        }
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
        if (data.error) { alert(data.error); return; }
        document.body.classList.remove('tonal-wash-correct', 'tonal-wash-incorrect');
        loadQuestion();
    })
    .catch(function() { alert('Não foi possível reiniciar o quiz. Tente novamente.'); });
}
