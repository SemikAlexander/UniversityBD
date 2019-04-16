using Npgsql;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;

namespace Logics.Functions.Connection
{
    public class ConnectionDB
    {
        #region Variable
        /// <summary>
        /// _configFile - название файла конфигурации
        /// </summary>
        private string _configFile = "config.ini";
        /// <summary>
        /// Класс, содержащий ip и port
        /// </summary>
        public struct Connection
        {
            public string ip;   //IP адресс сервера
            public string port; //Порт сервера
            public string dbname; //имя базы данных
        }

        /// <summary>
        /// все функции доступа
        /// </summary>
        public enum function_access
        {
            classroom_delete,
            classroom_get_all,
            classroom_get_class,
            classroom_get_housing,
            add_styding_plans,
            classroom_add,
            del_styding_plans,
            department_add,
            department_delete,
            discipline_add,
            discipline_delete,
            discipline_get_all,
            faculty_add,
            faculty_delete,
            faculty_get_all,
            get_groups,
            get_styding_plans,
            getalldepartmentnames,
            getallspeciality,
            getallspecialitynames,
            getallteachers,
            getdepartmentfull,
            getteacherdiscipline,
            group_add,
            group_delete,
            position_add,
            position_delete,
            position_get_all,
            specialty_add,
            specialty_delete,
            teacher_add_discipline,
            teachers_add,
            teachersdelete,
            teachersdelete_all_discipline,
            type_subject_add,
            type_subject_delete,
            type_subject_get_all,
            week_add,
            week_delete,
            week_get_all,
            timeTable_teachers_add,
            timeTable_group_add,
            timeTable_add,
            timetable_delete,
            delete_transfer,
            add_transfer,
            get_transfers,
            timetable_get
        };
        /// <summary>
        /// доступ, который есть у пользователя
        /// </summary>
        public List<function_access> Accesses { get; private set; }
        /// <summary>
        /// Настройки подключения
        /// </summary>
        private Connection connection;
        public Connection ConfigConnection { get => connection; }
        /// <summary>
        /// Строка для хранения ошибки
        /// </summary>
        public string exception = "";
        private string _login="";
        private string _password="";
        /// <summary>
        ///Настройки подключения
        /// </summary>
        public string ConnectString { get; private set; } = "";

        #endregion
        #region Function
        public ConnectionDB()
        {
            Load();
        }


        /// <summary>
        /// указание логина и пароля
        /// </summary>
        /// <param name="login">логин</param>
        /// <param name="password">пароль</param>
        /// <returns>true - загрузка успешно; false - произошла ошибка</returns>
        public bool SetLoginPassword(string login,string password)
        {
            _login = login;
            _password = password;
            if (!Load()) { return false; }
            ConnectString= $"Host={connection.ip};Username={_login};Password={_password};Database={connection.dbname}";
            return true;
        }

