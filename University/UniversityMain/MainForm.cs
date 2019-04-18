﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Input;
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
        ChoiseFaculty_Department_Teacher choiseFaculty_Department_Teacher;
        ForTransfer forTransfer;
        public List<Logics.MainTable.TimeTable.TimeTableStructure> tableStructures = new List<Logics.MainTable.TimeTable.TimeTableStructure>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        List<NumOfWeekDayForOutputInTable> arrayNumOfWeekDayForOutputInTable = new List<NumOfWeekDayForOutputInTable>();
        public MainForm(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            #region Need for output timetable
            string[] NumDayWeek = { "Понедельник", "Вторник", "Среда", "Четверг", "Пятница" };
            NumOfWeekDayForOutputInTable numOfWeekDayForOutputInTable;
            for (int i = 0; i < 5; i++)
            {
                numOfWeekDayForOutputInTable.NameWeek = NumDayWeek[i];
                numOfWeekDayForOutputInTable.NumDay = i;
                arrayNumOfWeekDayForOutputInTable.Add(numOfWeekDayForOutputInTable);
            }
            #endregion
            choiseFaculty_Department_Teacher = new ChoiseFaculty_Department_Teacher(connection);
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
            Close();
            choiseFaculty_Department_Teacher.ShowDialog();
        }     
        private void Button15_Click(object sender, EventArgs e)
        {
            Close();
            new AddPara(connectionDB).Show();
        }
        private void MainForm_Load(object sender, EventArgs e)
        {
            SetTimeTableForTeacher(tableStructures);
        }
        public void SetTimeTableForTeacher(List<Logics.MainTable.TimeTable.TimeTableStructure> timeTableStructures)
        {
            if (timeTableStructures.Count != 0)
            {
                LessonsInfo.Rows.Clear();
                for (int i = 0; i < 8; i++)
                {
                    LessonsInfo.Rows.Add();
                    LessonsInfo.Rows[i].HeaderCell.Value = (i + 1).ToString();
                }
                for (int i = 0; i < timeTableStructures.Count; i++)
                {
                    int num_para = timeTableStructures[i].num_para - 1, num_day_week = GetNumOfWeekDayForOutputTable(timeTableStructures[i].week.name_day);
                    string addRecordInTable = timeTableStructures[0].groupsStructures[0].name_speciality + timeTableStructures[0].groupsStructures[0].YearCreate.ToString()[timeTableStructures[0].groupsStructures[0].YearCreate.ToString().Length - 2] + timeTableStructures[0].groupsStructures[0].YearCreate.ToString()[timeTableStructures[0].groupsStructures[0].YearCreate.ToString().Length - 1] + timeTableStructures[0].groupsStructures[0].Subname + "\r\n" + timeTableStructures[0].classroom.Housing.ToString() + "." + timeTableStructures[0].classroom.Number_Class.ToString() + " (" + timeTableStructures[0].typeSubject.name + ")";
                    LessonsInfo.Rows[num_para].Cells[num_day_week].Value = addRecordInTable;
                }
            }
        }
        public void GetArrayFromChoiseForm(List<Logics.MainTable.TimeTable.TimeTableStructure> timeTableStructures, string NameTeacher, string NameFaculty, string NameDepartment)
        {
            foreach (var TTS in timeTableStructures)
                tableStructures.Add(TTS);
            NameTeacherForOutput.Text = NameTeacher;
            forTransfer.NameTeacher = NameTeacher;
            forTransfer.NameFaculty = NameFaculty;
            forTransfer.NameDepartment = NameDepartment;
        }
        int GetNumOfWeekDayForOutputTable(string NameDayWeek)
        {
            foreach (var Num in arrayNumOfWeekDayForOutputInTable)
                if (Num.NameWeek == NameDayWeek)
                    return Num.NumDay;
            return -1;
        }
        private void Timetable_Click(object sender, EventArgs e)
        {
            if (forTransfer.NameTeacher != "")
            {
                Close();
                new TransferPara(connectionDB, "Get", -1, forTransfer.NameTeacher, forTransfer.NameFaculty, forTransfer.NameDepartment).Show();
            }
        }
        #region SomeStuctForOutput
        public struct NumOfWeekDayForOutputInTable
        {
            public string NameWeek;
            public int NumDay;  /*Start with 0*/
        }
        public struct ForTransfer
        {
            public string NameFaculty, NameDepartment, NameTeacher;
        }
        #endregion
        private void LessonsInfo_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            DialogResult result = MessageBox.Show("Вы хотите перенести пару?", "Перенос", MessageBoxButtons.YesNo);
            if (result == DialogResult.Yes)
            {
                Close();
                new TransferPara(connectionDB, "Set", 0, forTransfer.NameTeacher, forTransfer.NameFaculty, forTransfer.NameDepartment).Show();    /*IDLesson*/
            }
        }
    }
}