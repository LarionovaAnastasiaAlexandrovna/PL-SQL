CREATE OR REPLACE PROCEDURE increment_article_views (
	p_article_id NUMBER
	)
IS
	p_current_views NUMBER;
BEGIN
	SELECT views
	INTO p_current_views
	FROM Articles
	WHERE article_id = p_article_id;

	UPDATE Articles 
	SET views = p_current_views + 1
	WHERE article_id = p_article_id;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20013, 
		'Error updating the number of article views:' || SQLERRM);
END increment_article_views;
/