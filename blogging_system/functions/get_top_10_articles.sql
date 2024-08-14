CREATE OR REPLACE FUNCTION BLOGGING_SYSTEM.get_top_10_articles (
	category_id NUMBER DEFAULT NULL
	)
RETURN SYS_REFCURSOR
IS
	top_10_articles SYS_REFCURSOR;
BEGIN
	IF category_id IS NULL
	THEN
		OPEN top_10_articles FOR
			SELECT article_id, (article_likes - article_dislikes) AS article_rating
			FROM ARTICLES
			ORDER BY article_rating DESC
			FETCH FIRST 10 ROWS ONLY;
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20105,
		'Error selected top 10 articles:' || SQLERRM);
END get_top_10_articles;
/