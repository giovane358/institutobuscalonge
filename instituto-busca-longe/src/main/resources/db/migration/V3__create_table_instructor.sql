CREATE TABLE instructor(
    ri INT IDENTITY(1,1)  PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(25) NOT NULL,
    contact VARCHAR(13) NOT NULL,
    birthdate VARCHAR(10) NOT NULL,
    auth_id UNIQUEIDENTIFIER NOT NULL,
    active bit NOT NULL CONSTRAINT df_student_active DEFAULT 1,
    updated_at DATETIME DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE()
    FOREIGN KEY (auth_id) REFERENCES auth(id_user)
);