CREATE TABLE auth_role /*criando a tabela de auth_role*/
(
 name_role VARCHAR(10) PRIMARY KEY
); /* Fim da tabela do auth_role*/


CREATE TABLE auth (
  id_user        UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  first_name      VARCHAR(45) NOT NULL,
  last_name      VARCHAR(45) NOT NULL,
  email          VARCHAR(60) NOT NULL UNIQUE,
  password_user  VARCHAR(255) NOT NULL,
  status_user    VARCHAR(10),
  name_role      VARCHAR(10) NOT NULL,
  created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,

);

/* INSERINDO DADO MANUEL NA TABELA auth_role*/
INSERT INTO auth_role(
	name_role
)
VALUES
	('ADMIN'),
	('USER');