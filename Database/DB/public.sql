CREATE TABLE "classroom" (
"ID_CLASSROOM" serial4 NOT NULL,
"Housing" int4 NOT NULL,
"Num_Classroom" int4 NOT NULL,
CONSTRAINT "Classroom_pkey" PRIMARY KEY ("ID_CLASSROOM") 
)
WITHOUT OIDS;
ALTER TABLE "classroom" OWNER TO "postgres";

CREATE TABLE "department" (
"ID_DEPARTMENT" serial4 NOT NULL,
"id_faculty" int4 NOT NULL,
"Name_Department" text COLLATE "default" NOT NULL,
"Logo_Department" text COLLATE "default" NOT NULL,
"id_classroms" int4 NOT NULL,
CONSTRAINT "Department_pkey" PRIMARY KEY ("ID_DEPARTMENT") 
)
WITHOUT OIDS;
ALTER TABLE "department" OWNER TO "postgres";

CREATE TABLE "discipline" (
"ID_DISCIPLINE" serial4 NOT NULL,
"Name_Discipline" text COLLATE "default" NOT NULL,
CONSTRAINT "Discipline_pkey" PRIMARY KEY ("ID_DISCIPLINE") 
)
WITHOUT OIDS;
ALTER TABLE "discipline" OWNER TO "postgres";

CREATE TABLE "faculty" (
"ID_FACULTY" serial4 NOT NULL,
"Name_Faculty" text COLLATE "default" NOT NULL,
"Logo_Faculty" text COLLATE "default" NOT NULL,
CONSTRAINT "Faculty_pkey" PRIMARY KEY ("ID_FACULTY") 
)
WITHOUT OIDS;
ALTER TABLE "faculty" OWNER TO "postgres";

CREATE TABLE "groups" (
"ID_GROUP" serial4 NOT NULL,
"id_specialty" int4 NOT NULL,
"Year_Of_Entry" int4 NOT NULL,
"Sub_Name_Group" char(1) COLLATE "default" NOT NULL,
CONSTRAINT "Groups_pkey" PRIMARY KEY ("ID_GROUP") 
)
WITHOUT OIDS;
ALTER TABLE "groups" OWNER TO "postgres";

CREATE TABLE "helpDiscip" (
"id_teacher" int4 NOT NULL,
"id_discipline" int4 NOT NULL
)
WITHOUT OIDS;
ALTER TABLE "helpDiscip" OWNER TO "postgres";

CREATE TABLE "para" (
"id_group" int4 NOT NULL,
"id_lesson" int4 NOT NULL
)
WITHOUT OIDS;
ALTER TABLE "para" OWNER TO "postgres";

CREATE TABLE "position" (
"ID_POSITION" serial4 NOT NULL,
"Name_Position" text COLLATE "default" NOT NULL,
CONSTRAINT "Position_pkey" PRIMARY KEY ("ID_POSITION") 
)
WITHOUT OIDS;
ALTER TABLE "position" OWNER TO "postgres";

CREATE TABLE "specialty" (
"ID_SPECIALTY" serial4 NOT NULL,
"id_department" int4 NOT NULL,
"Cipher_Specialty" char(6) COLLATE "default" NOT NULL,
"Name_Specialty" text COLLATE "default" NOT NULL,
"Abbreviation_Specialty" char(6) COLLATE "default" NOT NULL,
CONSTRAINT "Specialty_pkey" PRIMARY KEY ("ID_SPECIALTY") 
)
WITHOUT OIDS;
ALTER TABLE "specialty" OWNER TO "postgres";

CREATE TABLE "stadyingPlan" (
"ID_SETTING" serial4 NOT NULL,
"id_group" int4 NOT NULL,
"DateStartStuding" date NOT NULL,
"DateEndStuding" date NOT NULL,
"DateStartSession" date NOT NULL,
"DateEndSession" date NOT NULL,
CONSTRAINT "StadyingPlan_pkey" PRIMARY KEY ("ID_SETTING") 
)
WITHOUT OIDS;
ALTER TABLE "stadyingPlan" OWNER TO "postgres";

CREATE TABLE "subjectPay" (
"id_teacher" int4 NOT NULL,
"type_pay" int4 NOT NULL,
"id_subject" int4 NOT NULL
)
WITHOUT OIDS;
COMMENT ON COLUMN "subjectPay"."type_pay" IS '0 - ставка, 1 -почасовка, 2 - замена';
ALTER TABLE "subjectPay" OWNER TO "postgres";

CREATE TABLE "teachers" (
"ID_TEACHER" serial4 NOT NULL,
"Name_Teacher" text COLLATE "default" NOT NULL,
"id_position" int4 NOT NULL,
"id_department" int4 NOT NULL,
"Email" text COLLATE "default" NOT NULL,
"Rate" float4 NOT NULL,
"Hourly_Payment" float4 NOT NULL,
CONSTRAINT "Teachers_pkey" PRIMARY KEY ("ID_TEACHER") 
)
WITHOUT OIDS;
ALTER TABLE "teachers" OWNER TO "postgres";

