CREATE OR REPLACE FUNCTION BLOGGING_SYSTEM.get_article_status (
	f_article_id NUMBER
	)
RETURN VARCHAR2
IS
	f_status VARCHAR2(50);
BEGIN
	SELECT status
	INTO f_status
	FROM Articles
	WHERE article_id = f_article_id;

	RETURN f_status;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20102,
		'Error checking article_status by article_id:' || SQLERRM);
END get_article_status;
/