<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>Register</title>
  </head>

  <body>
    <h2>Register</h2>
    <form id="formRegister">
      <input type="text" id="firstName" placeholder="Primeiro Nome" required />
      <input type="text" id="lastName" placeholder="Ultimo Nome" required />
      <input type="email" id="email" placeholder="Email" required />
      <input type="password" id="password" placeholder="Senha" required />
      <input type="text" id="role" placeholder="role" required />
      <button type="submit">Registrar</button>
    </form>

    <script src="${pageContext.request.contextPath}/js/register.js"></script>
  </body>

  </html>