﻿using System;
using System.Drawing;
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
            Logics.Functions.Connection.ConnectionDB connection;
            Logics.Login.Auth authorizationUser= new Logics.Login.Auth();
            if (authorizationUser.Login(login.Text.Trim(' '), password.Text.Trim(' '), out connection))
            {
                Hide();
                new MainForm(connection).Show();
            }
            else
                MessageBox.Show(authorizationUser.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);           
        }
        private void button3_Click(object sender, EventArgs e)
        {
            new SettingConection().Show();
        }
    }
}