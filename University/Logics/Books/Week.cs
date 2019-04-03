using Npgsql;
using System;
using System.Collections.Generic;

namespace Logics.Books
{
    public class Week
    {
        public struct StructWeek
        {
            public Type_Week type;
            public string name_day;
            public int id;
        }
        public enum Type_Week
        {
            Top,
            Bottom
        }
        #region Variable
        public string exception = "";
        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion
        public Week(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        
        public bool GetAllWeek(out List<StructWeek> disciplines)
        {
            disciplines = new List<StructWeek>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM week_get_all();", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        if(reader.GetChar(2)=='V')
                        disciplines.Add(new StructWeek() { id = reader.GetInt32(0), name_day = reader.GetString(1), type= Type_Week.Top });
                        else
                            disciplines.Add(new StructWeek() { id = reader.GetInt32(0), name_day = reader.GetString(1), type = Type_Week.Bottom });

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
        public bool AddWeek(StructWeek week)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                char type_w=' ';
                if (week.type == Type_Week.Top)
                    type_w = 'V';
                else type_w = 'N';
                using (var cmd = new NpgsqlCommand($"SELECT * from week_add('{week.name_day}','{type_w}');", conn))
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
        public bool DeleteWeek(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * from week_delete({id});", conn))
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
