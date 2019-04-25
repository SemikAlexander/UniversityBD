using Npgsql;
using System;
using System.Collections.Generic;

namespace Logics.Books
{
    public class Holidays
    {
        public struct StructHolidays
        {
            public DateTime date;
            public int id;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Holidays(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;

        public bool GetAllHolidays(out List<StructHolidays> _Holidays)
        {
            _Holidays = new List<StructHolidays>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM holidays_get();", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        _Holidays.Add(new StructHolidays() { id = reader.GetInt32(0), date = reader.GetDateTime(1) });
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
        public bool AddHolidays(DateTime date_hol)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand($"SELECT * from holidays_add('{date_hol}');", conn))
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
        public bool DeleteHolidays(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * from holidays_delete({id});", conn))
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

    }
}
