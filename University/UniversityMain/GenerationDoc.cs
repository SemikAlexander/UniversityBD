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
    public partial class GenerationDoc : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Teachers teachers;
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructures = new List<Logics.MainTable.Teachers.TeachersStructure>();
        string FacultyForGeneration = "", DepartmentForGeneration = "", NameTeacherForGeneration = "";
        public GenerationDoc(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            teachers = new Logics.MainTable.Teachers(connection);
            connectionDB = connection;
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                DepartmentBox.Items.Clear();
                FacultyForGeneration = FacultyBox.SelectedItem.ToString();
                departments.GetAllDepartmentNames(FacultyForGeneration, out departments_name);
                foreach (var d_n in departments_name)
                    DepartmentBox.Items.Add(d_n);
            }
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentBox.SelectedItem != null)
            {
                TeacherBox.Items.Clear();
                DepartmentForGeneration = DepartmentBox.SelectedItem.ToString();
                teachers.GetTeachers(FacultyForGeneration, DepartmentForGeneration, out teachersStructures);
                foreach (var teach in teachersStructures)
                    TeacherBox.Items.Add(teach.nameteacher);
            }
        }
        private void TeacherBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            NameTeacherForGeneration = TeacherBox.SelectedItem.ToString();
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Label4_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button3_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
            folderBrowserDialog.RootFolder = Environment.SpecialFolder.Desktop;
            folderBrowserDialog.Description = "Выберите папку";
            folderBrowserDialog.ShowNewFolderButton = false;
            if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                FolderPath.Text = folderBrowserDialog.SelectedPath;
        }
        private void Button4_Click(object sender, EventArgs e)
        {

        }
        private void GenerationDoc_Load(object sender, EventArgs e)
        {
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
                FacultyBox.Items.Add(fac.Name);
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
    }
}