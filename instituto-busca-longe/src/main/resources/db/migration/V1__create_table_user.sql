CREATE TABLE auth (
  id_user       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
  first_name    VARCHAR(45) NOT NULL,
  last_name     VARCHAR(45) NOT NULL,
  email         VARCHAR(60) NOT NULL UNIQUE,
  password_user VARCHAR(255) NOT NULL,
  active        bit NOT NULL CONSTRAINT df_auth_active DEFAULT 1,
  name_role     VARCHAR(10) NOT NULL,
  created_at    DATETIME DEFAULT GETDATE()
);