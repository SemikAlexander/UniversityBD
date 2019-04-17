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
    public partial class ChoiseForm : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        public ChoiseForm(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            InitializeComponent();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            Close();
            new TransferPara(connectionDB, "GetTransfers").Show();
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
    }
}