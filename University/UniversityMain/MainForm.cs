using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class MainForm : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        bool WindowMaximize = true;
        int HeightPanel = 455;
        Logics.Functions.Connection.ConnectionDB connectionDB;
        public MainForm(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            connectionDB = connection;
        }
        #region Design
        private void button1_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void button3_Click_1(object sender, EventArgs e)
        {
            if (WindowMaximize)
            {
                WindowState = FormWindowState.Maximized;
                WindowMaximize = false;
            }
            else
            {
                WindowState = FormWindowState.Normal;
                WindowMaximize = true;
            }
        }
        private void button2_Click_1(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click_2(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void button3_Click_2(object sender, EventArgs e)
        {
            if (WindowMaximize)
            {
                WindowState = FormWindowState.Maximized;
                WindowMaximize = false;
            }
            else
            {
                WindowState = FormWindowState.Normal;
                WindowMaximize = true;
            }
        }
        private void button2_Click_2(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void panel1_MouseDown_1(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button5_Click(object sender, EventArgs e)
        {
            /*Проверка прав доступа*/
            new FacultyForm(connectionDB).Show();
            Close();
        }
        private void button7_Click(object sender, EventArgs e)
        {
            /*Пока так. Как только будут готовы функции - изменю.*/
            new ShowGroups(connectionDB).Show();
            Close();
        }
        private void button6_Click(object sender, EventArgs e)
        {
            new Teachers(connectionDB).Show();
            Close();
        }
        private void button4_Click(object sender, EventArgs e)
        {
            if (VerticalMenu.Width == 210)
                VerticalMenu.Width = 40;
            else
                VerticalMenu.Width = 210;
        }      
        private void INFO_Click(object sender, EventArgs e)
        {
            if (INFO.Height == 42)
            {
                INFO.Height = HeightPanel;
                pictureBox1.Image = Properties.Resources.CloseDir;
            }
            else
            {
                INFO.Height = 42;
                pictureBox1.Image = Properties.Resources.OpenDir;
            }
        }
        private void label2_Click(object sender, EventArgs e)
        {
            if (INFO.Height == 42)
            {
                INFO.Height = HeightPanel;
                pictureBox1.Image = Properties.Resources.CloseDir;
            }
            else
            {
                INFO.Height = 42;
                pictureBox1.Image = Properties.Resources.OpenDir;
            }
        }
        private void pictureBox1_Click(object sender, EventArgs e)
        {
            if (INFO.Height == 42)
            {
                INFO.Height = HeightPanel;
                pictureBox1.Image = Properties.Resources.CloseDir;
            }
            else
            {
                INFO.Height = 42;
                pictureBox1.Image = Properties.Resources.OpenDir;
            }
        }
        private void button8_Click(object sender, EventArgs e)
        {
            new Classroom(connectionDB).Show();
            Close();
        }
        #endregion
        private void button9_Click(object sender, EventArgs e)
        {
            Close();
            new Discipline(connectionDB).Show();          
        }
        private void button10_Click(object sender, EventArgs e)
        {
            Close();
            new Positions(connectionDB).Show();
        }
        private void button11_Click(object sender, EventArgs e)
        {
            Close();
            new WeekForm(connectionDB).Show();
        }
        private void button12_Click(object sender, EventArgs e)
        {
            Close();
            new TypeSubject(connectionDB).Show();
        }
        private void button4_Click_1(object sender, EventArgs e)
        {
            Close();
            new Departments(connectionDB).Show();
        }
        private void button13_Click(object sender, EventArgs e)
        {
            Close();
            new Specialities(connectionDB).Show();
        }
        private void Button14_Click_1(object sender, EventArgs e)
        {
            new ChoiseFaculty_Department_Teacher(connectionDB).ShowDialog();
        }     
        private void Button15_Click(object sender, EventArgs e)
        {
            Close();
            new AddPara(connectionDB).Show();
        }
        private void MainForm_Load(object sender, EventArgs e)
        {
            for (int i = 0; i < 8; i++)
            {
                LessonsInfo.Rows.Add();
                LessonsInfo.Rows[i].HeaderCell.Value = (i + 1).ToString();
            }
            /*Проверка права доступа к некоторым функциям*/
        }
        public void SetTimeTableForTeacher(string NameTeacher)
        {

        }
        private void Timetable_Click(object sender, EventArgs e)
        {
            /*Проверка прав доступа. Если есть на добавление и изменение - отображаем форму, а если только на просмотр - загрузить форму с переносами на просмотр*/
            new ChoiseForm(connectionDB).Show();
            Close();
        }
    }
}