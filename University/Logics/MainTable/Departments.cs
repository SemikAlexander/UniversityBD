using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.MainTable
{
     public class Departments
    {
        public struct DepartmentsStructure
        {
            public string Name_Department;
            public Image Logo_Department;
            public int Housing;
            public int Num_Classroom;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Departments(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GetAllDepartmentNames(string nameFaculty, out List<string> departments)
        {
            departments = new List<string>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT * FROM GetAllDepartmentNames("+ nameFaculty+");", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        departments.Add(reader.GetString(0));
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
        public bool GetDepartments(string nameFaculty,int startRow,int countRow, out List<DepartmentsStructure> departments)
        {
            departments = new List<DepartmentsStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM GetDepartmentFull({nameFaculty},{startRow},{countRow});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        if (reader.GetString(1) != null)
                            departments.Add(new DepartmentsStructure()
                            {
                                Name_Department = reader.GetString(0),
                                Logo_Department = Functions.Converting.Base64.decodeImage(reader.GetString(1)),
                                Housing = reader.GetInt32(2),
                                Num_Classroom = reader.GetInt32(3)
                            });
                        else
                        {
                            departments.Add(new DepartmentsStructure()
                            {
                                Name_Department = reader.GetString(0),
                                Logo_Department = null,
                                Housing = reader.GetInt32(2),
                                Num_Classroom = reader.GetInt32(3)
                            });
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

        public bool AddDepartment(DepartmentsStructure departments)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string sql = "";
                if (departments.Logo_Department == null)
                {
                    sql = $"SELECT * from department_add('{null}','{departments.Name_Department}','{departments.Housing}','{departments.Num_Classroom}');";

                }
                else
                {
                    sql = $"SELECT * from department_add('{ Functions.Converting.Base64.encodeImage(departments.Logo_Department)}','{departments.Name_Department}','{departments.Housing}','{departments.Num_Classroom}');";

                }
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
        public bool Delete(string department,string faculty)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from department_delete({faculty},{department});";
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