using Npgsql;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Logics.Facultets
{
    public class Faculty
    {
        public struct StructFaculty
        {
            Image logo;
            string Name;
            int id;
        }

        #region Variable
        public string exception = "";

        private  Functions.Connection.ConnectionDB _connectionDB =null;
        #endregion


        public Faculty(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;


        public bool GetFaculty(out List<StructFaculty> @struct)
        {
            @struct = new List<StructFaculty>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return false; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();
                

                conn.Close();
                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
            return true;
        }
        public bool AddFaculty(StructFaculty structFaculty)
        {

            return true;
        }

    }
}
