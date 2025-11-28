CREATE TABLE class_room (
  id INT IDENTITY(1,1) PRIMARY KEY,
  title VARCHAR(255),
  description VARCHAR(1000),
  capacity INT,
  duration INT,
  address VARCHAR(255),
  level VARCHAR(50),
  id_user UNIQUEIDENTIFIER NULL,
  instructor_ri INT NULL,
  active BIT NOT NULL DEFAULT 1,
  created_at  DATETIME DEFAULT GETDATE()
);