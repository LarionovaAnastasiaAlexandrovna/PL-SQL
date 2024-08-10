CREATE TABLE Authors (
	author_id NUMBER PRIMARY KEY NOT NULL,
	user_id NUMBER NOT NULL,
	creation_date DATE DEFAULT SYSDATE,
	CONSTRAINT fk_user_id FOREIGN KEY (user_id)
	REFERENCES Users(user_id)
);