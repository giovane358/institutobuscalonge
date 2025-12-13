<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <title>Dashboard IBL</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    </head>

    <body>
        <div class="sidebar">
            <h2>IBL</h2>
            <div class="menu-item active" onclick="abrirPagina('dashboard', this)">Dashboard</div>
            <div class="menu-item" onclick="abrirPagina('estudantes', this)">Estudantes</div>
            <div class="menu-item" onclick="abrirPagina('instrutores', this)">Instrutores</div>
            <div class="menu-item" onclick="abrirPagina('salas', this)">Salas</div>
            <div class="menu-item" onclick="abrirPagina('eventos', this)">Eventos</div>
            <div class="menu-item" onclick="abrirPagina('atividades', this)">Atividades</div>
            <div class="menu-item" onclick="abrirPagina('galeria', this)">Galeria</div>
        </div>
        <div class="content">
            <div id="dashboard" class="page active">
                <h1>Dashboard</h1>
                <div class="card">Filtros / Informações do Dashboard conforme imagem...</div>
            </div>
            <div id="estudantes" class="page">
                <h1>Estudantes</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>
                    <div class="buttons">
                        <button id="btn-todos" class="btn active">Todos</button>
                        <button id="btn-ativos" class="btn inactive">Ativos</button>
                        <button id="btn-inativos" class="btn inactive">Inativos</button>
                        <button class="add-btn">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table id="studentsTable">
                        <thead>
                            <tr>
                                <th>Matrícula</th>
                                <th>Nome</th>
                                <th>Email</th>
                                <th>Curso</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>001</td>
                                <td>João Silva</td>
                                <td>joao@email.com</td>
                                <td>Informática</td>
                                <td><span class="status ativo">Ativo</span></td>
                                <td class="actions">
                                    <button class="edit-btn">✏️</button>
                                    <button class="delete-btn">🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="instrutores" class="page">
                <h1>Instrutores1</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>
                    <div class="buttons">
                        <button class="btn active">Todos</button>
                        <button class="btn inactive" onclick="getInscrutorEnable()">Ativos</button>
                        <button class="btn inactive" onclick="getInscrutorDisabled()">Inativos</button>
                        <button class="btn inactive" id="btnAbrirInstructor">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Ri</th>
                                <th>Nome</th>
                                <th>Data de Nascimento</th>
                                <th>Email</th>
                                <th>Telefone</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody id="instructorsTableBody">

                        </tbody>
                    </table>
                </div>
            </div>
            <div id="salas" class="page">
                <h1>Salas</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>
                    <div class="buttons">
                        <button class="btn active">Todos</button>
                        <button class="btn inactive">Ativos</button>
                        <button class="btn inactive">Inativos</button>
                        <button class="add-btn">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Capacidade</th>
                                <th>Local</th>
                                <th>Recurso</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>SALA A1</td>
                                <td>30</td>
                                <td>1° andar</td>
                                <td>Projetor e Wi-Fi</td>
                                <td><span class="status ativo">Ativo</span></td>
                                <td class="actions">
                                    <button>✏️</button>
                                    <button>🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="eventos" class="page">
                <h1>Eventos</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>
                    <div class="buttons">
                        <button class="btn active">Todos</button>
                        <button class="btn inactive">Ativos</button>
                        <button class="btn inactive">Inativos</button>
                        <button class="add-btn">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Data</th>
                                <th>Local</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Palestra</td>
                                <td>10/02/2025</td>
                                <td>Auditório</td>
                                <td><span class="status ativo">Ativo</span></td>
                                <td class="actions">
                                    <button>✏️</button>
                                    <button>🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="atividades" class="page">
                <h1>Atividades</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>
                    <div class="buttons">
                        <button class="btn active">Todos</button>
                        <button class="btn inactive">Ativos</button>
                        <button class="btn inactive">Inativos</button>
                        <button class="add-btn">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Curso</th>
                                <th>Início</th>
                                <th>Fim</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Aula 01</td>
                                <td>Informática</td>
                                <td>01/02/2025</td>
                                <td>05/02/2025</td>
                                <td><span class="status ativo">Ativa</span></td>
                                <td class="actions">
                                    <button>✏️</button>
                                    <button>🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="galeria" class="page">
                <h1>Galeria</h1>
                <div class="top-bar">
                    <div class="buttons">
                        <button class="add-btn">➕ Adicionar</button>
                    </div>
                    <div class="gallery-card">
                    </div>
                    <div class="gallery-grid">
                        <div class="gallery-card"> </div>
                        <div class="gallery-card"></div>
                        <div class="gallery-card"> </div>
                        <div class="gallery-card"></div>
                    </div>
                </div>
            </div>

            <!---modal-instructor-->
            <div class="modal" id="modal-instructor">
                <div class="modal-content">
                    <span class="close" id="btnFechar">&times;</span>
                    <h2>Cadastro</h2>

                    <form id="formsInstructor">
                        <div class="input-box">
                            <input placeholder="Primeiro Nome" type="text" id="firstName">
                        </div>

                        <div class="input-box">
                            <input placeholder="Último Nome" type="text" id="lastName">
                        </div>

                        <div class="input-box">
                            <input placeholder="Email" type="email" id="email">
                        </div>

                        <div class="input-box">
                            <input placeholder="Senha" type="password" id="senha">
                        </div>

                        <div class="input-box">
                            <input placeholder="Contato" type="text" id="contact">
                        </div>

                        <div class="input-box">
                            <input placeholder="CPF" type="text" id="cpf">
                        </div>

                        <div class="input-box">
                            <input placeholder="Data de Nascimento" type="date" id="birthDate">
                        </div>

                        <button type="submit" onclick="registerInstructor()">Enviar</button>
                    </form>
                </div>
            </div>

            <!-- MODAL DELETE INSTRUCTOR -->
            <div class="modal" id="modal-delete-instructor">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalDelete()">&times;</span>
                    <h2>Confirmar exclusão</h2>
                    <div class="delete-info">
                        <p><strong>Nome:</strong> <span id="del-name"></span></p>
                        <p><strong>Email:</strong> <span id="del-email"></span></p>
                        <p><strong>Contato:</strong> <span id="del-contact"></span></p>
                        <p><strong>CPF:</strong> <span id="del-cpf"></span></p>
                        <p><strong>Status:</strong> <span id="del-status"></span></p>
                    </div>
                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalDelete()">Cancelar</button>
                        <button class="btn danger" onclick="confirmarDelete()">Excluir</button>

                    </div>
                </div>
            </div>

             <!-- MODAL Atualizar INSTRUCTOR -->
            <div class="modal" id="modal-edit-instructor">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalEdit()">&times;</span>

                    <h2>Editar Instrutor</h2>

                    <!-- RI escondido -->
                    <input type="hidden" id="edit-ri">

                    <div class="input-box">
                        <input type="email" id="edit-email" placeholder="Email">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-contact" placeholder="Contato">
                    </div>


                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalEdit()">Cancelar</button>
                        <button class="btn active" onclick="salvarEdicaoInstructor()">Salvar</button>
                    </div>
                </div>
            </div>


            <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
    </body>

    </html>