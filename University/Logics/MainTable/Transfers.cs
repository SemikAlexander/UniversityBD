using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;
using static Logics.MainTable.TimeTable;

namespace Logics.MainTable
{
    public class Transfers
    {

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        public struct TransfersStruct
        {
            public DateTime date_from, date_to; public int lesson_to;
            public TimeTable.TimeTableStructure tm;
        }
        #endregion
        public Transfers(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;


        public bool GetTransfers(string nameFaculty, string department, string teacherFIO,out List<TransfersStruct> transfersStructs)
        {
            transfersStructs = new List<TransfersStruct>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_transfers('{nameFaculty}','{department}','{teacherFIO}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        var _groupsStructures = new List<GROUPSTRUCT>();
                        _groupsStructures.Add(new GROUPSTRUCT() { Subname = reader.GetString(5), YearCreate = reader.GetInt32(6), name_speciality = reader.GetString(11) });

                        transfersStructs.Add(new TransfersStruct()
                        {
                            tm = new TimeTable.TimeTableStructure()
                            {
                                id = reader.GetInt32(0),
                                date = reader.GetDateTime(1),
                                time = reader.GetTimeSpan(2),
                                num_para = reader.GetInt32(3),
                                week = new Books.Week.StructWeek { name_day = reader.GetString(4) },
                                groupsStructures = _groupsStructures,
                                classroom = new Books.Classroom.StructClassroom { Housing = reader.GetInt32(7), Number_Class = reader.GetInt32(8) },
                                typeSubject = new Books.TypeSubject.StructTypeSubject { name = reader.GetString(9), typelesson = ((reader.GetChar(10) == 'O') ? Books.TypeSubject.type_lesson.Study : Books.TypeSubject.type_lesson.Session) }
                            },
                            date_to = reader.GetDateTime(12)
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


        public bool Add(int timetable_para ,DateTime datefrom, DateTime dateto, int numlesson)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно";  return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string sql = $"SELECT * FROM add_transfer({timetable_para},'{datefrom}','{dateto}',{numlesson});";
                using (var cmd = new NpgsqlCommand(sql, conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        if (reader.GetString(0) != "Success") { exception = reader.GetString(0); conn.Close(); return false; }
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
        public bool delete_transfer(int timetable_para, DateTime datefrom, DateTime dateto, int numlesson)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from delete_transfer({timetable_para},'{datefrom}','{dateto}',{numlesson});";
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