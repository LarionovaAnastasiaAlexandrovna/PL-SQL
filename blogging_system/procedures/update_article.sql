CREATE OR REPLACE PROCEDURE update_article (
   p_article_id NUMBER,
   p_category_id NUMBER DEFAULT NULL,
   p_title VARCHAR2 DEFAULT NULL,
   p_content CLOB DEFAULT NULL,
   p_introduction VARCHAR2 DEFAULT NULL,
   p_status VARCHAR2 DEFAULT NULL,
   p_image_url VARCHAR2 DEFAULT NULL
   )
AS
   v_changes_made BOOLEAN := FALSE,
   v_sql VARCHAR2(2000) := 'Update Articles SET ';
   
BEGIN
   IF p_category_id IS NOT NULL
   THEN
      v_sql := v_sql || 'category_id = :category_id';
      v_changes_made := TRUE;
   END IF;

   IF p_title IS NOT NULL
   THEN
      IF v_changes_made 
      THEN
           v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'title = :title';
        v_changes_made := TRUE;
   END IF;
   
   IF p_content IS NOT NULL
   THEN
      IF v_changes_made
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'content = :content';
      v_changes_made := TRUE;
   END IF;

   IF p_introduction IS NOT NULL
   THEN
      IF v_changes_made
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'introduction = :introduction';
      v_changes_made := TRUE;
   END IF;

   IF p_status IS NOT NULL
   THEN
      IF v_changes_made
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'status = :status';
      v_changes_made := TRUE;
   END IF;

   IF p_image_url IS NOT NULL
   THEN
      IF v_changes_made
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'image_url = :image_url';
      v_changes_made := TRUE;
   END IF;

   IF v_changes_made 
   THEN 
      v_sql := v_sql || ', last_updated = SYSDATE WHERE article_id = :article_id';
      EXECUTE IMMEDIATE v_sql
         USING p_category_id, p_title, p_content, p_introduction, p_status, p_image_url, p_article_id;

   ELSE 
      RAISE_APPLICATION_ERROR(-20004, 'Нет изменений для обновления.');
   END IF;
   
EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ошибка обновления профиля пользователя: ' || SQLERRM);
END;
/