<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <!DOCTYPE html>
  <html lang="pt-br">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <title>Login</title>
  </head>

  <body>
    <main class="container">
      <form id="formLogin">
        <h2>Login </h2>
        <div class="input-box">
          <input placeholder="Usuario" type="email" id="email" />
          <p id="msgEmail" style="color:red; font-size:14px;"></p>
          <i class="bx bxs-user"></i>
        </div>
        <div class="input-box">
          <input placeholder="Senha" type="password" id="password" />
          <p id="forcaSenha" style="font-size:14px;"></p>
          <p id="msg"></p>
          <i class="bx bxs-lock-alt"></i>
        </div>
        <div class="remenber-forgot">
          <label>
            <input type="checkbox">
            Lembrar Senha
          </label>
          <a href="#">Esqueci a senha</a>
        </div>
        <button type="submit" class="login">Login</button>
        <div class="register-link">
          <p>Não tem uma conta? <a href="#">CADASTRE-SE</a></p>
        </div>
      </form>
    </main>
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
  </body>

  </html>