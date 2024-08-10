CREATE TABLE Article_Tags (
	article_id NUMBER NOT NULL,
	tag_id NUMBER NOT NULL,
	CONSTRAINT fk_article_id_link FOREIGN KEY (article_id)
	REFERENCES Articles(article_id),
	CONSTRAINT fk_tag_id_link FOREIGN KEY (tag_id)
	REFERENCES Tags(tag_id)
);
