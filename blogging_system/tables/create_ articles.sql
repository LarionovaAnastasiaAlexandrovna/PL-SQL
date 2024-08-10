CREATE TABLE Articles (
	article_id NUMBER PRIMARY KEY NOT NULL,
	author_id NUMBER NOT NULL,
	category_id NUMBER NOT NULL,
	title VARCHAR2(200) NOT NULL,
	content CLOB NOT NULL,
	introduction VARCHAR2(1000),
	creation_date DATE DEFAULT SYSDATE,
	last_updated DATE DEFAULT SYSDATE,
	status VARCHAR2(50) NOT NULL,
	views NUMBER DEFAULT 0,
	image_url VARCHAR2(255),
	time_to_read_in_minutes NUMBER,
	article_likes NUMBER DEFAULT 0,
	article_dislikes NUMBER DEFAULT 0,
	CONSTRAINT fk_author_id FOREIGN KEY (author_id)
	REFERENCES Authors(author_id),
	CONSTRAINT fk_category_id FOREIGN KEY (category_id)
	REFERENCES Categories(category_id)
);
