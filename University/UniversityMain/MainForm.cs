using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class MainForm : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        bool WindowMaximize = true;
        public MainForm()
        {
            InitializeComponent();
        }
        #region Design
        private void button1_Click(object sender, EventArgs e)      /*Создать форму под сообщения типа MessageBox*/
        {
            Application.Exit();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }      
        private void button3_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Maximized;
        }
        #endregion
        private void button1_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void button3_Click_1(object sender, EventArgs e)
        {
            if (WindowMaximize)
            {
                WindowState = FormWindowState.Maximized;
                WindowMaximize = false;
            }
            else
            {
                WindowState = FormWindowState.Normal;
                WindowMaximize = true;
            }
        }
        private void button2_Click_1(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
    }
}