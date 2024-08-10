CREATE OR REPLACE PROCEDURE add_article (
	p_article_id NUMBER,
	p_author_id NUMBER,
	p_category_id NUMBER,
	p_title VARCHAR2,
	p_content CLOB,
	p_introduction VARCHAR2 DEFAULT NULL,
	p_status VARCHAR2,
	p_image_url VARCHAR2 DEFAULT NULL,
	p_time_to_read_in_minutes NUMBER
	)
AS
BEGIN
	INSERT INTO Articles (
      article_id, 
      author_id, 
      category_id, 
      title, 
      content, 
      introduction, 
      status, 
      image_url, 
      time_to_read_in_minutes
      )
   VALUES (
      p_article_id, 
      p_author_id, 
      p_category_id, 
      p_title, 
      p_content, 
      p_introduction, 
      p_status, 
      p_image_url, 
      p_time_to_read_in_minutes
      );
EXCEPTION
	WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Ошибка добавления новой статьи: ' || SQLERRM);
END;
/