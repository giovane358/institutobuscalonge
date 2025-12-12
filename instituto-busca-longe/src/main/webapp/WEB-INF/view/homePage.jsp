<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt-br">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Instituto Busca longe</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePage.css">
        <link rel="" </head>

    <body>
        <!--navegacao-->
        <header>
            <div class="logo">Istituto Busca Longe</div>
            <nav>
                <ul>
                    <li><a href="#inicio" class="menu-link">Inicio</a></li>
                    <li><a href="#sobre" class="menu-link">Sobre</a></li>
                    <li><a href="#atividade" class="menu-link">Atividade</a></li>
                    <li><a href="#projeto" class="menu-link">Projetos</a></li>
                    <li><a href="#galeria" class="menu-link">Galeria de Fotos</a></li>
                    <li><a href="login.html">ADMIN</a></li>
                </ul>
            </nav>
        </header>
        <!-- fim navegacao-->
        <div class="slider" id="inicio">
            <div class="slides">
                <!--Radios buttons-->
                <input type="radio" name="radio-btn" id="radio1">
                <input type="radio" name="radio-btn" id="radio2">
                <input type="radio" name="radio-btn" id="radio3">
                <!--slide imagens-->
                <div class="slide first">
                    <img
                        src="https://s2-g1.glbimg.com/Raono3PTnKUONKEo6XFtyBhPMLg=/0x0:1280x853/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/f/L/GaDUFXQCyAMMZa8XISMA/whatsapp-image-2023-05-31-at-14.48.14.jpeg">
                    <div class="slide-text">
                        <h2>Eventos que Unem <br>a Comunidade</h2>
                        <p>Promovemos eventos culturais e sociais que fortalecem <br>os laços comunitario.</p>
                    </div>
                </div>
                <div class="slide ">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/children-learning-together.jpg">
                    <div class="slide-text">
                        <h2>Transformando Vidas<br> Através da Educação</h2>
                        <p>Ofereçemos programas educacionais que capacitam<br> crianças e jovens para um futuro morlhor.
                        </p>
                    </div>
                </div>
                <div class="slide ">
                    <img
                        src="https://diadeaprenderbrincando.org.br/wp-content/uploads/sites/6/2017/04/shutterstock_384172003.jpg">
                    <div class="slide-text">
                        <h2>Esporte e Lazer para <br>Todos</h2>
                        <p>Atividades esportivas que promovem saúde,<br>bem-estar e integração social.</p>
                    </div>
                </div>
                <!--navegacao-->
                <div class="navigation-auto">
                    <div class="auto-btn1"></div>
                    <div class="auto-btn2"></div>
                    <div class="auto-btn3"></div>

                </div>
            </div>
            <div class="manual-navigation">
                <label for="radio1" class="manual-btn"></label>
                <label for="radio2" class="manual-btn"></label>
                <label for="radio3" class="manual-btn"></label>
            </div>
        </div>
        <section>
            <div class="bv">
                <h1>Bem-vindo ao Instituto Busca Longe</h1>
                <p>Somos uma organização dedicada a transformar vidas através de programas educacionais, culturais e
                    esportivos. Acreditamos no potencial de cada indivíduo e trabalhamos para criar oportunidades que
                    promovam o desenvolvimento integral de crianças, jovens e adultos em nossa comunidade.</p>
            </div>
            <div class="inovacao">
                <ul>
                    <li>
                        <h3>Comunidade</h3>
                        <p>Fortalecemos os laços comunitários através de ações integradas e participativas.</p>
                    </li>
                    <li>
                        <h3>Inovação</h3>
                        <p>Utilizamos métodos inovadores para promover aprendizado e desenvolvimento.</p>
                    </li>
                    <li>
                        <h3>Impacto Social</h3>
                        <P>Geramos impacto positivo e duradouro na vida de centenas de pessoas.</p>
                    </li>
                </ul>
            </div>
        </section>
        <hr>
        <section class="about" id="sobre">
            <div class="sobre">
                <h1>Sobre Nós</h1>
                <P>Conheça nossa história, missão e valores que guiam nosso trabalho</P>
            </div>
            <div class="mission">
                <!--Bloco 1 - missão -->
                <div class="mission-block">
                    <div class="img-mis">
                        <img src="https://v0-instituto-busca-longe-website.vercel.app/children-learning-together.jpg">
                    </div>
                    <div class="mission-text">
                        <h2>Nossa Missão</h2>
                        <p>Promover o desenvolvimento integral de crianças, jovens e adultos através de programas
                            educacionais, culturais e esportivos, contribuindo para a construção de uma sociedade mais
                            justa e igualitária.
                            Acreditamos que a educação e o acesso a oportunidades são fundamentais para transformar
                            vidas e comunidades. Por isso, trabalhamos incansavelmente para oferecer programas de
                            qualidade que atendam às necessidades reais de nossa comunidade.</p>
                    </div>
                </div>
                <!--Bloco 2 - visãso -->
                <div class="mission-block">
                    <div class="img-mis">
                        <img src="https://v0-instituto-busca-longe-website.vercel.app/children-learning-together.jpg">
                    </div>

                    <div class="mission-text">
                        <h2>Nossa Visão</h2>
                        <p>Ser referência em desenvolvimento social e comunitário, reconhecidos pela excelência de
                            nossos programas e pelo impacto positivo gerado na vida das pessoas e comunidades que
                            atendemos.
                            Sonhamos com um futuro onde todas as pessoas tenham acesso a oportunidades de
                            desenvolvimento e possam alcançar seu pleno potencial, independentemente de sua origem ou
                            condição socioeconômica.</p>
                    </div>
                </div>
            </div>
            <div class="nv">
                <h1>Nossos Valores</h1>
                <div class="nv-nv">
                    <ul>
                        <li>
                            <h3>Respeito</h3>
                            <p>Valorizamos a diversidade e tratamos todas as pessoas com dignidade e consideração.</p>
                        </li>
                        <li>
                            <h3>Compromisso</h3>
                            <p>Dedicação total à nossa missão e às pessoas que atendemos.</p>
                        </li>
                        <li>
                            <h3>Transparencia</h3>
                            <P>Atuamos com ética e clareza em todas as nossas ações e decisões.</p>
                        </li>
                        <li>
                            <h3>Excelência</h3>
                            <p>Buscamos constantemente a melhoria e qualidade em tudo que fazemos</p>
                        </li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="nh">
                <h1>Nossa História</h1>
                <P class="pg">
                    O Instituto Busca Longe nasceu em 2010 do sonho de um grupo de educadores e voluntários que
                    acreditavam no poder transformador da educação e do desenvolvimento comunitário. Começamos com um
                    pequeno programa de reforço escolar atendendo apenas 20 crianças em uma sala emprestada.
                    Ao longo dos anos, crescemos e expandimos nossas atividades, sempre mantendo o foco na qualidade e
                    no impacto real na vida das pessoas. Hoje, atendemos mais de 500 pessoas por ano em diversos
                    programas educacionais, culturais e esportivos.
                    Nossa jornada é marcada por histórias de superação, conquistas e transformação. Cada pessoa que
                    passa pelo Instituto leva consigo não apenas conhecimento, mas também esperança, confiança e
                    ferramentas para construir um futuro melhor.
                </P>
            </div>
            <hr>
        </section>
        <sectio>
            <div class="nv" id="atividade">
                <h1>Nossas Atividades</h1>
                <p class="pg">Oferecemos uma variedade de programas para atender diferentes interesses e necessidades
                </p>
                <div class="nv-nv">
                    <ul class="down">
                        <li>
                            <h3>Reforço Escolar</h3>
                            <p>Aulas de apoio pedagógico para crianças e adolescentes em diversas disciplinas.</p>
                        </li>
                        <li>
                            <h3>Oficinas de Arte</h3>
                            <p>Desenvolvimento da criatividade através de pintura, desenho e artesanato.</p>
                        </li>
                        <li>
                            <h3>Música e Dança</h3>
                            <P>Aulas de instrumentos musicais e dança para todas as idades.</p>
                        </li>
                        <li>
                            <h3>Esportes</h3>
                            <p>Práticas esportivas incluindo futebol, vôlei, basquete e artes marciais.</p>
                        </li>
                        <li>
                            <h3>Informática</h3>
                            <p>Cursos de informática básica e avançada para inclusão digital.</p>
                        </li>
                        <li>
                            <h3>Desenvolvimento Social</h3>
                            <p>Workshops sobre cidadania, liderança e desenvolvimento pessoal.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <P class="pg">Interessado em participar de nossas atividades? Entre em contato conosco!</P>
                <button class="center-screen">Entre Em Contato</button>
            </div>
        </sectio>
        <hr>
        <section id="projeto" class="projeto">
            <h2 class="projetos-titulo">Proximos Eventos</h2>
            <P class="pg">Participe dos nossos eventos e faça parte da transformação da nossa comunidade</P>
            <div class="projeto-ciaxa">
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/talent-show-stage.jpg"
                        alt="imagen ilustrativa" class="projeto-imagen">
                    <div class="caixa-texto-projeto">
                        <h3 class="info-projeto">Festival de talento</h3>
                        <p class="paragrafo-projeto">Apresentação dos talentos desenvolvidos pelos alunos nas oficinas
                            de arte, música e dança.</p>
                    </div>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/vibrant-sports-tournament.png"
                        alt="imagen ilustrativa" class="projeto-imagen">
                    <div class="caixa-texto-projeto">
                        <h3 class="info-projeto">Torneio Esportivo Comunitario</h3>
                        <p class="paragrafo-projeto">Competição amigável entre equipes da comunidade em diversas
                            modalidades esportivas.</p>
                    </div>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/science-fair.png"
                        alt="imagen ilustrativa" class="projeto-imagen">
                    <div class="caixa-texto-projeto">
                        <h3 class="info-projeto">Feira De Ciências e tecnologia</h3>
                        <p class="paragrafo-projeto">Exposição de projetos científicos e tecnológicos desenvolvidos
                            pelos estudantes.</p>
                    </div>
                </div>
            </div>
            <div>
                <P class="pg">Quer saber mais sobre nossos eventos ou propor uma parceria?</P>
                <button class="center-screen">Entre Em Contato</button>
            </div>
            <hr>
        </section>
        <section id="galeria" class="projeto">
            <h2 class="projetos-titulo">Galeria De Fotos</h2>
            <div class="projeto-ciaxa">
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/talent-show-stage.jpg" width=100%
                        height=100%>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/vibrant-sports-tournament.png"
                        width=100% height=100%>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/science-fair.png" width=100%
                        height=100%>
                </div>
            </div>
            <div class="projeto-ciaxa">
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/talent-show-stage.jpg" width=100%
                        height=100%>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/vibrant-sports-tournament.png"
                        width=100% height=100%>
                </div>
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/science-fair.png" width=100%
                        height=100%>
                </div>
            </div>
        </section>
        <hr>
        <footer>
            <div class="footer-content">
                <div class="logo-footer">Istituto Busca Longe
                    <p class="logo-footer">Transformando vidas através de atividades e eventos<br> que promovem
                        desenvolvimento social e comunitário.</p>
                </div>
                <div class="contact">
                    <h3>contato</h3>
                    Rua Exemplo, 123 - Centro<br>
                    São Paulo, SP - CEP 01234-567<br>
                    (11) 1234-5678<br>
                    ontato@buscalonge.org.br<br>
                </div>
            </div>
        </footer>
        <hr>
        <p class="direitos">&copy; 2025 Instituto Busca Longe. Todos os direitos reservados.</p>
        <script src="${pageContext.request.contextPath}/js/app.js"></script>
    </body>
    </html>