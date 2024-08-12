CREATE OR REPLACE PROCEDURE update_user_rating (
	p_user_id NUMBER,
	p_is_like BOOLEAN
	)
IS
	p_current_rating NUMBER;
	v_sql VARCHAR2(1000) := 'UPDATE USERS SET USER_RATING = p_current_rating ';
BEGIN
	SELECT user_rating
	INTO p_current_rating
	FROM USERS 
	WHERE user_id = p_user_id;

	IF p_is_like 
	THEN v_sql := v_sql || '+ 1';
	ELSE v_sql := v_sql || '- 1';
	END IF;

	v_sql := v_sql || 'WHERE user_id = p_user_id;';
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20014, 
		'Error changing the user rating:' ||SQLERRM);
END update_user_rating;
/