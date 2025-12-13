const token = localStorage.getItem("token");

let instrutoresCache = [];
let instructorSelecionado = null;
let studentCache = [];
let studentSelecionado = null;

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


/* ===================== End INSTRUCTOR ===================== */



/* ===================== CADASTRO ===================== */
function student() {
    return {
        firstName: document.getElementById("firstName_student").value,
        lastName: document.getElementById("lastName_student").value,
        email: document.getElementById("email_student").value,
        birthDate: document.getElementById("birthDate_student").value,
        contact: document.getElementById("contact_student").value,
        nameDaddy: document.getElementById("nameDaddy_student").value,
        nameMom: document.getElementById("nameMom_student").value
    };
}


async function registerStudent() {
    const stu = student();

    const resp = await fetch("/student/register", {
        method: "POST",
        headers: apiHeaders(),
        body: JSON.stringify(stu)
    });

    if (!resp.ok) throw new Error("Erro ao cadastrar");

    fecharModalCadastro();
    getInscrutorEnable();
}

/* ===================== MODAL CADASTRO Estudantes ===================== */
document.addEventListener("click", e => {
    if (e.target.id === "btnAbrirStudent") {
        document.getElementById("modal-student").classList.add("active");
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
    document.getElementById("modal-student").classList.remove("active");
}

/* ===================== LISTAR ATIVOS ===================== */
async function fetchStudentEnable() {
    const resp = await fetch("/student/list/enabled", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getStudentEnable() {
    try {
        const lista = await fetchStudentEnable();
        renderStudent(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar instrutores ativos");
    }
}

async function fetchStudentDisabled() {
    const resp = await fetch("/student/list/disabled", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getEstudantDisabled() {
    try {
        const lista = await fetchStudentDisabled();
        renderStudent(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar instrutores ativos");
    }
}


/* ===================== RENDER TABELA ===================== */
function renderStudent(lista) {
    studentCache = lista;

    const tbody = document.getElementById("studentTableBody");
    tbody.innerHTML = "";   

    lista.forEach(stud => {
        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${stud.ra}</td>
            <td>${stud.firstName} ${stud.lastName}</td>
            <td>${stud.birthDate}</td>
            <td>${stud.email}</td>
            <td>${stud.contact ?? "-"}</td>
            <td>${stud.active ? "Ativo" : "Inativo"}</td>
            <td class="actions">
                <button onclick="editarStudent(${stud.ra})">✏️</button>
                <button onclick="abrirModalDelete(${stud.ra})">🗑️</button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}

/* ===================== MODAL DELETE ===================== 
function abrirModalDelete(ra) {
    studentSelecionado = studentCache.find(i => i.ra === ra);

    if (!studentSelecionado) {
        alert("estudante não encontrado");
        return;
    }

    document.getElementById("del-name").innerText =
        studentSelecionado.firstName + " " + studentSelecionado.lastName;

    document.getElementById("del-email").innerText = studentSelecionado.email;
    document.getElementById("del-contact").innerText = studentSelecionado.contact ?? "-";
    document.getElementById("del-status").innerText =
        studentSelecionado.active ? "Ativo" : "Inativo";

    document.getElementById("modal-delete-student").classList.add("active");
}

function fecharModalDelete() {
    document.getElementById("modal-delete-student").classList.remove("active");
    studentSelecionado = null;
}

async function confirmarDelete() {
    if (!studentSelecionado) {
        alert("Estudante não selecionado");
        return;
    }

    console.log("ENVIANDO DELETE:", studentSelecionado.ra);

    const resp = await fetch("/student/delete", {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
        },
        body: JSON.stringify({
            ra: studentSelecionado.ra
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
    await getStudentEnable();
    alert("Estudente desativado com sucesso");
}*/

/* ===================== MODAL UPDATE ===================== */

function editarStudent(ra) {
    const estu = studentCache.find(i => i.ra === ra);

    if (!estu) {
        alert("Estudente não encontrado");
        return;
    }

    // Preenche os inputs
    document.getElementById("edit-ra").value = estu.ra;
    document.getElementById("edit-email").value = estu.email;
    document.getElementById("edit-contact").value = estu.contact ?? "";

    // Abre o modal
    document.getElementById("modal-edit-student").classList.add("active");
}

function fecharModalEdit() {
    document.getElementById("modal-edit-student").classList.remove("active");
}

function montarStudentEditado() {
    return {
        firstName: document.getElementById("firstName_student").value,
        lastName: document.getElementById("lastName_student").value,
        email: document.getElementById("email_student").value,
        birthDate: document.getElementById("birthDate_student").value,
        contact: document.getElementById("contact_student").value,
    };
}

async function salvarEdicaoStudent() {
    const student = montarStudentEditado();

    try {
        const resp = await fetch("/student/update", {
            method: "PUT",
            headers: apiHeaders(),
            body: JSON.stringify(student)
        });

        if (!resp.ok) throw new Error();

        fecharModalEdit();
        getStudentEnabled(); // recarrega lista
        alert("Estudante atualizado com sucesso!");

    } catch (e) {
        console.error(e);
        alert("Erro ao atualizar Estudante");
    }
}






