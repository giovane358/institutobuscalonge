const token = localStorage.getItem("token");

let instructorCache = [];
let instructorSelecionado = null;

let studentCache = [];
let studentSelecionado = null;

let classRoomCache = [];
let classRoomSelecionado = null;


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

/* ===================== Start Students ===================== */

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
        alert("Erro ao carregar Estudantes ativos");
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
        alert("Erro ao carregar Estudantes ativos");
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
                <button onclick="abrirModalDeleteStudent(${stud.ra})">🗑️</button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}

/* ===================== MODAL DELETE ===================== */
function abrirModalDeleteStudent(ra) {
    studentSelecionado = studentCache.find(i => i.ra === ra);

    if (!studentSelecionado) {
        alert("Estudante não encontrado");
        return;
    }

    document.getElementById("del-nameStudent").innerText = studentSelecionado.firstName + " " + studentSelecionado.lastName;
    document.getElementById("del-emailStudent").innerText = studentSelecionado.email;
    document.getElementById("del-contactStudent").innerText = studentSelecionado.contact ?? "-";
    document.getElementById("del-statusStudent").innerText = studentSelecionado.active ? "Ativo" : "Inativo";

    document.getElementById("modal-delete-students").classList.add("active");
}

function fecharModalDeleteStudent() {
    document.getElementById("modal-delete-students").classList.remove("active");
    studentSelecionado = null;
}

