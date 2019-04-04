using Npgsql;
using System;
using System.Collections.Generic;

namespace Logics.Books
{
    public class TypeSubject
    {
        public struct StructTypeSubject
        {
            public type_lesson typelesson;
            public string name;
            public int id;
        }
        public enum type_lesson {
            Session ='S',
            Study = 'O'
        }
        #region Variable
        public string exception = "";
        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion
        public TypeSubject(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        
        public bool GetAllTypeSubjects(out List<StructTypeSubject> disciplines)
        {
            disciplines = new List<StructTypeSubject>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM type_subject_get_all();", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        switch (reader.GetChar(2))
                        {
                            case 'S':
                                disciplines.Add(new StructTypeSubject() { id = reader.GetInt32(0), name = reader.GetString(1), typelesson = type_lesson.Session });
                            break;
                            case 'O':
                                disciplines.Add(new StructTypeSubject() { id = reader.GetInt32(0), name = reader.GetString(1), typelesson = type_lesson.Study });
                                break;
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
        public bool AddTypeSubject(string name,type_lesson type_Lesson )
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string com = "";
                switch (type_Lesson)
                {
                    case type_lesson.Session:
                        com = $"SELECT * from type_subject_add('{name}','S');";
                        break;
                    case type_lesson.Study:
                        com = $"SELECT * from type_subject_add('{name}','O');";

                        break;
                }
                using (var cmd = new NpgsqlCommand(com, conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        if (reader.GetString(0) == "Success") return true; else { exception = reader.GetString(0); return false; }
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
        public bool DeleteTypeSubject(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * from type_subject_delete({id});", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        if (reader.GetString(0) == "Success") return true; else { exception = reader.GetString(0); return false; }
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
