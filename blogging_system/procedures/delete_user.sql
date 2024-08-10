CREATE OR REPLACE PROCEDURE delete_user (
   p_user_id NUMBER
)
AS
BEGIN
   DELETE FROM Users
   WHERE user_id = p_user_id;

EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20003, 'Ошибка удаления пользователя: ' || SQLERRM);
END;
/