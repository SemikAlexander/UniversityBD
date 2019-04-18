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
    public partial class TransferPara : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        string workWithForm = "";
        public TransferPara(Logics.Functions.Connection.ConnectionDB connection, string TypeForm)
        {
            workWithForm = TypeForm;
            connectionDB = connection;
            InitializeComponent();
        }

        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            new MainForm(connectionDB).Show();
            Close();
        }
        private void TransferPara_Load(object sender, EventArgs e)
        {
            /*Передаю факультет, кафедру, имя преподавателя*/
        }
    }
}