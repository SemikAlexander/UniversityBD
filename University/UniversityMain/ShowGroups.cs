using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class ShowGroups : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.MainTable.Groups.GroupsStructure> groupsStructures = new List<Logics.MainTable.Groups.GroupsStructure>();
        List<Logics.MainTable.Groups.GroupPlan> groupPlans = new List<Logics.MainTable.Groups.GroupPlan>();
        Logics.MainTable.Groups.GroupsStructure structure;
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Speciality speciality;
        List<string> specialityName = new List<string>();
        bool edit_data = false;
        Logics.MainTable.Groups groups;
        public ShowGroups(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            groups = new Logics.MainTable.Groups(connection);
            speciality = new Logics.MainTable.Speciality(connectionDB);
            InitializeComponent();
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
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void ShowGroups_Load(object sender, EventArgs e)
        {
            foreach (var access in connectionDB.Accesses)
            {
                switch (access)
                {
                    case Logics.Functions.Connection.ConnectionDB.function_access.group_add: panel3.Visible = true; edit_data = true; break;
                    case Logics.Functions.Connection.ConnectionDB.function_access.get_groups:
                        Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
                        List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
                        faculty.GetAllFaculty(out structFaculties);
                        foreach (var fac in structFaculties)
                        {
                            FacultyBox.Items.Add(fac.Name);
                            FacultyInputBox.Items.Add(fac.Name);
                        }
                        break;
                }
            }
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            DepartmentBox.Items.Clear();
            Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
            List<string> departmentsName = new List<string>();
            departments.GetAllDepartmentNames(FacultyBox.SelectedItem.ToString(), out departmentsName);
            foreach (var dep in departmentsName)
                DepartmentBox.Items.Add(dep);
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            SpecialityBox.Items.Clear();
            speciality.GetAllSpecialityNames(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), out specialityName);
            foreach (var spec in specialityName)
                SpecialityBox.Items.Add(spec);
        }
        private void SpecialityBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            GroupsInfo.Rows.Clear();
            groups.GetGroups(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), SpecialityBox.SelectedItem.ToString(), out groupsStructures);
            foreach (var gr in groupsStructures)
            {
                string year = Convert.ToString(gr.YearCreate);
                GroupsInfo.Rows.Add(SpecialityBox.SelectedItem.ToString() + " " + year[year.Length - 2] + year[year.Length - 1] + " " + gr.Subname, gr.YearCreate);
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {
            if(InputYearEntry.Text.Length!=0 & FacultyInputBox.SelectedItem!=null & DepartmentInputBox.SelectedItem!=null & SpecialityInputBox.SelectedItem != null)
            {
                structure.YearCreate = int.Parse(InputYearEntry.Text);
                structure.Subname = SubName.Text;
                if (groups.Add(structure, FacultyInputBox.SelectedItem.ToString(), DepartmentInputBox.SelectedItem.ToString(), SpecialityInputBox.SelectedItem.ToString()))
                {
                    string year = InputYearEntry.Text, spec = SpecialityInputBox.SelectedItem.ToString();
                    FacultyInputBox.SelectedItem = null;
                    DepartmentInputBox.SelectedItem = null;
                    SpecialityInputBox.SelectedItem = null;
                    InputYearEntry.Clear();
                    SubName.Clear();
                    GroupsInfo.Rows.Clear();
                    groups.GetGroups(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), SpecialityBox.SelectedItem.ToString(), out groupsStructures);
                    foreach (var gr in groupsStructures)
                        GroupsInfo.Rows.Add(SpecialityBox.SelectedItem.ToString() + " " + Convert.ToString(gr.YearCreate)[gr.YearCreate.ToString().Length-2] + Convert.ToString(gr.YearCreate)[gr.YearCreate.ToString().Length - 1] + " " + gr.Subname, gr.YearCreate);
                }
                else
                {
                    MessageBox.Show(groups.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
            }
        }
        private void DepartmentInputBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentInputBox.SelectedItem != null)
            {
                SpecialityInputBox.Items.Clear();
                Logics.MainTable.Speciality speciality = new Logics.MainTable.Speciality(connectionDB);
                List<string> specialityName = new List<string>();
                speciality.GetAllSpecialityNames(FacultyInputBox.SelectedItem.ToString(), DepartmentInputBox.SelectedItem.ToString(), out specialityName);
                foreach (var spec in specialityName)
                    SpecialityInputBox.Items.Add(spec);
            }
        }
        private void InputYearEntry_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8)
                e.Handled = true;
        }
        private void GroupsInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteGroup" && e.RowIndex >= 0 & edit_data == true)
            {
                try
                {
                    structure.Subname = Convert.ToString(GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString()[GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString().Length - 1]);
                }
                catch (Exception)
                {
                    structure.Subname = "";
                }
                structure.YearCreate = (int)GroupsInfo.Rows[e.RowIndex].Cells[1].Value;
                string year = GroupsInfo.Rows[e.RowIndex].Cells[1].Value.ToString();
                groups.Delete(DepartmentBox.SelectedItem.ToString(), FacultyBox.SelectedItem.ToString(), SpecialityBox.SelectedItem.ToString(), structure);
                GroupsInfo.Rows.Clear();
                groups.GetGroups(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), SpecialityBox.SelectedItem.ToString(), out groupsStructures);
                foreach (var gr in groupsStructures)
                    GroupsInfo.Rows.Add(SpecialityBox.SelectedItem.ToString() + " " + Convert.ToString(gr.YearCreate)[gr.YearCreate.ToString().Length - 2] + Convert.ToString(gr.YearCreate)[gr.YearCreate.ToString().Length - 1] + " " + gr.Subname, gr.YearCreate);
            }
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "StadPlan" && e.RowIndex >= 0)
            {
                string[] abr = GroupsInfo.Rows[e.RowIndex].Cells[0].Value.ToString().Split(' ');
                string ABR = abr[0];
                structure.YearCreate = (int)GroupsInfo.Rows[e.RowIndex].Cells[1].Value;
                structure.Subname = abr[2];
                groups.GetGroupPlan(FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), ABR, structure, out groupPlans);
                Close();
                new StudyPlan(connectionDB, groupPlans, FacultyBox.SelectedItem.ToString(), DepartmentBox.SelectedItem.ToString(), ABR, structure.Subname, structure.YearCreate).Show();
            }
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
    }
}