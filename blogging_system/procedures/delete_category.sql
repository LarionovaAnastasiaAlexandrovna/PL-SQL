CREATE OR REPLACE PROCEDURE delete_category (
	p_category_id NUMBER
	)
IS
BEGIN
	DELETE FROM CATEGORIES 
	WHERE category_id = p_category_id;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20010, 'Error deleting a category:' || SQLERRM);
END delete_category;
/