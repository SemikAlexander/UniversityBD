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
    public partial class Classroom : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.Books.Classroom classroom;
        List<Logics.Books.Classroom.StructClassroom> structClassrooms = new List<Logics.Books.Classroom.StructClassroom>();
        List<int> housing = new List<int>();
        int StartRow = 0;
        public Classroom(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            classroom = new Logics.Books.Classroom(connection);
            InitializeComponent();
        }
        #region Design
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void InputNameFaculty_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8)
                e.Handled = true;
        }
        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar >= 58) && e.KeyChar != 8)
                e.Handled = true;
        }
        #endregion
        private void button4_Click(object sender, EventArgs e)
        {
            if (InputHousing.Text.Trim(' ').Length != 0 & InputClassroom.Text.Trim(' ').Length != 0)
            {
                if(!classroom.Add(int.Parse(InputHousing.Text), int.Parse(InputClassroom.Text)))
                {
                    MessageBox.Show(classroom.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    MessageBox.Show("Данные успешно добавлены!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ClassroomInfo.Rows.Clear();
                    InputClassroom.Clear();
                    InputHousing.Clear();
                    housing.Clear();
                    structClassrooms.Clear();
                    classroom.GetAllHousign(out housing);
                    for(int i = 0; i < housing.Count; i++)
                    {
                        classroom.GetAllClassroom(housing[i], StartRow, 20, out structClassrooms);
                        for (int j = 0; j < structClassrooms.Count; j++)
                            ClassroomInfo.Rows.Add(structClassrooms[j].id, structClassrooms[j].Housing, structClassrooms[j].Number_Class);
                    }
                }

            }
            else
            {
                MessageBox.Show("Вы заполнили не все поля!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
        }
        private void Classroom_Load(object sender, EventArgs e)
        {
            classroom.GetAllHousign(out housing);
            for (int i = 0; i < housing.Count; i++)
            {
                classroom.GetAllClassroom(housing[i], 0, 20, out structClassrooms);
                for (int j = 0; j < structClassrooms.Count; j++)
                {
                    ClassroomInfo.Rows.Add(structClassrooms[j].id, structClassrooms[j].Housing, structClassrooms[j].Number_Class);
                }
            }
        }
        private void ClassroomInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteH" && e.RowIndex >= 0)
            {
                int ID_Delete = (int)ClassroomInfo.Rows[e.RowIndex].Cells[0].Value;
                classroom.DeleteClass(ID_Delete);
                ClassroomInfo.Rows.Clear();
                InputClassroom.Clear();
                InputHousing.Clear();
                housing.Clear();
                structClassrooms.Clear();
                classroom.GetAllHousign(out housing);
                for (int i = 0; i < housing.Count; i++)
                {
                    classroom.GetAllClassroom(housing[i], i, 20, out structClassrooms);
                    for (int j = 0; j < structClassrooms.Count; j++)
                        ClassroomInfo.Rows.Add(structClassrooms[j].id, structClassrooms[j].Housing, structClassrooms[j].Number_Class);
                }
            }
        }
        private void DownButton_Click(object sender, EventArgs e)
        {
            StartRow += 20;           
            classroom.GetAllHousign(out housing);
            for (int i = 0; i < housing.Count; i++)
            {
                classroom.GetAllClassroom(housing[i], StartRow, 20, out structClassrooms);
                if (structClassrooms.Count != 0)
                {
                    ClassroomInfo.Rows.Clear();
                    for (int j = 0; j < structClassrooms.Count; j++)
                        ClassroomInfo.Rows.Add(structClassrooms[j].id, structClassrooms[j].Housing, structClassrooms[j].Number_Class);
                }
                else
                {
                    StartRow -= 20;
                    break;
                }
            }
        }
        private void UpButton_Click(object sender, EventArgs e)
        {
            if (StartRow - 20 >= 0)
            {
                StartRow -= 20;
                ClassroomInfo.Rows.Clear();
                classroom.GetAllHousign(out housing);
                for (int i = 0; i < housing.Count; i++)
                {
                    classroom.GetAllClassroom(housing[i], StartRow, 20, out structClassrooms);
                    for (int j = 0; j < structClassrooms.Count; j++)
                        ClassroomInfo.Rows.Add(structClassrooms[j].id, structClassrooms[j].Housing, structClassrooms[j].Number_Class);
                }
            }
        }
    }
}