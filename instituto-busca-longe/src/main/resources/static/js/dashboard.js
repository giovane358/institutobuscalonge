const token = localStorage.getItem("token");

let instrutoresCache = [];
let instructorSelecionado = null;

/* ===================== HEADERS ===================== */
function apiHeaders() {
    return {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${token}`
    };
}


/* ===================== Start INSTRUCTOR ===================== */

/* ===================== MENU ===================== */
function abrirPagina(id, item = null) {
    document.querySelectorAll(".page").forEach(p => p.classList.remove("active"));
    document.getElementById(id)?.classList.add("active");

    if (item) {
        document.querySelectorAll(".menu-item").forEach(m => m.classList.remove("active"));
        item.classList.add("active");
    }
}

/* ===================== CADASTRO ===================== */
function instructor() {
    return {
        firstName: document.getElementById("firstName").value,
        lastName: document.getElementById("lastName").value,
        email: document.getElementById("email").value,
        senha: document.getElementById("senha").value,
        contact: document.getElementById("contact").value,
        cpf: document.getElementById("cpf").value,
        birthDate: document.getElementById("birthDate").value
    };
}

async function registerInstructor() {
    const inst = instructor();

    const resp = await fetch("/instructor/register", {
        method: "POST",
        headers: apiHeaders(),
        body: JSON.stringify(inst)
    });

    if (!resp.ok) throw new Error("Erro ao cadastrar");

    fecharModalCadastro();
    getInscrutorEnable();
}

/* ===================== LISTAR ATIVOS ===================== */
async function fetchInstrutoresEnable() {
    const resp = await fetch("/instructor/list/enable", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getInscrutorEnable() {
    try {
        const lista = await fetchInstrutoresEnable();
        renderInstrutores(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar instrutores ativos");
    }
}

/* ===================== LISTAR INATIVOS ===================== */
async function fetchInstrutoresDisabled() {
    const resp = await fetch("/instructor/list/disabled", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getInscrutorDisabled() {
    try {
        const lista = await fetchInstrutoresDisabled();
        renderInstrutores(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar instrutores inativos");
    }
}

/* ===================== RENDER TABELA ===================== */
function renderInstrutores(lista) {
    instrutoresCache = lista;

    const tbody = document.getElementById("instructorsTableBody");
    tbody.innerHTML = "";

    lista.forEach(inst => {
        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${inst.ri}</td>
            <td>${inst.firstName} ${inst.lastName}</td>
            <td>${inst.birthDate}</td>
            <td>${inst.email}</td>
            <td>${inst.contact ?? "-"}</td>
            <td>${inst.active ? "Ativo" : "Inativo"}</td>
            <td class="actions">
                <button onclick="editarInstructor(${inst.ri})">✏️</button>
                <button onclick="abrirModalDelete(${inst.ri})">🗑️</button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}

/* ===================== MODAL DELETE ===================== */
function abrirModalDelete(ri) {
    instructorSelecionado = instrutoresCache.find(i => i.ri === ri);

    if (!instructorSelecionado) {
        alert("Instrutor não encontrado");
        return;
    }

    document.getElementById("del-name").innerText =
        instructorSelecionado.firstName + " " + instructorSelecionado.lastName;

    document.getElementById("del-email").innerText = instructorSelecionado.email;
    document.getElementById("del-contact").innerText = instructorSelecionado.contact ?? "-";
    document.getElementById("del-cpf").innerText = instructorSelecionado.cpf ?? "-";
    document.getElementById("del-status").innerText =
        instructorSelecionado.active ? "Ativo" : "Inativo";

    document.getElementById("modal-delete-instructor").classList.add("active");
}

function fecharModalDelete() {
    document.getElementById("modal-delete-instructor").classList.remove("active");
    instructorSelecionado = null;
}

async function confirmarDelete() {
    if (!instructorSelecionado) {
        alert("Instrutor não selecionado");
        return;
    }

    console.log("ENVIANDO DELETE:", instructorSelecionado.ri);

    const resp = await fetch("/instructor/delete", {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
        },
        body: JSON.stringify({
            ri: instructorSelecionado.ri
        })
    });

    console.log("STATUS:", resp.status);

    const text = await resp.text();
    console.log("RESPOSTA:", text);

    if (!resp.ok) {
        alert("Erro ao deletar");
        return;
    }

    fecharModalDelete();
    await getInscrutorEnable();
    alert("Instrutor desativado com sucesso");
}

/* ===================== MODAL CADASTRO ===================== */
document.addEventListener("click", e => {
    if (e.target.id === "btnAbrirInstructor") {
        document.getElementById("modal-instructor").classList.add("active");
    }

    if (e.target.id === "btnFechar") {
        fecharModalCadastro();
    }

    if (e.target.classList.contains("modal")) {
        fecharModalCadastro();
        fecharModalDelete();
    }
});

function fecharModalCadastro() {
    document.getElementById("modal-instructor").classList.remove("active");
}

/* ===================== MODAL UPDATE ===================== */

function editarInstructor(ri) {
    const inst = instrutoresCache.find(i => i.ri === ri);

    if (!inst) {
        alert("Instrutor não encontrado");
        return;
    }

    // Preenche os inputs
    document.getElementById("edit-ri").value = inst.ri;
    document.getElementById("edit-email").value = inst.email;
    document.getElementById("edit-contact").value = inst.contact ?? "";

    // Abre o modal
    document.getElementById("modal-edit-instructor").classList.add("active");
}

function fecharModalEdit() {
    document.getElementById("modal-edit-instructor").classList.remove("active");
}

function montarInstructorEditado() {
    return {
        ri: document.getElementById("edit-ri").value,
        email: document.getElementById("edit-email").value,
        contact: document.getElementById("edit-contact").value
    };
}

async function salvarEdicaoInstructor() {
    const instructor = montarInstructorEditado();

    try {
        const resp = await fetch("/instructor/update", {
            method: "PUT",
            headers: apiHeaders(),
            body: JSON.stringify(instructor)
        });

        if (!resp.ok) throw new Error();

        fecharModalEdit();
        getInscrutorEnable(); // recarrega lista
        alert("Instrutor atualizado com sucesso!");

    } catch (e) {
        console.error(e);
        alert("Erro ao atualizar instrutor");
    }
}


/* ===================== Start INSTRUCTOR ===================== */
