CREATE OR REPLACE FUNCTION BLOGGING_SYSTEM.get_user_rating (
	f_user_id NUMBER
	)
RETURN NUMBER
IS
	f_user_rating NUMBER;
BEGIN
	SELECT user_rating
	INTO f_user_rating
	FROM Users
	WHERE user_id = f_user_id;

	RETURN f_user_rating;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20101,
		'Error checking user_rating by user_id:' || SQLERRM);
END get_user_rating;
/