CREATE OR REPLACE PROCEDURE delete_article (
   p_article_id NUMBER
)
AS
BEGIN
   DELETE FROM ARTICLES 
   WHERE article_id = p_article_id;
EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20003, 'Ошибка удаления статьи: ' || SQLERRM);
END;
/