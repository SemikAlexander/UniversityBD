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
        private extern static void SendMessage(IntPtr hwnd, int wmsg, int wparam, int lparam);
        public List<string> NameTeacherForPara = new List<string>();
        bool ChoiseTypePayForTeacher = false;
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
        Logics.Books.Classroom classroom;
        #endregion
        #region Arrays
        List<int> classes = new List<int>();
        List<Logics.MainTable.Teachers.TeachersStructure> teachersStructure = new List<Logics.MainTable.Teachers.TeachersStructure>();
        List<Logics.Books.Week.StructWeek> structWeeks = new List<Logics.Books.Week.StructWeek>();
        List<Logics.Books.TypeSubject.StructTypeSubject> structTypeSubjects = new List<Logics.Books.TypeSubject.StructTypeSubject>();
        List<Logics.MainTable.TimeTable.type_opl_teacher> array_type_Opl = new List<Logics.MainTable.TimeTable.type_opl_teacher>();
        List<Logics.MainTable.TimeTable.TimeTableStructure> arrayTableStructure = new List<Logics.MainTable.TimeTable.TimeTableStructure>();
        List<Logics.MainTable.TimeTable.GROUPSTRUCT> arrayGroupsStruct = new List<Logics.MainTable.TimeTable.GROUPSTRUCT>();
        List<Logics.MainTable.Groups.GroupsStructure> groupsStructures = new List<Logics.MainTable.Groups.GroupsStructure>();
        List<Logics.Books.Discipline.StructDiscipline> structDiscipline = new List<Logics.Books.Discipline.StructDiscipline>();
        List<Logics.Books.Discipline.StructDiscipline> structDisciplineForGetID = new List<Logics.Books.Discipline.StructDiscipline>();
        List<Logics.Books.Classroom.StructClassroom> ClassRoomInHousing = new List<Logics.Books.Classroom.StructClassroom>();
        #endregion
        #region Structures
        Logics.MainTable.TimeTable.type_opl_teacher type_Opl;
        Logics.MainTable.TimeTable.TimeTableStructure tableStructure;
        Logics.MainTable.TimeTable.GROUPSTRUCT groupsStruct;
        Logics.Books.Classroom.StructClassroom structClassroom;
        Logics.Books.Week.StructWeek structWeek;
        Logics.Books.TypeSubject.StructTypeSubject structTypeSubject;
        Logics.Books.Discipline.StructDiscipline structDisciplineForAddPara;
        #endregion
        public AddPara(Logics.Functions.Connection.ConnectionDB connection)
        {
            classroom = new Logics.Books.Classroom(connection);
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
                FacultyGroupBox.Items.Add(fac.Name);
            }
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
                    structWeek.type = Logics.Books.Week.Type_Week.Top;
                    break;
                case 1:
                    foreach (var strWeek in structWeeks)
                        if (strWeek.type == Logics.Books.Week.Type_Week.Bottom)
                            WeekDayBox.Items.Add(strWeek.name_day);
                    structWeek.type = Logics.Books.Week.Type_Week.Bottom;
                    break;
            }
        }
        private void WeekDayBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            structWeek.name_day = WeekDayBox.SelectedItem.ToString();
            switch (TypeWeekBox.SelectedIndex)
            {
                case 0:
                    foreach (var strWeek in structWeeks)
                        if (strWeek.type == Logics.Books.Week.Type_Week.Top)
                            if (WeekDayBox.SelectedItem.ToString() == strWeek.name_day)
                            {
                                structWeek.id = strWeek.id;
                                break;
                            }
                    break;
                case 1:
                    foreach (var strWeek in structWeeks)
                        if (strWeek.type == Logics.Books.Week.Type_Week.Bottom)
                            if (WeekDayBox.SelectedItem.ToString() == strWeek.name_day)
                            {
                                structWeek.id = strWeek.id;
                                break;
                            }
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
            type_Opl.faculty = FacultyBox.SelectedItem.ToString();
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            TeacherInfo.Rows.Clear();
            type_Opl.department = DepartmentBox.SelectedItem.ToString();
            teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructure);
            foreach (var teach in teachersStructure)
                TeacherInfo.Rows.Add(teach.nameteacher);
        }
        private void DisciplineBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            structDisciplineForAddPara.name = DisciplineBox.SelectedItem.ToString();
            discipline.GetAllDiscipline(type_Opl.faculty, type_Opl.department, 0, 100, out structDisciplineForGetID);
            foreach (var S_D in structDisciplineForGetID)
                if (S_D.name == structDisciplineForAddPara.name)
                {
                    structDisciplineForAddPara.id = S_D.id;
                    break;
                }
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
                    TeacherInfo.CurrentRow.Cells[2].Value = null;
                    array_type_Opl.Remove(type_Opl);
                    type_Opl.name_teacher = "";
                    DisciplineBox.SelectedItem = null;
                    DisciplineBox.Items.Clear();

                }
                else if (TeacherInfo.CurrentRow.Cells[1].Value == null)
                {
                    if (TeacherInfo.CurrentRow.Cells[2].Value == null | TeacherInfo.CurrentRow.Cells[3].Value == null)
                    {
                        TeacherInfo.CurrentRow.Cells[1].Value = true;
                        type_Opl.name_teacher = TeacherInfo.Rows[e.RowIndex].Cells[0].Value.ToString();
                    }
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
                        ChoiseTypePayForTeacher = false;
                        type_Opl.type_Oplaty_Teacher = 0;
                    }
                    else if (TeacherInfo.CurrentRow.Cells[2].Value == null & TeacherInfo.CurrentRow.Cells[1].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                    {
                        TeacherInfo.CurrentRow.Cells[2].Value = true;
                        type_Opl.type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Pochasovka;
                        array_type_Opl.Add(type_Opl);
                        TeacherInfo.CurrentRow.Cells[3].Value = false;
                        TeacherInfo.CurrentRow.Cells[3].Value = null;
                        ChoiseTypePayForTeacher = true;
                    }
                }
                else
                {
                    TeacherInfo.Rows.Clear();
                    teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructure);
                    foreach (var teach in teachersStructure)
                        TeacherInfo.Rows.Add(teach.nameteacher);
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
                        type_Opl.type_Oplaty_Teacher = 0;
                        ChoiseTypePayForTeacher = false;
                    }
                    else if (TeacherInfo.CurrentRow.Cells[3].Value == null & TeacherInfo.CurrentRow.Cells[1].Value != null && (bool)TeacherInfo.CurrentRow.Cells[1].Value == true)
                    {
                        TeacherInfo.CurrentRow.Cells[3].Value = true;
                        type_Opl.type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Stavka;
                        array_type_Opl.Add(type_Opl);
                        TeacherInfo.CurrentRow.Cells[2].Value = false;
                        TeacherInfo.CurrentRow.Cells[2].Value = null;
                        ChoiseTypePayForTeacher = true;
                    }
                }
                else
                {
                    TeacherInfo.Rows.Clear();
                    teachers.GetTeachers(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out teachersStructure);
                    foreach (var teach in teachersStructure)
                        TeacherInfo.Rows.Add(teach.nameteacher);
                }
            }
        }
        private void ComboBox1_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            TypeSubjectBox.Items.Clear();
            switch (TypeLessonsBox.SelectedIndex)
            {
                case 0:
                    structTypeSubject.typelesson = Logics.Books.TypeSubject.type_lesson.Session;
                    TimeSessionPanel.Visible = true;
                    foreach (var tSub in structTypeSubjects)
                        if (tSub.typelesson == structTypeSubject.typelesson)
                            TypeSubjectBox.Items.Add(tSub.name);
                    break;
                case 1:
                    structTypeSubject.typelesson = Logics.Books.TypeSubject.type_lesson.Study;
                    TimeSessionPanel.Visible = false;
                    foreach (var tSub in structTypeSubjects)
                        if (tSub.typelesson == structTypeSubject.typelesson)
                            TypeSubjectBox.Items.Add(tSub.name);
                    break;
            }
        }
        private void TypeSubjectBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            structTypeSubject.name = TypeSubjectBox.SelectedItem.ToString();
            foreach (var TypeSub in structTypeSubjects)
                if (TypeSub.typelesson == structTypeSubject.typelesson)
                    if (TypeSub.name == structTypeSubject.name)
                        structTypeSubject.id = TypeSub.id;
        }
        private void HousingBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (HousingBox.SelectedItem != null)
            {
                ClassRoomBox.Items.Clear();
                classroom.GetAllClass(int.Parse(HousingBox.SelectedItem.ToString()), out classes);
                structClassroom.Housing = Convert.ToInt32(HousingBox.SelectedItem.ToString());
                foreach (var cl in classes)
                    ClassRoomBox.Items.Add(cl);
            }
        }
        private void ClassRoomBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            classroom.GetAllClassroom(structClassroom.Housing, 0, 1000, out ClassRoomInHousing);
            structClassroom.Number_Class = Convert.ToInt32(ClassRoomBox.SelectedItem.ToString());
            foreach (var LessonClass in ClassRoomInHousing)
                if (LessonClass.Number_Class == structClassroom.Number_Class)
                    structClassroom.id = LessonClass.id;

        }
        private void FacultyBox2_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            DepartmentGroupBox.Items.Clear();
            Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
            List<string> departmentsName = new List<string>();
            departments.GetAllDepartmentNames(FacultyGroupBox.SelectedItem.ToString(), out departmentsName);
            foreach (var dep in departmentsName)
                DepartmentGroupBox.Items.Add(dep);
        }
        private void DepartmentBox2_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            SpecialityGroupBox.Items.Clear();
            List<string> specialityName = new List<string>();
            speciality.GetAllSpecialityNames(FacultyGroupBox.SelectedItem.ToString(), DepartmentGroupBox.SelectedItem.ToString(), out specialityName);
            foreach (var spec in specialityName)
                SpecialityGroupBox.Items.Add(spec);
        }
        private void SpecialityBox_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            GroupsInfo.Rows.Clear();
            groups.GetGroups(FacultyGroupBox.SelectedItem.ToString(), DepartmentGroupBox.SelectedItem.ToString(), SpecialityGroupBox.SelectedItem.ToString(), out groupsStructures);
            foreach (var gr in groupsStructures)
            {
                string year = Convert.ToString(gr.YearCreate);
                GroupsInfo.Rows.Add(SpecialityGroupBox.SelectedItem.ToString() + " " + year[year.Length - 2] + year[year.Length - 1] + " " + gr.Subname, gr.YearCreate);
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
                }
                else if (GroupsInfo.CurrentRow.Cells[2].Value == null)
                {
                    GroupsInfo.CurrentRow.Cells[2].Value = true;
                    groupsStruct.faculty = FacultyGroupBox.SelectedItem.ToString();
                    groupsStruct.department = DepartmentGroupBox.SelectedItem.ToString();
                    groupsStruct.name_speciality = SpecialityGroupBox.SelectedItem.ToString();
                    groupsStruct.YearCreate = Convert.ToInt32(GroupsInfo.Rows[e.RowIndex].Cells[1].Value.ToString());
                    groupsStruct.Subname = Convert.ToString(GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString()[GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString().Length - 1]);
                    arrayGroupsStruct.Add(groupsStruct);
                }
            }
        }
        private void Button4_Click(object sender, EventArgs e)
        {
            if(type_Opl.name_teacher!="" & type_Opl.faculty!="" & type_Opl.department!="" & ChoiseTypePayForTeacher != false)
            {
                DisciplineBox.Items.Clear();
                foreach (var GetParaForTeacher in array_type_Opl)
                {
                    teachers.GetTeacherDiscipline(GetParaForTeacher.faculty, GetParaForTeacher.department, GetParaForTeacher.name_teacher, out structDiscipline); /*Изменить! Большее количество преподов*/
                    foreach (var discip in structDiscipline)
                        DisciplineBox.Items.Add(discip.name);
                }
                AddLessonsInTimeTable.Visible = true;
                tableStructure.teachersStructures = array_type_Opl;
            }
        }
        private void AddLessonsInTimeTable_Click(object sender, EventArgs e)
        {
            if(DisciplineBox.SelectedItem!=null & TypeLessonsBox.SelectedItem!=null & TypeSubjectBox.SelectedItem != null & TypeWeekBox.SelectedItem != null & WeekDayBox.SelectedItem != null & HousingBox.SelectedItem != null & ClassRoomBox.SelectedItem != null)
            {
                if(structTypeSubject.typelesson == Logics.Books.TypeSubject.type_lesson.Session)
                {
                    TimeSpan timeDifferent = StopSomithing.Value.TimeOfDay - StartSomething.Value.TimeOfDay;
                    if (timeDifferent.Hours > 0)
                    {
                        tableStructure.num_para = Convert.ToInt32(NumPara.Value);
                        tableStructure.time = StartSomething.Value.TimeOfDay;
                        tableStructure.date = DateSomething.Value.Date;
                        tableStructure.typeSubject = structTypeSubject;
                        tableStructure.week = structWeek;
                        tableStructure.Discipline = structDisciplineForAddPara;
                        tableStructure.classroom = structClassroom;
                        AddGroupInTimeTable.Visible = true;
                    }
                }
                else
                {
                    tableStructure.num_para = Convert.ToInt32(NumPara.Value);
                    tableStructure.typeSubject = structTypeSubject;
                    tableStructure.week = structWeek;
                    tableStructure.Discipline = structDisciplineForAddPara;
                    tableStructure.classroom = structClassroom;
                    AddGroupInTimeTable.Visible = true;
                }
            }
        }
        private void AddGroupInTimeTable_Click(object sender, EventArgs e)
        {
            if (arrayGroupsStruct.Count != 0)
            {
                tableStructure.groupsStructures = arrayGroupsStruct;
                AddParaInTimeTable.Visible = true;
            }
        }
        private void Button3_Click(object sender, EventArgs e)
        {
            
            tableStructure.teachersStructures = array_type_Opl;
            if (timeTable.Add(tableStructure))
            {

            }
            else
            {
                MessageBox.Show(timeTable.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            tableStructure.teachersStructures.Clear();
        }      
    }
}