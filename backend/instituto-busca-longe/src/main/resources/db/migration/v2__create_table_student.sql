CREATE TABLE student (
  ra INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthdate VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  name_daddy VARCHAR(100) NOT NULL,
  name_mom VARCHAR(50) NOT NULL,
  contact VARCHAR(13) NOT NULL,
  auth_id UNIQUEIDENTIFIER NOT NULL,
  active bit NOT NULL CONSTRAINT df_student_active DEFAULT 1
  FOREIGN KEY (auth_id) REFERENCES auth(id_user)
);