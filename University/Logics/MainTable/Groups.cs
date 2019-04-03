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
            public int YearCreate; public string Subname;
        }
        public struct GroupPlan
        {
            public DateTime startStudy, startSession, EndSession, EndStudy;
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

        /**************************/
        public bool GetGroupPlan(string nameFaculty, string department, string specialABR, GroupsStructure groupsStructure, out List<GroupPlan> groupplan)
        {
            groupplan = new List<GroupPlan>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_styding_plans('{nameFaculty}','{department}','{specialABR}','{groupsStructure.YearCreate}','{groupsStructure.Subname}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        groupplan.Add(new GroupPlan()
                        {
                            startSession = reader.GetDateTime(2),
                            EndSession = reader.GetDateTime(3),
                            startStudy = reader.GetDateTime(0),
                            EndStudy = reader.GetDateTime(1)
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
        public bool AddGroupPlan(string nameFaculty, string department, string specialABR, GroupsStructure groupsStructure, GroupPlan groupPlan)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM add_styding_plans('{nameFaculty}','{department}','{specialABR}','{groupsStructure.YearCreate}','{groupsStructure.Subname}','{groupPlan.startStudy}','{groupPlan.EndStudy}','{groupPlan.startSession}','{groupPlan.EndSession}');", conn))
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
        public bool DeleteGroupPlan(string nameFaculty, string department, string specialABR, GroupsStructure groupsStructure, GroupPlan groupPlan)
        {
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                using (var cmd = new NpgsqlCommand($"SELECT * FROM del_styding_plans('{nameFaculty}','{department}','{specialABR}','{groupsStructure.YearCreate}','{groupsStructure.Subname}','{groupPlan.startStudy}','{groupPlan.EndStudy}','{groupPlan.startSession}','{groupPlan.EndSession}');", conn))
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

    }
}