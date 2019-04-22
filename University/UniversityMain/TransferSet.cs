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
    public partial class TransferSet : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(IntPtr hwnd, int wmsg, int wparam, int lparam);
        int TimeTableData;
        #region Classes
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Transfers transfers;
        #endregion
        public TransferSet(Logics.Functions.Connection.ConnectionDB connection, int IDLesson)
        {
            InitializeComponent();
            TimeTableData = IDLesson;
            transfers = new Logics.MainTable.Transfers(connection);
            connectionDB = connection;
        }

        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void PictureBox1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Label4_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void AddParaInTimeTable_Click(object sender, EventArgs e)
        {
            if(!transfers.Add(TimeTableData, StartSomething.Value.Date, StopSomithing.Value.Date, (int)NumPara.Value))
            {
                MessageBox.Show(transfers.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            else
            {
                MessageBox.Show("Перенос добавлен!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Close();
            }
        }
    }
}
