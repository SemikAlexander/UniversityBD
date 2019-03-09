using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class Authorization : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        public Authorization()
        {
            InitializeComponent();
        }

        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        #region Design
        private void button2_MouseEnter(object sender, EventArgs e)
        {
            button2.BackColor = Color.Red;
        }
        private void button2_MouseLeave(object sender, EventArgs e)
        {
            button2.BackColor = Color.DeepSkyBlue;
        }
        #endregion

        private void button1_Click(object sender, EventArgs e)
        {
            foreach (Control control in Controls)       /*Проверка на пустоту в textbox*/
            {
                if(control is TextBox)
                {
                    if(control.Text.Trim(' ').Length == 0)
                    {
                        MessageBox.Show("Вы заполнили не все поля!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                }
            }
            /*Функция авторизации*/
            Hide();
            new MainForm().Show();
        }
        private void button3_Click(object sender, EventArgs e)
        {
            new SettingConection().Show();
        }
    }
}