CREATE OR REPLACE FUNCTION BLOGGING_SYSTEM.is_user_author (
	f_user_id NUMBER
	)
RETURN BOOLEAN
IS
	f_author_id NUMBER := NULL;
BEGIN
	SELECT author_id
	INTO f_author_id
	FROM Authors
	WHERE user_id = f_user_id;

	IF f_author_id IS NOT NULL
	THEN RETURN TRUE;
	ELSE RETURN FALSE;
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20100,
		'Error checking whether this user is the author:' || SQLERRM);
END is_user_author;
/