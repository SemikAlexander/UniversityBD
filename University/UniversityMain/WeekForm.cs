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
    public partial class WeekForm : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        Logics.Books.Week week;
        Logics.Functions.Connection.ConnectionDB connectionDB;
        List<Logics.Books.Week.StructWeek> structWeeks = new List<Logics.Books.Week.StructWeek>();
        Logics.Books.Week.StructWeek @struct;
        public WeekForm(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            week = new Logics.Books.Week(connection);
            InitializeComponent();
        }

        private void WeekForm_Load(object sender, EventArgs e)
        {           
            try
            {
                week.GetAllWeek(out structWeeks);
                foreach (var week_out in structWeeks)
                    WeekInfo.Rows.Add(week_out.id, week_out.name_day, week_out.type);
            }
            catch (Exception)
            {
                MessageBox.Show(week.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                Close();
                new MainForm(connectionDB).Show();
            }
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if(InputWeek.Text.Trim(' ').Length!=0 & WeekBox.SelectedItem != null)
            {
                @struct.name_day = InputWeek.Text;
                switch (WeekBox.SelectedIndex)
                {
                    case 0:
                        @struct.type = Logics.Books.Week.Type_Week.Top;
                        break;
                    case 1:
                        @struct.type = Logics.Books.Week.Type_Week.Bottom;
                        break;
                }
                if (!week.AddWeek(@struct))
                {
                    MessageBox.Show(week.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    MessageBox.Show("Данные успешно добавлены!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    InputWeek.Clear();
                    WeekBox.SelectedItem = null;
                    WeekInfo.Rows.Clear();
                    try
                    {
                        week.GetAllWeek(out structWeeks);
                        foreach (var week_out in structWeeks)
                            WeekInfo.Rows.Add(week_out.id, week_out.name_day, week_out.type);
                    }
                    catch (Exception)
                    {
                        MessageBox.Show(week.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        Close();
                        new MainForm(connectionDB).Show();
                    }
                }
            }
        }

        private void WeekInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeleteWeek" && e.RowIndex >= 0)
            {
                int ID_Delete = (int)WeekInfo.Rows[e.RowIndex].Cells[0].Value;
                week.DeleteWeek(ID_Delete);
                WeekInfo.Rows.Clear();
                InputWeek.Clear();
                WeekBox.SelectedItem = null;
                structWeeks.Clear();
                try
                {
                    week.GetAllWeek(out structWeeks);
                    foreach (var week_out in structWeeks)
                        WeekInfo.Rows.Add(week_out.id, week_out.name_day, week_out.type);
                }
                catch (Exception)
                {
                    MessageBox.Show(week.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    Close();
                    new MainForm(connectionDB).Show();
                }
            }
        }
    }
}
