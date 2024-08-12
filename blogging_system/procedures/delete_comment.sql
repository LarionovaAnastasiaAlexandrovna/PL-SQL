CREATE OR REPLACE PROCEDURE delete_comment (
	p_comment_id NUMBER 
	)
IS
BEGIN
	DELETE FROM Comments
	WHERE comment_id = p_comment_id;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20006, 'Error deleting a comment: ' || SQLERRM);
END delete_comment;
/