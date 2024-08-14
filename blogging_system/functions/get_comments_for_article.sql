CREATE OR REPLACE FUNCTION BLOGGING_SYSTEM.get_comments_for_article (
	f_article_id NUMBER
	)
RETURN SYS_REFCURSOR
IS
	commens_cursor SYS_REFCURSOR;
BEGIN
	OPEN commens_cursor FOR
		SELECT comment_id
		FROM Comments
		WHERE article_id = f_article_id;

	RETURN commens_cursor;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20103,
		'Error selected comments for an article:' || SQLERRM);
END get_comments_for_article;
/