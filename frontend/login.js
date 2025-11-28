   function validar(){
                var email = document.getElementById('email').value;
                var senha = document.getElementById('senha').value;

                if(email == "admin@admin.com" && senha == "claM#123"){
                    alert('sucesso');
                    location.href = "index.html";
                }else{
                    alert('Usuario ou senha incorreto');
                }
            }

            function validarEmail() {
                const email = document.getElementById("email").value;
                const msg = document.getElementById("msgEmail");

                const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (email === "") {
                    msg.textContent = "";
                } else if (!regex.test(email)) {
                    msg.textContent = "E-mail inválido!";
                 } else {
                     msg.textContent = "";
                }
            }

            function validarSenha() {
                const senha = document.getElementById("senha").value;
                const msg = document.getElementById("forcaSenha");

              let forca = 0;

            if (senha.length >= 6) forca++;
            if (/[A-Z]/.test(senha)) forca++;
            if (/[0-9]/.test(senha)) forca++;
            if (/[\W_]/.test(senha)) forca++;

            if (senha === "") {
                msg.textContent = "";
                msg.style.color = "";
            }else if (forca <= 1) {
                msg.textContent = "Senha fraca";
                msg.style.color = "red";
            } else if (forca === 2) {
                msg.textContent = "Senha média";
                msg.style.color = "orange";
            } else if (forca >= 3) {
                msg.textContent = "Senha forte";
                msg.style.color = "green";
            }
        }

      async function logar() {
    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    const url = "http://localhost:8080/auth/login";

    try {
        const resposta = await fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                email: email,
                senha: senha
            }),
            credentials: 'include'
        });

        if (!resposta.ok) {
            alert("Erro " + resposta.status + " - " + resposta.statusText);
            return;
        }

        const dados = await resposta.json();

        if (dados.sucesso === true) {
            alert("Login realizado com sucesso!");
            window.location = "admin.html"; // corrigido "adimn.html"
        } else {
            alert("Usuário ou senha incorretos!");
        }
    } catch (erro) {
        console.error("Erro ao conectar com a API", erro);
        alert("Não foi possível conectar com a API. Verifique o servidor.");
    }
}