async function confirmarDeleteStudent() {
    if (!studentSelecionado) {
        alert("Estudante não selecionado");
        return;
    }

    console.log("ENVIANDO DELETE:", studentSelecionado.ra);

    const resp = await fetch("/student/delet", {
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

    fecharModalDeleteStudent();
    await getStudentEnable();
    alert("Estudente desativado com sucesso");
}



/* ===================== MODAL UPDATE ===================== */


/* ===================== MODAL UPDATE ===================== */
function editarStudent(ra) {
    const stud = studentCache.find(i => i.ra === ra);

    if (!stud) {
        alert("Estudante não encontrado");
        return;
    }

    // Preenche os inputs
    document.getElementById("edit-raStudent").value = stud.ra;
    document.getElementById("edit-emailStudent").value = stud.email;
    document.getElementById("edit-contactStudent").value = stud.contact ?? "";

    // Abre o modal
    document.getElementById("modal-edit-student").classList.add("active");
}

function fecharModalEditStudent() {
    document.getElementById("modal-edit-student").classList.remove("active");
}

function montarStudentEditado() {
    return {
        ra: parseInt(document.getElementById("edit-raStudent").value, 10),
        email: document.getElementById("edit-emailStudent").value,
        contact: document.getElementById("edit-contactStudent").value
    };
}


async function salvarEdicaoStudent() {
    const stud = montarStudentEditado();

    try {
        const resp = await fetch("/student/update", {
            method: "PUT",
            headers: apiHeaders(),
            body: JSON.stringify(stud)
        });

        if (!resp.ok) throw new Error();

        fecharModalEdit();
        getStudentEnable(); // recarrega lista
        alert("Estudante atualizado com sucesso!");

    } catch (e) {
        console.error(e);
        alert("Erro ao atualizar Estudante");
    }
}

/* ===================== End Students ===================== */


/* ===================== Start CLASSROOM ===================== */

/* ===================== CADASTRO ===================== */
function classRoom() {
    return {
        title: document.getElementById("titleClassRoom").value,
        description: document.getElementById("descriptionClassRoom").value,
        capacity: document.getElementById("capacityClassRoom").value,
        duration: document.getElementById("durationClassRoom").value,
        address: document.getElementById("addressClassRoom").value,
        level: document.getElementById("levelClassRoom").value,
        setInstructorBy: document.getElementById("setInstructorByClassRoom").value
    };
}

async function registerClassRoom() {
    const room = classRoom();

    const resp = await fetch("/classRoom/register", {
        method: "POST",
        headers: apiHeaders(),
        body: JSON.stringify(room)
    });

    if (!resp.ok) throw new Error("Erro ao cadastrar");

    fecharModalCadastro();
    getInscrutorEnable();
}

/* ===================== MODAL CADASTRO ===================== */
document.addEventListener("click", e => {
    if (e.target.id === "btnAbrirClassRoom") {
        document.getElementById("modal-classRoom").classList.add("active");
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
    document.getElementById("modal-classRoom").classList.remove("active");
}


/* ===================== LISTAR ATIVOS ===================== */
async function fetchClassRoomEnable() {
    const resp = await fetch("/classRoom/list/enable", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getClassRoomEnable() {
    try {
        const lista = await fetchClassRoomEnable();
        renderClassRoom(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar Sala ativos");
    }
}

/* ===================== LISTAR Inativos ===================== */
async function fetchClassRoomDisabled() {
    const resp = await fetch("/classRoom/list/disabled", {
        method: "GET",
        headers: apiHeaders()
    });

    if (!resp.ok) throw new Error("Erro ao buscar");

    return resp.json();
}

async function getClassRoomDisabled() {
    try {
        const lista = await fetchClassRoomDisabled();
        renderClassRoom(lista);
    } catch (e) {
        console.error(e);
        alert("Erro ao carregar Sala ativos");
    }
}

/* ===================== RENDER TABELA ===================== */
function renderClassRoom(lista) {
    classRoomCache = lista;

    const tbody = document.getElementById("classRoomTableBody");
    tbody.innerHTML = "";

    lista.forEach(room => {
        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${room.id}</td>
            <td>${room.title}</td>
            <td>${room.description}</td>
            <td>${room.capacity}</td>
            <td>${room.duration}</td>
            <td>${room.address ?? "-"}</td>
            <td>${room.level}</td>
            <td>${room.active ? "Ativo" : "Inativo"}</td>
            <td class="actions">
                <button onclick="editarClassRoom(${room.id})">✏️</button>
                <button onclick="abrirModalDeleteClassRoom(${room.id})">🗑️</button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}


/* ===================== MODAL DELETE ===================== */
function abrirModalDeleteClassRoom(id) {
    classRoomSelecionado = classRoomCache.find(i => i.id === id);

    if (!classRoomSelecionado) {
        alert("Sala não encontrado");
        return;
    }

    document.getElementById("del-titleClassRoom").innerText = classRoomSelecionado.title;
    document.getElementById("del-descriptionClassRoom").innerText = classRoomSelecionado.description;
    document.getElementById("del-capacityClassRoom").innerText = classRoomSelecionado.capacity;
    document.getElementById("del-durationClassRoom").innerText = classRoomSelecionado.duration;
    document.getElementById("del-addressClassRoom").innerText = classRoomSelecionado.address;
    document.getElementById("del-levelClassRoom").innerText = classRoomSelecionado.level;
    document.getElementById("del-setInstructorByClassRoom").innerText = classRoomSelecionado.setInstructorBy;
    document.getElementById("del-status").innerText = classRoomSelecionado.active ? "Ativo" : "Inativo";

    document.getElementById("modal-delete-classRoom").classList.add("active");
}

function fecharModalDeleteClassRoom() {
    document.getElementById("modal-delete-classRoom").classList.remove("active");
    classRoomSelecionado = null;
}

async function confirmarDeleteClassRoom() {
    if (!classRoomSelecionado) {
        alert("Sala não selecionado");
        return;
    }

    console.log("ENVIANDO DELETE:", classRoomSelecionado.id);

    const resp = await fetch("/classRoom/delet", {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
        },
        body: JSON.stringify({
            id: classRoomSelecionado.id
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
    alert("Sala desativado com sucesso");
}


/* ===================== MODAL UPDATE ===================== */
function editarClassRoom(id) {
    const room = classRoomCache.find(i => i.id === id);

    if (!room) {
        alert("Sala não encontrado");
        return;
    }

    // Preenche os inputs
    document.getElementById("edit-id").value = room.id;
    document.getElementById("edit-title").value = room.title;
    document.getElementById("edit-description").value = room.description;
    document.getElementById("edit-capacity").value = room.capacity;
    document.getElementById("edit-duration").value = room.duration;
    document.getElementById("edit-address").value = room.address;
    document.getElementById("edit-level").value = room.level;


    // Abre o modal
    document.getElementById("modal-edit-classRoom").classList.add("active");
}

function fecharModalEditClassRoom() {
    document.getElementById("modal-edit-classRoom").classList.remove("active");
}

function montarClassRoomEditado() {
    return {
        id: document.getElementById("edit-id").value,
        title: document.getElementById("edit-title").value,
        description: document.getElementById("edit-description").value,
        capacity: document.getElementById("edit-capacity").value,
        duration: document.getElementById("edit-duration").value,
        address: document.getElementById("edit-address").value,
        level: document.getElementById("edit-level").value
    };
}


async function salvarEdicaoClassRoomr() {
    const room = montarClassRoomEditado();

    try {
        const resp = await fetch("/classRoom/update", {
            method: "PUT",
            headers: apiHeaders(),
            body: JSON.stringify(room)
        });

        if (!resp.ok) throw new Error();

        fecharModalEdit();
        getInscrutorEnable(); // recarrega lista
        alert("Sala atualizado com sucesso!");

    } catch (e) {
        console.error(e);
        alert("Erro ao atualizar Sala");
    }
}




