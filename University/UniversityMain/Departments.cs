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
    public partial class Departments : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        List<Logics.MainTable.Departments.DepartmentsStructure> departmentsStructures = new List<Logics.MainTable.Departments.DepartmentsStructure>();
        List<string> NameDep = new List<string>();
        Logics.MainTable.Departments departments;
        int StartRow = 0;
        public Departments(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            departments = new Logics.MainTable.Departments(connection);
            InitializeComponent();
        }

        private void Departments_Load(object sender, EventArgs e)
        {
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            Logics.Books.Classroom classroom = new Logics.Books.Classroom(connectionDB);
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<int> HOUSING = new List<int>();
            faculty.GetAllFaculty(out structFaculties);
            classroom.GetAllHousign(out HOUSING);
            foreach (var fac in structFaculties)
            {
                FacultyBox.Items.Add(fac.Name);
                OutputDepartmentBox.Items.Add(fac.Name);
            }
            foreach (var house in HOUSING)
                HousingBox.Items.Add(house);
        }

        private void DownButton_Click(object sender, EventArgs e)
        {

        }

        private void UpButton_Click(object sender, EventArgs e)
        {

        }

        private void Classroom_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void OutputDepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            departments.GetDepartments(OutputDepartmentBox.SelectedItem.ToString(), StartRow, 20, out departmentsStructures);
            foreach (var dep in departmentsStructures)
                DepartmentInfo.Rows.Add(dep.Name_Department, dep.Housing, dep.Num_Classroom);
        }

        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
    }
}