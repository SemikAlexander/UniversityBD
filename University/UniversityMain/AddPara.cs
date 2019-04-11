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
    public partial class AddPara : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        public List<string> TeacherForLesson = new List<string>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Teachers teachers;
        Logics.Books.TypeSubject typeSubject;
        Logics.Books.Week week;
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructure = new List<Logics.MainTable.Teachers.TeachersStructure>();
        List<Logics.Books.Week.StructWeek> structWeeks = new List<Logics.Books.Week.StructWeek>();
        List<Logics.Books.TypeSubject.StructTypeSubject> structTypeSubjects = new List<Logics.Books.TypeSubject.StructTypeSubject>();
        public AddPara(Logics.Functions.Connection.ConnectionDB connection)
        {
            week = new Logics.Books.Week(connection);
            typeSubject = new Logics.Books.TypeSubject(connection);
            teachers = new Logics.MainTable.Teachers(connection);
            connectionDB = connection;
            InitializeComponent();
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
        private void AddPara_Load(object sender, EventArgs e)
        {
            week.GetAllWeek(out structWeeks);
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
                FacultyBox.Items.Add(fac.Name);
            typeSubject.GetAllTypeSubjects(out structTypeSubjects);
        }
        private void ComboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            WeekDayBox.Items.Clear();
            switch (TypeWeekBox.SelectedIndex)
            {
                case 0:
                    foreach(var strWeek in structWeeks)
                        if (strWeek.type == Logics.Books.Week.Type_Week.Top)
                            WeekDayBox.Items.Add(strWeek.name_day);
                    break;
                case 1:
                    foreach (var strWeek in structWeeks)
                        if (strWeek.type == Logics.Books.Week.Type_Week.Bottom)
                            WeekDayBox.Items.Add(strWeek.name_day);
                    break;
            }
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
            List<string> nameDepartments = new List<string>();
            departments.GetAllDepartmentNames(FacultyBox.SelectedItem.ToString(), out nameDepartments);
            foreach (var dep in nameDepartments)
                DepartmentBox.Items.Add(dep);
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            TeacherInfo.Rows.Clear();
            teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructure);
            foreach (var teach in teachersStructure)
                TeacherInfo.Rows.Add(teach.nameteacher);
        }
        private void TeacherInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn & senderGrid.Columns[e.ColumnIndex].Name == "ChoiseTeacher" && e.RowIndex >= 0)
            {
                if (TeacherInfo.CurrentRow.Cells[1].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                {
                    TeacherInfo.CurrentRow.Cells[1].Value = false;
                    TeacherInfo.CurrentRow.Cells[1].Value = null;
                    TeacherForLesson.Remove(TeacherInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                }
                else if (TeacherInfo.CurrentRow.Cells[1].Value == null)
                {
                    TeacherInfo.CurrentRow.Cells[1].Value = true;
                    TeacherForLesson.Add(TeacherInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                    ComboBox CB = new ComboBox();
                    CB.Items.Add("Почасовка");
                    CB.Items.Add("Ставка");
                    ((DataGridViewComboBoxColumn)TeacherInfo.Columns["TypeOpl"]).DataSource = CB.Items;
                }
            }
        }
        private void ComboBox1_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            TypeSubjectBox.Items.Clear();
            switch (TypeLessonsBox.SelectedIndex)
            {
                case 0:
                    foreach (var tSub in structTypeSubjects)
                        if(tSub.typelesson==Logics.Books.TypeSubject.type_lesson.Session)
                            TypeSubjectBox.Items.Add(tSub.name);
                    break;
                case 1:
                    foreach (var tSub in structTypeSubjects)
                        if (tSub.typelesson == Logics.Books.TypeSubject.type_lesson.Study)
                            TypeSubjectBox.Items.Add(tSub.name);
                    break;
            }
        }
    }
}