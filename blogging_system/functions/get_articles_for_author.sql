CREATE OR REPLACE FUNCTION get_articles_for_author (
	f_author_id NUMBER
	)
RETURN SYS_REFCURSOR
IS
	articles_cursor SYS_REFCURSOR;
BEGIN
	OPEN articles_cursor FOR
		SELECT article_id
		FROM ARTICLES
		WHERE author_id = f_author_id;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20104,
		'Error selected articles for an author:' || SQLERRM);
END get_articles_for_author;
/