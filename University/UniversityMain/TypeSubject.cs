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
    public partial class TypeSubject : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.Books.TypeSubject.StructTypeSubject> structTypeSubjects = new List<Logics.Books.TypeSubject.StructTypeSubject>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.Books.TypeSubject type;
        Logics.Books.TypeSubject.type_lesson type_Lesson;
        public TypeSubject(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            type = new Logics.Books.TypeSubject(connectionDB);
            InitializeComponent();
        }

        private void TypeSubject_Load(object sender, EventArgs e)
        {
            try
            {
                type.GetAllTypeSubjects(out structTypeSubjects);
                foreach (var str in structTypeSubjects)
                    SubjectInfo.Rows.Add(str.id, str.name);
            }
            catch (Exception)
            {
                MessageBox.Show(type.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                Close();
                new MainForm(connectionDB).Show();
            }
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
        private void SubjectInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteSubject" && e.RowIndex >= 0)
            {
                int ID_Delete = (int)SubjectInfo.Rows[e.RowIndex].Cells[0].Value;
                type.DeleteTypeSubject(ID_Delete);
                SubjectInfo.Rows.Clear();
                structTypeSubjects.Clear();
                type.GetAllTypeSubjects(out structTypeSubjects);
                foreach (var str in structTypeSubjects)
                    SubjectInfo.Rows.Add(str.id, str.name);
            }
        }
        private void button4_Click(object sender, EventArgs e)
        {
            if (InputSubject.Text.Trim(' ').Length != 0 & TypeSub.SelectedItem != null)
            {
                switch (TypeSub.SelectedIndex)
                {
                    case 0: type_Lesson = Logics.Books.TypeSubject.type_lesson.Session; break;
                    case 1: type_Lesson = Logics.Books.TypeSubject.type_lesson.Study; break;
                }
                if (!type.AddTypeSubject(InputSubject.Text, type_Lesson: type_Lesson))
                {
                    MessageBox.Show(type.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    InputSubject.Clear();
                    SubjectInfo.Rows.Clear();
                    structTypeSubjects.Clear();
                    try
                    {
                        type.GetAllTypeSubjects(out structTypeSubjects);
                        foreach (var str in structTypeSubjects)
                            SubjectInfo.Rows.Add(str.id, str.name);
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(type.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        Close();
                        new MainForm(connectionDB).Show();
                    }
                }
            }
        }
    }
}