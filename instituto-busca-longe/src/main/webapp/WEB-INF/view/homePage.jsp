<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="pt-br">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homePage.css">
        <title>carrosel</title>
    </head>

    <body>
        <header>
            <div class="logo">Istituto Busca Longe</div>
            <nav>
                <ul>
                    <li>Inicio</li>
                    <li>Sobre</li>
                    <li>Atividade</li>
                    <li>Eventos</li>
                    <li>Galeria</li>
                </ul>
            </nav>
        </header>

        <main class="container">
            <div class="tech-circle">
                <div class="circle"></div>
                <div class="circle"></div>
                <div class="circle"></div>
                <div class="circle"></div>
            </div>

            <div class="list">

                <div class="item active">
                    <div class="product-img">
                        <img src="https://parquedamonica.com.br/wp-content/uploads/2024/01/Criancas_brincando_de_pintar.png"
                            width="60%" height="40%">
                    </div>

                    <div class="content">
                        <p class="product-tag">Transformação</p>
                        <p class="product-name">Transformando Vidas Atravez Da Educação</p>
                        <p class="description">Oferecemos Programas educacionais que capacitam crianças e jovem para um
                            futuro melhor.</p>
                        <button class="btn">Saiba Mais</button>
                    </div>



                    <div class="arrows">
                        <button class="arrow-btn" id="prev">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#fff"
                                class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                                <path
                                    d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0m3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5z" />
                            </svg>
                        </button>
                        <button class="arrow-btn" id="next">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#fff"
                                class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                <path
                                    d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0M4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5z" />
                            </svg>
                        </button>
                    </div>

                    <div class="indicators">
                        <div class="numbers">01</div>
                        <div class="dots">
                            <div class="dot active"></div>
                            <div class="dot"></div>
                            <div class="dot"></div>

                        </div>
                    </div>
                </div>

                <div class="item">
                    <div class="product-img">
                        <img src="https://cruzeirodosul.vtexassets.com/arquivos/ids/162278/cursos-livres-recreacao-e-lazer-cruzeiro-do-sul-virtual.jpg?v=638814430096030000"
                            width="60%" height="40%">
                    </div>
                    <div class="content">
                        <p class="product-tag">Lazer</p>
                        <p class="product-name">Esporte E Lazer Para Todos</p>
                        <p class="description">Atividades Esportivas Que Promevem Saúde, Bem Estar E Integração Social.
                        </p>
                        <button class="btn">Saiba Mais</button>
                    </div>
                </div>


                <div class="item">
                    <div class="product-img">
                        <img src="https://parauapebas.pa.gov.br/wp-content/uploads/2025/04/WhatsApp-Image-2025-04-07-at-14.15.48.jpeg"
                            width="60%" height="40%">
                    </div>
                    <div class="content">
                        <p class="product-tag">Eventos</p>
                        <p class="product-name">Eventos Que Unem A Comunidade</p>
                        <p class="description">Promovemos Eventos Culturais e Sociais que Fortacem os Laços
                            Comunitarios.</p>
                        <button class="btn">Saiba Mais</button>
                    </div>
                </div>

            </div>
        </main>

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
        <section class="about">
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

            <sectio>
                <div class="nv">
                    <h1>Nossas Atividades</h1>
                    <p class="pg">Oferecemos uma variedade de programas para atender diferentes interesses e
                        necessidades</p>
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


        </section>



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


        <section id="projeto" class="projeto">
            <h2 class="projetos-titulo">Galeria De Fotos</h2>
            <div class="projeto-ciaxa">

                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/talent-show-stage.jpg" width=100%
                        height=100%>
                    <div class="caixa-texto-projeto">

                    </div>
                </div>


                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/vibrant-sports-tournament.png"
                        width=100% height=100%>
                    <div class="caixa-texto-projeto">
                    </div>
                </div>


                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/science-fair.png" width=100%
                        height=100%>
                    <div class="caixa-texto-projeto">
                    </div>
                </div>

            </div>

            <div class="projeto-ciaxa">
                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/talent-show-stage.jpg" width=100%
                        height=100%>
                    <div class="caixa-texto-projeto">
                    </div>
                </div>


                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/vibrant-sports-tournament.png"
                        width=100% height=100%>
                    <div class="caixa-texto-projeto">
                    </div>
                </div>


                <div class="projetos-card">
                    <img src="https://v0-instituto-busca-longe-website.vercel.app/science-fair.png" width=100%
                        height=100%>
                    <div class="caixa-texto-projeto">
                    </div>
                </div>
            </div>
        </section>
        <hr>

        <footer>
            <div class="logo">Istituto Busca Longe</div>
            <p class="pf">Transformando vidas através de atividades e eventos<br> que promovem desenvolvimento social e
                comunitário.</p>
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