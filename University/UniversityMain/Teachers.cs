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
    public partial class Teachers : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        public Teachers(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            connectionDB = connection;
        }

        #region Design
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        #endregion

        private void Teachers_Load(object sender, EventArgs e)
        {
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            if (faculty.GetAllFaculty(out structFaculties))
            {
                for (int i = 0; i < structFaculties.Count; i++)
                    faculty_choise.Items.Add(structFaculties[i].Name);
            }
            else
            {
                MessageBox.Show(faculty.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                new MainForm(connectionDB).Show();
            }
        }

        private void faculty_choise_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}
