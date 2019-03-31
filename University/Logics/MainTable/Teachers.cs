﻿using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.MainTable
{
    public class Teachers
    {
        public struct TeachersStructure
        {
            public string nameteacher, emaildata, nameposition;
            public float rating, hourlypayment;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Teachers(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GeTeachers(string nameFaculty, string department, out List<TeachersStructure> specialtyStructures)
        {
            specialtyStructures = new List<TeachersStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM getallteachers('{nameFaculty}','{department}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialtyStructures.Add(new TeachersStructure()
                        {
                            nameteacher = reader.GetString(0),
                            emaildata= reader.GetString(1),
                            nameposition=reader.GetString(4),
                            rating = reader.GetFloat(2),
                            hourlypayment=reader.GetFloat(3)
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

        public bool Add(TeachersStructure specialtyStructure, string faculty, string department)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string sql = $"SELECT * from teachers_add('{faculty}','{department}','{specialtyStructure.nameteacher}','{specialtyStructure.emaildata}',{specialtyStructure.rating},{specialtyStructure.hourlypayment},{specialtyStructure.nameposition});";
                using (var cmd = new NpgsqlCommand(sql, conn))
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
        public bool Delete(string department, string faculty, string nameteacher)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from teachersdelete('{faculty}','{department}','{nameteacher}');";
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