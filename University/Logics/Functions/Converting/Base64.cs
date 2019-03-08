


using System;
using System.Drawing;
using System.IO;
using System.Text;

namespace Logics.Functions.Converting
{
    /// <summary>
    /// Класс шифрования base64
    /// </summary>
    public static class Base64
    {
        private static string base64String = null;
        /// <summary>
        /// Картинка в base64
        /// </summary>
        /// <param name="image">Исходная картинка</param>
        /// <returns>base64 строка или null</returns>
        public static string encodeImage(Image image)
        {
            using (MemoryStream m = new MemoryStream())
            {
                image.Save(m, image.RawFormat);
                byte[] imageBytes = m.ToArray();
                base64String = Convert.ToBase64String(imageBytes);
                return base64String;
            }
        }
        /// <summary>
        /// Картинка в base64
        /// </summary>
        /// <param name="image_path">путь к картинке на диске</param>
        /// <returns>base64 строка</returns>
        public static string encodeImageFromPath(string image_path)
        {
            if (!File.Exists(image_path)) return null;
            using (System.Drawing.Image image = System.Drawing.Image.FromFile(image_path))
            {
                using (MemoryStream m = new MemoryStream())
                {
                    image.Save(m, image.RawFormat);
                    byte[] imageBytes = m.ToArray();
                    base64String = Convert.ToBase64String(imageBytes);
                    return base64String;
                }
            }
        }
        /// <summary>
        /// строка в base64
        /// </summary>
        /// <param name="value">исходная строка</param>
        /// <returns>base64 строка</returns>
        public static string encodeString(string value)
        {
            return Convert.ToBase64String(Encoding.ASCII.GetBytes(value));
        }
        /// <summary>
        /// Из base64 в картинку
        /// </summary>
        /// <param name="value">base64 строка</param>
        /// <returns>Image</returns>
        public static Image decodeImage(string value)
        {
            byte[] imageBytes = Convert.FromBase64String(value);
            MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
            ms.Write(imageBytes, 0, imageBytes.Length);
            System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
            return image;
        }
        /// <summary>
        /// base64 в строку
        /// </summary>
        /// <param name="value">base64 строка</param>
        /// <returns>обычная строка</returns>
        public static string decodeString(string value)
        {
            return System.Text.Encoding.UTF8.GetString( Convert.FromBase64String(value));
        }
    }
}
