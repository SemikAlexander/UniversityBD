using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.Books
{
    public class Faculty
    {
        public struct StructFaculty
        {
            public Image logo;
            public string Name;
            public int id;
        }

        #region Variable
        public string exception = "";

        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion


        public Faculty(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;


        public bool GetAllFaculty(out List<StructFaculty> @struct)
        {
            @struct = new List<StructFaculty>();
            StructFaculty str;
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand("SELECT * FROM faculty_get_all();", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        str.id = reader.GetInt32(0);
                        str.Name = reader.GetString(1);
                        if (reader.GetString(2)!=null | reader.GetString(2)!="")
                        {
                            str.logo = Functions.Converting.Base64.decodeImage(reader.GetString(2));
                        }
                        else str.logo = null;
                        @struct.Add(str);
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
        public bool AddFaculty(string nameFaclty,Image image)
        {
            if (nameFaclty.Trim().Length == 0) { exception = "Название факультета не задано"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    if(image==null)
                        cmd.CommandText = $"SELECT * from faculty_add('{nameFaclty}','{null}');";
                    else
                    cmd.CommandText = $"SELECT * from faculty_add('{nameFaclty}','{ Functions.Converting.Base64.encodeImage(image)}');";

                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) == "Success") return true; else { exception = reader.GetString(0); return false; }
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
        public bool DeleteFaculty(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = "SELECT * from faculty_delete(@id);";
                    cmd.Parameters.AddWithValue("id", id);
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) == "Success") return true; else { exception = reader.GetString(0); return false; }
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