CREATE TABLE "timeTable" (
"ID" serial4 NOT NULL,
"id_classroom" int4 NOT NULL,
"num_lesson" int4,
"type_subject" int4 NOT NULL,
"id_type_week" int4 NOT NULL,
"Date" date,
"Time" time(6),
CONSTRAINT "TimeTable_pkey" PRIMARY KEY ("ID") 
)
WITHOUT OIDS;
ALTER TABLE "timeTable" OWNER TO "postgres";

CREATE TABLE "transfers" (
"id_lesson" int4 NOT NULL,
"date_from" date NOT NULL,
"date_to" date NOT NULL,
"num_lesson_to" int4 NOT NULL
)
WITHOUT OIDS;
ALTER TABLE "transfers" OWNER TO "postgres";

CREATE TABLE "typeSubject" (
"ID_SUBJECT" serial4 NOT NULL,
"Name_Subject" text COLLATE "default" NOT NULL,
CONSTRAINT "TypeSubject_pkey" PRIMARY KEY ("ID_SUBJECT") 
)
WITHOUT OIDS;
COMMENT ON COLUMN "typeSubject"."Name_Subject" IS 'Тип предмета (лекция, проработка, семинар, консультация, экзамен, зачёт)';
ALTER TABLE "typeSubject" OWNER TO "postgres";

CREATE TABLE "week" (
"ID_DAY" serial4 NOT NULL,
"NameDay" text COLLATE "default" NOT NULL,
"TypeWeek" char(1) COLLATE "default" NOT NULL,
CONSTRAINT "Week_pkey" PRIMARY KEY ("ID_DAY") 
)
WITHOUT OIDS;
COMMENT ON COLUMN "week"."TypeWeek" IS 'Тип недели (V - верхняя N - нижняя неделя)';
ALTER TABLE "week" OWNER TO "postgres";


ALTER TABLE "helpDiscip" ADD CONSTRAINT "fk_helpDiscip_discipline_1" FOREIGN KEY ("id_discipline") REFERENCES "discipline" ("ID_DISCIPLINE");
ALTER TABLE "helpDiscip" ADD CONSTRAINT "fk_helpDiscip_teachers_1" FOREIGN KEY ("id_teacher") REFERENCES "teachers" ("ID_TEACHER");
ALTER TABLE "teachers" ADD CONSTRAINT "fk_teachers_position_1" FOREIGN KEY ("id_position") REFERENCES "position" ("ID_POSITION");
ALTER TABLE "subjectPay" ADD CONSTRAINT "fk_subjectPay_teachers_1" FOREIGN KEY ("id_teacher") REFERENCES "teachers" ("ID_TEACHER");
ALTER TABLE "teachers" ADD CONSTRAINT "fk_teachers_department_1" FOREIGN KEY ("id_department") REFERENCES "department" ("ID_DEPARTMENT");
ALTER TABLE "department" ADD CONSTRAINT "fk_department_faculty_1" FOREIGN KEY ("id_faculty") REFERENCES "faculty" ("ID_FACULTY");
ALTER TABLE "department" ADD CONSTRAINT "fk_department_classroom_1" FOREIGN KEY ("id_classroms") REFERENCES "classroom" ("ID_CLASSROOM");
ALTER TABLE "specialty" ADD CONSTRAINT "fk_specialty_department_1" FOREIGN KEY ("id_department") REFERENCES "department" ("ID_DEPARTMENT");
ALTER TABLE "groups" ADD CONSTRAINT "fk_groups_specialty_1" FOREIGN KEY ("id_specialty") REFERENCES "specialty" ("ID_SPECIALTY");
ALTER TABLE "para" ADD CONSTRAINT "fk_para_groups_1" FOREIGN KEY ("id_group") REFERENCES "groups" ("ID_GROUP");
ALTER TABLE "para" ADD CONSTRAINT "fk_para_timeTable_1" FOREIGN KEY ("id_lesson") REFERENCES "timeTable" ("ID");
ALTER TABLE "transfers" ADD CONSTRAINT "fk_transfers_timeTable_1" FOREIGN KEY ("id_lesson") REFERENCES "timeTable" ("ID");
ALTER TABLE "timeTable" ADD CONSTRAINT "fk_timeTable_classroom_1" FOREIGN KEY ("id_classroom") REFERENCES "classroom" ("ID_CLASSROOM");
ALTER TABLE "timeTable" ADD CONSTRAINT "fk_timeTable_week_1" FOREIGN KEY ("id_type_week") REFERENCES "week" ("ID_DAY");
ALTER TABLE "subjectPay" ADD CONSTRAINT "fk_subjectPay_timeTable_1" FOREIGN KEY ("id_subject") REFERENCES "timeTable" ("ID");
ALTER TABLE "stadyingPlan" ADD CONSTRAINT "fk_stadyingPlan_groups_1" FOREIGN KEY ("id_group") REFERENCES "groups" ("ID_GROUP");
ALTER TABLE "timeTable" ADD CONSTRAINT "fk_timeTable_typeSubject_1" FOREIGN KEY ("id_type_week") REFERENCES "typeSubject" ("ID_SUBJECT");

