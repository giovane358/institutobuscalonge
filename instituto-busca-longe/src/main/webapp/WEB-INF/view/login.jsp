<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>Login</title>
  </head>

  <body>
    <h2>Login</h2>
    <form id="formLogin">
      <input type="email" id="email" placeholder="Email" required />
      <input type="password" id="password" placeholder="Senha" required />
      <button type="submit">Entrar</button>
    </form>

    <script src="${pageContext.request.contextPath}/js/auth.js"></script>
  </body>

  </html>