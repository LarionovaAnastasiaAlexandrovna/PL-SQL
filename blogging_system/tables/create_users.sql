CREATE TABLE Users (
	user_id NUMBER PRIMARY KEY NOT NULL,
	username VARCHAR2(100) UNIQUE NOT NULL,
	real_name VARCHAR2(200),
	email VARCHAR2(100) UNIQUE NOT NULL CHECK (email LIKE '%@%' AND LENGTH(email) - LENGTH(REPLACE(email, '@', '')) = 1),
	hash_password VARCHAR2(255) NOT NULL,
	registration_date DATE DEFAULT SYSDATE,
	profile_picture BLOB,
	bio VARCHAR2(2000),
	user_role VARCHAR2(50) NOT NULL,
	sex CHAR(1),
	birth_date DATE,
	user_rating NUMBER DEFAULT 0
);