        /// <summary>
        /// Метод инициализации
        /// </summary>
        /// <returns>true - считывание ip и port успешно; false - произошла ошибка</returns>
        private bool Load()
        {
            try
            {
                /*проверка существования файла*/
                if (!File.Exists(_configFile))
                    return create_file(); //попытка создания файла 
                else
                {
                    /*если не удается считать файл*/
                    if (!readfile()) 
                    {
                        File.Delete(_configFile); /*удаление файла*/
                        return create_file(); /*создание заного*/
                    }

                }
                Accesses = new List<function_access>();
            }
            /*отлавливание исключений*/
            catch (IOException ex)
            {
                exception = ex.Message;
                return false;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
            return true;/*все прошло успешно*/
        }

        /// <summary>
        /// Создание файла конфигурации
        /// </summary>
        /// <returns>- true - запись ip и port успешно; false - произошла ошибка</returns>
        private bool create_file()
        {
            try
            {
                connection.ip = "127.0.0.1";
                connection.port = "5432";
                connection.dbname = "univer";
                TextWriter tw = new StreamWriter(_configFile);
                tw.WriteLine(Converting.Base64.encodeString(connection.ip));
                tw.WriteLine(Converting.Base64.encodeString(connection.port));
                tw.WriteLine(Converting.Base64.encodeString(connection.dbname));
                tw.Close();

                return true;
            }
            catch (IOException ex)
            {
                exception = ex.Message;
                return false;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }
        /// <summary>
        /// Чтение файла конфигурации
        /// </summary>
        /// <returns>true - считывание ip и port успешно; false - произошла ошибка</returns>
        private bool readfile()
        {
            try
            {
                TextReader tr = new StreamReader(_configFile);
                connection.ip = Converting.Base64.decodeString(tr.ReadLine());
                connection.port = Converting.Base64.decodeString(tr.ReadLine());
                connection.dbname= Converting.Base64.decodeString(tr.ReadLine());
                tr.Close();
                ConnectString = $"Host={connection.ip};Username={_login};Password={_password};Database={connection.dbname}";

                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }

        /// <summary>
        /// Обновление сроки подключения
        /// </summary>
        /// <param name="connection"></param>
        /// <returns>true - все успешно, false - произошлаошибка</returns>
        public bool updateSettings(Connection connection)
        {
            IPAddress ip; int port;
            if (connection.ip.Trim().Length == 0 || connection.port.Trim().Length == 0 || connection.dbname.Trim().Length == 0)
            {
                exception = "Пустой ip или пустой пароль или пустое имя базы данных";
                return false;
            }
            if (!IPAddress.TryParse(connection.ip, out ip))
            {
                exception = "Введенное значение не соответствует ip";
                return false;
            }
            if (!int.TryParse(connection.port, out port) && port>0 && port < 65536)
            {
                exception = "Порт должен быть целым числом и в диапазоне от 1 до 65536";
                return false;
            }
            try
            {
               if(File.Exists(_configFile)) File.Delete(_configFile);
                TextWriter tr = new StreamWriter(_configFile);
                this.connection = connection;
                ConnectString = $"Host={connection.ip};Username={_login};Password={_password};Database={connection.dbname}";
                tr.WriteLine(Logics.Functions.Converting.Base64.encodeString(connection.ip));
                tr.WriteLine(Logics.Functions.Converting.Base64.encodeString(connection.port));
                tr.WriteLine(Logics.Functions.Converting.Base64.encodeString(connection.dbname));
                tr.Close();
                return true;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return false;
            }
        }
        #endregion

        public bool get_access(NpgsqlConnection conn)
        {
            #region AdminVuz
            try
            {
                using (var cmd = new NpgsqlCommand("SET ROLE AdminVuz", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        Accesses.Add(function_access.classroom_delete);
                        Accesses.Add(function_access.classroom_get_all);
                        Accesses.Add(function_access.classroom_get_class);
                        Accesses.Add(function_access.classroom_get_housing);
                        Accesses.Add(function_access.add_styding_plans);
                        Accesses.Add(function_access.classroom_add);
                        Accesses.Add(function_access.del_styding_plans);
                        Accesses.Add(function_access.department_add);
                        Accesses.Add(function_access.department_delete);
                        Accesses.Add(function_access.discipline_add);
                        Accesses.Add(function_access.discipline_delete);
                        Accesses.Add(function_access.discipline_get_all);
                        Accesses.Add(function_access.faculty_add);
                        Accesses.Add(function_access.faculty_delete);
                        Accesses.Add(function_access.faculty_get_all);
                        Accesses.Add(function_access.get_groups);
                        Accesses.Add(function_access.get_styding_plans);
                        Accesses.Add(function_access.getalldepartmentnames);
                        Accesses.Add(function_access.getallspeciality);
                        Accesses.Add(function_access.getallspecialitynames);
                        Accesses.Add(function_access.getallteachers);
                        Accesses.Add(function_access.getdepartmentfull);
                        Accesses.Add(function_access.getteacherdiscipline);
                        Accesses.Add(function_access.group_add);
                        Accesses.Add(function_access.group_delete);
                        Accesses.Add(function_access.position_add);
                        Accesses.Add(function_access.position_delete);
                        Accesses.Add(function_access.position_get_all);
                        Accesses.Add(function_access.specialty_add);
                        Accesses.Add(function_access.specialty_delete);
                        Accesses.Add(function_access.teacher_add_discipline);
                        Accesses.Add(function_access.teachers_add);
                        Accesses.Add(function_access.teachersdelete);
                        Accesses.Add(function_access.teachersdelete_all_discipline);
                        Accesses.Add(function_access.type_subject_add);
                        Accesses.Add(function_access.type_subject_delete);
                        Accesses.Add(function_access.type_subject_get_all);
                        Accesses.Add(function_access.week_add);
                        Accesses.Add(function_access.week_delete);
                        Accesses.Add(function_access.week_get_all);
                        Accesses.Add(function_access.timeTable_teachers_add);
                        Accesses.Add(function_access.timeTable_group_add);
                        Accesses.Add(function_access.timeTable_add);
                        Accesses.Add(function_access.timetable_delete);
                        Accesses.Add(function_access.delete_transfer);
                        Accesses.Add(function_access.add_transfer);
                        Accesses.Add(function_access.get_transfers);
                        Accesses.Add(function_access.timetable_get);
                        return true;
                    }
            }
            catch
            {
            }
            #endregion
            #region AdminFaculty
            try
            {
                using (var cmd = new NpgsqlCommand("SET ROLE AdminVuz", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        Accesses.Add(function_access.classroom_get_all);
                        Accesses.Add(function_access.classroom_get_class);
                        Accesses.Add(function_access.classroom_get_housing);
                        Accesses.Add(function_access.add_styding_plans);
                        Accesses.Add(function_access.del_styding_plans);
                        Accesses.Add(function_access.department_add);
                        Accesses.Add(function_access.department_delete);
                        Accesses.Add(function_access.discipline_add);
                        Accesses.Add(function_access.discipline_delete);
                        Accesses.Add(function_access.discipline_get_all);
                        Accesses.Add(function_access.faculty_get_all);
                        Accesses.Add(function_access.get_groups);
                        Accesses.Add(function_access.get_styding_plans);
                        Accesses.Add(function_access.getalldepartmentnames);
                        Accesses.Add(function_access.getallspeciality);
                        Accesses.Add(function_access.getallspecialitynames);
                        Accesses.Add(function_access.getallteachers);
                        Accesses.Add(function_access.getdepartmentfull);
                        Accesses.Add(function_access.getteacherdiscipline);
                        Accesses.Add(function_access.group_add);
                        Accesses.Add(function_access.group_delete);
                        Accesses.Add(function_access.position_get_all);
                        Accesses.Add(function_access.specialty_add);
                        Accesses.Add(function_access.specialty_delete);
                        Accesses.Add(function_access.teacher_add_discipline);
                        Accesses.Add(function_access.teachers_add);
                        Accesses.Add(function_access.teachersdelete);
                        Accesses.Add(function_access.teachersdelete_all_discipline);
                        Accesses.Add(function_access.type_subject_add);
                        Accesses.Add(function_access.type_subject_delete);
                        Accesses.Add(function_access.type_subject_get_all);
                        Accesses.Add(function_access.week_get_all);
                        Accesses.Add(function_access.timeTable_teachers_add);
                        Accesses.Add(function_access.timeTable_group_add);
                        Accesses.Add(function_access.timeTable_add);
                        Accesses.Add(function_access.timetable_delete);
                        Accesses.Add(function_access.delete_transfer);
                        Accesses.Add(function_access.add_transfer);
                        Accesses.Add(function_access.get_transfers);
                        Accesses.Add(function_access.timetable_get);
                        return true;
                    }
            }
            catch
            {
            }
            #endregion
            #region AdminKafedra
            try
            {
                using (var cmd = new NpgsqlCommand("SET ROLE AdminVuz", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        Accesses.Add(function_access.classroom_get_all);
                        Accesses.Add(function_access.classroom_get_class);
                        Accesses.Add(function_access.classroom_get_housing);
                        Accesses.Add(function_access.discipline_get_all);
                        Accesses.Add(function_access.faculty_get_all);
                        Accesses.Add(function_access.get_groups);
                        Accesses.Add(function_access.get_styding_plans);
                        Accesses.Add(function_access.getalldepartmentnames);
                        Accesses.Add(function_access.getallspeciality);
                        Accesses.Add(function_access.getallspecialitynames);
                        Accesses.Add(function_access.getallteachers);
                        Accesses.Add(function_access.getdepartmentfull);
                        Accesses.Add(function_access.getteacherdiscipline);
                        Accesses.Add(function_access.group_add);
                        Accesses.Add(function_access.group_delete);
                        Accesses.Add(function_access.position_get_all);
                        Accesses.Add(function_access.specialty_add);
                        Accesses.Add(function_access.specialty_delete);
                        Accesses.Add(function_access.teacher_add_discipline);
                        Accesses.Add(function_access.teachers_add);
                        Accesses.Add(function_access.teachersdelete);
                        Accesses.Add(function_access.teachersdelete_all_discipline);
                        Accesses.Add(function_access.type_subject_get_all);
                        Accesses.Add(function_access.week_get_all);
                        Accesses.Add(function_access.timeTable_teachers_add);
                        Accesses.Add(function_access.timeTable_group_add);
                        Accesses.Add(function_access.timeTable_add);
                        Accesses.Add(function_access.timetable_delete);
                        Accesses.Add(function_access.delete_transfer);
                        Accesses.Add(function_access.add_transfer);
                        Accesses.Add(function_access.get_transfers);
                        Accesses.Add(function_access.timetable_get);
                        return true;
                    }
            }
            catch
            {
            }
            #endregion
            #region Teachers
            try
            {
                using (var cmd = new NpgsqlCommand("SET ROLE AdminVuz", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        Accesses.Add(function_access.classroom_get_class);
                        Accesses.Add(function_access.classroom_get_housing);
                        Accesses.Add(function_access.discipline_get_all);
                        Accesses.Add(function_access.faculty_get_all);
                        Accesses.Add(function_access.get_groups);
                        Accesses.Add(function_access.get_styding_plans);
                        Accesses.Add(function_access.getalldepartmentnames);
                        Accesses.Add(function_access.getallspeciality);
                        Accesses.Add(function_access.getallspecialitynames);
                        Accesses.Add(function_access.getallteachers);
                        Accesses.Add(function_access.getdepartmentfull);
                        Accesses.Add(function_access.getteacherdiscipline);
                        Accesses.Add(function_access.position_get_all);
                        Accesses.Add(function_access.type_subject_get_all);
                        Accesses.Add(function_access.week_get_all);
                        Accesses.Add(function_access.get_transfers);
                        Accesses.Add(function_access.timetable_get);
                        return true;
                    }
            }
            catch
            {
            }
            #endregion
            #region AdminSpravochnik
            try
            {
                using (var cmd = new NpgsqlCommand("SET ROLE AdminSpravochnik", conn))
                using (var reader = cmd.ExecuteReader())
                    if (reader.Read())
                    {
                        Accesses.Add(function_access.classroom_delete);
                        Accesses.Add(function_access.classroom_get_all);
                        Accesses.Add(function_access.classroom_get_class);
                        Accesses.Add(function_access.classroom_get_housing);
                        Accesses.Add(function_access.add_styding_plans);
                        Accesses.Add(function_access.classroom_add);
                        Accesses.Add(function_access.del_styding_plans);
                        Accesses.Add(function_access.department_add);
                        Accesses.Add(function_access.department_delete);
                        Accesses.Add(function_access.discipline_add);
                        Accesses.Add(function_access.discipline_delete);
                        Accesses.Add(function_access.discipline_get_all);
                        Accesses.Add(function_access.faculty_add);
                        Accesses.Add(function_access.faculty_delete);
                        Accesses.Add(function_access.faculty_get_all);
                        Accesses.Add(function_access.get_groups);
                        Accesses.Add(function_access.get_styding_plans);
                        Accesses.Add(function_access.getalldepartmentnames);
                        Accesses.Add(function_access.getallspeciality);
                        Accesses.Add(function_access.getallspecialitynames);
                        Accesses.Add(function_access.getallteachers);
                        Accesses.Add(function_access.getdepartmentfull);
                        Accesses.Add(function_access.getteacherdiscipline);
                        Accesses.Add(function_access.group_add);
                        Accesses.Add(function_access.group_delete);
                        Accesses.Add(function_access.position_add);
                        Accesses.Add(function_access.position_delete);
                        Accesses.Add(function_access.position_get_all);
                        Accesses.Add(function_access.specialty_add);
                        Accesses.Add(function_access.specialty_delete);
                        Accesses.Add(function_access.teacher_add_discipline);
                        Accesses.Add(function_access.teachers_add);
                        Accesses.Add(function_access.teachersdelete);
                        Accesses.Add(function_access.teachersdelete_all_discipline);
                        Accesses.Add(function_access.type_subject_add);
                        Accesses.Add(function_access.type_subject_delete);
                        Accesses.Add(function_access.type_subject_get_all);
                        Accesses.Add(function_access.week_add);
                        Accesses.Add(function_access.week_delete);
                        Accesses.Add(function_access.week_get_all);
                        Accesses.Add(function_access.timeTable_teachers_add);
                        Accesses.Add(function_access.timeTable_group_add);
                        Accesses.Add(function_access.timeTable_add);
                        Accesses.Add(function_access.timetable_delete);
                        Accesses.Add(function_access.delete_transfer);
                        Accesses.Add(function_access.add_transfer);
                        Accesses.Add(function_access.get_transfers);
                        Accesses.Add(function_access.timetable_get);
                        return true;
                    }
            }
            catch
            {
            }
            #endregion
            return false;
        }
    }
}
