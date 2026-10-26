// Dados simulados baseados na estrutura de banco relacional do PatNews Systems
const respostasAPI = {
    status: {
        status: "200 OK",
        provedor: "Aiven Cloud Platform",
        sgbd: "MySQL 8.0",
        ssl: true,
        banco: "assetcontrol_db",
        tempoRespostaMs: 24,
        mensagem: "✓ Conexão ativa e estável com integridade de dados garantida."
    },
    ativos: [
        {
            num_tombamento: "PAT-00101",
            nome_ativo: "Notebook Dell Latitude 5420",
            categoria: "Equipamentos de TI",
            responsavel: "Carlos Eduardo",
            departamento: "Tecnologia da Informação",
            status: "Em Uso",
            valor_aquisicao: 5500.00
        },
        {
            num_tombamento: "PAT-00102",
            nome_ativo: "Servidor Dell PowerEdge R740",
            categoria: "Equipamentos de TI",
            responsavel: "Carlos Eduardo",
            departamento: "Tecnologia da Informação",
            status: "Em Uso",
            valor_aquisicao: 25000.00
        },
        {
            num_tombamento: "PAT-00301",
            nome_ativo: "Furgão Renault Master",
            categoria: "Veículos",
            responsavel: "Fernanda Lima",
            departamento: "Logística",
            status: "Em Manutenção",
            valor_aquisicao: 120000.00
        }
    ],
    manutencoes: [
        {
            id_manutencao: 1,
            tombamento: "PAT-00101",
            ativo: "Notebook Dell Latitude 5420",
            tipo: "Corretiva",
            custo: 450.00,
            data: "2023-11-10",
            descricao: "Troca de tela danificada"
        },
        {
            id_manutencao: 3,
            tombamento: "PAT-00301",
            ativo: "Furgão Renault Master",
            tipo: "Corretiva",
            custo: 3500.00,
            data: "2024-01-15",
            descricao: "Manutenção no sistema de freios"
        }
    ],
    depreciacao: [
        {
            categoria: "Equipamentos de TI",
            taxa_anual: "20.00%",
            total_ativos: 3,
            valor_original: 48500.00,
            depreciacao_acumulada_est: 9700.00
        },
        {
            categoria: "Veículos",
            taxa_anual: "20.00%",
            total_ativos: 1,
            valor_original: 120000.00,
            depreciacao_acumulada_est: 24000.00
        }
    ]
};

function testarAPI(rota) {
    const label = document.getElementById('endpointLabel');
    const viewer = document.getElementById('jsonViewer');

    label.innerText = `Requisitando /api/v1/${rota}...`;
    viewer.style.color = '#94a3b8';
    viewer.innerText = '// Aguardando resposta do servidor...';

    setTimeout(() => {
        label.innerText = `HTTP 200 OK — GET /api/v1/${rota}`;
        viewer.style.color = '#38bdf8';
        viewer.innerText = JSON.stringify(respostasAPI[rota], null, 2);
    }, 350);
}