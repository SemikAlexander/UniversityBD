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
        public bool GetTimeTable(string nameFaculty, string department, out List<TimeTableStructure> specialtyStructures)
        {
            specialtyStructures = new List<TimeTableStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM getallteachers('{nameFaculty}','{department}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialtyStructures.Add(new TimeTableStructure()
                        {
                           
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
                int id_para_new = 0;
                string sql = $"SELECT * FROM timetable_add('{timeTableStructure.date.Day+"."+ timeTableStructure.date.Month+"."+ timeTableStructure.date.Year}', '{timeTableStructure.time}', {timeTableStructure.classroom.Housing}, {timeTableStructure.classroom.Number_Class},{timeTableStructure.week.id}, {timeTableStructure.num_para}, {timeTableStructure.typeSubject.id},{timeTableStructure.Discipline.id});";
                using (var cmd = new NpgsqlCommand(sql, conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        id_para_new = reader.GetInt32(0);
                    }
                foreach (var q in timeTableStructure.groupsStructures)
                {
                    sql = $"SELECT * FROM timeTable_group_add('{q.faculty}','{q.department}','{q.name_speciality}','{q.Subname}',{q.YearCreate},{id_para_new});";
                    using (var cmd = new NpgsqlCommand(sql, conn))
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) != "Success") { exception = reader.GetString(0); conn.Close(); return false; }
                        }
                }
                foreach (var q in timeTableStructure.teachersStructures)
                {
                    sql = $"SELECT * FROM timeTable_teachers_add('{q.faculty}','{q.department}','{q.name_teacher}','{q.type_Oplaty_Teacher}',{id_para_new});";
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