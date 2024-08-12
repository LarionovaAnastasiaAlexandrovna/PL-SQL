CREATE OR REPLACE PROCEDURE add_comment (
	p_comment_id NUMBER,
	p_user_id NUMBER,
	p_article_id NUMBER,
	p_comment_text CLOB,
	p_parent_comment NUMBER DEFAULT NULL
	)
AS
BEGIN
	INSERT INTO Comments (
		comment_id,
		user_id,
		article_id,
		comment_text,
		parent_comment
		) 
	VALUES (
		p_comment_id,
		p_user_id,
		p_article_id,
		p_comment_text,
		p_parent_comment
		);
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20005, 'Error adding a new comment: ' || SQLERRM);
END add_comment;
/