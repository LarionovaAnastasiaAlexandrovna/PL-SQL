CREATE OR REPLACE PROCEDURE add_tag_to_article (
	p_article_id NUMBER,
	p_tag_id NUMBER
	)
AS
BEGIN
	INSERT INTO Article_Tags (
		article_id,
		tag_id
		)
	VALUES (
		p_article_id,
		p_tag_id
		);
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20007, 'Error adding a tag to an article:' || SQLERRM);
END add_tag_to_article;
/