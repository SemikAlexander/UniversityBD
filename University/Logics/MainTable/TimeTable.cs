using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.MainTable
{
    public class TimeTable
    {
        public enum type_oplaty_teacher
        {
            Stavka=0,
            Pochasovka=1,
            Zamena=2
        }
        public struct type_opl_teacher
        {
            public string name_teacher;
            public string faculty,department;
            public type_oplaty_teacher type_Oplaty_Teacher;
        }
        public struct GROUPSTRUCT
        {
            public int YearCreate; public string Subname;
            public string faculty, department, name_speciality;

        }
        public struct TimeTableStructure
        {
            public int id;
            public List<GROUPSTRUCT> groupsStructures; //массив групп на эту пару
            public List<type_opl_teacher> teachersStructures; //информация о каждом преподе
            public int num_para; //номер пары
            public Books.Discipline.StructDiscipline Discipline; //дисциплина
            public DateTime date; //дата экзамена
            public TimeSpan time; //время экзамена
            public Books.Week.StructWeek week; //день недели
            public Books.TypeSubject.StructTypeSubject typeSubject; // тип предмета
            public Books.Classroom.StructClassroom classroom; //аудитория
        }   

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public TimeTable(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GetTimeTable(string nameFaculty, string department,string teacherFIO,Logics.Books.Week.Type_Week type_Week, out List<TimeTableStructure> specialtyStructures)
        {
            specialtyStructures = new List<TimeTableStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM timetable_get('{nameFaculty}','{department}','{teacherFIO}',{((type_Week== Logics.Books.Week.Type_Week.Top)?'V' : 'N')});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        var _groupsStructures = new List<GROUPSTRUCT>();
                            _groupsStructures.Add(new GROUPSTRUCT() { Subname = reader.GetString(5), YearCreate = reader.GetInt32(6), name_speciality = reader.GetString(11) });

                        specialtyStructures.Add(new TimeTableStructure()
                        {
                            id = reader.GetInt32(0),
                            date = reader.GetDateTime(1),
                            time = reader.GetTimeSpan(2),
                            num_para = reader.GetInt32(3),
                            week = new Books.Week.StructWeek { name_day = reader.GetString(4), type = type_Week },
                            groupsStructures = _groupsStructures,
                            classroom = new Books.Classroom.StructClassroom { Housing=reader.GetInt32(7),Number_Class=reader.GetInt32(8)},
                            typeSubject=new Books.TypeSubject.StructTypeSubject { name=reader.GetString(9),typelesson=((reader.GetChar(10)=='O')?Books.TypeSubject.type_lesson.Study : Books.TypeSubject.type_lesson.Session)}
                            
                        });
                    }
                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }
        
        /// <summary>
        /// ID у type_subject, week, discipline
        /// </summary>
        /// <param name="timeTableStructure"></param>
        /// <returns></returns>
        public bool Add(TimeTableStructure timeTableStructure)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                int id_para_new = 0; string sql = "";
                if (timeTableStructure.typeSubject.typelesson==Books.TypeSubject.type_lesson.Session)
                    sql = $"SELECT * FROM timetable_add('{timeTableStructure.date.Day+"-"+ timeTableStructure.date.Month+"-"+ timeTableStructure.date.Year}', '{timeTableStructure.time}', {timeTableStructure.classroom.Housing}, {timeTableStructure.classroom.Number_Class},{timeTableStructure.week.id}, {timeTableStructure.num_para}, {timeTableStructure.typeSubject.id},{timeTableStructure.Discipline.id});";
                else
                    sql = $"SELECT * FROM timetable_add('{NpgsqlTypes.NpgsqlDate.Now}', '{NpgsqlTypes.NpgsqlTimeSpan.Parse(DateTime.Now.TimeOfDay.ToString())}', {timeTableStructure.classroom.Housing}, {timeTableStructure.classroom.Number_Class},{timeTableStructure.week.id}, {timeTableStructure.num_para}, {timeTableStructure.typeSubject.id},{timeTableStructure.Discipline.id});";

                using (var cmd = new NpgsqlCommand(sql, conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        id_para_new = reader.GetInt32(0);
                        if (id_para_new < 0) return false;
                    }
                foreach (var q in timeTableStructure.groupsStructures)
                {
                    sql = $"SELECT * FROM timetable_group_add('{q.faculty}','{q.department}','{q.name_speciality}','{q.Subname}',{q.YearCreate},{id_para_new});";
                    using (var cmd = new NpgsqlCommand(sql, conn))
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) != "Success") { exception = reader.GetString(0); conn.Close(); return false; }
                        }
                }
                foreach (var q in timeTableStructure.teachersStructures)
                {
                    sql = $"SELECT * FROM timetable_teachers_add('{q.faculty}','{q.department}','{q.name_teacher}','{(int)q.type_Oplaty_Teacher}',{id_para_new});";
                    using (var cmd = new NpgsqlCommand(sql, conn))
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) != "Success") { exception = reader.GetString(0); conn.Close(); return false; }
                        }
                }
                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }
        public bool Delete(int id)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from timetable_delete({id});";
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) != "Success") { exception = reader.GetString(0); conn.Close(); return false; }
                        }
                }
                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }


    }
}