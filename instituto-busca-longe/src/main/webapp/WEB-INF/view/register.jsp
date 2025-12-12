<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  </head>

  <body>
    <main class="container">
      <form id="formRegister">
        <h2>Register</h2>
        <div class="input-box">
          <input type="text" id="firstName" placeholder="Primeiro Nome" required />
        </div>
        <div class="input-box">
          <input type="text" id="lastName" placeholder="Ultimo Nome" required />
        </div>
        <div class="input-box">
          <input type="email" id="email" placeholder="Email" required />
        </div>
        <div class="input-box">
          <input type="password" id="password" placeholder="Senha" required />
        </div>
        <div class="input-box">
          <input type="text" id="role" placeholder="role" required />
        </div>
        <button class="login" type="submit">Registrar</button>
      </form>
    </main>
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
  </body>

  </html>