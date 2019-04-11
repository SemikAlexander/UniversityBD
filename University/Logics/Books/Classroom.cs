using Npgsql;
using System;
using System.Collections.Generic;

namespace Logics.Books
{
    public class Classroom
    {
        public struct StructClassroom
        {
            public int Housing;
            public int Number_Class;
            public int id;
        }

        #region Variable
        public string exception = "";
        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion
        public Classroom(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GetAllHousign(out List<int> housing)
        {
            housing = new List<int>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT * FROM classroom_get_housing();", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        housing.Add( reader.GetInt32(0));
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
        public bool GetAllClass(int housing,out List<int> classes)
        {
            classes = new List<int>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM classroom_get_class({housing});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        classes.Add(reader.GetInt32(0));
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
        public bool GetAllClassroom(int idHousing,int start_row,int count_rows,out List<StructClassroom> housing)
        {
            housing = new List<StructClassroom>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM classroom_get_all({start_row}, {count_rows}, {idHousing});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        housing.Add(new StructClassroom() { id = reader.GetInt32(0), Housing = reader.GetInt32(1), Number_Class = reader.GetInt32(2) });
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
        public bool Add(int housing,int classroom)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand($"SELECT * from classroom_add('{housing}', '{classroom}'); ", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        if (reader.GetString(0) != "Success"){ exception = reader.GetString(0); conn.Close(); return false; }
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
        public bool DeleteClass(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * from classroom_delete({id});", conn))
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
