using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

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
        }
        #endregion
        public Transfers(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;


        public bool GetTransfers(int id_para, out List<TransfersStruct> transfersStructs)
        {
            transfersStructs = new List<TransfersStruct>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_transfers({id_para});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        transfersStructs.Add(new TransfersStruct()
                        {
                            date_from = reader.GetDateTime(0),
                            date_to = reader.GetDateTime(1),
                            lesson_to = reader.GetInt32(2),

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