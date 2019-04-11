using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.MainTable
{
     public class Speciality
    {
        public struct SpecialtyStructure
        {
            public string Abbreviation_Specialty, Cipher_Specialty, Name_Specialty;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Speciality(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        public bool GetAllSpecialityNames(string nameFaculty,string department, out List<string> specialiteNames)
        {
            specialiteNames = new List<string>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM getallspecialitynames('{nameFaculty}','{department}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialiteNames.Add(reader.GetString(0));
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
        public bool GetSpeciality(string nameFaculty,string department,int startRow,int countRow, out List<SpecialtyStructure> specialtyStructures)
        {
            specialtyStructures = new List<SpecialtyStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM getallspeciality('{nameFaculty}','{department}',{startRow},{countRow});", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialtyStructures.Add(new SpecialtyStructure()
                        {
                            Abbreviation_Specialty = reader.GetString(0),
                            Cipher_Specialty = reader.GetString(1),
                            Name_Specialty = reader.GetString(2)
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

        public bool Add(SpecialtyStructure specialtyStructure,string faculty,string department)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string sql =$"SELECT * from specialty_add('{faculty}','{department}','{specialtyStructure.Cipher_Specialty}','{specialtyStructure.Name_Specialty}','{specialtyStructure.Abbreviation_Specialty}');";
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
        public bool Delete(string department,string faculty,string abbreviature)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from specialty_delete('{faculty}','{department}','{abbreviature}');";
                    using (var reader = cmd.ExecuteReader())
                        if (reader.Read())
                        {
                            if (reader.GetString(0) != "Success")  { exception = reader.GetString(0); conn.Close(); return false; }
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