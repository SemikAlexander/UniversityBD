﻿using Npgsql;
using System;
using System.Collections.Generic;

namespace Logics.Books
{
    public class Discipline
    {
        public struct StructDiscipline
        {
            public string name;
            public int id;
        }

        #region Variable
        public string exception = "";
        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion
        public Discipline(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        
        public bool GetAllDiscipline(string namefaculty,string department,int start_row,int count_rows,out List<StructDiscipline> disciplines)
        {
            disciplines = new List<StructDiscipline>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM discipline_get_all('{namefaculty}','{department}',{start_row}, {count_rows});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        disciplines.Add(new StructDiscipline() { id = reader.GetInt32(0), name = reader.GetString(1)});
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
        public bool AddDiscipline(string name_discipline, string namefacul, string NameDepartment)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand($"SELECT * from discipline_add('{name_discipline}','{namefacul}','{NameDepartment}');", conn))
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
        public bool DeleteDiscipline(int id)
        {
            if (id < 0) { exception = "ID не указан"; return false; }
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * from discipline_delete({id});", conn))
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
