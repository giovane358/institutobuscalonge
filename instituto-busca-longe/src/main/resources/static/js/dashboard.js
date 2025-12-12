const token = localStorage.getItem('token');
document.getElementById("meu-elemento").innerHTML = token;

/* ----------------------- MENU LATERAL ----------------------- */

function abrirPagina(id, item = null) {
    document.querySelectorAll(".page").forEach(p => p.classList.remove("active"));
    document.getElementById(id).classList.add("active");

    if (item) {
        document.querySelectorAll(".menu-item").forEach(m => m.classList.remove("active"));
        item.classList.add("active");
    }
}

/* ------------------- FUNÇÕES GERAIS PARA TODAS AS TELAS ------------------- */

function inicializarTabela(pageId) {

    const page = document.getElementById(pageId);
    if (!page) return;

    const tabela = page.querySelector("table");
    const tbody = tabela.querySelector("tbody");
    const addBtn = page.querySelector(".add-btn");
    const searchInput = page.querySelector(".search-box input");

    const filtroBtns = page.querySelectorAll(".buttons .btn");

    /* ---------- EDITAR / DELETAR ---------- */
    function ativarEventosLinha(linha) {
        const editBtn = linha.querySelector(".actions button:nth-child(1)");
        const deleteBtn = linha.querySelector(".actions button:nth-child(2)");

        deleteBtn.addEventListener("click", () => linha.remove());

        editBtn.addEventListener("click", () => {
            const colunas = linha.querySelectorAll("td");

            colunas.forEach((coluna, index) => {
                // Última coluna é ações → não edita
                if (index === colunas.length - 1) return;

                let novoValor = prompt(`Editar:`, coluna.innerText);
                if (novoValor !== null) coluna.innerText = novoValor;
            });
        });
    }

    tbody.querySelectorAll("tr").forEach(linha => ativarEventosLinha(linha));

    /* ---------- ADICIONAR ---------- */
    if (addBtn) {
        addBtn.addEventListener("click", () => {

            const colunas = tabela.querySelectorAll("thead th");
            let valores = [];

            for (let i = 0; i < colunas.length - 1; i++) {
                let valor = prompt(`Digite ${colunas[i].innerText}:`);
                if (!valor) return alert("Preencha tudo!");
                valores.push(valor);
            }

            const novaLinha = document.createElement("tr");

            valores.forEach(v => novaLinha.innerHTML += `<td>${v}</td>`);

            novaLinha.innerHTML += `
                <td class="actions">
                    <button>✏️</button>
                    <button>🗑️</button>
                </td>
            `;

            tbody.appendChild(novaLinha);
            ativarEventosLinha(novaLinha);
        });
    }

    /* ---------- FILTROS (Ativo, Inativo, etc.) ---------- */
    filtroBtns.forEach(btn => {
        btn.addEventListener("click", () => {

            filtroBtns.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            const filtro = btn.innerText.toLowerCase();
            const linhas = tbody.querySelectorAll("tr");

            linhas.forEach(linha => {
                const status = linha.querySelector("td:nth-last-child(2)")?.innerText.toLowerCase();

                if (filtro === "todos" || filtro === "todas") {
                    linha.style.display = "";
                } else {
                    linha.style.display = status.includes(filtro) ? "" : "none";
                }
            });
        });
    });

    /* ---------- PESQUISA ---------- */
    if (searchInput) {
        searchInput.addEventListener("keyup", () => {
            const termo = searchInput.value.toLowerCase();

            tbody.querySelectorAll("tr").forEach(linha => {
                linha.style.display = linha.innerText.toLowerCase().includes(termo) ? "" : "none";
            });
        });
    }
}

/* --------------- INICIAR TODAS AS TELAS AUTOMATICAMENTE --------------- */

document.addEventListener("DOMContentLoaded", () => {

    const telas = [
        "estudantes",
        "instrutores",
        "salas",
        "eventos",
        "atividades",
        "galeria"
    ];

    telas.forEach(tela => inicializarTabela(tela));
});

// Seleciona elementos
const addButton = document.querySelector("#galeria .add-btn");
const galleryGrid = document.querySelector(".gallery-grid");

// Função para criar novo card na galeria
function criarCard(imgURL) {
    const card = document.createElement("div");
    card.classList.add("gallery-card");

    card.innerHTML = `
        <img src="${imgURL}">
        <div class="status">Ativo</div>

        <div class="actions-gallery">
            <button class="edit-img">✏️</button>
            <button class="delete-img">🗑️</button>
        </div>
    `;

    // Evento excluir
    card.querySelector(".delete-img").addEventListener("click", () => {
        card.remove();
    });

    // Evento editar imagem
    card.querySelector(".edit-img").addEventListener("click", () => {
        let input = document.createElement("input");
        input.type = "file";
        input.accept = "image/*";

        input.onchange = () => {
            const file = input.files[0];
            if (file) {
                const newURL = URL.createObjectURL(file);
                card.querySelector("img").src = newURL;
            }
        };

        input.click();
    });

    galleryGrid.appendChild(card);
}



// -------------------------------
// BOTÃO ➕ ADICIONAR NOVA FOTO
// -------------------------------
addButton.addEventListener("click", () => {
    let fileInput = document.createElement("input");
    fileInput.type = "file";
    fileInput.accept = "image/*";

    fileInput.onchange = () => {
        const file = fileInput.files[0];
        if (file) {
            const imgURL = URL.createObjectURL(file);
            criarCard(imgURL);
        }
    };

    fileInput.click();
});




