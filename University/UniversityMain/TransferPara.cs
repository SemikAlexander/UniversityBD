﻿using System;
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
    public partial class TransferPara : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(IntPtr hwnd, int wmsg, int wparam, int lparam);
        #region Arrays
        List<Logics.MainTable.Transfers.TransfersStruct> transfersStructs = new List<Logics.MainTable.Transfers.TransfersStruct>();
        #endregion       
        #region Classes
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.MainTable.Transfers transfers;
        #endregion
        string faculty = "", department = "", nameTeacher = "";
        public TransferPara(Logics.Functions.Connection.ConnectionDB connection, int IDLesson, string NameTeacher, string NameFaculty, string NameDepartment)
        {
            transfers = new Logics.MainTable.Transfers(connection);
            connectionDB = connection;
            nameTeacher = NameTeacher;
            faculty = NameFaculty;
            department = NameDepartment;
            InitializeComponent();
        }
        private void Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void TransferInfo_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            int IDForDelete = (int)TransferInfo.CurrentRow.Cells[6].Value;
            for(int i = 0; i < transfersStructs.Count; i++)
                if (transfersStructs[i].tm.id == IDForDelete)
                    transfers.delete_transfer(IDForDelete, transfersStructs[i].date_from, transfersStructs[i].date_to, transfersStructs[i].tm.num_para);
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void Button1_Click(object sender, EventArgs e)
        {
            new MainForm(connectionDB).Show();
            Close();
        }
        private void TransferPara_Load(object sender, EventArgs e)
        {
            transfers.GetTransfers(faculty, department, nameTeacher, out transfersStructs);
            for (int i = 0; i < transfersStructs.Count; i++)
            {
                for(int j = 0; j < transfersStructs[i].tm.groupsStructures.Count; j++)
                {
                    TransferInfo.Rows.Add(transfersStructs[i].tm.groupsStructures[j].name_speciality + " " + transfersStructs[i].tm.groupsStructures[j].YearCreate.ToString()[transfersStructs[i].tm.groupsStructures[j].YearCreate.ToString().Length - 2] + transfersStructs[i].tm.groupsStructures[j].YearCreate.ToString()[transfersStructs[i].tm.groupsStructures[j].YearCreate.ToString().Length - 1] + transfersStructs[i].tm.groupsStructures[j].Subname, transfersStructs[i].tm.week.name_day, transfersStructs[i].tm.num_para, transfersStructs[i].tm.typeSubject.name, transfersStructs[i].tm.id);
                }
            }
        }
    }
}