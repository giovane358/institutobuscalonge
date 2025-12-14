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
          
            <div class="menu-item" onclick="abrirPagina('estudantes', this)">Estudantes</div>
            <div class="menu-item" onclick="abrirPagina('instrutores', this)">Instrutores</div>
            <div class="menu-item" onclick="abrirPagina('salas', this)">Salas</div>
            <div class="menu-item" onclick="abrirPagina('eventos', this)">Eventos</div>
            <div class="menu-item" onclick="abrirPagina('atividades', this)">Atividades</div>
            <div class="menu-item" onclick="abrirPagina('galeria', this)">Galeria</div>
        </div>
        <div class="content">
            
            <div id="estudantes" class="page">
                <h1>Estudantes</h1>
                <div class="top-bar">
                    <div class="search-box">
                        <input type="text" placeholder="Pesquisar..." />
                        <img width="25" src="https://img.icons8.com/ios-glyphs/30/search--v1.png">
                    </div>

                    <div class="buttons">
                        <button class="btn active">Todos</button>
                        <button class="btn inactive" onclick="getStudentEnable()">Ativos</button>
                        <button class="btn inactive" onclick="getEstudantDisabled()">Inativos</button>
                        <button class="btn active" id="btnAbrirStudent">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Ra</th>
                                <th>Nome</th>
                                <th>Data de Nascimento</th>
                                <th>Email</th>
                                <th>Telefone</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody id="studentTableBody">
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
                        <button class="btn inactive" onclick="getClassRoomEnable()">Ativos</button>
                        <button class="btn inactive" onclick="getClassRoomDisabled()">Inativos</button>
                        <button class="add-btn" id="btnAbrirClassRoom">➕ Adicionar</button>
                    </div>
                </div>
                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Titulo</th>
                                <th>Descrição</th>
                                <th>Capacidade</th>
                                <th>Duração</th>
                                <th>Onde</th>
                                <th>Nível</th>
                                <th>Status</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody id="classRoomTableBody">

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
                        <button class="btn inactive" onclick="getEventosEnable()">Ativos</button>
                        <button class="btn inactive" onclick="getEventosDisabled()">Inativos</button>
                        <button class="btn inactive" id="btnAbrirEventos">➕ Adicionar</button>
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
                        </tbody id="eventosTableBody">
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




            <!---modal-Estudnates-->
            <div class="modal" id="modal-student">
                <div class="modal-content">
                    <span class="close" id="btnFechar">&times;</span>
                    <h2>Cadastro</h2>

                    <form id="formsStudent">
                        <div class="input-box">
                            <input placeholder="Primeiro Nome" type="text" id="firstName_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="Último Nome" type="text" id="lastName_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="Email" type="email" id="email_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="Contato" type="text" id="contact_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="nameDaddy" type="text" id="nameDaddy_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="nameMom" type="text" id="nameMom_student">
                        </div>

                        <div class="input-box">
                            <input placeholder="Data de Nascimento" type="date" id="birthDate_student">
                        </div>

                        <button type="submit" onclick="registerStudent()">Enviar</button>
                    </form>
                </div>
            </div>

            <!-- MODAL Atualizar Estudentes -->
            <div class="modal" id="modal-edit-student">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalEditStudent()">&times;</span>

                    <h2>Editar Estudentes</h2>

                    <!-- RI escondido -->
                    <input type="hidden" id="edit-raStudent">
         
                    <div class="input-box">
                        <input type="email" id="edit-emailStudent" placeholder="Email">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-contactStudent" placeholder="Contato">
                    </div>

                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalEditStudent()">Cancelar</button>
                        <button class="btn active" onclick="salvarEdicaoStudent()">Salvar</button>
                    </div>
                </div>
            </div>

            <!-- MODAL DELETE STUDENTS -->
            <div class="modal" id="modal-delete-students">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalDeleteStudent()">&times;</span>
                    <h2>Confirmar exclusão</h2>
                    <div class="delete-info">
                        <p><strong>Titulo:</strong> <span id="del-nameStudent"></span></p>
                        <p><strong>Descrição:</strong> <span id="del-emailStudent"></span></p>
                        <p><strong>Capacidade:</strong> <span id="del-contactStudent"></span></p>
                        <p><strong>Duração:</strong> <span id="del-statusStudent"></span></p>
                    </div>
                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalDeleteStudent()">Cancelar</button>
                        <button class="btn danger" onclick="confirmarDeleteStudent()">Excluir</button>

                    </div>
                </div>
            </div>



            <!---modal-Classroom-->
            <div class="modal" id="modal-classRoom">
                <div class="modal-content">
                    <span class="close" id="btnFechar">&times;</span>
                    <h2>Cadastro de Salas</h2>

                    <form id="formsClassRoom">

                        <div class="input-box">
                            <input placeholder="Titulo" type="text" id="titleClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Descrição" type="text" id="descriptionClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Capacidade" type="text" id="capacityClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Duração" type="number" id="durationClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Onde" type="text" id="addressClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Nivel" type="text" id="levelClassRoom">
                        </div>
                        <div class="input-box">
                            <input placeholder="Instrutor" type="text" id="setInstructorByClassRoom">
                        </div>

                        <button type="submit" onclick="registerClassRoom()">Enviar</button>
                    </form>
                </div>
            </div>

            <!-- MODAL DELETE CLASSROOM -->
            <div class="modal" id="modal-delete-classRoom">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalDeleteClassRoom()">&times;</span>
                    <h2>Confirmar exclusão</h2>
                    <div class="delete-info">
                        <p><strong>Titulo::</strong> <span id="del-titleClassRoom"></span></p>
                        <p><strong>Descrição:</strong> <span id="del-descriptionClassRoom"></span></p>
                        <p><strong>Capacidade:</strong> <span id="del-capacityClassRoom"></span></p>
                        <p><strong>Duração:</strong> <span id="del-durationClassRoom"></span></p>
                        <p><strong>Onde:</strong> <span id="del-addressClassRoom"></span></p>
                        <p><strong>Nível:</strong> <span id="del-levelClassRoom"></span></p>
                        <p><strong>Instrutor:</strong> <span id="del-setInstructorByClassRoom"></span></p>
                        <p><strong>Status:</strong> <span id="del-statusClassRoom"></span></p>
                    </div>
                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalDeleteClassRoom()">Cancelar</button>
                        <button class="btn danger" onclick="confirmarDeleteClassRoom()">Excluir</button>

                    </div>
                </div>
            </div>

            <!-- MODAL Atualizar ClassRoom -->
            <div class="modal" id="modal-edit-classRoom">
                <div class="modal-content">
                    <span class="close" onclick="fecharModalEditClassRoom()">&times;</span>

                    <h2>Editar ClassRoom</h2>

                    <!--id escondido -->
                    <input type="hidden" id="edit-id">

                    <div class="input-box">
                        <input type="text" id="edit-title" placeholder="Titulo">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-description" placeholder="Descrição">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-capacity" placeholder="Capacidade">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-duration" placeholder="duration">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-address" placeholder="address">
                    </div>

                    <div class="input-box">
                        <input type="text" id="edit-level" placeholder="level">
                    </div>


                    <div class="modal-actions">
                        <button class="btn inactive" onclick="fecharModalEditClassRoom()">Cancelar</button>
                        <button class="btn active" onclick="salvarEdicaoClassRoomr()">Salvar</button>
                    </div>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
    </body>

    </html>