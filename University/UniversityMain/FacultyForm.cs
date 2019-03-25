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
    public partial class FacultyForm : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        public FacultyForm(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            connectionDB = connection;
        }
        #region Deisgn
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
        #endregion

        private void FacultyForm_Load(object sender, EventArgs e)
        {
            /*Проверка на права тут должна быть!*/
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            if(faculty.GetAllFaculty(out structFaculties))
            {
                for (int i = 0; i < structFaculties.Count; i++)
                    FacultyInfo.Rows.Add(structFaculties[i].id, structFaculties[i].Name, structFaculties[i].logo);
            }
            else
            {
                MessageBox.Show(faculty.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            OpenFileDialog open_dialog = new OpenFileDialog(); //создание диалогового окна для выбора файла
            open_dialog.Filter = "Image Files(*.JPG;*.PNG)|*.JPG;*.PNG|All files (*.*)|*.*"; //формат загружаемого файла
            if (open_dialog.ShowDialog() == DialogResult.OK) //если в окне была нажата кнопка "ОК"
            {
                try
                {
                    LogoBox.Image = new Bitmap(open_dialog.FileName);
                }
                catch
                {
                    DialogResult rezult = MessageBox.Show("Невозможно открыть выбранный файл",
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
        private void button4_Click(object sender, EventArgs e)
        {
            if (InputNameFaculty.Text.Trim(' ').Length == 0)
            {
                MessageBox.Show("Вы не ввели имя факультета!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            else
            {
                Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
                if(!faculty.AddFaculty(InputNameFaculty.Text, LogoBox.Image))
                {
                    MessageBox.Show(faculty.exception, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                else
                {
                    MessageBox.Show("Данные добавлены!", "OK", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    LogoBox.Image = null;
                    InputNameFaculty.Clear();
                    FacultyInfo.Rows.Clear();
                    List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
                    if (faculty.GetAllFaculty(out structFaculties))
                    {
                        for (int i = 0; i < structFaculties.Count; i++)
                            FacultyInfo.Rows.Add(structFaculties[i].id, structFaculties[i].Name, structFaculties[i].logo);
                    }
                    else
                    {
                        MessageBox.Show(faculty.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
            }
        }

        private void FacultyInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.RowIndex >= 0)
            {
                Logics.Books.Faculty.StructFaculty structFaculty;
                structFaculty.id = (int)FacultyInfo.Rows[e.RowIndex].Cells[0].Value;
                structFaculty.Name = FacultyInfo.Rows[e.RowIndex].Cells[1].Value.ToString();
                InputNameFaculty.Text = structFaculty.Name;
                structFaculty.logo = (Image)FacultyInfo.Rows[e.RowIndex].Cells[2].Value;
                LogoBox.Image = structFaculty.logo;
                Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
                faculty.DeleteFaculty(structFaculty.id);
                FacultyInfo.Rows.Clear();
                List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
                if (faculty.GetAllFaculty(out structFaculties))
                {
                    for (int i = 0; i < structFaculties.Count; i++)
                        FacultyInfo.Rows.Add(structFaculties[i].id, structFaculties[i].Name, structFaculties[i].logo);
                }
            }
        }
    }
}