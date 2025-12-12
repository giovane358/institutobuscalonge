// Sistema de Login
document.getElementById('formLogin').addEventListener('submit', async (e) => {
  e.preventDefault();

  const payload = {
    email: document.getElementById('email').value,
    password: document.getElementById('password').value
  };

  try {
    const res = await fetch('/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    if (!res.ok) {
      const text = await res.text();
      alert('Erro: ' + res.status + ' - ' + text);
      return;
    }

    const data = await res.json(); // espera LoginDTO { token: "..." }
    // salvar token (teste)
    localStorage.setItem('token', data.token);
    alert('Login OK');
    window.location.href = '/dashboard';

  } catch (err) {
    console.error(err);
    alert('Erro ao conectar com o servidor');
  }
});
