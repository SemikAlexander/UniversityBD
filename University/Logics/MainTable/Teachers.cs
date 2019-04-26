using Npgsql;
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
            public float rating, hourlypayment, pol_stavka;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Teachers(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GetTeachers(string nameFaculty, string department, out List<TeachersStructure> specialtyStructures)
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
                            emaildata = reader.GetString(1),
                            nameposition = reader.GetString(4),
                            rating = reader.GetFloat(2),
                            hourlypayment = reader.GetFloat(3),
                            pol_stavka = reader.GetFloat(4)
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
                string sql = $"SELECT * from teachers_add('{faculty}','{department}','{specialtyStructure.nameteacher}','{specialtyStructure.emaildata}',{specialtyStructure.rating},{specialtyStructure.hourlypayment},'{specialtyStructure.nameposition}','{specialtyStructure.pol_stavka}');";
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


        /************************************Дисциплины**************************************/
        public bool GetTeacherDiscipline(string nameFaculty, string department,string nameTeacher, out List<Logics.Books.Discipline.StructDiscipline> specialtyStructures)
        {
            specialtyStructures = new List<Logics.Books.Discipline.StructDiscipline>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM getteacherdiscipline('{nameFaculty}','{department}','{nameTeacher}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialtyStructures.Add(new Logics.Books.Discipline.StructDiscipline()
                        {
                            id=reader.GetInt32(0),
                            name=reader.GetString(1)
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
        public bool DeleteTeacherAllDiscipline(string department, string faculty, string nameteacher)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from teachersdelete_all_discipline('{faculty}','{department}','{nameteacher}');";
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
        public bool AddTeacherDiscipline(string department, string faculty, string nameteacher,string namediscipline)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from teacher_add_discipline('{faculty}','{department}','{nameteacher}','{namediscipline}');";
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