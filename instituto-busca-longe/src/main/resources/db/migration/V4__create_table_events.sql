CREATE TABLE events(
	id          INT PRIMARY KEY,
	title       VARCHAR(45) NOT NULL,
	description VARCHAR(45) NOT NULL,
	data        VARCHAR(10) NOT NULL,
	houres      VARCHAR(5) NOT NULL,
	address     VARCHAR(100) NOT NULL,
	auth_id     UNIQUEIDENTIFIER NOT NULL,
    active      BIT NOT NULL DEFAULT 1,
    created_at  DATETIME DEFAULT GETDATE()

);