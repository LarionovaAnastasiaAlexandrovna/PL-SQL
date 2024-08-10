CREATE TABLE Categories (
	category_id NUMBER PRIMARY KEY NOT NULL,
	category_name VARCHAR2(100) NOT NULL,
	category_description VARCHAR2(500),
	parent_category_id NUMBER
);