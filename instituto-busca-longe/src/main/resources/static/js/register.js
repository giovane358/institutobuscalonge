
document.getElementById('formRegister').addEventListener('submit', async (e) => {
  e.preventDefault();


  const payload = {
    firstName: document.getElementById('firstName').value,
    lastName: document.getElementById('lastName').value,
    email: document.getElementById('email').value,
    password: document.getElementById('password').value,
    role: document.getElementById('role').value,
  };

  try {
    const res = await fetch('/auth/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    if (!res.ok) {
      const text = await res.text();
      alert('Erro: ' + res.status + ' - ' + text);
      return;
    }
    
    alert('Registro OK');
    window.location.href = '/login';

  } catch (err) {
    console.error(err);
    alert('Erro ao conectar com o servidor');
  }
});