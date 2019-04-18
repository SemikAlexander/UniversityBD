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
        string FacultyForGetTimeTable = "", DepartmentForGetTimeTable = "", NameTeacherForGetTimeTable = "";
        #region Arrays
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructures = new List<Logics.MainTable.Teachers.TeachersStructure>();
        List<Logics.MainTable.Speciality.SpecialtyStructure> specialtyStructures = new List<Logics.MainTable.Speciality.SpecialtyStructure>();
        public List<Logics.MainTable.TimeTable.TimeTableStructure> timeTableStructures = new List<Logics.MainTable.TimeTable.TimeTableStructure>();
        #endregion
        #region Classes
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.Books.Week.Type_Week type_;
        Logics.MainTable.Teachers teachers;
        Logics.MainTable.TimeTable timeTable;
        #endregion
        public ChoiseFaculty_Department_Teacher(Logics.Functions.Connection.ConnectionDB connection)
        {
            teachers = new Logics.MainTable.Teachers(connection);
            timeTable = new Logics.MainTable.TimeTable(connection);
            connectionDB = connection;
            InitializeComponent();
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
            MainForm mainForm = new MainForm(connectionDB);
            mainForm.GetArrayFromChoiseForm(timeTableStructures, TeacherBox.SelectedItem.ToString());
            mainForm.Show();
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                DepartmentBox.Items.Clear();
                FacultyForGetTimeTable = FacultyBox.SelectedItem.ToString();
                departments.GetAllDepartmentNames(FacultyForGetTimeTable, out departments_name);
                foreach (var d_n in departments_name)
                    DepartmentBox.Items.Add(d_n);
            }
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentBox.SelectedItem != null)
            {
                TeacherBox.Items.Clear();
                DepartmentForGetTimeTable = DepartmentBox.SelectedItem.ToString();
                teachers.GetTeachers(FacultyForGetTimeTable, DepartmentForGetTimeTable, out teachersStructures);
                foreach (var teach in teachersStructures)
                    TeacherBox.Items.Add(teach.nameteacher);
            }
        }
        private void TypeWeekBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (TypeWeekBox.SelectedIndex)
            {
                case 0: type_ = Logics.Books.Week.Type_Week.Top; break;
                case 1: type_ = Logics.Books.Week.Type_Week.Bottom; break;
            }
            if(FacultyForGetTimeTable !="" & DepartmentForGetTimeTable !="" & NameTeacherForGetTimeTable != "")
            {
                timeTable.GetTimeTable(FacultyForGetTimeTable, DepartmentForGetTimeTable, NameTeacherForGetTimeTable, type_, out timeTableStructures);
            }

        }
        private void TeacherBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            NameTeacherForGetTimeTable = TeacherBox.SelectedItem.ToString();
        }
        private void ChoiseFaculty_Department_Teacher_Load(object sender, EventArgs e)
        {
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
                FacultyBox.Items.Add(fac.Name);
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
    }
}