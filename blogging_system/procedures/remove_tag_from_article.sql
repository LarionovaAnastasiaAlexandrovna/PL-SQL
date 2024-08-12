CREATE OR REPLACE PROCEDURE remove_tag_from_article (
	p_article_id NUMBER
	)
IS
BEGIN
	DELETE FROM Article_Tags
	WHERE article_id = p_article_id;
EXCEPTION
	WHEN OTHERS THEN 
		RAISE_APPLICATION_ERROR(-20008, 'Error deleting an article tag:' || SQLERRM);
END remove_tag_from_article;
/