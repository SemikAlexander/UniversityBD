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
        ComboBox combo;
        #region Classes
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Teachers teachers;
        Logics.Books.TypeSubject typeSubject;
        Logics.Books.Week week;
        Logics.MainTable.TimeTable timeTable;
        Logics.Books.Faculty faculty;
        Logics.MainTable.Speciality speciality;
        Logics.MainTable.Groups groups;
        Logics.Books.Discipline discipline;
        #endregion
        #region Arrays
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructure = new List<Logics.MainTable.Teachers.TeachersStructure>();
        List<Logics.Books.Week.StructWeek> structWeeks = new List<Logics.Books.Week.StructWeek>();
        List<Logics.Books.TypeSubject.StructTypeSubject> structTypeSubjects = new List<Logics.Books.TypeSubject.StructTypeSubject>();
        List<Logics.MainTable.TimeTable.type_opl_teacher> array_type_Opl = new List<Logics.MainTable.TimeTable.type_opl_teacher>();
        List<Logics.MainTable.TimeTable.TimeTableStructure> arrayTableStructure = new List<Logics.MainTable.TimeTable.TimeTableStructure>();
        List<Logics.MainTable.TimeTable.GROUPSTRUCT> arrayGroupsStruct = new List<Logics.MainTable.TimeTable.GROUPSTRUCT>();
        List<Logics.MainTable.Groups.GroupsStructure> groupsStructures = new List<Logics.MainTable.Groups.GroupsStructure>();
        List<Logics.Books.Discipline.StructDiscipline> structDiscipline = new List<Logics.Books.Discipline.StructDiscipline>();
        #endregion
        #region Structures
        Logics.MainTable.TimeTable.type_opl_teacher type_Opl;
        Logics.MainTable.TimeTable.TimeTableStructure tableStructure;
        Logics.MainTable.TimeTable.GROUPSTRUCT groupsStruct;
        Logics.Books.Classroom.StructClassroom structClassroom;      
        #endregion
        public AddPara(Logics.Functions.Connection.ConnectionDB connection)
        {
            discipline = new Logics.Books.Discipline(connection);
            groups = new Logics.MainTable.Groups(connection);
            speciality = new Logics.MainTable.Speciality(connection);
            faculty = new Logics.Books.Faculty(connection);
            timeTable = new Logics.MainTable.TimeTable(connection);
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
            Logics.Books.Classroom classroom = new Logics.Books.Classroom(connectionDB);
            List<int> HOUSING = new List<int>();
            classroom.GetAllHousign(out HOUSING);
            foreach (var house in HOUSING)
                HousingBox.Items.Add(house);
            week.GetAllWeek(out structWeeks);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
            {
                FacultyBox.Items.Add(fac.Name);
                FacultyBox2.Items.Add(fac.Name);
                FacultyForDisciplineBox.Items.Add(fac.Name);
            }
            typeSubject.GetAllTypeSubjects(out structTypeSubjects);
            List<Logics.Books.Faculty.StructFaculty> structFACULTY = new List<Logics.Books.Faculty.StructFaculty>();
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
                    type_Opl.name_teacher = "";
                    type_Opl.faculty = "";
                    type_Opl.department = "";
                    TeacherInfo.CurrentRow.Cells[2].Value = null;
                }
                else if (TeacherInfo.CurrentRow.Cells[1].Value == null)
                {
                    TeacherInfo.CurrentRow.Cells[1].Value = true;
                    type_Opl.name_teacher = TeacherInfo.Rows[e.RowIndex].Cells[0].Value.ToString();
                    type_Opl.faculty = FacultyBox.SelectedItem.ToString();
                    type_Opl.department = DepartmentBox.SelectedItem.ToString();
                }
            }
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn & senderGrid.Columns[e.ColumnIndex].Name == "Pochasovka" && e.RowIndex >= 0)
            {
                if (TeacherInfo.CurrentRow.Cells[1].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                {
                    if (TeacherInfo.CurrentRow.Cells[2].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                    {
                        TeacherInfo.CurrentRow.Cells[2].Value = false;
                        TeacherInfo.CurrentRow.Cells[2].Value = null;
                    }
                    else if (TeacherInfo.CurrentRow.Cells[2].Value == null)
                    {
                        TeacherInfo.CurrentRow.Cells[2].Value = true;
                        type_Opl.type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Pochasovka;
                        array_type_Opl.Add(type_Opl);
                        TeacherInfo.CurrentRow.Cells[3].Value = false;
                        TeacherInfo.CurrentRow.Cells[3].Value = null;
                    }
                }
                else
                {
                    TeacherInfo.CurrentRow.Cells[1].Value = false;
                    TeacherInfo.CurrentRow.Cells[1].Value = null;
                    TeacherInfo.CurrentRow.Cells[2].Value = false;
                    TeacherInfo.CurrentRow.Cells[2].Value = null;
                    TeacherInfo.CurrentRow.Cells[3].Value = false;
                    TeacherInfo.CurrentRow.Cells[3].Value = null;
                }
            }
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn & senderGrid.Columns[e.ColumnIndex].Name == "Stavka" && e.RowIndex >= 0)
            {
                if (TeacherInfo.CurrentRow.Cells[1].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                {
                    if (TeacherInfo.CurrentRow.Cells[3].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                    {
                        TeacherInfo.CurrentRow.Cells[3].Value = false;
                        TeacherInfo.CurrentRow.Cells[3].Value = null;
                    }
                    else if (TeacherInfo.CurrentRow.Cells[3].Value == null)
                    {
                        TeacherInfo.CurrentRow.Cells[3].Value = true;
                        type_Opl.type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Stavka;
                        array_type_Opl.Add(type_Opl);
                        TeacherInfo.CurrentRow.Cells[2].Value = false;
                        TeacherInfo.CurrentRow.Cells[2].Value = null;
                    }
                }
                else
                {
                    TeacherInfo.CurrentRow.Cells[1].Value = false;
                    TeacherInfo.CurrentRow.Cells[1].Value = null;
                    TeacherInfo.CurrentRow.Cells[2].Value = false;
                    TeacherInfo.CurrentRow.Cells[2].Value = null;
                    TeacherInfo.CurrentRow.Cells[3].Value = false;
                    TeacherInfo.CurrentRow.Cells[3].Value = null;
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
                        if (tSub.typelesson == Logics.Books.TypeSubject.type_lesson.Session)
                        {
                            TypeSubjectBox.Items.Add(tSub.name);
                        }
                    break;
                case 1:
                    foreach (var tSub in structTypeSubjects)
                        if (tSub.typelesson == Logics.Books.TypeSubject.type_lesson.Study)
                        {
                            TypeSubjectBox.Items.Add(tSub.name);
                        }
                    break;
            }
        }
        private void Button3_Click(object sender, EventArgs e)
        {

        }
        private void HousingBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (HousingBox.SelectedItem != null)
            {
                Logics.Books.Classroom classroom = new Logics.Books.Classroom(connectionDB);
                List<int> classes = new List<int>();
                ClassRoomBox.Items.Clear();
                classroom.GetAllClass(int.Parse(HousingBox.SelectedItem.ToString()), out classes);
                foreach (var cl in classes)
                    ClassRoomBox.Items.Add(cl);
            }
        }
        private void FacultyBox2_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            DepartmentBox2.Items.Clear();
            Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
            List<string> departmentsName = new List<string>();
            departments.GetAllDepartmentNames(FacultyBox2.SelectedItem.ToString(), out departmentsName);
            foreach (var dep in departmentsName)
                DepartmentBox2.Items.Add(dep);
        }
        private void DepartmentBox2_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            SpecialityBox.Items.Clear();
            List<string> specialityName = new List<string>();
            speciality.GetAllSpecialityNames(FacultyBox2.SelectedItem.ToString(), DepartmentBox2.SelectedItem.ToString(), out specialityName);
            foreach (var spec in specialityName)
                SpecialityBox.Items.Add(spec);
        }
        private void SpecialityBox_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            GroupsInfo.Rows.Clear();
            groups.GetGroups(FacultyBox2.SelectedItem.ToString(), DepartmentBox2.SelectedItem.ToString(), SpecialityBox.SelectedItem.ToString(), out groupsStructures);
            foreach (var gr in groupsStructures)
            {
                string year = Convert.ToString(gr.YearCreate);
                GroupsInfo.Rows.Add(SpecialityBox.SelectedItem.ToString() + " " + year[year.Length - 2] + year[year.Length - 1] + " " + gr.Subname, gr.YearCreate);
            }
        }
        private void GroupsInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn & senderGrid.Columns[e.ColumnIndex].Name == "GroupOnLesson" && e.RowIndex >= 0)
            {
                if (GroupsInfo.CurrentRow.Cells[2].Value != null && (bool)GroupsInfo.CurrentRow.Cells[2].Value == true)
                {
                    GroupsInfo.CurrentRow.Cells[2].Value = false;
                    GroupsInfo.CurrentRow.Cells[2].Value = null;
                    TeacherForLesson.Remove(GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                }
                else if (GroupsInfo.CurrentRow.Cells[2].Value == null)
                {
                    GroupsInfo.CurrentRow.Cells[2].Value = true;
                    TeacherForLesson.Add(GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                }
            }
        }
        private void DepartmentForDisciplineBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            discipline.GetAllDiscipline(FacultyForDisciplineBox.SelectedItem.ToString(), DepartmentForDisciplineBox.SelectedItem.ToString(), 0, 20, out structDiscipline);
            foreach (var discipline in structDiscipline)
                DisciplineBox.Items.Add(discipline.name);
        }
        private void FacultyForDisciplineBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
            List<string> nameDepartments = new List<string>();
            departments.GetAllDepartmentNames(FacultyForDisciplineBox.SelectedItem.ToString(), out nameDepartments);
            foreach (var dep in nameDepartments)
                DepartmentForDisciplineBox.Items.Add(dep);
        }
    }
}