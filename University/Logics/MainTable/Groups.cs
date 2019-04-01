using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace Logics.MainTable
{
     public class Groups
    {
        public struct GroupsStructure
        {
            public int YearCreate;public string Subname;
        }

        #region Variable
        public string exception = "";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Groups(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        
        public bool GetGroups(string nameFaculty,string department,string specialABR, out List<GroupsStructure> specialtyStructures)
        {
            specialtyStructures = new List<GroupsStructure>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_groups('{nameFaculty}','{department}','{specialABR}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        specialtyStructures.Add(new GroupsStructure()
                        {
                            YearCreate = reader.GetInt32(0),
                            Subname = reader.GetString(1)
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

        public bool Add(GroupsStructure groupStructure,string faculty,string department,string special)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                string sql =$"SELECT * from group_add('{faculty}','{department}','{special}',{groupStructure.YearCreate},'{groupStructure.Subname}');";
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
        public bool Delete(string department,string faculty,string abbreviature,GroupsStructure groupsStructure)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = $"SELECT * from group_delete('{faculty}','{department}','{abbreviature}',{groupsStructure.YearCreate},'{groupsStructure.Subname}');";
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