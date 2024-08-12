CREATE OR REPLACE PROCEDURE update_category (
	p_category_id NUMBER,
	p_category_name VARCHAR2 DEFAULT NULL,
	p_category_description VARCHAR2 DEFAULT NULL,
	p_parent_category_id NUMBER DEFAULT NULL
	)
IS
	is_changed BOOLEAN := FALSE;
	v_sql VARCHAR2(1000) := 'UPDATE Categories SET ';
BEGIN
	IF p_category_name IS NOT NULL
	THEN
		v_sql := v_sql || 'category_name := p_category_name';
		is_changed := TRUE;
	END IF;

	IF p_category_description IS NOT NULL
	THEN
		IF is_changed 
		THEN
			v_sql := v_sql || ', ';
		END IF;
		v_sql := v_sql || 'category_description := p_category_description';
		is_changed := TRUE;
	END IF;

	IF p_parent_category_id IS NOT NULL
	THEN
		IF is_changed 
		THEN
			v_sql := v_sql || ', ';
		END IF;
		v_sql := v_sql || 'parent_category_id := p_parent_category_id';
		is_changed := TRUE;
	END IF;
	
	IF is_changed 
	THEN
		v_sql := v_sql || ' WHERE category_id = p_category_id;';
		EXECUTE IMMEDIATE v_sql
		USING p_category_name, p_category_description, p_parent_category_id, p_category_id;
	ELSE
		RAISE_APPLICATION_ERROR(-20004, 'There are no changes to update.');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20012, 'Error changing the category');
END update_category;
/