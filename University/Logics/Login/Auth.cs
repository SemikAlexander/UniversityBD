using Npgsql;
using System;
namespace Logics.Login
{
    /// <summary>
    /// Класс авторизации
    /// </summary>
    public class Auth
    {
        /// <summary>
        /// строка ошибки
        /// </summary>
        public string exception = "";
        /// <summary>
        /// Авторизация
        /// </summary>
        /// <param name="login">Логин пользователя</param>
        /// <param name="password">Пароль пользователя</param>
        /// <param name="config">Класс настроек для подключения к бд</param>
        /// <returns>true- если авторизация успешна,false - ошибка(проверять переменную exception). </returns>
        public bool Login(string login, string password, out Functions.Connection.ConnectionDB config)
        {
            config = new Functions.Connection.ConnectionDB();
            if (config.SetLoginPassword(login, password))
            {
                try
                {
                    var conn = new NpgsqlConnection(config.ConnectString);
                    conn.Open();
                    //if (!config.get_access(conn)) return false;
                    conn.Close();
                    return true;
                }
                catch (Exception ex)
                {
                    exception = ex.Message;
                    return false;
                }
            }
            else
            {
                exception = config.exception;
                return false;
            }
        }
    }
}
