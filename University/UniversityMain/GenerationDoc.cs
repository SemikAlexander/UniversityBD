using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace UniversityMain
{
    public partial class GenerationDoc : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher;
        Logics.reports.Reports reports;
        string FacultyForGeneration = "", DepartmentForGeneration = "";
        BackgroundWorker backgroundWorker = new BackgroundWorker();
        public GenerationDoc(Logics.Functions.Connection.ConnectionDB connection)
        {
            InitializeComponent();
            reports = new Logics.reports.Reports(connection);
            connectionDB = connection;
        }
        private void FacultyBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null)
            {
                Logics.MainTable.Departments departments = new Logics.MainTable.Departments(connectionDB);
                List<string> departments_name = new List<string>();
                DepartmentBox.Items.Clear();
                FacultyForGeneration = FacultyBox.SelectedItem.ToString();
                departments.GetAllDepartmentNames(FacultyForGeneration, out departments_name);
                foreach (var d_n in departments_name)
                    DepartmentBox.Items.Add(d_n);
            }
        }
        private void DepartmentBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DepartmentBox.SelectedItem != null)
                DepartmentForGeneration = DepartmentBox.SelectedItem.ToString();
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Label4_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void Button3_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog();
            folderBrowserDialog.RootFolder = Environment.SpecialFolder.Desktop;
            folderBrowserDialog.Description = "Выберите папку";
            folderBrowserDialog.ShowNewFolderButton = false;
            if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                FolderPath.Text = folderBrowserDialog.SelectedPath;
        }
        private void Button4_Click(object sender, EventArgs e)
        {
            if (FacultyBox.SelectedItem != null & DepartmentBox.SelectedItem != null & TypeDoc.SelectedItem != null & FolderPath.Text.Length != 0)
            {
                button4.Enabled = false;
                backgroundWorker.DoWork += (obj, ea) => Gen(type_Oplaty_Teacher, FacultyForGeneration, DepartmentForGeneration, dateTimePicker2.Value.Date, dateTimePicker1.Value.Date, FolderPath.Text);
                backgroundWorker.RunWorkerCompleted += BackgroundWorker_RunWorkerCompleted;
                backgroundWorker.RunWorkerAsync();
            }
        }
        private void BackgroundWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            button4.Enabled = true;
        }
        private void GenerationDoc_Load(object sender, EventArgs e)
        {
            Logics.Books.Faculty faculty = new Logics.Books.Faculty(connectionDB);
            List<Logics.Books.Faculty.StructFaculty> structFaculties = new List<Logics.Books.Faculty.StructFaculty>();
            faculty.GetAllFaculty(out structFaculties);
            foreach (var fac in structFaculties)
                FacultyBox.Items.Add(fac.Name);
        }
        private void TypeDoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (TypeDoc.SelectedIndex)
            {
                case 0: type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Stavka; break;
                case 1: type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.PolStavka; break;
                case 2: type_Oplaty_Teacher = Logics.MainTable.TimeTable.type_oplaty_teacher.Pochasovka; break;
            }
        }
        private async void Gen(Logics.MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher, string faculty, string department, DateTime month, DateTime start_semestr, string path_to_dir)
        {
            if (reports.RunReports(type_Oplaty_Teacher, faculty, department, month, start_semestr, path_to_dir))
            {
                MessageBox.Show("Отчёт сгенерирован!", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            else
            {
                MessageBox.Show(reports.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
    }
}