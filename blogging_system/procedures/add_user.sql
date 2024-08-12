CREATE OR REPLACE PROCEDURE add_user (
   p_user_id NUMBER,
   p_username VARCHAR2,
   p_real_name VARCHAR2 DEFAULT NULL,
   p_email VARCHAR2,
   p_hash_password VARCHAR2,
   p_profile_picture BLOB DEFAULT NULL,
   p_bio VARCHAR2 DEFAULT NULL,
   p_user_role VARCHAR2,
   p_sex CHAR,
   p_birth_date DATE DEFAULT NULL
   )
IS
BEGIN
   INSERT INTO Users (
      user_id, 
      username, 
      real_name, 
      email, 
      hash_password, 
      profile_picture, 
      bio, 
      user_role, 
      sex, 
      birth_date
      )
   VALUES (
      p_user_id,
      p_username,
      p_real_name,
      p_email,
      p_hash_password,
      p_profile_picture,
      p_bio,
      p_user_role,
      p_sex,
      p_birth_date
      );
EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Error adding a new user: ' || SQLERRM);
END add_user;
/