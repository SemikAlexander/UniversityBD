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
    public partial class Faculty : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        bool WindowMaximize = true;
        public Faculty()
        {
            InitializeComponent();
        }
        #region Deisgn
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button3_Click(object sender, EventArgs e)
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
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm().Show();
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        #endregion
    }
}