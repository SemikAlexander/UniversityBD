/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : PostgreSQL
 Source Server Version : 90612
 Source Host           : localhost:5432
 Source Catalog        : university
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90612
 File Encoding         : 65001

 Date: 27/03/2019 16:36:38
*/


-- ----------------------------
-- Sequence structure for classroom_ID_CLASSROOM_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."classroom_ID_CLASSROOM_seq";
CREATE SEQUENCE "public"."classroom_ID_CLASSROOM_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for department_ID_DEPARTMENT_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."department_ID_DEPARTMENT_seq";
CREATE SEQUENCE "public"."department_ID_DEPARTMENT_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for discipline_ID_DISCIPLINE_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."discipline_ID_DISCIPLINE_seq";
CREATE SEQUENCE "public"."discipline_ID_DISCIPLINE_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for faculty_ID_FACULTY_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."faculty_ID_FACULTY_seq";
CREATE SEQUENCE "public"."faculty_ID_FACULTY_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for groups_ID_GROUP_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."groups_ID_GROUP_seq";
CREATE SEQUENCE "public"."groups_ID_GROUP_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for position_ID_POSITION_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."position_ID_POSITION_seq";
CREATE SEQUENCE "public"."position_ID_POSITION_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for specialty_ID_SPECIALTY_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."specialty_ID_SPECIALTY_seq";
CREATE SEQUENCE "public"."specialty_ID_SPECIALTY_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for stadyingPlan_ID_SETTING_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."stadyingPlan_ID_SETTING_seq";
CREATE SEQUENCE "public"."stadyingPlan_ID_SETTING_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for teachers_ID_TEACHER_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."teachers_ID_TEACHER_seq";
CREATE SEQUENCE "public"."teachers_ID_TEACHER_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for timeTable_ID_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."timeTable_ID_seq";
CREATE SEQUENCE "public"."timeTable_ID_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for typeSubject_ID_SUBJECT_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."typeSubject_ID_SUBJECT_seq";
CREATE SEQUENCE "public"."typeSubject_ID_SUBJECT_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for week_ID_DAY_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."week_ID_DAY_seq";
CREATE SEQUENCE "public"."week_ID_DAY_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for Spec_discipline
-- ----------------------------
DROP TABLE IF EXISTS "public"."Spec_discipline";
CREATE TABLE "public"."Spec_discipline" (
  "id_discipline" int4 NOT NULL,
  "id_department" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS "public"."classroom";
CREATE TABLE "public"."classroom" (
  "ID_CLASSROOM" int4 NOT NULL DEFAULT nextval('"classroom_ID_CLASSROOM_seq"'::regclass),
  "Housing" int4 NOT NULL,
  "Num_Classroom" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS "public"."department";
CREATE TABLE "public"."department" (
  "ID_DEPARTMENT" int4 NOT NULL DEFAULT nextval('"department_ID_DEPARTMENT_seq"'::regclass),
  "id_faculty" int4 NOT NULL,
  "Name_Department" text COLLATE "pg_catalog"."default" NOT NULL,
  "Logo_Department" text COLLATE "pg_catalog"."default",
  "id_classrooms" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for discipline
-- ----------------------------
DROP TABLE IF EXISTS "public"."discipline";
CREATE TABLE "public"."discipline" (
  "ID_DISCIPLINE" int4 NOT NULL DEFAULT nextval('"discipline_ID_DISCIPLINE_seq"'::regclass),
  "Name_Discipline" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for faculty
-- ----------------------------
DROP TABLE IF EXISTS "public"."faculty";
CREATE TABLE "public"."faculty" (
  "ID_FACULTY" int4 NOT NULL DEFAULT nextval('"faculty_ID_FACULTY_seq"'::regclass),
  "Name_Faculty" text COLLATE "pg_catalog"."default" NOT NULL,
  "Logo_Faculty" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS "public"."groups";
CREATE TABLE "public"."groups" (
  "ID_GROUP" int4 NOT NULL DEFAULT nextval('"groups_ID_GROUP_seq"'::regclass),
  "id_specialty" int4 NOT NULL,
  "Year_Of_Entry" int4 NOT NULL,
  "Sub_Name_Group" char(1) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for helpDiscip
-- ----------------------------
DROP TABLE IF EXISTS "public"."helpDiscip";
CREATE TABLE "public"."helpDiscip" (
  "id_teacher" int4 NOT NULL,
  "id_discipline" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for para
-- ----------------------------
DROP TABLE IF EXISTS "public"."para";
CREATE TABLE "public"."para" (
  "id_group" int4 NOT NULL,
  "id_lesson" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS "public"."position";
CREATE TABLE "public"."position" (
  "ID_POSITION" int4 NOT NULL DEFAULT nextval('"position_ID_POSITION_seq"'::regclass),
  "Name_Position" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for specialty
-- ----------------------------
DROP TABLE IF EXISTS "public"."specialty";
CREATE TABLE "public"."specialty" (
  "ID_SPECIALTY" int4 NOT NULL DEFAULT nextval('"specialty_ID_SPECIALTY_seq"'::regclass),
  "id_department" int4 NOT NULL,
  "Cipher_Specialty" text COLLATE "pg_catalog"."default" NOT NULL,
  "Name_Specialty" text COLLATE "pg_catalog"."default" NOT NULL,
  "Abbreviation_Specialty" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for stadyingPlan
-- ----------------------------
DROP TABLE IF EXISTS "public"."stadyingPlan";
CREATE TABLE "public"."stadyingPlan" (
  "ID_SETTING" int4 NOT NULL DEFAULT nextval('"stadyingPlan_ID_SETTING_seq"'::regclass),
  "id_group" int4 NOT NULL,
  "DateStartStuding" date NOT NULL,
  "DateEndStuding" date NOT NULL,
  "DateStartSession" date NOT NULL,
  "DateEndSession" date NOT NULL
)
;

-- ----------------------------
-- Table structure for subjectPay
-- ----------------------------
DROP TABLE IF EXISTS "public"."subjectPay";
CREATE TABLE "public"."subjectPay" (
  "id_teacher" int4 NOT NULL,
  "type_pay" int4 NOT NULL,
  "id_subject" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."subjectPay"."type_pay" IS '0 - ставка, 1 -почасовка, 2 - замена';

-- ----------------------------
-- Table structure for teachers
-- ----------------------------
DROP TABLE IF EXISTS "public"."teachers";
CREATE TABLE "public"."teachers" (
  "ID_TEACHER" int4 NOT NULL DEFAULT nextval('"teachers_ID_TEACHER_seq"'::regclass),
  "Name_Teacher" text COLLATE "pg_catalog"."default" NOT NULL,
  "id_position" int4 NOT NULL,
  "id_department" int4 NOT NULL,
  "Email" text COLLATE "pg_catalog"."default" NOT NULL,
  "Rate" float4 NOT NULL,
  "Hourly_Payment" float4 NOT NULL
)
;

-- ----------------------------
-- Table structure for timeTable
-- ----------------------------
DROP TABLE IF EXISTS "public"."timeTable";
CREATE TABLE "public"."timeTable" (
  "ID" int4 NOT NULL DEFAULT nextval('"timeTable_ID_seq"'::regclass),
  "id_classroom" int4 NOT NULL,
  "num_lesson" int4,
  "type_subject" int4 NOT NULL,
  "id_type_week" int4 NOT NULL,
  "Date" date,
  "Time" time(6)
)
;

-- ----------------------------
-- Table structure for transfers
-- ----------------------------
DROP TABLE IF EXISTS "public"."transfers";
CREATE TABLE "public"."transfers" (
  "id_lesson" int4 NOT NULL,
  "date_from" date NOT NULL,
  "date_to" date NOT NULL,
  "num_lesson_to" int4 NOT NULL
)
;

-- ----------------------------
-- Table structure for typeSubject
-- ----------------------------
DROP TABLE IF EXISTS "public"."typeSubject";
CREATE TABLE "public"."typeSubject" (
  "ID_SUBJECT" int4 NOT NULL DEFAULT nextval('"typeSubject_ID_SUBJECT_seq"'::regclass),
  "Name_Subject" text COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."typeSubject"."Name_Subject" IS 'Тип предмета (лекция, проработка, семинар, консультация, экзамен, зачёт)';

-- ----------------------------
-- Table structure for week
-- ----------------------------
DROP TABLE IF EXISTS "public"."week";
CREATE TABLE "public"."week" (
  "ID_DAY" int4 NOT NULL DEFAULT nextval('"week_ID_DAY_seq"'::regclass),
  "NameDay" text COLLATE "pg_catalog"."default" NOT NULL,
  "TypeWeek" char(1) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."week"."TypeWeek" IS 'Тип недели (V - верхняя N - нижняя неделя)';

-- ----------------------------
-- Function structure for GetAllDepartmentNames
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."GetAllDepartmentNames"("namefaculty" text);
CREATE OR REPLACE FUNCTION "public"."GetAllDepartmentNames"("namefaculty" text)
  RETURNS TABLE("Name_Department" text) AS $BODY$BEGIN
				
			RETURN QUERY	SELECT department."Name_Department" FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for GetAllSpeciality
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."GetAllSpeciality"("namefaculty" text, "NameDepartment" text, "startrow" int4, "countrow" int4);
CREATE OR REPLACE FUNCTION "public"."GetAllSpeciality"("namefaculty" text, "NameDepartment" text, "startrow" int4, "countrow" int4)
  RETURNS TABLE("Abbreviation_Specialty" text, "Cipher_Specialty" text, "Name_Specialty" text) AS $BODY$BEGIN
				
RETURN QUERY	SELECT specialty."Abbreviation_Specialty",specialty."Cipher_Specialty",specialty."Name_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"="namefaculty" LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"="NameDepartment") as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" LIMIT countrow OFFSET startrow;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for GetAllSpecialityNames
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."GetAllSpecialityNames"("namefaculty" text, "NameDepartment" text);
CREATE OR REPLACE FUNCTION "public"."GetAllSpecialityNames"("namefaculty" text, "NameDepartment" text)
  RETURNS TABLE("Name_Specialty" text) AS $BODY$BEGIN
				
			RETURN QUERY	SELECT specialty."Abbreviation_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=NameDepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for GetDepartmentFull
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."GetDepartmentFull"("namefaculty" text, "startrow" int4, "countrow" int4);
CREATE OR REPLACE FUNCTION "public"."GetDepartmentFull"("namefaculty" text, "startrow" int4, "countrow" int4)
  RETURNS TABLE("Name_Department" text, "Logo_Department" text, "Housing" int4, "Num_Classroom" int4) AS $BODY$BEGIN
				
			RETURN QUERY	SELECT department."Name_Department",department."Logo_Department",classroom."Housing",classroom."Num_Classroom" FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms LIMIT countrow OFFSET startrow;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for classroom_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_add"("housing" int4, "num_classroom" int4);
CREATE OR REPLACE FUNCTION "public"."classroom_add"("housing" int4, "num_classroom" int4)
  RETURNS "pg_catalog"."text" AS $BODY$
BEGIN
	 	IF EXISTS(SELECT FROM "public".classroom WHERE "public".classroom."Housing"=Housing AND "public".classroom."Num_Classroom"=Num_Classroom) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO classroom ("Housing","Num_Classroom") VALUES(Housing,Num_Classroom);	
		RETURN 'Success';
	END IF;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for classroom_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."classroom_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM classroom WHERE "ID_CLASSROOM"=id;
		RETURN 'Success';

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for classroom_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_get_all"("start_row" int4, "count_rows" int4, "number_korpus" int4);
CREATE OR REPLACE FUNCTION "public"."classroom_get_all"("start_row" int4, "count_rows" int4, "number_korpus" int4)
  RETURNS TABLE("id" int4, "house" int4, "number_kab" int4) AS $BODY$
	BEGIN
	RETURN QUERY SELECT * FROM classroom WHERE "Housing"=number_korpus ORDER BY "ID_CLASSROOM" ASC LIMIT count_rows OFFSET start_row ;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for classroom_get_housing
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_get_housing"();
CREATE OR REPLACE FUNCTION "public"."classroom_get_housing"()
  RETURNS TABLE("housing" int4) AS $BODY$BEGIN
	-- Routine body goes here...
	RETURN QUERY SELECT "Housing" FROM classroom GROUP BY "Housing";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for department_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."department_add"("namefaculty" text, "logo" text, "NameDepartment" text, "housing" int4, "NumClassroom" int4);
CREATE OR REPLACE FUNCTION "public"."department_add"("namefaculty" text, "logo" text, "NameDepartment" text, "housing" int4, "NumClassroom" int4)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDCLASSROOM INTEGER :=0;
	IDFACULTY INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN "Факультет не найден";
END IF;
SELECT "ID_CLASSROOM" FROM classroom INTO IDCLASSROOM WHERE "Housing"=housing and "Num_Classroom"=NumClassroom LIMIT 1;
IF NOT FOUND THEN
    RETURN "Класс не найден";
END IF;

SELECT * From department WHERE  department."Name_Department"=NameDepartment and IDFACULTY=department.id_faculty;
IF FOUND THEN
    RETURN "Кафедра существует";
END IF;
			INSERT INTO department(department."Logo_Department",department."Name_Department",department.id_classrooms,department.id_faculty) VALUES(logo,NameFaculty,IDCLASSROOM,IDFACULTY);
			RETURN "Success";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for department_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."department_delete"("facultyname" text, "departmentname" text);
CREATE OR REPLACE FUNCTION "public"."department_delete"("facultyname" text, "departmentname" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE 
	id_fac INTEGER :=0;
	BEGIN
		SELECT faculty."ID_FACULTY" FROM faculty INTO id_fac WHERE faculty."Name_Faculty"=facultyName LIMIT 1;
		IF NOT FOUND THEN
				RETURN 'Факультет не найден';
		END IF;
	 DELETE FROM department WHERE department."Name_Department"=departmentName and department.id_faculty = id_fac;
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for discipline_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."discipline_add"("name_discipline" text, "namefacul" text, "NameDepartment" text);
CREATE OR REPLACE FUNCTION "public"."discipline_add"("name_discipline" text, "namefacul" text, "NameDepartment" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	id_dep INTEGER :=0;
	id_disc INTEGER :=0;
	BEGIN 
	SELECT discipline."ID_DISCIPLINE", discipline."Name_Discipline" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefacul LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=NameDepartment INTO id_dep) as dep INNER JOIN  "Spec_discipline" on "Spec_discipline".id_department= dep."ID_DEPARTMENT" INNER JOIN discipline on discipline."ID_DISCIPLINE"="Spec_discipline".id_discipline WHERE discipline."Name_Discipline"=name_discipline;
	IF FOUND THEN
		RETURN 'Запись уже существует';
	END IF;
	INSERT INTO discipline(discipline."Name_Discipline") VALUES (name_discipline);
	  SELECT currval(pg_get_serial_sequence('discipline','ID_DISCIPLINE')) INTO id_disc;
	
		INSERT INTO "Spec_discipline" VALUES (id_disc,id_dep);
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for discipline_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."discipline_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."discipline_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM discipline WHERE "ID_DISCIPLINE"=id;
	 DELETE FROM "Spec_discipline" WHERE "Spec_discipline".id_discipline=id;
		RETURN 'Success';

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for discipline_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."discipline_get_all"("namefaculty" text, "department" text, "start_row" int4, "count_rows" int4);
CREATE OR REPLACE FUNCTION "public"."discipline_get_all"("namefaculty" text, "department" text, "start_row" int4, "count_rows" int4)
  RETURNS TABLE("id" int4, "name" text) AS $BODY$BEGIN
	RETURN QUERY SELECT discipline."ID_DISCIPLINE", discipline."Name_Discipline" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=department) as dep INNER JOIN  "Spec_discipline" on "Spec_discipline".id_department= dep."ID_DEPARTMENT" INNER JOIN discipline on discipline."ID_DISCIPLINE"="Spec_discipline".id_discipline LIMIT count_rows OFFSET start_row;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for faculty_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."faculty_add"("name_faculty" text, "logo" text);
CREATE OR REPLACE FUNCTION "public"."faculty_add"("name_faculty" text, "logo" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM faculty WHERE "Name_Faculty"=name_faculty) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO faculty("Name_Faculty","Logo_Faculty") VALUES(name_faculty,logo);	
		RETURN 'Success';
	END IF;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for faculty_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."faculty_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."faculty_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM faculty WHERE "ID_FACULTY"=id;
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for faculty_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."faculty_get_all"();
CREATE OR REPLACE FUNCTION "public"."faculty_get_all"()
  RETURNS TABLE("id" int4, "name" text, "logo" text) AS $BODY$BEGIN
	RETURN QUERY SELECT * FROM faculty;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for position_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."position_add"("name_position" text);
CREATE OR REPLACE FUNCTION "public"."position_add"("name_position" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM "position" WHERE "Name_Position"=name_position) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "position"("Name_Position") VALUES(name_position);	
		RETURN 'Success';
	END IF;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for position_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."position_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."position_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM "position" WHERE "ID_POSITION"=id;
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for position_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."position_get_all"();
CREATE OR REPLACE FUNCTION "public"."position_get_all"()
  RETURNS TABLE("id" int4, "name" text) AS $BODY$BEGIN
	RETURN QUERY SELECT * FROM "position";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for specialty_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."specialty_add"("namefaculty" text, "NameDepartment" text, "CipherSpecialty" text, "NameSpecialty" text, "AbbreviationSpecialty" text);
CREATE OR REPLACE FUNCTION "public"."specialty_add"("namefaculty" text, "NameDepartment" text, "CipherSpecialty" text, "NameSpecialty" text, "AbbreviationSpecialty" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN "Факультет не найден";
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=NameDepartment and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN "Кафедра не существует";
END IF;

SELECT * From specialty WHERE specialty."Abbreviation_Specialty"=AbbreviationSpecialty or specialty."Cipher_Specialty"=CipherSpecialty or specialty."Name_Specialty"=NameSpecialty or specialty.id_department=IDDEPARTMENT;
IF FOUND THEN
    RETURN "Специальность существует";
END IF;
INSERT INTO specialty (specialty."Abbreviation_Specialty",specialty."Cipher_Specialty",specialty."Name_Specialty",specialty.id_department) VALUES(AbbreviationSpecialty,CipherSpecialty,NameSpecialty,IDDEPARTMENT);
RETURN 'Success';



			RETURN "Success";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for specialty_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."specialty_delete"("namefaculty" text, "department" text, "specialtyABR" text);
CREATE OR REPLACE FUNCTION "public"."specialty_delete"("namefaculty" text, "department" text, "specialtyABR" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	id_depar INTEGER :=0;
	BEGIN
	SELECT department."ID_DEPARTMENT"  FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INTO id_depar LIMIT 1;
	if not FOUND then
	RETURN 'Кафедра не найдена';
	end if;
	DELETE FROM specialty WHERE specialty."Abbreviation_Specialty"=specialtyABR and specialty.id_department=id_depar;
	
	RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for type_subject_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."type_subject_add"("name_Subject" text);
CREATE OR REPLACE FUNCTION "public"."type_subject_add"("name_Subject" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM "typeSubject" WHERE "Name_Subject"=name_Subject) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "typeSubject"("Name_Subject") VALUES(name_Subject);	
		RETURN 'Success';
	END IF;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for type_subject_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."type_subject_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."type_subject_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM "typeSubject" WHERE "ID_SUBJECT"=id;
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for type_subject_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."type_subject_get_all"();
CREATE OR REPLACE FUNCTION "public"."type_subject_get_all"()
  RETURNS TABLE("id" int4, "name" text) AS $BODY$BEGIN
	RETURN QUERY SELECT * FROM "typeSubject";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for week_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."week_add"("name_day" text, "type_week" bpchar);
CREATE OR REPLACE FUNCTION "public"."week_add"("name_day" text, "type_week" bpchar)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM week WHERE week."NameDay"=name_day and week."TypeWeek"=type_week) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO week("NameDay","TypeWeek") VALUES(name_day,type_week);	
		RETURN 'Success';
	END IF;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for week_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."week_delete"("id" int4);
CREATE OR REPLACE FUNCTION "public"."week_delete"("id" int4)
  RETURNS "pg_catalog"."text" AS $BODY$BEGIN
	 DELETE FROM week WHERE week."ID_DAY"=id;
		RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for week_get_all
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."week_get_all"();
CREATE OR REPLACE FUNCTION "public"."week_get_all"()
  RETURNS TABLE("id_w" int4, "name_w" text, "type_w" bpchar) AS $BODY$BEGIN
	
	RETURN QUERY SELECT * FROM week;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."classroom_ID_CLASSROOM_seq"
OWNED BY "public"."classroom"."ID_CLASSROOM";
SELECT setval('"public"."classroom_ID_CLASSROOM_seq"', 2, false);
ALTER SEQUENCE "public"."department_ID_DEPARTMENT_seq"
OWNED BY "public"."department"."ID_DEPARTMENT";
SELECT setval('"public"."department_ID_DEPARTMENT_seq"', 2, false);
ALTER SEQUENCE "public"."discipline_ID_DISCIPLINE_seq"
OWNED BY "public"."discipline"."ID_DISCIPLINE";
SELECT setval('"public"."discipline_ID_DISCIPLINE_seq"', 2, false);
ALTER SEQUENCE "public"."faculty_ID_FACULTY_seq"
OWNED BY "public"."faculty"."ID_FACULTY";
SELECT setval('"public"."faculty_ID_FACULTY_seq"', 6, true);
ALTER SEQUENCE "public"."groups_ID_GROUP_seq"
OWNED BY "public"."groups"."ID_GROUP";
SELECT setval('"public"."groups_ID_GROUP_seq"', 2, false);
ALTER SEQUENCE "public"."position_ID_POSITION_seq"
OWNED BY "public"."position"."ID_POSITION";
SELECT setval('"public"."position_ID_POSITION_seq"', 2, false);
ALTER SEQUENCE "public"."specialty_ID_SPECIALTY_seq"
OWNED BY "public"."specialty"."ID_SPECIALTY";
SELECT setval('"public"."specialty_ID_SPECIALTY_seq"', 2, false);
ALTER SEQUENCE "public"."stadyingPlan_ID_SETTING_seq"
OWNED BY "public"."stadyingPlan"."ID_SETTING";
SELECT setval('"public"."stadyingPlan_ID_SETTING_seq"', 2, false);
ALTER SEQUENCE "public"."teachers_ID_TEACHER_seq"
OWNED BY "public"."teachers"."ID_TEACHER";
SELECT setval('"public"."teachers_ID_TEACHER_seq"', 2, false);
ALTER SEQUENCE "public"."timeTable_ID_seq"
OWNED BY "public"."timeTable"."ID";
SELECT setval('"public"."timeTable_ID_seq"', 2, false);
ALTER SEQUENCE "public"."typeSubject_ID_SUBJECT_seq"
OWNED BY "public"."typeSubject"."ID_SUBJECT";
SELECT setval('"public"."typeSubject_ID_SUBJECT_seq"', 2, false);
ALTER SEQUENCE "public"."week_ID_DAY_seq"
OWNED BY "public"."week"."ID_DAY";
SELECT setval('"public"."week_ID_DAY_seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table classroom
-- ----------------------------
ALTER TABLE "public"."classroom" ADD CONSTRAINT "Classroom_pkey" PRIMARY KEY ("ID_CLASSROOM");

-- ----------------------------
-- Primary Key structure for table department
-- ----------------------------
ALTER TABLE "public"."department" ADD CONSTRAINT "Department_pkey" PRIMARY KEY ("ID_DEPARTMENT");

-- ----------------------------
-- Primary Key structure for table discipline
-- ----------------------------
ALTER TABLE "public"."discipline" ADD CONSTRAINT "Discipline_pkey" PRIMARY KEY ("ID_DISCIPLINE");

-- ----------------------------
-- Primary Key structure for table faculty
-- ----------------------------
ALTER TABLE "public"."faculty" ADD CONSTRAINT "Faculty_pkey" PRIMARY KEY ("ID_FACULTY");

-- ----------------------------
-- Primary Key structure for table groups
-- ----------------------------
ALTER TABLE "public"."groups" ADD CONSTRAINT "Groups_pkey" PRIMARY KEY ("ID_GROUP");

-- ----------------------------
-- Primary Key structure for table position
-- ----------------------------
ALTER TABLE "public"."position" ADD CONSTRAINT "Position_pkey" PRIMARY KEY ("ID_POSITION");

-- ----------------------------
-- Primary Key structure for table specialty
-- ----------------------------
ALTER TABLE "public"."specialty" ADD CONSTRAINT "Specialty_pkey" PRIMARY KEY ("ID_SPECIALTY");

-- ----------------------------
-- Primary Key structure for table stadyingPlan
-- ----------------------------
ALTER TABLE "public"."stadyingPlan" ADD CONSTRAINT "StadyingPlan_pkey" PRIMARY KEY ("ID_SETTING");

-- ----------------------------
-- Primary Key structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "Teachers_pkey" PRIMARY KEY ("ID_TEACHER");

-- ----------------------------
-- Primary Key structure for table timeTable
-- ----------------------------
ALTER TABLE "public"."timeTable" ADD CONSTRAINT "TimeTable_pkey" PRIMARY KEY ("ID");

-- ----------------------------
-- Primary Key structure for table typeSubject
-- ----------------------------
ALTER TABLE "public"."typeSubject" ADD CONSTRAINT "TypeSubject_pkey" PRIMARY KEY ("ID_SUBJECT");

-- ----------------------------
-- Primary Key structure for table week
-- ----------------------------
ALTER TABLE "public"."week" ADD CONSTRAINT "Week_pkey" PRIMARY KEY ("ID_DAY");

-- ----------------------------
-- Foreign Keys structure for table Spec_discipline
-- ----------------------------
ALTER TABLE "public"."Spec_discipline" ADD CONSTRAINT "fk_Spec_discipline_department_1" FOREIGN KEY ("id_department") REFERENCES "public"."department" ("ID_DEPARTMENT") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."Spec_discipline" ADD CONSTRAINT "fk_Spec_discipline_discipline_1" FOREIGN KEY ("id_discipline") REFERENCES "public"."discipline" ("ID_DISCIPLINE") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table department
-- ----------------------------
ALTER TABLE "public"."department" ADD CONSTRAINT "fk_department_classroom_1" FOREIGN KEY ("id_classrooms") REFERENCES "public"."classroom" ("ID_CLASSROOM") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."department" ADD CONSTRAINT "fk_department_faculty_1" FOREIGN KEY ("id_faculty") REFERENCES "public"."faculty" ("ID_FACULTY") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table groups
-- ----------------------------
ALTER TABLE "public"."groups" ADD CONSTRAINT "fk_groups_specialty_1" FOREIGN KEY ("id_specialty") REFERENCES "public"."specialty" ("ID_SPECIALTY") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table helpDiscip
-- ----------------------------
ALTER TABLE "public"."helpDiscip" ADD CONSTRAINT "fk_helpDiscip_discipline_1" FOREIGN KEY ("id_discipline") REFERENCES "public"."discipline" ("ID_DISCIPLINE") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."helpDiscip" ADD CONSTRAINT "fk_helpDiscip_teachers_1" FOREIGN KEY ("id_teacher") REFERENCES "public"."teachers" ("ID_TEACHER") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table para
-- ----------------------------
ALTER TABLE "public"."para" ADD CONSTRAINT "fk_para_groups_1" FOREIGN KEY ("id_group") REFERENCES "public"."groups" ("ID_GROUP") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."para" ADD CONSTRAINT "fk_para_timeTable_1" FOREIGN KEY ("id_lesson") REFERENCES "public"."timeTable" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table specialty
-- ----------------------------
ALTER TABLE "public"."specialty" ADD CONSTRAINT "fk_specialty_department_1" FOREIGN KEY ("id_department") REFERENCES "public"."department" ("ID_DEPARTMENT") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table stadyingPlan
-- ----------------------------
ALTER TABLE "public"."stadyingPlan" ADD CONSTRAINT "fk_stadyingPlan_groups_1" FOREIGN KEY ("id_group") REFERENCES "public"."groups" ("ID_GROUP") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table subjectPay
-- ----------------------------
ALTER TABLE "public"."subjectPay" ADD CONSTRAINT "fk_subjectPay_teachers_1" FOREIGN KEY ("id_teacher") REFERENCES "public"."teachers" ("ID_TEACHER") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."subjectPay" ADD CONSTRAINT "fk_subjectPay_timeTable_1" FOREIGN KEY ("id_subject") REFERENCES "public"."timeTable" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table teachers
-- ----------------------------
ALTER TABLE "public"."teachers" ADD CONSTRAINT "fk_teachers_department_1" FOREIGN KEY ("id_department") REFERENCES "public"."department" ("ID_DEPARTMENT") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."teachers" ADD CONSTRAINT "fk_teachers_position_1" FOREIGN KEY ("id_position") REFERENCES "public"."position" ("ID_POSITION") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table timeTable
-- ----------------------------
ALTER TABLE "public"."timeTable" ADD CONSTRAINT "fk_timeTable_classroom_1" FOREIGN KEY ("id_classroom") REFERENCES "public"."classroom" ("ID_CLASSROOM") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."timeTable" ADD CONSTRAINT "fk_timeTable_typeSubject_1" FOREIGN KEY ("id_type_week") REFERENCES "public"."typeSubject" ("ID_SUBJECT") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."timeTable" ADD CONSTRAINT "fk_timeTable_week_1" FOREIGN KEY ("id_type_week") REFERENCES "public"."week" ("ID_DAY") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table transfers
-- ----------------------------
ALTER TABLE "public"."transfers" ADD CONSTRAINT "fk_transfers_timeTable_1" FOREIGN KEY ("id_lesson") REFERENCES "public"."timeTable" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;
