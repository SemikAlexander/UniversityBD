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
        Logics.MainTable.Departments.DepartmentsStructure structure;
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
                OutputFacultyBox.Items.Add(fac.Name);
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
            DepartmentInfo.Rows.Clear();
            departments.GetDepartments(OutputFacultyBox.SelectedItem.ToString(), StartRow, 20, out departmentsStructures);
            foreach (var dep in departmentsStructures)
                DepartmentInfo.Rows.Add(dep.Name_Department, dep.Housing, dep.Num_Classroom);
        }

        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void HousingBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Logics.Books.Classroom classroom = new Logics.Books.Classroom(connectionDB);
            /*Ф-я вывода всех аудиторий*/
        }
        private void button5_Click(object sender, EventArgs e)
        {
            if(InputNameDepartment.Text.Trim(' ').Length!=0 & FacultyBox.SelectedItem!=null & HousingBox.SelectedItem!=null & ClassroomBox.SelectedItem != null)
            {
                structure.Name_Department = InputNameDepartment.Text;
                structure.Housing = int.Parse(HousingBox.SelectedItem.ToString());
                structure.Num_Classroom = int.Parse(ClassroomBox.SelectedItem.ToString());
                structure.Logo_Department = LogoBox.Image;
                if (!departments.AddDepartment(structure, FacultyBox.SelectedItem.ToString()))
                {
                    MessageBox.Show(departments.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    DepartmentInfo.Rows.Clear();
                    FacultyBox.SelectedItem = HousingBox.SelectedItem = ClassroomBox.SelectedItem = LogoBox.Image = null;
                    InputNameDepartment.Clear();
                    departments.GetDepartments(OutputFacultyBox.SelectedItem.ToString(), StartRow, 20, out departmentsStructures);
                    foreach (var dep in departmentsStructures)
                        DepartmentInfo.Rows.Add(dep.Name_Department, dep.Housing, dep.Num_Classroom);
                }
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            OpenFileDialog open_dialog = new OpenFileDialog(); //создание диалогового окна для выбора файла
            open_dialog.Filter = "Image Files(*.JPG;*.PNG)|*.JPG;*.PNG|All files (*.*)|*.*"; //формат загружаемого файла
            if (open_dialog.ShowDialog() == DialogResult.OK) //если в окне была нажата кнопка "ОК"
            {
                try
                {
                    LogoBox.Image = new Bitmap(open_dialog.FileName);
                }
                catch
                {
                    DialogResult rezult = MessageBox.Show("Невозможно открыть выбранный файл",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void DepartmentInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteDepartment" & e.RowIndex >= 0)
            {
                string DelDep = (string)DepartmentInfo.Rows[e.RowIndex].Cells[0].Value;
                string DelFac = OutputFacultyBox.SelectedItem.ToString();
                departments.Delete(DelDep, DelFac);
                DepartmentInfo.Rows.Clear();
                departments.GetDepartments(OutputFacultyBox.SelectedItem.ToString(), StartRow, 20, out departmentsStructures);
                foreach (var dep in departmentsStructures)
                    DepartmentInfo.Rows.Add(dep.Name_Department, dep.Housing, dep.Num_Classroom);
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
    }
}