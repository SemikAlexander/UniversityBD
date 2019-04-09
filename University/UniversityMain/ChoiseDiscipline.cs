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
    public partial class ChoiseDiscipline : Form
    {
        int StartRow = 0;
        Logics.Books.Discipline discipline;
        Logics.Functions.Connection.ConnectionDB connectionDB;
        public List<string> disciplineForTeacher = new List<string>();
        List<Logics.Books.Discipline.StructDiscipline> structDisciplines = new List<Logics.Books.Discipline.StructDiscipline>();
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.MainTable.Teachers teachers;
        Teachers teachersDisc;
        string facultyName, departmentName, Name;
        bool addForm;
        public ChoiseDiscipline(Logics.Functions.Connection.ConnectionDB connection, string faculty, string department, bool add, string NameTeacher)
        {
            InitializeComponent();
            facultyName = faculty;
            connectionDB = connection;
            departmentName = department;
            discipline = new Logics.Books.Discipline(connection);
            addForm = add;
            Name = NameTeacher;
            teachers = new Logics.MainTable.Teachers(connection);
            teachersDisc = new Teachers(connection);
        }
        private void button1_Click(object sender, EventArgs e)
        {
            teachersDisc.GetArrayFromChoiseDiscipline(disciplineForTeacher);
            Close();
        }
        private void UpButton_Click(object sender, EventArgs e)
        {
            if (StartRow - 20 >= 0)
            {
                StartRow -= 20;
                DisciplineInfo.Rows.Clear();
                discipline.GetAllDiscipline(facultyName, departmentName, StartRow, 20, out structDisciplines);
                for (int i = 0; i < structDisciplines.Count; i++)
                    DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
            }
        }
        private void DownButton_Click(object sender, EventArgs e)
        {
            StartRow += 20;
            discipline.GetAllDiscipline(facultyName, departmentName, StartRow, 20, out structDisciplines);
            if (structDisciplines.Count != 0)
            {
                DisciplineInfo.Rows.Clear();
                foreach (var descipline in structDisciplines)
                    DisciplineInfo.Rows.Add(descipline.id, descipline.name);
            }
            else
                StartRow -= 20;
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void DisciplineInfo_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn & senderGrid.Columns[e.ColumnIndex].Name == "ChoiseTeacherDiscipline" && e.RowIndex >= 0)
            {
                if (DisciplineInfo.CurrentRow.Cells[1].Value != null && (bool)DisciplineInfo.CurrentRow.Cells[1].Value == true)
                {
                    DisciplineInfo.CurrentRow.Cells[1].Value = false;
                    DisciplineInfo.CurrentRow.Cells[1].Value = null;
                    disciplineForTeacher.Remove(DisciplineInfo.Rows[e.RowIndex].Cells[0].Value.ToString());                   
                }
                else if (DisciplineInfo.CurrentRow.Cells[1].Value == null)
                {
                    DisciplineInfo.CurrentRow.Cells[1].Value = true;
                    disciplineForTeacher.Add(DisciplineInfo.Rows[e.RowIndex].Cells[0].Value.ToString());
                }
            }
        }
        private void ChoiseDiscipline_Load(object sender, EventArgs e)
        {
            if (addForm == true)
            {
                discipline.GetAllDiscipline(facultyName, departmentName, StartRow, 20, out structDisciplines);
                foreach (var descipline in structDisciplines)
                    DisciplineInfo.Rows.Add(descipline.name);
            }
            else
            {
                discipline.GetAllDiscipline(facultyName, departmentName, StartRow, 20, out structDisciplines);
                foreach (var discipline in structDisciplines)
                    DisciplineInfo.Rows.Add(discipline.name);
                structDisciplines.Clear();
                teachers.GetTeacherDiscipline(facultyName, departmentName, Name, out structDisciplines);
                foreach(var discipline in structDisciplines)
                {
                    for(int i = 0; i < DisciplineInfo.Rows.Count; i++)
                    {
                        if (DisciplineInfo.Rows[i].Cells[1].Value == null & DisciplineInfo.Rows[i].Cells[0].Value.ToString() == discipline.name)
                        {
                            DisciplineInfo.Rows[i].Cells[1].Value = true;
                            break;
                        }
                    }
                }
            }
        }
    }
}
