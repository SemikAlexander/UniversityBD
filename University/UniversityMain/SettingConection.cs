using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class SettingConection : Form
    {
        Logics.Functions.Connection.ConnectionDB connection = new Logics.Functions.Connection.ConnectionDB();
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        public SettingConection()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Hide();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Logics.Functions.Connection.ConnectionDB.Connection connectionStruct;
            connectionStruct.ip = ip_adress.Text;
            connectionStruct.port = port.Text;
            connectionStruct.dbname = nameDB.Text;
            if (connection.updateSettings(connectionStruct))
            {
                MessageBox.Show("Изменения сохранены!", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                Close();
            }
            else
                MessageBox.Show(connection.exception, Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        #region Design
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button2_MouseEnter(object sender, EventArgs e)
        {
            button2.BackColor = Color.Red;
        }
        private void button2_MouseLeave(object sender, EventArgs e)
        {
            button2.BackColor = Color.DeepSkyBlue;
        }        
        private void login_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8 && e.KeyChar != 46)
                e.Handled = true;
        }
        private void password_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8)
                e.Handled = true;
        }
        private void SettingConection_Load(object sender, EventArgs e)
        {
            if (connection.ConfigConnection.ip == null)
            {
                MessageBox.Show(connection.exception, Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
                Close();
            }
            else
            {
                ip_adress.Text = connection.ConfigConnection.ip;
                port.Text = connection.ConfigConnection.port;
                nameDB.Text = connection.ConfigConnection.dbname;
            }
        }
        #endregion
    }
}
