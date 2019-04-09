using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace UniversityMain
{
    public partial class ChoiseFaculty_Department_Teacher : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.MainTable.Teachers.TeachersStructure structure;
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructures = new List<Logics.MainTable.Teachers.TeachersStructure>();
        List<Logics.MainTable.Speciality.SpecialtyStructure> specialtyStructures = new List<Logics.MainTable.Speciality.SpecialtyStructure>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Teachers teachers;
        Logics.MainTable.Speciality speciality;
        public ChoiseFaculty_Department_Teacher(Logics.Functions.Connection.ConnectionDB connection)
        {
            teachers = new Logics.MainTable.Teachers(connection);
            speciality = new Logics.MainTable.Speciality(connection);
            connectionDB = connection;
            InitializeComponent();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                DepartmentBox.Items.Clear();
                departments.GetAllDepartmentNames(FacultyBox.SelectedItem.ToString(), out departments_name);
                foreach (var d_n in departments_name)
                    DepartmentBox.Items.Add(d_n);
            }
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentBox.SelectedItem != null)
            {
                MainForm mainForm = new MainForm(connectionDB);
                mainForm.ParaInfo.Rows.Clear();
                teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructures);
                foreach (var teach in teachersStructures)
                    mainForm.ParaInfo.Rows.Add(teach.nameteacher, teach.nameposition, teach.emaildata);
            }
        }
        private void TeacherBox_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private void ChoiseFaculty_Department_Teacher_Load(object sender, EventArgs e)
        {
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
            {
                FacultyBox.Items.Add(fac.Name);
            }
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
    }
}