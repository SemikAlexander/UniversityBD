--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE admin_depar;
ALTER ROLE admin_depar WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE admin_faculty;
ALTER ROLE admin_faculty WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE admin_vuz;
ALTER ROLE admin_vuz WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5218e525d54a4b3a8e72598428c11e78c';
CREATE ROLE spravochniki;
ALTER ROLE spravochniki WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE teachers;
ALTER ROLE teachers WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;






--
-- Database creation
--

CREATE DATABASE "Univer" WITH TEMPLATE = template0 OWNER = postgres;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect "Univer"

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.12
-- Dumped by pg_dump version 9.6.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: add_styding_plans(text, text, text, integer, text, date, date, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) OWNER TO postgres;

--
-- Name: add_transfer(integer, date, date, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN

	INSERT INTO transfers(date_from,date_to,id_lesson,num_lesson_to) VALUES(datefrom,dateto,id_tm,numless);
	RETURN "Success";
END
$$;


ALTER FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) OWNER TO postgres;

--
-- Name: classroom_add(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.classroom_add(housing integer, numclassroom integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
	 	IF EXISTS(SELECT FROM "public".classroom WHERE "public".classroom."Housing"=housing AND "public".classroom."Num_Classroom"=numclassroom) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO classroom ("Housing","Num_Classroom") VALUES(housing,numclassroom);	
		RETURN 'Success';
	END IF;
END
$$;


ALTER FUNCTION public.classroom_add(housing integer, numclassroom integer) OWNER TO postgres;

--
-- Name: classroom_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.classroom_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM classroom WHERE "ID_CLASSROOM"=id;
		RETURN 'Success';

END
$$;


ALTER FUNCTION public.classroom_delete(id integer) OWNER TO postgres;

--
-- Name: classroom_get_all(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) RETURNS TABLE(id integer, house integer, number_kab integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
	RETURN QUERY SELECT * FROM classroom WHERE "Housing"=number_korpus ORDER BY "ID_CLASSROOM" ASC LIMIT count_rows OFFSET start_row ;
END
$$;


ALTER FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) OWNER TO postgres;

--
-- Name: classroom_get_class(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.classroom_get_class(house integer) RETURNS TABLE(class integer)
    LANGUAGE plpgsql
    AS $$BEGIN
	-- Routine body goes here...
	RETURN QUERY SELECT "Num_Classroom" FROM classroom WHERE "Housing"=house;
END
$$;


ALTER FUNCTION public.classroom_get_class(house integer) OWNER TO postgres;

--
-- Name: classroom_get_housing(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.classroom_get_housing() RETURNS TABLE(housing integer)
    LANGUAGE plpgsql
    AS $$BEGIN
	-- Routine body goes here...
	RETURN QUERY SELECT "Housing" FROM classroom GROUP BY "Housing";
END
$$;


ALTER FUNCTION public.classroom_get_housing() OWNER TO postgres;

--
-- Name: del_styding_plans(text, text, text, integer, text, date, date, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) OWNER TO postgres;

--
-- Name: delete_transfer(integer, date, date, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	DELETE from transfers WHERE date_from=datefrom and date_to=dateto and id_lesson=id_tm and num_lesson_to=numless;
END
$$;


ALTER FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) OWNER TO postgres;

--
-- Name: department_add(text, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.department_add(namefaculty text, logo text, namedepar text, housingc integer, numclassroom integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.department_add(namefaculty text, logo text, namedepar text, housingc integer, numclassroom integer) OWNER TO postgres;

--
-- Name: department_delete(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.department_delete(facultyname text, departmentname text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.department_delete(facultyname text, departmentname text) OWNER TO postgres;

--
-- Name: discipline_add(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.discipline_add(name_discipline text, namefacul text, namedepar text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.discipline_add(name_discipline text, namefacul text, namedepar text) OWNER TO postgres;

--
-- Name: discipline_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.discipline_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM discipline WHERE "ID_DISCIPLINE"=id;
	 DELETE FROM "Spec_discipline" WHERE "Spec_discipline".id_discipline=id;
		RETURN 'Success';

END
$$;


ALTER FUNCTION public.discipline_delete(id integer) OWNER TO postgres;

--
-- Name: discipline_get_all(text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) RETURNS TABLE(id integer, name text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT discipline."ID_DISCIPLINE", discipline."Name_Discipline" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=depart) as dep INNER JOIN  "Spec_discipline" on "Spec_discipline".id_department= dep."ID_DEPARTMENT" INNER JOIN discipline on discipline."ID_DISCIPLINE"="Spec_discipline".id_discipline LIMIT count_rows OFFSET start_row;

END
$$;


ALTER FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) OWNER TO postgres;

--
-- Name: faculty_add(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.faculty_add(name_faculty text, logo text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN 
	IF EXISTS(SELECT * FROM faculty WHERE "Name_Faculty"=name_faculty) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO faculty("Name_Faculty","Logo_Faculty") VALUES(name_faculty,logo);	
		RETURN 'Success';
	END IF;

END
$$;


ALTER FUNCTION public.faculty_add(name_faculty text, logo text) OWNER TO postgres;

--
-- Name: faculty_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.faculty_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM faculty WHERE "ID_FACULTY"=id;
		RETURN 'Success';
END
$$;


ALTER FUNCTION public.faculty_delete(id integer) OWNER TO postgres;

--
-- Name: faculty_get_all(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.faculty_get_all() RETURNS TABLE(id integer, name text, logo text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM faculty;
END
$$;


ALTER FUNCTION public.faculty_get_all() OWNER TO postgres;

--
-- Name: get_groups(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) RETURNS TABLE(yea integer, sub text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN query SELECT groups."Year_Of_Entry",groups."Sub_Name_Group" FROM (SELECT specialty."ID_SPECIALTY" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" WHERE specialty."Abbreviation_Specialty"=spec)as sp INNER JOIN groups on groups.id_specialty=sp."ID_SPECIALTY";

END
$$;


ALTER FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) OWNER TO postgres;

--
-- Name: get_styding_plans(text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) RETURNS TABLE("DateStartStuding" date, "DateEndStuding" date, "DateStartSession" date, "DateEndSession" date)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN query SELECT "stadyingPlan"."DateStartStuding","stadyingPlan"."DateEndStuding","stadyingPlan"."DateStartSession","stadyingPlan"."DateEndSession" FROM(SELECT groups."ID_GROUP" FROM (SELECT specialty."ID_SPECIALTY" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepar) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" WHERE specialty."Abbreviation_Specialty"=spec)as sp INNER JOIN groups on groups.id_specialty=sp."ID_SPECIALTY" WHERE groups."Sub_Name_Group"=sub_gr and groups."Year_Of_Entry"=year_gr)as gr INNER JOIN "stadyingPlan" on "stadyingPlan".id_group=gr."ID_GROUP";

END
$$;


ALTER FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) OWNER TO postgres;

--
-- Name: get_transfers(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_transfers(facult text, depar text, fio text) RETURNS TABLE("ID" integer, "Date" date, "Time" time without time zone, num_lesson integer, "NameDay" text, "Sub_Name_Group" text, "Year_Of_Entry" integer, "Housing" integer, "Num_Classroom" integer, "Name_Subject" text, type_lesson character varying, "Abbreviation_Specialty" text, dateto date)
    LANGUAGE plpgsql
    AS $$
	DECLARE
	date_start_week date := now();
	date_end_week date := now();
	BEGIN
	SELECT date_trunc('week', now()::timestamp) INTO date_start_week;
	SELECT (date_trunc('week', now()::timestamp)+ '6 days'::interval)::date INTO date_end_week;
	

CREATE TEMP TABLE seltm as (
		SELECT ttw."Date",ttw."ID",ttw."Time",ttw.num_lesson, ttw.type_subject,ttw."NameDay",ttw.id_classroom, groups."Sub_Name_Group",groups."Year_Of_Entry","stadyingPlan"."DateStartStuding","stadyingPlan"."DateEndStuding","stadyingPlan"."DateStartSession","stadyingPlan"."DateEndSession",specialty."Abbreviation_Specialty" from 
			(
				SELECT "timeTable"."Date","timeTable"."ID","timeTable"."Time","timeTable".id_classroom,"timeTable".num_lesson, "timeTable".type_subject,week."NameDay" from (
						SELECT teachers."ID_TEACHER" from (
								SELECT department."ID_DEPARTMENT" FROM (
										SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facult
								) as facul 
								INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=depar) as dep
						INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" WHERE teachers."Name_Teacher"=fio LIMIT 1) as teach
								INNER JOIN "subjectPay" on "subjectPay".id_teacher=teach."ID_TEACHER" INNER JOIN "timeTable" on "timeTable"."ID"="subjectPay".id_subject INNER JOIN week on week."ID_DAY"="timeTable".id_type_week) as ttw 
		INNER JOIN para on para.id_lesson=ttw."ID" 
		INNER JOIN groups on groups."ID_GROUP"=para.id_group 
		INNER JOIN specialty on groups.id_specialty=specialty."ID_SPECIALTY"
		INNER JOIN "stadyingPlan" on groups."ID_GROUP" = "stadyingPlan".id_group
);
CREATE TEMP TABLE res as (
		SELECT finish_timetable."ID", finish_timetable."Date", finish_timetable."Time", finish_timetable."num_lesson", finish_timetable."NameDay",finish_timetable."Sub_Name_Group",finish_timetable."Year_Of_Entry",classroom."Housing",classroom."Num_Classroom","typeSubject"."Name_Subject","typeSubject".type_lesson,finish_timetable."Abbreviation_Specialty"
		from(
				SELECT * from seltm WHERE "DateStartStuding"<now() and "DateEndStuding">now() 
				UNION ALL 
				SELECT * from seltm WHERE "DateStartSession"<now() and "DateEndSession">now()
				)as finish_timetable
		INNER JOIN classroom on classroom."ID_CLASSROOM"=finish_timetable."id_classroom" 
		INNER JOIN "typeSubject" on finish_timetable.type_subject = "typeSubject"."ID_SUBJECT"
);
RETURN query SELECT res."ID", res."Date", res."Time", transfers.num_lesson_to, res."NameDay",res."Sub_Name_Group",res."Year_Of_Entry",res."Housing",res."Num_Classroom",res."Name_Subject",res.type_lesson,res."Abbreviation_Specialty",transfers.date_to FROM res INNER JOIN transfers on res."ID"=transfers.id_lesson
WHERE transfers.date_to>=date_start_week and transfers.date_to<=date_end_week;
	
END
$$;


ALTER FUNCTION public.get_transfers(facult text, depar text, fio text) OWNER TO postgres;

--
-- Name: getalldepartmentnames(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getalldepartmentnames(namefaculty text) RETURNS TABLE("Name_Department" text)
    LANGUAGE plpgsql
    AS $$BEGIN
				
			RETURN QUERY	SELECT department."Name_Department" FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms;
END
$$;


ALTER FUNCTION public.getalldepartmentnames(namefaculty text) OWNER TO postgres;

--
-- Name: getallspeciality(text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) RETURNS TABLE("Abbreviation_Specialty" text, "Cipher_Specialty" text, "Name_Specialty" text)
    LANGUAGE plpgsql
    AS $$BEGIN
				
RETURN QUERY	SELECT specialty."Abbreviation_Specialty",specialty."Cipher_Specialty",specialty."Name_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"="namefaculty" LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"="NameDepartment") as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT" LIMIT countrow OFFSET startrow;

END
$$;


ALTER FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) OWNER TO postgres;

--
-- Name: getallspecialitynames(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) RETURNS TABLE("Name_Specialty" text)
    LANGUAGE plpgsql
    AS $$BEGIN
				
			RETURN QUERY	SELECT specialty."Abbreviation_Specialty" FROM(SELECT department."ID_DEPARTMENT" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty LIMIT 1) as id_fac INNER JOIN department on department.id_faculty=id_fac."ID_FACULTY" WHERE department."Name_Department"=namedepartment) as dep INNER JOIN specialty on specialty.id_department=dep."ID_DEPARTMENT";
END
$$;


ALTER FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) OWNER TO postgres;

--
-- Name: getallteachers(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getallteachers(facultet text, departm text) RETURNS TABLE(nameteacher text, emaildata text, rating real, hourlypayment real, nameposition text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN query SELECT teachers."Name_Teacher",teachers."Email",teachers."Rate",teachers."Hourly_Payment","position"."Name_Position" from (SELECT department."ID_DEPARTMENT" FROM (SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facultet) as facul INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=departm) as dep INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" INNER JOIN "position" on teachers.id_position="position"."ID_POSITION";

END
$$;


ALTER FUNCTION public.getallteachers(facultet text, departm text) OWNER TO postgres;

--
-- Name: getdepartmentfull(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) RETURNS TABLE("Name_Department" text, "Logo_Department" text, "Housing" integer, "Num_Classroom" integer)
    LANGUAGE plpgsql
    AS $$BEGIN
			RETURN QUERY	SELECT department."Name_Department",department."Logo_Department",classroom."Housing",classroom."Num_Classroom" FROM (SELECT faculty."ID_FACULTY" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON faculty_sel_name."ID_FACULTY"=department.id_faculty INNER JOIN classroom on classroom."ID_CLASSROOM"=department.id_classrooms LIMIT countrow OFFSET startrow;
END
$$;


ALTER FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) OWNER TO postgres;

--
-- Name: getteacherdiscipline(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) RETURNS TABLE(id_disc integer, namedisc text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN query SELECT discipline."ID_DISCIPLINE",discipline."Name_Discipline" from (SELECT teachers."ID_TEACHER" from (SELECT department."ID_DEPARTMENT" FROM (SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facultet) as facul INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=departm) as dep INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" WHERE teachers."Name_Teacher"=nameteacher)as teach INNER JOIN "helpDiscip" on "helpDiscip".id_teacher=teach."ID_TEACHER" INNER JOIN discipline on "helpDiscip".id_discipline=discipline."ID_DISCIPLINE";

END
$$;


ALTER FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) OWNER TO postgres;

--
-- Name: group_add(text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) OWNER TO postgres;

--
-- Name: group_delete(text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
if sub!='' then
DELETE FROM groups WHERE groups."Sub_Name_Group"=sub and groups.id_specialty=IDSPEC and groups."Year_Of_Entry"=yea;
else 
DELETE FROM groups WHERE groups.id_specialty=IDSPEC and groups."Year_Of_Entry"=yea;
END IF;
RETURN 'Success';
END
$$;


ALTER FUNCTION public.group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) OWNER TO postgres;

--
-- Name: holidays_add(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.holidays_add(holid_day date) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
	BEGIN 

INSERT INTO "holidays" (date_hol) VALUES (holid_day);


RETURN 'Success';

END
$$;


ALTER FUNCTION public.holidays_add(holid_day date) OWNER TO postgres;

--
-- Name: holidays_delete(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.holidays_delete(holid_day date) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
  DELETE FROM "holidays" WHERE date_hol=holid_day;
RETURN 'Success';
END
$$;


ALTER FUNCTION public.holidays_delete(holid_day date) OWNER TO postgres;

--
-- Name: holidays_get(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.holidays_get() RETURNS TABLE(_id integer, hol_date date)
    LANGUAGE plpgsql
    AS $$BEGIN
  RETURN query SELECT * FROM holidays;
END
$$;


ALTER FUNCTION public.holidays_get() OWNER TO postgres;

--
-- Name: position_add(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.position_add(name_position text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN 
	IF EXISTS(SELECT * FROM "position" WHERE "Name_Position"=name_position) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "position"("Name_Position") VALUES(name_position);	
		RETURN 'Success';
	END IF;

END
$$;


ALTER FUNCTION public.position_add(name_position text) OWNER TO postgres;

--
-- Name: position_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.position_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM "position" WHERE "ID_POSITION"=id;
		RETURN 'Success';
END
$$;


ALTER FUNCTION public.position_delete(id integer) OWNER TO postgres;

--
-- Name: position_get_all(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.position_get_all() RETURNS TABLE(id integer, name text)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM "position";
END
$$;


ALTER FUNCTION public.position_get_all() OWNER TO postgres;

--
-- Name: specialty_add(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.specialty_add(namefaculty text, namedepartment text, cipherspecialty text, namespecialty text, abbreviationspecialty text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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

IF EXISTS(SELECT * From specialty WHERE specialty."Abbreviation_Specialty"=abbreviationspecialty or specialty."Name_Specialty"=namespecialty and specialty.id_department=IDDEPARTMENT) THEN
    RETURN 'Специальность существует';
END IF;
INSERT INTO specialty ("Abbreviation_Specialty","Cipher_Specialty","Name_Specialty",id_department) VALUES(abbreviationspecialty,cipherspecialty,namespecialty,IDDEPARTMENT);
RETURN 'Success';



			RETURN "Success";
END
$$;


ALTER FUNCTION public.specialty_add(namefaculty text, namedepartment text, cipherspecialty text, namespecialty text, abbreviationspecialty text) OWNER TO postgres;

--
-- Name: specialty_delete(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.specialty_delete(namefaculty text, depar text, specialtyabr text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
	id_depar INTEGER :=0;
	BEGIN
	SELECT department."ID_DEPARTMENT"  FROM (SELECT "ID_FACULTY" as "FacultyID" FROM faculty WHERE faculty."Name_Faculty"=namefaculty) as faculty_sel_name INNER JOIN department ON (faculty_sel_name."FacultyID"=department.id_faculty) WHERE department."Name_Department"=depar INTO id_depar LIMIT 1;
	if not FOUND then
	RETURN 'Кафедра не найдена';
	end if;
	DELETE FROM specialty WHERE specialty."Abbreviation_Specialty"=specialtyabr and specialty.id_department=id_depar;
	
	RETURN 'Success';
END
$$;


ALTER FUNCTION public.specialty_delete(namefaculty text, depar text, specialtyabr text) OWNER TO postgres;

--
-- Name: teacher_add_discipline(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
	IF EXISTS(	SELECT * FROM "helpDiscip" WHERE id_teacher=IDTeacher and id_discipline=IDDISCIPLINE) THEN
    RETURN 'Дисциплина уже была добавлена';
END IF;
	
INSERT INTO "helpDiscip"(id_discipline,id_teacher) VALUES (IDDISCIPLINE,IDTeacher);	
	RETURN 'Success';
	
END
$$;


ALTER FUNCTION public.teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text) OWNER TO postgres;

--
-- Name: teachers_add(text, text, text, text, double precision, double precision, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text) OWNER TO postgres;

--
-- Name: teachersdelete(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teachersdelete(namefaculty text, namedepartment text, nameteacher text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.teachersdelete(namefaculty text, namedepartment text, nameteacher text) OWNER TO postgres;

--
-- Name: teachersdelete_all_discipline(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text) OWNER TO postgres;

--
-- Name: timetable_add(date, time without time zone, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE
	IDCLASS INTEGER := 0;
	var integer:=0;
	BEGIN 

	SELECT "ID_CLASSROOM" FROM classroom WHERE classroom."Housing"=classroom_house and classroom."Num_Classroom"=classroom_class INTO IDCLASS;
	if not FOUND THEN 
	RETURN -1;
	end if;
	 INSERT into "timeTable"("Date","Time",id_classroom,"id_type_week",num_lesson,type_subject,id_discipline) VALUES (_date,_time,IDCLASS,_id_type_week,_num_lesson,_type_subject,_id_discipline) RETURNING "timeTable"."ID" INTO var;
	 RETURN var;
END
$$;


ALTER FUNCTION public.timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer) OWNER TO postgres;

--
-- Name: timetable_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.timetable_delete(id_t integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN 

	DELETE FROM "timeTable" WHERE "ID"=id_t;
END
$$;


ALTER FUNCTION public.timetable_delete(id_t integer) OWNER TO postgres;

--
-- Name: timetable_get(text, text, text, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) RETURNS TABLE("ID" integer, "Date" date, "Time" time without time zone, num_lesson integer, "NameDay" text, "Sub_Name_Group" text, "Year_Of_Entry" integer, "Housing" integer, "Num_Classroom" integer, "Name_Subject" text, type_lesson character varying, "Abbreviation_Specialty" text)
    LANGUAGE plpgsql
    AS $$
	DECLARE
	date_start_week date := now();
	date_end_week date := now();
	BEGIN
	SELECT date_trunc('week', now()::timestamp) INTO date_start_week;
	SELECT (date_trunc('week', now()::timestamp)+ '6 days'::interval)::date INTO date_end_week;
	

CREATE TEMP TABLE seltm as (
		SELECT ttw."Date",ttw."ID",ttw."Time",ttw.num_lesson, ttw.type_subject,ttw."NameDay",ttw.id_classroom, groups."Sub_Name_Group",groups."Year_Of_Entry","stadyingPlan"."DateStartStuding","stadyingPlan"."DateEndStuding","stadyingPlan"."DateStartSession","stadyingPlan"."DateEndSession",specialty."Abbreviation_Specialty" from 
			(
				SELECT "timeTable"."Date","timeTable"."ID","timeTable"."Time","timeTable".id_classroom,"timeTable".num_lesson, "timeTable".type_subject,week."NameDay" from (
						SELECT teachers."ID_TEACHER" from (
								SELECT department."ID_DEPARTMENT" FROM (
										SELECT "ID_FACULTY" FROM faculty WHERE "Name_Faculty"=facult
								) as facul 
								INNER JOIN department on department.id_faculty=facul."ID_FACULTY" WHERE department."Name_Department"=depar) as dep
						INNER JOIN teachers on teachers.id_department=dep."ID_DEPARTMENT" WHERE teachers."Name_Teacher"=fio LIMIT 1) as teach
								INNER JOIN "subjectPay" on "subjectPay".id_teacher=teach."ID_TEACHER" INNER JOIN "timeTable" on "timeTable"."ID"="subjectPay".id_subject INNER JOIN week on week."ID_DAY"="timeTable".id_type_week WHERE week."TypeWeek"=type_week_char
			) as ttw 
		INNER JOIN para on para.id_lesson=ttw."ID" 
		INNER JOIN groups on groups."ID_GROUP"=para.id_group 
		LEFT JOIN "stadyingPlan" on groups."ID_GROUP" = "stadyingPlan".id_group
		LEFT JOIN specialty on groups.id_specialty=specialty."ID_SPECIALTY"
);
CREATE TEMP TABLE res as (
		SELECT finish_timetable."ID", finish_timetable."Date", finish_timetable."Time", finish_timetable."num_lesson", finish_timetable."NameDay",finish_timetable."Sub_Name_Group",finish_timetable."Year_Of_Entry",classroom."Housing",classroom."Num_Classroom","typeSubject"."Name_Subject","typeSubject".type_lesson,finish_timetable."Abbreviation_Specialty"
		from(
				SELECT * from seltm WHERE "DateStartStuding"<now() and "DateEndStuding">now() 
				UNION ALL 
				SELECT * from seltm WHERE "DateStartSession"<now() and "DateEndSession">now()
				)as finish_timetable
		INNER JOIN classroom on classroom."ID_CLASSROOM"=finish_timetable."id_classroom" 
		INNER JOIN "typeSubject" on finish_timetable.type_subject = "typeSubject"."ID_SUBJECT"
);
RETURN query SELECT * FROM res UNION ALL (SELECT res."ID", res."Date", res."Time", transfers.num_lesson_to, res."NameDay",res."Sub_Name_Group",res."Year_Of_Entry",res."Housing",res."Num_Classroom",res."Name_Subject",res.type_lesson,res."Abbreviation_Specialty" FROM res INNER JOIN transfers on res."ID"=transfers.id_lesson
WHERE transfers.date_to>=date_start_week and transfers.date_to<=date_end_week ) ORDER BY "ID" DESC;
	
END
$$;


ALTER FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) OWNER TO postgres;

--
-- Name: timetable_group_add(text, text, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDSPECIALTY INTEGER := 0;
	IDGroup INTEGER := 0;

	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT "ID_DEPARTMENT" From department WHERE  "Name_Department"=namedepart and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;

SELECT "ID_SPECIALTY" From specialty WHERE  "Abbreviation_Specialty"=name_spec and id_department=IDDEPARTMENT INTO IDSPECIALTY;
IF NOT FOUND THEN
    RETURN 'Специальность не найдена';
END IF;
SELECT "ID_GROUP" From groups WHERE "Sub_Name_Group"=subname and "Year_Of_Entry"=yea and id_specialty=IDSPECIALTY INTO IDGroup;
IF NOT FOUND THEN
    RETURN 'Специальность не найдена';
END IF;
INSERT into para(id_group, id_lesson) VALUES(IDGroup,id_time_table_para);
RETURN 'Success';
END
$$;


ALTER FUNCTION public.timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer) OWNER TO postgres;

--
-- Name: timetable_teachers_add(text, text, text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
	IDDEPARTMENT INTEGER :=0;
	IDFACULTY INTEGER := 0;
	IDTEACHER INTEGER := 0;
	BEGIN 


SELECT "ID_FACULTY" FROM faculty INTO IDFACULTY WHERE "Name_Faculty"=namefaculty LIMIT 1;
IF NOT FOUND THEN
    RETURN 'Факультет не найден';
END IF;

SELECT "ID_DEPARTMENT" From department WHERE  "Name_Department"=namedepart and IDFACULTY=department.id_faculty INTO IDDEPARTMENT;
IF NOT FOUND THEN
    RETURN 'Кафедра не найдена';
END IF;

SELECT "ID_TEACHER" From teachers WHERE  teachers."Name_Teacher"=nameteacher and teachers.id_department=IDDEPARTMENT INTO IDTEACHER;
IF NOT FOUND THEN
    RETURN 'Преподователь не найден';
END IF;
INSERT into "subjectPay" (id_subject,id_teacher,type_pay) VALUES (id_time_table_para,IDTEACHER,type_oplat);
RETURN 'Success';
END
$$;


ALTER FUNCTION public.timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer) OWNER TO postgres;

--
-- Name: type_subject_add(text, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.type_subject_add(name_subject text, lesson character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN 
	IF EXISTS(SELECT * FROM "typeSubject" WHERE "Name_Subject"=name_subject and "type_lesson"=lesson) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO "typeSubject"("Name_Subject", "type_lesson") VALUES(name_subject,lesson);	
		RETURN 'Success';
	END IF;

END
$$;


ALTER FUNCTION public.type_subject_add(name_subject text, lesson character varying) OWNER TO postgres;

--
-- Name: type_subject_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.type_subject_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM "typeSubject" WHERE "ID_SUBJECT"=id;
		RETURN 'Success';
END
$$;


ALTER FUNCTION public.type_subject_delete(id integer) OWNER TO postgres;

--
-- Name: type_subject_get_all(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.type_subject_get_all() RETURNS TABLE(id integer, name text, lesson character varying)
    LANGUAGE plpgsql
    AS $$BEGIN
	RETURN QUERY SELECT * FROM "typeSubject";
END
$$;


ALTER FUNCTION public.type_subject_get_all() OWNER TO postgres;

--
-- Name: week_add(text, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.week_add(name_day text, type_week character) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN 
	IF EXISTS(SELECT * FROM week WHERE week."NameDay"=name_day and week."TypeWeek"=type_week) THEN
		RETURN 'Запись существует';
	ELSE
		INSERT INTO week("NameDay","TypeWeek") VALUES(name_day,type_week);	
		RETURN 'Success';
	END IF;

END
$$;


ALTER FUNCTION public.week_add(name_day text, type_week character) OWNER TO postgres;

--
-- Name: week_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.week_delete(id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$BEGIN
	 DELETE FROM week WHERE week."ID_DAY"=id;
		RETURN 'Success';
END
$$;


ALTER FUNCTION public.week_delete(id integer) OWNER TO postgres;

--
-- Name: week_get_all(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.week_get_all() RETURNS TABLE(id_w integer, name_w text, type_w character)
    LANGUAGE plpgsql
    AS $$BEGIN
	
	RETURN QUERY SELECT * FROM week;
END
$$;


ALTER FUNCTION public.week_get_all() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Spec_discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Spec_discipline" (
    id_discipline integer NOT NULL,
    id_department integer NOT NULL
);


ALTER TABLE public."Spec_discipline" OWNER TO postgres;

--
-- Name: classroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classroom (
    "ID_CLASSROOM" integer NOT NULL,
    "Housing" integer NOT NULL,
    "Num_Classroom" integer NOT NULL
);


ALTER TABLE public.classroom OWNER TO postgres;

--
-- Name: classroom_ID_CLASSROOM_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."classroom_ID_CLASSROOM_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."classroom_ID_CLASSROOM_seq" OWNER TO postgres;

--
-- Name: classroom_ID_CLASSROOM_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."classroom_ID_CLASSROOM_seq" OWNED BY public.classroom."ID_CLASSROOM";


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    "ID_DEPARTMENT" integer NOT NULL,
    id_faculty integer NOT NULL,
    "Name_Department" text NOT NULL,
    "Logo_Department" text,
    id_classrooms integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_ID_DEPARTMENT_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."department_ID_DEPARTMENT_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."department_ID_DEPARTMENT_seq" OWNER TO postgres;

--
-- Name: department_ID_DEPARTMENT_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."department_ID_DEPARTMENT_seq" OWNED BY public.department."ID_DEPARTMENT";


--
-- Name: discipline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discipline (
    "ID_DISCIPLINE" integer NOT NULL,
    "Name_Discipline" text NOT NULL
);


ALTER TABLE public.discipline OWNER TO postgres;

--
-- Name: discipline_ID_DISCIPLINE_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."discipline_ID_DISCIPLINE_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."discipline_ID_DISCIPLINE_seq" OWNER TO postgres;

--
-- Name: discipline_ID_DISCIPLINE_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."discipline_ID_DISCIPLINE_seq" OWNED BY public.discipline."ID_DISCIPLINE";


--
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    "ID_FACULTY" integer NOT NULL,
    "Name_Faculty" text NOT NULL,
    "Logo_Faculty" text
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- Name: faculty_ID_FACULTY_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."faculty_ID_FACULTY_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."faculty_ID_FACULTY_seq" OWNER TO postgres;

--
-- Name: faculty_ID_FACULTY_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."faculty_ID_FACULTY_seq" OWNED BY public.faculty."ID_FACULTY";


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    "ID_GROUP" integer NOT NULL,
    id_specialty integer NOT NULL,
    "Year_Of_Entry" integer NOT NULL,
    "Sub_Name_Group" text NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: groups_ID_GROUP_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."groups_ID_GROUP_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."groups_ID_GROUP_seq" OWNER TO postgres;

--
-- Name: groups_ID_GROUP_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."groups_ID_GROUP_seq" OWNED BY public.groups."ID_GROUP";


--
-- Name: helpDiscip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."helpDiscip" (
    id_teacher integer NOT NULL,
    id_discipline integer NOT NULL
);


ALTER TABLE public."helpDiscip" OWNER TO postgres;

--
-- Name: holidays_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.holidays_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.holidays_seq OWNER TO postgres;

--
-- Name: holidays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.holidays (
    id integer DEFAULT nextval('public.holidays_seq'::regclass) NOT NULL,
    date_hol date NOT NULL
);


ALTER TABLE public.holidays OWNER TO postgres;

--
-- Name: para; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.para (
    id_group integer NOT NULL,
    id_lesson integer NOT NULL
);


ALTER TABLE public.para OWNER TO postgres;

--
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    "ID_POSITION" integer NOT NULL,
    "Name_Position" text NOT NULL
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- Name: position_ID_POSITION_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."position_ID_POSITION_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."position_ID_POSITION_seq" OWNER TO postgres;

--
-- Name: position_ID_POSITION_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."position_ID_POSITION_seq" OWNED BY public."position"."ID_POSITION";


--
-- Name: specialty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialty (
    "ID_SPECIALTY" integer NOT NULL,
    id_department integer NOT NULL,
    "Cipher_Specialty" text NOT NULL,
    "Name_Specialty" text NOT NULL,
    "Abbreviation_Specialty" text NOT NULL
);


ALTER TABLE public.specialty OWNER TO postgres;

--
-- Name: specialty_ID_SPECIALTY_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."specialty_ID_SPECIALTY_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."specialty_ID_SPECIALTY_seq" OWNER TO postgres;

--
-- Name: specialty_ID_SPECIALTY_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."specialty_ID_SPECIALTY_seq" OWNED BY public.specialty."ID_SPECIALTY";


--
-- Name: stadyingPlan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."stadyingPlan" (
    "ID_SETTING" integer NOT NULL,
    id_group integer NOT NULL,
    "DateStartStuding" date NOT NULL,
    "DateEndStuding" date NOT NULL,
    "DateStartSession" date NOT NULL,
    "DateEndSession" date NOT NULL
);


ALTER TABLE public."stadyingPlan" OWNER TO postgres;

--
-- Name: stadyingPlan_ID_SETTING_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."stadyingPlan_ID_SETTING_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."stadyingPlan_ID_SETTING_seq" OWNER TO postgres;

--
-- Name: stadyingPlan_ID_SETTING_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."stadyingPlan_ID_SETTING_seq" OWNED BY public."stadyingPlan"."ID_SETTING";


--
-- Name: subjectPay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."subjectPay" (
    id_teacher integer NOT NULL,
    type_pay integer NOT NULL,
    id_subject integer NOT NULL
);


ALTER TABLE public."subjectPay" OWNER TO postgres;

--
-- Name: COLUMN "subjectPay".type_pay; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."subjectPay".type_pay IS '0 - ставка, 1 -почасовка, 2 - замена';


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    "ID_TEACHER" integer NOT NULL,
    "Name_Teacher" text NOT NULL,
    id_position integer NOT NULL,
    id_department integer NOT NULL,
    "Email" text NOT NULL,
    "Rate" real NOT NULL,
    "Hourly_Payment" real NOT NULL
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_ID_TEACHER_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."teachers_ID_TEACHER_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."teachers_ID_TEACHER_seq" OWNER TO postgres;

--
-- Name: teachers_ID_TEACHER_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."teachers_ID_TEACHER_seq" OWNED BY public.teachers."ID_TEACHER";


--
-- Name: timeTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."timeTable" (
    "ID" integer NOT NULL,
    id_classroom integer NOT NULL,
    num_lesson integer,
    type_subject integer NOT NULL,
    id_type_week integer NOT NULL,
    "Date" date,
    "Time" time(6) without time zone,
    id_discipline integer NOT NULL
);


ALTER TABLE public."timeTable" OWNER TO postgres;

--
-- Name: timeTable_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."timeTable_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."timeTable_ID_seq" OWNER TO postgres;

--
-- Name: timeTable_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."timeTable_ID_seq" OWNED BY public."timeTable"."ID";


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transfers (
    id_lesson integer NOT NULL,
    date_from date NOT NULL,
    date_to date NOT NULL,
    num_lesson_to integer NOT NULL
);


ALTER TABLE public.transfers OWNER TO postgres;

--
-- Name: typeSubject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."typeSubject" (
    "ID_SUBJECT" integer NOT NULL,
    "Name_Subject" text NOT NULL,
    type_lesson character varying(1) NOT NULL
);


ALTER TABLE public."typeSubject" OWNER TO postgres;

--
-- Name: COLUMN "typeSubject"."Name_Subject"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."typeSubject"."Name_Subject" IS 'Тип предмета (лекция, проработка, семинар, консультация, экзамен, зачёт)';


--
-- Name: COLUMN "typeSubject".type_lesson; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."typeSubject".type_lesson IS 'Тип предмета, к чему относится 
Сессия - С
Обучение - О ';


--
-- Name: typeSubject_ID_SUBJECT_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."typeSubject_ID_SUBJECT_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."typeSubject_ID_SUBJECT_seq" OWNER TO postgres;

--
-- Name: typeSubject_ID_SUBJECT_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."typeSubject_ID_SUBJECT_seq" OWNED BY public."typeSubject"."ID_SUBJECT";


--
-- Name: week; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.week (
    "ID_DAY" integer NOT NULL,
    "NameDay" text NOT NULL,
    "TypeWeek" character(1) NOT NULL
);


ALTER TABLE public.week OWNER TO postgres;

--
-- Name: COLUMN week."TypeWeek"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.week."TypeWeek" IS 'Тип недели (V - верхняя N - нижняя неделя)';


--
-- Name: week_ID_DAY_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."week_ID_DAY_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."week_ID_DAY_seq" OWNER TO postgres;

--
-- Name: week_ID_DAY_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."week_ID_DAY_seq" OWNED BY public.week."ID_DAY";


--
-- Name: classroom ID_CLASSROOM; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom ALTER COLUMN "ID_CLASSROOM" SET DEFAULT nextval('public."classroom_ID_CLASSROOM_seq"'::regclass);


--
-- Name: department ID_DEPARTMENT; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN "ID_DEPARTMENT" SET DEFAULT nextval('public."department_ID_DEPARTMENT_seq"'::regclass);


--
-- Name: discipline ID_DISCIPLINE; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline ALTER COLUMN "ID_DISCIPLINE" SET DEFAULT nextval('public."discipline_ID_DISCIPLINE_seq"'::regclass);


--
-- Name: faculty ID_FACULTY; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty ALTER COLUMN "ID_FACULTY" SET DEFAULT nextval('public."faculty_ID_FACULTY_seq"'::regclass);


--
-- Name: groups ID_GROUP; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN "ID_GROUP" SET DEFAULT nextval('public."groups_ID_GROUP_seq"'::regclass);


--
-- Name: position ID_POSITION; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position" ALTER COLUMN "ID_POSITION" SET DEFAULT nextval('public."position_ID_POSITION_seq"'::regclass);


--
-- Name: specialty ID_SPECIALTY; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialty ALTER COLUMN "ID_SPECIALTY" SET DEFAULT nextval('public."specialty_ID_SPECIALTY_seq"'::regclass);


--
-- Name: stadyingPlan ID_SETTING; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."stadyingPlan" ALTER COLUMN "ID_SETTING" SET DEFAULT nextval('public."stadyingPlan_ID_SETTING_seq"'::regclass);


--
-- Name: teachers ID_TEACHER; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN "ID_TEACHER" SET DEFAULT nextval('public."teachers_ID_TEACHER_seq"'::regclass);


--
-- Name: timeTable ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable" ALTER COLUMN "ID" SET DEFAULT nextval('public."timeTable_ID_seq"'::regclass);


--
-- Name: typeSubject ID_SUBJECT; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."typeSubject" ALTER COLUMN "ID_SUBJECT" SET DEFAULT nextval('public."typeSubject_ID_SUBJECT_seq"'::regclass);


--
-- Name: week ID_DAY; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.week ALTER COLUMN "ID_DAY" SET DEFAULT nextval('public."week_ID_DAY_seq"'::regclass);


--
-- Data for Name: Spec_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Spec_discipline" (id_discipline, id_department) FROM stdin;
35	84
36	84
37	84
38	84
39	84
40	84
41	84
42	84
43	84
44	84
45	84
46	84
47	84
48	84
49	84
51	84
52	84
53	84
54	84
55	84
\.


--
-- Data for Name: classroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classroom ("ID_CLASSROOM", "Housing", "Num_Classroom") FROM stdin;
14	4	1
16	4	2
17	4	3
18	4	4
19	4	5
20	4	6
21	4	7
22	4	8
23	4	10
24	4	11
25	4	12
26	4	13
27	4	14
28	4	15
29	4	16
30	4	17
31	4	18
32	4	19
33	4	20
34	4	21
35	4	22
36	4	23
37	4	24
38	4	25
39	4	26
\.


--
-- Name: classroom_ID_CLASSROOM_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."classroom_ID_CLASSROOM_seq"', 42, true);


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department ("ID_DEPARTMENT", id_faculty, "Name_Department", "Logo_Department", id_classrooms) FROM stdin;
81	13	Автоматизированных систем управления	iVBORw0KGgoAAAANSUhEUgAAAMUAAADFCAYAAADkODbwAAAABGdBTUEAALGOfPtRkwAAACBjSFJNAACHDwAAjA8AAP1SAACBQAAAfXkAAOmLAAA85QAAGcxzPIV3AAAKOWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAEjHnZZ3VFTXFofPvXd6oc0wAlKG3rvAANJ7k15FYZgZYCgDDjM0sSGiAhFFRJoiSFDEgNFQJFZEsRAUVLAHJAgoMRhFVCxvRtaLrqy89/Ly++Osb+2z97n77L3PWhcAkqcvl5cGSwGQyhPwgzyc6RGRUXTsAIABHmCAKQBMVka6X7B7CBDJy82FniFyAl8EAfB6WLwCcNPQM4BOB/+fpFnpfIHomAARm7M5GSwRF4g4JUuQLrbPipgalyxmGCVmvihBEcuJOWGRDT77LLKjmNmpPLaIxTmns1PZYu4V8bZMIUfEiK+ICzO5nCwR3xKxRoowlSviN+LYVA4zAwAUSWwXcFiJIjYRMYkfEuQi4uUA4EgJX3HcVyzgZAvEl3JJS8/hcxMSBXQdli7d1NqaQffkZKVwBALDACYrmcln013SUtOZvBwAFu/8WTLi2tJFRbY0tba0NDQzMv2qUP91829K3NtFehn4uWcQrf+L7a/80hoAYMyJarPziy2uCoDOLQDI3fti0zgAgKSobx3Xv7oPTTwviQJBuo2xcVZWlhGXwzISF/QP/U+Hv6GvvmckPu6P8tBdOfFMYYqALq4bKy0lTcinZ6QzWRy64Z+H+B8H/nUeBkGceA6fwxNFhImmjMtLELWbx+YKuGk8Opf3n5r4D8P+pMW5FonS+BFQY4yA1HUqQH7tBygKESDR+8Vd/6NvvvgwIH554SqTi3P/7zf9Z8Gl4iWDm/A5ziUohM4S8jMX98TPEqABAUgCKpAHykAd6ABDYAasgC1wBG7AG/iDEBAJVgMWSASpgA+yQB7YBApBMdgJ9oBqUAcaQTNoBcdBJzgFzoNL4Bq4AW6D+2AUTIBnYBa8BgsQBGEhMkSB5CEVSBPSh8wgBmQPuUG+UBAUCcVCCRAPEkJ50GaoGCqDqqF6qBn6HjoJnYeuQIPQXWgMmoZ+h97BCEyCqbASrAUbwwzYCfaBQ+BVcAK8Bs6FC+AdcCXcAB+FO+Dz8DX4NjwKP4PnEIAQERqiihgiDMQF8UeikHiEj6xHipAKpAFpRbqRPuQmMorMIG9RGBQFRUcZomxRnqhQFAu1BrUeVYKqRh1GdaB6UTdRY6hZ1Ec0Ga2I1kfboL3QEegEdBa6EF2BbkK3oy+ib6Mn0K8xGAwNo42xwnhiIjFJmLWYEsw+TBvmHGYQM46Zw2Kx8lh9rB3WH8vECrCF2CrsUexZ7BB2AvsGR8Sp4Mxw7rgoHA+Xj6vAHcGdwQ3hJnELeCm8Jt4G749n43PwpfhGfDf+On4Cv0CQJmgT7AghhCTCJkIloZVwkfCA8JJIJKoRrYmBRC5xI7GSeIx4mThGfEuSIemRXEjRJCFpB+kQ6RzpLuklmUzWIjuSo8gC8g5yM/kC+RH5jQRFwkjCS4ItsUGiRqJDYkjiuSReUlPSSXK1ZK5kheQJyeuSM1J4KS0pFymm1HqpGqmTUiNSc9IUaVNpf+lU6RLpI9JXpKdksDJaMm4ybJkCmYMyF2TGKQhFneJCYVE2UxopFykTVAxVm+pFTaIWU7+jDlBnZWVkl8mGyWbL1sielh2lITQtmhcthVZKO04bpr1borTEaQlnyfYlrUuGlszLLZVzlOPIFcm1yd2WeydPl3eTT5bfJd8p/1ABpaCnEKiQpbBf4aLCzFLqUtulrKVFS48vvacIK+opBimuVTyo2K84p6Ss5KGUrlSldEFpRpmm7KicpFyufEZ5WoWiYq/CVSlXOavylC5Ld6Kn0CvpvfRZVUVVT1Whar3qgOqCmrZaqFq+WpvaQ3WCOkM9Xr1cvUd9VkNFw08jT6NF454mXpOhmai5V7NPc15LWytca6tWp9aUtpy2l3audov2Ax2yjoPOGp0GnVu6GF2GbrLuPt0berCehV6iXo3edX1Y31Kfq79Pf9AAbWBtwDNoMBgxJBk6GWYathiOGdGMfI3yjTqNnhtrGEcZ7zLuM/5oYmGSYtJoct9UxtTbNN+02/R3Mz0zllmN2S1zsrm7+QbzLvMXy/SXcZbtX3bHgmLhZ7HVosfig6WVJd+y1XLaSsMq1qrWaoRBZQQwShiXrdHWztYbrE9Zv7WxtBHYHLf5zdbQNtn2iO3Ucu3lnOWNy8ft1OyYdvV2o/Z0+1j7A/ajDqoOTIcGh8eO6o5sxybHSSddpySno07PnU2c+c7tzvMuNi7rXM65Iq4erkWuA24ybqFu1W6P3NXcE9xb3Gc9LDzWepzzRHv6eO7yHPFS8mJ5NXvNelt5r/Pu9SH5BPtU+zz21fPl+3b7wX7efrv9HqzQXMFb0ekP/L38d/s/DNAOWBPwYyAmMCCwJvBJkGlQXlBfMCU4JvhI8OsQ55DSkPuhOqHC0J4wybDosOaw+XDX8LLw0QjjiHUR1yIVIrmRXVHYqLCopqi5lW4r96yciLaILoweXqW9KnvVldUKq1NWn46RjGHGnIhFx4bHHol9z/RnNjDn4rziauNmWS6svaxnbEd2OXuaY8cp40zG28WXxU8l2CXsTphOdEisSJzhunCruS+SPJPqkuaT/ZMPJX9KCU9pS8Wlxqae5Mnwknm9acpp2WmD6frphemja2zW7Fkzy/fhN2VAGasyugRU0c9Uv1BHuEU4lmmfWZP5Jiss60S2dDYvuz9HL2d7zmSue+63a1FrWWt78lTzNuWNrXNaV78eWh+3vmeD+oaCDRMbPTYe3kTYlLzpp3yT/LL8V5vDN3cXKBVsLBjf4rGlpVCikF84stV2a9021DbutoHt5turtn8sYhddLTYprih+X8IqufqN6TeV33zaEb9joNSydP9OzE7ezuFdDrsOl0mX5ZaN7/bb3VFOLy8qf7UnZs+VimUVdXsJe4V7Ryt9K7uqNKp2Vr2vTqy+XeNc01arWLu9dn4fe9/Qfsf9rXVKdcV17w5wD9yp96jvaNBqqDiIOZh58EljWGPft4xvm5sUmoqbPhziHRo9HHS4t9mqufmI4pHSFrhF2DJ9NProje9cv+tqNWytb6O1FR8Dx4THnn4f+/3wcZ/jPScYJ1p/0Pyhtp3SXtQBdeR0zHYmdo52RXYNnvQ+2dNt293+o9GPh06pnqo5LXu69AzhTMGZT2dzz86dSz83cz7h/HhPTM/9CxEXbvUG9g5c9Ll4+ZL7pQt9Tn1nL9tdPnXF5srJq4yrndcsr3X0W/S3/2TxU/uA5UDHdavrXTesb3QPLh88M+QwdP6m681Lt7xuXbu94vbgcOjwnZHokdE77DtTd1PuvriXeW/h/sYH6AdFD6UeVjxSfNTws+7PbaOWo6fHXMf6Hwc/vj/OGn/2S8Yv7ycKnpCfVEyqTDZPmU2dmnafvvF05dOJZ+nPFmYKf5X+tfa5zvMffnP8rX82YnbiBf/Fp99LXsq/PPRq2aueuYC5R69TXy/MF72Rf3P4LeNt37vwd5MLWe+x7ys/6H7o/ujz8cGn1E+f/gUDmPP8usTo0wAAAAlwSFlzAAALEwAACxMBAJqcGAAA9UFJREFUeF7s/QdcFMvWNQ7XOcZjFkmSQRQVRRAVELMomHNACWYkiKigBEFBEXPOOeecc86CCUXFnCNKzrC+vatnkOM597n3vs99w/P/ffNz2zNNT0939V6116raVSUA/H/AChQrpPds/+jvv+7nYwvU28Ki/YV/e47iViDycrNFWlqatJS079K+fPsoPn5+V+ndh7dWZJ1evXk5/Enis/DYuDuLL1+5uePkycunDhw4Fbtn55HEndsOfti+/XAyWfbWrQcLduw4gn37jhUcPXo2+/SJy8nnz1z/cPnSjcSbN+7E3rh++9STxy92vH//cXFqano4XcNwsk503VZkVZR7zxe5dE15eTkiMzNT5OTk0H0Uv6ef7+W9FrvHQrXROYrK8U/loX7/D8rxH+7/P2vq+/jn1/Nf//1vd/7ft392U/9rVog8afKhF3OKAuTTfuX32AH4vfKZjBxF7iPLK8gXmdlZIiU9R/xIRrmvH9Ho5WN4xN9E9NVTBTv3b0iPWxL9/EdUYCx83A6je8t5aF47CE3MfFBXtzdqajnBRKMxTCvVg2nlmjCuZAqD8vrQq6gJ3fIa0CxfSbE/KkOzrAY0ylaBZjktGFdpAPNqLWGp74JGFm7o3Wkyxo/aimkTT2Ddkvs/Th9Oinv+CDs/vUL05zfw+PYJjb99ya7w5dNX8f7tB5GU9ENkZGSJ7Jx0uq9cMrXzqOyX8vhpShmoy+MvTvcPv/d/2X69rn/2+Rf7253/901V6H/7t/91Y0AUkFP8WihFD11VI/4EiWISEHl5humZGT3fvHsbdf7S9QPr1h98GR6yGP17hKJFYx/U0B0A/QqeMKgwDHpktfXGoo1NJPq2nouh3ZYhaOg6TA3chBlha7EgYjUWTFqChZGLsTR6CZbOmI9Vc+nzjNmYPWUaYiZGYcqESEwcG4rxfhPgPSAEAzoEwcV+OJrU8UBt497QqeRMoGmHyqXaoFLpltCs1AJ2DfqjX/cxmBS2EOvW7Hp5+uSZA/fvxke9ePGq57NnL0xfvnoqPnx8I758TRLJKWlF9/+PnUR1/2RKmfz/QfH/oKkd9e/+9tO5i276l5svogf/4DxFD52/U4BKBbnomPIVkbcv5R1bPP16kteAdeSU/qhRxRkmlcxhbVoBzo6/wbWrQFSwwLqVAjeulMPD+Ap49fx3fE8SyM7+HfkFv9HpSxIjqYj8HCPkZDRFbqYjCgqqAoWllZ/ny8k1QGGOFXLTXaQV5OmhILcibUsjK0MgM1UgK/V3fHhdAnduCpw+IbB1k8D0SIFRwwRcWgrY1xcw0ymF6hWMYFrFCQ51AjCox0ZMD7mZtG/rx2NXzv2IfHD3c8eXz79UffbynXj59p1ISUkRWVlZfy4LVQXx71nxsv1r+f60f/b3/679e7//E+yKFb35n2H/9c3+M1Cov/8THMp+tQNQweiTub98/mrlof2nEoYPmQAbyx6oUqo50RkXmFTrD+emkxA0ZAXWzNqAc/tX4UPieqR+nIOspLHITnOVzp6bbYO8bEMUFlRGYWFZuoQSEhjZOWVxN07g4F6BC2d+x6tXBBr2Rf55sncvf8Oe7QILZwusXCxw6YJAekpJutSyiuWXIdD8gZRvlZCbYUEAs0Z2hhOyU/oj/etYvE0MR/z1+Ti8YxkWRi9DgOciONtFoIbmcGiV7gfdyt1hZzMYXkMnYvHCdQmHj51eeT/hkfuTJ0+Mnz9/Lt6/fy++f//OUbGobP49Uz8ftf3dMWz/7O//Xfv3fv9/OCjU9s9u+l80Bkw+tLJS4fYwLn/tklnXXrp2mwWdyvaS09eqLigSCISOJ0feI/AknmrqtAokM6qRw1cgRy4hrSC/EvJz6+HBzRU4tn0PNi3ajwMbzuLsoQ1IiFuKtG+heHzPE4HDTmNYz6Pw6HRY2sDOGzBm6HIc2RmOk/ui4OoyG60ahqO5jdrGwK17MA5s74KPL6Zgy4pJGNxzOHq1H4v+nSYgYlwYLp8IoQhjhoJsE4oqpgQUE+SluUgrzK+KlB8l8fChwMnjJRA1UaBrWwErs7IURaxhqT0YvZ3mYE7UtZen9qeuvX39m9uzxE/VX7x4IQGSlpUp8gitf40a/6Hy/5dN/Xv/2u/+dHLl+KLPqkqyqPIssp/fZfvLjv8Z9vc3829a2y+fkuYsXbg+3rX3WBhpt0Olkq2gVd4Zndr6SU5/dMc0vEmIQnqyL9XMrYEcY6Qklcb7twKfPgqkEZ0pLPidgFEF164IBPk2ha/bYIz2nCjNd1BXTBzXDOtXWCB4jMDI/vsxauA5+Pa/gOE9T2FIr+3o1yECA7qZkbNqw8UuDJ1bzECH5jMIjDFo3zQUrRq5oWcH+q5nSfpsAmf7TmhnPwztHYajdZMW6NG+NDavE8hJN8DHd+Wxn8C7apHAvm0CL57R9REw8vJMkZ3ZGpnJI/H11QJcPLoas8NWwbPjEtSpPoSEfVepifp2D8T8uavjL1y4MOfly5ftn79+Jd7RjXJr1p/L7j9S/v+GqX/vX/vd/4+D4u8v+h+Z+uaL0yPZvKoujEJUz82Cd+zlgsPhY3cXmmk7oXo5U9Q2EuhLumDpHIEHd4m7Z1Yg/k8Rgfg+GzvVh5cuiAldDPeuC+DZYytG9N8DH7dtmBF8GkumnsTIfnMwZtB1BA65jfGD4qSNG3wHAR6x8Op+EcO7nseQ7pvh77Yf/gPOwLvPcQzrvQce3TbDteM6dG+9EG3tA9GhRSg6No+Ci+NktHMMRftmYQSASDRrMAGONiNoXwCBIxjtHMLQscVkAk842jUZhZGu8zGw+0x0aBaFri1Xo0ebdRjQeQVmhu/A+5e9kJfVhCKJsbQiTZOrhcRHAjvWCwzrL2BdqwT0KlqigWkAAoYcKDy4/d3hJ/E53l8/ZhhlpGWL3NxcpayLlaksV1W5F38Wf7Z/9Bz/vef779u/e37l+F92/r9m/95N8YMpkOE+X+Tn54qcnDxRUED782H1Iyk5aufOo3dbNR+ACiWbo1KJ5mhq5YaI0dNw9nAkkj+FIzelN/KzayI5uTRevRb4/FkQIErg2zcNhBOF6uHkQZRnHjy6b8GwvrswcsAW+A1cB98B8+HVdzaG9DiBMZ63EDzkDiYMvi1BMXYQgcTzHoI87sLXdQ/cO62TgPDrT5Gi5y4C2SYJil5OS9DNaTJaNR5DIIgg546Ec/OJcGoaIkHh3DQKbR380ayhF1yahUowdGg+id5HEAjGUwQZTd8djd7Oc9DPZQtd5w66zjWSZkWGCbx8qofkJA0pzrdsELh4tgTSkstLYOSndUfax2jcurAWU8YvJgoXCa0yfaFTsQM6tPXG2pXb7z5LfBmVlpZmy8AoyKNK538gKP5544Fy/C87/6eY+mYVKxLKBAbuwMrKypCAyE6Fw5snWLB81r03jWv7E03Qg6W5wCgvgUP7Bb584q+TECaKkZtTE0d3h8HXYzT6uoSgW+ux6O0SgJFuU+HZOwJtmozEgE5zZW0/tNdueJFjj3Y9i3FuVzF28C2MGxJL4DiOwd33YrTbcUwYdh6Bg+MU87iJIALLGI9r8O53ivTESgzrsZ4o1C4M7roNAzusQe+2i9Cj7Vx0ahmJ1o18KFKMQQcS9S4EECeKCu0JBAyAlrZBcLQeSRGFgECfO7SYQpElGt3azJSRg4Hi2nk1BnbZgkHddmF47/30G9sxotcejOy7EZ5dVhBoDhBojsDbfR0ObV2DzJymUidJwU/F+yO1FI4fZzooYEPlpV3ajiLVMCyaee7NywQsyMtCC9JiIpcsn0HBFU8xy+P9tP1nVvQdOl5a8X3FTf33f3bcL8bXJn9H9b08+sxW9HeV/fpZKYX/YfZ3TasFBQUiIyNNZGdn8rZpQsLjJVMjln+pZeiCKiU6wMrUC6GjJ+PquVlI/z4WuUQn1K06DIqdOwRRk3Jo28QZ7exGwtnBh2rjoeSIw8j5RqBzq7Ho1GwS+jotx/A+e8m5TxaBIsDzhgRG0LCLtD1HDr8HXuSM4wbFSlCMp+049xsIcL9K9Ok8/Fy3Y6DLMrIN8Oy8BQNcVqOP02IC4mwJik4tAtHK1htOjUMlMNj5GRTtm05UgNHIDy1sfeFCAGBQdGoxDV1aTUcvZ9Yjk9CdAObRfTs8u+7EsF77MLLPPgLgbvRpO4/AvIGo1kUM7X0GQ/utgEcPF+zYLVCQp6GAgoo2r7AqsrMbIeNrMK6emI3xI5bB0qgXqpRpBnP97ggaM/3L1UsJS54+/9Yq8dlX8eL5D5UliefPvomnz76LxKdJ4tnzFPH8RSptf8h9v9pztT1NVqz4vuJGf3vxjM71y3Hq3/vTsXL/V9p+EU+fk/Fn+i7b0xd0HWTKd5TrlJaonIOvmT9Lh/p/z346+58//7qfAVIohWA6cd70ZDR8dBsLooNuf7bWHw/jytXR1Ulgw0YWnbrIk02lNvjwOAjXT47GyQNDcO1sDPZsmkkO1x5O9lT7kvN1dJwonbFj00h0aU7O1nY2+rZbhD7OS6k2XyhtaJ/N8HMnYHhcxjjP+xjrcY+ixQNpgYMfwK/PDQzqOYW0xww6bj0dt1cR2a5n4NN/L4b2mIcBPXQxxNWE6JMzerUZRiI7DJ2as44IQCuHgWjRuALaN9dESzsPtLWbAJemMQTWabSNRkubiRIYHDE6tZiK7m0WkC5ZTDRsmQTGgK7ziZ4xKA5hRO9jFCVOEAA2EJ1aBa9+JzCi73FpQ3oehlv3uVg+6yh2b9mNKcGTET4mGmvmbsLLxOHIym4om5afk2hfME/QdQnolakJM80OCA889PnWRSx48gj2ZIIt8TFbgbTHj/MVo/3SHheqLFdlqr+r9j96giJLoM9qK75Pbp/kS3uUWKDaT38nS6DfeKSyhASIh7TvIX+m92x8HJ+DfzMxUdmyPaH90p4USPuTg/2/Y786f3FAMF3iyACKCkr+UUZGhknikxdR82Ztfd6g1kDolBmEDo3mYePC1Xj/dBE9WHvkUs33+oUO5pOYHtST9EFbgY6tBTq1KY+OrSzQomELNLcZLQVsh6YkYknodnKMkqDo1nI61eQL4Uq0Z3CvjVQLr0O/Dsvh1mUnRvQ5Bd9+NyUwJCCGPqSIcBfePSmCDFmEuZMPYHb4eYSMPC6jBNOn0e6HEO67A4d2jkFC3GJsWDiPRHoUnXOaBEbnNuMxyDUMaxb7YtvaIAzsxa1QgXCwDIZj/VA0bxBK78ejmY03WjfxJ70xmaLMfBLXS9DXeSX6dpyNrm2mEs3bJUExvNdRDOt5BCMH7kIfl+UY3OMQRvY/WQQOr4FEqToGoUfHHhjafxA8eo4goHrC31vg8hWSDdzfQpaR1gOJ8VMwPWgRrM36oUKJNjDV7YdxY1Y8v3r5WxSBohaD4skjcjSyIqdnQJA9IQdWLE9lihOq999/kCfiH+aT5dH73GKm7H+QkE9OXkDOnldk9+JzRdydTHErNltcuZouTp78Jo4d+ywOHPgotmx/LjZvfSk2bngqVq96KK5cS5ag4N989Civ6PoeJRBA5PUp+1VO9z/HODKw2EtPTxdZGSj36TV8tizJut7aZhGMq9iQQ1TCwX3c6VVB+QpTgjxDvHhgR1x7AVo2JJFqNxku9pGyhYc745iWcIRo0WgcHBr4y1YeFq6dHEPQvWW0jAw926wkp10Pj257iYqcwai+FzG490CM9q6PedPqIHSMJsZ5WxIPr4+YMC0c3F0Fb97w75cnHJdG2g+BV88Fnj0R+PSeKEouN+X+VmQFuQIfaP+zpwJvSORnZtLfVfVARrLA9csC61YIzJ9JNfZsRSw/vCdw9KCAR1+BLq3roFOrQejRbhT6dghC19aj0LWtP4YPiCZdcZrAewbevU/Qte9Ff+cl8O6/lQBBn0kbcSRhjdSz/XwM6r1WHjOE9Egf53UUgVbi7NEOyE1vT7qrAfKza6Aw1xgf3pTBrBgBB2vSHKVsYFd/CObFXLyecBs+TxJQ4cmjQpHIji8jghIJfoLgz2BQf753p1DcvwvxIJ4c/gEBgMAhjd+TPSJAJBAwEhJypfPy+/j7+eLunRwRd6tAnDmbLg4cyRDbdmaJtRtSxZq1KWL5im9i9pznYsu2VHH/Xo5IeMiOr/z24wS6PgIvA4XB9jiB9tN1S0f7n2Lc00pRQVpqamq7M6du7HLtGQHdsj6ws5iBFTN34cuLjbKXtzBPW3Eq+mp+th5mRwk42U2U3Ltzs2iiRlMUQJCQZVBI4+ZPsjb2o9CiwQi0bDAKLnbhRFmmo2uLpejdfg36tN+CPm32YFiXE5gzOQaJD5Yj+eNMvH4chmf3F+N5/BK6hmBkp/aVaRyF+X9IUKCwDF2TrjTkV6SatxS9Jy5PYMjPoevkBh1VjZyfVx65ufSdbNpPfyvMKYOCHCNyTCfkpLVFbgZZZkvaZy7t2YPR2Lg0AoHeMzDcNRIjXKMxwWcppoZsxuC+kXDrdAhefc9KUPj2J7rUaQXpjdUUKU5iGAGCQcHRZEDX5ejTYRGJ8n0SFG5dt6KnEx3nKRB7VRfXriq98QxQBkZm6kDcuRpJOmoO9Ku2h0a5dujsNAmbN8TuIufqqAYFOyA7YlHkKDIFLOrPt25kk3Pnint3syUwFACQkSNL40hBIGFAMIj4nA/iCUx3c+m7eeLkqRSxffc3sX5Tsli+6ptYtvyrmDP3tZgy9YE4dYYpFDm/CmwSGASIp08UQDANY0D850FBtEZpolN1jqg+F1V5/+D4n/v+/jhu7svOzREZmdyyBP3ndzE1etyVjxY6fdDYuAnmzRB4+9oQuXmm0t48Wob9G9dh4dQlmB66FqH+S9Gx2SjZD+DSPETydjaODuooIUWsHVEne9ITjtPp7zOJxw9HczsLTAgQCBkrEOgnMCOylMw3uhPHl0a1OTivSW3KJRfSe5mdrTJwB18+/Z22DIRCBgHnJfJ71We2/CzV+9wS0pBB30mnz5k/DXxMBp2HDBn0mY2zMgp+k+fKShMyKhXklJSAfBAvMH1KJQx1bUIAiCYgTMfQvlPRw2ksPLtvwch+RyiSHKZIQtteW9Cz1UICxHbZKubWZSP6d1iJnu3mUIUyicpjEtHMULRuPI5AFoVbVzohN8seBfm6uHlDYIiHgIEGWcWuFDW3f7x/G1OJUpkUgUBFoxIktycnJUdU6IwSMe7cy1Zo0PUMcf1Wtoi9ky/u3OfIQZTpAekLAoZ0anJiNjVoGBTXLueJw4fTxaYtyWLpik9iwcLvYuacTBE44ZWYN/+uuEfn4UiQQFSMz6EGGZukTnQ9apBSaf7ZAf9bpnLy/yQoODpwujbbj+TU7nv3Hj/ZpnE0jCp4YGCnGbh36j6yUgZKzZCTa4KLlwTG+1rCz2MgvFx94N5tHFGqsUQFgmXHGPcDNG/gh9a2AbJ5Uw0KbtVhQHR0CEc7u6loYR1OwnsEViyagrRvI/Ht/WB8fDkUqV/8kZPZAXk5lsin2r2Ab1Pt/HTJ/DlfZX8CBaeEEDA4MiCPAUKfOUmQP+eSQxcDRkaK4twMCGmcH5Vfkoy+Q9GjIJ2+n8nvCTz09wLaJ7/PAGMwFRAgckuhIK8sOawmkj6Nw9nDCxAzYTvCfFdTFFkubXjfXbIJ2asvaQ7SHl59tmGAy0q4tl8ngcGg6OfCemOhBIWT/WR0pkjboXkY2jb0gGsviiA3yklQsCV9Dsf6pWGwr+ODiqQ36tbqj3VrrpykWr031+5cU7MVBwWb2hl534OHBA5yYAbE1RuZEiB3bmdLmhR/n2gTfZ+1BRt/h2t9/huDYt++H2LVmk9i8bIPRJk+i4jIL8Lb76E4TJSKhfgj0iUPSYMwKDgSPSC9IoFBAJGApfMxOKm0fzrgf9d+duKwY7P9eoxq/1/AoDJuapXNrTzuIVfkEq/g6JCTCd0XCYgOHHY1yaTCaHLqstizyZicsiw5XWk6FWeglsDxTbEY2XsPCdlb8BtwXdIC7lPgHCN+uD1bz0OP1jMlALi2a2YzCg5WI9DCtj6cm+uhnaMOnFsI9O4mMClM4MYtupT8cuS05NQ5P2t66chc8+fRZ3Lognx2+pKkE2ogK8uOHLqntLx8A7o++j7fFn9PVSRvX/liYkhJLFtUHnkZHYoAwc5dkPUbhrs3Qcc2+njzkr9XAT/et8fG1QKb1v6OL+87EBjKIS+9NFGpdtLUEYN/Q7kuuiYV9WLA8XUyUIBSVHGQXuHjqbxePq+AiRME3LqFq1qqzhBITqJbm8Xw7LkZAzlSdFwnxTmXW1vbMejWkugklR83B7doSJVNu2l4/9oeeVm2suOzIKcWXbc2poYLGGmWg0bZ+hg5aHVS7GVEP3yQbpjwMIMcMo30Rg7VztmSwiQmqhxSRV/4Pe9jJ46n6MF06nZchrgVly6jCTuxBBhHDALF/QcF4vLlTLFrV5qMELPmpIjIKR/FMK/rInr65yLnl4BiMJAxwOLjc+Tf+L06cvA5qXR+ccz/hv23QaH6ewF5SE5uhsjKyRTpGVmtjx+5ebCtoz8MKvjDi7hvwvUNyP7uIx1ODYrvRBnCRsxD8LAzGD/sPvzdbspmyEHdd8gar3e7pejRai5pgxjZF8C9wh1bhqFpAy+MGNgHuzdOwq4N4Th5IAD3YgOIggxAfqEW1dzE/Zm2cG2sdjpVra8GRSHV+knfBE6fEti+XSCAaNYob/p8hmp+Aq66/Z+jBgPjwF4HaFYlkdpY4OWT+vQ3Og87MDlzJolqOwK9oZbACxLdDIovr1qjcQOBRmQvE1vQcRXx7KGAp6ugSEbfyyGnz/6NqIwasPSZt3xOBofqOvMJ1Gycr1VA15+XUxtvng/H9LAdVE7bSYAfgKvLQbSzn4nOLRfInvt+HdaiV/ul5Pxz4dRoLDo4TJCgkOYYRrorAFMnC1y9qIj+W9cE8rIbIJe0z871S9HWwQMVSraCraUXtm+7djD+fqrz/Xsp4tbNL+SIGRIUUvQSEBgETHEU/aECCFMeFW3iliY2dU3Px7Ej34unqHI1W+zcmSrmzvsqpkR/FqNGx4sR3jfFoaMELtVx/B1Jv9TGIp5NdT71Zyqxv3PO/92mOP/fgYg74Tg7MyMn/7ePz+A/d9LFRAvdbmhq5oR9O+mQ3Pr08Jsii4Tsi/it2Ld2P7YuOYL5ESfh3nkn8eODkgb49N8Jr/47MKzPVgLFetlU2aPNInRuMUsR2PbeaGOnT9xX4NtH/nkWw+TsbHmliLKQY2WS49M2L4NBUBXpGT3xPak3vnzuRZTNnRyrvGIkqGNvCmhXKo8a+rpw7SPQzF6glpnAuVNj6LboXAwKplEoQ6BpiTo1BUyNSKNMoZqeRHg+OXVBwR/48FmgQV1t2Frp4dtXY+Tm1MfrJxNQl87FUSzpXQcS2Q1xYI9AuTICg9wbKqAjO7hvELp1FthLf+Os2fycSgSqKuSk9RXjIMxglpRNBSCOIAVl8eK5kgm8ZrnA6hUCQaShernMRr9Oy9C7/RJpzs2CqczGyeZqtnZNGRyTZbRtYjkU9pZj0KxBEEYNGYmHt8fJMvtCZRtFUdFYW0CzXDdMHn8q8frlz/73bn/97dqNF+TQn8SjRBLVBAIGAANBTa8kUCRAGDjk2Or+CTUNI7CwM9+7XyguXMgQm7emiZiZX0XAuE/CzfOBWLr4oaRjSnOuAiz+zs/PHDkU0HG04IgT//D/WuvT34CCaBPrBx5bnFtYYHAnPmGBW49F0K/QDX3ah+PhmZf0oC2lvXttLgf0TAnuhIhRkxDmMxOhIzcjZCT3Lp8h2rQV7p3WEBCWy0Q7br/v0mIBnBpPQ5tGkWjTOBS92o3H4hmj8PG5H4HgDwr/Qta0eSoKIykJA4O3BeXx9LFAeIRAm9bk8I6kW0h8P3zAjl5BguLDu1JoVK8O3Pv0pCgTiOuXO0CzisCeHZ7K7bJDEuB44JFFDYHI8O7wHdkYdjYCyRRlWAswKBLJOWvXqIz6tTWxbq3AqZMCW9Y4oqahQN8upDe+9ZBUZc4MgfJlBZYuGqmcn0AxZbINKleg6EGOzenk7JQ3qeaeQjX5syeViGJSlOBopwKFBCrTvzyKtgU6MhOYK5vMtL5Uxm7wH7qNIup09HVZRuW1GJ1aTUTzhv4SENy5yaBo7zhJ9pVwxHVxjKQoE0G6zRFDBgo6B/8GVSZfx2P7uvGwsfAjreGCbp0CcPTQ3QU3br0yu3z1KYnqbxIU6kjxkICh1hoMCnWfAgOC+yaKBDtTHjIGxdmzqWLNum8iOOyZ8BzySIz0fSXOnqa/03F8PgaBGkRF/R4ECDUo2BgUbHTVvzrsf99+OrvaFBAUP0ZaMRrFESI/FyI7HfZn92B/M4tpsNDVwoIZFsgkCsNZq3m51nidMAihnu8w3vMtJo58i0l+bzBp5HNp4SMSETbsMYIG30WA+3USkqcwsOtOdG3ticF9TbB2FTkp0ZvrVwS+ct4Ti1fSCwwEtnyiL2xMZVjw8j6OIKePhqK+hYC+rsCA3gJeQwTqmFNNb0x0aet4ckjWEwLuA2zQuoUWzhzxwThfEzRvIvDo7nSiTWWJRpWWtf7eneUlKK6e98PZEyOhTTRq60bSFlmNpFi9f0+ghklVole/o0p5AY2KZJVKoVrl0hg+lPRAegdkpHXHME+ByvT3ebMC8DqxDzK+e2OwextUJ9rFLWOctpFGkW2sv4AW/cbBvW3oOpUWKgZBQb42cnLqIC/PUqFuapCoQUMR5Ou3cpgzhzRW+zro1nogurQeg1YNR6O9XbDs9VcnLLo4kj4jUHBGADdctLOLQot6wRjnZ4/kzzzHAp2XQPvsaUn4DRfQLdEMNuYDsGHZjf3XLn5pefHSQ3HteiLV6inS+dVgePCIqBKBQAFG8SZdihJEh3jLdOf2nTxx+myOiJmVI4Z6PRTuHtfF7JlJVPsrTbDcr6GYQpkYIAyKBPrbIwIDR4zirVt09yoH/Q/avwsK7pBjUKSnZvVeuXRbrGkVf1hqB2Hf+jVI/zZTAiKfauuszHpYMVcXEUM/Icr3Byb5fkCE72tE+rwkQDyVoAgZkoBxnrfhP/Aq0acz6NdxK4b0GYerp6KRld6FIk1dog2cQl3+ZzOnSicwIFJT+DPTHaVW5Zagdi1LQJ+cbdP6xvjxeQJSk4Jw+lhLWNUTaGpfVo6rYGCEjO8iKVErok5tmgq0pG3vLqXw5QtrCwUUXuTYTRoKnDw8CLu29qGIINCnh0B6cn0JisuXiGYQIDq0t8P2TYOxeF4XDOzXFZXK/YagcQJZGR3x+aMTXNoK6FRTHL5RfYoi3QTq1a4Im/oaFLXovvKr4fXbVmjuQNfQXeDz+5AiUBTml5F9DvPmCTx/XlGCQWnW5fugv6sEel6+HtJIyB/fOQcBQyait0sw0c4gNLX0Q+fmFCVU/TodmwehBfeuNx4nW/KcHabCpUkUnJr/gf07ahY9bm6ISP06AtPG7ET1Cm2gV6UNwoPXx54+c8f1/IV4cf7Cc3H3bnoRKBgQki5JQPA+BojSf6EGCovl2LgcsWPXB+EX8EK4D74jvEbeF7t3Em1SgSI+PovAkKMAgoU1AaI4KIo3+bIpV/t/yIqaaos+K6neDIyUJIwO9Dr6TrtUH/RoJxAfq08Pjzu/qpJo64LUj3Nx7cxh+LouQ9jIy5joFYuoUQ8Q5fcYk0clEDgeYaJPIonsBxjjeQmjSVMM6dOZOKwmnj+hnyPBWphdUkYAKZoJDPmZJNSzaxNnH4A1i/qQY9miWePq8POqiaeP3EioWuDiaYGqREmGuNtJh5Emb6EkZk9zgQFx5d3ExbNzbLFsgTNqUvTYf0D5vH/3KOjrCCxfxsNOmyIubgKBSMCcjqljQjSKrLapkN/Zuz1YNvMe3E+/V05QLdumaPadNcs9UOkP0h/TmOI1xa3LfvK7bZozDfsdg90EWpDz6xJIOjhZyKZi7jfZuNIb+rTPb6QRUlJCZMQqKChD0aY3/H0UUB075FIElu+fG0sKJbWPmmLJqKFEz08f6LkkCCyYXhXtm2sTVYqRxlGDI0hLGz90ak7A4Y5QMieHIHRtFYTQUTEIDxyCret8kUxUisFx/JiAfS0D6JazwtD+i98d3/919LmL98SZ83fEndtJRI9yCAjcc600l8r8JRU41MYOfO9uvoi7AzF/8QMx0P2x8Bj0VERMeiJOnsoXN+O4KZePIwrF+kEVIRgYCjiUdJIiUKgiCZfe/zH7O1CQlf36JTXSc2Bgtkap3hjSYwNexscgL72tBMSbVwKHdpcm/m+NyAn+CByyXqZm+/U7DZ8+p+HX9yK8+56jfdfhN+CmNE68mzj8GPZuWI4Pz0IJENVQmEUOkVWiqBaUnWDZFbBpjUDzxkqnk0l1AUvzsqhMTsk1ekFWTRzeK6RDho3vLgHB4lRSDHKcs8dDYUSUaik7PYHgAolqSxLQa9eReE+ywMql/aBHoGGOz6CYM8cOlYkOzZnuhNOHAnDxlC9WLmoLDQJd9456FAUssI6upxIJ6IlBnYqKbkqEEyqSflixVAHFrs2doV1ZIMCXO+oCkfY9AHt3WMrrDPDtSt+h+yMb420PA02B+nUE+vUjKveIz/cHXjxrhpakizo503V+CpegYGOdFk36Q0Y+VQtWUR8IG0WYvEIdpHwag4njOqORxXg42U2TuWIcQZo38KEoEahEC+77aR5CQBkBRysXApElOrSphJBAHrVI4p+AcePYHgLNMGiUaYseHaZm7953NpJAUe70qURx88bXfwgK3rLz3r2TRQBigQyxe3+yGDr8lRgy7KWYO++zOHgoXVy5niZBw/0YDAwGhRTY9F0GAIOCTa0t1JFEKfX/mLHDk6lpEe2TNEr1ufixTJny81Ht+ZPc+e0cg6FT0glTIolGpDrKoZOfPzhgwdRY+PW/hgkerzBx6HuEe33AVP8vFBkULRHh/QKhwyk6DH6Mkb1uInK8BR7cqYYUeqi57PzsHDyTBr8nEGRlGsuHkZVqQDWiMT3oGli+SKBMCQKGQ308T1Tyklo2tZC17jNyoru3qOYmB+zSqZnSDs8dVZy+UaiBJfN8Ja06tI9uL9cA3786oW0rAUebimhuWxkG9DePAT+F9Cyq6Yd6KD3OsoONgJVDThdGjhLgLZD0oSSunRcYMUjg+EE6hmt8uv4Z5KhmBNh9u3lfdYSOr0d0SmA1OXFudh0CShMJmPKkMRYtIoqYZ0CVyW+kg0qgo5MJdm41kiBoTfYqMQq7twVAq4rAYvpOAVcYDHIC/KpV7ihH5718gcFfg4BuIw053BpHpmqN42tn4Mwlse/UUqCt7QACgx/srQaR8A6CiwPpDXuiVc1CaP94Kc47tw6nKLKQIkoMJozqiB8fRsvI9f27gM/Q8tAtbygbQDYsfzr/zLnbOmcpYtyMfSseP8mWLU0KMJQt1/ZMmW7G5Ypbt6m2v8c1PcS8+UnC2+eamD77o1i7sYCEdp64eTNf3GFg0Hdkxx0Za5X4hBwJCNkzLimUIsAZNFQaf3bW/579a6BgQNBW796956tqm7eDZjlnhPvsRFpKUwJES3z93AgL5gr4emxFuPdjTBrxCZO9PmOyz2dEjHwndQSDYrLvK0T6vSZwvEKgZwJuXwpEXmZTqUG474BphBIZ2H6nB6mP6KlEOSZyDWgmQfH+VTnUNteFuYmmBASPRmvTvK4UuQ/vUg2fpo+2rRuiIn1eSU6UllqJxGll3CKw2FiWQUsHLaQkVZagSE/pCI+BAt3amVJU64UDO4fgw5sBVCQkbHN+R8q3jnS+HhS5SstWn3xyRu4vyEntjOyUTkQTCWxZWshNb4GsFMeiWvr14364eaEVvn4qRc6qQ9fRmXRCaTnbR15OXeRkNsYIimwMin37vCUoDhOoKlF0WTh7JOmVkVg0rwxqGAqcOuJOtXVzGBCtu3NPk2p/TRn9GBQ7dviiKmmUq6RrGBTHjitR8CO3ImWXLmqNy+WOQirftO8e2L/LC8P7TCQAjEbD2gMIAH5EpyIoeoQXgcLRmjQIgaJjswXo3GIRlY8Zdm+qJ0HB9vHVdIwdPgHaf3SFTW1frFi1cxUBw+Tk6Xhx4+ZnCQS1sUbgDjwW19zrHXdXoVAcSc6dh5gQ/FCERjwRi5alikMHksW1azkSFOzwj6SOICCotIo6EZDBJrUH/f3u/Zz/MCh+dX4CSHG6JPcxIPJhfPPK+40mui1hUL6xHHgvR37x1+nPB7csgVevlZg44j4ivJ4iciQ5P9kkHxLVfhQlfL4ifORnRI56hdARZxBJDznuinnRz/A5uJMsL68Mfea+BKYHJfAgrgNqExdnLr1/90T6G+0nG+9vKHl83x6N0MxOT1Icf6Im2ZxiQbUit+a0IC1QgWhNM7uq6NrBFAZ0DodG7EDcU8y1J90W1erp7DAS83xu5TqK6gr1froedkQ1FSu+lQ7KWwKEuolY9khzikduSaW5mN/zPm4uziiFvKwq2LpeIGi0wLtnOsjNtIUn6YwKRKc8XB2oRveT99WsmcC1a61hW7cE+naphSw+N0UrJVKUwIXzfWGmx/ldvTDOtzk0qRzMDQS2buFrqEy/T7/NmowzeIvST+hasn/H+6f03A4J9CFR37bxZDnmQw6QsicKZe1Nwny8TBHp0noGurSZBrcuc/H5XWeqLGoTwEjsozIWzdGHKdHN+sZ+WDrr0cZTZ2Jrkokb156Lp4+zqHbnFJACig454vY9znnKlpmv9+9RLc/ZtUSR1m9KFCNHJojQ0E9i4ZJUcfI0CECcP0WAosjAHYUMBCVNhOkZCXCmYwwO+htrDLorlSf9J+yfgEIVIUwvnru/VU+rMYnAplg2bb9Su+dpSKdhmx7mC+8+q+UwztChJKCHPqVI8ZKA8FICI3T4BwQNei0H9swOvoPHtxYjN5VqYPoZdkK1cabpU3pYWdzCRA/95qWWsK5NdIgedmcXXSjzf/2GU4eGwJScoVol7jiriBkxzShq9KUHRuch49o44W57RIT0QrtWemS6iAjqinuxHclx7ckx6DxkDArZF0D3oL4GecuSBinvpQhmIcvGXJ72S/EujRyMjSmfNAYDbdkZyYHz6T7yCAjcWCDTOFSgyM0kh80hOphdC3lpVshKs8aZk+Uxflx7NLauIpt1LcxKYf/+uti7tzaqE3WaG+1Bj4o0lgoQbHv3tEV90kR1SPwbkXOOHmmDmxdDieKZERipcuHf5DJjQHDOFVcAXLYM1NyKBDJHbNvYHXZ1AkljTJGgYBHOoOjoGChB0bXNTPRoPxNdWkzCwjkCZ04IJD6h8xAw0pLCsGSmPwwqDYSFwUjMnb9u6+mzcRanT94VN66+F/eIIjEgWEDH3sklPZGpAkaeuBPHNAni2k2IiRO/CA+PWOE3OlbMmfdMHD6SJLUHaxE22Sci+0GUwU4MEP7M+9nojn468f92y4Px5VOJW7UrWMG0SiM57oFnzMvNbI53j30opE6VKQee3bZjULc9GNr7AIb1Pgqfvsdk2vPIvjxv0nFMDWmLI/sq4+07qjkL/pCnVgOqyBHJ2Zcv7gJTogwH9/2O7AwXnD7sjLo1BO37Xbbxb+KpYVI7IP17C7iTEK1K+7asG6U4CdMufuj08CUF4wQ+Va0qa28+hn6Df0/9+2oHl7SAZ/ejWjA/rZXsEEv/MRrJScH04Ofg69u5ePN4PhLuzcPt63Nx48wMXD4+FZdPTMH1s2yTcftqGBJuhxB1Goekd6OR9X24PE9+ZnvkZDWkiGIquT5fW5EYpmvjNHQGsuypRikkk3558UIZj56Z3RjupHEsyOnv3Ggu0zzY7seNRcCopjChsuIm5Xaki66fN0YBgUbedw4ZOT6DspCiggJG5XfzaJ8aHBI0FDlWLSqJ9s1+Q3sHihRNJ6NVo7FoaxeELi1nysFQ3BHY02kRmllPlEDp1jYSM8I3ISOtpmyB27ZWH3WNBerqjMDsyLitx87cqnn45HVx4eILERubTAAoFHdvQ6Z33LmXK+LI4eNuF5LOyBNxcRB79+QIb+8bYtCQpyS8n4uI8FtSW/BIvT838bKeYHBQhLgPOqci6ukuijnt/17TO7Dn6kZj7cYw022K9fMO0YM1lqA4vF9gnJfAwJ628OgxCaPcj8rxzsHeVxHqE4vJfnGkH+4i3PceRg28IPscslN/JtypAaFQlp924og/zOghd+ko8ONbSxzZ00o2ZY4f2w8mBr+hFdGJd88byXEK3ArFHNy9X01lfAM7GteI/MDZ4VROJ2tWVQ3+8zd5S8afybLIgb59LosnD0vi5AGBeTMFxo4SGOIpZGZpT7qeDiRQmzYWaGIt0IiiVwMCa30zcgS6Pmn0vlE9Ev1N6PqdBAYRaMePIXFMWmsvCe540jupLOAlAFTOq4pA+XTtDAzZEUn7ZRmRdkgnWnVof3msXFwWGT+G4v1bDcydLWBtKWBMNGliyAA4tTbDwL4UZSny5hMtlOdnUBAYGBBFoMim+6bzy9/No9/gKMagoePTv7lj1YK+cLILRwubCbCv54OWtmPQtdUsZYRg24USGDy3Vb9OizCg62z0aOeLNauoksqqQxWALzYt94FpJXcZMWYtWLfx6OmbJkeO3hfnzr0VcbeIOhElYkDcvU/agkR3bFyBHHnHiYFnz0BMm/ZBDB76TAz3eiV278oRyvDUP/d7SCMQ3LsHsWTJDdIgr/4Kin8ojNX7f7VfjqMS+sVUf89HtQvHH62qbdSKQqONHKhSmGuI5A++iAnrg9aNZqN721Vw774dI/ruw+gBF4g6xSHEKx4h3Es98hOJ668I9g3H0X296ZT0MIpRD061yMs1x/cvo5GYMJDOTbUcgY1bmqbOEKhCWmDRTF+KAqNhQDTp/h0NTI0U+KOkQOBoV3KYqrImtamvdKx9fkvnzaGalh8+P2iiL+xkhcz3GRj5fxCga0hgZiVF4E3CCpzevQ4r56yFr/tCOFqORQNzb3J4f3RwikDvzpPg2W8aJgSsxpxp+7Bh7Rkc3H8VJ09cw4njtD12HccOX8GBPWexffMRbFizF0sXbEN05Eq6vjnwHBAK59bD0cSqH2roOUOnYktoV2hB79uhQwsPhPkGY9/ayXhwazJSvo5DZkYX8OwkrEFYnzDIZRRh6sZlx9SM3l+5VAVdOwsMHSRw73ZVopnt4edHmoAA++WDtwJ6vmcGApl6vAdyayLtR3vciR2KG1fd8eltD6pYiAITGCW14+8UlMbLZ8r0n8Pp/E4tTdGtxVx0JVB0cyJQuCyV2cr9Os3BgM6b4NppIwFjHA7smqU8W7Ltm2pIWtvAwBeLpj9YdfTEdZ3Dx66Ky1fekiNnEZXKkn0U16/ni+vXQGDIFKdOZorDx7PF6rWfxKiAM2LN+iRy/p894WwKTWKQKDpk2Yp3Yu78p7Ij8C+p4/8JUPBMG8UnIyvIR9kbV5/Ot6rpBN1K1lg+c48EBNv6pfpUMNro4bQafTtsgFu3bRIUfv3OIsjzNsYPu4tQEtqhXh8xakAi1i7YhOTPc4m3q05fDBT7iYp1pRqYE/FWL6eHk20oQfHirRasapaGg3VV+AxrBDOqhZ89McCbl2aoaVJONk3evE7nIGAcPeiM65ddiSaQM6nznpgWsCOwsOXfpdvMSBN4eF/JUB3pIdCp5e+wMdUkutARk8Zsxdq5D3FsdwqePqTTpNJXshQr5G02bfPo0skKCxSjSuOvRn+XlqtYXgbw7R3w+E4+Lp/8RmV3HRPHrUX3dsPRwLgeTCoLNKwj0JeE7lzi6nGxVAZ07bI2V1UgDAoJDHZasuzMtkj+7ojMtCay/yM7yxm+PK0NVQ7vXw9TIjDfO2sGjhL8ngAVe03Ac6CAJUU4c6Ji3Cy7haioum9Dps0wgPJ06bpb4u2LYIzz7y5nYWdQdG27QIKC+zL6dJiFgV04TX0zvZ+A8QHdZQMDXzNTzmXzh0G/bD9Y1RiNJcu3zT928ka5o8ceUkT4Im7EZohrN3LFpUtZ4tzZLHHmdIY4dPC72LXvh1i7/otYt/GHuEsCmwGh5E8p4yXUoppBsWFjopg5+5GIJTrGf+MoQr9e3Kn/TfsLKFSm3l9AF/QgKbJx/b7QLd8EG7bS7lwDKjgNfHpDYrfNBHRsPoWixCy4dlyFQTzzXp9D8O9/BiFDr1OUOIexQ7dicmBTnNxv+PP09LCkdlD9zOa1frLTbBA5qCvRDO4xvnDah/5GYZ1s2YI/YKQpYKJTBfXNDalmo/Pklcfi+QK2DQROHKXP+RXpQRAYiIuruXI+D+LJ00ZmSje8fx6GI7umI8RvJmxqDkcdQ3eiNqPhPWQu0b8bePXyIzkZez5dIjs6b399yb/99Q+Fhco+/r+4KSdi+/lSHVr0KigowLdv36nWv40lC3YSKMbD2mIQjLW7EUj6Y2rQUpw/sgTJn6ZRbe5CZa8no0YRFVTVygwaTuuIoghagyjn04S+dA0lZK3PkYYdnXXMxdO1qfYui/IUZTu5CAwbTMKcyp77TSLDNZD1o6tCt7hPgysVtnyKGolEA10ao3urMejbdgn6OVGkaBGOHs7TikDh2mUDujstx+3LowhMzen6qtB3q2L14pow1SG6WXccNix5Hnni+E1x+BhpjMtviTKlivMXsihC5Iu9B7LFtp0pYs2G1+LosWTp5D8jg2IMCDnKjujUlq2ZImb6YxF7I1s8poihplV0xSpP+18xtVcW2ydbmFT7P7xLGe3c1i27SlkbTBq7Bpl59cnR9Mghq+HRPeLLjX0kKHgiL54hj2fK8+y6GyN7HoNXj6MY63kcq2bfwZO4RchNdld+UtbWCp9X//SIQVaSm6eljETCg04yWe/YwUHI5poNJfHxtSs9gBLQqVQGTerXwvfPtJ9A8fFtZ6JbLaWuyc0qKzv8ZBqImisXlJURgTvdOJeJgdWyYXdEjT9KwjgbGd/o9FTzyxr9V49WOe+fnLjY/r97qf/887C/guLvXvI3+DC+jhzg8yuQlvmCiKDNaN2wF/FygX7dBDYQZ//yvhR9ge6NyoXBUBwguXnV8eJ5DdJA5fDgTje6BgUUbPz3tGQd9KHzKD3uQ/H1UxeKMv1x48p0tGnxG3SpfC6erE7XUuYnIJh+csTKL4fN62bDxd4b3ZvPwwDnFRIUvTpMl4BgCjWw2yb0dlmNQJ9qclAVl73Msv0Wjqhgd2iV6or2TaOyd2w/OfrYyVti/6H74uSpj+L4iR9i/74UsWN3mli74ZPYufe7uE8RojgoGAxqYLBuOHLovYielkCAouMIIGx87F9AQWX7C01Sc5Ti+4rt/wUURd+nfenJ6D2gx7R3lUs7YlIoJ9ZZy5TnnAwbXDsXiNBRgXCoNwytbMainV2QnE6GRVgf56Vw67wInl1m4D6JSU4tUF+CAghFjHErhRogi+YJrCXKxIJ5boxS0zWxIW7cnKLAoSDZC825NtUqUKinfTlEf2RLCT1s6fz0nh9cYXYl2trg06sg7NwYgZ5t/aFboank8SM9Z+PUyYtIS2UOpLzYF4vbz9ffO3MBHfXn436+OFqo7S+v4j/CkUb1voB4FZt6f6H8BeV31adJS0vDpfP3EOAzHza1RqKuvge83SNx8dgmZH4LkWMz8qlMefZ9qQVkmZZUKAx/JlO3tl06MxyGVGN3J2Ck/LAnEFLZ8YhEquS2EwsoX5obAzrIY7mDj79XyOdhUGTRc8yrjCOHCaBdtUhsu6Fr8zHo1XauHAQ2oNN6uHfdgP4dVsO5KQlviiTd2kZj3pQdMhMhM8MI43zNoFPBAL07Tnu3c8tL1wNHbgu2fXuTxZbNX8Tqde/E5m3fxP37VPOTc6sTCNXOzsZAuUxAmDDhjFi/5bO4TwBJUI38U4/ToKtVHJqNyvE/BQr70b4TY6uVaymXovr+uT4BogmePdaU06J0aivQzr4lOrecgG6tIgkI0RjYaaGcU8nLdTuG91mNeeEnyPF16WdUI9f451SgOH9WYOd2fk8PhCwvq4UERGZyK0SFkbhb0gML53SRiXa9ulQmrlxNWpB/XezaPIicv6Tkx+rWEtn8ml8C6d9LYvt6gY5tBHSIozer3x9LZx7H0/v0M4wFdjQ21Uv98Zfd9FJAUdzB+e1fj/sXX+ovqo2BIUGQJ00NlAJybzUo/vRijUIR5NNzYPOSxyRovWFevRS83HlOWQKDqhzlYyXNIWmV7B9RykcBSwkc2dcPWlQuE8azHmn5s5+CQHHzegmZBj/Uo4k8VkZc6SZ0Hi7fdCrzbKVB5MrpKQgfPR1dmgWga4sZcj5dBoZHt43EFtbIUX9u3TbICd26tfXG4UMUwfPM8eEFsYmuHtAo64Qh7stid+273nL3/hti29ZPYu2at6QhPsp+Ch7KqmTSqud2Uppf1aC4fQti69ZvYtHyZ2LNxg/i3KVP8niOIP9+k+w/AIG6k0712WDLymf7q/zmhF6dBF4ktENW8mCcPGgpE8QcrcahfZNJFBmmyikfu7SJQc82c+RgeY8uh6RN9K2Fl09M6acovJMpaxKSiFP9tGe/NtDTENizlZtT20uwSOPpZEizcGcbT7/i3MYALRyqIYebVrnnlWkDGz9oeqAF2X9IMf7hzXgsWxgE61r9UbmUHQlHT+zYegLp6aySi9e8irP/9aXerxgfKg9X7ytkr/y5v3iNrrz+fNzPl7JfDa6f56VtMZT93K86/pfPyjl+njs3Nx/nzlxHzy4xMNHvQxWTN45v20OVQiD9rS5hSBHM0pm5tuctRdT4+w6oYUIVTQ+Bb1+iqUyJKrEWk2krpXD+HNFW1me5PC69Ag4fHI6YaHt8/15FAkLOQMJRh6MzPYfbcfoY6qaLXu22wrXTbqJPW9Cv0xoS4zMIFMvg3mUr+rtswOD+vfAkfoxsUPn4QcClUUtUr2iDCcFb92/bnmC2YfMdAkScuHHjh3R69SAlda6UekSfmkKpwRF3J1scPfpJrF71XKxb+0rE3kqTeoOu8KeT/1P756D47cHDJwu0y3dB7epuiLvSCNnJnrhytoGc6r6F7Wg5AVkHhyjFeHLgllPRp9184pjr0a/9bri67MX1Y2Ol0CqaFUMFDtXPYox3b9Q0LAs70hE3LmkpgFCB4uIZgeVLhRw3rEPAmRLRnx6CEhm4BlT3QbD4Q0El+RDbtVbSw11aBODwzmcUQehn2IeKnEr9+vWz+qXer9jfOWXx/f8QFEWmev0Ckp/nVb1UO37uV77/6+c/m+pFb/Mp+l04nYlBPUJhXElTJiLG8QClok47paxk2ZH9+N4HPl5KgmTIBA3Z5PrkgcCbF3QcRXSuYHKyTSUgHscLWFsJmTN2lIHCaSJyBhKujLjm50wDJ8yf0Q6dW/CyAXvg1n0r+nZcLefmcu++nGj0FgmMvl1csHNzGwkKtgt7jsNCvyUMDDth+oxjCwgUvx088kqmcbDDy+ZWAoG65mdQsBUHBUcOCRz6+/17RKku8ZYnU/gVFL84Pd2pyn5+Vppbix9DoFA8VyR/gL+NhRv0SHBt31iLCqciMlJLwL1XEFrbKtM7snEWJU9W3JkA0Y0iRa92k6m28sUYr7KIu0rOyiBQOzrZ5/eD8CKxD71XEsgmBjeAQ0MhB/O3dCiDp89qEz1ypN+yhZurkB129WoLREXxSLUKdB2/F7Whcy8wT1R2/XyQXBGoYskGcGzcD3t3nUdmJqNBeRVjPkVO9pMOFa95ydQHqD+rmlL5kDyydHr/KQV4/Ba4+wSIjQcuXynA1eOZOLv/Ow5ue40dax9j+7oE7Fj/CPs2JODUnhe4fu4LHsSm4XViPpI/E4OjczANkoBV/7z6kv70Ul2H6sXX/Wcq98uX6OOl87fQsdVEGGv1wKjBIXh8ax2ychohP7uqLDcZLSjavn8nKMIQMP4QMCUBz4mF9Wtxw4YeeKwGP58r56bAwVapaAICBNJ/qL6fS89VBTQlYpTG61dCjnvp32EyAWALRYb1EhQePVYQUDaQCN8o00LG+y5SOmt5XcBcQ+zdwXPaOqNJPW9s3HDB/+qV9yI27qtIeJShzExYDBRFAlsFBv6bOnIwMNSRQzbT0n66smIO/i+Ago3KtNg+Mvqcn4vWA3tMS6xcqikiwzrJmb0ZFDy2uY39AHRwHC8XFGFQcAYlm1yYxD6caooQRI5dgyd3AlCQ2aRYqoZigVSwrUkgf/zI+8siZkpTePQzIeE3C3VqCAx041qsocxDSvpiSTzZHU8eBiInx0GmRqsFI0eM7FSBBbNIjOsL1DFwweJZR5GWRH7BjvwPXuxCf3YjtdOpwFF0QAFdex6+vv2OSyfjsHb1Yaxbfxrrt57Hqs0XMG/lScxfcRGLV91AQ1tfGFbuAhON7tCv0pEEZHtolm8jTeePFtAt5widSg4w1GoGS/P2cGzUC53aDcbIIaGYOW0Zdm8/ilvX7+DLp6/8w7+8/gyK4q9f8SBfvI8Ozye2uHllAuzrOaFhTYFNW6giIVBw1GBn5p5ySWHeDMKMyLbo7FwXLm1rkVarhuuXuOGjLBITSYs1Eagsx3boICVlNH1faepmDSfzuFic07k4cxiFlXB0x3o5Dr+fM0WMjhslKJg+MSDY+nXmBWmCcYQiztePf0hQFOaYI2TEVlQt44R+fccnnj/30vna9Q/i3v1kAkKOEh1UoCgeIdh4vlv+uxosDAjez4DgKPPT84oZlZG0v+5XrUNdBA7uqKO/5UJ329ozBzXKaZFYspfZpXIgPl34vZst0Mp2JFo38kYLOeBkKJpbDZfWorEfGlkOodBIp8unwi9Uske5B1lSngKq4SmUnzqmjXrk/D07C3x4tRhH9/dHLxd6SPkmOHlSwEiL0yCa4ss3qkXoPNyUyJyV6RKfTz7YDAfwwo2t7bugYllr+AyfgzevP9Bt8eunk7Oxjyi+o96nfqk+80bV/PmNfPLm7ULsOfEVY6cdh1vwNoyYcxThW24g5tBtrLj6HJsfJ+HAh0yc/J6H08kFuJAODJm3H6ZV/FBPJxD1dMegtiaJXx1P1ND2gKmmG0yqDYRR1b4wqNwb+uV7QrdsN2iWcoFGCQJPiY7QLdMVNTT7oUWDsfDovQjzoi/g8ukf+EERha9NCWR0F8q/P92PGhi/7lcM+PI5BRPGzieguqBL8zCKqjwNaE9ZsRRFDRLQTEXlpG2FpemnKiI21o8qr0qoSIDwHNhGTud57lhPLJrbEQF+zdCeNJ6vV2ukfic2kEs6hL6vnKsCrl0W8B5UDT2d3NGheQxFik3w6Ezim8yzB1GqlrxK0ywM7LoGG9f2QdaPACR97IDBAwW0S/TEtLBrB2/c/GQYd/ubeHCfaBA7uGqiA7XIViIBRQeV1uBx2yzEH9D7fftTxLp1n8WRI/8LoJDrUKtAwav78/7H8SnR+ho2sKplg5unNtOfmK+Xxu2bQq4AxAt+tGzohbZNfCkyjEJ7O390aREEZ7KOrYPx9rkOOTB31FAhyZaPEsjhJj36KQZFZmoPbFndWDYH+gzTxb1b40iLcKLb7xIYq0gk6xLP3bufvk+g4ExVmZvE52JhnaeJTcsFTKoK2Fm1xZH9j4lO0ZWrnaM4FSLj3exPP/epX0pkSPn6A8f2ncaMqA0IGL0KQ72WIWLmaew8m4wzRI/Ovid69A24lgZc/AGcIdpzkrbHv+XgyOdMHPtSgM33UtHYfDLqaI6BpU6ABAUDwkzLXQLCWGOABIWxRj+YVu0PMw1XmFXrC1ONPgSmfjCpTICp2B3Vy3WBZrkOskVGt0pbqqXdMG70dOzbc5KiCCGE7oPvSLnVP9+Per/6/pUt7yAjynfucDIcLb1hYSywfiWVpXz0StSQdJSdmio/nhf3ETOCNjzJgoBhddKPTU1ha6lk2zLF4nT9CmV5rqvK+Cg7T3mlV+Wc+bmcNmOK+zcmYur4eejcaiZcO68tAoV7t5USFL3aL0HfDsvRo0tJ7Npkjpy0Prhzw1ImDppqD8HuPbeib99JEvfvZiljJ1SgkIAgMKgjhuy84yiiSv84cTpFLFn6SOzenSm2bUv5N4W2yjhCEE2QwElNQfdu7SKTdEs7ydWBOCco5cM4zJviSkCYgObWQXI2ObnoiEMEUaYp3AFDtUE01doOmBNtRqekyECFo9QaJZHyPQxRkyrIjM6MFG7io/0EmFnRArXoAXVr5wS7+vVw6yr9Xp4BiTYt3L5NAUvVDMhgYOMZMl49CiWhNg0af7ThxUaQ9E3dolTc2f/BSzZ90pZ85fsnYM+hj/AM2IxWbrPRJ2Inxm2+jLV3P+JCWiGuZRAQ6NQXv+XiUhJFg68UFb5l40xSDk59ycfJz3k48SUPRz9m4+B7BgboXEdQTWMQ6ur6oba2D8y1B8NM0xPmmu4EhAEE4t4yGjAojAkENaoNkFsGC5spAcasWn8CkStqaA2i73kSWDyhWdINRpUoKteOxBiPY7h4JA/p9HsyuhW/bYkI5e2fXqr9vPn2PQmjvVegUll79O7aH/G3Z5MTU0TOUiZ+kHlReVXlKEDWEGaGAvak9zq3FwgN5GwDgU5OTWWHn7OTkGvscUuiOh9L9oEw2Ni4pZFscnBvAkWobKZlY9HNlKpPx6VwpUjRy2WZzID49LYifc8cG5Y0gEEV+p1WE5NuXMjvzRTqYUL6X1qfpLjmqKGabZxF9rmzuWLhwrvi5Mls8TARIv4f0ad/ZgwKttw86M+ft+5k5VKt5djp/BwzZKYZYEZEeTjZV6LIECZ1Q1v70CJQtLPnxQunyIl6B/ToiSf3/OmUCiikESiWLjKBoR5x/7ns2M0kIBgYGT+84O9lDRNtLViamuDoAQUUPF1LQUFlOoZpl3Isbx8/qIp2zQTqmg7AoZ2kctkppBP8PSj+wrfp8524+wTQhejq4oeO3acidNY5bL2YihNvgNOkRU6Rnf6eg9NfsqQxKC5+y/9bUBz7lCNBceBdhgTFxkPZMK8xBjWreRWBgp3bTGOgBAZHBgYGg4LNhCIEb9WgYECwGWv0l9+rSVZbxwt1qo9BLW1/1NTwhXGF4fLv7RxHEY3ZjOeJVA7qF9/vr/fML9rHQUP950KKqts23IOJnrnsFOWVYGVrUhY5MTdtZ1XEjyQjbN3QHft3DcCje/3oWbkT5eot9RsP4LKtZ4Y7sa1lpVmU0MlRnCiyOvLIDkT628Gd0+QE0Or+C9YXvFpTv87L0b/LagmMTs3m4BAnlubUQMbnKfB2b4sq5IfhQftP3o9PMSGToOChphw1GBQcMVg/qBeV4bmili+LF4cPp8os2gf0t2OnP/y7oCgQ+USZsvPzBJWZuH8dU00ru6Ib1QDvnnZHdrI7tq2rAMf6E9HePkZmQcrZvB14ZSBl4UJeFKV147YklAUexvMpy0rez5aRboedW+rDSKcUDLRKYPy4Zvj+YzQVojJXLFsqcdghnlVQjWoGXqGosOBnk6zSCFYSWd+CsW/DNJjqu6JXl1l49vyl8nBVXv/T+RklxapP3s/OQNTh+IFEdB+2DDU6TYR9yCaMP/YayxNzsf5tIba8yMGel9k48jYXxz/m4OSXTAmAs0SXzlC0uPA1B+e/ECC+ZuNcUi5Ofy2QoJDA+JCN4xR1jr0Dxi36hOr1p6GWhjdqa3mRYw+BoYYHjBgQBsNgaj0OFQ2o9q/aU5pxtT6KUYRgUPBi90y19HQ8oKs5CCZaQymyeKGu9ijSKmNhqRuI+tVDYaUXhppVgmBQxg92ZjEIGHQcsefpXuk+/6ZuKHr9pF3K627cG7Rw7A6tKrWwIGYdsjJaUKSgComAIVuTOCGQtRxVUDxOI2z8EJQrRfS5qcDtWxUUQOSZIyHOH2eP9MW18/3x+Z0f8vJ1yblVdIoqwOQvBggbwwvrcE7UXtmJ17lVlNQTnE3r2nEbujmuxMyptWTjSiEq4vkLilA12sComiOOHnox9eF9noggi0Cg6sCjqMDa4eIliD378sWOXdli8dLX4uhxFK2CdPo0xNKlL/59UBQSbeIFx5NS0tv16bTwo0G53jh9wBbZP4bhw4tO8B4s4NQkGi5NZyiAIGCoW5va2oXImb79hwSQAB9LtVE1EuPk8BwhqDATnxjA1kqgq3NjDHPvBF0S0EOHCQkENTB4+/LZHPj7GuDBQ57tWrMIFEpfRimsmKuHWroCk0OPI5dErQQE2V9ffwYF146HDxxHv14+aOM4DCNC92DesU9YcD9fsfg0LH2Sjs3Ps7HvdS4Ov1GiwCUCw9VMoldvUrEh4YMEBAPjLGkINgYFH8d25lshjn4oQI+IbdBsNAP6DaaTnvCVoDDXHkqOPRgGFClqGnvBwNIf1Wv7UjToDeMqPWCkQVsVKH7aAIqqg2FVdzzqmY6GhS6di89Xzf9PoLCqHgFrfdYwIRRxRqKGjiuGD5qMi+dvyXv/u9dfyo3KJ4ki3FCPQFQuZYjoKURZ06rK/gwGBotwmT+WVxFzKEIwIOrWrIorl6yl8/74poVZ0wVsagvoawgY0zPq4iJw9hw9//xyCijIFwqz6+LicWd0a70R/TrshGsX1hkKKPp35FSQrejVci3GB2ggK70x+QUBjmx1zFZol7dF+7b+H+/GZXdMSMimCMApHwoorlzPI+2QIJat+CAWLn4t5i14Jg6RsL55K0tcupwsVqx4LQ4d+ssUN4qA/vUzFYw0qjlEXgHpiSyU27ziwi69yiaY6Ner6PC7sc7o00mXwBBKYJgIZwd/tG3sgxY2XiS2h6OxZSNEhlghS9IkCp2sAciUPKTf6Aar4shBijrvqHBzS2IuFawRibaenbQQd3U+gceYHFcZaac2bqHi1iaeaDn14xYEjQyFftUu2LAsXj5QRTD/kxfVmBdPvoXTwDnQ6xgGpwVnEEoqecq9LITfSkFUbApm3M7AvHtpWPE4C1tekzYgDXuaHOTgQ2D1bsDV+zzshq3C6thUXEjOJVBkETgyce5zDs59ycWZjyRcmWpRlAgafBnG5cagduNFqGE9V4rs2lojiPIMlrpAv5obzE1HwtRoKHSru6FGbT9o63PEUHSEGhD8ns1E2x31rEJQ024KTG2moY7tTJhZToO+eSR0TSNgoR8uQdGw+iRpNvS5QfUweQ0WGiHw7X8A8VeoHNT0Um3/4JWbA0SEzUX5klbo1z0Unz72IGCYFj3PwtxqWDKfIkRjgYunqpHDayInoyIGeXRAGQKKYxOqsMIEIicJNCI6ZkJU+eDuYPpN8gn2DRl1SuDIfk149q+CHs5+6NJ8qqRSnDTKvd7cyde5dQimhU1C7IV+kqXwGA+fEUTXfnfGgmk3eeGYCkyd1FriyqV0ceTQO/HgXr64E5slTp9PElu2vRLr170X8+c+EUsWv5KdeD+9S9rPzjmiGvIzG4OBykjkEm3i988fFfhY1+yC1k2ckXjzQNHXnz/pjV4dtOHYYDSaWvmjmdVQtLYdSdrCD052o9DarhWO7x9O9bIqN4ZNVQBcS+RlExXi1X5UnXSZaQOwbWN7mOlTaKTCO3+GL0cZaaf+TRmu+Xz5JRHobYGGNe1w6kASCv/LCPHz9fz5cxKSkWjRxBNDQ3djzpnviLydi7Dr6Qi5llQEiulx6VickI2Nr4H1zzIx+dBddI/YiBrtI1DRMBDV60zGzGPfZdRgUDAgFMvFWQLGxW/ASQJEz4hNMK0YQPQmQoLC1Gq2BEUdbS+pCdSgqGFCkcN0BDRIV+gYkM6w8CVq5CqBwdSJQcGfWVMYaQ6Els4QGFiFQrtWGPTMw1DbZjasHZaigf0S2FrMkKCw0gqToLDWmyiBYa0fhfq6k2BWeSRF1r4ID1mIN6+VFqv/suDob9yvs3LRGVQsbQ23gQLfP1WhZ1NSJv/xRAo56bXw6okNRZJOBLZqciw29247OpjjXmwzZKYMRnrqYNy/00ZOSdqpXVWkc/MuUzD2CfIHHn57+sgoDBswCd1a8mQHfwZFe8dxJK6d4N5T4MAObWSnd8KdW2aopeMGU+0BFKG++PxZYIO0hZIRm8h0imgTLxR59QrEoQP5YsH8Z2LTxl9WR6V7lUY3rVixv/G0lrzNy4HJRN9r1/VLD8XRw1QAxB05Oez5w/4I95sL56Zj0cYuTE6+yxqCKRSvDNSq4SQM7MMrDulJEDAgcjJ5YuNaSProLNvBZearXM+5pEKHVM5/4WQNNHMgYNgLfPrclmp/2l8k1Moj4+0pjOjnD5s6brh3g2L8Ly+lqVEtrsnoXyHRnemLzqOGUwhsQnYg8MIPRNzJRdDVFARe/Y6gaz8Qcv0HJt1MRcy9bCxJAFacyUJg1C20a7lM0pDalUJQp3Io9BqNwbLjb3EnC7j0Q9EQbBdIcHOUOPedgEIW6HMLNaqEwLr6FFjpRKK23VLSDfNQt5ov6pIWsNAcCjPNwahONT+DwsLYB3qVlBYnc3J8U4oY1fQ8YFC1jyKyNVxli5R6a6w7HDZ1Q4l6TYABCe36euNhZz4ZNk2XoFGzdbCwXgK9GtNhTsCorz+JaFU4bAwnS8DU05kIvbK+sLeIxsalj5FH4C7+UvSYUn6FUoxwWAG2b9tHVMoBzo188fxZV5nwJ1uUmAqxZfNcvQ0osigTQ2xZ342+qowtlyMZ6fmGju8uJ6O+dZc+55OAZwpFf1fT6pfPHDBkgAFcXTZLc+vIKUE8nDVcLpPcscVCONnPRlxsZeRkOyIm0hZa5cvBf/jK608eohZPmcnJgerOOhbcSjOtoje4/+LqtTSxfiMvFvnLbB7/CBQcNXJzc2lLX758J8qksi/cnDcjhxyaQXHzelWMGk78sJkHulJI69hyCqF4krxotvb20bCvOwErFzdBbrZNUZjNz6mADWu4lhCYFEIhdL/Ao4dUGFRbqAHB2+yUAbh5zQpnz5qQvuhCl6ZuZSJQ5P2BAI8maNekC549oK+oMruVh6h+FQMEAeTh3QR4EojadAnFpPUPMe12IdGlDIy7/AOBV5IlKNgm3iJA3M/FuDPv0GLSDmg5jEMFvaHQ12IhOxENtCajsf40zN3+HneSCRBMmb5lSRAwKM5/zZPAuJhCPHz+AarRg9DAIBq2BtNQX5v4vf0yGFvNkaCw1KLautoQCQpdLYU+MSj0Kw+UrU6GFXtDiyKGCUUMY83+pDEIGNx3QVaTjyfQGJImMdP3ReMGMTA3Gk+UbAzqVQ9CdbNwmNSeBSu71bBttgH29RfB2igK9XRJaxAwGugRQAgY9fUjYFZ1NAGxO9z7RODBA6oJ/vRSlyMDQgEFPQwc3P4MBn+0QreuAh8/UMTg6M3NtZIJKKAYP07pr7hw2pccv7TCFGQ/ksBYfxc5kcRVuUiOAgo2BgU326andMXk4Kbo2Zo0hfMmCYrebRfISpdB0aPdCrRqNB0zSK9kZTrgWcJ0tLG3g2b5Vji0702UnMY/Ibeon6IocjAgCBjckx3/AOI2T5NDUYR+/afz/woGKgBJpwoLcqRlfkHDQb0XP7c2/R2x5zyppnfG44e1SPxsRBeqPXlttM4tY9C52RS5BjUvB8V9Es0bN8SE0RWUeYbYuECoJshO15GTh3Eefg0jXSm8eG7V/t3rIWxcN2xeOwhvnvkjI9OALqWCLEA2mShIgjrt/WH4DfSHo+0IEvl0xfTAOCowHNQm/+PnyMGCQ/7qKzB1ikDHmScxkar2kNh0TLicjPGXVIAgm3A9DVPvFWDmvg9wH74VDYz8of+HO8w1RpCj+Us+bqUbitL1AzBhQ7wU2ae/sY4gEJCdJ3HNdjopD9eygTnzk0gAk+MRgGwNpqOxQSRsdMNRq/FCmNnMRS0NX0mfaml7Uo3vBr0qruTUIyR90lFRJqklKGJYEE0yMfeFBkUTplCyv0KTooXs3yCrNpSizAQ0bjgHZoYTYK4XSnSJfpt+r371iWhkMgW2tssocmxAHbuV0DaPgSXtr0fgqG9AW30W5cEw+mMk7QvAmrmkzYq1UhWPGD8NxBrOoWp5R7Rq6oO379vTMzZRpsJhSpRXFes2kPCm5zx96mA5RFUuiMngIU3IzbYtiQlwXhU3nORlWkpT9zfxpAu7d1Ol22ohie31cOu0iujUTJlM2stlDrq3XYLOTediUJ/acuI4ngN4/04BjZKt0aFl2HOiTPYytUMFCAYGA4Q79mSPNw8wIhrF9i8lBDIo8nnALcH64NYPCwyqdEdMsCuyv84iBLfBzBieqn0t+nXYgB5Os2UnCw8YYmBwf4Sd5TiMHOSOl48CyZl/V5rvuBZhyzOiCFAXhroa6OzcGmePjcacaS2I32vIOVBNSUvwMFNex06CQkYHKjiyXNIRwT4OaGbZAk/j6WplhFAe0p9AoeqAS/mWhnGjp6Fj5yBM2/EWc+IKEHQ9GWMuf0PwlRQJDAbExLhsSaEcpx9GZaIEZSp3h3ElD9mXUEtzJCx1xxDVoVpYIxDDZt3GZY4KBIhTshlWAcbF73k49zVbAmLGyVswqTEZ9Y2i0dB4JhoZzkAjfaI05KQWTUhoN5wHi2p+qKszkmp8DwkKdetTDZPh0OZmVxUoOGIYVXKFAVEr4xo+MKRowc2yDArTanSNqn4Kg+oBqF1zMuwazkYtcnQGRAPWFBwVKBoYG0+BYc2ZEhQNmq9HEwIGg8KSAFS3eghFDsXMNUaierluGD54ItFeHmaofhUHBJuy2bfjCSr/4QCPQQKZSdoySkhg5FQmoGjBzraKXCqAB4TduMpN8Pw8S+Dz2364fLYh8kl73LguMM5f4MNrXt2W/IWjBYHizRszmfrRq/1yuHdeLcdhdG49Db07zFUGJDVfgJ7Oerh33Rk8/1VmshF6tYtC+d+aY//ehAWPuSNPRZvUoCjq8SYwqIHxl0FGdBUqUz6TO4n8Qm6GhUj5kt+0b5tln1uYhcjEvIKCaoi9FAiP7j5SAPVzWSNB0bVNFHjprDb2PmjesB5iJuvKuYc4ZDK2JCh4wElaCdnqxFOwzJthAU3im8vn10D6t0no3aMCOjr/jo3rfpeT/vJ0+LKThyMFXVr6l+mYGjQR5gb9SUPQLtWrOBjY5H/0sOKIHrXrPQstwrcjhkR0VFwWgq8RCK6lYNzVZLJUhN3IwoxbBQhc/gCOzcKh+UdXGJTvQXSCBC0LYO3hqKs9WqZklK8+BF3G7MPhTwU4SiA4IfskSFzTe9nSlJQjo8f+M4B13bmooxONxsZz0dhoJhrqx5BNQQPdyUWaok61kQS0EUWaQo9AUcuIQGgyEroa5PAECBkpVP0U+pX7wcJkBIxNBkNbR+nY4yjB0aKmzggJML7WmlazUNd2PmqTsGYNwfSInd/KYLISPbRClajluBoNHFbCwCwKNQy5pSqYBPg4+t4Y1NT1QbWS/eBgGYqLpz4qEVcWLoNBTaPovdwHbN28DxVKNcAg1ynIzWyMgqzKyui7gt9w44ZAqxZKugebr49Ackod1XP9jXyqKk4cE3JmwiB/N9nfUZhbiqgU0+WSOHXEFP27aaJvp/lU4UZLZtLHebGcMqdrq3lEp3rg4ukR9D0lxfz4viZyDt72TYM/x11BK54yU7ZGEVVSDz/lyCEzZOVWMcXLiuzPoOCWphxOQKLosX/HqSWmFYdgdsA1CQi2Y3s9MbTPaHh024ze7VaiY/NotGkyHs2s/dHUegjpisZ4eHsEnaoMhUxulaDT8hDG7LISGMwrWT98ejMZ/XsKNLAQcs3menW4pSlYrqhTyE19nEvF+kF1mTvWNUddfTOcPPhdCmb1Sw0GtfF/Z09dhUuHEExddBMrHgNTb2VhIoFhwlWiSypQhBFQAi8mo9H47RBmHqhQsSsMyQlrcE+xqre4htYw1NYcBZMKw+HYYSF23QGOfSU+/TGrCBQMiItJBbiYWogDr5Ng324RRbtJaGgyF42M5sgowcCwNZhKQnsS0afFRaCw1PoptLn1qabhCBktfgUF91UYVnWFXjXSErW8YGjkKUFRgyKFGryWut7yWnVMwlGPKFqjWtNRV5eBoeiGenoREhQNKXpYkzbSNZsCC5uFaNJsNaxqTye9NB6W2mNQR38sLPT8UEvHB9XL03XotaeK6qCqcP8eFPx2bswB2Vy7YA4/72pFojs3tzZePOuE5YuHISSoHRbML4mPn0xUoKCoQKC4ThHEpq6u7MDlqMGdu0r/xW9ySbXNqwbJCOFkH4U+LvOJpSxC9zYLpDk7dkP4BFM8TeTKtgLSvozB4P4NUK0M/daMK0s4UVBOsnyfokQ8RYwEZep9ZZSeojH+CgrVxEZ0f9JkfhPRp6TXcOjWdt6Xtg6lkfTeo+hw7pl06+qOHq2nw9mOUziUVA7nZjPRuslUDB5YBp/fm9Mpf5MAyM8wwfvnZG8ay2V3i3JfCksjIV6gVo0qqFhOYPEiAkuuabFWJrL8ErJ57/blcNTQdsP2Va/pGvjBKKa0MNGLHw7voo/bDr9GC8+ZiLrwCstJc0y7k4rJJJ7DrqcSZfpB4joF0bdzMHHVAzRuEgKt0h1gWKkH0ZXe5IRKJxn3GJtXHUQimKkMN3uOx7RziThAgDj8Lg/H3ytgkBGCKNOFH/m4kQT0H30KFhXC4WA0D7aGM9HEZA5sCBDWkj5FkjMq9MnU+q9Cu3rVATJS1DQeDh2KVCaafSUgDAkQRrQ10+hFQOiJ6roDUKe2Pwz0PUn8Ezi0h8BciyKODkU07XGytrfWD0UDcnYjSxLaRKMYDCyspVUPhw2BljWS1EnGEbC3WYA6jeajOicr6owiMPnLFBQLLW8JDJ1y3TFt4gFluh754sIuBg5+0WZsQAQq/qErpyXiCjQ/gyo2HmTElSJXcKpKjgGRm2WFl88GIihgAInx3+RagbVIW/L6fa/f9qDzsT8wO1GOP3HIAv26G1CUWI2eTivQsy1FC2IprRqHoKnNSHRqNQgHNk2n79SQk0UbV3BCS3u/L7G3s1rwrIIsqnliA550WS71pfrMAGFwKN5dZNwcoICCo0R+PoOkQOzZkLTAsKo71i8diqwfI4sOP7C9AwZ0HgjXDvPR32UehbOZ6Eoodmk+C47WEZgSXgdZaQ2VlgRyfgbFGG8lMYynspRNbnSjebwkb35VzJk5Qa7ZFhX5CyhkACuJT68d0NZBYMHUmyTg6BLkQ1ADQvVAVKDYtukgBngtxq7YLGx4RWI3Ph0xd9Mw6WaKBMXEG2mYTDSqzayjKFPLExUJDAwEdSaqcRVyPBa5BAquwc2rDoUeUZOJcxOw5wOw/U02Dr3NxYkPeTjzKVv2RTAoiIURBbuOiuYBaKI/G3YGFCGMZkljUDQgoW2rx5oigujTYim01U2ytSkaqemThTFpDAJFdYoI6p5sNSgYEDWq9YYWgcVAfzABww9GuiTAtQajphTs/lTbB0pQMBUyrEu/S8BgXcGg4J5tBgUDgo37LdgsDcJgTvSphtVM1LdfTDRrLOkoBRBsHC2NCKQaZZtjnN8cZGXxiCcu97+CIpsieE+qMI2q1sB9npUjjzRhFtFm0pKcDCifPflQLm05kdSptZBrcDSzM8W+Xf5YOMcBDeoJXLvBi+UoGc88ZxUDI/37EKJXTdGt9VKKFKvkAp88hLWF7QR0aMWrt7oRWOrI5EPOx/PsPBUa5Vti9txjC3hNO14jj0GgXm317j1lH69NwVFDuTK1qYQ2g4K1RD5pibQfBVb92617095yOr7xNI2FGkj7NhXrF0ZjcOcjGNnrtFyWl1fmZ27XpRWJ2ebj4OTgjDt3lMKQzXN5pXBkTy05trpahdKo8kcJ9OvRAOdODCXA1KUQaYmUpHrERZVcmR9JbeiSVCPwcg2Q9rkDujdbIgeh5OerogK9/tLySs9p3vJ76DN6Iw6+ysWu93lY/ThVpmhMvZtMkSIN027mYNalTPQdsBJaFbpQdOhG0aEnOV1fcjpV5imJW84+ZZ7OOUValQaiceB6rKWIs+kZnfd1DvZ+yMKRz1kSEGxX04El55OIJs2Djd5s2JstULSE8ewia2gwowgU6khhoelPTqe0PnEioK4G0Sdjb5ibDoMWp4qr6BMbX5eaRtWk92aV+kKfAVRnrGySZU3BNXy96uNkcyynedQmYDSpOxu2JKz1jaPoGihSyWhB2obM2oAiCBkLcTZLok+2FDXq2M+BrsVE1NSkCFSNAKfamlQagKrCGUPd5iP1B5U5P4Piz0H1ev0iB3Ut2sDBqjbeJMwmSkO6UEWluKKMjW1PbKKynAzBmLh/dAyv5UEagipAHlf/7j05tRwkpkuAYuHO36NzkJCeGVMSnZotQy+ndXI4c9eWUWjRaAw6t5kEF8dZaG4ZTpRJyJ7uM0fbyGl+nJuHvom9CltexOXe3Vy5JgVP0Mwro/J7Xhn175tkqXrmKMHpHAyOU8euRPFDi/a5JgGRn18FuzY3Q8CQPvB3vQivnqfg0XWbXLydQdG5ZTSaW4/A1JAYOlYDBZll6Iaots8tibvXW6NpQ0F8sSq6ubSRw1Z5jARPgfP6WSXSHE1w94Y2Tp+sLNd2UwswBsX6pQINjSbgw69N58VfhJUNK/Zi2KituPKSOP97YMvLDKx6lCJBMeXOD8x8WIDQs0kw6jsDf1TsAn2iIpxbZEpbNSi4D0ByeNITJhrkpBUHoqntZERfTsbqZ8DGpznY8TIL+z5mS1CcJl3BWuLUZ8DKdRrqacWQdpgvAdHERKFPalDwewYF0yd1pODyra2ttD6xVa/mTiLbBzXNhktQqEH6d6Awr9IfVTjVvCZFh5pjZW3OoKijHSBznzjvqZ7hRJnqYdN4OepZL0J90hE2MloooOBjGuhTtDAgoLDuIBDV1Q6CTq0w0j0zYWXoWwQKs6oEXA0POaajfEl7DPGMoGeVXQSK4v1D3Ot97vQjaJcvhfE+JrRDaVyRzl34u5wBnQHRxVmHKNEUOfy1IEeDfEWhyzxwifUBL2Wcn0b7VSP2uMl15zZzuDgsJi27Hr2d5smk09Z2gejYKhwdms1GG+sojPYSRPd74senQLj1qAHtCh2wZll8FIOCVy6SywTLqfxzlPf/1ZLB3HvNlvUN1UcMXHO3ab2qeJ0QiuyMnoi/Wx/eve5gnPsT+A28hCG99sK92za4uiwljjcVHR27YyYhNCOZbiKfxDQhXs62xyK7sCQePSFBTWGxS8dS2L29Bgb2E6hUWplQeOG8csjItKZLUCJEHk+zQgVzfMMjEpAdcOMSqVsqcy52peg5NJDxhgCxYtMruI7ejmvfIUe57X6bRbV6FpY/S5OgWB5fgGn73qKZdTC0S3eT7f7c+cXOJtMl2OG4RlalaXMvMW9/rzcCXmsfYGViIZY+SsOG51nY/ioLB95l4fDHXBwnDXE+g2hT8FOiXJMJvHNgZzwPDsa0NZyFxiprZDBbmq1eFIFiEiyIopg2JFCQ0Ja5TxSRTIkC6WiSjjEdKXu1WXSzA5rRNUmgcqcdN8Oqrpm3tUiM16rqgVpWk6BrQgJZy1+2PtUhUHAzawPSFRwBappMI3qyBpa1ZsKcooUtRQsW27KPgsCgjhQcXbg3nPtkZBN0gykwNg8mMHrCTNuDKo7+MCZqyZVIhd/awct9AXJS6RkUp7H04mdEFSxmTzuK8qUay5QdnpBCOjZZeno5XCLO/+O74hucqsOTQWdlNsOj+wMQEeKGOuZl5CRrJ4740ckU2sUtlh8pirj36klaIgC9nGPkMIUOLaLQscU0OVanrd0k9Ouqg8R4Z4pONXDsoIBOmfbo3Xn63ft3co0YALzWxV0S3JwLJY3oE+uKIiAUN3VKR+wFeJtXH4jJY/sh48tcpCV3weYNAmPdHiPI8ylGuV3GiH4H4dF9O/o4LUQL61GYOCqKbrIF1Qh6EhCyo47zWTgBkG68AGVx4WwI1YICwwbxnKVu2LImGPbW5dG1k0BaupUEhHIJpZCe9jta1x2EqMBt0vHVoODClh11/CBox7lTNzHEbwfuUHS4kUwi+FMG9r7PkWney56mYuWzfIQeeQnN5mOgXa4ngWFgkfMX1cDsdPyenZDAwluDCr3Q0nsTlsYBC+9nYtnjdKx7moEdr3lcRBaOfs6XKeOLbzwlCjMblqQbGlF0YFAwIBgY9tz6ZED7/wYUJjZEnwgUMveJamI1KGqaEYcnUOhUJrBWJC1BZlCRKF6lXvJa2RgUbBbcGFDZDXpm41CzPmkVzVGy6VgNCq75OQKYGU4hQMxGc/vVEhQMCDYrihAMCj5GoU/BknoxIOoQuHQMAmBRbzLqmfjJ5mATrQFFoOCUE07zCB4zXz4VxeiRUMSQz4jeZ9Lz6NYhBFZ1BF48poihTvPJqUzHacoWSCW1p7Rs7l+4QKAlUWg9LQFbq6pyIgrPgRpSV3BquTy+oAI2r1xBUWEkurWdgla2wTKTggFRHBTPE4hxEChSk3TQrnEgqlftgn27H3lLbUECm4HBrVEMCp5g+a+agoxuRi7yzn0Tk0bFH66jESpbhljJf349HJPH9MbEEfGYMPg2/NwPUpRYje4t56Cz/SS0tW+BfTs60AWXlM2vLKALSVOsXjoAQaNtsWlde1w62xcfXnvSthlqmpaFu2srWTP8+FYer3kZqQJl7C4DKetrGML9B6KNo5dSExUV+s/aiN9evAT0Hb4eV39k4FZ2gew8O/Epnzh/BrY+S8cuojwzD3yCfc1A6JXhHmAW0NzpRSKWnItBodS8yqAeNgZFNXro+rajEXD2PWY8ysO8B2lYkZBG9ClT0qcD79NwnKjTGRLerd33o3aVCAIDCWvTObA1mU3UiSkTRQk1dTKZQWL7Zz+FBfdT2Mz/U+5TjSqeqFqlLzQMPVHe1B1CuyfKGPZFORNXlCErbdwfpTV7oVzlHij3RydUr9wbNehaa2kOggHnPtWLID0SRBz9p6ZQO7u6J76ewzqYNVgi37PA5r8zdeLebDZLihJstfXGUoRW0tplanvdYBiYBSgVCVco6mGzlfqg6m8umDF5F1Ef1UMp9owYHE+eJsJAqzWG9IxEbrYF6QIS3hwxyE94ybLEpxaImTwUNnUryoU4eWK1IYMFPrzvh0nhdaFN0eLQYQYE6QvuFOT5avN1sJYq6XaO7eUwZ55+lQcjMSjaNIlA1zadcef6KKJhpGtREasWNIVeRR14DVl+OOEeBC/pxVqCVzmSywvTe15CuAgMalNHidev3rdtVnd+4eCOB5GbZSJBkfTeG7MmekpAePc6LzMW+3dchgEdlsGj4wJ0aeOC4wd7UikooOCxu8+ILtWmqMCdc7XNBRo1UFKHh7jzDB3msut/fBDRrVReXLGcMsODai7XuAs9UN+oPC5xvjXT1qLwrBQ409eH8S/Qo+dCnLsN3KMHcjUtW6ZYnPxcgD3v03HgIzD/wmdUbzUBBn/0R02NwUWgKKJLRcZaoo8EBT/0qlV6Y9jE45ieUICou+mYG5/6F1BwXlPIxseoVDdcUqQmRuz8itkRONSg4NYnBoW14bS/gKJ2VW+YVfCEYTlXeX0NbSagS/+VGDzhEEZNOYegWZcRvigWYYvjMH7edYyZdBbDvHehc6c5sLHwA4/X1ivbG9oaxPeNx6Bxg2gJCqZAciyFihapU8YN686HdfNNRa1ODAo2TvNQerUpStB36+iPg0V1f4oW3Fw8HNWqUzSzDIGFjocEhiHpGQYFVyCcm6Vd0R7bN57+5RmpxoGTLZt/GpolbUkzkovJkXu0pQowP0cbE4IFKpIvNGmggWmRQ9HZuQ5atRR49bIH4u9FoLmjwNZtKlCo1ssoyNVCelYjRAROgpOdn2yBYlC4NJsq04ta2jbHcA/yo9v0PQJGQmwQbGtZU8TyLLxyPrM9awkGBS8iyaZeV1sCgKMDb+lGZL8EoV3s2Hx5Tm09G2xbsIj+RE5Klp3SH7vWjUa/dgfg1ecCfF1PY0TvY/Dsuhe92myERx9NJCbUk0JJtjjllpciifPltQgUDo00Mc6/K+bGlJIr73dsx+FRyLAaH2tAJce1BoEpTxvJSc3Qqv4khPpyIdOVFagLWjEGRMpXoGfvBVh15gae0N6bqfm4/qNQDgk9yyPiCEvrb2WgfcNZMPxjCCy0R8ieXx7/zPRJGbnGvFwBQxEgCCD65XujStdJmHIlA9GxmZh2O1026y5LyMCW5+nY9jITh0hLrH+cgzZ264myREtx3cR4geyTkJGBhDZTKe6rsDecK6MEWyMChQ2BwtxuEbRqT0Vp3QGwbB6G9hN3Yviehwi9kYrJd7IReTeLtpkIvZ2PkLg8mYISzv0qtOWM3vA7WQi88BX9192A1aAFpCcG4w+KMrUaTodpfaJKJJa5SVatKWS/BFG3WgQEh0bL0aDBIhgZRSnUif6m7q9gMCn0aSzq6vBMI74UxUbIVBJTnUGoVXscdKoPK1ZeSlM2L+TIFc7Vi8/lY1KDQb7oTSbRzC4dPeFoVRPvH8+UVEiyggKi1OcoOlQT8B1JGiDXEGcJONpVeDqi6vTVEkj9wS1RdCxTJ/UUOewr9Le92zqjU8su6NxiFjo2myEzKto5TEDT+mPRrEEgRZBOuHF+EjGS9gifSBX0750xLzp2DkcG2SyrolF/K7S5X4I77NJ/QGuIe3h8M6t2+CIzJRXh+/SBI2ZN6obgEfcRNPQORg08K0Hh3nk3OjuuQkRQI6QnczIYnY7pU2YZZKcZ4swxbwzsXUsObOdMSV4iN+FOFyR98kH87e64fK4B0pN46nX6nhRTWli/RpADBeArUZ+fr+LAACKCj2POvFg8pY9xaYW4lVYg9QSD4sKXfBx+k4vGg2ZKQMi0B81hSjoEAUINCiVSKA9X/YCNiJIYVOiDPosuY1YcRYkbaYiOS5OgWPowHRsTU6TQPvIDcF1wkDh2BAFgPuxMFsrmWDVdamw6XwKDAcH9FQ2Np8ss2cYGU2FJtLR6velw7LoTQTE3sONUDlbfJ5p3PxdhN9NkGsqEq0kYf+Ubxl3LwNir6UUJi2obfz1Z9rfMuJuL5TfzsHDlUzh3XYzyOqNgYTsD9XUnSFBYG4RJemStFyFBUdsgArVMo+HouA6mtOWEQP4b0yk2NSiUFqyxEhQcKbjH3JCEf3X9ERIYarpZRDupPKuUcEFzh974/DG1CBSyRYrfUKC/cfUpRZgyWDC1CT1Gcm5y7PzcUqTR9eHatzEMqpNv3CffydLDpjWWiI8bKB1ftlzl/yabatXDX+XkB/S34wf6ElXqjk7NiT6RdWwxEc1tRiviu1kkWjdqjrHetZGZ0Q7nzlZC9TI90L39nPgH93OrMyh4DT2223dz5MpIRYBgyy7IEfnklXHn4FZbYzwWzhIyOmSleOJlQh9MGvkFYcM+YCKvXT0oDqMGXMLw3vvh3nUB+nfqiXgec81zi/JFk3GLk6wJuCWJnP3EEYHeHZRVRnl2ufCQBnj9rCP9tNKRJzt0GHxXr8DCuC7Wrd1LFIzKTkYJfnGEoJLNALavvolOPjPwKBN4QHaXokRcah5uJefgPGmKi98Bv8HnYFzeT/busvjkMdA8pxIn0Mk+CFVHnRoU6qZO5ut1Ok+V4yk4fXxKXDpm3EnD/PtKpFj3NI1ENrD6CmBmPxdW2lMlbVKo0iyiTUpzrL0JRQ6juTIRUCYDkti21Z8BU90gmFANNmjJMaxJzMG6V4VY+Cgb029ThFB1LrJxKsr4K98x/jK9v5JWlJbCgOA09/HXvyOYgMPHRt3KxJwnOZj9MBN9Z5+EScvJMKg1CbU461VFn5T8p0lyDAWnjddqspQo3LKivzN1Yk3BwrweAYqBUZcFu46vrFBMZY+7p+zAq6nrAeNaPtCo7v6zCVvVmlfht7bw8lgmZ0dkLBB3Ub+RNnbkZjk68umjJijI0leaaSkCXL1kgCa2AgfIT7h/gjNmmS5lpPVA7E13zJruhRaOeti/W0uKZ7mYTmEpPLnviIE9tNGx+WxpnVqMR3PrkXLpYl7Pm5ct7tBsDL69/w156VXQrUV3GGrb4+C+RDdel4IjRuzNVHHlaqY0oks/QZFTmCtBsXjax7VmFQKI0thKUCR/6Y8ls8sjnNez9v4qQRHocQv+Ay9jRJ8D6NN+BtYvWknOq+7OpxqAQKEIZkY5I5qcPqcWUj64YtHckWhiU14u9MHrwckwSlFCRgo6NmTYULRr7oI0EtdypZ+il1Konyh69GwfiLPP8/GEtMb99ELcoyjBoLj5Q+lV9lt+BEbVxtDDDaEak2o9LX8SjUPlvEp/Bwo22WtctReqaPWD9+zLkrowMCIJGOywPByVQbHheQYOkbh2jbqIijVCFEBws+svoOCWJm6FsjWZpQBDbzpqVZqInh22YueJQhwkvbPhRQGWJBA1u5+GmLgU+Vvs5CHk/AwKCQwCRdAldfLiz0gRdC0JIde+K73zN9IRdfs7Zj3IwOZEYOqmd2jccjlFMaJQTJ2YIhlGyrwntYbQrT0dNq03yCgiQaNKHWdQsHE/B4NC9mgT9eQ+EI4WXHaGRNP0TIfDqKY3VShKaxjrMDbuea9cuiU2bNymYIH/KwaK14+AGtX7YCLpCOQYymjBlvLdGW9e2iNXtkhpIvlHGZw4LuDtJdCgvoAesQxNEuAjhjALMSGa9ZsERurX3gS0+qQrpqFLq3m0HU3Rwa9owgwGBWuOh6QtkKOFWaGzUblsXUwM2bxWjsLjtPKEQnGXxPeNm8UGGbGuKMiHSE0u0O/ReuXLXk2XIoWzWwsqYNui2wSI25jm/wWR3u8JFI/IcW/Ab+AJ9HaejZ0kgJCjJ0Ma0yae6p4TwV4/ccPGlT0wPrAtpk3thYvnOiIznSIDcchP7wQ2EkV6/pib1+h4+i6j/9E9Zzmofte6P+c2SaN/PBFBv8HrMHvjM9Czx92MPNzJKJR2JSMHxHawZD+gYTqRQv144sChMCIKUL2aNwyqDYMeiVHdKgOhS7WdDglpNm16wGx6lfqiWplu0OwShZBzRE2o9mVQRMUSRaFIwa1PSx9lYSNFiZnXk2DVeA30dKehJkUDC4oKP22htNo158PcdDZq0z5zAohGDW+4hm7Dodd5OPwFUptw8y6DYu79rJ+5WcQBeYw4j/4LvJJKxtQpXaa0s40ngART5GDgcP5WBB0fxSME6Trn3UvH/IRkbHwLTD76BtoNKUpS1Gd6xJ14bDLVg6wuRQv7urNQz34lNIwmw8woHKb0dxODUBjrhxCVGUtl5w8DTW+qWUdAX3OIzLHiQVDcbFyVzKSGDwwIHBo6FCmoUpHRlgDC+sLSxA2J91TN5kXPUdnMi1kMEx1dxJ7aRjsUGqWeyuj61W6YHN4UDa3LoAppUau6BIzhJdG9i7nUHTHRTK+qyEpUsgvy0QtnBdo3GYCurcbB0WYEZ8bCpXmkHOzG79vY+uB2LB+rievn2stlkds6BL18eBfGRVPhqGYQpKMUUMhWJ6rOb15/6G6pH4ipvtfoAokK0Q8umnQSUb7xiB71GVN8PyLC6wn8+p1Gf+ct6OMyB3di9RVQMCBYYOeXlbMDtnVUJuItV1YxnsZ9ahRHDF5F5w8Jgvws1YB3Fuf0ecIYgRYNA1H4lyZYMvq3feNJ9B20Fs9JtN3PKsC9zHwJiNvpBbiZW4hjH7/CecgJ1Gw0D81tl6Kp9SLYWEbDqjZx5prjUddsNBWIHzkt8WLjodJqGNKWPtcxHC47p7rGnEb0rXzi9eSgRGeY0jAouPVp2eNsCYqe84/AwmopmjTaiGaNt8Cx0Wa5bd5kK9l2er8NDk02wNF+E+yt18O69nJMmp+AqxQdeMKD3aR3GBRrnqRJUMy+S4L+Nv0WgSKUgPh3oFCPDGRAKPZDAiOcgasCxdy7RPMIFNyfsovqldCljyQo6utQBCCnV4OCe7S5f6K2HumNZmthabcCtg3mSmtoNRvW9WaiQb1oNKgzCQ0sJqJ+LSq7GiS6zfxQi4DA/SjGZAyKug1IeBu4FeVoqbVapRItMbj/lF+eo7L58TEd9WqYY/zwHrRDBQoVUxhPmrNSeU4zp1p9xiDcuDIMwYHVqIIRmE2fc7JsyYc0FE1B38nLKYucTENEjlmCljbD6LmPlGKbAcHDop3sx6Nz80C8fU3H51fD1zfe6O6iBwONrti38527esZABgQDg65CaXEi2i4KsyAWTT+0sqG5Da4dm0rXTtQHpTAv/C2iAhIQE/AYoUNvwavXYYzoeQi+/Y5jRNf9uH65hPwxTu5iQf44foJsduUpasb6C+zbJTBnhkBNc4HyRJkWzC1PNX5TiijKipsS7aQrYk8cgom2EfbvOa4qP1VBqsLv28dAu7azcfjxOxkl7lOUiCdQ8JYpFAPj1PsUbH30CZse/cDK+0mYd/MToq++Q9j51xh78hX8jr2E1+EXGHbgJQYffA2PfS8waO8zDN73HO57n9LnZwi89E0KXW4FYou8lUygSMHs+B9Y8ywPq09koH7DKbCtv4Acfg0cbTehacONtFWsWZPNcGy8Cc1st8LOagMMm03CpF33cYG00LGv2dj3Nht7CRRbX2QRKDhSkB6gGl4NirAbSgYvO/34S0lFYBh3hd6TqTUG642Q6ykIvflDfo8bA2YTKBY+IO3zKA1rXqRj9yeKrKN3obqWT1GE4KghW5voPVt9oymy8uD7YWtkOR22dWNgVWeKtLq1QlGnVhAsaoxGLTN/1OC8LBMfOQiKjSsW7swr3lghBThRKZ3SXbB/xy2qKIseY9Fr4fQrMvXiUYK1bHFiKsSU6PlTgdOneGSmNT6/7oo+3X5Dw3oC50+TrxADkfMFF5aTTf5ysUtevjjnd2QnmyJ4nJAZC9xX4WzPUyuxpgikaDESD+JayvVM8jLtsWKxgEZpF0wcd3ilkjauHrdNkUIBBEMU4scnVHLrMTHBpakzsj4elqBgY1AEj4jF2IGXMLr/eQQPuyJtlOtJDO+yD/dvV5SgUC9Ju2C2tVzlP2aqPtJ+jKVQZyvt4IFoGBsJNLUTeP+ypkwSZN2hNK39hgnDPNDGvhUy06jo/gYUE/yOY2LoJSTS+3uZhUWAuJeeK0ERS5riWkoBLhHFOklC+8BniixEI9a+JN6emIc5D/MQfTcbkbezEX4zG2GxeQi9lUs1cyY5Yha9z0bITWUAktq4JYhBERP3A3MfpsiMW/fQo6jK2agmU1HLaJakRxakHeqaLaAtUSnTeahTYwFqGc6HkdZ0hK54hsvJwImkXNnTfvBDngTFtpfZWJuYKSkZg4Lpk8ziJVBITXGZhDQBQ06mwDpCNXacQSHtb0DB55EpLRQpVj5NwfZ3+dhHQb9JwxhYVB2vRAhdzn0icNB7trpk5qQpzI2iFNMPRk2DEJjoB8FAZwwMdP2gr+sFPe0hKhsEXU0POSqQh8syBeXxJ2ptVgSOKkRRCRQt7FyR/C33L6D4/BKoa+KO6KkMBl4xV9EI7PR5ubVw9aKQaw12aidw9+ZEAkl1fP38G969Idr9XCiD17jPgpkGN+5k1caqpdoSFDzqsyOvhUKgaG8/DnaWrhjqJnDrig5VxA64faO8jGwtm0xIePAgtyqDQW0SDOoOu8Rb6NiQQmx0sK78YmEBOTvZmX1n4dN7ByZ5vcRUP6p1vUhoD7oDn/674ecZjpQk+noBT3asRIpB/ZpAjwRRIl04Z8kW8DhdQjQn/AWM4oRAgXPHPeg7SoJYQW51PH1kRVqiD5bOvE7nUIpOveWs5NtXk2DbKQQ33wCPc4CHmQVFoLhDEeJ2Wj5i0/NxIyUHl5JycPJjLva/ycE2rtmpNl4Un4mZtzNk82owORE3Z7LTq0Usb6V4Zc5OzsYCVzocRQqmJjPiUrHkUQ4WkcO2rjdDOhg7VEPDaUW5Ter+Ce6X4CZYPb0ABESfxs1MHrKajRNfM3H0YyYOf8yWeVncrLs2UWnRYhE/haKRAopkRNzKwnQC7axrOZhzhSIJ2YxrmYgh0E4mC7mehnHXviHoxne6xmQ568iUuGTMJsHOoFhBhbQmMQubn+dhH0WLYStOkKMGFKWNy/mfdJW5oFhgs7Hg5nHcLLKtCBDcoy077yjKcG4WJwXKeW7J2bkX/WfnpxoMSnYA7+PZ0rnPQtKo39tg0fTLyrMs9uLHO3nybFiZ6+Pl3RXkD6oKMr88Lp8XMNQVqEI0qk0rgR6dSDO0FHCm93YN6xFgtRASXB7ZWe0k9ZKMI9sESxf8hhbWk+RkfM5NowgcYWjW0Isq21FEy8fKkaEf31ZBVpoJ2jn2goluS5w++q7j04eK4OYpcSQYOK2Dt7tW50Qal/eRkxJwiCnIr4Dv5PDLZizH9LHXEDP6Iwnt1wgd8QTjh9zDkO6bsXQGCaWC0vJm+DQMisH97aBDAumOOo9eFeIYFKN8hFww/MrZYRIUSqSojrkzBeoaueEb1cTFXwwMXnFn5KAYRCy9jJf0/kFGvjQGBRsDgoFxKy0P15Oz/wKKVVRrqkEx5Wa6BMWEG8roO0lDVHREUhSiKupWHzWFmnKLhDaBYtVzYMTqizCr6EO1bThsOH+IQMGtT0qTrGLcL1Gn0iQMGnQUcQRiTjs59TULx79k4NinLBz6kIU977JlByALbe774ObeqXeptr+bhej4XPif+ojuiy/BIWgbrEeugI33SjQJ3ATnmccwcMt9BNF1RpA4D45l4BKI6H6Kg2L5I4pCT7Nlmvt20habn+SQ2CTxXy1YATOBQQ0MNSjUrVRWeiHg1PPioLDQHF4ECqZFDAp2+OKdn+pWKAYLG48hZ2DoVugMqxqeePdOWfrgZ6XH8259Rh1jbSybTtqCfEcNiudPysLfuy2CAjpi2tQGWDq/GdYua49JwXXR2LouKpcrCUsS4E8e8+JACg1HrhnWLC8rQdHBcaYERVu7CUQNhxMAAuQEfU3q+mDbJgJRdk1MGBUNjXI2WDz3dGTiA26BUiZilmCQeoJEduCQK8caG0/Bh/d0cfnaFN6WY17YekwZ/hnTR1Ohj/6CCN/XCBv5DGPdbiA0UAPfPpjQxfwuQxjfEE+Dv3xxbTklu5trObx4Ohu5Ga2lHT8cA1NDgQ5OPF+ongQE39CnZ6Fo2dAU43wnk3CisuECk8VGL3pz4xLQovV0xCWn4zH9/QEJ7Hji53dJYLPdI1DcJep0Oy0Ht5IzyQmzcOKTwt23PM8mB8mUTjftzg9EEg3iWnYCRQQ2di41LSkCBXGdkKukJ4jXc3NnRGwyppEQXn8bcOq/BOYVfKRD1eOa1WCqTAfnNA41KMxJvLZ0WYYjb5NxKaVQDlU99YnzsbJxhLb732dh9/scbH2ZRqDIwuJH6VgYz513hZiz9x1cPdaivpkXDMr3RPWy3aBbpovKOtHnzjLFommDQIwIOYxFp35gyu1MCYqpDIp7PHYkQ97z+idKlvDWV+lypKDv5HOk8/wkKHhKGwaAujmW39sYhFEUCSE6FYw6ehNkkyxnynKTbC2t4XIAlGzSVjW98nVw3wT3U6iNExSNq3aDabUe4BGC5tVcJYA0S3RETOQ2+Xx/PmCFHg9xXYjW9mOQRfSIc+XUzfPcNJuV7Sjnm927ZQhce9dF3ZoCtWsIdO9IlfUigW/kq2r/4+9evCzgaOMPlxZhsr+iZUMfEt4BcG7GgjuKqFUoYiYr/W9HdtD1ajKzmXvscTxUQ1IJFGpAfP2aZNii3rwk3z4niM9pgqe3P7FvJAFhMeYGpCPGPxlR/p8xedRbhIxIRMCAa7h2wRMFWTZKUyw3qdKNMChePh0NF3J8bkFo3UJgZrTAxAnKsltVKgjs2qpN37NQ0E3R4vD29hRuBW5cSCgSZEoWLBmVm0f/jZgxOx7cuR2fmSujA3fYcXSIzyY6latYAhV4fHahpCsXJIcH9hN12ES1NdfyCxJzMTMhG9EPgKh7+dIm38lFBOmMEIoGavrEoOAZPpjXc58Bg2LWw1xMP/oR2nW9YKUdKIeUNjCOgrVxTBFt4i0PIrKuFYP9JwjMFNV4LlkGxenPPPN4jgTFoU9ce2dIY1Aspxp96aMC9Jl1DBWthuGPSl1RvVIvmRnLtTI7Fk+gYErcnY0dUadCD4jKHWHZKwbjL3zGtHs5UqjPustjRxRQbEjMlvPebiHw7ftcgA1HM1DXIgJ1tUJllFOigjo6sPBWZvGwJD3BwFBnyvJwVJ4lRN3Po56ATW1MmXi2QvWMhQwIXqGJRwjydZvT8QxuG8seePsqpQgU6qbaUwe/QrO8E25e40qSKLskLiXx8etvCI9guiRQrZySDjRyqAMO7+uNH5+JzWQ1QmFWVcX3ZKtnRbz/WA7d20+BU9MJaGcfgGYNvChKBMPJgbRF06kSFBHki1nJ/fD0Thgc62vAtu7gpLjrhaaJiUSfuPVJZsTmQ1y//LJnPaNuWB5+kMKXEbIzdTFt1DeyH5hKFhNAoT3gPSb538bQ3lswOWgJ+a9qcmQOeVTrc1NZbnYjokzV8CJRkDMLOaKKW5zYmtDNbVrHx/+mRJac36Wo6u/Ca1iMRE4OD29UXjLEspa4/BENnCfgMtGqB/RnboaVeoLEOPkziOFgL9FVtm0XgY1ngNXHCrFsTyYWbv6GGaveImLhI0yYdRejp16Cz6SzGBF8EkODjmHwuAPwCNiLrmP3Y+iyuwi+ofQFqDVF8PUkKWIjYlMx51EhRs+8A2NrqmUdlqCh43o0arUVdm12w77NITR1OgKHdodQp+lWBG29jEsETAUQ2Tj9lejTF4oWZBwtOOV8N0exF6nY/rIAO64Dvd3Xy4RA4woDSQC6wdiAHNBmPAzrjUFNC8VMa/vDrM5o1LDwR806AXKOWV3DwWjdbxGWnM+Q0Ww6Uaf5RMd43AcDbsvzTJkpzBNCHyBhaz9wEWpVHAce6KQGhDKZQTjMWFfYzodNq1Wo57gU9e0XwqrxfFg2moJ6NlGobTURFvXDUKPuWGl8Dea1R8OcrofNrM4o2u8P03r+qGY0SPZ8S/1RlShXFTdULd0RC3/RFvyc078DrZt4IGiUGdXgAxRQkD5999YC7aly7dtHYMd2/kz7uU+Lm3C5UYeZBoMhkyJFhuJTnA6ydokB2jXVkwsF8TrtcoJvh8lo5zBFiRTTeNK09qSFO2M4iW890j87N33sqZ4sTeTLga8Qm9efiqqj3xn7l9xEQZ4hEh8LTPFRaNP0MWnSgoc+ho/rCfgM3I1JgYuRxfqcB6AzMKjGP3ZEYFK4UFbLJGCkfuuLU0f6YdHCbli/zo3EdDfkZiqDTGT+Sn4p2ZJgptESC6bxnLS/vAgUQb5z4R15APR8ZZ8EG+uJh0SfHtIhkTvPo5L5KOjUHw/NBuOhUT8QVeuNQ1WLAFSt4YtKJiNRzmgoyhoMRgndfvhdpy9+11RbTwgK9aJ6P/SKOS8T7ThaFAltErFht5Ix+XY6Zj7IQ+PuS1DBcBT0akbCyGI2DGrPhWHthTC1XA2zemugZToPLq5XcCGVhPUPBRRy3QoVKDhScKq5GhQ7SWyvjk+B44AFKFOll8yQ5fRxBgX3A+jU8kV5PU9o6w6RVk1vkDRNXU9pWnoecp5ZodEVnSfsJuDmI+Z+quxk5H6K1WSbnqZj+4tM7H5BlPIjMHTaWVhUCpT0Tw0KZdqbSRIUVjwSsMkCaNaIgG6NcOibhUPXNIB+h8rY0Bda+t50DXwtQ6BVfZA0TR0PaNH1VNUlxyfTMRsGozq+stdb6g8CBY/W06nQHS0aBSA1VXZC/XxRZRcdulGOyvzytjP5EvkH+VR6mh3evKqP5B/NyYmdiDUQtaIKVTboMCCYoahBwSaZx++yH2KslzOa1PGAi0Pon0DhUH8C1q5RQJGV1hPzY8oSWDtheuSVKAaEBAU3yeYkQwSP3nygXaN6+P5iGl2QqRxDwaJ65tgviB73BOMGX8O4gbcweeRj2Zsd7ncaORy2uAWJMxcLS2KoR2toVRF4dNcOvJZ1br4B0alyFCnpYklEyZQPeRNkfANZdbFpdV0YarXHHZ45TP1ShdVXRHPsrUOw9/4rPKHAwbQpIZ2MBPWTTNIS7+nvzpup1luIpqYrYG+6BHYmi2FnvEDmGclakNMVtMfJhEA5+F5DyX9ikWhOHNioXDeUJz479vhnBN/KknNAcbSQ9On6D4RfT8bMe3kIP/YZtmZUQ1bxlrSiPgntRkZT0ER/GuzptxpXjyGQBGDtuW+4SoA99z0b577k4fzXfIU+feF1LHhtikzSFBk48L4AB54CbYdvgWEZN1iSmFXP5qFH18dzPlmYeimzeVQlykSg4SZETkNRN3vKRDyqifXL90VDs1GYdPajHAi16IESKbi5l/tCtr4gqvaKh88WYuqxB0SHQsGTGCgzeSiAYGBwD3cjs2hYN1kMXaOJMkOWh7YyfZKagqiTNFVCpZJu/9PUApubamvX9IG+rjv0efZC+szGQl23TB8c3HuDH2/RiylyXOw9umdzHFizlfzlN4WKc2UL8i0VE5FA4H0MBvY91T42ScV5v5yRUBsnzgo0rT8OLo6RCnXi6VvJ7OuPxoEdTZGT1paYSm2cPi6gU74TvDzWHGA9IekTw/LrG5Tr2i70pVuntsj9slCCIjlJE9MDPiF8+HMEeFxGmPcdxIx+iehRzzFhyDUJCrkmHQGCgZGWygLaQk6dHzpOYNsWgdjbAp+/yECkgCKPjuXReAwKvpF0C7l4S5umvsjh5XDVLxUoFsXcg3uftXhEEeMe0REGxUMCxCMCxisqyEXbPkC7ZpQEhKPZSgkKaZytSo7KiW+cNq3OfeJZ/mRim1xosb8c46xHtYS1+1JEXc9B4LU0CQqOFnLWwKtJEhSz4wvQd/5FogKD5Eg0K/0JslmT2/zVoKhTMQz+oRflnLLnfxBt+pYpAcHAKA6KE5+zSFPw2G5gyOyr+MOSBxh5Syua4qbaQAkK9WweahCoExb5szpvS+H17tAt2wtdZh/BiicFWEDRgiMFg2LzswzZysWg2PM+H+vu/0DjGjGopx0mO/HYmD6pTQKj6XIYmE2WLVA8xQ0nBDIoeE0+adXc/hYUXNGwyak+DYfAwpyiHUcLFShqaAyCTunecHcNJDaiPGr5ogovJ7sArR1bYoz7CAkKpkfqHms1KIq27PwEAjUguEKWY3DYr9i/CBT7DpPgtgosAgVbu6YT0YgimGsPXn+9mgTFs8dlUEtvAFrZjX8ZG5taQQptuh7x9A4aNTAJQuQEM0KcA/E8ZSr8LQv3YlT/I4gZk4TpY78jatQHTPZ9hwnDtmL1XC+6G7oocnbuy3j2sDzq16kkp0XkuZvKlyWuVvV3NKlvhIH9miIqqjPu3a4sVyqVS8cSmJ7eDUR906qYMnkB3bxSOEVGn1u0m4PZ694ikTDCrU3xGYV4SDQqnsLtXQLJgO6XqDabAzuzZQSMZXA0XirNzmiRTMazMYgmihCGunrj5NQvNXWULE91TccTE+hU7AnnxRcxOS6PaBNTJ+40U0wm290k4Xo3H+2HriPOP1AO8+TUagkKOj83ydbRi0Sjhkuw99k3ue6dnE+W54JKUqLEmS8FRUL72IdMXPkGTFv/BEY281Gz7lxYavrJeZ+42bNmNU8JBAaEet4nFqts6twiBoPaGBQ1qwyEfukeaDpwAVbepcqCCmnJ41SseZqKTc8JFGQ8KGrXW+4wzIWT00oSzUFoYKL0aBcZVyAUWWs3Wgozq/lUkdB16SitT2zqpQJqVSV6R7+pvq5fwVFkdUdDQ38QgYEBQZUQ3ZtRhf70zD3xhEeEyWlxVEbPfGrIATSxHEp0qTrtqqw4PFek2YrJ5loVSCQwcqsgL7s+ThxpiptXO0mf4ohRmKeHnVsJFA1IbDtw/hPRJ8cQ0hc+aN3QVy4cxIvAvH31B7IzjNDZ0RMm1dvg1Jl3jeU62nQt4twheJhT+D66u5/sn2BAZBDnXx69ATFjKUIQKKJHf8UU/4+Y5PMWYz034MHVdXQzqr4JAsXhPQJ/lCJNETYIWzb6Yoy/HZwc68Fcv4JcQvYPsmWL+SY1i1KFD2ztCP3KAhfP0ZOUwYGuhgFBduXCHTRuNhXXEtWA4GxYbootlAOKtsY+QYOay9GIwPCvgKIWz9WqAoW6ptOv1Bt1jIdh5JG3CLueqQBCRZ3UoIiITZOzeJg0D4FpJc8iUHCTJp/f1iiGHCAE4WEvVK1Nynp3bAyIs99oqwIF64oz9Pfd8cmo0Xw8DBrMRe36C1BHw+d/GRTcNMoOakiRwqT1BMy9nIalj3Ox9ElaEShYUzAoeFz5PtYVQ0/AuGqAnOdJuY9IZRZ1FShM6s1FncbL5DgKBsa/CwrZV0Hi1ZA0ka7pCHmMBAZpC74/zbLtsXz+CQUMxUBx/kgS6Q4n3LrJfqKAQgKDe63JZJM/A4Itn9dEL4uli5TVWBfOrUb+o6x7wqDYs4Pok9V4OQpP0if78Whu5YVOzYLAM+Hb1/PHvt18vhrwHRCBquVssWHTTY8EnmCZ/FBsnI9o47KhePlaAzl59ZCZFIhdS6MRMeI7pvlnYkZAMlGpb5g6+gMmDL2PnZurECfTpwunkMUXWFAW8XECIcECjx+VlxfHTs/A4jyWE4cE5sQIPLjHN0RRSEaKkvAfFg7Lms3x/XsyAVHBAzfF8mTJUeM3o5P/XNxLh+x/4GxYFtn36W/c/Bqy4A7qVZmFljXWwr7mCtiZL0cT06VwMCFQqDQFP+yfoPCTKwXxg2VAmFRxRWUCRb0O0XKcwvgbnEukRIoicFxLxpTb2YjakAh9fW6OHCbpE9MxmVSnx9NfRsLCIQQHH+TKKMHRQT3r+BkCBoNERguyE0ShLhBNHD/qPFUG42DReClMrOahHkcKonbqaTOZPvGUmWpQqJ2Np99h4/dMR9SdZ3LKmcoDYWDhhfn7PxMosilSpGHV00xseJ6DHc9ysOtFnmwCPpwEDJ8TjwpGBG4CAPdTsPaS+ouENo+pMDajyGe3FBYGwVSRjIa5ro+cT4rHo9SsRqK52gBycqXzjk19fcbVekkzJcpkXLEfqhsOky1l3ArF6eY84YGZ9iBol+0jhzHncbBQPXe2z29B/tALS+bVR0FmoyJQyLH+BaVkcz8PKsrOboNrl7uhWwcblKeK2MGOKtbz5FMUVaRWza2AK6QpWjYYBedmwXJpagdrL7RuMlYuTOrsMB28LuP8OYIiRXvMnz4AWn+YInTC3mieZ1ZGitCRj3faGszFuw86yCKB/PzBQMwIHEpAyJY2c0yKBMVk3zcI80qgi+9GyDUtAkV+NoNAE7k59aVJdDOq6UbkutZZNorlEn3KJP7HF05mb+WMQQPGUnEoL9k3QdssohfdncYiZudNPCAQxKVmS0AwMLhfIu4H4NhrAez0l6KZySoJCAbGPwMFT2PPNR1HCjUouvltR2hcFoKucy7Rn0HBLVAx9/MxbMppVKlCvJhAwe32PPseg6KhfjRqVQ7B6MgLuE1aQk2XioPiXFKB3Mea4uyPQmyK/4gGtUJQQ4euy34FzKwXECB8CRgcKf5rUPC6FGpQyM9kalCwVTVwQ/SWF3LBSl6bb/WzrL+A4sCXQgSufgMtixCKekQDVYDglig1KPSNwmFtuxBWNSb926Aw0eS+FQJtlQHg5QK42VY9fsVUm3QIT+9ZbRBq6Q7Hs6evpMhWg4JXYfV0jZGL++Rn2Er/UoPi21eBHPKpTPKbdesErOuTQK7K66p3RuLjHrJhR+oMrnCzy+Hru8ro1TYSbe0DSS/4w7GhtwSInNaVQNG0XhgWzVdAsXNjIFVSFujkMmnntct5QuTm5ot+7TfG9bBfiqysElRjl8P6WQmI9E2UzbDcPxEz9jOmBryET7/zmOx3BSnJZhSiKhEQOFTRReRXx5eP9ti2uQ+OHhqGzJQu+PqB0HyuJ949G02iSk81+IiO5dYB0hUvHleBbmVCaczZYqWi2M0LQIMGo3Eo8TPuUkExbeIea85zekI068wNqlFq8dQxK+FYYw0cSGhLI0AUBwXPhMdjjrm1SPbMqsZo8zxJPLNeaePBcFt0CxPv5GDslR9yAI8ExOXv0oJuJCHyYQ4Guq2BTvk+UpfU0SShXZ3ok24oCVBynlozsPrWS1yiKKFepEU9+/gFAoEEgwRINm5SLe0ffhYWFcfCVocA1YQihfV8OZOHMpsH9xoP/Qt9UlOln0Jb7YQkwDV5tJuyxLCO7kBMWfMYK54Wykix5mm67NHewtTpZY4EBQv8idt/oGIjqjDoHpRWqMkS5FxWPJGBefUJsOEsWctpMKgeqNAnKjs5QyD9jrrzTt2zXXQ9KlPnRGlq9EJNMy+YGY2EDoHJVIsARd+vpTkC2iX7YtvGi1wTFr24fWX6tFUkhnXw8XkY/U3xr/xcfURGCqrxDdGpfStoVNYmEW+JXdtbIjOjGwGlNQHHnGh5WUVrsBX8hvVL9dHOXhsOVj6kLULQvlmIpFLOzSajqWUA9u6kijvHHA+uDyCdQ5V0w7Fx507kCPHhw6dKzSxjfkzw4AkCyktQzAw6TzrilQTEjLHpJLDfIcDtFsJG3kPwsDO4e4ciRIEyyIMvnBdw9BomUKUiiWsdgelTBNz6CVQnJLeyF6rZGyoomYxsudVwdL+QoDh3lDyFwVBMT6yYH49evRYhjqgTT0ZwJyVX9mBz6xM9b0QveIqaJjFoaraawLAKzcxX0/uV/yUomPZwyxPTp5pVKZRX6A3N+qMRuOstgm9lFI1qY1BwZqoExq0fCI5NRrPmEahOdIB1SV2tAAkKPq9ZlfFw63kE5ylysVZgMBQHRpGmIEDwxMv77mejfrNwWGmGSFDUtl8OU5sFqK0xvEhT/HdAoaXtivBl9/8WFNtfZGPbq3QJioidKdB0nF4ECgUQnE6ugKKmXjDq15oCW+tZEhRyguV/ARRqMKiBoaNF2oKEtqXFmCJQcJRmUOiW7g/fEdPouTMclBeD4uzpe7CuWQ23LnjSDkVD8FrpGzaUQi1DAX3tKtDR1IeulgHV7AKj/QXmUY1/7KhAKiem5lB0kRRK4NsbL3i7NYV9fW/w4qTqnm0nh3C0sQ2WY37ys2vg1YMRaGtXlcrb88eFU3lVREL8B6sGxoOwPJQXVqaTkcUEXcP0wEeYGfwC4d6PMZYAMcX3rezIC+j3BOfPm8gLVYPi0F5/uliBkUME/EbwXLEC9WqWRb/eJWBkoKxJ8PZ1f7pQ1ezjWXUxLaIyLE064TUJaTUeWGuz9XPdRDXqRdljfSU5C3cJHHfSgHvZBUigQvQafIucfAaam6uaYmsoxvRJUigS2jy5cQPDKUr7O9EnC91RqEFOJ0M3RQrj8r2g024yJp5LI0GdoRqfoKZOytjoSbGZGHvqAxqa+MCkohvVmCw8A8l5KELoRUDHwB+zNr3ERbq2kxIABIbvhTiTxAvL89p3pCmIPvGKRlcI1FExb4lahCizeehMleOjjaxI1FIUK7466k/6xP0UShqFYj/FNVsRKIiqMK2pqt0fYUvuYs1zYOXTLGwkIOx4nY9db9WWi6PfOVJ8hJHjLDTQo0qDTOZBETCUOZ8oAupNQAOTcNg0WUD3OKEoyqpBoeQzKZqGrei6qrDw7i+vicHLx/C1mVqORTXWF1Xpvug6a1YbDoNybjJzNV3WiUycFXR8fPMJtpZNsGraEslE2LkVOv4bfiQL3LktsHmj+P/R9hfgVSTB1zg8uwu7OHF3VxKIJ0QgBHeH4O6BECBAggQI7u7u7u4uwd3dPW6cf1XNvSGw+3vl+d6vH4q5MrljdbrqdFdXYQTxV85K7mynoFRxdbRzExebzzVSQUF/k5UWgsQ4R4R5qyXmtFGzlf16onX9HsjOMCfQWUvmmNaNFFgZNseR3VnllNMnbtVyM4vGggQyZRpQLJ/6DEl9rmFw1xSJhh0X+wzj+73DmF7kUrR6jDNnnMSkyUnT/iMTKsLBWsH9mxF4ci9K0tlMG98Ln97PRzPyD12diWRfV5OkSfZxAkXHaIX8vY7IJYXXGAgBxJfU7wiumIxVO7NwLjUHZ79n4/L3HwKMW7TD6Y/fUK3SRnhZTCVAzEVF+4X/x6Bg94d9drYU5v/Ug2f0HIw+m4v4M2ma9QlfJUCQAcHC6y7arb9JYCAeokNul0EPWBbvBpsSfWD5T0/YuwzBrksgpc8TUDCHOMQjTAQCrmyknck+RuR658vvCKg4jxRliJoh0GiUgILdJ06qwIVW/negkDUKGlBIMN5/gKL/5HOYRjdrUso7zL72AQtvfMbiW5+x9M5XLLv7RUag+i1+CMvgCfC1TiZAqMGBLFpOwXFPnlZDBRQmlvFkwXr/H4OChc+LhbmFTZnmsCSybe7Yq+A8GRS2ZdvD1boxblz69AsoOJlapaAqGNShH+mLyilkMIfXWpAXw4kM8nI8kJtanfSrNS6fb481K/tgYP8wbNvBlsVQAMF/8/q5K9o2/QeVfEYIKKoGjZRI2Uq+PUjqYjuBKC/bChmpldG7YykYl2mAjSte1VK2bz7T2cs2GNvmbKUTI6SRfHw5CMP7dEJ8+xeYGJchRHtszAck9XqAUb1O4d1rOugP4gg8yULSuqmHZBPv2MafrEWYpCmZMbUvbt9YJMXDAytw6IevCiKS989bo1LAn+jUPoGQrQJC/qP7cufKG3hWTcD+O8AZUjZOW5OSmieLiO7R95suvEa43TIEWy6USbtQcp2YT7D7FEiACLCZjUDLafAvRLQ9CRSSkYLIIg/JMvEzKl4PgQmbMfpSHuJPaNZTaKJlmWQPPvkVySnZaDn1OKzLNCQrUw+udpGoFdUezWr3QNPanRE3YhpO3HiEM/ce4ez9x7hExDHl4TOce/RU5NID/uwxLjx7g5X7LiLIuzUCXFvBw6oBAbQOnDzawdqxBYxLRMCkZCXZGhevgjIlK8PanFwR8+Yw1GkIcx1etKNGozI4tO4JJwiwJlBIGIVuByHCvo4DqWcci4jykxDmOxGV/Gcg0m8OogLmkdswH1VDFsLbexZ8fefB243Lf6nRvgIMvldcjJ7cQx5h8wqaARO7oXAw/pVTqEGKLeUcfnGZCAh8TgxY1a0id68snT8BwsKJLLXGUtjTb9kZdoY58bqNy+7KoxcdEGDko1OriWhYdSDyfvxDbjcJJ8IgKRjAkRzDf5O3QjqYT245Z5ARKSW8Qjvkf+NSTTSsaUqWIVGsRNWQQXQPBiDEuxeq+MaiSkAYju4eJHVPJo1RYFisDuZOudZZWTBna6KfcwTObTlLJ6aC4vn93piS2F/4hJDtPp9l9Cmhyy3MGHqDDqgrQ2Q8ccfzFINjq6O8axHJ6aRPvIIzLpiSO+XiyD6gIqMJ3z5Fqu7Wjz9w71pteNorGJ+8/F+gWL14N8KaTcbpFyoozn/LFVBwtg4GxeydV1BOdyrCbJcKINh9Ej5BwNCCIshqegEoOJu2h2lsASi02SjMSjdC3RknkXQhpwAUsiaaV7aRxUg4k4rJN4HI+A0Srm1RujoqBUfj81vqiMgFySNi/ZUs1zvq2d7xloROV+Q9XQoLv/6Qk49XtL1PvOPZXeBBCnDzTDYuHU7DwePp2L73A9YtvIbpow8gIWY1erWZjwZ1xyA0KA7eHt3pnhJoStWHQdGa0PuruohxiXoy6mSh2wg2hjzS04osWXsBha1eR1jpdKVtb1gZcCXVvvT5QBFbI1VMTBIEGP7eM/5HUHBoTLnA6TBz4CI5xHdIkf9rPUVh+R0U2vAUY1uyrm79CiyFLeffMu4KA7LWYxN2yaMvDIrJY3YhyLM1vknIBoGCRzdlhFMNJ+KU/nm5fyGLgPL5I3WyrxQ8uK3gyX32Qv5RQZH/F65frIFGtcwQ6T9MtRKhgxHs1ROVA/qjVshg+jwUSfHBAor15JIZ/FMbo4YcTlRGJ66ZFeYRiAdnZ0mKGk54u3DUK4zu/Zzcpq8qMIhLTOz9DaMGdcW1863IjPFB+YTVIdkcQjBnjr51U02bPm0Ch/gqqBJBrhMBI2k470u+HiOdTOLJPbGwNiyODWt20YXK3VAbAWRI/9mIHrceJ0iJjpMLcvGbuoiIwzx45GnE0hR4601BhN0ShDCnIAm2n4cgcqUCbeYRyebtNHApLfGXyX3icAWO4XEgUNgYtNGEeUSjxdpbSLyYLWso1HXQaRh0kqulfkbi2fdIWrEd4VWqw87SFKYGOoioFCW5jAo9xf9sBV//tt9vb6mR2yAhLZqWR0qh2eHTp0949eoVrl27hu1bt2HxwmXkpo5CdKNu8HGpD0ud6qqbQm4MKyC7XQ7sfhl1FmLMQ8ecyExW0dE9EOF6diTO5Cb5uE8Ra2FpqfIKmacgcTMdBG8i1x6Gfcm9mwIzt5HEKbpKCAp3KJwlkNdjq2uy1ZV2WndOdfGaEmDoc02YO7tThtZdhFdwOAqfJ7tPXHqA5yu6tlzBt+GXG7Nt7VO4WTQjV1yX7klZzTJncuuXh6NH1wro3L4iGtergGqVHRDkYwl3BzNYGZdGo3oKPr0JUUefcv7EyxeuaNPsH0RUIEsRNJosZ3dE+PeUuQoemo3w7YD2zVsjN9tXasLzmpW+XTfMUuJ6z1lf3b8y3t1aIaB48YKIdsw1AsMbAQWPQE0kYCR3+yig+PJmCJ0/gUFDghgYBeYsz4AU312SEqR/rYv3r7vj7s1mePbYlli+vgbBf2DbyrYw1y2Ksyev/QsUXdqOxIAVJwUUnOnvwldePMRzFD9kgVHHpG0FoKjouKAAGAwKFRAMjKkCivIWo/4TFFbkp7tadEKXXc/Ba7M51kldYJSK+FPpsrCo8qStqN5tEJpGt4WXmxOMdEujUuWqyMikkyhI7vWzSai7Zsuv5F3BC7UVfqvur/aMBe23/Qua9nPeNQuYOW4b9WrhKqcgq8c1tFnZWGmdTLoKKDhfE183r6Lje6CdnGNxIWB4OU9AQMDCAlDIfSLxtBgioPAy6Q97nwmw9Bwt2QG5yhL/PrufWlBouY64SmIZNHFOXPyeRAsKPQ6D9+j/c0bcoIuIRZlocP7XrIzsX6779KF0WOvWRoqsr/gJil69SgihtjDhEtN/wN2pGHw8jRHq7wEb07LSCb997k96pNbxzkgPoU7WHiGe8QIMXpZaLTRWAMFSya8jurXthJwsHxw9rMCyVEN0aLFovdK51fSDLas5I+v9dGR97Yr9212Q2PkbEet8jI1Nxbi4TxjT7yUGtj+GxD5j8OHZBDp/NmUEBM3kila0ZZu4RnJWRiSePoqTseSHD4qSz1FaRp7YrM0ZHU9M3wjPnrz8+cBJMr8CbaKTMengHRnmPEPvU1LVEI/bpAw3iLBWa7cN9saz4WW/nFywZSjnsBwedovp9RK42yyAm/VsuNlMh6vNZDhajYGteaKMu1sRWTQns21m0hFluGf1GYiYYx8w9FKmZpVdqoR6JBBIRp75hMhBU7Frx06MThoFJycn6OnpoUrlasjO/Ini/PxcnDlzCof37sWRffuwb+9O7NyxBdu2bsCWzeuwft1KkU0bNmLLps3Ytn0Tdu7aiv17tuPQ/l04fGA3Thw5jMuXUvDowUO8ePUSr9++wZcvdPHUNDj7eYs0gZKL5u9CmWKBMNJpLhG1pmQtLAyjYW7ckdytrrAx6Q1bshT2JnFwJOLM98DecjjsCRgsNubD4WA/Xmppm9omg6sYsZvJwOA12l5mg2SC0sJzDOx9JxFf7Aprk250DOIBBu0L8j7x0LEJHZtzaLFw7ix5r9NC6vbx+fGgQQk6RzuPOJnNVi1FWxltsy/bCf52g8giMtn+2R5QX2ll0AC7tjJptlY7X5InjxVcTlFwh1ylx/Sa3aavH8iFJ+Xv1k5BeXdyo251Jr0sKoVHmWdw8oNK/lUR4tVWhmQ5DkrCPmhb2TcS00YHy7AsD8/a6zdE07oTDirRDcdealOLevePM5H5pQsO7nQTUIzrm4fxcekYFfMW/dteR1LvSxg9YBIun+LU5uzbETA0lkIWDf0gxafPmDdcuaQmrAryV/nFQZ6nyClT4OsN790e3s4u+PSBtL7giQMvHwEtmo7E/HMvsZvwcuh1Bo6/ScO592lI+ZKNE0+B8ObrEO6zHVFBe1E5cLdIpYAdIpUDtiPCbyOZydVEahfD32sOKnhMIXeDHrzTcLjZU29l3wfmVp3hG5ksoOh56I2sh+594DXJW3r9DnH7nyIibpK4LXGx/eHu7g5DQ0MBRW62+vhYYfPyOLiOSLGpKVzt7eHq4gCvcm4krvCp4IngIF9UiQxDtaiqqFoliixNKEIqBiAk0AeBft7wo338K5RHcGAQIitVRrUa1REZVQUNGjRA3759MXp0MpYtW4GTp08RFPi4qmVZsnAPLIyqkqJ3liL0LrZd1TxWdn3g5jgAno5DUN5lJHxdx8DPbQL8vKbDt9w0+JejrcdUVPAkzuW3EAHhq2BmN1ZAoYq6xkJLtC3LJcMjdDY8HAbLvXO1i6XjkMXVFJThfFksDry1IPeKX1t1Uiu7kkiBfBJTe+JzXoNkNtuytBoDxRzIuiRZnjIdcfWqSra17T09Z2+njli5pEgBKLjT5ZEnVQyoQ2LXqgTpX3EBxfBBCpxtCTDX2gso8jP/AOcyzskwR+eWPRBWoYNM3kUGcj4oFRiRflWwf3NH/MhxxIM7f8LdvCVqRQ6/pDSsNv5+h4YGyPqYQD11J+zf4YQRnb9jciwwqs8NCRNP6vUByX2/ILHHfmxdOZM0gkDAC0HIWvAwWU5adTy6E42Fs+qiVlUX6Jb+U4IAHcwVdGxBxP0hXVQOnSiDCEXQrVkPVPSpgowMIgrU+IawPLoNUuDeqOg6A9V8l6FGwErUClqPOsFbUDd4J+pGHkZUxf2oEnYAkaH7USmUQBG2h17vVSWEgBFMPID2D/HfQP7mYviVn0FKMBGeLklwc46Hs0M/uDj0oQfcDd62XeBl0xmedl3IynSCi10HUu6OKGfVCs6mNbF3zy4smD+XfsuH3KcyiKpSQ0Kcta5Sbm426tWqSUphCC8XG/gQIIL9ytPxfVG/VhQG9OuLuTNnYMmCuVixZCG2btuIk6eO4urla7h98w4eP7mPFy+fiHV4/vIFnj9/jpcvX5IL+wrPnr3AnVu3ce/OXSxduhQfPnyQY3JbvuQwWTw6rl1PEWf73uo1OcbCw3kwPF1HwNt9LCp4TZDkZn7ecxBQYZ5sg3wXwL88uZr0voLbZAJXX+hR729o3Al6RNT1jTpCn7Y6em1hyATbZQi5j8PIVRkCF6d+cHbsS+DrBUdbOrZND1XoPvLMNdfo45JkXMSSq7s623YXsWVxi0FpD7LSnp2g794Vhp69YUBSxrkrjp28XWAVuX2hSw0J6I6pk/WoI3UTr4Q724w0L3x+XwOvnrXAnZsdcel8Uxw/3AF7dwxFmxZ2BEAFF040oV8gIs6eS84/+Pi+JJrVHoQq/v0lUrZ64HBEBY5AJd8E9OtihG8f/Oj3y+LDWwV+Di1Jf3rfV2pFJL3u1tysABRH9rojscMXJPfMIpfpDJL73SZu8a0AFNtXzy4ABVuGFy+JSCcQqQ5Ts3SU9yiD5o1rwNpcBz3a2yDjYzfVdcpSrQivjGpVqw2qhdUjtKsKpgXFjUvpRALbkw9Lvq9ZMspZjCM/l8vsTqdejNwi6/nwIJfJ1X4p3ByWkSIsEnFzWCLiajsPbnbz4WQ7G442s6jnGgsb6gGtzeJhTg/fzLgbmf32MNJrJXWouSoQi2mZhjAr24jMfX0RsxLVYaVTSUAxccI4UgpnGOqURtWomgIKbnLe5M40aVCfempTlHezE+7h7e5MIHSmrSM8XJzh5uRIympHrx3hXd4DYeHBZDmqo2b1WmjStAE6dGyD3jF9MDB+EJKTkwUA27fvxN69+/H5ozrbf/DgQbx9+1aOy41BUbpkKAz0okU4BxOLGSm0OSmyhUkMLMl1sjQbQM+B3CeLJHKZRhYIVzSS1yZD0aTeegwafAaxccfRt/8x9Ol3BH36HkavPgfRtdsBuLknwkS/K/1uD5gQkTcmXsCz0yyGutEivKiIhevzGeg2FteJhWuA8zxLqVKNEVl7OiZueIZxax9jyprnmLbuLWZv+Yxxy5/h7IVHv4Aik1zm6lUGImkEdaQECulMSdfOnflD1v5HVVLI0irwdCOdsySCrE8eSVlFaige3FlVdFNKUeeXwCVyi0IrtJZ8stWD42UFXvWQUQhwi0X3NmXw/mU50ssy+ExuWIBTK4T4dHmtVAsb+bVbWxfkfulOP1KMUPMP5ibPQWybvRIuPiFOjX8a1/srRsaOx7WzfekENaAgn233NgUliygw1lHQp7shbl4aTGRnEvw9FAyK45NTExsw8ZHRJ3K3alRsica1CCwaH1kVIlhH3kvQHocacB4lTlTMi4Y4lINFS6q1Q7EhtosQylGy9gsQQGBg8bOZi2DrGTIky0XcefZZS7TtjTgtpjoky0OKPAHFEZ1MEjlsQcbc9QkoZWvTPtWxe+8uTJg0HuUIFHplSqJ69erIyeHQTm3LR7NmTeBkzaBwQPlyzvD38UBosB+qVQlHqxaNMWzoQCyaNxsb1qzEulXLsXblMmzauJ74B/GJE8dw4cI5XL58GZcuXcKVK1dw48YN3L1/B0+fPymwpPsO7Mfb9+/kNbdVSw5Av0SAZp6AkxqoaxW4mpHkZ+I8TcQptCWDtQuImGxLVCyHdZBYGfbB6KnXcCAT2PoR2PLhh2QUXEeHWvsG2PAY8G80ETbF20u1JV5gpK68UxMWaOcpCgg3gUKdYFTf83c8dFy2WG00aDoH4+/9wJhbOZh0MwdT7mRh1qN8JF/9gKPn7vwy3vKDeHfLJomI7VUKP9LDVDed3O7Tp0tL5slqBArOA9UuWkGPrgq5uApGjFAwczLxjnu0Lxf+IU6Rn22F5Sv+lhByLuJSNTgB1chacLRsmHdnVPSKRkKfsbSfLr5//hshrq3J1Wz7VYkMTszq3cnzJyhI9qzejWE9ThIgvmJsP3UEanyfbxjRbxz5e+NVUJDkZZfAyye6SBzYEQHelrAn88UZ3Xp2LkvkV0HiEA0oCAwFoKALjApsiuiGMXT5KiC0w5JH970UIsYxOGpysamyvJQD/zjOSTv8yrPYWlBUJJKtBYU/WQoWnrzjenNci4Gz4WmXVTqaEAmlHlVGbDh+h+OKCBQ8nKh9yBZkKUxLVodJyQjs3b8H02ZMpd7eHgZkKWrUqPEvULRq1VJAUYEsA4PC29MJ5dyd4OXhLFuWCuXcyY0rhwAfb1QMJMBUrYImjRuiXbs26Ny5I7p16yYcYsSIEZg5cyZWrl6BzVs3CUjYIh08fEhcLG78fvXSgzAsFaRRumgBOEfJMjA4fqowKDg7hxYUwhdItAnRrI1iMCjplABi9fN0rHqWhlVPs7DkSToWP8rCmvvkxjSf9i9Q/NKJaACgDs+qM9vaoVr+TguKRs3nIel6JhJT1EyG466Ri347AyMvvsbBUzf+BYq2LZPQo1MR5KeFqqAg+fo1EO9e1sTH1y3x/WM7pH9tjIzUushMr0UdSATxCC8SczW+jvQNuTaYNfvnYqPqFYchMmCABAjWCOmLqkGdadsYL54oSP9WHOGe7eHj2TpLifBNyO/f3QPZ31sRiXRHeqoj8YlUcZfG9idAkCT3zSae8RXbN3nIEj4h2lwTWTMZx6bt3RsFS5coqB5Fpoyshn5JcqXcSmPkkNb4/oHNoJowjaWyT2O0bT6owG0Sy0n/HdnxnB5wOxkJ4TxKnGkvhCfjNJZCayEYCAwInrALYYBohBcb+Wkm7xgUFSxHy2gKK4ebUW8ZBuRZWT4GB9FxnD/H6Fjq1YRJ2TCydhVgaVwevp6hqFO9Hk6dPotxE8YKKHRLl/gXKBjMHTq0E1D4alwmL7IYzC0qBvggMiIEdWpGoW2blhg9ajjWrV2JHds349DB/Th86AAOkZw8eVysxO3bt/Hw4WM8ffqcrMQzPHn2FJ8/f5bjsPv04sWLgnu1evkhGJcMUodA6TpYQdUh2Q4SysIhLQwKtpBcZ4ItrwT9kfAknTYq1lK/FwYMOy5rLDiCdi3JGgLFsocZWHqfQPEgHxGd58OqRFu4GHBx+Q6/gEIbdqKdvOPkZwJUDSgKLEWJOmjcaiFGX8/CcALE6MvfMOFqGoEiE0ln3mHP4RRVB7SdJN3ijm2T0KltEeSmkjtEOsMdama6E4GgCtLTWyAtrTlxjAbI/F4bmWl1kJNaE3kEjNx0Z9lXVnfmGpF1VhDkEYtqwSOoM+6DsPJdaUtEO4CtRiLCvfrgynn67W/GiCzfGV6uLfIVzruZEOtXAIpzZ8gUdX6N8f2/IzlWBcbEAT/Qp9FjXDpb7ScomGRrlJwJ94+84sjJ9sL7Ny3JVeiCds3Lw1RPoV5CUesC5JeUfXMyFVT0rItOrRMKHrLcEPpv/+ZH1HO3kZGQ/wKF1kKwy8SiBYN2RptBocY+TUeg1STqEclSUM/oYRyrWUHWVQWEblupVGRcoj4pVx04mDZApcCu6NxmBCaMXoI5U5eiZ5fe2LlrD4aPHCagMCSiXbt2bSLXuXy20hgU3bsTwbQ0FkvBoGAp7+Ei3IKthI+3O/yJfAcH+aFSREXUqF4FdWrXRNMmjdCpUwcMHBgnXGLy5MmYPn0mZs+ei2UrlmPNurW4evWqHOfIkSN4/Phxwb1au/IIjEoEiuJpQWGv36YAFI5cvFEzeSfzFCZc8PEnKLSRsTxM3WfQAewkS7H+eYYkTeOIWi6JvIxrhZP7VKPPClgUay0VXLWg4ONpQcGitRgs/JrPq7ClKF2sFpq3W1oACs5kWBgUO/afV3WgECi6dRpL5Jn05buaFpNnsx89KIXWLRU0baqgTRsFXTuTV9JFkayTg/qSG9WH117TvprAUwbFpXNlEeo9kIAwjNylzgKMasFcgJ64BVkOBsWtKwqyU01RK6g3cdPGYFDkjxikg/SPY/DtXTJ2rK+LYV2+Yny/XIzrl07g+EKu1CPEtT2CmckD8P3tYDpxYvZ5qkgmDyY12QQSzZArWxHkFsG1FAXT2c+7yydaTNbZ8vhxsEc9dG09XG5D4XZo+0PqhVoWWAqt+xRiN08sg5vjQiLZi+FMgHBxWAonu4UizgQMJwKGi/1cONvNoZ57JhytZhDJngArApidaSzsTNoTea4FC90QWBhVgJd7MOrXa4L4+CGYN2umSAKRXR5NcnawJsJYCnv27CHSux01qlaCvk7Jf4GCH2C/fjECCrYUDAzesrVgYWD4eXugcqVQNGpYF926d8LgIQMwZswoTJw4nlyl6Zg/f66Q6zVr1mDLtq04dOQw+c5niWdcxZdPZClIWw4fPSLVRbVtDYGiTKkQ6Ok3hoGBSmjN9NvBlJSWiba5cS8i2rGwMh8oRNvCcjAsLBJgSYSbhevcWVkNQ2ndHujZ7zC2kaVY84JBQdbhSV4BKNY+AWoOXg2dMh2IxPaAmWFnIvQaom3Qgsg1Z+7g2h7NhVAz2TYgUBiT9TAisBiQRTEk8BQpWQ+N+m5C8q08cp/I+0hRLcWUm+Q+nX2HbXs5xOhny6Nb3KXzWLRuTsr6rYoKCtKruzd1JTl3OXe1uKiZkSp2Fgo9U0WKAM2ezoVI/ypw1bO+E2ja+SPYs5YUn68eOhycor96EGcM7IYm1Rvg81ue6yiOOkG94G7fMF8J9xmaFR9TTEDx4kE8Zk30xtiYbJGJcVkY2fMNke5rGB93AyPjOuLZHSLIBAotMAQUXJiPkMknwsCQSTwiO3lZziI/MouTr6eOHbOEl2+MDs2HyA3QNvaVj+56IvH2HIPDqSi5GpAWFEHWxCv8NqJqxAFEVTqEKhEHaXuAtvtlWJaHZ6MidqFy6HZEBG1GqP8G8uOXwsNtIlys4+FkQb1EQCy6tR6LqeNXY8WSzZg9awH69OmLyPAwUh4z6JQqSYS6NEwMdWBqpIu9e/diyZIlCPIvTw+3NOrUqSOgUEee+DHmY/DgQbA1MxBAaKW8B3EKAkU5V3rv6QpfHy+xFuHkTjVr3ghxcbEYPjwRiYlDkZAwBElJSZg2bZpYiB27dpJlOEYk/NQvoLh1h2sPqm3jupMwN60OO/tOcHAg/mDXAx6OZA1JPF2GoJzbcDruWOI44+keTIOP7zT4+c2m85gv4uNDFtV/DuychqNbnwPCKRgUa59xKs88cZ8YFOueAq0m7oWD3UB4OifKHIiLQ18Z/nWy7ybDrzIEa9tdzT4iw7Jd4GTbiTon/q67iKFFO3QYfhCjb+Rg6MXPUhVKiuDcIo5x8hW27jnzL1B0aD8KHdv8VeA+saR/K4cXT6Pw6H5XLFtQX9z08WN64eThfhiX5C+pWpctai2gYPdJnSzm+notEVKudsEiI15PUaviSISWb4+EmHjqwMsi/ctfqFqhM7xdmmUplQMSvsb1IFB8GE+gGIzZEytgTEwGWYgcjOl7D/3bnFUDAmO+YHivLTh7cCw9KHX0iTmF8AqNpWBQCEI5zQgHczFQ2LfjLZMf2o/BEuXbGK0b91N9AWramdpj+1/J6FAF8oHZ/VGrjc5CqM0cBFvMgX+T8/CsfQyV/Lajsv8OhPttE4nw3y7bMN8tCPVdj4oVViPAczGCwzqiQ48BSJowCSvXrsHaTeswa9YMdO3WEcEh/qRQdrC3tiIFdkZABS962LawMjOm3lYfJvo6OHBgH1auXI5AXx/oly1TAAo+V62MGjUSNqb68CEgeLvakqX4CY5yrvYCkCC/CggN8kdUlQh06tiWADAFGzeux+bNG2W7ZcsW4Q0XUy7g5u0buHfvHp48eYLM7Ay6Rfk4efwErl1RXSlum9afIu4TCXur9rA17wgbs3YkncgqdoWtVW/YWveHHXUEdnZD4GA/Ak4OY+DsmAwfV+po3CepE3jlpsIhdC7qDbggOag4pHz1s1ysfJItC5O4LPLapz/QdvZxOJr3g5vNQLLGfeBg0wuOXJ/CitwpOr6IZWdVSPkdLPmzdiIO1BHZm3eCvlUbdJl4AqOuZyPxEnGKq98xlovL3MvBwAOPsHvPBdGFgs4mi0ARPRrdOvLMdLiqY6xXLFw8Ml8HR4+oGclXLR2AjO+tsX61DvRKKdi8lovAFBE3PS+nOD5/LIPmtckq+PeTgEBZbESkm+tsN637Ny6fd5RR1C8fFVRx74QKbq2/KlVDRrzu0+lPAcX39+OwaUUNJHb9TOQ6EwPbXxBgSOg4AWNE7604tW+0CgoSOVkO9yjkPokLxdnaGBiMVE5+yxfD4KDvfuT8hRqBzdGsbk+5EWpTFSzlzHc4m3dGedOhQpS52ihHvWpBUb7+KZgHb4Gn7WJ42S+Fl+MyeDstRzlypdRQj8XwsJ9Hr2fDxigZXXtOw71nH/EhNR1nL17AvMXzyX8fjbnzZmL9htVYuHA+hg0ZjOaN6ssEnb21BSxMDGFhbCDA2LVrByZMGAdvD3cBRf369WVuRXu+LJMmTRBQqECwF+HhWX7P/MLTRZ2j8PX2RM0aUeQWtBcewRZixIhhGD06iVypiTLqtHDxAqxasxIbNmwQ1+39x3cCitMnTyHl4iU6ntq2bDwDgzLB4qJwmIeLXTfyhfvA1TkWHq7x8HQfDm/PZJQvPx4+FabC33c2AvzmwNWaAELupIPFcLrWEbAKmI6ILgelVgYvQFr1NEdAwflnl99PJ55BhHf+aZiUIcCR+8RhJKaGnKytjYgJuU4i5L6xmOo1JTeuGX3WRMSM51B0WqC0SXPEzr1cAAouOcC1OBgUMTtv48DBK4V0gRqBolWTYejTvaSAgrmo1lqILuWVxY3rRQh4CiJCdMn1VVAtUiGwMqfoTb9FloL1ML8UdShcGasTaoQMVNdoEyi4dgUP0/bpYoWs1Hqkx6UEFJVc2sO/XPvXSs3wkfc7R7sg60tfIssGePJIQfLgicQhDmFUj/eY1F8TOs6Wou9kXDkbS2gm5ealguQ65XGYh4CChYCS/qdm8fg/xOijcedaCN69L0EkvDi5UnxBf6FJ1RaoUbmhhEmoykWNbsqDm/nwsO0olTt9LFVLURgUvtWPwy1sL0LIlQrTDMUGOy4igr2QCDav114o7hbXsnbVH4FBg0bh0+fv+PbtG549eyZzAAcOHEDy6DFo0qgxKpQn6+DsCEdHe7EatjYWsBZLoSdRsWfPnsW2bdtkKJVHnxo2rC/nrLpOdMpk4ZgXWJvoaTiFCgqtpfgJDmch3xWDfFGreiTq1atDRLEV+vfvh7FjxxDwJmDevHnYtmUrjh05SiA4h6uXbyA1NVWOc/78RRFt27PlDExLh0CnRH2E1qFndfwD+h15i/jjLzH81CuMIT994oV3mHH5PeZf/YxldzIw9dBr+FiNklQ2korfMgnuPrMR2GAzNhAINjzPFZLNvGLVY85YnoHVBIqeay/J4ioHvZ9EW5u4QDsEqyXZP9dRqESbh7s5yE7fvi0S19xH0rUcAkW6EG12n2bdzUXMmhQcO3H5F1DkZHK97cFIHMJh4G4/+UGGI3KzXWjfIpKIb8xItYaFLnEJM30FEyax3umpeWXJU/mR5UQucjHiEwNkPQXzCC7iUjkwDkHlO9G2PjYsJjeeQMFLWQPto3ny7r5SP2rspTaNbQtAwXJyzzkBxcTY72IlJMUNgSKxz0S8fjyeTpsUn0DBgFA5BZ+MVorSQYoi9b2CSckKAsorOH2GTjCfZ7Xp+9w/0bFxV4QFVEN2Nl19IVC8JmIXVI58VoNBRLQni3IzKMJs5wooKlQ9inKVD0oGj1Ai3iFOi2VeIthxiQCDR6EYFFzLmkERFzeCAPlZhjZPnDiB2bNnq73y9Bkik6mXHzokXuYLKlUKh72dFaxMjQQUJvplce7cOemx2fXRKVVcQKGdU1FbPhYsmCegKGwptKDQCs90s/BoFPMTnvBjXsGAYFAxb1m5ciXWrl4jwNi1Yy+OHDqOr1+/ylEuXbos5FuDRezbdg5mZSpCt2QDDJ14HmNv/kDSlWyM4yKQtzKkuMzC++QGPcmVBM473wOdZxyCXelYdUjWYiR8rUcLKFwrL8GqO99luaoQbQ0olt/PxMqn+YjfdQ8eZn1hr9v1fwsKAUQhUPA8kAWdo7VXT4zf8VoK5idcTCsYkp1zPx9dFp/CmXM3fwFFKl12aHB3TJloIqAQC0H89eb1P7BogYJvX1mf/iK3qQEO7W2E+TNq48DO3sjIclezkLOXQsKgmDCeMwUOlFnsGsHDEek7gNzrPqhSMYaIdz10bRlAv19SQBHk0AoRgT0vKS0bjDvYok4Asr+MoJv+N7kHRbFtEa+wu0ugYEB8R3JMKkb2+IzFUxpR7x+AgvUU7Dpp5itYeN122re6WDp/AMKDDMXn49CP8yd43xKqSSPTNqRrR/i4udND/665DWrjivyNqw2HY5khksxMO/rEoAgymw/PyvvhHXWIADIPYTaLZIiWhSfughwWStg4i7/1TLgZEChiR+D9uy/4+jkVz548xdXrKdi7n2epx6J5yyZEOMsThzCFkV5ZGXI1N9GHlbkRuU/6MDPUxdlzF3CYSG+VSqSAZYqjcRMGRaGnR6BYtmwJLA0JFMRLGADMLX4HRXlXJxEGBhPvQN/yCCZ3rWJIEKpGRaJp06Zo27atTOIx6V69Zh327N1fENpx5co1HD9+suDYB3degGEJPxhXHoRRJ78h4cJXJF78hlEkXJiGU/FzdaRF91Ox7nEOdpLOVaw6BU668eAwcV5U5GU/hsj2Ajj6zcLSa9+x6SWR7adkHZ5wSeRsLL2fg6WP8zH65Gu4O8TCWrOIiRcJ8Rp3XtJbAAataEChtRic2tPw7xpwqTYCySe58ms6hl8gUFz5IjUE59zOQccp+3Hv7iO5LrWDzMdHslB+zp2wZAGXf7NVQUEg2LHVhjoCBZHhOli3agBS08id5VwBPPDDHJc9FO3EHQOD/nbiBAKFZ7ysp4gI6IWQCl2JUwwViQzsi/pVuuHDGwO8eFIK7pbRqBGecFDpFD1jfdOavsj9liSgyMsrgsmD92F87GOyEl9JUmUUalC7l5g7rg7yMirSSRAYOMZdM1eh5RhckrVtKwWl/1FQtjjHQf2J3VviCb2GyMssKqNSDIqpCfFSLvbVK3WWtqBRJ9y91SzYFB9QAApW8IrWswUUHpX2wbfGMQGFrKfQgEI7o61dZMRActZNFFB8eP+VyNY38cunz5yC+CEDENOvF2LjYjBgQH/07dUT7Vq1QKXQYLg52/0CivMXLmHf/oOoGhkmQ7I8cvRry8eqVSsEFL4erv8JCgn/IEAwaBgUEjRIgKhTo6pYqW1bN+Po0aM4efIkUlJS8PTpU3L5vuI78SBtaYLr128KKLTt6N7LMCkdiBaj92PCBep9CRRcJ2/0JS5DxjXv1OpInM1j22tgxPLbMLbtDk+T4SLuPLttNxqBgYtg5jYec869wxbarzAoltwjYBAoppCr41cuAZZlNJOD/wtQFLhPGmFQGBerhYi28zD5QrYAYuSlDAHFxGupmHkjU0Dx+hWvU+SmguLJLcDRuDG2buSFabYqT+V5ivu10LeHhcQ7GemRrrVTiGsRGBgUrI+8H4NBCw762yWLiyDYY5C6nsKnG6qE9JVJO56jiPDrjcbVeyHtqyWuX1bgYNQYjWokr1f69Zg5q2ZwFXx8uBzZWSG4fs0AI7unIrlPFib240Ro9Dr2Ffp12IsBnTfhyLajKig0o0/MEe7d6Yb4/uXhZKfAxUHByGEKOrRVXafHd3vQvoR4HoESxCvYsqglLMsWwaULd9T7oG30OmHQ3AJQBNjykOwMSVsTaLUY5cL2IaDacVS0mItK5D6xu8TCM9zB5FLJfgSgQMsZ8NQbhYGxI/H+DblPHz/h9ctXePz4KW7evI3dO/dg1ozZ6Na1s/TUHuTzM58wI3Jtye4TWQwelj1P5HzPvr2oXb0aDHTKonHjxr9YCnalVq9eSaAgou3mUgAKAYKGTxQAQyPyPfELnr8ICw5A5bAQVIoIQ5XISmjVqhXi4+PJrRqLHTt2FMye3759V4ZptW3nvotwC22DuBMMhkwknvuOkVLei9zdq98xlVyombdTsZiUe9NjoHndLbAtG6vGPREgGBTeDhMQGrAQxpaJmHT0oWQkX/k0VUI9eJ5iyb1MLHqchVm3UlElaCwsyrRWQaHXvsB9YvdIQmU0oOC4MSu9hvKaFxvxxJ5J8dqIHLkN467kSl5eLoAzinjOhBupmHLqLfpPO0TcKV2ui+8sy8WTP2BWthZOniJ9ySGOIG4561oJvHv1jwQDBvgqcCV9szVXENPTFlcuJSIrz55cpjIEDB7oIcktidsPybIERCOYi7dUJAtRcTgBQ11kFOlXD4N6lpcipSeOKDAv0whtmhBtHzF4RWK4VxAeX56JzIwgnDheBMO78iKjXAEFr7qLa3cDw2JOYUTfvZiVPLsAFAKMnD8Q3UIdHvMr/ycWz++B1y+aY+6s4lKw5eqFVnRyfwkouPIl5/I5vrU3bPWLkf988F+gWDxvHxxKD4aPOQcETkGg7UzJExtkvQQugTsQUus0QsznFIBCcj4RIBgY2rxPnM3DXWckBvQj94lA8e3LV9y4dh1Tp05H9+490aBeQ1SvWgM1qleV2eW6dWrIBBsTahsLU5mjsDA1wNnz53DqzGm0btFcRp9+BwWf8Jo1q34BBRNurbUoDAyteLvaw93JToDBgBgYG4N1a1dLgCCHe3Do+Pv3738JJ7l37wGOHeNsK2o7dPwm+ievlaW0nIkk4ew3jDj3FUmX2Ff/LnXvZt9Nx4rnPzBq923Ymw6Gu+nPmnau9DrAfToCK8xBGYM4jNh5VUDBgOAYKE6Nw2EeCx5mYMGDbNSrMgPmpVv9b0HBgOAMgfyaQz20M96dV17HmEts0X6CYtKtdAzbdReDZh2je6pelxYUOze+hqNZU9y9p0+6Q6LlrASKm1cVWFso2LyhP+5cnYCY7tb0zBS4uyhYvpp0LLM0WYoiBaB48kpBjdD2BOx+AgoGhEhAgoBi59reAoo9O8j6FK+LXh3XJCqzpq3vHOASjiu7TiI/PRBnjvwhM9oTYvMwcdBrDOlyC4Pb35M6FSO6P8L4Pk+Q+onITH4puhgCBcl4JtTl1Bw8Ttac0rAEuQkmssCob+9WxCnCkPXdrsDVunmxJtxtOSnuWpnSV5GhouPCyRtqWIJJcgHR5khZBoCLx1pUq3UGQY4r6D1xCgaEWAs1KRqDRyyF9Sy46owR9+njh2/ijrx8/QKv3zzHh49v8PbNK9y5fRNHDh/E7FkzxIWqXiWSzttF3CcGhYmBPi5cuijhFr7EPXR1yqBJs6by0H6eb75YCjP90gVKz6DQzm5rrYP2Ow4v57kMdf7CVdyoRvVqI7plc7RpHY1efXpj/MQJmDNrtqzW066hePDggbhYWkAeu/MECeuOS4ljLj7PxSqHnf8q7tPEK98x5cZXzLmTjh13gTqtlsOmbG9UsBghgZZcwNLcMgl+AYsQ6DwVlqX7InbhWewmT5YTpmmJ9hIpO5aOxU+4ytIKGJVpQaBoJ0GHWlD8dJ9Uws2jTQwSXjcuySHKNoKbfRf0OfYWQ1PSpVD/yEtpSLpM1uxuNoYsPosZS9TKRnxtcn30b8G0E/B3icYXTm72o7ikzcwntz4zvRHWrgyHheFfGDcyBtMmNkCX9s4yNFuKXPZW0dzxEscgELHLlZkehvFJvgjzHIrqAWNk5KlmSALxicFSKXXoIAXfP/vIKtF1a/6Cfok6GBq7u7OyYc3RWhXsg7F/yWbkpQXgyR0zjOhGvilZiqQ+jxDbJkUAwXmfRvV6iqSud/H2uZpaRGa0yVqkf4/Co5utpRZZwoBw8sFt4OZYllyQIviniEIKoeD5w1ICCLYurx+1Qgi5VjE9RxOa+Zb8BMXnN5mo6DQOnoajZEiW114H25OlsJ0PR9dVqBR1DFUrbCX+oA7BqkLuEwNDYyn8yX3SgoKJ9ucv33D/4T1Z5DMmeSSaN2uC8t7lYGJsiDKlS8pMtqmhASzNDAtAYW5sJO7T/oMH0LpVSxga6KFRE7IUcpa/gsJEt2QBAH4Fgfr655YshKy7cICHswMcba1kwrBhg3roH9sX02ZMx+69e2RO4vnTZ3Ikbky4jx1T3SdWnFMPXmDImqOIP5+BgWfTBBRcalgLiqk3v0nt8FHr78PIsYeajEAKyg+VYEBrW+pwAhfDx24C8YD+iB69TUCxltymwqCYez8NS54CPfrv+78CBQdaMjAMitdBnarjkXglU6rRMihGXOR5CnKd7mSh55R92LSP/LvCjW5wn05zUDeiP5HoEviR949kjvn0UcGA/mqJOBPqbDm3GGeP8Sc9im5aDkmJTZByyYl6/Z8FRh/et0ez+n8issII1AhMlqpG1QIHo0pgPCr5DSAeoU/7VyTwVMbE8Qr0yNWbMf5SLeXYoRvlOHPC/FHH6YTox4i0rFncHEn91iK2/UWpiMojUFIdtecLDO95Ge+l9lixglEnWY7KVYqY8JBwgODzJwoO7lEwcbSCzkSIbl5h61JETjgnrRxaN1ZQrXIPQjTfCW34eD6BjHzgmnPhqjeESDOZeOr52QKwi+RHLhPPZEdUPgxH5xUSNStkm6NnaRtErlaI/WyxMC66o9C/L3GKdzwk+5F623s4fPQQtu3Yii1bNmErEVyeUV6xYhmmThyHHl06SriHg421TNzx0OzFi+dxmKxJdNNG4BnuRo3r0TkKitWejc53w6b1sLO1hreXJ1yIqDs6WMPezpI+syCxFK7CWxYb+szK2gyWVqYwtzCGhbkxrK3M6EF7iStVpUoVtGzZUuKphhAJnz5zBrZu34Z1G9ZLqAfdJQHl6UfPMHjNwQJQsLINu/AZoy6Tr07u0/TbmVh6Ow8NqyyCfdk+5DINUUPGiVMw0ebSZD4Vl8PPPBlOZfqifqeV2PsC2PA0R0I9eEabyw3PvZcq4IqbcQZlGQDGaoSxgx65UqT0nDiBo4wZGBwIqBUHItz2ZZuiOPGCpkM2YfjVfAw6ly4DAiMvfpdqruOuZKPH4AV48FANZRHhDd1XnsPqEx1DbzQTxPklcOUCeSHEV8MqKhg4QMGyxQrOnlPw4T19z9nGWf80MU8qMf8bW9dHo7JfDQICEWviEFHBAyXhcohXbwR59sS+baWR870eMr62RN/u5D790wrjkl6WU25efaPjad3yy8xE8u8ZFCRvnyzAxCHbMLjbdYwfoI5AcXVULvc1efBDZH8nMqMBBbN+PglBJwFCnb/gz0vTZ+6SUj3jmw9SP3tLLArvyxnIhw3QId+6Ll5Lh/iz52ULOmP0NdiV7C+gCLCaJb0/BwT6E2/wd1uDqtVPwtV9TcHokzaEnEHBVYwYFM46SYjrl4R3bz/h06cPePfuDd68e407925LyPa8eXMQS71ztWpR8CZXxs7KXIZnLU1NZEab5fLlS0RwD6FeTSLaZUupQ7Kcwk7TGBRpGal49fI5Xjx/iocPbuPunevkml3DzRuXceP6ZdpewbWrl3D1ykVcuXoRKZfP48LFMzh3/hROnTyKo0cOYP/uHdi5dZOEe2zdqoJ29+6dEhx47gLtT27cpy+fC0Bx9skLxK8+IKBgZeMyZCPIV09K+SRDnfOp8+244BisdbtLihstKCSjB4HC1m2qgMLbaCTc9EhJ6k3B1gcqKNhK8Iz20ofZmEeWYvHjPIxdfQ9Gpm1gxSl0OPeTBhScnVBNs6NaDK0wKGxKUUdi1RJDl15D4uVcOU8eNmZQjLmahSHHP6BT/1nI4gE2fvQaUHz8+JE4WUVMGTpVQCHVjPKK48PrYjh7ujFZ0BjivnXBxVry8s3JipAHwvvwiBO556yHEjbOMU8TQwUUNUPIUgQPl3xPnAitsn8cWYr+6NNFwde3UUQHmqEDuV7GxVp/ad1sv47y7OlrJdBlZMrIbuzbFSelLAZeCH5iWx8kdOJo2Xwkx6RjbOwHJHa/hCnDNorCqylt/pCZRcnUlmuEA7u6oWNrT1SrZI0xw1sj9Zs9AUBTkYZPlETKe+Uag6tdmutG4fxRddaWm9anPLv/oxRI4fxNXIBFXX03XybtgizIOjQ4B4egbQQI+oyEAaOOPs2T0HI/+hstKD68/4IvXz7h+PGjmDBpIvrG9kOTRk1Rq0ZtGfHhBT8R4aHw9HCDs70NrM1NYGqgKzPbF1MuifvEZJzdp8aNG9JZ8hP8rfEDLSy84Wv5n9rv+/9HyhxphfcRIStFcuPZeySsOkyKlir1+Xg4djhxCvbVp5CFWHQggyxXIuzKdkN5ziDOhfBJeF0Fp7hx9FkEZ78lUljeXb8fXAOGYdM1cp9eZmPFkzQRLnq/4GEa5t/PwZQ9b2Dq3A2OZdvDWbcjbPRaC2fQEm0bXR5xaiRWgkPF2Y3iHErmVYZg+IkvZMlSCbh8nl8xgly9abeA7otTMHXyCtIlzbXxPaDX507fRTlHAxzd3Yo+VKsXZWfpSZqkx/eaIe1Lb2SkRyInx4W+M6S/+UdceNEx7pxJx8RSkNWYnFQbEb41ERUyCOF+/WRxEWcI5NltTpDWuL6CWyk98ebxKNQMZ33slxLd/LiiZGbkKfXC521oHr4Q2dlkfggU3z9WwKoZ9TG6V5aAYmxfMnf9P2JA+1OI7zYbqV/JrJGfxxaBs7UxKDhFiBuZN64ZYM4lvoj4zJvDANBXoxVZGBg8fpxjRD2nIYxLV8IiMs2/NLo3n8mPjaowCl7GY4U0a0HBBVqCLRfDq8pBlK96WCyIFhSy6Ign72SeYraAYkDsKHz/loH09FSxFDdv3xKewEOyixcuwbDEocIvQisGiwtkaqgnk3i6pYoLMK7duI5jJ46jfbs2QrRr1KhGD0P8vYKmBXKBYvP2P9ovIOGXheX/BBS8T24WstO/4+ytx4hftp+IdoaAYvDZTxjBnOJqGqbeyUdUx6XQJzeHMyN6mwz8BRScK9YzZBVsveahnOFQuscDYO0Zh1n7P2Hj23ysfJpeAIp5978LKBaeTIOL/yDYlWoDF71Ov4CCAcCA0IKCLYUWFLXiNmD8pWwBBBfA4dGnkQQQBkXkoLU4duQGXVehayRQzJm5Bt7ORnh8U03FL55InhGGDVUHcpqQIiePUbBjhyLFSr9/Jh1kD4cDBVnHtF4LgWLV/I5kEWoh1CeGOGxvcNrMGmHEKwgUnEqzWSOFOPQA3L82EL6uClyth2/o0PacopBJVmLbXR4TZj8L794YSWzJo5tTkRQ7SdZnc9KCCX2/YFyfd+jT4ir6tb6KlXN6IJP8MBmSJWDk5Lhh3GgiQHoKFs8Nx4XzPqRoCkL8ODnVaPLZuuDru0Bi+SUJGEXp5P9E3nci4I6R6N1pZIHCyLOn/7mQR3wM+cOlRiLYar6EdLCVYAm3W0G93DaE1zkHH7IIoQ4LVGDYzYOv0wB42LSBszk9MNOqaN2mo8xIr1i1EsNGDEebdq3FOlQo50nukiXMzchVMjeVuCcXFyd4lfOATwVviYoN8KmAM2fPY83a9RIn5eVJPIgI9+WUi7h7+44QYV4N9+bNGwLcOzH7HE7CcVYsnLuJtxyqod3yZzyixH/DQ68cCcsRsbdu3ZC12mfPnhZ3be/e3diwYR2WLl0sUb0zpk/FnNkziUccxuBdt9FlzQX02f0EQ84SIM58lW3ihTTMvgn0m3KGXJeOUkfD1UitVqS6UOqSVHeLkfAPWQ5bp0my0IjT2diZ9cW4OY+w+T2w6lkGVpALxTW4599Lx/y72VjM5ZKjJ8GyWBO46Ktr3FkKZq81RJuHXzlNJo/325pEo/322xLWIbl5yaolkuvEtb6nHP6ABl3n4z25tvzQ2Q1lYX7ZvdNk1K9JLniqZm127h9487wdakYp8PJQ4EvEmhevGZVVy3qFhZihfRtnrFoerHbSBAhtfrGUM9GIDPIilylW1lHwpJ3MZAclEUjIisWT7qZWxp4NfWBp4IygoIVjWrc+qoJi/tj0No4lhuLlc10BxYPrk5HYe2wBKCaRxLe5h0Ed7hHxfo7hsVXx+kkNuhqVCDEoJiQrsDJRcO/GUKSltsbwYer7pAQrDIlTUKeqOvuI7GIEDEJ1TlG0bxyLQK/a/0p1w6DYuuYG3PTHCSg4AFAb7xRqswxWHmsRWusMItyXCRFnQPC2evB4jIjbgdnjz2L9shTs3XcYN2/dwfWbN8RCnL94DimXLuD65RTcunaVfP6ruHXzOm6S3LlzC/fu3saD+3fx8ukT3Lhymf6euMf8hViyaDE+ffiIb18/kynPQGZ6BtK+p0o9aFZ4DtzjrfY9g0Or/Fq5c+cOpk+fjtGjR8ta7H79+qFjx45o1qwZ6tSpJdwmIMBPwGltbQljY0MYkMvGWzNTYxmdilm0E0mHn2D40RdIOPlJ6mhogTHmeh4G7HoKwwo9BBTuRupyVC2nYJLNGQB9HMbDL3gZzG2SBRSc+MzKqBf6DT8ji41WP+cU/iooFpLMvpmO5XeBegPWwOKfxnDWUxNUi6Xg+CeevdaAggFhb9AM+n/XQs1Ko5FwSa0GFX/2u4CCLcW465noPu8MeozYUfDAtaD4+gEIqBCN8aMckZ8WXuAG3bhcG3aWZCFGmeHxgykYHNsWLrZlqKcPho93WUnFH9evBP2Quo5CwPSjCJYv8EKVYG8i2AmyjoJBwVIleBQCyw3CwV20f1ok5k6sB4OSVqhZc1Ob5OS3anmvvevgx6MUZ497IfNbWzy4ORjD+sZgQmyOlPcaFXOdLMQxyTw+qucbDOywHqd2z6EDa8PHy0pWD32dPxDTqzX696kP//L6MCijoNTfCkrSSXOdii1cPyCH61qUElkzrx71KkVx6fx9MZ1sJ1j4Fn37noGq5aeJCyVpMW21S0+XINBhOZGlXfCuegyG7qth47IaDtaL0bBZbzx6+gZPXj6VTBkcGj5y5HAMjh8oStW3bx+R/v1iEdu3HwbExYrED+iLwQP7iQwZFIshA/sjcfBADBo0QHrsE6dOyvPTnp+2/c4btA/3536/7U+Sk5crOZ540RDzlQWLFgpQOHEBc5bAQH/Y29nIcDEPDZsZ60k4+4iERHTYSD3v+VRxRQac+oT+Zz5jwDny069kIfHYJ5SnHrBU2TYwM+8Dc/P+MLUcCDPLIbC0HkWSDB27ZDgHLZYEae7mmjSZZD0s6dl3aLEHG98QKJ4Rr3icJYuMmGjPvk1k+xHQcvZxlCGCbWjQDkZGbWBo2BoGhs1VIZAYGkZL0Rh+/6dRE7Qaf0wqRHE9wSGnCBBn0jGMyHbytWy06zaH3J/LdDd+vUfnj+fBqEwNnD3COqUrQ/6c1X7/vjZ0PxTqnGzx7UscWZOqCA00Q2Yqh4KUgp6OghXLqJPmESiyEpyi9d5NG1QJIMsQOEwWFUUFD5N12jWDRoj1GJ2ohxy2LPT7A9sPg16JEHTussTv4iVNzbtbZ1CqnNngJ1PH8wLutmQFRmP6qCQCQCom9s9F/7YnMLL3Vck8zqAY3HkTVs0eSCesSV5AoLh7429YW5RGsaLqRAoju0qYA3p2roUF89ri+tW25G7Y4+RRTUFIIuvXTw2FvVFpzJy2/BdQsPKwjOqTAje9JOIUc2QeQp3BXoYA+2Xwc12L8CZXEFDnLCrVOIMq4YfRvHV/PH72Fhm5mXj79jWuXEmRkaY1q1di5Ihhsiaao2HdXd1gbWklPKFkiWIo8c+fMp9SsthfKF2iqETEli1ZDEWK/IkePbrhzLmzmrP6+QDZ9eGlqhyKzguEeB310eNHCEDHcerUCUmnee7cGRnWvXDhAr0/g/TMDOSRGeR0NZycgDnLgUMHCbwLJRCQz48zDjLpZ2DwvAmHnHDoyfChCQKKoVKbT62fwaCIv5iKYSkZ8CB309y+F9zLEXcoPxoVKkyAt+9k+PjPhK//ApLF8AxfiQpV1sHNmjONa9LeWI6AvWEcKgfNwaK7X7H2RW7BjPZ84hU8CTj/HlmhbQ/hVi4eTo79yJr1hbNzDBydusPJuQecnHqpQq9tbDvBKzIJ43Z/lOKaWlAMPZ1GvCcTsYdfoUGLsWRJ+S5q76d6T2dMOA13+zb49JJrn5DXwkpLfOHihb50P8gdD1LQpZMCazMFHs7FsW5VUbRrpcDeVsGlC/0FFDIKlWuEBbPVhAVcR5uXn2pBUcl7EDo0r4tn92OIppGXQ8doHN4KJjqVnixfcb/UzVtcHZXcpzdPodQIG7i9TeMgZH6aCKkDdpVcn57LMazbBULSbYyP+0QW4y2G93yJ+K5biIgPox/VguJPApNCPa1Cva6CnZsVPLxFB+QTlEItnli/ygkRwW4oQcrHi81zM4KR/jkKLesoqF0jjjmkqJ2qe/Qf/budkgNn004Fk3eSvMBBTVggM9kuSxBRbhUqeqxHIFmLJg17E/A+4e27D7h67YYoHffIWrfo7p0buHTxLE4dO47tm7dgzozpGEvg79KhvazNDg+rCGcnB1hZmlLPpI+yZUqJhTl16pRqFfjcWKhxAF9061bo2LmTZPTo2LE9PbDO6NalKwGpB3r27ImYmBj0798fsbGx8p4zAHLjhUr8+satm2KF1q7bgOkzZiGOLFS9urXh5+tNlk9d2yHDw+bGGJqYgI4bryHhrFpUhi3FsPPkjpxNRXTjeZDyY6bd4GrRB+5WfeBpHYdytkSkbUegvO0o+NiPgZ/DaHhZqVWLWHgkikWbyGDiqWfY+BJY8ShXQMHu06w73zHzbjrGnP8MX+pxzfVbgUsvc4ZzO9NWsDcj0m3cUl4zjzAlFypyzG6MvJqLWLJo/Ylkc8F+BsXkK0DT4TvJ1Z5VcB+58UtOuF67an10atiOPlDns3hNP/LKkJIbYOMaNQ2rk72CUcMVAQO7TSwjEomMZxuoERP5fxKPrY/2za0R4TsMVYNHa9ymwagU0B/lXdpiUC83ZHxsgbxsOzx5WJTuTwdUcO22/cKFz8rdu3mqpcj8CqVflyVJ1ULtkPZ+nICCk87uXXYbfVsewpi+r5Dc772AYkSvVxjUZTMObZhDF0PmKo9cKGb72X/JzHZmWjW6GDd6ry9xUQyKB7dLkrlTBBCN6oTi5JE/kZUaIGlJ5owvDivzqrh/R3Of+D8WAkbON6BzsxXELcZqQjp4km4xQh0XCzD8iWT7Ep/wIcvhbj4PDep2x7NnH/Du/UekXL4qE15jx49DJ1LYmjWqoUJ5T7i7OcHV0QmeZC2YcHMu1yA/X1QMDBCSzYuOeKLN3MxIQMHu1enTp0WRtWDVNrYe6ltNb6c578LtdxdL29LT0/HoyWMZ9t28ZRsmT5mGdh3aIiQ4EN5e7nC0sZQJRBYGxZCEoeiw4SoSyV1iUPAsNs8Oe8cshG6JurDQYT+f1zt0JevbBU4mvQkk/eFiNhiuplwhNgFuHANlxvUnflYu4tT8DAqHMv3Rb8NZbHsHLH+YI7LgfoaAYvrtVMy4nYvaDWZDvySRaV0CgH4bIqfNYE5cgsVCvyn55XXhYd8F8Qfe0/mlFYBiwLk0DD9PbvjpdHg2nUB87skv95Ff3n/wFC52Hlg8cT6945Bx7vGLUo+u0P5MoN2JT/TAlUvR5DY1xOP7QZg4rglmTW+D92/cSNcMC5Ym3EgJQeNaeuRic8aOZEmCJhN2Xj1RKTAGdSP/wIVjngQie5wgz8WydF20aTIriQFx506uouRRV08WXVk4a2fDcnY1cXgZ+3qEUPK1Pr/rijlj+2J072+ypmJMzCck936BmFYbcWDzauTmc8DW3+oFEErZajBaxYQRSLJSG2DrpkrwdColq6N4YXniUK6M/7ckMOCALbYo5qXDsHDGcbo5uSLS+E6RbNl4BO5649TEBUS2wxyWalwpNd6JLUcogcLfYj4a1u2KF8/fiwJnZWUhOzcHqelpsm7jyZNnuHDpLLbv3CIr3bj35kVDYcFBKOfiIkmSZSkqiTn1zuyysBsVH9dPrEJh5f6XomvOtUD+DxqfH4eJMwG/fPWKWAwOQ+c131UqRxEHs4ZuaS7MXwzG+jpIGkag2HIVQ4lUjzqbgbFHv6NxvelSfce2bAs46LaTVPdOhp0llQ8nf+OyZu5m8QUgYOWXnE+aZGg8IiVimgj70v3QauBO7HoGrHtA7hPPU9xPldLDHNE68yHQccQ+cjkbSj1sLcHmESfJtEjn8LdOXTRJ2I3Eq3mIPf2zSD8Xwxl5Ixe9R+9Bp+7TyVNWO5GCBVvZwPSJm+HtouDVo8b0lWZmOtcSw8kqmJsQn1iYgBxOrJevpxJpWautzmLzkuef8xNFcPlMNTSsaY4qgQPJWvBgTjeE+fWRxMrVg5h0O2PjimbI/N4Ss6eRXharh9FDjje8eztfYVFySYsZFMcP3LN1s6r6aWnSNjpLOiAB48XjVhg3uIOkuhnT5ztG9/mIMb2eo1uTVRjQrR0ePuaTKCYXwCJJbRkgQnj+wNQJarVUXiqYOLAV9ch6KO+lIP2LChopxZShh6qB3dGsbiLdphzSqV9BkZUONAreBm+j6QIKzvfEgGAwqOSbw8YXCyga1+8uoOARIA6gmz13DpLHjZU0NrGxceSeEJkeOlD893HjxokCjhs9CvEEkK7t2xOoaqG8p5vEJDE49MuWEtLNoFDXZv+7CT608psl+a/2O6AyMzNx+uwZLFm2VNaDc3jHgP4D0b9fnCRoHtQ/FtHNGqN/TC+0Xn8R427ko//e17BoPBZlS9SWeQEum1UYFFwQxc2kTwEotPmeZLSJwcFbDSgk/MNsGFz1B6FC7fHYwjPbj3IEFAsfpImlmHgzDVPu5CB55QNyK1vASr85uEJqwahTmcYwK9YQHv5xmLzrEwZdyBCXaeDJLwKMgWTdOCAwoO4I7Dn4ogAUqlDfSM+4Xo2eaN/CBBmfO6sdrAYUmzeXJZepCHSpQx0/luPs/iH9Iv2hfXikSTpkzTyYgIJ07/71RmhSx0pCOSp690FkcH9UC+PSXkNRNWAI8QsX7N3SUUDRr5cCw5INP61Z9ML23p0fCguBIk8hf055+eytEug8Zi/XoeCC8CxPbs/E8JglMiw7JuYzkmOfIb7TDfRoehp9Wp7H5KQO+Pq2Z8FFSJH5XH1cuZyAFs1KE2lVUDlEwYWzbEGsMWpYFeiVVrBnpwlyc5xkip5l5YzasNH7BzevP5X7pNUxbjw8u3nFfTgY9BYAsHBoB89cM69gV4oB4msxh5S6O54//SD+6ddvqXj59g3uPXqII8cOY+nyJQSIeDRt3oR64ki4OrvA1sYKRob6Qrh5xpqDAC1MjMVKaC3F0EFxP90nOqmP78k9IxL/5fNHmXtIS0sjxU5HRkYasnKykZmdJVagsDDBTstIl+3X79/w8fMnfPj0UQL9OAKWQ8YvXrxIfOc8rl5JwW1ie5xx/D7xoB07tqH+tE3ose4aZp1Kx8BJZ+Bj100mx7ggCgfmOeg0h5NuG7IQnJy6E9wMusPTqK9aosuE3SUCBlkDLRh4eFa7toKlginxC4MhcHEYjKV7U7HqZT6WPFbnKebezpRFS9OvZ2Ey9fiWlQZIZVn7smo4h4R06JLrVLo+as06jlFkJbRFcLhMGtcOHHchR0aj2rYYQN6E5sFKY1DkI+XEDxiXqo59B0mpyRKIorNOMV/98Qfu3VHQsqlaAbVmNRdcuVhXOKl0wCw8xJ9J1oJfk/t050ov1KkUibByA1AzWE2XKavtgpMR5jMc7dqSRXpZF0/vxyPCRwfuds32njuVqdy9A+X2LbIUTLQZFPk5ULo02Tky3G08PXg6IQLFs7uzMazPYskWyKDgAvO9W5xDXLsrElLes10EmSqueqqaO3al7t1QEBigwECPS7r+g8N7YskXVGcfZ05pLNmhB/ZXcJPe3ybXiUHxOGUsvO2MMTpp2r9AwS+yPgG1QmbBy3g6gYDcJw75IGBoAwHZcvhZzi0ARWpaBp49f4m7Dx/gCpHtlCuXcOnyRZy7cBZnzp3G0cNHpIjK8mVLkDxmFPrG9JaMfTxp5+nqIlk9GBRsKRLiB8j6bgbF96/fcOHceVy8cA7Xrl6WVJd3794V5X348D7u0/EeEAgfPXokys7y8CG9J+7AaTBZuDDLl29fJZaJJ/y4jBfPabB8/PBOwPbh3Xu8ff1G1rBzWs2YrRcx4sgbBHVfgCJmjWFarC5synJUajPqpZuoClqWSK9uawGFqz4Rbr1ecDOMhYdRPDyMuRg+F2P5aSG0wuBgUHgZJcCEwNRv/GmsJ17BoGBOwaCYdp1I8uU0zCcXqHqvZTAtWkeAaFu6sQjX46sWMQqJZ1KlAA7PsnO5NJ60SzybJlzCosYIHNpzXX2+BdZSBcXgPhtQwbkj3n6wop5et6CTFTeeh/3zLPHtU12MHNZWPA+OlN27QwVAAShk7os6X+K4IwcboUZoOOlMEqoFMNlOEGBUCRoDX9cBWLa0uMylHd7bhHiXgia1R468dwvKndtkKe7y6NMPKHl59GvIV5ZM+VrTtnRf3L7qi8xvTfD07kCMjO0pC404UnZ4z0tkIQ5iZI/HGNLxDro3W4nFM2fxn2qYfzHcvUk+oJG66MjRVk2VzvMVnJOHOYWZIQ/XlkCZ4gpat1aQ8S0UuWmVMGyQggDnLkj7mXFeRYZGdm47CWe9sRLOISkzObRDMwrFy1ErWM4ijtAHT1+8l7COZ8+eSA8/d+5cjBqZhI7tO0iYRrg2zsnJgXpGexFOl89p8z3dHEVsLc0k/1PZMiWQMHSQgIIbx09ZWppLyhrORM5rvHlegcNEqleLQstWLRA/ZBAWLJqP9RvXYdO2rdi1by/OXDgvAGVQMCAKt1/cKXrJwJtxYAVqxrbErNlTCXT30aTzcjj7D4WucXuY2fSQaqNScdS+OywdesDCqQ+snONg4zoQDh7EDzyT4Og1Do4Bk+HoPw2u/nNgZTdGVtwVWAvmFhpr4WA5Gi5uU2BfbgIa9jkuI1BLH2ZhMRPtW6lEtNMlIfKk2/lov+EWTNzoHOx7wpqOa0Hb4r490XXjfSSk5BAYiFhrQMHWYuT1fHTsvxat2oymC1RBoApdLlGKD+/S4OFsjzFxzekDUnKOp8suhsx0Y1y+0AbXUtrj3s1WeP6oM16/7oW1G33gaucGo7LUiY4m/cmwU8Eg4R0eWL+cnoc3p8WcUACGqGDOCsh17sojPuZvcskZcEWQ3D8ZBiU8MWHU1pr3bkO5e/cHEW2yFPQclPx8tlP5ypWj0HU3HnJ74WxON9gUb54kYlLiQCLXXwQYsW2OIqHbeVlsNKjdTfRquQbD4gbwn4qfxzFQ2ek6GD6kIZo1dEOblp5oG10O7aMD0IWsSq9uUVK8z8G6FJo3iiB/kXzErxUFFJdOG8KydG1sXKpdxE5NAwiW7AygVbVD8NSfItyiMCh4fTaDonHjvnjz/hv9QT5SU7+pvS/1xu/fvpPEBTxrfenSBewkl4StxDQOEOzVk3z2prLIyMPVATaWJhIUyEtTdXVKITEhnsBwnM9GQjB4lpktCQcPenl5Ijg4UAIKOWiwbfs2SByeIK7ann27cYkI9CMCwjOyDixsJdhC/I+NrpPDR/ovHIXQznUwNGGgrM/WsWmF4iatBRCm1t2l2igLg8LMtqtUCjJ36AdLp/6wdo6HlUsi7DzGwNJrDBz8piKgyipY2yf/AorCFoPLoAWFLIWd53i4VJmLOVc+YtWzfAEFz1NMufFdQJF8NROjLmUiqNZE6Jl1gKlNN+gYt0WDhJ1IvpAtC54GkLXQuk+DL6Sj+4FXcA7oieMnyfxoAFFAsOnt3NnLYG9lhitHVggo1M61FI4dUchqK/D2IM/DR5HRy8qVyX2qq8DdwQMli5RSO1UCheqlKPj20Ro9OiiI9OdC8uMFEDKDHTSM3KZ49GnfAi/ucxK+vyRZWstqLWGp73973/ZHuvfJdSoABZ0aWQqZOlQ+voTSqNrgBfUjayPj/RIxW7ep5x/ZbyJG9DiM2FbniGw/QmL3+xjU8SZ6R2/F0D6TkKshPrJkkM1YblF6X4Qujs0foZ9FXhfBqzcK7t6qgLevKhOIdMAZA+Wi8v9Ay+rN0bB2c/LD6S2DQXMTpdH7a0TgPEgxtKHkkoXcdgkC7ZbB12oR6kT1wcljF3Hz1lVs3LQWixYtkGx8PIPdtnUbNGrcFJFVqqJiaKCsj67oH4gQvwAE+/tJrBP3/qzsPEfA8wPMKUYkDJYMfXz8owQKUxMjONtZyyIhTlnjW94DgUG+qFY9UlLX8FqISVMmYvnKZbJ2g/kMh5hwqMn9+/dlfuLXfLSFm3q9XMnowQPuHHIl3NzOvCKMy4TA0iASVgbVwbUzbPRrEQ8jXqHfgHz6hnAwbAln/WiJYnXV6wF3gxhYmsfAnct8uY+Ds+nQglEnthBMsMub05bcKkff+WSJFsJDNwFOpXti6LIUbH4BzBdQkKUgPjHlSrpk9ht/KxOdkw+hiEF9FC1dC36hQ2V0iUPDGRQsPKkYR59NPpuNkOazMDR2FHWacoE/G93P74ST4PLdZC0Dp6MRHWLJLYXdWxV0aqOgW2cF7dqpCZVbtVClHYGhBXGMo3t435IF3OPAgZaoEVaXeMQY1AgaLcF/HBUb7tMf3g6dsGC6DnLSqhIgvHHvdlm4GEejUuDgBVeupAsY7twjTkHAoF9jS5GvkBlXclOhjBm8sXWAmw/upYwkpbUQYJzadRmDO+5BQpfrBaAY2OEGerbYjCG9JxKx5ZMj4VEAMk15PDyWqYmL4ml3UXoVFPkohh1bSyEyQsF5qX7Jafr5+z+wZ9UuGOtakh99ke8ZtZ+gYMLNmeOSh5yCS9kxCHdcphJuAkWI40oBho97Y/hVCJWcrfUb1EbPnt0lK/iA/nEYMWw4+scNRCLirkMAAHFGSURBVEzfWEl03LFtKwJgXdSIjEJIgL+4Uew28XAsl/Ji+ftPBcPIHdKCgtPnGxsZwIWAw8KWJbxiANq0bYlRo4djxoxpmD59KuYtmCs1Jri+Bcdb3SFH9fHTJ2T+X4v1+p9GsrTX+9OjUkFhYxoMg5KBMNONkHB7K92qUjLYokwNmJNiWpSuC9MS9WD+Tz2Y/tUEZn9Fw7pYRxjqd4WP93h4OY2CZdl+kvfJRZ84hslQlLfk5anqyFP5iNUwdpoIH5NRcCzVA9V6zceGp8CCB5kCihk3soVTcGa/pMtfseDgN7gExpG1aI4ZC+5iyKW0AkBoQZF4NQvRs8/CumI8Pr8iM68BRYG7SJtNK+9D558wnD0WIqCQzpFAwcUdM79Zk7fSEOnfm5A73AxpaU2RkapK2rfmSP3ajDpgcxnBFP0iUCxeHIpqFWujTug4AUa4b1+pmx1avh8ifOPQncD19rkv7V8Ba1cpMP67JmK6rG2ttRAMiAJQMCC01uL4wbPWribdnkwdeJ4uQM0DlZvthmP7QjCg7VuM7JmGoV1fYlDna+jR/CCaVx+PEwe6IydDU7+YgaHd8lxEFiE5wxi3rxliycJS+PK+F3ZuCYShjoIeXXh4Vh2C41lxri3QjnqARrWSkc8JHvj+FSiI2t6//4jqvjOphxsrJYO1Q7MidnPhaTwarpbl4WJtJ9nAbc0MqOc3JyW2hqutFQK8PKR2ROXQILRs2ZB6oKbo3b0Hhg6Kx6ABAzGYtn169ZbZaZ7HWLJkEY4ePUxHzsfhI/slvFx+y4FAQb6wr5e7WJ16taqjUaMGYi26dOmCuLg4WW+9cPEirF2/ThInc0FH5hUc//TbZWnaz05AWn6eBC7a2xhDr+zfMNYpBv2SxYiP/S2iX6akrAi0tzFHgK8XKoVXRpeOPTBu7GSsXLEO586n4P6DJ3jy+AX27zuM3r0SEB7SDs5mDWFZqiX0TeLg7Tsbgd6zqdckd8p0GNwNB8HFPR7rTuTKktQ5d79jxvV0TLzCScxSJfSb45caLz2L6jMP0me5kjxhwEnmEqnCKYady0Ting8ExkbYsOqQ5mJ+NsZFZiYQFhSOtjUbiOvNLjgXjEeeITq0j0JUFResWdcE7960oQ7WlT4vLfuJVcim/cgTYRBpgcSd6tyJdYk31EJUYF+EevVChF8/4hVDSJJRyW8kWjRWcOtqNL69H46ubf6CSamaT9YsuW/NoLhHVoIM+U/3iUULiq/vM5Rq/slLOtRYRG4MHZSAwaC4cCIKg9q/LwBFPFmNTg13o2XNiejd2QC3rxtTx0bWgMHAJ8sTeASK909pm2WKpEQFhnoK9mznVXjxaNVMId+cc38G0QXxnAWbUALfniiYkVtw4gCh4j9Awe3UNsDDaAw4+TKDomAyj0ARaDcVPs4h8HZ2g5eLHTwcreFkawlHGws4WJjCRnLF6ksWQH39kiKmhkZErM1ha22D8l7eiAgLR+2atdCtWxexNHPmzKL7kIf9B3YLKJztrAQUnMepaqVQxPTshlnTJhNH2ijLV7muBI86cXzTm3dvZQiWCTYPx/LQ7M+Z8N+b1lL8EBcrLysTh4ioW5rpCjA4eXPDmtXQq2snjBgaj7UrluIwcZfrVy7g2+d3ZNnpV/knNPdNs/n5nr7jIov7Nr7AiJjDCKg4D46uE2CiMwB2ulzHgme3h8LYrCv6TjiJtUS4GRQzb2RgAgFCCwoOL+HZ9OEXvmMIgWDgqe8iDAheHjsqJQ/mjceT4k0kheUT+LUxKFau3EgdoxEOrN5EH2jzh/2Ne7cUODuVQJnSCvQNFTRppGDjakUy+PGqUBECBYeAaEEhwCD1XTGnBYI9w1HZrzdqVhwsCZV5PXa1EOpAvRPQvZOCT2/742ZKB0m0EVyu15Jr51UuwaBg4df0ayoo2IXiOQs6X2VM3MNW7uRf3rtZDlmpdciMNcaxveUwuP07jOz+DYndHmFgx0toU2stekVvRPNqsxHbcRUy0/TpBItrJlH+RMKgAJQnovT8sRnu3tSBlXFR1I7ywbikHvD1LonSxRTExRSnB6nGUGmjIttUb4uWDToRGPkOyj/14WqUhv8lD10N19LJiHDgeQqe3ebYqPlqMjTbyShnEQsvR094OKjAcLE1lx6VExPYEjg4fMKeCLUtbW3IJWLh4Dsj/TKSdp+Tn/HrIn8ospaBD8p1ss1MDeFgYykJBzhfFKfZF7IdEYaG5LJ179YRw0cMxZSpEzBrzkwh3fsP7pPECVyi69Wb18jRpK/hOQwOO+eQ81evXuHh4we4ev2K5LDlCcPz58/LJOThg4fw5NFjfP74BZnpPxc5ae8LC8/NMPh4WPjatWuS6CDlymWZN9HuxMGI/JKvhUH++esXnDp9HolDJiMytD1crBrBomwTGBVrjfqV55KlyMG8e5mYcTMTE4lkj7z6TYquDDufKml1OCycpf+Zr4g9rY428TxFjwGb4VmuJZ6/fiUA1z43NYqYk1MAgZ6d0Y54gnAJKTtNRPl7U8THKXB1VLBmSRD69TKBjbkC3dJ/wL+CEyZOaIy7d5uSRSkNrrbLf8OA4HCNu7dqomPD8TI5VzMsmYAwSkh21WCunT0AFcu1x6Y1fDwrzB8/CQYlPBDTa36ru7cYCHkiDAqxFOw60XmqnEIDilM7YepUatCNtSvIt/teW0Bx7qg/4tuR+0SgGNb9MWJanUaHehsFFB0aLEXDyNHUYzEYShUs8pgxuY4MvU6bpODxfSOE+jtAv5SCkkXVYhttW9pj747a9Dcq/2BQ8Omc2XYWFvpOOLDvtDxMvpEs2pvL/1LfAs1CdsFLf5KMQmlBIWkzbSbBz34wPO3dUc7JAe4O1LPbWcDRzhLWFsYSaMcigCDLYWtsCHtTYwEMR6ZqhUeiOIKWR6r4oAf27yZOQe4TAYKrG3EsFQfv8TqIihWDUbNGFbRu1QxxA/piyNCBMjw7OnmUDNHOmTebuMZ8iYrlCFteoMRJn9misHClokdPHuLt+zcyIfgLGdfegJ83QtZocF6qjZs3Yf6CRZg9Z57Ut9i5e5dE5XIICYe5yO6amXaeMHxJiqq9j/ydfEWHSv8CHN/7EaMHHUat0BmwM+iO2K2XsfTpj3+BgpOvsXAIe2FQDLuSg+h1N2Fo0xx79vLMtbb9Copp44+ibJGKOHs6jHp9Zw2n/As3bwXRvVWD/VI/JOPM8d6SvqZqZX+U97SFgb6CKlUUPHzAesbJl3n7Jz681UVcPwW1gvuhbniSgIILP6qjT4MR4t0D7Rsl4+t7HeK7FmhbryGMS3vd2Ljulul/goLOsUByiLHkkx369AZKwxoDJ1cNqImvzw9LzMmFc38grvUTjO79hVyoFHRruAtdmx5CjxZH0a7+TjQIXYIlC6zFBZLsHiSfPppIDTxzUwvY2XAxRQVuzgr60wVcOKeoo1ZM0jX5P/kiefUUz36PHKqgks8IZGkzKv7WuAd6/eQHQsr1h48ZT+atIPdpjqTM5MQFnB6ngn0X6v0i4WTPgDCHIxFpdqHsNIBga8HgsKLe39LEoGCrfqZ+x5k9KoeFYs+O7VhD7gq7Tzwyxd/ZcDYOMyOxHD7EVYICfVGndnX0IJeL13DMmjkdu3ZuFyXl3psn+3gWm2e2uQfXWoyfTQN61hwWItrpGd9kOPn40WPCb7jQS+/evWWR0shRScJXLl5MIRL/VhZrqT2z2lgF2TJduXodR4+dwMWrF/CWHq6opvYYJAwe1YqoAnq/buVaBNRpjil7L2LenRxMvJaO5CtfMTJFzV3Li5u0K+p4ToKXxk7c9AzWBIip48my8qVofv9HPqGOh2Hps8cP38PZ0hyDOkbQe9VC8Dp/ztiRmWqI3dsV3LlJn2UVR5MGBuJiP7pfFldT/oSzPafcNyLyzfurGe9/5JXE5KSZqBLQG/Uqj0OdiGTUrjhKSgPXCh2CSv5t0LM7/cZdB+G9Vy6Sx6LbDJUDEydfvZoh7hIDgUUFxm+g4OBAiYXKgrJg+pGq7hZeP/asGyWgePPKCiO6f0BC5zcSTt6p7jb0bXsa3ZodRvsGu9AwbCnGjPybkOgiJo2tRV6uM+bP0UeRP4tKgFu/3hE4faIFsjJqkP9rRr0UXxwJ8w8S/jtJhECgePGoGtwte2DehDt0av9DI/dq38avKGdIQLAkXmGv5pFlUHDmcU8rdgki4eJoJcBwtrYQl0kLCq3ya8Gg5RpmpPhMYLl2Nmfx+OevP0V4lpsBEOxXAc0a1sPguL4YN2o4Vi5dhEvnTuPZ04fIzPhOJ6ZR7gL5tWn1Udu0ipyTnUmk+CH27NqLmdNnoUvXDjKKVqsGuQbtO0g9i3Xr1uDWrVsSM/X772gbWwle68HLcLlk2KWUK5KbNo9AxiJ/Q//x6kHOnHj1+jUBKgMiNf07li9eRFwpCn+ZOmDwij1Y9OCHpM4fc5k6RAIFJ0pgUPCKOg7lSEjJkgk748DeaN5iOl0I/T5fdsEJqveBcdGtSxwczExw5+Qy6uXVjpDX+X/+qODrxzKyCI1JdWZaUfTo4orBAwKRk+mB9eT66JdVsHblQPopNaEBj2a+fqmgRd22BIh41K00FrXCRqNu2BgBRnj5PmjXJBFPH/siJ72SgIK9Ft0iNX+MGXqsqpZDaLf/DQqSbI6Fou3tW/eVCnZjdsWSJUCuOV2oGVJO+5MvH4VerZehV4vdiOtwDt3IWnQgS1EvfB4S+/tLZCyjn0HBBVrevVCwcI6C+0Sg8n+UEHn+sBeWzKuCcaNDcWBPDDI5B2iuDt2MYvS31HuIBfkDmxc3hBeR33s3iHSruYal8X2W3k5zs+dMOiaxUf52M8mFmgl/+87wtouEp5OFiJujncwtONuYwd6CEygbiOLrEm8oU7pYQTRq2ZIlyBIQv7Awh7szkeioSmjerJGswFu8eCE2bdpAPf4VcV20S2j/q2l1QSva8ywQ0o7cnCxyA+5JlkIexu3atTPxkgjiJ8HkIlRFp05dpOQXz6Y/ffYCObn8t2r7aQ3U32NX6+bNm1i+fCUGDBiEkSNHYvfu3TKrX/i4Wvfl+Ys3OHHyrCyKev7ymXyWk5WLzevXIKJiEIx0zGCu64vSZeqhad/1BIo8TLz+VQqtjLj4HZxnii0EjzZxmp05R9MRXDUJVcOaEiFOK3RMtWnPdzdZkjJFg7F4Pj3fHAPRE+YTmWme6NNVQUW/kti3fSzyM/zpc336CbYYCr58CkTD+grq1FHw+TN/p1qYH9R57tlqiqqBk4UD1Y0ci+phQ1A5KJZ+qz383OtiYPdY0ice1foLT+/0RSXfcnCybLzr4J6PvwHiJ9kuAAQLgyHnR74IWVClT5vj3f0skvCUfTgCRfa3DrhzaQ7iOq9DbNuD6MeWQgOKJlFL0KKeHk4dtaSLUUeT8rK4xh3nf3IQySWlf/pMQe2qhNaSCimhQkqoYDFxl4zUYvj4mo7DFyA3S0Hay/loVbsO2rYY+r8EBUg/R/W/BPuyI9S8TxpQeLtaE58wE4vAPb5B6X8kmx+DgifoggJ9UKN6JDq2bUNWbgTmz56FvTt34FrKJbx48ph6bh4XZt9e+5C18t+Nn70Ivy4sBILXr19i964dmDljGnr26IbatWpIuAnPhvMwLtfA4wIx7GJlZf3qVml/5/fGeal4biQ6OhrNmzfH2LHjcZVcpZ/t1/O+fDVF1m7s2LkXT56+pN9UgcKf1a5ZR0oScHSws6078axgeJePxZxt78h9yhJQjLnMo06cpvOrgGLwhUwMvZSNcs0mw8G7F57e/aq5PfS7bBYKNV63Xs6xJcL9eyLtqye4uIqMGtGz/vrJScJ8OPOfBenDhFEKPr0jxWe1JGCkp4bh4nkDckP1yEKGy9+JEChWLymGqIBJqBsxG5GBCQjz7UvHiEFUWA9UrdgWLes0JQvEv1MEm1ZWhEXZ4mjdeGL329d+BcP/CAqt8EgU3S3l4NZsKyu9VlfnTeiMzA/96ELVXTatIGC0X4l+RLZ7NDmCjo02onHV2cIBaoWNwsGddYHMCqRUtD/zBc71lEY+YGYQ4voT0SYwdOxoSSTbRsaO7UyMUIOUo14tBW/f+MmNYOF0OwwiL+OOWMkB/VrN+F1L+DUxxr5d58BKpzX8HJIkZNrJngi2k62srJs1bSqmTZ2MDevXytLQ69evSyJjHv3J52rmovz0UwW98K+N0+I/evSAXJPHkpVDbT8VTpSAGOv3zx/w6N5tnDt1HCMTh0jYN89jcE2Kcp7uAoKEhASsWrVKUu9zmPvPpv097Xn8fM8tJydPlH7MmDGoVasWAgMDZU6EM5RzYKH2PLTKzo3DXPbu3ydzJlu3bpfM6+xAscpyrY56dWvCxtgCVvoOcDdvAXeL3jDX7w6H8iOQsPcOlr0gYnwrDRNvMqdQLUX8BbIWKemYezoTlZtNgYd9Zdy+ytVbtcfXPh7O+JhLHSQQ02MmrE2ISx71oo7vTzXsm72CXOYG9Lx//EXknDrM6gp1XgYI9Q/Fto31ZLKOC/4g/2/ZhwdktGDKzqyC2VMiEODRD5W5LjYR6zphI1GPXKg6FZMQFdgFzRo0IetVlo5ngubVhsGgZMTVFYsuWHE07PWbOcrN23kSGcvBgFpg0K//GxRkjmWNxdeXUJrWnJVUxV8X31/3Kthl9cKpAoq4tufQs+lRAUW9StNQJ3wSalQciTZNFTy/byhESPgCgyKzKLlWfmjYgHoDC4V6uXFI+9IaifEKjEqVgGHJ4ujQRsGL5950A2h/kry8v8m6mGFB0mU4G7cjf/slHZ+a5q4XTAzT67ycXOSSOz+g6y5JKOxllSClf3nEqW10S1y+cJ52/FXJtE3N+vdztOe/gMGz0MeOHZEKRFxkvkGDBhg6dDCmEtC4GhHXvmvZtBG83F0kPIRnxqMqhaFNy2ZIThouIPn08b3whv+5/X5++RLcyEOznNwgJCQUtrb2qF69ulRl4tGrX5v69wyIew/u0jlNksVUnBzh3YefIxYHjx5BM7onhsZ6ssLQ1cYRXg5+KGfVCrZ6HRHmPwnLt+RjDf38nHsZAooJN9IwOoWI9qVUyQ07/Fo2/DvNgY5jK1w9+5oeAP+y9vjqI9K+37T2Kkr+7YVxI0OQ86VtgVJzZSvO26QNBcrMCsGcGQ5kMUygX4pTlyoYSvrx9Antk1tEACFcgoX4xIVzhujcRgc1qCNuUHUiuU9jBBR1Q0cJKMIrtMPg/oNofwucO6nAslQkqobGJt1IyRUgMCC0oBCh1/8afdJKHrtPeWQxyFqsX7XPx9mg8/PlI2+TYhSnr0viwNYY4hOzENv6jICiQ5PFqBk6Bg2ipqJ+lSkI9+mMCUMS6cSLIp8tBQ/Rcnr0XCNMnUZmUkdBv+6N0aC2F/nzao5QzvaxfFFp2p9AwT0HC4ODb1iOIxJiFdSqOB1ZHFcmjW84K3KujOKoPn6+hFvHdFwJK/KHPR3tRSwMdIVYd+/SXlLXFG7si7PScY/9Oxh4hIiHMDl2iecY8unJZ+dmyf7c23u4u+Kfv4ugTIl/JIlaWMVQDB08RNJf8j685JTb77/7X6ArbBnYbTtz+jiGJgxCALl4vNajnIcXHXOYVDXShonw+WgtAjeeKedUm927dZFQ+NmzZxL/4SFYtZ0/dwad2rSBvZk5rAwJDBbV4WbSQRYgcS08HZOOCG48GXMuv8H6V/lYxOsp7hIoeEb7aqa4T+OuZmHhyUyEN5wMN5sopJwhvSg4D/V5kAmgk6PrIaA8fvCRfHgrNK5kK+E/AgbWB+KNnLM4uLyCzRu9JUvHlStj4OGhoHE9Bft36aBuTZ6jUNCrO/1Nto38LQMqJ9sdJ482QgPiEfXIbWoUNQsNIqcQ0R5PnkoyaoWOQ2T5RPFC7lwPRuqnfujXxQG6/0Q+nzzuhA+vm7h1M09W2d25RaBgcJDVYGvB4KCz+xUQ9HBkjQWDgi5LefsiU6kZMG56y+CppHh/0sMrgbspkxHbboaAolezY2jTYL6cTJMaM1Gn0kTUCI1Bixq18eUD/STX2BYX6k9ZXJ5yWQeutqWgTy4Uh5G3aemHA/vGkU/LCZeJW3x2pZtK+7Pw6ATdiPwse7x9HA0fh8FI6K2t08A9Uo4MWWpJL5tq+ZwsRv+Oq2BvbirzFJ5EtHnUiUt0cb3sQYMGyToIVkR2hbjmXKdOnaRgyqFDh6TO3ahRoxDTr6+4HVy4hWekC7sl3DKoFz94YB/27dqOj29fITdbowyF2n8B4L8az01wFhAecuW5j5Il/oa1jTnad2gtUb0Zaf+2MHwurJA8zMsZQaKqVUVYRDjmzZ0tVknuBbkzvIiJkylY0P2wMDKCs5U1uTwOKGdbB+Wtu8NJdyCc9Qahe79D2EeUZNPLfMn9tOBOqkTJ8jzFhCsZmHQrS+pg2NcaDlOPrrhymo7BGCi4LxpQqB8inZ5D9aimUrXq2pEl9Dz/FkCo8wsKpo2tDAt98hzM1IzirVrpwd5ewdkTatXSZ49GkwvqgIP79AUUYmHI9Xr5whDdOyuoX2kOmlZbVACK2uFjRSL9RqC6fxJOHnGS1XUXTlUnS6gg2LvX9POnVMW/eSO3ABS3bpHl0FgMBgsd5VdQaIXDPnJz+Ozzlbnjn4VZlOnynifaMgl13962xiQiQ71apKBn80toXn0qGlQahybV5xJap6FGSDKq+8Qj5eo/1GnQBbH/yJkZyFJMGq+gTDF1fQVPxLx6Ng5f389Ac+odgvwUvHsdiYxv9fDhtQvd1zJ0czn+ik/pD6ScqApfJwW7Nj4Xcs1gYCvBaqeK+nD4f05e5uXhLMOw7hzAZ6OGevDwK6exYa4xftxoqXLEf/vsxXNJUubt7Y3KlSvLyA/zDroP9K3aVPL4ExTyhzL7pXkt36nf/6/BoO7HKTCvX76IJOIe4cQ7OFSdhcPQly1ZLuvK1fbzdwu361evYWDcAEnZExwYJMAQi0ffsdy4cQ2xfXrDzc4aZkSinWyC4WLZBJ4mamp+V+MhMCnTB7ZR1NlsuYZNb4G1L/KlgKSaDI0XGTEoMjDvHjB39weUq9APFf0a4+G95wX34/f4RrklJAP6TIZBUSfs2U7PL09HHX4lxc5OV6sH5edzsU0FDenZsz6ULs4r7OogM6M2uUpm9BusftSpagZuZJKX9GFGMoGgciKaVZ+PJlXnokm1GWhQZQLqkftUq2J/tG+tkLtKx8rTlUjs/h1nQK9kwPthiavDVMVnYBC5Jstwh90mrRAwGCCsbQXCVkK7ZcnLpSv4kae8oB8I8x43u1lD6sk/9kXWl064cNwfHeqdRNfG59AkapIAoxGRbQZFzYpjUcUrDpu30Z8TKDhiNpesBWdcuJqig9he1RHdpDxMiHh1aFMUHVoVgSm5VHF9FWSmNcDVi65oVFfBvft0OnQT1NP6A1kEyG0rhsLRohFOHyqUmLlA1J6TX2ekpaNju2gijTriOjEoOG7fztJUZqqNDcpKb8yxTuxzSzgENU6ByeSbR0v+HeL9q3LyOL9YB1aCvHwZAuX1Ghy+8T81BvKJ40clFSYPfzL/4IjcSvR63NhRuH3rGv+YekGaVhiMrPRsyRo1agRjcoFCQypixbLlyJH03Wq7cfM24gYMgo2NlRSfcbIyh4eDLVztQ+Fh2wLe5kPgUCZWcj7F9biADeRR7iW3lOtos3DNO5YF93k5qlq4pc/WWyjr2RHVak3AeyLf6un8ej+0jU993rxVKFXUAcP7TicgONDzL6729KTgXDWI5wuyskoIMN697oixI6vByc4UZkal0ac3PfvbZFG4M9RwCPlbcqU/fVLQrVUPAsNItKi5kCzFPLESPD8R7jMAUf691eWqBDoGxZ1bClxMqsHbtcnsUyc/iCXQgoIBwcKfseUQa0HC2vYfojLdHHLss/LyZah23qzNEdZ6Ld+tnnCHHlIJkdPHiyGumx4aVopHqzrT0LTGdPHr6kSMkXDd2pWjcXjnCDo5S+RnFFO5BUt+ESn72ralAmM9BaYGCtpFK3jz7k/k5pPv36GehIOcJnLEC074ZvAEjzahQlL/imQxAnCP9AfkVaiA0PxXSJk4pmj9+vWIioqCjo4OjIhYcvkuntWWEA9yqXiotnTxv4UUc1FGOqD8LY8McXlhthgci8QA4YVL169fxbbtO7Fu/Uba5yIpeVrBcT9+/iBrKHr16iHDvAvnzMSju7eQmfpVJveGJcYjqkq4xFTxZCADcnjiMFnEpLqAWvfjd0XjNRbPpOqSv58PSvxdVGpprN+8CekaMPOfPLp3XxIt8ESlvg65ihaOdK2RcDXqLNbB03w4bPTiYGDbGZXaz8CYo7ew4yOw5U0u1j5Nw9onGSLLOcHyowyseJSPtY+A+IT9sDRogkGxydRp8diVxl367X5Lo/e7tz4hbyAQ3buS///NiJSanhs/d+rtc2kbFe4smSO7d/LA86ddybKo81cplxXp5bmIqL+3gufP+Pnz3JUGFKTk168WR9OoiaRrBITKI1ElRC3EwsIr7Vh4DRAve8j80gUDevlAt2i1d6OGHIzQukdai6DlECpQ1M/+ZSlYVGuhgiKXHL/MXHUy78WTLCUqcMT0OhWGE4FkM1YCORmheHpzGAZ0YsROIPdpGupVniDDslw+KaR8TdStoiurqJBbWr0x7EqxAaIe49Pbvjh2MJJ8v6r4+CYGeT+MceqMmv2jdlQF6u3phhIoBBAMDI3F+PR4LepGNEBkSC98fFno2RR6SIXdF+75ly5dCi9vdyJuJSTeiWe1ef5CQjmM1QVFXNWocaMGkvyMGxPlZcuWyfAnT6xxzlfO4segePX6LbluWXQcTa9OorVUL18+lyRrni6OMknIi5d4Nrx4sb/g5uqAzsQTDu7dg6+fvxScr9p+BUVe3g8J4eARL3PiA8WL/S3zG7u3byOrm808VuThw8dIGDSUelp7yWxoZqwjYS1O9h5kIavB06w7HHVi4GQQj4ZV1mDOyjc4TMrOgFj/IhvrnqVj/fMMrH+WhTWP07HyWQbWvQYW3s6Af68ZsLRtg1ULHxacWgGx1lx34Xbh/BWY6FVGaEBXvH1dhZ65BX5ownhkSUFeUcR0bwDDsgpM6Dk3aqDg7j0i0vnFkZNrTzy0NpJH1MagfqHIyiTrogn8EyFQHD5I3NM/AdWChwso6lUdQ1ZjLBpHJYv7VCVwiFoxlTriCyeCiDspcLduP/36eZVcF3aTfgEEf/efloJrr5LQBUsMFF2vJDXQcovFUx8HWpRp/WjxtI7I+txTzBsr6vghw4nsDCHfbhbqVSLCU3kYkxpE+g9F9QpDUKdiPaQcj6GfJsXmm6MVjovnVXqMwR9/4PPLnmhSR4GjJV0IXczMadZElJoiJ9uegPGzxl4egeTLZ7o5gX5oWrMNMjgFY6H5Ln5g8tAKhD6jzZNHz9GudReU/Jt60jIOErfEYmlsDCsTE1gZ6aPsP+TKGRqgd7deuHVLDTHJzszC+rXrcObU2Z+K8AuhVo+j/UrbeGnp6KRRcHVxQiPN2oznz9WMJeqO2vPTitqy0zOwZcNGNGtUX6xY0SIKmjVtKClAZT8Nj3lDPGjU8GFwcbSRlJ/mRGitjF1had8eto4xsDPoCcuyXWBo3wkh0VMwaNMlbHyWjZ0Ehk2v6JoIBCwbnqrCYFj7Kgd7ibJNW/MUARV6oVpED9y6yXMQmsvm/+XFD7VD4E+4A6J/Ny+CXNsGCAlU8OyBPikxh/2QdUg3pYsibyGvDD2Hsti+rjwc6BlzlVPOVO/tXhRb1o9CdrYr/RzzSNIHBgFbB/r7/MySyMtxxbZ1C9G2QTIaRs5By1pLxH1iTqEl2rXCY9C0diTevPqH9rdA9+ZTUbpI0KPx47YFstJfu8FDsCo4WO7Iayi3GRD8/laOCB21ECg4GEkDClXUYVnmFj/yc5UPj6DUrDgxKdK/OJ7daSx/wko6MWEknVQ8mlafLaCoVSlRsrExmmv7D0MVn6oYFmujBgCytWB+kUbKTRcsq/T4BhAoVi+0g2FpBcvmtcT86Y1QwYuzNhjh+jUFTzjHVMFpEvGiG/zs+hVEBtRC+6Zx+KIZqs0h4p2VkynCY/ws4uPzg2Sh5zhv5no42QagLHEKjnXiRGgMCq0FYT+8dLFS5JPbYfjwkbLGW/v3ad/TJaPHowfUcxY0Val5F54PePr0OdLSyB3S/M3TJ49kpEpVoJ+WRft3WuG/mzFjFioSaf77z7/EenVq1xqnTx2j/XMKlPDdm7eYMG68hKJweAqXN+YIX14T4mxTAU4ePWBg0gHulnFoXW8N5q5+jb2E7110GVte5pFlSCPLkI4Nz7MFFJue52D9k0xsps6FXacGCVuh59IB40YdRuZXOjSfHjU+5QJQaM5fPSfgzu0HnCoGDub1cfFcM1JkL+TQM+YBlqzvRlg0R8Eh6uUZFE9ut4WPh4I+PR0wfWILGYXk/LArV3JkQxF1JR3rBPfFWeR65ZbFnl0KmtePRPOawxFdeyma11gkfIJFC4rK/l2waMZ4cp0scfK4AvMSleDn0T7p4oXvyo3rOQKKG7d+jj4xIFi03IIBcftm9m9EWyN0qbKVz0jrZSSKs92S1dix5ZCTeYku5wa0OyxBfT/yzLF5TW00q1GDiPYc1I+cSe7TQIR6d/u5cDwwnk54IG7cYlNogB+p5H6xECB4IVJ+th6ZWjv4uP+DZvXc8e1jL9y72Rihvu7U8+jDkm5aRX/qfZ7QTc3juRLmFvR3TLy+/oHqPlVQN7I93pIrlUm69/VzquRnev3qBV6SL/74/gPcvn5Dem7tM712/Q6aNYyF7j+u0C/hCgv9cvRgrKRUsLU5Z/ouK65P6WJFUd7bA4sXzRP+wErACRC41x86dCiWL1+OYyeOYvzEcfIZJ1bmmhMyasUH4uNpXDmeUOP1FfPnzpORo8+f3iE7K43O7RqGDhoIF2d7/PkH8SxDE/TpFYOL5y+ov6FpXAqAw0Q43WfJf/6GoS6BwcwUFnq+sNKthuJmHVDarQ/MQwaiZtwqJB19iDUv87HpdZ5YiI2Ps7H5aa6U8dr4jLbkNm0kt2k7EecDb4DZa18hOCABjWvG4NIZDhf5FbSFXdKCRh+xhSjv0BLlXBRcv8Ar5Mgj0M5Pkbt07jRbY0UKws+ZMQAZ36PRrZOCKuG8eCgeu7Ybwd9Hgb6ugnVrAug31bSZPOP9A0VwYOd8NIgaQIBYiug6K9Cy+hJE11hK7voCNK42n549F4uvigUEvOx0O7x9QZ5L9Qoo83elc0vnXne6cZUAcD1fuXo9V+TmDQaFCgxV1BEp7eei+Fqh6/sFFAwI7XcMivxcKKlf8pVOjbb2cNaLweVLhBMCxr3r8WjXsKEAom6l6WQhYhHh01NAwcSnWshQhHjFYPNW+ikOBEsntymjiAqKnCLETcpi7BhFlL9f9yh0astZpRVUcLUhvzEIE0e1wYVTXUjRSyIzXSXcfGoMijzo4NXVZ6gS1IzcjTh842gHfnYs2geam0cPIlV6d44K5eA6/jonHVi7+Cj8PWujTFEbGOmq1VGtzHQFGBxBywuS9PXKQKdsSckIzgVVtD02k3FOoNy+YztZSMRk+Bfl4Q2fAr+kz3LysmWx0bQpU2Wiz8HemohzedhbW6EogcHezgqD4+OIKGqK7muug0ecFi1ahKBAf5Qo/o/U9BYwSOI2cpkM/OFsVh8RDeaje/IFzNuXis30Eyuf5gthXvU4DeseZwgoWBgULJtfZmHvZ2D+xY+I6D0XriGDMWPqTeRxoC9jWnOdP+XfLeXSNbhYN4aDcR2cOtJOyk6La8yAyP2TlFTBl4+hZCnIXTVXUKaEOvK0eP6fcHdScOJwdbIOzXH+jDviYv/C/bvdVVKtCQH5nqqgd5fa5CYPQcvaywUYbWqvQKuay9Cs5iI0qDIHdSonYO7E2dQh2hCQnLF0gT/MdRQ0rDmmx42LZA0IEDev5QkgrlzLIavBo01aa0HWo+D9f4CCzkLkJxhUws2SnZ2p5GaTTSN36sLxrFK2JvU2tm3QAR8eLaGLsMemteTjB7VCw6rxqBTQU6pQ1ghNFBeKq9uHeg9At5bNcO9yLO1vTmaxBPI4/CP3L7x75YCoCDU0mOPnWzRSyKwquH2bvv/xd8HpPbzdDf16Kvj83hA/ctk//VOVH8Xw7cvfqBUUQDeoA57epd1lrkslrhrdoseqri/g5aLSNF88f/4RI4bNIj+3Bor/WQ76pX1gpushJJyFgcEjVcZ6ZSWkvEOb1pqZ8V+VRXsM7fHkHSmWluNov+PGMUlcpcjPzwfu7q4YPTpJkqqpv6D+PbuCG9aspXtTkXjQnzAgYHKIu6WhBz30QFjq1YaVTjS5Tx1Qvsp4DD/0FkvIq5t9KxuzbnEVokwse5gl1Yl4VElLqHlybtd7YOc1oG/CPkT4d8OQ/rPw4nnhpFvqOfA6i59Nc738BW3OHPoKe9M6CKrAtePoOeVTJ0VgkMIpecWwZ0cDjEy0oM/5OfKknIKwILVmSWSol7hME5PrijVRE1sQEGhf7XwGLyE4cMAKDSrNR+s6q9G64Ry0qDuDrMAkes7JqFqxL1mOLrh7i49XmnTCAY/uByDAntzH4nU2rll1u9TF8wSEq1BukJvEs9YsV69nkyvF7lS2xD9pQXH9piqqthWINr5C+/4nKFjyclRrkfMNyqgh22ta6di+WTSlnoAiO80KExOXEdnpR3yio6QWqRk2DFGBiQIKJt0hnm5o1YB7B/o5Ho0Sn5FNni+2b7KQUPJjhwbg6/t2RM7Cicjr0o3SzlMoOH20ARysFNqHbhqBQjtUm5//D7lV+nhz6wZqRbSDr0c0Lp1iH54BUXhyT5UrV9Twb+0HwhOpU7x7LR/9esyBvWUkyv5tK+sp2FowIFg4stbeypzcAF042tpIZCtHv2obr2zjaqZXrl0V8NE9E1C8eMVp969LaYDbd+8Umv/IlzoaQr41Csf7c7jGrj27JcZJt3QZ6JUuLpOOBWLkCVujMNgY1gPXnzMz7oTSNp1h0mQkxp7+iLl3cjHnTiYW3MsSUHAdOx5V2kiWYTdZhuX3vqPTgkOoUD8ZHWM24uYFunie5uD7oWls2TS3p1D7CYpN63fBsGQ4/D3a4er59mT1vQrNVv+F1E8KQgIU1KrG79kV4u/ccOd6fdSvWVGGXY3IXWrVzFqiqbVxTT8D/njdtjUWLFBQPXCaAKNWxGhUDx2JmuGjULvSGOKuAxDTfgjtV1Ij9hg5TIGBUu3NgB5bap4+ma4cOvBR2bvvrXL8xHfl+vUsGV26fjNXIzkiDAoW5hwsqrb9S7RA+PU9PTAlRzMS9fr1WyXce8xod+M+uHK2uRArHlN+cEfB0P4VyGo0RM2QYagRzLUBhhIhHsQLxVG5Qj9UD2mBPZvG043XISJWRAUHh4zzYTS9BYt2dEsmcQgAC2Y1lfHrB/foM3LbMrMCkZUdJPsIcGgfdq/6trGCh5mbxO/zzHdB42dKD/TNq9e4knK50EPXKCQJDzfevHYXQ+ImwdWmDkr+6QW9EuVhbugFGyt7IuhW8HSwpO9MYapbBkHe5bF43mwCcSYPyCAjM1vK/g4ePBgDB/RD0shETJk6HStXrcHrN+/U4/088K+NeuXTx4+hRdMG0CldDAZEtC2J15ib2MNEtwIsytSSvK2c8ZtLa3EBdy6zxflk7egz438aol7kZMxNycbiez8IHN+xhNyl1U9/YPdzYMdNYOjko4huPhbx/Wfi1vUHch6FLdivTQMC3oP3YzwQfqaN3wmDIuXRtKmC189K0bPTjDJllUZOpg3Svtji2/sq8C//D8KDdfD9Sw9kZwcgO9dc5g9Svxpi/Gh12YA7uckyH8GpjjSg4KqnnCBv94ZZaNNgOGpWHI9GVWajaY354kK1qLVM3KfGUQno17GDEHo+h22r1sFcrzyR+Oajz576oty+kyFy4VK6cvToN2Xnng/K3v3flVNnQG4UWQ7N6NNP90q1IPRrhcHwKwj+/T5fsgnm5eUQQKDs3wAb06KtDnRrx3l6XKlj5vDe4ti2risi/eoKIDj1efWKCZKQikFRu+JQshzN0KiGEx7IWttiKiiYWBXqLbh34UMXeHJEuIbE+aNOteJC7q9eVtCuvYL7D8gV03AMBgUva0x9thxj+o+ClWFNjB+x+2fPrAEF16w7e/qMJERWleEnKFjkLfWcT24DU5N3IiKwLYx13VG2tLoU1c3WTIDh7eJI4LCVSqrVK1fBxk1bChYDcUzV6lXLcOjgXgJuIRdO+5964ILG/IRD3M2MDAUQkmCBrZQJl/myhYWhP1kFsgwECs74zQUYGRQsDAgGhoMBnWfJJijfdSYW3snDKjJiS5/kYMr5N+i94Djq9l2MMXPPExjogDyEzZRBcyq/nQ7dT/6EwaDlFXxNmejZfRhK/+2Nbs3H4N27RtSrO8gIE0ct5OeUxQZyo5uT+3vnqhvaRZeHqwPxxD4KWrZUsGiJgtRverSfNblYLpg0rhYS4kOQmUF6o4mC5U4xI7UMFhNpblkvCNF1E9C63iK0rksku+4SAUWzGksEFBzSMXf8OAFE2meF3PVKMCzlfmDZ/NM2rOQ3b6Upd+9lqUnOCACXCQhHjmUrm7e+F9l/8IOScomsx40fyh0CB1uP/3NQEABE6DXzjczcHIUes5KV/UPp33tMY/3iYZ+mD9tDvQCvljLElVMBaFS1LKoEDCf3SV0rG1EhBmHevQkoXJBvLAI94jFmWDnkpEZIPL34kAQO8SdzWLnLICfLV8I+Mr83x7tncagZZY7unYJx9+pShPsTGXdVcOaUqfbUBBg/QaRg9xYbuNoqaFxjJHEZ+kgeLksuLl44g/Q0YpQabRAdKPj+p1Kw8PDqnl0nENNjAny96kGvjCuMyjiRK2UnwYbl3ezgbGMiI1ZN6tfG8WOHCn63cCusYGrLx/3btzCwX2/yr42gq/sPzMx0YGtuCWtDT1jqkIukU08Un9cVW+k1lmLuUpFUgEBWQ4dILoHEUb8tSWfY63aEwT9N0bLhQswhtp04dxuSkpdjx9Zj+PzpA50En4O2/bzewk29dm4qJ+MO4vql77KyzqJUKSwn5ZYBE7buPMqkmZz7kamPGAJA8SIKPasKaB9diaysInUnKripCStiutdDTnZJOix1hvkEBCbU3BFyp5ijh/TP5TA8Zhvqhk9Dizor0bLuKrSqu1JGnaLrrCKivRwt6yxF3cqTMDBWwYsn/kj93Aejh1RDmaJVPnVpvajxpYuflGtXv8sEnayR0KTYv3cHCtE2mZO4cO6rsnXnc2XL9rfKrl1flVOnoFwj0Ny69T+sp6Cz1YjmfSFQsDAgeHUe3Trl5eMMxc+93Rhng9rSe//IM8DXV83RLdoB4RXUmsU1QuJlvSwDg0HByakq+yeheYM/8Oy+s/ACCSemm8NLDRkUr57y8JyaoZx7nhqVFAT5lkB0Uw/Uq2YkM5VbNwVRr1+TOjw6rgYMvNW6XZlfO+D4/qEo79QGFct3lwzed+/elviijRvWkNl+gtxsVUl+B4Xa1PcF+KDe9fmjfGzffA7xfcfR+QSqISNmenC1M4OPl5PEVvEoEpf54jSZv7afv8+chotU8lyDoU4pSdhmZ2cCS0t9WJmYwcaoHGwNKpPy1y+wCFpQSMEUdqF0CSBlG8GqdGOY/N0Qhn81gXnxaLhZ9kLbZsuweNdjHH+Qhmw+pFym9nq0Sq+1BP9TU0GxcvFJOqcwlHethD1r1pCbVB556WVV/qABBc87MSjev/NAwzrBKElkmuupt2rsRZ1Ye9y81BoV/S1gZkDuL8e0cTYO7ggZDCTqs9fHptUK8YcksQwMCAaGCogVBI7VaFyVlylMRfsmS8lVL4fM1Jo4tDcALsQ1y7t0HXNg+1flyuWvAgrmD5KQ4LYqDAgOAuQtA+QWWZAUIuGHDmUpGza8VjZufKYcOfL1d1BowfAbKDRCroUIfycTesQx+PNj+19Y6hT32VEjrCoe35gp7s3unQrCvJqSPzgIXEGGaxlXDuhHrweoxfmChiPctw2mjhmKTy/aiRkuIFp0wxhgDeuqEk/A2L5JwcXTE1Ep5A+Z7d62gXxZTtVOp6MCQp27kNxRTOzYFeNT/VEEKRd6I+XSFkkjw5WDODvG44ePcPb8GSnceO/eA/J5teT3f24/lUltbEHOn78o6Tl9fStI3qhyTvaShM3O3BBO1qZIGhKPRw/VVWksH96/xezJE+Hr4SZLYzmLoau9PRwt3WBvHE7K3pB6/zZkBdqJq2SnT7yBeYQeWQraco1q45J1oFs0EmWKBMGgREU4WdZEVGgHDOg/Hps37yWwv5Hz47P9L9GeS4FovtBasnzekLy8B3RuuUiCNfv1IP7AyzrJVSkYci2wEnTvM+lZ8Gtygz69K4WWLRT8Q5ahY/ua5POHidSp5iXhHbdktIgsBS8r0HgH7PrevdoHbRs1QysCQGuyDm0aLkDrBvMRXU+VVvV60/k4YMUyBR/fm5In4YMXD31R0TUehiWa7pg9d5vlxZTXSsrlT8qNG5nKLQIEC6fCLLzVvuZVdmxJVLDkKydOfVJ2737zfw8KDv8grZXvczmKlj7PSYUyKmFNNcMSeveH9efoRHM6YWP06zAegW6dSfkHIqhcX0QGxqJGWDxZjxEikYEdEO7njiF9FVy5QD9F/iQrc14OkS4i0u9etca3T52RnRYhKfs7tLKDvaWCJXO4VEAj2Z9Ps7B1EHBoTp8/y6Yb/ur5GHz8kILw8HD4+flJsuWD+w+QHuTj05ePuHHjFi5cuCRDoNr2OwD+q/3cJZ8A9xCzpk9CmL+PpOrkPFMV3B1hbWyI8t7lsGD+XOIYKxAWGgILAz0Ctq3sY2mkA1N9fZjoWJKy+8C0eE0YFW0Eg78awPDvWtD7qzr0i9SA0T+1YVKyPlzM2yGsQhxa1Z+CkYM2Yduau7h5MQvfeNKdFFnCuDXnpdH1f4nsqAUES8EXGstBr9ev2Yty9p3hZN4aK+bHI/XjIPKiigt3UIFAogECW4mCz2ibn22Bx48CEBriIMBIHqEOsfNQbHSTUImORXZRFVgMCLYSBIqNKyuhQVQNNKu+mIj1fHKRJqBOpfGoHTGBeGkyWtTugZQTkyTkIzfbhcQXiQMVGP7Z4H7PdpuqnTz9WDl34YWA4vbtnF8AoJXC7xkQbEm07tVtBgcJnc2viv+raLTrt/d0z1QhcDDx5tffvmcolQMH9DH8J4puYlNyXVrg+ydjrFiskDIrCA82kLrGLJyTh4WL8lX06UG8gy4+ZCr1/m2QmVmJepG/VJPKSk7y/k0VdCYyzxX2ebmieHMCABLGqAYUHKWiTZsjFifXCG9eBiA9PRPjx09EieJF4OnhjNq160r4xpMnnNlbdSc4QdkVsqWsENoek0EjUsjd+FU0jb/WCBdcmTN7OiIrh0kSAM5Q6OlkI1bD0cpEMop4uzvDxswMzk52aB3dCh3aDELr5gPRpsUgkQ4tBqJnh+EYEJeM0aOmY/7sldi8fq9kVH/66KWkt9G2wuAtOA367HdQ/9d+v7cf9LPXLvxA+2YJxFPMMZgs9NuX/9A3RVS/X2shSJHlNYOB3ab0P1Xh9/S9fJdXhNykv1AlUkHpYn8Kz2jZnBMc82CMOmOdm02c4ocO3r3sg+1rR6FJjYmoHjwG9StPRoPIGbLuv2m1BWhRcy0BZTX6djXDtw+h0mFyxzt37B6YlAomrtOxz95dN5TTp58oFy++EsLMCq4FBbtMsnbiDnMMNeiP88byCjwWdqVkHw1Q6Oy1Cv9f8r8HhYjm/Z0U/GFSovr0co5EgI9y/id7Mo12ePagNyaNbY+KXqrrVD1wuFSZqRzUF2F+vVC30kzUD5uBNs1L4epVMzoEp/HX9Pik5B/eRqFbRwVjRurj++cRpI504zXKz8KvWTj7uWRA10hOph5Sv0bi2bMX8PT0grGRLiLCg6X+3ZIlywQUKgDUduPaTTx68JheqUqvBcXPVhgQhT5nDSss5Id/+fweSxfOowdWETam+mIV2K1iYDCp7tCqFc6eUbOZs+uexyHwPFfAxoq3JDxvJnNnfIpa0Rz2FyXXvC44vKYVfP47QDRSuPHqvYQB68mda4AI/2jsXrVJsn7/yLFUc3Fxj65xd1jpC0CRTp9lcFiHxn3SgoK2uTn25LZWhIu9JRHvcLx6EYQfWRYa/sjPtxgePVKQGP8nmtd1Q/PaU9CmPgf9LSJZhtb1lpArtYxkA+pXWoLRQ8sh4yuXcDCTZHq8TsLNqvb0ZfMO/3Hq+FMBxdWr7wkIaq+vtQxapWdQsAXRWghJVqABheyj+ZzOTqvw/w+EuvCD+47alfozfFuQVy88fViNzK0zPcxSuHtDIXLdClHBccIxooITUDmwF7lP3SXpAQd11a88Ff3bbyRFNqW/Ka32/qzg/NMaxS8YftUekl9rgaB9L97dX3jydAj1KLcxdnQiuFSXjbWZZNPo1qkzEuIHyzLTwsqRl5cjsUsf3n9RlVGjPdo10f9q/6Vd1AqD6du3VCxfsRhVoiJkIrB6ZAR27txJ5/kff/g/Nc1x/n04PgYfS/u5+l4r/I32u8J/V/AZAe/NM2DGmIPwMmuEsEAFK5byGmj1/vHST3FtNGAQK8HCHIIBoBWtxeAtfacFjYCDLAbXrHsr6Yv+ls/EBcsvgZMHphIQhqBOBFmD2muIN6xWR5tqr0J0rZUEhnUiLepMRpPqLXDuDP0mWYg75zYi3KcGTHUjto0eucXu8LEbypHjN5Xz51W3ia0BA0BItqb3FxBoRPvZf33HQmeq0a7/F8J+DXXjQ/puDi9TpNKlnl051b413YxSxAuKEHGKR5hPb0lFwsCIDOotISH1K08XULSoNQ+NK0+SwpGSel0DgJ8g+OMXkBRs+TPmI9p9+T09zE+fx+Hdm+PwdFNrT9jbWaJCeS80a9QYQwYOwvSZM6RuxM8eNY/I83dsWL+FevGLP7Xnf2r/w/f/tjC5+PrtI3Zu2YhvHzXhvJr2vwJHwXea42g2hdqvyq99r+UM2v1//zt+/frNB4xN2gAfz9ZwtWiIcf034cm9ichMq0M7ECAYDFoLoQXD/wYU2s9/AQXtz0tC83LKShIL+Sy3KF4+V9C+uScaVo1Ds5qrBBQMCJY2dQkgBIqWtdagcdQy4hUjsWL2GrEQmekG6NIsmPiX7aWeHWeE79v9XDl09Lpy7ORt5fp1ToOpAoK3vyt9YSD8l/z/BxQayc7IVxrUbteibNGAl/27L0RuphORLxdsW2eNKsFFyW8cK1IlqB+R8F5oWHk8mkbNRvMadHNqrkbX6PE4sms6vrztT70K106mnyXRYE4UXwVHYdDQA9GAJjfPBB8+hMsiHeYOPPPMtSkcHazh4myHqtUqo2fPnrKyjifNCppGe54/eY1aVVuSbz0Rpw58JpNNn//0sv7dtJNxGmFlVhVao6Sapt2lQIm1H2j307wv+Phf7df9Clqhj+W3fwOTCJ3/j3Tg+nlgRNwKlLeJQHgAEeDJCt69p/snMWZ0DwkI6hApv9aIFhi8zp6FAzrTiENoFV8DjgLCnUoir3keg4T+hvdjgLFkZkRi8thQVA2aiOi6y6gzXIBWdecTGOajXf251HnOQtNaYxDdwBMJsX/gHFfXzTMisj8aiX3bQv+fGi/rVxvXYsu2Q8qBQ+eUg4euKZcuvieFzv5FuQsr+++K/7uo36uJlunMf1Xo/ydCmpvxDUqAZ9sYAkbW0oX0EYHi69u2GDGwEgJcByLSLwkRfr0LQNGkCt2IaivQrsEm6hli0Dk6EHOmmuHeDbIYrPSs/PTTLIXBUBgU2m1mlgGBo4GsSGMuwYmVeY02A8KngicaN6mPVuTTd+vWjQj4eAGGKBIrj0bBLp9/BDuT2ihbNAhR4e2xaP4WPH/+kvaj7wu1gr+Tv9W8LmikotRr/5eOSj8uLzTvuHfXfKnZ/EcrpP2aHeT4//5YbZoP3r/7jFXLd6BJ7VGwNqqDCN8OmJm0Aq8ezUDG99Z0CuSqkpsj948tBNcZ0Q52/F+AQkSsBYlYjz+R/12zD/8d88Qff+LMaT00rltEBliqh0xGrdBJqB02HvXCJ5BwGv1EdImejT2bxuHTi1gBBMvMSQ6w0lWywirExaxe9EgAsf/gWeX0mQfED9JJoXMKhllZ0ZlQFwaCFhj/k6gu138sR/1/IeQ6iKScf65UcK0y0lzXA8smb6QbTObvux5mTFTQtK6CiFAdhAdGoGGlqWgWtRAtahAo6q9Hy2pz0KPZGvRsdh09ml7D8b2jyazXo+dLN1X4At9geihaQPDQLM+uktn/kV8U794Oo9f3MGp4ghR05NEfrk/h5GiLch6eCA2siOimLRETE4MJEybg8OHDolwFPaymnT+zUBJ4NauvwNmGlzXao2ursdi14R3ecwwfL4/m6Y1f/+w/m/a3fznGf4R7cOOPRH5zg7QpfLipv6NBAzftW9olPwN4cR/YtvYpuraYhQpO3lKkpFcnBSePkkvLyvujKIl6P9WROu6NSyI31xbvXtbGwzvh5IVZ0vcEmGwNGBgcGoCIopPSixQGRQEwaB8GBrtP6WXI4nth/84BGNBtNOqEjpbRR84QXj+SwBDJSS/moEm1JWhWYxkaVOuANStq0TXS35NKpX/vimVz2sOmTEt4OfYZuWDJBuXAkQvKnkOXlINH7yo3eG21Rum1APgvIPz+3f8k6lH/Hwk9J3WrAQU9IOXY3usl7E19p7mb+OPMcfqagfG1JS6f6YQtG4ehVZPWqBk0Fk0i56N59eVo32CDgKJbk1WIa/cAA9o/xJC+obh13ZOe+6+g4MPKjWNXSgOK3Jw/Sabh/u3tMDHQVfOjGqri6eGCkKBgNG3QBO1btUOHDh1koRCv39bmjvq13cG965Pw9lkyTh/piKSBQ4gPdYVx6drwduqMbu0nYPH8XXj86AUprOZP/qP9DraCptX235q4QJpXLIXfq8DQtp+gePf2E44fvYSJY5ehSd1BcLZqBFOdGsTXEjElaRJuXpyGjM8xapaLH8U01kAFg3pP1cC8z58NcPqYC0YP57SUJnTfyd1hd4gLe/7vQFHYajAw+L0AShfLyVuoWeVvcpmaiDXgDDBNaxDRrjWdeAQT7UWySrBl7ZVoVKMTThzpSldFf0+yd5cr3W8FrsYdp80cf73EPrIQew6cUfYfvaJcvfnp59DrfwDgdzAU3qewFP5OPer/c2EtVYWBsmb5cWNjvQoLXax9sX/NBpk/YMnLtsLqpWQxfAar626rLUenBhvRvOZsdGyyTIrYx3e6gdi2FzF54FOkptUVspVXAAQSjbVgLsGgyaTtl9TRxCnOY+/e/VixYpXUimjRvKlk2ytP7lN4eCXUrFmbLEVvxNN3k6dOkbxP/2qkiZ8+fsP50+2RlV6d3qulZu/dVLCBzrsrz7/48vnbIMqvIWI7TMf2Fa9w+Rj11Lfo9DhNLGNNO9SqER7ZKphk+x0U2s+0+s7CBoOxQJJJv/nhJXDtfA62rLmHEf3XoXHVHvC0dYSL6Z/wdlbQuomCpYvpPO/Sfcktpuk4uEMhBdUQaBEeVWJhFymvGG5fbEtKGoIa/lPhazsE9SK6Y/r45vSsSuFH1t8S+Fcwc63lDyQ/3Sj6HbEOfyIvowjdq1LIyLTGyLgpCPXqQa4SWYfwSTLaKPMQ1Pk1rTFPrAODoVW9pWhQeSwmjSXr8LWCxLwd2NEebqZdYaXXZuGoMTOM9x88p+w7cJ54xFXlypVvqjLzcCoJvy7sPmmVvPBn/ydCV/BfSv3/q/wEhbzPgbJk/n4bk7IOKyqQC3KZsy1oQPH4rp7k7KkXMRPR1VegQ731RLzmoF3DxWQlrgooErrfwoA257BipYJvX8qQztDP8oPWiBYUPHGXS8B49W4IXr9WM3JIJ61xQ969f4WUy+exbNkKjBiRhPbt26Jt29boG9tP6jj8bi20w7KpXybixlV7+glSCBaydvnfqyPz40C8e7wIh7YuwvjBc9AzeoKUl3Iw+v/a+w6wKq6t7Z3EHnvvWKIm0WjsKAhSRRAEpKk0QSlSBESQolJM7C32Ho1RsXds2GssqLEg2HtHBKnq+6+158wBjbn3/l++PMm93+V5Xs7MnjlzprzvXmvt2XvtQfi2WRBszcYg1Hc+EmKXY9a09diw+ggOp1zChfM35cCmhw+e4v69x3LCFY5Xrl+/icuXMpB69iKOHUnFruRDWLN6B+bMXI1RUT/A0zUSxvqe5Apao8bn+qhcphta1LWGRXd3RAwNxpqFY5GWmiAtQkGeMblDdenSy8t7o8QKRFpNGnspEFUUZDW4+/XZw870LNpCp+IQfFV7GJpW18P8GZ54dJ/u8b8iCllGx+My2p+zb2zdJmDQ3opihiiZ5cWm5xQpCnvTme+JwsliKfoYTsPwwUnkvrVEUa4ujh/6ErrfCuhUdl2eEHGoyc7dx0XyrmNiT8ppkXruHhFYCayv8ptozXuGkuT/UAgfbv+9crqKkmT+YyD+SEjWloBaPmvqtha1P++4stPXxti3fqXWYiyd3Qw2Ji3IfVpD7tNWDOyzGB62y+T8FyMHX0Hs4BsY43sbnpa7kBBwDHMSDiLteIqSZa6oOlWk/PP0MDTdPvil0GUy+wmjB+Hs8f14zVnCqWrmZlKG+sciyMjIkPM08Nhp7Yg8+tu5c6fM6D1nzhxkvnyKK2nncP1qd/KNyc8mUskglH+Lf1OLz5Cf+xmuZnDvXYF1SQLfjxLwdBHo3VPA2EDARL8MTPVqwqRrI4qnGqNHp+bQa9sCuq2boWOrBmjXvAZaN/4crRoKtCC0JLTVEdD9SjnG4IECcTFkqVYInDkh5PwfhUxIbkble0DgTnbadwu0LM+VO1qqrpLGUshyFkdRGdlEGhncFF2/7I02deLwTd14tK7vDsueBli3niqb15WU73HArbYq8TJD40bJQUZ0PH4umQ/9cGTvaDj0toNeB3+YdA+FafdhsDAYjj49E2Q6GierRDhYhKC/bSuEDBXYvFkgO7se8nOscCQ5FJ11wlG/ksfKyJhxLZIpoE4mC7E75Zw4eSpLvphTm1+5i4ZMgfkByUtCDboZHwpBXf5TWp/+mSjIjRCT45Na1fq8+UrdVk1w+iRtJlG8uBeKxJEDKPhaCOdeSUoPSatFiBxyChFelzDa5xYSht5DgOMRjPI5iNFDkxAf4iODRh5xV6SxFiVFwXlrA3wtUa3Cp+hlZITYiAisXb9GJg8oHvmm/KliKen7JycnQ09PD82bN8e+/ZxaJh93bhgi62k1bW3LHRi1wqBP7u3LL6UKihpTTd1RulycTTHn2Si8uD8Ht6/PQcbFJbhwcjkObFuATUnTsGrJFCz9YQLmTUrA/CnxWDQ9jtbHYOXCMdi4MgYHdsTg/KExuH85BpkPQpH3gly5bDsiqR6dQwsCz/7zmTwXzi3BHSKlKFT/n8HnSecsz5dFoVoLFSQKvo9306fAotsANCoXii9rxKJ+eWskLV2MgsJO5A5RsMzHkhZBEYG0DlymaY3inggvM6kyWM1j7QX6UAxh3NWQhB8gu/MYdPKHYeehMOocSZVClGx5DBo0Afu2T8aDW2EyyGccPViXrAtZiPLuKyOH7m21becRwXHErr2nxKmzt5VM4URinnWISaz2XVJF8Y/we6JQtv8JrU8q+TnIZvx2H66qisSMSRtbVC3TennbL3pg96q19FAbUjBXS9asoyP4hpaC7wBLhLifxcghVxHte51EcQchA3ci0ms/EoKeYczQxxRzHEbyz6lExjpSCCwM1ZXin3v+ojIc7QWql+fs1Z+ibh2qhb9uCYe+VlTbRmLzhiSkXTqH/LxsIkWJgJb/aZpKs7LUuSjIl380CRdTKVDl/FXyUriWJXJIn5xr6tIoeluGxGCOgtxeyC9sLacSUPx5zS2QKPl+hSAFTeC3yAwqU7epdcvbd/RbRGCZEohdk8KaVCN3keAOeJyWUtbaUgi0L4EtgYS0ECwEgioSPhaLiCC303mfPloa0ycIjI/ThZNNGSybXxULZgi6P7x/qeIXeSwGKQ5Cdim846Rlb+vh4N5YDLQJRLfWETD4Ngam3Uaht0GCzEjP6Gs4XoKTW9iZzoKNWRds32iouSdUZ2a5I3l9GNo1DED9KgOXD4/4rsX2ncfFzj2/KIL45QmRX5mwkYmsdAEnK3CVREJQiV4SqhhUfGx7yU+Gcjb/S/hnonhHT0IiH2LV4kNNapRvtrBjky9wSGYQbEREMpNm99GtGKyYOw6+jkcR4X0FUT7XEO9/G5xWJ8xttxTFaP9HZDHOYFTAbDx6SA+bB61ofkrWlvTzhUUNcO+2OUYOs0dznZoyK0etmlVlAgDO+cTTAjfTqY/u3TrD2dEJY+LjMGvObGzZsBFHDhyUMwVdvHgBBw8exuTJUzF5Qhs8e2iFN0Ry2c2dSaYRhtL6VQpPn5N7Qy7TjKkCS34UuE1uiVI70/5EdNkgIAlP36VzlcsM2kclsXodUgzqJ4lCbieyF1LNfOmswMa1AmPjlE/OjaS1DNyNQiMKJj+TXhKf1zVlbC1UUcjExWRtXj1tjdcvPCiIjydB2CH/pS9ePe4kRSHjCbpepSsHQY0rcjhtUUWc5ETJ1pVg3LkfTLvEyyTbZt255wInroinIDsRVnrcHMvNsDNl/ODazxTpFwdrrzd5Y0N0JDexaWW3hWPCDzTZsUuxDrsphjhxKp1ih3wSQjF5tRYinQjPKEH+kiT/sOzDbR9+Kmfzp4GFwQJRxKKt9jTLq346UqdyhXbTm9Q1wtIJyXTzexDZ6kmCP30sED40gWKKPYgdko44/xuIGHwcQ132IDHgLlmOBxgT8ACxfncp9tiAuePW4vD2Q3iQ/gMKqfbkASuSCNK1KYfjR8kf9xBo3UKgfnWB2lU/lUM/69aog9pVaqP659VRsVx5VK1YSfaT4h6uLRs1wZc6zVCPhMQZsXfuouO9qaAlG4uPXRZJegb59Q/Jx7c0EviqiUCTegIpO/rIcnVaZF7mLvGLZzvBw0UPIf59sHu3JXKzOdM2HZOOvXmjBaZPscR3iZaIjuiNAB8DeLt3wY10Ege5hbkvv0RfCyEzB372KcUsrlSb5/QoJj6LgrMvskBoXZbLc9ScA4viI1DOT4lJOOerGohzh0AJKtNu45d7hY1kyvwr50fBsa8JDDuGgqfotdCPhqluBMz1o2R3nt7dxqKP/jhYGoxH7x7jYNXTC7am9ZUEFHSMnOcJmDeFAvsaXmhU3XN6fMKsOrt2nxZ795wRKXvPkiCeSNKrXb5VS3E1rVCkX6WYgtwo1ZVS4ozfikJdVtfVspKff+rLu2L8vijeURX4rhBiT/K1Ck3rGcc3Ltclf+kSfjDsbvBQxXJY/9MeBPXfRHFEBsb4XcfowFQpCnal4vzukaW4j7jAhwgauArDPBIRExSN76M7YD/d7ELygfkB84PmQUvclJuT6YhDewdgTKQ5zAzb44smOqhRubqcNYdRq1p11KlRU77b4ElYalWkT0KZTwSc7M3lm3IUkpvGxGMSaWp+eZlMOhlTlMGT20tgZSyg10lQjU41oUYUvJ2nu3UfINCwJgXROiTMGlQzNhWYM5O+zwKm45hxd+sKAhUJ1SsLsmxK5ouTJGyezqAwpw2WzisPRwdb1KxRBSaGAk8e8LRZtJ3PTeM+qZaB74G0bHwvmPhqTFEytuBl+r6yXeMSsigKefotRRgsCBmvvCstZyA6elBgwWwBb7fy6Nq+BfTaBcGgQ4gUh3GXcBjrjpCisOz+HYw7jKJtsRRPjIG3SzR2rkuQgijKq4+JiXXRtLbIb90oMH5yfGoFFsQeEsP+fefE2TM3SRAFiovE5CVBaN0nEgRDFUOxOBThlGyKVcuKBfBbUSiC+pNiCpX82nWNONRy8t3fK796+aHo+E3fYbUrWNyLC9mIrCcDUZRrjNzXrbF+nUDYoEmI8UsmV+kgfOx2IsY3HYnB90kUd0kU9xHjcxiBztsQF3AHUYMz4Od4ABNjzuHZIzt6iI3lzzApZKDJP0vkyyVyppILso5cj9GjFSvi6iRg0VNQYCjkDDt6XYQknJ+XwAXaV81rxL61FIamJpWE51pY4xbdvx4DfTqGG5E/86U+lRHJaBuPFJsx9ROZaT3Apy3OnxfYskXg6y/q4ovG1WXaeE75uHmjwKJ5ApvWCyxbINC8fnmyPFWUqQmKypL7Qr9HwfHlSz3Q5kuySl8InD4eIAN9eV6qG6USXmshmOS0zPtQuRwGrJZrhKCOmZbbNfvxsWSza0EdaZF+mj8aA6xHyrhBv20UBcVK4GxKQjAiQei3DUQPEki3tkOh+40/BdvNETjkc8wk4XOy7VeZZG1J3LfTJyLYayRqlrK61/nrYcPmLVwjUg6kit1kIfamXBC/nHkpxaCSvaQ1UMmvkrnkNnX9Q1F8DCVFoYKumFnyv4N/KgqNg1y8n6xeyWeAuMt5ag1i+9cuY3Z6eKDAwzttUVjQTmLjkhMYG3oAY8NOUExxBJHelymuuEfuE1uLu4gPPAl/h82I9b0hEeVzHr4u6zGbgsS87LpKDcygn1TFIWu9N1TrFrSWA5tyMvsh83E/IrQDrl8ciPTzLsi47ILb152R/8qY9lfmB9cShaGpSSXhSogiZXs/tG2pZLHIyzfVxhEsisGDBJo1InLsSdS2tgx2t5eD+nfuoHMiUchRZXkdKcbqLMcsV6Ztbg4mFLRrRqyxP59PbtgjW/Qiq8Ii27jGhq5R01+J3RtVuHSeWgvB6yXEoo0pVKFIl6hYFPK7XC6PU4ruUSXMnEYVh0FzmHQZJAcEMXhoMfdX6k2ukyW5TvzJMNeLhGGnELja9cDNtNF0n3vLa2NBcAIzRxuygBWanO7dLa5/0pK7Yv+h8zJ+2Lf/vDh3/oFIyyCyktv0IeFV0heTu6QQlH1VUajCUD8/XP6YYOhqmbR/Ld4RYxiPHj4XIYGJhrXKemwyajsepw7PIv/ZTz5sNt+ZmTwKrxSmJo5BzNCdGBN4B6MDbiMx6CoCnQ4hfNBpxPpfpDjkEkYMuoAhzisR5D4b30UsxaIp3+PQ7hgKHH1Ih9UpQCylkItfNPEAmVxycdSan4jOmQtlDcqEyOXtSi0soZKMXQ6CGthLVwqlMecHLzSoIygmoP0Kdej36PskGs55NHKEQD1ymeb9ECs74z28a0PWqSNqVlTebYDfHnMgS+TNfDYILrZEenKhVi42UEivtvyQtXib1wL+gwUqULwzftxAqm8058vEl36/5jxVkqsNAuq6Btrr0VgUZZmup7CpjM/Yauc89cP4iMlkDQLQp2ccBcpj0Us/ThNIU0BNMOvGc0REo1fX0bJvU69uEWQpHKXVe1vQkgTxNfLzO2HV/NX4plkfVCmnv8nDZbLhlq3HxeEjabIL+P6DaeL8hZcKcXnwD7+YI6IqRC4mfklwR0ClM+CH5e+L6MNtJZcV/MWiYBGoyzxFsUzgTFbk1QuIhVPuN2ta2W9Gj85lsG1DS9qFCMyEeMdmty7OHNqHcO/N74lihMcpBA04SuuXyZJcRLjneYR6b0HfnpHobzkcrtbmRLBqiIsUuHKRfraQal0WRTb9rDqckslGZJKuQolltfuCUvNqWp6YOEyqN5yhkNY1VoLn3fg+wV6KImkVT2/G40no+xpRnDjamFylctCp9xl8vTlWIdJX+RR9e3VHzqtqdMzPld98UwpHDnZB8wbkxnUQZL1GyGPIbfKcCAWtMOl7gfLlyP3z7qqIgo2vRhgctGvPk8SrdY9Kdvfgco0QVCjNw8psQls3kQu3SCAxmmKdjr2lKDhhNouARcEZ+7j7BqdH5fxeLAoeWWncIQrdWvshyGsiMp/WlaJ48awRZpD1blazORpU7T5j7KjNzQ7tyRTHjmeIAwcviaMnMsTFy89F2tU8IisoXtAIgz4V/JbsCv41UXxsuST+FPfpj4BFkl9YIIrechbCNyJ5+4FPureJD9ap5J0e7T8HmTcOSFJJFDZHSrJAxKCVFHSnIXHoM0R53kGQy36M8ktFzJALJJLTCHM/CE/rVehnNl0OceT0KGZdp8K25zBs+3msrAXf8tRTRTp03BqS7LKWlZ3ZFAIqJKTaNa+UssxCkeIgaCwAC4Jx4kQXHN4XDU9ne3zRoDZST9kSMTtorYginFLYRW5SeJBAp3ZfoUHtqvi2DedZrUrHo9+gY8tg9m05RIT1R7lSApEkZBQ01Fo2iVx+H6KLdUm6qFGuMnp21sP8mR7YseNbeU5ai8FQBaBCaxGV/dRWNJ6imRs6Lpwah7jwBTK9jI3RQlh1nwebHgu1U0IbdxkJ/W+DodfeB/odfGHQyU+KxbBrJ5jp14JVz3LyzfvPy7mHK8Uh2XY4czCKnkMcqpQxTP+mlWPwj4sOfvLL6fsy0cDhw9fFLycficuX84mwxS6PiqsymFaIr0Alsrr9fdH8HtTvlVzmwLpkOYPu0MdJ+leA4wwWRl5egcjPhbh4DMLXcW2v5tUNtwy0bIPzqUQYjSh48NHqmWmI9DiD4QOuYYTrDbj22oCR3r9oRRHiuh/+Tpvk3AUDrefJ/jW2xvNhYxAEp14t5UPj+ddSUgRuXGN3gU6Dx4ezKIh4ynTHRHqNJVHdElUUyv60TZJdICxMoFZVgSZ1qqNV43pw7iewjSdBpG1MPN6PfXh2Sx7dtoeFSQ/UrFIec2e2QOFrE+neyPHL5OLwzLJdOtSTU+bu2FGmWBQ8XwPFE4XkSk6ZKGBOMUW9yjVRs3wVVCorMJDIKMXK56hCFQO7e/ypioLdKb5etjBs5d6VQ0YaXUdAKzhbhcrhoQNtVsPVKgkOJsuI1D+gr/E4WBnGE0ahV48wmHQLlqLQb+uNuJEjsGxeKA7uGI0H1wfTderI/m0rlwkSkUC1zwy29Led0Gvvjnvi19QccfrsQ3HsxG1x9uwjsgosCG5efV8UvMx9nN4XxvuiKN73t0JglCR98Xd/C3V/ukPvE/OvBL/we0P2Oz8/V+Tm5ojXhbni6ctnYuaUrY2+buD63dd1Qp7Pib2CZ/dmEImMZKDMPUG3bCqDLeu/wbrV3yB+ZEcSRIZEsOtp+A/YBQfTKXDuNR39Leahn/EPclpZNvdtm3vIFhLOiM4JoIMGR2H3zmDkFXSkQLeKUmtr3BCtFSFo3Qy2EvzJsQQF8jwj5w9TBSYQWUMoyO7QVnm5JptkVUKSe/Xkjh38yXWqQQFycFBVrbhUd4eJtHZlRVQgkut2rkluB22nAJuF+TZHOQ5n9u5jpkyFZmIkMISOl5AgkLxVEa167ryvFKLGokmL9bYilbXAk/shMm7bumYS1v64Esvm/ghPu5EY0Gs+fB1Wwst2OTys1QlSFsgx9DynoY3ROLIYCTLI7tP9exh1tEaobxPto+T+aEWveyD16Hj4uYaj+mfmz+tUtPlufOLaRufOvRLnL2aL06kvxJnTT8XFX18RIYsHBykiUN49pKcrRC8m7fsWoSShle3vi6Ek1O3/aH+1TLmKvwlYFAxOm8PCeJWXLXIKXovclxBHtucKO4O5Ds3Kee92c/wUF1Mb0IOtJYWR99oKOZnDkJ0ZjqN7I+HfLxXh7ukIGngKQwfuhmuf2bJ7gUuvuVTjzdR0O0iAUZcw9OgQLAXCojDsYgULc4GFizXvObh7BoMtAYNrViKbNoBlN0UVBomCXbGC1/qyxSnnVV9cS7PFgzsDZNOnFAX78iSKAztbwb6PgJ9vBdy9850UDQtDEYRAQW4DDBsq0KAuvx13pe+UI5LR8VkQ5MapTcLHDzjh6D4H3LnVH1mZfZGXZyh9d60ANWBBSGFKa8Av4srj8CGB0VGl4D+oA3zdDTG4vwc8nTwo9gqHs+kcOBjNhIPxLLhaLpJTaTlbLJSWwtZkkuzVzOjVbSx6to2Gpb4TDiaHaC1mbs7nSPqJYqH2AjXLNdlt3jXaIXndC5FxmTvm5YsLl3KkMC7T59W0PJGRwYRUBfFbAhcvq1ahmNjq9pL7f1j+4baPratl/Klcxd8URUVvyWLki6zXZDUK8sXtOw/F5O+XNPmqftTYr2pFPEwcvgJPrm3XWg1NSzB+XqyLIDd3BLscRaDTYXjZbYSl3nQ5642tCVuK76QLwNkL9b7xg1m3SNmkaEbiMO4aK4drBnlGY9KoUUgYEYQJscOxatFEXL/iS368qVKzl7QSHNwyeFkbOzARi1FSRIW0LPsy8WXyviw0Nagnd+3N67K4SRbw3nWB/Czaj10m3qbGE7J7hfo79MkuHB+DLQMdR1qId+VJoN2Rl+WBFw8i8ehWKLKfhOLZ3aGYGL1KzgTkZbcHQxz2YbDDDgkfx+0SQ5y2wtVmJd2vuXSfJlEAzV3748l1cqdlfbpPuhRkN5Zv7jlz4EVya1FYF7n0W8dSYjHAIgFVyxo8rF/LamxY0E9NzpOrxN0z2AJculSgTS2jvozjHqyKpVBJqrhKijul+PwfElmFSuiPbf9H3/m9Mv5U7urfGG/evBPZebniZU62yM17I3JeQBzaCuFuudayWXWTtXYmDbF7+ycoyK+uFcXTu6Ox/IeZ8LPfD0/LZAzovQq9dKeAB8rbm82StZylQZwUhVHHYPRoP4weNvfTiZPCsDQIhF5bCxLMN7DQ60jogD5G7TDEQ+kOrro7kvBSCPypkF8VhSRsScFI0dB3SBQsCCkM3pePpRJakpq28/TKPH8HN8/m0TIJQZsUQBVFNlkVOiYfQ1oB7kgom1v5HErJbjLsSk0dz50syyI2vDQmxJVFVIiAk/lw+Disga/TAYkhjsnwcdqpFYW3w2Z4OazDIIcVcLVdBAeL6TIHsLOlD2ZPmICZ47/HkpkjyCpH4eXjIVIQj+5+IlvCOnwlUKe04Voz/eGWu7c/FVcvkrtzhYh3WelCIcmnaWplQTAUQZR0lUoKolC6USUJrJK3eP//GT52DF6nO/o+Cf9aSIbJgFt56VdczvNiZGe/lmCX6sHTh2LurM0VKSYY2rBC8Am3XutweMtqvH46Uc7FzUg9XQmLZgs5kmvBzCqIDmsF2166sDacKgfL96YakOfO0G83hFyoEPBUZGbdOCs6z6kxCt3b+VONGAHrnuNlFmyrHrPRW28mxkSEYtOq5VgwdQVmjV+CRdOXYO+aNbh/I5FqS0ciKWfGKIu8osbIf8MtW42I+I1kc63aEiXJLC0OE5q7ulPAy+sEGcfIGp/FUQOcQIy/z11MuIfsm4LKhGZ4/sQN509GYM+maIkLv/ji/vVo7Ez6gYgdStfJaevXwt1mEzxtt8DTegcG2STDo+9qihF4cM8s2Srn2381fJ03SnEM7rcLg+yTJdz6bqYgey1crGbC2mAg9uzk862kuIMkxKK8TnhyNwqzx89Al68HoHJp8xNtW/gMHZv4c8VfL5BrlE4BMoNJzkinYJqQfrVAQt2urheTs2RLU8nA+vfKP+5W/f9DOS5dZUny/dX4fVEw3nKWEHKnMnNeihfZmSKbYo2LJyHGBJ1v2bpWdELHZnWvjxpeHddukN9MoijM00VhtjWynlkgNzMAt69Ohb+nHXp24F6cnEkiUc62ZNDeF4Yd/KQQ1AnK2XIYdQmBYadgsizfS1HYm1LAafEjBtj1gY1ZT7jb+2GwSzD83QIwwtsb8dE62LS2CrJfCZDHh2u3PsNFcoOupQvcInCZ6vIol0WuEpGfx0Dz3HCytpc1PpGOPl+/FEi7IHDysMCZ4/yWn4VSRk6Osn2LQBC5LjzFsq1ZFQkehjrYVRCBW8HR3FuSelC/7XLglnSP+u2lADoFQwdshV//NWQNlspRjo695sgEZLyPW58tGNhnM8URm6g8CfZGy2QMNnPsMuTlkLDZepEoOEfv9s1CJnWoX6n29ZrldBNCfFe3PLEf4tZNBbfvQNy8RZ+Emzd4+Z2Eup23MbTrfxOUeEL/DmDHvEjOv5ednSVevnwhcnJeiVfkWh08eFIM8Zikq1PNdUaLWkGPI9134dje+RSAR1Ng2ZJq66qyBr93l+dIEDDVb6Gdqd9Mzw0dv7KCSecwWHSLltkLuSObVY8YGHwbDHPdCNiZxJMopsmA091mFZHoZ7kc7LEFIe5HEOKaimEDziPA6QwifVcjwmcVfPsdgY/9YQU2BxAXuA3rFm/CzUtzcWDHSEwesxYRfosxzHOuxJToWOxaNwHnT0zB3Kn94GQ9UjYG6H8bRi7ecFgZD0KwZzwC3EjI39pRWRRMuo4hcVN81CMRVvpT0KfHVPQ1mIw+etxKNAFutvMw2HE1uUWbCSQGp12Kq0Twdd4l4d1vB/r3XgdnG31ytdoSmpJVLY24qNKYQVaWR/ixi1SQ21Xm4tq0fC4JJgDVyps+rlzGaIZb/zDdK5d5Tmel8lL9WG3lpp2K+n1o/V31e1z2P8If/f77+Gjh3xHKG3BFFHwDuIWKxfHq1UuRmfWSxPFGPL4LkZyUI6jW69ms/ODZHb8q8yQqXOD0Kc5MUVFxa1gYN4IxKTGQCETkakduk747vPvHkLsRC9POEeQyjZbC4H48Ft2JmB1DpSj4JSALwc16JRFpHTjPqYftTwj1OIpQt3MY7n4J4R6XMdx7BbkrMxDU/xdEeP0q365HepynfX5GkHsoYsM6wc+9CfnscfC0H0c1cyK5M6PhaGwKp94t0c+yCsz0P4Gpng+dy0hpwWTM08OVhOuEHu1sYdzJET07sUWj+IgEwcKwNpgGe5NZcDafRW7PfDrWDNlaxM2p3vYb4O+yQ4rCz2W3VhCKOHZjoNUGxIR54t61WeSCjSerGoiHtwJR+NKNgvg6yHtVFSm7BXwormpao9yTWmVbz3axndTzaAqZjCJ6RiXJrSH7h+QvKYiS5X+c1H/0++/jo4V/PxRftOwnxZ+a8nfv3oi8PI41skQOIe91vnjw5KnYvG2XcLGPM6jzudWMhlUc77gYT8KqeTNw+/L3yM01l9aD3RFO0Zl2hZ7N24o4uE/IcQqc31bO6tr9eyLdeDkHOHdt4IRt/c2Xypk6B9muw1DnzXDrvRp+ztsxfNARjPA8qbxJ90pF6KCz8LJfg2D3HeRa0brHKYR6HkMICWioyz64Wm6Cu+1i+Lj8TML6mdyVH+HYe7ZMP8+xjmGHSJh0CSTCD4elXhxZMO5bFCPFwaI10Y2mWIjdvqGwNIxR+iMZj4O1yWTpDvG7BbZonEeL54izN5sN936jyZUi2I4iq5EAr/7j4dovAYOcHCgQr4a79/iWclcaqkCKasqxEg8yJmDpDyuowggD3cs71UqbzXDoG2SwP+UXkZ/HrQf8HIorK/lMqIx7Qmufn5b8KjTPUy3/zfa/Fh8t/PtBc7M1DvmHouBPDsTzSRyvXmaLrNe5Ioce2CPyaQ9ufy38XZd31Clvn9CgYulz1sYCs2YJXJL9n+qS/15NCqKwoBz56t2wZ9sA2FvEolubUHJPRskZl5RJLINh2W0CnE0XS1F42a2Xoghw3oGBlqsR5nkYEYN+kaIY7n1OCiPMazeRMAnD3E6SaM5IUQS7HUaw6yGJgdYLiLDz4Gm3UorCzoxqdtPJ0u3hDnfGnQNkrNObBMpgUciYhxsCSBi99cNJOMHQbx9E26JgZfQ97HpNlyns+1suli4e59Ea7LQW3k4r4ULu2Iz4DZg/fjvihi1CZPBijB+zAT8vmEcWIoq8nAp0KwkUTN++LrBoLlUSpgINKjc5p1PNNMFnwIKOKZuzxIvHEEUFRHwlYwSBBCGb0ZTnoQ4N0PZv+w3p/yuKP47fuWnv6GEwiteVN+LZOSSK13kiN/+1KCjKFzm5r8WFX6+IUVHTGzetb+JfpbTpti9qOb1ztY/ETwsm4UpqLPKzvFCY34pchS/w/FF1rFouMGIYBbO+AuMSObNeOcyfUx4uNg1kLextt12O2+BOiH6OG2VqnjCPExjhdRZh7mdkzqoRXmck+ZmYYV57ZDkjyPUIBbsp0p1x6b1Evm13s54DB7N5MtUPZ86TLlGPePTsHIVubX1k3l3L7lSmy7NAKVMxq61k3CGPLYtFdzty+fqRsMLg3HucTGXvbkuWzS4RA/paY81auo1vatCtUt6ecw4rHkn4poBT3PuQMGZiw4qF8HFehK/qe7yrXd5mWxudwf7DghIa7z9wRDx8dJfubabIzc2lSohFoBC/uJJSn4Nm/TfPTSMG7bqCD79fvN/H9/+z8dHCvx1K3Fxt7cPLHxGFAojCorciryBXCqPwTZF4S98vzIV4eAti6eyLwlIv1rxqmdZTalcSvxp1ExgdKbB7p8CLxzVJGM0luNt65uNBcmBNYa4hcrIGY82PQbIWdjQh18R6J4bYp8Cn33r4OmxAiNsxBPY/iuEeZymWOI/hnqcQMfgXBAzcJoUR4HyM4orTGOZ+jMr2wddpGxFwHZzMp8G2J0+LOxd2xrOVl4sGypzRDBPdEDlnX89vo2DcIUa+fZe9VDWxBudTYpH0NXLBuKjpCPaaDlebyRQDkbtntQDhfguw4adlyC/gWaZq0K3UvFN59xnFCooLOS5ewMZcoEntSr82rGQ/xUo/3nzS6MPiwNZ8cfP6KxLEM/H8xWPxOjdLCuL95/A+qbXr/xXF3wGqO1Vcxg+PXSs541KJB8kP9uyZX9l61GvToq9r1bIGS2qXM7tp0GYowobEY/Wycbh0Ng65mUEoemUlLYgaqN+nWGTrRoEpY0tjYvynWLtO4MHdhnj64Essmy8Q6O1KscRi6VJxrBHuPQ3DPH0xZqQxwgI6y1GCw9wOYohTCrwd9sCDXCx+Y2xr3hp9zb6GpUGsFAWPZzbvrrxo7NneD/36UqDrJWBlWAW9OrWFkW5v9OxqAbOuX8O5j8A+Tkv6tiqK8j7F04cC168J3L5JFqGgGgrf6MgsI3kvonD94kxsX7kUY4evgVH7kdCp5nmz3ucDlnRq6+7q7xNfb+WqJHH6TKq4mpEubty6KW7duiWePHki76MkqZbsfw1p/2x8tPDfFx9/SGrcUbyuiU14JGARxP0bEOtXZIgQr6U67XXc3GqWbb6gTlVxuUs7gYDBAj+Sb33hjEDWS+LC29IUiNYm4nUhgg3D62dBVAO3lzOGFuXqIi/THDs3rsaUUXvJddqPQHKTvgv/EQc278T9G6uxeU04Ql13wcN6M1ytt1EssYVq+PkkkLnYsnoKZk0cRrFFohziqf9tNMU1MejaOojcrDgcO+SA+7eHI3ltDKZEhyN4SAQJMBzT4sORemQECt/Wp3PjPlvlSLycdqaitAxZL8shg2KE1T+TSxioJFVrWafq5caVTBd0bhHo5jcgSWfxtBti385H4tKF5+JKWrpIu5oh0tKvirv374msrCzxhl+fq/f3v6L490RJq/D7+O1DffDggdibckhEjZxYrWM7W8salfTiKQZJblLN/nmPtv4IGjgJ8yYswf4tS5F2bhpevUiU1iT/lQPy87rjzZtm8p3Iu7eV8OSxwGNCPlewms54/DNPnwiZCG75ojL4YbIykEfO9MOzvdJ+D+8L7NpGYiSrs2CmwCaySk8eKd+V3CTCK9lK6qOooDW5dnrIy3ZAzjNfPLwei1+PT0Ly6tmYM2EB/AfMJLcrBq3qeD2vX6lfctNazvEm3f0tQ4dOqLZgwXJx6PBxcfbiBXExPU1cTrskwdbhwaOHIp+CDo7R/lPJ/3v4aOF/Kj4UyocWRFvOICvyOgvi+hWIFQuuCh/neU312vjaNyjfLaFBxaabW9Uve9O4u+LOxEcLrFgicORwGTx6VBm5OeVRxCP73lGtjc8J5L9LKD/x9k1FsizfIC9roARbGZ5/XLvfW45rvkBRjpFEYUELKqul/X4BuUePSTi3qPY/SfHA+iRl8pVgHwEHS4HOXwl8UevTm/UqNtrcsJJ5Qo9vRtoPcfyx6bSEE2LLykfi5IFMkXb+pUhLuyUuX8mQgki7cU08fPxAvHj5vLj1iO4NQxXFv1bR/Pvjo4X/1/AxcSgE4FqSgnS8EfkFRfIl4bnzl8SqnzeJkeHTKvaziejc4Wtv95b1Xb9rXNVjTfMaAWe+aTQis2uLGFi0nwAfx4WI9fsJ00auw7Ipm7Dpp+3YmrQGe9YlIWXjCuzZuBQpW5bg4Oa5OLRlHq3PxvakadiyYiI2LJ2IVUvHY/GsBExNHIfYYYkY6hkFV1vuixWMzi3dqPZ3QuPK1plVyxifqfhZ9zX1qpp916aFnXs/m+DOI0eMr7h0yTqRsu+w+PXCFXH58mVx7UaGyLieTrFCmki/dlXcvHmbLOMj2ZokhwNrBaDeh9/GaGr5h/frPwkfLfy/h997yIoouLbk1qyCokISx1uRmwORnQlx7ybEr6cgUjZni5XzHopxkaki2H1HVTerZW2tOk22at/EZ0iLan1GNa/Yc1bzKh2SdKp/sadJ7TqnW9Sukd6ybqUHrRp8/rJlg7L5rRt88paA5nXE28bVRX7jquJlw0riQe3KIr12JXG6VoXKe2qVa5hUt3KrWbUrfDvq60ZWQ0w7B1o5mX/XNtB1YdXJCfvEgeQX4tdfIG6mQTy5D/Hi6Tvx+FGuuP/gqbh75yEJ4Ka4fvMauUX3xfPMZ+JVTtYH18r48D4o6+q8I7+/338SIP4fiIwIwHapyksAAAAASUVORK5CYII=	14
82	13	Компьютерной инженерии	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	16
83	13	Компьютерного моделирования и дизайна	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	36
85	13	Искусственного интеллекта и системного анализа	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	36
87	13	Экономической кибернетики		37
\.


--
-- Name: department_ID_DEPARTMENT_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."department_ID_DEPARTMENT_seq"', 90, true);


--
-- Data for Name: discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discipline ("ID_DISCIPLINE", "Name_Discipline") FROM stdin;
19	Численное моделирование
20	Управление технологическими процессами
21	Автоматизация программирования
22	Веб-программирование
23	Программирование мобильных систем
24	Теория операционных систем
25	Компьютерные сети
26	Протоколы компьютерных сетей
27	Теория защиты программных систем
28	Администрирование компьютерных сетей
29	Системное администрирование
30	Информационная безопасность
31	Основы систем компьютерного обучения
32	Математический анализ
33	Теория вероятностей
34	Математическая статистика
35	Численное моделирование
36	Управление технологическими процессами
37	Автоматизация программирования
38	Веб-программирование
39	Программирование мобильных систем
40	Теория операционных систем
41	Компьютерные сети
42	Протоколы компьютерных сетей
43	Теория защиты программных систем
44	Администрирование компьютерных сетей
45	Системное администрирование
46	Информационная безопасность
47	Основы систем компьютерного обучения
48	Математический анализ
49	Теория вероятностей
51	Математическая статистика
52	Программирование с серверами БД
53	Компьютерная дискретная математика
54	Алгоритмы структуры данных
55	Анализ требований
\.


--
-- Name: discipline_ID_DISCIPLINE_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."discipline_ID_DISCIPLINE_seq"', 58, true);


--
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty ("ID_FACULTY", "Name_Faculty", "Logo_Faculty") FROM stdin;
12	Электротехнический	\N
7	Горно-геологический	
13	Компьютерных наук и технологий	\N
14	Компьютерных информационных технологий и автоматизации	\N
15	Экологии и химической технологии	\N
16	Инженерно-экономический	\N
9	Инженерной механики и машиностроения	
11	Металургии и теплоэнергетики	\N
\.


--
-- Name: faculty_ID_FACULTY_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."faculty_ID_FACULTY_seq"', 23, true);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups ("ID_GROUP", id_specialty, "Year_Of_Entry", "Sub_Name_Group") FROM stdin;
32	15	2016	а
36	15	2015	б
\.


--
-- Name: groups_ID_GROUP_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."groups_ID_GROUP_seq"', 39, true);


--
-- Data for Name: helpDiscip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."helpDiscip" (id_teacher, id_discipline) FROM stdin;
17	19
17	20
17	21
18	22
18	23
19	31
19	30
19	29
19	28
19	27
19	26
19	25
19	24
20	34
20	33
20	32
21	52
22	53
22	54
23	55
\.


--
-- Data for Name: holidays; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.holidays (id, date_hol) FROM stdin;
\.


--
-- Name: holidays_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.holidays_seq', 1, false);


--
-- Data for Name: para; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.para (id_group, id_lesson) FROM stdin;
32	17
32	18
36	18
32	20
32	21
36	21
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" ("ID_POSITION", "Name_Position") FROM stdin;
16	Аспирант
17	Ассистент
18	Доцент
19	Профессор
20	Старший преподаватель
\.


--
-- Name: position_ID_POSITION_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."position_ID_POSITION_seq"', 23, true);


--
-- Data for Name: specialty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialty ("ID_SPECIALTY", id_department, "Cipher_Specialty", "Name_Specialty", "Abbreviation_Specialty") FROM stdin;
15	84	09.03.04	Программная инженерия	ПИ
16	84	09.03.04	Технологии программного обеспечения интеллектуальных систем	ПОИС
17	86	01.03.04	Прикладная математика	ПМ
\.


--
-- Name: specialty_ID_SPECIALTY_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."specialty_ID_SPECIALTY_seq"', 20, true);


--
-- Data for Name: stadyingPlan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."stadyingPlan" ("ID_SETTING", id_group, "DateStartStuding", "DateEndStuding", "DateStartSession", "DateEndSession") FROM stdin;
14	32	2018-09-01	2019-05-24	2019-06-01	2019-06-28
19	36	2018-09-01	2019-05-24	2019-06-01	2019-06-28
\.


--
-- Name: stadyingPlan_ID_SETTING_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."stadyingPlan_ID_SETTING_seq"', 19, true);


--
-- Data for Name: subjectPay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."subjectPay" (id_teacher, type_pay, id_subject) FROM stdin;
17	1	18
17	1	20
17	1	21
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers ("ID_TEACHER", "Name_Teacher", id_position, id_department, "Email", "Rate", "Hourly_Payment") FROM stdin;
17	Федяев Олег Иванович	18	84	fedyaev@donntu.org	1	1
18	Коломойцева Ирина Александровна	20	84	bolatiger@gmail.com	1	1
19	Чернышова Алла Викторовна	20	84	chernyshova.alla@rambler.ru	1	1
20	Скворцов Анатолий Ефремович	18	84	a.e.skvorcov@mail.ru	1	1
21	Щедрин Сергей Валерьевич	17	84	do010575ssv@gmail.com	1	1
22	Незамова Лариса Викторовна	17	84	larkot@mail.ru	1	1
23	Григорьев Александр Владимирович	19	84	grigorievalvl@gmail.com	1	1
\.


--
-- Name: teachers_ID_TEACHER_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."teachers_ID_TEACHER_seq"', 26, true);


--
-- Data for Name: timeTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."timeTable" ("ID", id_classroom, num_lesson, type_subject, id_type_week, "Date", "Time", id_discipline) FROM stdin;
12	14	1	14	3	2019-04-16	12:50:31	19
14	16	1	17	3	\N	\N	35
15	17	1	17	3	2019-04-16	21:28:40.920912	35
16	17	1	17	3	2019-04-16	21:28:40.920912	35
17	14	1	17	14	2019-04-16	21:32:07.001098	35
18	37	1	17	4	2019-04-16	21:35:42.948955	35
20	16	1	17	14	2019-04-16	22:03:11.268964	35
21	25	1	18	3	2019-04-18	19:33:41.805622	36
\.


--
-- Name: timeTable_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."timeTable_ID_seq"', 21, true);


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transfers (id_lesson, date_from, date_to, num_lesson_to) FROM stdin;
\.


--
-- Data for Name: typeSubject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."typeSubject" ("ID_SUBJECT", "Name_Subject", type_lesson) FROM stdin;
14	Консультация	S
15	Экзамен	S
16	Зачёт	O
17	Лекция	O
18	Проработка	O
20	Семинар	O
\.


--
-- Name: typeSubject_ID_SUBJECT_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."typeSubject_ID_SUBJECT_seq"', 23, true);


--
-- Data for Name: week; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.week ("ID_DAY", "NameDay", "TypeWeek") FROM stdin;
3	Понедельник	V
4	Вторник	V
5	Среда	V
6	Четверг	V
7	Пятница	V
8	Суббота	V
10	Воскресенье	V
14	Понедельник	N
16	Вторник	N
17	Среда	N
18	Четверг	N
19	Пятница	N
20	Суббота	N
22	Воскресенье	N
\.


--
-- Name: week_ID_DAY_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."week_ID_DAY_seq"', 25, true);


--
-- Name: classroom Classroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT "Classroom_pkey" PRIMARY KEY ("ID_CLASSROOM");


--
-- Name: department Department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY ("ID_DEPARTMENT");


--
-- Name: discipline Discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discipline
    ADD CONSTRAINT "Discipline_pkey" PRIMARY KEY ("ID_DISCIPLINE");


--
-- Name: faculty Faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT "Faculty_pkey" PRIMARY KEY ("ID_FACULTY");


--
-- Name: groups Groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY ("ID_GROUP");


--
-- Name: position Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY ("ID_POSITION");


--
-- Name: specialty Specialty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialty
    ADD CONSTRAINT "Specialty_pkey" PRIMARY KEY ("ID_SPECIALTY");


--
-- Name: stadyingPlan StadyingPlan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."stadyingPlan"
    ADD CONSTRAINT "StadyingPlan_pkey" PRIMARY KEY ("ID_SETTING");


--
-- Name: teachers Teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT "Teachers_pkey" PRIMARY KEY ("ID_TEACHER");


--
-- Name: timeTable TimeTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable"
    ADD CONSTRAINT "TimeTable_pkey" PRIMARY KEY ("ID");


--
-- Name: typeSubject TypeSubject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."typeSubject"
    ADD CONSTRAINT "TypeSubject_pkey" PRIMARY KEY ("ID_SUBJECT");


--
-- Name: week Week_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.week
    ADD CONSTRAINT "Week_pkey" PRIMARY KEY ("ID_DAY");


--
-- Name: holidays holidays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.holidays
    ADD CONSTRAINT holidays_pkey PRIMARY KEY (id);


--
-- Name: Spec_discipline fk_Spec_discipline_department_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Spec_discipline"
    ADD CONSTRAINT "fk_Spec_discipline_department_1" FOREIGN KEY (id_department) REFERENCES public.department("ID_DEPARTMENT") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Spec_discipline fk_Spec_discipline_discipline_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Spec_discipline"
    ADD CONSTRAINT "fk_Spec_discipline_discipline_1" FOREIGN KEY (id_discipline) REFERENCES public.discipline("ID_DISCIPLINE") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: department fk_department_classroom_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_department_classroom_1 FOREIGN KEY (id_classrooms) REFERENCES public.classroom("ID_CLASSROOM") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: department fk_department_faculty_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_department_faculty_1 FOREIGN KEY (id_faculty) REFERENCES public.faculty("ID_FACULTY") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: groups fk_groups_specialty_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_groups_specialty_1 FOREIGN KEY (id_specialty) REFERENCES public.specialty("ID_SPECIALTY") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: helpDiscip fk_helpDiscip_discipline_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."helpDiscip"
    ADD CONSTRAINT "fk_helpDiscip_discipline_1" FOREIGN KEY (id_discipline) REFERENCES public.discipline("ID_DISCIPLINE") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: helpDiscip fk_helpDiscip_teachers_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."helpDiscip"
    ADD CONSTRAINT "fk_helpDiscip_teachers_1" FOREIGN KEY (id_teacher) REFERENCES public.teachers("ID_TEACHER") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: para fk_para_groups_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.para
    ADD CONSTRAINT fk_para_groups_1 FOREIGN KEY (id_group) REFERENCES public.groups("ID_GROUP") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: para fk_para_timeTable_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.para
    ADD CONSTRAINT "fk_para_timeTable_1" FOREIGN KEY (id_lesson) REFERENCES public."timeTable"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: specialty fk_specialty_department_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialty
    ADD CONSTRAINT fk_specialty_department_1 FOREIGN KEY (id_department) REFERENCES public.department("ID_DEPARTMENT") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stadyingPlan fk_stadyingPlan_groups_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."stadyingPlan"
    ADD CONSTRAINT "fk_stadyingPlan_groups_1" FOREIGN KEY (id_group) REFERENCES public.groups("ID_GROUP") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subjectPay fk_subjectPay_teachers_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."subjectPay"
    ADD CONSTRAINT "fk_subjectPay_teachers_1" FOREIGN KEY (id_teacher) REFERENCES public.teachers("ID_TEACHER") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subjectPay fk_subjectPay_timeTable_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."subjectPay"
    ADD CONSTRAINT "fk_subjectPay_timeTable_1" FOREIGN KEY (id_subject) REFERENCES public."timeTable"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: teachers fk_teachers_department_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_department_1 FOREIGN KEY (id_department) REFERENCES public.department("ID_DEPARTMENT") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: teachers fk_teachers_position_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk_teachers_position_1 FOREIGN KEY (id_position) REFERENCES public."position"("ID_POSITION") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: timeTable fk_timeTable_classroom_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable"
    ADD CONSTRAINT "fk_timeTable_classroom_1" FOREIGN KEY (id_classroom) REFERENCES public.classroom("ID_CLASSROOM") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: timeTable fk_timeTable_discipline_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable"
    ADD CONSTRAINT "fk_timeTable_discipline_1" FOREIGN KEY (id_discipline) REFERENCES public.discipline("ID_DISCIPLINE");


--
-- Name: timeTable fk_timeTable_typeSubject_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable"
    ADD CONSTRAINT "fk_timeTable_typeSubject_1" FOREIGN KEY (type_subject) REFERENCES public."typeSubject"("ID_SUBJECT");


--
-- Name: timeTable fk_timeTable_week_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."timeTable"
    ADD CONSTRAINT "fk_timeTable_week_1" FOREIGN KEY (id_type_week) REFERENCES public.week("ID_DAY") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transfers fk_transfers_timeTable_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT "fk_transfers_timeTable_1" FOREIGN KEY (id_lesson) REFERENCES public."timeTable"("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FUNCTION add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.add_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION add_transfer(id_tm integer, datefrom date, dateto date, numless integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.add_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION classroom_add(housing integer, numclassroom integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.classroom_add(housing integer, numclassroom integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_add(housing integer, numclassroom integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION classroom_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.classroom_delete(id integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_delete(id integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION classroom_get_all(start_row integer, count_rows integer, number_korpus integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_all(start_row integer, count_rows integer, number_korpus integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION classroom_get_class(house integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.classroom_get_class(house integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_class(house integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_class(house integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_class(house integer) TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_class(house integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION classroom_get_housing(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.classroom_get_housing() TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_housing() TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_housing() TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_housing() TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.classroom_get_housing() TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.del_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text, startstuding date, endstuding date, startsession date, endsession date) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION delete_transfer(id_tm integer, datefrom date, dateto date, numless integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.delete_transfer(id_tm integer, datefrom date, dateto date, numless integer) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION department_add(namefaculty text, logo text, namedepar text, housingc integer, numclassroom integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.department_add(namefaculty text, logo text, namedepar text, housingc integer, numclassroom integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.department_add(namefaculty text, logo text, namedepar text, housingc integer, numclassroom integer) TO admin_faculty WITH GRANT OPTION;


--
-- Name: FUNCTION department_delete(facultyname text, departmentname text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.department_delete(facultyname text, departmentname text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.department_delete(facultyname text, departmentname text) TO admin_faculty WITH GRANT OPTION;


--
-- Name: FUNCTION discipline_add(name_discipline text, namefacul text, namedepar text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.discipline_add(name_discipline text, namefacul text, namedepar text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_add(name_discipline text, namefacul text, namedepar text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_add(name_discipline text, namefacul text, namedepar text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION discipline_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.discipline_delete(id integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_delete(id integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_delete(id integer) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.discipline_get_all(namefaculty text, depart text, start_row integer, count_rows integer) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION faculty_add(name_faculty text, logo text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.faculty_add(name_faculty text, logo text) TO admin_vuz WITH GRANT OPTION;


--
-- Name: FUNCTION faculty_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.faculty_delete(id integer) TO admin_vuz WITH GRANT OPTION;


--
-- Name: FUNCTION faculty_get_all(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.faculty_get_all() TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.faculty_get_all() TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.faculty_get_all() TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.faculty_get_all() TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION get_groups(namefaculty text, namedepartment text, spec text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_groups(namefaculty text, namedepartment text, spec text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_styding_plans(namefaculty text, namedepar text, spec text, year_gr integer, sub_gr text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION get_transfers(facult text, depar text, fio text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_transfers(facult text, depar text, fio text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_transfers(facult text, depar text, fio text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_transfers(facult text, depar text, fio text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.get_transfers(facult text, depar text, fio text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getalldepartmentnames(namefaculty text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getalldepartmentnames(namefaculty text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getalldepartmentnames(namefaculty text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getalldepartmentnames(namefaculty text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getalldepartmentnames(namefaculty text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspeciality(namefaculty text, "NameDepartment" text, startrow integer, countrow integer) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getallspecialitynames(namefaculty text, namedepartment text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallspecialitynames(namefaculty text, namedepartment text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getallteachers(facultet text, departm text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getallteachers(facultet text, departm text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallteachers(facultet text, departm text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallteachers(facultet text, departm text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getallteachers(facultet text, departm text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getdepartmentfull(namefaculty text, startrow integer, countrow integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getdepartmentfull(namefaculty text, startrow integer, countrow integer) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION getteacherdiscipline(facultet text, departm text, nameteacher text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.getteacherdiscipline(facultet text, departm text, nameteacher text) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.group_add(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.group_delete(namefaculty text, namedepartment text, abbreviationspecialty text, yea integer, sub text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION position_add(name_position text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.position_add(name_position text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_add(name_position text) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION position_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.position_delete(id integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_delete(id integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION position_get_all(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.position_get_all() TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_get_all() TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_get_all() TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_get_all() TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.position_get_all() TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION specialty_add(namefaculty text, namedepartment text, cipherspecialty text, namespecialty text, abbreviationspecialty text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.specialty_add(namefaculty text, namedepartment text, cipherspecialty text, namespecialty text, abbreviationspecialty text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.specialty_add(namefaculty text, namedepartment text, cipherspecialty text, namespecialty text, abbreviationspecialty text) TO admin_faculty WITH GRANT OPTION;


--
-- Name: FUNCTION specialty_delete(namefaculty text, depar text, specialtyabr text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.specialty_delete(namefaculty text, depar text, specialtyabr text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.specialty_delete(namefaculty text, depar text, specialtyabr text) TO admin_faculty WITH GRANT OPTION;


--
-- Name: FUNCTION teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teacher_add_discipline(namefaculty text, namedepartment text, nameteacher text, namediscplin text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachers_add(namefaculty text, namedepartment text, nameteacher text, emailteacher text, rateteacher double precision, hourlypayment double precision, nameposition text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION teachersdelete(namefaculty text, namedepartment text, nameteacher text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teachersdelete(namefaculty text, namedepartment text, nameteacher text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachersdelete(namefaculty text, namedepartment text, nameteacher text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachersdelete(namefaculty text, namedepartment text, nameteacher text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.teachersdelete_all_discipline(namefaculty text, namedepartment text, nameteacher text) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_add(_date date, _time time without time zone, classroom_house integer, classroom_class integer, _id_type_week integer, _num_lesson integer, _type_subject integer, _id_discipline integer) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION timetable_delete(id_t integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.timetable_delete(id_t integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_delete(id_t integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_delete(id_t integer) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION timetable_get(facult text, depar text, fio text, type_week_char character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_get(facult text, depar text, fio text, type_week_char character varying) TO teachers WITH GRANT OPTION;


--
-- Name: FUNCTION timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_group_add(namefaculty text, namedepart text, name_spec text, subname text, yea integer, id_time_table_para integer) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer) TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.timetable_teachers_add(namefaculty text, namedepart text, nameteacher text, type_oplat integer, id_time_table_para integer) TO admin_depar WITH GRANT OPTION;


--
-- Name: FUNCTION type_subject_add(name_subject text, lesson character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.type_subject_add(name_subject text, lesson character varying) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_add(name_subject text, lesson character varying) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION type_subject_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.type_subject_delete(id integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_delete(id integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION type_subject_get_all(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.type_subject_get_all() TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_get_all() TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_get_all() TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_get_all() TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.type_subject_get_all() TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION week_add(name_day text, type_week character); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.week_add(name_day text, type_week character) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_add(name_day text, type_week character) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION week_delete(id integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.week_delete(id integer) TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_delete(id integer) TO spravochniki WITH GRANT OPTION;


--
-- Name: FUNCTION week_get_all(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.week_get_all() TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_get_all() TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_get_all() TO admin_depar WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_get_all() TO teachers WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.week_get_all() TO spravochniki WITH GRANT OPTION;


--
-- Name: TABLE "Spec_discipline"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Spec_discipline" TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public."Spec_discipline" TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public."Spec_discipline" TO admin_depar WITH GRANT OPTION;
GRANT ALL ON TABLE public."Spec_discipline" TO teachers WITH GRANT OPTION;


--
-- Name: TABLE classroom; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.classroom TO admin_vuz WITH GRANT OPTION;
GRANT SELECT ON TABLE public.classroom TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public.classroom TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.classroom TO teachers WITH GRANT OPTION;
GRANT ALL ON TABLE public.classroom TO spravochniki WITH GRANT OPTION;


--
-- Name: TABLE department; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.department TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.department TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public.department TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.department TO teachers WITH GRANT OPTION;


--
-- Name: TABLE discipline; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.discipline TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.discipline TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public.discipline TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.discipline TO teachers WITH GRANT OPTION;


--
-- Name: TABLE faculty; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.faculty TO admin_vuz WITH GRANT OPTION;
GRANT SELECT ON TABLE public.faculty TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public.faculty TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.faculty TO teachers WITH GRANT OPTION;


--
-- Name: TABLE groups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.groups TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.groups TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public.groups TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.groups TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "helpDiscip"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."helpDiscip" TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public."helpDiscip" TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public."helpDiscip" TO admin_depar WITH GRANT OPTION;
GRANT ALL ON TABLE public."helpDiscip" TO teachers WITH GRANT OPTION;


--
-- Name: TABLE para; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.para TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.para TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public.para TO admin_depar WITH GRANT OPTION;
GRANT ALL ON TABLE public.para TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "position"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."position" TO admin_vuz WITH GRANT OPTION;
GRANT SELECT ON TABLE public."position" TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public."position" TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public."position" TO teachers WITH GRANT OPTION;
GRANT ALL ON TABLE public."position" TO spravochniki WITH GRANT OPTION;


--
-- Name: TABLE specialty; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.specialty TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.specialty TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public.specialty TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.specialty TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "stadyingPlan"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."stadyingPlan" TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public."stadyingPlan" TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public."stadyingPlan" TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public."stadyingPlan" TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "subjectPay"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."subjectPay" TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public."subjectPay" TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public."subjectPay" TO admin_depar WITH GRANT OPTION;
GRANT ALL ON TABLE public."subjectPay" TO teachers WITH GRANT OPTION;


--
-- Name: TABLE teachers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.teachers TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.teachers TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public.teachers TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.teachers TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "timeTable"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."timeTable" TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public."timeTable" TO admin_faculty WITH GRANT OPTION;
GRANT INSERT,DELETE ON TABLE public."timeTable" TO admin_depar;
GRANT SELECT ON TABLE public."timeTable" TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public."timeTable" TO teachers WITH GRANT OPTION;


--
-- Name: TABLE transfers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transfers TO admin_vuz WITH GRANT OPTION;
GRANT ALL ON TABLE public.transfers TO admin_faculty WITH GRANT OPTION;
GRANT ALL ON TABLE public.transfers TO admin_depar WITH GRANT OPTION;
GRANT ALL ON TABLE public.transfers TO teachers WITH GRANT OPTION;


--
-- Name: TABLE "typeSubject"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."typeSubject" TO admin_vuz WITH GRANT OPTION;
GRANT SELECT ON TABLE public."typeSubject" TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public."typeSubject" TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public."typeSubject" TO teachers WITH GRANT OPTION;
GRANT ALL ON TABLE public."typeSubject" TO spravochniki WITH GRANT OPTION;


--
-- Name: TABLE week; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.week TO admin_vuz WITH GRANT OPTION;
GRANT SELECT ON TABLE public.week TO admin_faculty WITH GRANT OPTION;
GRANT SELECT ON TABLE public.week TO admin_depar WITH GRANT OPTION;
GRANT SELECT ON TABLE public.week TO teachers WITH GRANT OPTION;
GRANT ALL ON TABLE public.week TO spravochniki WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.12
-- Dumped by pg_dump version 9.6.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.12
-- Dumped by pg_dump version 9.6.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--
