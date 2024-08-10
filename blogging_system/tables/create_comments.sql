CREATE TABLE Comments (
	comment_id NUMBER PRIMARY KEY NOT NULL,
	user_id NUMBER NOT NULL,
	article_id NUMBER NOT NULL,
	comment_text CLOB,
	comment_date DATE DEFAULT SYSDATE,
	parent_comment NUMBER,
	comment_likes NUMBER DEFAULT 0,
	comment_dislikes NUMBER DEFAULT 0,
	--CONSTRAINT fk_user_id_comments FOREIGN KEY (user_id)
	--REFERENCES Users(user_id),
	CONSTRAINT fk_article_id FOREIGN KEY (article_id)
	REFERENCES Articles(article_id)
);
