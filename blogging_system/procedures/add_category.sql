CREATE OR REPLACE PROCEDURE add_category (
	p_category_id NUMBER,
	p_category_name VARCHAR2,
	p_category_description VARCHAR2 DEFAULT NULL,
	p_parent_category_id NUMBER DEFAULT NULL
	)
IS
BEGIN
	INSERT INTO Categories(
		category_id,
		category_name,
		category_description,
		parent_category_id
		)
	VALUES (
		p_category_id,
		p_category_name,
		p_category_description,
		p_parent_category_id
		);
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20009, 'Error adding a new category:' || SQLERRM);
END add_category;
/