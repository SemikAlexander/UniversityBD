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
    public partial class Specialities : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.MainTable.Speciality.SpecialtyStructure> specialtyStructures = new List<Logics.MainTable.Speciality.SpecialtyStructure>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Speciality speciality;
        int StartRow = 0;
        public Specialities(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            speciality = new Logics.MainTable.Speciality(connection);
            InitializeComponent();
        }

        private void Specialities_Load(object sender, EventArgs e)
        {
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
                FacultyBox.Items.Add(fac.Name);
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
        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8 && e.KeyChar != 46)
                e.Handled = true;
        }
        private void DownButton_Click(object sender, EventArgs e)
        {

        }
        private void UpButton_Click(object sender, EventArgs e)
        {

        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SpecialitiesInfo.Rows.Clear();
            speciality.GetSpeciality(comboBox1.SelectedItem.ToString(), comboBox2.SelectedItem.ToString(), StartRow, 20, out specialtyStructures);
            foreach (var spec in specialtyStructures)
                SpecialitiesInfo.Rows.Add(spec.Name_Specialty, spec.Abbreviation_Specialty, spec.Cipher_Specialty);
        }
        private void SpecialitiesInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteSpeciality" & e.RowIndex >= 0)
            {
                //string DelDep = (string)DepartmentInfo.Rows[e.RowIndex].Cells[0].Value;
                //string DelFac = OutputFacultyBox.SelectedItem.ToString();
                //departments.Delete(DelDep, DelFac);
                //DepartmentInfo.Rows.Clear();
                //departments.GetDepartments(OutputFacultyBox.SelectedItem.ToString(), StartRow, 20, out departmentsStructures);
                //foreach (var dep in departmentsStructures)
                //    DepartmentInfo.Rows.Add(dep.Name_Department, dep.Housing, dep.Num_Classroom);
            }
        }
    }
}
