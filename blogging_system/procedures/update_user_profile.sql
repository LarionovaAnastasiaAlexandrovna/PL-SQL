CREATE OR REPLACE PROCEDURE update_user_profile (
   p_user_id NUMBER,
   p_real_name VARCHAR2 DEFAULT NULL,
   p_email VARCHAR2 DEFAULT NULL,
   p_profile_picture BLOB DEFAULT NULL,
   p_bio VARCHAR2 DEFAULT NULL,
   p_sex CHAR DEFAULT NULL,
   p_birth_date DATE DEFAULT NULL
)
AS
   v_sql VARCHAR2(1000);
   v_first_field BOOLEAN := TRUE;
BEGIN
   v_sql := 'UPDATE Users SET ';

   IF p_real_name IS NOT NULL 
   THEN
      v_sql := v_sql || 'real_name = :real_name';
      v_first_field := FALSE;
   END IF;

   IF p_email IS NOT NULL 
   THEN
      IF NOT v_first_field 
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'email = :email';
      v_first_field := FALSE;
   END IF;

   IF p_profile_picture IS NOT NULL 
   THEN
      IF NOT v_first_field 
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'profile_picture = :profile_picture';
      v_first_field := FALSE;
   END IF;

   IF p_bio IS NOT NULL 
   THEN
      IF NOT v_first_field 
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'bio = :bio';
      v_first_field := FALSE;
   END IF;

   IF p_sex IS NOT NULL 
   THEN
      IF NOT v_first_field 
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'sex = :sex';
      v_first_field := FALSE;
   END IF;

   IF p_birth_date IS NOT NULL 
   THEN
      IF NOT v_first_field 
      THEN
         v_sql := v_sql || ', ';
      END IF;
      v_sql := v_sql || 'birth_date = :birth_date';
   END IF;

   v_sql := v_sql || ' WHERE user_id = :user_id';

   EXECUTE IMMEDIATE v_sql
   USING p_real_name, p_email, p_profile_picture, p_bio, p_sex, p_birth_date, p_user_id;
   
EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Ошибка обновления профиля пользователя: ' || SQLERRM);
END;
/