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
        Logics.MainTable.Speciality.SpecialtyStructure structure;
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
            {
                comboBox1.Items.Add(fac.Name);
                FacultyBox.Items.Add(fac.Name);
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
            if (comboBox1.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                comboBox2.Items.Clear();
                departments.GetAllDepartmentNames(comboBox1.SelectedItem.ToString(), out departments_name);
                foreach (var d_n in departments_name)
                    comboBox2.Items.Add(d_n);
            }
        }
        private void SpecialitiesInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteSpeciality" & e.RowIndex >= 0)
            {
                string DelDep = comboBox2.SelectedItem.ToString();
                string DelFac = comboBox1.SelectedItem.ToString();
                string DelAbrv= (string)SpecialitiesInfo.Rows[e.RowIndex].Cells[1].Value;
                speciality.Delete(DelDep, DelFac, DelAbrv);
                SpecialitiesInfo.Rows.Clear();
                speciality.GetSpeciality(comboBox1.SelectedItem.ToString(), comboBox2.SelectedItem.ToString(), StartRow, 20, out specialtyStructures);
                foreach (var spec in specialtyStructures)
                    SpecialitiesInfo.Rows.Add(spec.Name_Specialty, spec.Abbreviation_Specialty, spec.Cipher_Specialty);
            }
        }
        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox2.SelectedItem != null)
            {
                SpecialitiesInfo.Rows.Clear();
                speciality.GetSpeciality(comboBox1.SelectedItem.ToString(), comboBox2.SelectedItem.ToString(), StartRow, 20, out specialtyStructures);
                foreach (var spec in specialtyStructures)
                    SpecialitiesInfo.Rows.Add(spec.Name_Specialty, spec.Abbreviation_Specialty, spec.Cipher_Specialty);
            }
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                DepartmentBox.Items.Clear();
                departments.GetAllDepartmentNames(comboBox1.SelectedItem.ToString(), out departments_name);
                foreach (var d_n in departments_name)
                    DepartmentBox.Items.Add(d_n);
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {
            if (InputNameSpeciality.Text.Trim(' ').Length != 0 & textBox1.Text.Trim(' ').Length != 0 & textBox2.Text.Trim(' ').Length != 0 & FacultyBox.SelectedItem!=null & DepartmentBox.SelectedItem != null)
            {
                structure.Name_Specialty = InputNameSpeciality.Text;
                structure.Abbreviation_Specialty = textBox1.Text;
                structure.Cipher_Specialty = textBox2.Text;
                if (!speciality.Add(structure, FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString()))
                {
                    MessageBox.Show(speciality.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    SpecialitiesInfo.Rows.Clear();
                    InputNameSpeciality.Clear();
                    textBox1.Clear();
                    textBox2.Clear();
                    FacultyBox.SelectedItem = DepartmentBox.SelectedItem = null;
                    speciality.GetSpeciality(comboBox1.SelectedItem.ToString(), comboBox2.SelectedItem.ToString(), StartRow, 20, out specialtyStructures);
                    foreach (var spec in specialtyStructures)
                        SpecialitiesInfo.Rows.Add(spec.Name_Specialty, spec.Abbreviation_Specialty, spec.Cipher_Specialty);
                }
            }
        }
    }
}