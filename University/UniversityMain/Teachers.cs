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
        Logics.MainTable.Teachers teachers;
        public List<string> teacherDiscipline = new List<string>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Teachers.TeachersStructure structure;
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructures = new List<Logics.MainTable.Teachers.TeachersStructure>();
        public Teachers(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            connectionDB = connection;
            teachers = new Logics.MainTable.Teachers(connection);
        }
        #region Design
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            new MainForm(connectionDB).Show();
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
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
            {
                FacultyBox.Items.Add(fac.Name);
                FacultyInputBox.Items.Add(fac.Name);
            }
            List<Logics.Books.Position.StructPosition> structPositions = new List<Logics.Books.Position.StructPosition>();
            Logics.Books.Position position = new Logics.Books.Position(connectionDB);
            position.GetAllPositions(out structPositions);
            foreach (var pos in structPositions)
                PositionBox.Items.Add(pos.name);
        }
        private void faculty_choise_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                DepartmentBox.Items.Clear();
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departmentsName = new List<string>();
                departments.GetAllDepartmentNames(FacultyBox.SelectedItem.ToString(), out departmentsName);
                foreach (var dep in departmentsName)
                    DepartmentBox.Items.Add(dep);
            }
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentBox.SelectedItem != null)
            {
                TeacherInfo.Rows.Clear();
                teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructures);
                foreach (var teach in teachersStructures)
                    TeacherInfo.Rows.Add(teach.nameteacher, teach.nameposition, teach.emaildata);
            }
        }
        private void TeacherInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteTeacher" && e.RowIndex >= 0)
            {
                string NameTeacher = (string)TeacherInfo.Rows[e.RowIndex].Cells[0].Value;
                teachers.Delete(DepartmentBox.SelectedItem.ToString(), FacultyBox.SelectedItem.ToString(), NameTeacher);
                TeacherInfo.Rows.Clear();
                teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructures);
                foreach (var teach in teachersStructures)
                    TeacherInfo.Rows.Add(teach.nameteacher, teach.nameposition, teach.emaildata);
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {
            if(textBox3.Text.Length!=0 & InputRating.Text.Length!=0 & FacultyInputBox.SelectedItem!=null & DepartmentInputBox.SelectedItem!=null & textBox1.Text.Length!=0 & EmailTeacher.Text.Length!=0 & PositionBox.SelectedItem != null)
            {

                if (IsValidEmail(EmailTeacher.Text))
                {
                    structure.nameteacher = textBox1.Text;
                    structure.nameposition = PositionBox.SelectedItem.ToString();
                    structure.emaildata = EmailTeacher.Text;
                    structure.rating = float.Parse(InputRating.Text);
                    structure.hourlypayment = float.Parse(textBox3.Text);
                    if (teachers.Add(structure, FacultyInputBox.SelectedItem.ToString(), DepartmentInputBox.SelectedItem.ToString()))
                    {
                        textBox3.Clear();
                        InputRating.Clear();
                        FacultyInputBox.SelectedItem = null;
                        DepartmentInputBox.SelectedItem = null;
                        textBox1.Clear();
                        EmailTeacher.Clear();
                        PositionBox.SelectedItem = null;
                        TeacherInfo.Rows.Clear();
                        if(FacultyBox.SelectedItem!=null & DepartmentBox.SelectedItem != null)
                        {
                            teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructures);
                            foreach (var teach in teachersStructures)
                                TeacherInfo.Rows.Add(teach.nameteacher, teach.nameposition, teach.emaildata);
                        }
                    }
                    else
                    {
                        MessageBox.Show(teachers.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
                else
                {
                    MessageBox.Show("Email неверный!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
        }
        private void InputYearEntry_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8 && e.KeyChar != 46)
                e.Handled = true;
        }
        private void textBox3_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8 && e.KeyChar != 46)
                e.Handled = true;
        }
        private void FacultyInputBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyInputBox.SelectedItem != null)
            {
                DepartmentInputBox.Items.Clear();
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departmentsName = new List<string>();
                departments.GetAllDepartmentNames(FacultyInputBox.SelectedItem.ToString(), out departmentsName);
                foreach (var dep in departmentsName)
                    DepartmentInputBox.Items.Add(dep);
            }
        }
        bool IsValidEmail(string email)
        {
            try
            {
                var adress = new System.Net.Mail.MailAddress(email);
                return adress.Address == email;
            }
            catch (Exception)
            {
                return false;
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            if (FacultyInputBox.SelectedItem!=null & DepartmentInputBox.SelectedItem!=null)
            {
                ChoiseDiscipline choiseDiscipline = new ChoiseDiscipline(connectionDB, FacultyInputBox.SelectedItem.ToString(), DepartmentInputBox.SelectedItem.ToString());
                choiseDiscipline.Show();
            }
        }
    }
}