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
    public partial class StudyPlan : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.MainTable.Groups.GroupsStructure> groupsStructures = new List<Logics.MainTable.Groups.GroupsStructure>();
        Logics.MainTable.Groups.GroupsStructure structure;
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Groups groups;
        List<Logics.MainTable.Groups.GroupPlan> GP = new List<Logics.MainTable.Groups.GroupPlan>();
        Logics.MainTable.Groups.GroupPlan plan;
        string nameFaculty, nameDepartment, groupABR, subName;
        bool edit_data = false;
        int yearEntry;
        public StudyPlan(Logics.Functions.Connection.ConnectionDB connection, List<Logics.MainTable.Groups.GroupPlan> groupPlan, string NAME_FACULTY, string NAME_DEP, string ABR, string SUB_NAME, int YEAR_ENTRY)
        {
            connectionDB = connection;
            groups = new Logics.MainTable.Groups(connection);
            foreach(var PLAN in groupPlan)
            {
                plan.startStudy = PLAN.startStudy;
                plan.EndStudy = PLAN.EndStudy;
                plan.startSession = PLAN.startSession;
                plan.EndSession = PLAN.EndSession;
                GP.Add(plan);
            }
            nameFaculty = NAME_FACULTY;
            nameDepartment = NAME_DEP;
            groupABR = ABR;
            subName = SUB_NAME;
            yearEntry = YEAR_ENTRY;
            InitializeComponent();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new ShowGroups(connectionDB).Show();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void PlanStadInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeletePlane" && e.RowIndex >= 0 & edit_data == true)
            {
                structure.Subname = subName;
                structure.YearCreate = yearEntry;
                plan.startStudy = DateTime.Parse(PlanStadInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                plan.EndStudy = DateTime.Parse(PlanStadInfo.Rows[e.RowIndex].Cells[1].Value.ToString());
                plan.startSession = DateTime.Parse(PlanStadInfo.Rows[e.RowIndex].Cells[2].Value.ToString());
                plan.EndSession = DateTime.Parse(PlanStadInfo.Rows[e.RowIndex].Cells[3].Value.ToString());
                groups.DeleteGroupPlan(nameFaculty, nameDepartment, groupABR, structure, plan);
                PlanStadInfo.Rows.Clear();
                groups.GetGroupPlan(nameFaculty, nameDepartment, groupABR, structure, out GP);
                foreach (var gp in GP)
                    PlanStadInfo.Rows.Add(gp.startStudy.ToString("d"), gp.EndStudy.ToString("d"), gp.startSession.ToString("d"), gp.EndSession.ToString("d"));
            }
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void StudyPlan_Load(object sender, EventArgs e)
        {
            foreach (var access in connectionDB.Accesses)
            {
                switch (access)
                {
                    case Logics.Functions.Connection.ConnectionDB.function_access.add_styding_plans: panel3.Visible = true; edit_data = true; break;
                    case Logics.Functions.Connection.ConnectionDB.function_access.get_styding_plans:
                        foreach (var PLAN in GP)
                            PlanStadInfo.Rows.Add(PLAN.startStudy.ToString("d"), PLAN.EndStudy.ToString("d"), PLAN.startSession.ToString("d"), PLAN.EndSession.ToString("d"));
                        break;
                }
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {
            TimeSpan x = EndStad.Value - StartStad.Value;
            if ((int)x.TotalDays > 0)
            {
                x = EndSess.Value - StartSess.Value;
                if ((int)x.TotalDays > 0)
                {
                    plan.startStudy = StartStad.Value.Date;
                    plan.EndStudy = EndStad.Value.Date;
                    plan.startSession = StartSess.Value.Date;
                    plan.EndSession = EndSess.Value.Date;
                    structure.Subname = subName;
                    structure.YearCreate = yearEntry;
                    if (!groups.AddGroupPlan(nameFaculty, nameDepartment, groupABR, structure, plan))
                    {
                        MessageBox.Show(groups.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                    else
                    {
                        PlanStadInfo.Rows.Clear();
                        groups.GetGroupPlan(nameFaculty, nameDepartment, groupABR, structure, out GP);
                        foreach(var gp in GP)
                            PlanStadInfo.Rows.Add(gp.startStudy.ToString("d"), gp.EndStudy.ToString("d"), gp.startSession.ToString("d"), gp.EndSession.ToString("d"));
                    }
                }
            }
        }
    }
}