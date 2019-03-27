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
    public partial class Discipline : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.Books.Discipline.StructDiscipline> structDisciplines = new List<Logics.Books.Discipline.StructDiscipline>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.Books.Discipline discipline;
        int StartRow = 0;
        public Discipline(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            discipline = new Logics.Books.Discipline(connection);
            InitializeComponent();
        }
        #region Design
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
        #endregion

        private void DownButton_Click(object sender, EventArgs e)
        {
            StartRow += 20;
            discipline.GetAllDiscipline(StartRow, 20, out structDisciplines);
            if (structDisciplines.Count != 0)
            {
                DisciplineInfo.Rows.Clear();
                for (int i = 0; i < structDisciplines.Count; i++)
                    DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
            }
            else
                StartRow -= 20;
        }
        private void UpButton_Click(object sender, EventArgs e)
        {
            if (StartRow - 20 >= 0)
            {
                StartRow -= 20;
                DisciplineInfo.Rows.Clear();
                discipline.GetAllDiscipline(StartRow, 20, out structDisciplines);
                for (int i = 0; i < structDisciplines.Count; i++)
                    DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
            }
        }
        private void Discipline_Load(object sender, EventArgs e)
        {
            discipline.GetAllDiscipline(StartRow, 20, out structDisciplines);
            for(int i = 0; i < 20; i++)
                DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
        }
        private void button4_Click(object sender, EventArgs e)
        {
            if(InputDiscipline.Text.Trim(' ').Length != 0)
            {
                if (!discipline.AddDiscipline(InputDiscipline.Text))
                {
                    MessageBox.Show(discipline.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    MessageBox.Show("Данные успешно добавлены!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    InputDiscipline.Clear();
                    DisciplineInfo.Rows.Clear();
                    discipline.GetAllDiscipline(StartRow, 20, out structDisciplines);
                    for (int i = 0; i < structDisciplines.Count; i++)
                        DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
                }
            }
        }

        private void DisciplineInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.RowIndex >= 0)
            {
                int ID_Delete = (int)DisciplineInfo.Rows[e.RowIndex].Cells[0].Value;
                StartRow = 0;
                discipline.DeleteDiscipline(ID_Delete);
                DisciplineInfo.Rows.Clear();
                InputDiscipline.Clear();
                structDisciplines.Clear();
                discipline.GetAllDiscipline(StartRow, 20, out structDisciplines);
                for (int i = 0; i < structDisciplines.Count; i++)
                    DisciplineInfo.Rows.Add(structDisciplines[i].id, structDisciplines[i].name);
            }
        }
    }
}
