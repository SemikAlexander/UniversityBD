/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : PostgreSQL
 Source Server Version : 90612
 Source Host           : localhost:5432
 Source Catalog        : Univer
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90612
 File Encoding         : 65001

 Date: 04/04/2019 15:07:13
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
-- Records of Spec_discipline
-- ----------------------------
INSERT INTO "public"."Spec_discipline" VALUES (16, 49);
INSERT INTO "public"."Spec_discipline" VALUES (17, 49);

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
-- Records of classroom
-- ----------------------------
INSERT INTO "public"."classroom" VALUES (2, 13, 12);
INSERT INTO "public"."classroom" VALUES (3, 3213, 12312);
INSERT INTO "public"."classroom" VALUES (4, 1, 2);
INSERT INTO "public"."classroom" VALUES (8, 1, 5);
INSERT INTO "public"."classroom" VALUES (9, 1, 6);

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
-- Records of department
-- ----------------------------
INSERT INTO "public"."department" VALUES (4, 7, 'Технологии и техники бурения скважин', '', 4);
INSERT INTO "public"."department" VALUES (5, 7, 'Геоинформатики и геодезии', NULL, 3);
INSERT INTO "public"."department" VALUES (7, 7, 'Геологии и разведки месторождений полезных ископаемых', NULL, 3);
INSERT INTO "public"."department" VALUES (8, 7, 'Маркшейдерского дела', NULL, 3);
INSERT INTO "public"."department" VALUES (9, 7, 'Русского языка', NULL, 3);
INSERT INTO "public"."department" VALUES (10, 8, 'Охраны труда и аэрологии', NULL, 3);
INSERT INTO "public"."department" VALUES (11, 8, 'Управления производством им. Ю. В. Бондаренко', NULL, 3);
INSERT INTO "public"."department" VALUES (12, 8, 'Обогащения полезных ископаемых', NULL, 3);
INSERT INTO "public"."department" VALUES (14, 8, 'Строительства зданий, подземных сооружений и геомеханики', NULL, 4);
INSERT INTO "public"."department" VALUES (15, 8, 'Разработки месторождений полезных ископаемых', NULL, 4);
INSERT INTO "public"."department" VALUES (16, 9, 'Механического оборудования заводов черной металлургии', NULL, 4);
INSERT INTO "public"."department" VALUES (17, 9, 'Сопротивления материалов', NULL, 4);
INSERT INTO "public"."department" VALUES (18, 9, 'Начертательной геометрии и инженерной графики', NULL, 4);
INSERT INTO "public"."department" VALUES (19, 9, 'Транспортных систем и логистики имени И. Г. Штокмана', NULL, 4);
INSERT INTO "public"."department" VALUES (20, 9, 'Горных машин', NULL, 4);
INSERT INTO "public"."department" VALUES (22, 9, 'Теоретической механики имени Н. Г. Логвинова', NULL, 2);
INSERT INTO "public"."department" VALUES (23, 9, 'Мехатронных систем машиностроительного оборудования', NULL, 2);
INSERT INTO "public"."department" VALUES (25, 9, 'Основ проектирования машин (секция «Общеинженерные дисциплины», секция «Управление качеством»)', NULL, 2);
INSERT INTO "public"."department" VALUES (26, 9, 'Энергомеханических систем', NULL, 2);
INSERT INTO "public"."department" VALUES (27, 9, 'Технологии машиностроения', NULL, 3);
INSERT INTO "public"."department" VALUES (31, 11, 'Физики', NULL, 3);
INSERT INTO "public"."department" VALUES (33, 11, 'Рудотермических процессов и малоотходных технологий', NULL, 3);
INSERT INTO "public"."department" VALUES (34, 11, 'Технической теплофизики', NULL, 2);
INSERT INTO "public"."department" VALUES (35, 11, 'Обработки металлов давлением', NULL, 3);
INSERT INTO "public"."department" VALUES (37, 11, 'Металлургии стали и сплавов', NULL, 3);
INSERT INTO "public"."department" VALUES (38, 11, 'Промышленной теплоэнергетики', NULL, 3);
INSERT INTO "public"."department" VALUES (39, 11, 'Физического материаловедения', NULL, 3);
INSERT INTO "public"."department" VALUES (40, 12, 'Электроснабжения промышленных предприятий и городов', NULL, 3);
INSERT INTO "public"."department" VALUES (41, 12, 'Электропривода и автоматизации промышленных установок', NULL, 2);
INSERT INTO "public"."department" VALUES (42, 12, 'Электрических систем', NULL, 3);
INSERT INTO "public"."department" VALUES (43, 12, 'Электромеханики и теоретических основ электротехники', NULL, 3);
INSERT INTO "public"."department" VALUES (44, 12, 'Электрических станций', NULL, 3);
INSERT INTO "public"."department" VALUES (45, 12, 'Технического иностранного языка', NULL, 3);
INSERT INTO "public"."department" VALUES (46, 12, 'Систем программного управления и мехатроники', NULL, 3);
INSERT INTO "public"."department" VALUES (47, 13, 'Автоматизированных систем управления', NULL, 4);
INSERT INTO "public"."department" VALUES (49, 13, 'Компьютерной инженерии', NULL, 4);
INSERT INTO "public"."department" VALUES (50, 13, 'Компьютерного моделирования и дизайна', NULL, 4);
INSERT INTO "public"."department" VALUES (51, 13, 'Программной инженерии', NULL, 3);
INSERT INTO "public"."department" VALUES (52, 13, 'Искусственного интеллекта и системного анализа', NULL, 3);
INSERT INTO "public"."department" VALUES (53, 13, 'Прикладной математики', NULL, 3);
INSERT INTO "public"."department" VALUES (54, 13, 'Экономической кибернетики', NULL, 3);
INSERT INTO "public"."department" VALUES (57, 14, 'Высшей математики', NULL, 3);
INSERT INTO "public"."department" VALUES (58, 14, 'Горной электротехники и автоматики', NULL, 3);
INSERT INTO "public"."department" VALUES (59, 14, 'Электронной техники', NULL, 3);
INSERT INTO "public"."department" VALUES (60, 14, 'Автоматики и телекоммуникаций', NULL, 3);
INSERT INTO "public"."department" VALUES (61, 14, 'Радиотехники и защиты информации', NULL, 3);
INSERT INTO "public"."department" VALUES (62, 14, 'Физического воспитания и спорта', NULL, 2);
INSERT INTO "public"."department" VALUES (63, 15, 'Природоохранной деятельности', NULL, 2);
INSERT INTO "public"."department" VALUES (64, 15, 'Физической и органической химии', NULL, 3);
INSERT INTO "public"."department" VALUES (65, 15, 'Общей химии', NULL, 2);
INSERT INTO "public"."department" VALUES (67, 15, 'Химической технологии топлива', NULL, 2);
INSERT INTO "public"."department" VALUES (68, 15, 'Прикладной экологии и охраны окружающей среды', NULL, 2);
INSERT INTO "public"."department" VALUES (69, 15, 'Машин и аппаратов химических производств', NULL, 2);
INSERT INTO "public"."department" VALUES (70, 16, 'Международной экономики', NULL, 2);
INSERT INTO "public"."department" VALUES (71, 16, 'Менеджмента и хозяйственного права', NULL, 2);
INSERT INTO "public"."department" VALUES (72, 16, 'Экономики предприятия и инноватики', NULL, 2);
INSERT INTO "public"."department" VALUES (73, 16, 'Экономической теории и государственного управления', NULL, 2);
INSERT INTO "public"."department" VALUES (74, 16, 'Экономики и маркетинга', NULL, 2);
INSERT INTO "public"."department" VALUES (75, 16, 'Финансов и экономической безопасности', NULL, 2);
INSERT INTO "public"."department" VALUES (76, 16, 'Бухгалтерского учета и аудита', NULL, 2);
INSERT INTO "public"."department" VALUES (77, 16, 'Управления бизнесом и персоналом', NULL, 2);

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
-- Records of discipline
-- ----------------------------
INSERT INTO "public"."discipline" VALUES (16, 'dsa');
INSERT INTO "public"."discipline" VALUES (17, 'asdsa');

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
-- Records of faculty
-- ----------------------------
INSERT INTO "public"."faculty" VALUES (8, 'Горный', '');
INSERT INTO "public"."faculty" VALUES (12, 'Электротехнический', NULL);
INSERT INTO "public"."faculty" VALUES (7, 'Горно-геологический', '');
INSERT INTO "public"."faculty" VALUES (13, 'Компьютерных наук и технологий', NULL);
INSERT INTO "public"."faculty" VALUES (14, 'Компьютерных информационных технологий и автоматизации', NULL);
INSERT INTO "public"."faculty" VALUES (15, 'Экологии и химической технологии', NULL);
INSERT INTO "public"."faculty" VALUES (16, 'Инженерно-экономический', NULL);
INSERT INTO "public"."faculty" VALUES (9, 'Инженерной механики и машиностроения', '');
INSERT INTO "public"."faculty" VALUES (11, 'Металургии и теплоэнергетики', NULL);

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS "public"."groups";
CREATE TABLE "public"."groups" (
  "ID_GROUP" int4 NOT NULL DEFAULT nextval('"groups_ID_GROUP_seq"'::regclass),
  "id_specialty" int4 NOT NULL,
  "Year_Of_Entry" int4 NOT NULL,
  "Sub_Name_Group" text COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO "public"."groups" VALUES (4, 2, 1234, 'выфв');
INSERT INTO "public"."groups" VALUES (5, 2, 123, 'выф');

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
-- Records of position
-- ----------------------------
INSERT INTO "public"."position" VALUES (13, 'dsadsa');

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
-- Records of specialty
-- ----------------------------
INSERT INTO "public"."specialty" VALUES (2, 4, 'qqqq', 'qqqqq', 'qqqqq');

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
-- Records of teachers
-- ----------------------------
INSERT INTO "public"."teachers" VALUES (4, 'sa', 13, 4, 'aaa', 21, 12);
INSERT INTO "public"."teachers" VALUES (5, 'sa', 13, 4, 'aaa', 21, 12);
INSERT INTO "public"."teachers" VALUES (7, 'Q', 13, 51, 'q@q.ru', 1, 1);

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
  "Name_Subject" text COLLATE "pg_catalog"."default" NOT NULL,
  "type_lesson" varchar(1) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."typeSubject"."Name_Subject" IS 'Тип предмета (лекция, проработка, семинар, консультация, экзамен, зачёт)';
COMMENT ON COLUMN "public"."typeSubject"."type_lesson" IS 'Тип предмета, к чему относится 
Сессия - С
Обучение - О ';

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
-- Records of week
-- ----------------------------
INSERT INTO "public"."week" VALUES (3, 'Понедельник', 'V');
INSERT INTO "public"."week" VALUES (4, 'Вторник', 'V');
INSERT INTO "public"."week" VALUES (5, 'Среда', 'V');
INSERT INTO "public"."week" VALUES (6, 'Четверг', 'V');
INSERT INTO "public"."week" VALUES (7, 'Пятница', 'V');
INSERT INTO "public"."week" VALUES (8, 'Суббота', 'V');
INSERT INTO "public"."week" VALUES (10, 'Воскресенье', 'V');

-- ----------------------------
-- Function structure for add_styding_plans
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_styding_plans"("namefaculty" text, "namedepar" text, "spec" text, "year_gr" int4, "sub_gr" text, "startstuding" date, "endstuding" date, "startsession" date, "endsession" date);
CREATE OR REPLACE FUNCTION "public"."add_styding_plans"("namefaculty" text, "namedepar" text, "spec" text, "year_gr" int4, "sub_gr" text, "startstuding" date, "endstuding" date, "startsession" date, "endsession" date)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDSPEC INTEGER := 0;
	IDGROUP INTEGER := 0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
 IF not FOUND THEN
 RETURN 'Факультет не найден';
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepar and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не существует';
END IF;

SELECT specialty."ID_SPECIALTY" From specialty WHERE specialty."Abbreviation_Specialty"=spec INTO IDSPEC;
IF NOT FOUND THEN
    RETURN 'Специальность не существует';
END IF;

SELECT "ID_GROUP" FROM groups WHERE "Sub_Name_Group"=sub_gr and groups.id_specialty=IDSPEC and "Year_Of_Entry"=year_gr INTO IDGROUP;
IF NOT FOUND THEN
	RETURN 'Группа не существует';
END IF;

IF EXISTS (SELECT
FROM
"stadyingPlan"
WHERE
id_group=IDGROUP AND
"DateStartStuding"=startstuding AND
"DateEndStuding"=endstuding AND
"DateStartSession"=startsession AND
"DateEndSession" =endsession ) THEN
	RETURN 'План уже существует';
END IF;

INSERT INTO "stadyingPlan" (id_group,"DateStartStuding","DateEndStuding","DateStartSession","DateEndSession") VALUES (IDGROUP,startstuding, endstuding, startsession, endsession);


RETURN 'Success';

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for classroom_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_add"("housing" int4, "numclassroom" int4);
CREATE OR REPLACE FUNCTION "public"."classroom_add"("housing" int4, "numclassroom" int4)
  RETURNS "pg_catalog"."text" AS $BODY$
BEGIN
	 	IF EXISTS(SELECT FROM "public".classroom WHERE "public".classroom."Housing"=Housing AND "public".classroom."Num_Classroom"=numclassroom) THEN
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
-- Function structure for classroom_get_class
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."classroom_get_class"("house" int4);
CREATE OR REPLACE FUNCTION "public"."classroom_get_class"("house" int4)
  RETURNS TABLE("class" int4) AS $BODY$BEGIN
	-- Routine body goes here...
	RETURN QUERY SELECT "Num_Classroom" FROM classroom WHERE "Housing"=house;
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
-- Function structure for del_styding_plans
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."del_styding_plans"("namefaculty" text, "namedepar" text, "spec" text, "year_gr" int4, "sub_gr" text, "startstuding" date, "endstuding" date, "startsession" date, "endsession" date);
CREATE OR REPLACE FUNCTION "public"."del_styding_plans"("namefaculty" text, "namedepar" text, "spec" text, "year_gr" int4, "sub_gr" text, "startstuding" date, "endstuding" date, "startsession" date, "endsession" date)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDSPEC INTEGER := 0;
	IDGROUP INTEGER := 0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
 IF not FOUND THEN
 RETURN 'Факультет не найден';
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepar and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не существует';
END IF;

SELECT specialty."ID_SPECIALTY" From specialty WHERE specialty."Abbreviation_Specialty"=spec  INTO IDSPEC;
IF NOT FOUND THEN
    RETURN 'Специальность не существует';
END IF;

SELECT "ID_GROUP" FROM groups WHERE "Sub_Name_Group"=sub_gr and groups.id_specialty=IDSPEC and "Year_Of_Entry"=year_gr INTO IDGROUP;
IF NOT FOUND THEN
	RETURN 'Группа не существует';
END IF;

DELETE
FROM
"stadyingPlan"
WHERE
id_group=IDGROUP AND
"DateStartStuding"=startstuding AND
"DateEndStuding"=endstuding AND
"DateStartSession"=startsession AND
"DateEndSession" =endsession;

RETURN 'Success';

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for department_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."department_add"("namefaculty" text, "logo" text, "namedepar" text, "housingc" int4, "numclassroom" int4);
CREATE OR REPLACE FUNCTION "public"."department_add"("namefaculty" text, "logo" text, "namedepar" text, "housingc" int4, "numclassroom" int4)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDCLASSROOM INTEGER :=0;
	IDFACULTY INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;
SELECT "ID_CLASSROOM" FROM classroom INTO IDCLASSROOM WHERE "Housing"=housingc and "Num_Classroom"=numclassroom LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Класс не найден';
END IF;

IF EXISTS(SELECT * From department WHERE  department."Name_Department"=namedepar and IDFACULTY=department.id_faculty) THEN
    RETURN 'Кафедра существует';
END IF;
			INSERT INTO department("Logo_Department","Name_Department",id_classrooms,id_faculty) VALUES(logo,namedepar,IDCLASSROOM,IDFACULTY);
			RETURN 'Success';
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
DROP FUNCTION IF EXISTS "public"."discipline_add"("name_discipline" text, "namefacul" text, "namedepar" text);
CREATE OR REPLACE FUNCTION "public"."discipline_add"("name_discipline" text, "namefacul" text, "namedepar" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	id_disc INTEGER :=0;
	BEGIN 
	
	IF EXISTS(SELECT discipline."ID_DISCIPLINE", discipline."Name_Discipline" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefacul LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepar) as dep INNER JOIN  "Spec_discipline" on "Spec_discipline".id_department= dep."ID_DEPARTMENT" INNER JOIN discipline on discipline."ID_DISCIPLINE"="Spec_discipline".id_discipline WHERE discipline."Name_Discipline"=name_discipline) THEN
		RETURN 'Запись уже существует';
	END IF;

	INSERT INTO discipline("Name_Discipline") VALUES (name_discipline);
	  SELECT currval(pg_get_serial_sequence('discipline','ID_DISCIPLINE')) INTO id_disc;
	
		INSERT INTO "Spec_discipline" VALUES (id_disc,	(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefacul LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepar));
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
DROP FUNCTION IF EXISTS "public"."discipline_get_all"("namefaculty" text, "depart" text, "start_row" int4, "count_rows" int4);
CREATE OR REPLACE FUNCTION "public"."discipline_get_all"("namefaculty" text, "depart" text, "start_row" int4, "count_rows" int4)
  RETURNS TABLE("id" int4, "name" text) AS $BODY$BEGIN
	RETURN QUERY SELECT discipline."ID_DISCIPLINE", discipline."Name_Discipline" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=depart) as dep INNER JOIN  "Spec_discipline" on "Spec_discipline".id_department= dep."ID_DEPARTMENT" INNER JOIN discipline on discipline."ID_DISCIPLINE"="Spec_discipline".id_discipline LIMIT count_rows OFFSET start_row;

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
-- Function structure for get_groups
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_groups"("namefaculty" text, "namedepartment" text, "spec" text);
CREATE OR REPLACE FUNCTION "public"."get_groups"("namefaculty" text, "namedepartment" text, "spec" text)
  RETURNS TABLE("yea" int4, "sub" text) AS $BODY$BEGIN
	RETURN query SELECT groups."Year_Of_Entry",groups."Sub_Name_Group" FROM (SELECT specialty."ID_SPECIALTY" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" WHERE specialty."Abbreviation_Specialty"=spec)as sp INNER JOIN groups on groups.id_specialty=sp."ID_SPECIALTY";

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for get_styding_plans
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_styding_plans"("namefaculty" text, "namedepartment" text, "spec" text, "year_gr" int4, "sub_gr" text);
CREATE OR REPLACE FUNCTION "public"."get_styding_plans"("namefaculty" text, "namedepartment" text, "spec" text, "year_gr" int4, "sub_gr" text)
  RETURNS TABLE("DateStartStuding" text, "DateEndStuding" text, "DateStartSession" text, "DateEndSession" text) AS $BODY$BEGIN
	RETURN query SELECT "stadyingPlan"."DateStartStuding","stadyingPlan"."DateEndStuding","stadyingPlan"."DateStartSession","stadyingPlan"."DateEndSession" FROM(SELECT groups."ID_GROUP" FROM (SELECT specialty."ID_SPECIALTY" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" WHERE specialty."Abbreviation_Specialty"=spec)as sp INNER JOIN groups on groups.id_specialty=sp."ID_SPECIALTY" WHERE groups."Sub_Name_Group"=sub and groups."Year_Of_Entry"=year_gr)as gr INNER JOIN "stadyingPlan" on "stadyingPlan".id_group=gr."ID_GROUP";

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getalldepartmentnames
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getalldepartmentnames"("namefaculty" text);
CREATE OR REPLACE FUNCTION "public"."getalldepartmentnames"("namefaculty" text)
  RETURNS TABLE("Name_Department" text) AS $BODY$BEGIN
				
			RETURN QUERY	SELECT department."Name_Department" FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getallspeciality
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getallspeciality"("namefaculty" text, "NameDepartment" text, "startrow" int4, "countrow" int4);
CREATE OR REPLACE FUNCTION "public"."getallspeciality"("namefaculty" text, "NameDepartment" text, "startrow" int4, "countrow" int4)
  RETURNS TABLE("Abbreviation_Specialty" text, "Cipher_Specialty" text, "Name_Specialty" text) AS $BODY$BEGIN
				
RETURN QUERY	SELECT specialty."Abbreviation_Specialty",specialty."Cipher_Specialty",specialty."Name_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"="namefaculty" LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"="NameDepartment") as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" LIMIT countrow OFFSET startrow;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getallspecialitynames
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getallspecialitynames"("namefaculty" text, "namedepartment" text);
CREATE OR REPLACE FUNCTION "public"."getallspecialitynames"("namefaculty" text, "namedepartment" text)
  RETURNS TABLE("Name_Specialty" text) AS $BODY$BEGIN
				
			RETURN QUERY	SELECT specialty."Abbreviation_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getallteachers
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getallteachers"("facultet" text, "departm" text);
CREATE OR REPLACE FUNCTION "public"."getallteachers"("facultet" text, "departm" text)
  RETURNS TABLE("nameteacher" text, "emaildata" text, "rating" float4, "hourlypayment" float4, "nameposition" text) AS $BODY$BEGIN
	RETURN query SELECT teachers."Name_Teacher",teachers."Email",teachers."Rate",teachers."Hourly_Payment","position"."Name_Position" from (SELECT department."ID_DEPARTMENT" FROM (SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facultet) as facul INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=departm) as dep INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" INNER JOIN "position" on teachers.id_position="position"."ID_POSITION";

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getdepartmentfull
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getdepartmentfull"("namefaculty" text, "startrow" int4, "countrow" int4);
CREATE OR REPLACE FUNCTION "public"."getdepartmentfull"("namefaculty" text, "startrow" int4, "countrow" int4)
  RETURNS TABLE("Name_Department" text, "Logo_Department" text, "Housing" int4, "Num_Classroom" int4) AS $BODY$BEGIN
			RETURN QUERY	SELECT department."Name_Department",department."Logo_Department",classroom."Housing",classroom."Num_Classroom" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON faculty_sel_name."ID_FACULTY"=department.id_faculty INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms LIMIT countrow OFFSET startrow;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for getteacherdiscipline
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."getteacherdiscipline"("facultet" text, "departm" text, "nameteacher" text);
CREATE OR REPLACE FUNCTION "public"."getteacherdiscipline"("facultet" text, "departm" text, "nameteacher" text)
  RETURNS TABLE("id_disc" int4, "namedisc" text) AS $BODY$BEGIN
	RETURN query SELECT discipline."ID_DISCIPLINE",discipline."Name_Discipline" from (SELECT teachers."ID_TEACHER" from (SELECT department."ID_DEPARTMENT" FROM (SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facultet) as facul INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=departm) as dep INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" WHERE teachers."Name_Teacher"=nameteacher)as teach INNER JOIN "helpDiscip" on "helpDiscip".id_teacher=teach."ID_TEACHER" INNER JOIN discipline on "helpDiscip".id_discipline=discipline."ID_DISCIPLINE";

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for gettimetable_basic
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."gettimetable_basic"("facult" text, "depar" text, "fio_teacher" text, "typeweek" bpchar);
CREATE OR REPLACE FUNCTION "public"."gettimetable_basic"("facult" text, "depar" text, "fio_teacher" text, "typeweek" bpchar)
  RETURNS TABLE("housing" int4, "numclass" int4, "num_lesson" int4, "namesubject" text, "nameday" text, "groups_year" int4, "groups_subname" text) AS $BODY$	
	DECLARE 
	DayName TEXT :='';
	BEGIN
	
	
	
	
	RETURN query SELECT * from (SELECT "timeTable"."Date","timeTable"."ID","timeTable"."Time","timeTable".id_classroom,"timeTable".num_lesson, "timeTable".type_subject,week."NameDay" from (SELECT teachers."ID_TEACHER" from (SELECT department."ID_DEPARTMENT" FROM (SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facultet) as facul INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=departm) as dep INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" WHERE teachers."Name_Teacher"=fio_teacher LIMIT 1) as teach INNER JOIN "subjectPay" on "subjectPay".id_teacher=teach."ID_TEACHER" INNER JOIN "timeTable" on "timeTable"."ID"="subjectPay".id_subject INNER JOIN week on week."ID_DAY"="timeTable".id_type_week WHERE week."TypeWeek"=typeweek) as ttw;

	
	

	RETURN QUERY SELECT * FROM "timeTable";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for group_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."group_add"("namefaculty" text, "namedepartment" text, "abbreviationspecialty" text, "yea" int4, "sub" text);
CREATE OR REPLACE FUNCTION "public"."group_add"("namefaculty" text, "namedepartment" text, "abbreviationspecialty" text, "yea" int4, "sub" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDSPEC INTEGER := 0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
 IF not FOUND THEN
 RETURN 'Факультет не найден';
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не существует';
END IF;

SELECT specialty."ID_SPECIALTY" From specialty WHERE specialty."Abbreviation_Specialty"=abbreviationspecialty or specialty."Abbreviation_Specialty"=abbreviationspecialty INTO IDSPEC;
IF NOT FOUND THEN
    RETURN 'Специальность не существует';
END IF;

If EXISTS(SELECT * FROM groups WHERE "Sub_Name_Group"=sub and id_specialty=IDSPEC and "Year_Of_Entry"=yea) THEN
	RETURN 'Группа уже существует';
END IF;

INSERT INTO groups (id_specialty,"Sub_Name_Group","Year_Of_Entry") VALUES (IDSPEC, sub,yea);
RETURN 'Success';

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for group_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."group_delete"("namefaculty" text, "namedepartment" text, "abbreviationspecialty" text, "yea" int4, "sub" text);
CREATE OR REPLACE FUNCTION "public"."group_delete"("namefaculty" text, "namedepartment" text, "abbreviationspecialty" text, "yea" int4, "sub" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDSPEC INTEGER := 0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
 IF not FOUND THEN
 RETURN 'Факультет не найден';
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не существует';
END IF;

SELECT specialty."ID_SPECIALTY" From specialty WHERE specialty."Abbreviation_Specialty"=abbreviationspecialty or specialty."Abbreviation_Specialty"=abbreviationspecialty INTO IDSPEC;
IF NOT FOUND THEN
    RETURN 'Специальность не существует';
END IF;

DELETE FROM groups WHERE groups."Sub_Name_Group"=sub and groups.id_specialty=IDSPEC and groups."Year_Of_Entry"=yea;
RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

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
DROP FUNCTION IF EXISTS "public"."specialty_add"("namefaculty" text, "namedepartment" text, "cipherspecialty" text, "namespecialty" text, "abbreviationspecialty" text);
CREATE OR REPLACE FUNCTION "public"."specialty_add"("namefaculty" text, "namedepartment" text, "cipherspecialty" text, "namespecialty" text, "abbreviationspecialty" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT department."ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty LIMIT 1 INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не существует';
END IF;

IF EXISTS(SELECT * From specialty WHERE specialty."Abbreviation_Specialty"=abbreviationspecialty or specialty."Cipher_Specialty"=cipherspecialty or specialty."Name_Specialty"=namespecialty or specialty.id_department=IDDEPARTMENT) THEN
    RETURN 'Специальность существует';
END IF;
INSERT INTO specialty ("Abbreviation_Specialty","Cipher_Specialty","Name_Specialty",id_department) VALUES(abbreviationspecialty,cipherspecialty,namespecialty,IDDEPARTMENT);
RETURN 'Success';



			RETURN "Success";
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for specialty_delete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."specialty_delete"("namefaculty" text, "department" text, "specialtyabr" text);
CREATE OR REPLACE FUNCTION "public"."specialty_delete"("namefaculty" text, "department" text, "specialtyabr" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	id_depar INTEGER :=0;
	BEGIN
	SELECT department."ID_DEPARTMENT"  FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INTO id_depar LIMIT 1;
	if not FOUND then
	RETURN 'Кафедра не найдена';
	end if;
	DELETE FROM specialty WHERE specialty."Abbreviation_Specialty"=specialtyabr and specialty.id_department=id_depar;
	
	RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for teacher_add_discipline
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."teacher_add_discipline"("namefaculty" text, "namedepartment" text, "nameteacher" text, "namediscplin" text);
CREATE OR REPLACE FUNCTION "public"."teacher_add_discipline"("namefaculty" text, "namedepartment" text, "nameteacher" text, "namediscplin" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDPOSITION INTEGER := 0;
	IDTeacher INTEGER:=0;
	IDDISCIPLINE INTEGER:=0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;
SELECT "ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;
	SELECT "ID_TEACHER" FROM teachers WHERE teachers."Name_Teacher"=nameteacher and teachers.id_department=IDDEPARTMENT INTO IDTeacher LIMIT 1;
	IF NOT FOUND THEN
    RETURN 'Преподователь не найден';
END IF;
	SELECT "ID_DISCIPLINE" FROM discipline WHERE discipline."Name_Discipline"=namediscplin INTO IDDISCIPLINE LIMIT 1;
	IF NOT FOUND THEN
    RETURN 'Дисциплина не найдена';
END IF;
	IF EXISTS(	SELECT * FROM "helpDiscip" WHERE "helpDiscip".id_teacher=IDTeacher and "helpDiscip".id_discipline=IDDISCIPLINE) THEN
    RETURN 'Дисциплина уже была добавлена';
END IF;
	
INSERT INTO "helpDiscip"("helpDiscip".id_discipline,"helpDiscip".id_teacher) VALUES (IDDISCIPLINE,IDTeacher);	
	RETURN 'Success';
	
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for teachers_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."teachers_add"("namefaculty" text, "namedepartment" text, "nameteacher" text, "emailteacher" text, "rateteacher" float8, "hourlypayment" float8, "nameposition" text);
CREATE OR REPLACE FUNCTION "public"."teachers_add"("namefaculty" text, "namedepartment" text, "nameteacher" text, "emailteacher" text, "rateteacher" float8, "hourlypayment" float8, "nameposition" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDPOSITION INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT "ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;
SELECT "ID_POSITION" FROM "position" WHERE "Name_Position"=nameposition INTO IDPOSITION;
IF NOT FOUND THEN
    RETURN 'Должность не найдена';
END IF;
			
			INSERT INTO teachers("Email","Hourly_Payment","Name_Teacher","Rate",id_department,id_position) VALUES(emailteacher,hourlypayment,nameteacher,rateteacher,IDDEPARTMENT,IDPOSITION);
			RETURN 'Success';
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for teachersdelete
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."teachersdelete"("namefaculty" text, "namedepartment" text, "nameteacher" text);
CREATE OR REPLACE FUNCTION "public"."teachersdelete"("namefaculty" text, "namedepartment" text, "nameteacher" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDPOSITION INTEGER := 0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT "ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;
	
	DELETE FROM teachers WHERE teachers."Name_Teacher"=nameteacher and teachers.id_department=IDDEPARTMENT;
	RETURN 'Success';
	
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for teachersdelete_all_discipline
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."teachersdelete_all_discipline"("namefaculty" text, "namedepartment" text, "nameteacher" text);
CREATE OR REPLACE FUNCTION "public"."teachersdelete_all_discipline"("namefaculty" text, "namedepartment" text, "nameteacher" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDPOSITION INTEGER := 0;
	IDTeacher INTEGER:=0;
	BEGIN 
SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT "ID_DEPARTMENT" From department WHERE  department."Name_Department"=namedepartment and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;
	
	SELECT "ID_TEACHER" FROM teachers WHERE teachers."Name_Teacher"=nameteacher and teachers.id_department=IDDEPARTMENT INTO IDTeacher LIMIT 1;
	IF NOT FOUND THEN
    RETURN 'Преподователь не найден';
END IF;
	
	DELETE FROM "helpDiscip" WHERE "helpDiscip".id_teacher=IDTeacher;
	
	RETURN 'Success';
	
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for type_subject_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."type_subject_add"("name_subject" text);
CREATE OR REPLACE FUNCTION "public"."type_subject_add"("name_subject" text)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM "typeSubject" WHERE "Name_Subject"=name_subject) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "typeSubject"("Name_Subject") VALUES(name_subject);	
		RETURN 'Success';
	END IF;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for type_subject_add
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."type_subject_add"("name_subject" text, "lesson" bpchar);
CREATE OR REPLACE FUNCTION "public"."type_subject_add"("name_subject" text, "lesson" bpchar)
  RETURNS "pg_catalog"."text" AS $BODY$
	BEGIN 
	IF EXISTS(SELECT * FROM "typeSubject" WHERE "Name_Subject"=name_subject and "type_lesson"=lesson) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "typeSubject"("Name_Subject", "type_lesson") VALUES(name_subject,lesson);	
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
  RETURNS TABLE("id" int4, "name" text, "lesson" bpchar) AS $BODY$BEGIN
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
SELECT setval('"public"."classroom_ID_CLASSROOM_seq"', 12, true);
ALTER SEQUENCE "public"."department_ID_DEPARTMENT_seq"
OWNED BY "public"."department"."ID_DEPARTMENT";
SELECT setval('"public"."department_ID_DEPARTMENT_seq"', 80, true);
ALTER SEQUENCE "public"."discipline_ID_DISCIPLINE_seq"
OWNED BY "public"."discipline"."ID_DISCIPLINE";
SELECT setval('"public"."discipline_ID_DISCIPLINE_seq"', 18, true);
ALTER SEQUENCE "public"."faculty_ID_FACULTY_seq"
OWNED BY "public"."faculty"."ID_FACULTY";
SELECT setval('"public"."faculty_ID_FACULTY_seq"', 19, true);
ALTER SEQUENCE "public"."groups_ID_GROUP_seq"
OWNED BY "public"."groups"."ID_GROUP";
SELECT setval('"public"."groups_ID_GROUP_seq"', 7, true);
ALTER SEQUENCE "public"."position_ID_POSITION_seq"
OWNED BY "public"."position"."ID_POSITION";
SELECT setval('"public"."position_ID_POSITION_seq"', 15, true);
ALTER SEQUENCE "public"."specialty_ID_SPECIALTY_seq"
OWNED BY "public"."specialty"."ID_SPECIALTY";
SELECT setval('"public"."specialty_ID_SPECIALTY_seq"', 6, true);
ALTER SEQUENCE "public"."stadyingPlan_ID_SETTING_seq"
OWNED BY "public"."stadyingPlan"."ID_SETTING";
SELECT setval('"public"."stadyingPlan_ID_SETTING_seq"', 6, false);
ALTER SEQUENCE "public"."teachers_ID_TEACHER_seq"
OWNED BY "public"."teachers"."ID_TEACHER";
SELECT setval('"public"."teachers_ID_TEACHER_seq"', 8, true);
ALTER SEQUENCE "public"."timeTable_ID_seq"
OWNED BY "public"."timeTable"."ID";
SELECT setval('"public"."timeTable_ID_seq"', 6, false);
ALTER SEQUENCE "public"."typeSubject_ID_SUBJECT_seq"
OWNED BY "public"."typeSubject"."ID_SUBJECT";
SELECT setval('"public"."typeSubject_ID_SUBJECT_seq"', 11, true);
ALTER SEQUENCE "public"."week_ID_DAY_seq"
OWNED BY "public"."week"."ID_DAY";
SELECT setval('"public"."week_ID_DAY_seq"', 13, true);

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
