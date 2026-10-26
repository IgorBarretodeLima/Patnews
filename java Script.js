// FUNÇÃO PARA MUDANÇA DE ABAS
function openTab(event, tabId) {
    // Esconde todos os conteúdos de abas
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => content.classList.remove('active'));

    // Desativa todos os botões de abas
    const buttons = document.querySelectorAll('.tab-btn');
    buttons.forEach(btn => btn.classList.remove('active'));

    // Ativa a aba atual e o botão clicado
    document.getElementById(tabId).classList.add('active');
    event.currentTarget.classList.add('active');
}

// FUNÇÃO PARA O ACORDEÃO DAS CONSULTAS SQL
function toggleAccordion(button) {
    const content = button.nextElementSibling;
    const isActive = content.classList.contains('active');

    // Opcional: Fecha outros acordeões abertos
    document.querySelectorAll('.accordion-content').forEach(item => {
        item.classList.remove('active');
    });

    // Alterna o estado do atual
    if (!isActive) {
        content.classList.add('active');
    }
}

// SIMULADOR DE CONEXÃO CLOUD (AIVEN)
function testarConexaoCloud() {
    const output = document.getElementById('cloudOutput');
    const btn = document.getElementById('btnConnect');

    btn.disabled = true;
    output.style.color = '#0284c7';
    output.innerText = '⚡ [1/3] Iniciando handshake SSL com servidor Aiven Cloud...';

    setTimeout(() => {
        output.innerText = '🔑 [2/3] Autenticando usuário no banco assetcontrol_db...';
    }, 1000);

    setTimeout(() => {
        output.style.color = '#16a34a';
        output.innerText = '✓ [3/3] CONEXÃO ESTABELECIDA COM SUCESSO!\n- Host: mysql-assetcontrol-aiven.aivencloud.com\n- Porta: 24711 (SSL Ativo)\n- Latência: 42ms';
        btn.disabled = false;
    }, 2200);
}