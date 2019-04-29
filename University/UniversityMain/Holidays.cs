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
    public partial class Holidays : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Functions.Connection.ConnectionDB connectionDB;
        Logics.Books.Holidays holidays;
        List<Logics.Books.Holidays.StructHolidays> structHolidays = new List<Logics.Books.Holidays.StructHolidays>();
        bool edit_data = false;
        public Holidays(Logics.Functions.Connection.ConnectionDB connection)
        {
            holidays = new Logics.Books.Holidays(connection);
            connectionDB = connection;
            InitializeComponent();
        }
        private void Button1_Click_1(object sender, EventArgs e)
        {
            new MainForm(connectionDB).Show();
            Close();
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
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
        private void FacultyInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteHoliday" & e.RowIndex >= 0 & edit_data == true)
            {
                holidays.DeleteHolidays((DateTime)HolidayInfo.Rows[e.RowIndex].Cells[1].Value);
                HolidayInfo.Rows.Clear();
                if (holidays.GetAllHolidays(out structHolidays))
                {
                    foreach (var SH in structHolidays)
                        HolidayInfo.Rows.Add(SH.id, SH.date);
                }
            }
        }
        private void Holidays_Load(object sender, EventArgs e)
        {
            foreach (var access in connectionDB.Accesses)
            {
                switch (access)
                {
                    case Logics.Functions.Connection.ConnectionDB.function_access.holidays_add: panel3.Visible = true; edit_data = true; break;
                }
            }
            HolidayInfo.Rows.Clear();
            holidays.GetAllHolidays(out structHolidays);
            foreach (var SH in structHolidays)
                HolidayInfo.Rows.Add(SH.id, SH.date);
        }
        private void Button4_Click(object sender, EventArgs e)
        {
            if (!holidays.AddHolidays(dateTimePicker1.Value.Date))
            {
                MessageBox.Show(holidays.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            else
            {
                HolidayInfo.Rows.Clear();
                holidays.GetAllHolidays(out structHolidays);
                foreach (var SH in structHolidays)
                    HolidayInfo.Rows.Add(SH.id, SH.date);
            }
        }
    }
}