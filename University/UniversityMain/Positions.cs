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
    public partial class Positions : Form
    {
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        List<Logics.Books.Position.StructPosition> structPositions = new List<Logics.Books.Position.StructPosition>();
        Logics.Functions.Connection.ConnectionDB connectionDB;
        bool edit_data = false;
        Logics.Books.Position position;
        public Positions(Logics.Functions.Connection.ConnectionDB connection)
        {
            connectionDB = connection;
            position = new Logics.Books.Position(connection);
            InitializeComponent();
        }

        private void Positions_Load(object sender, EventArgs e)
        {
            foreach (var access in connectionDB.Accesses)
            {
                switch (access)
                {
                    case Logics.Functions.Connection.ConnectionDB.function_access.position_add: panel3.Visible = true; edit_data = true; break;
                    case Logics.Functions.Connection.ConnectionDB.function_access.position_get_all:
                        try
                        {
                            position.GetAllPositions(out structPositions);
                            foreach (var pos in structPositions)
                                PositionInfo.Rows.Add(pos.id, pos.name);
                        }
                        catch (Exception)
                        {
                            MessageBox.Show(position.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            Close();
                            new MainForm(connectionDB).Show();
                        }
                        break;
                }
            }
        }
        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(Handle, 0x112, 0xf012, 0);
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Close();
            new MainForm(connectionDB).Show();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }
        private void button4_Click(object sender, EventArgs e)
        {
            if (InputPosition.Text.Trim(' ').Length != 0)
            {
                if (!position.AddPosition(InputPosition.Text))
                {
                    MessageBox.Show(position.exception, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                else
                {
                    MessageBox.Show("Данные успешно добавлены!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    InputPosition.Clear();
                    PositionInfo.Rows.Clear();
                    position.GetAllPositions(out structPositions);
                    foreach (var pos in structPositions)
                        PositionInfo.Rows.Add(pos.id, pos.name);
                }
            }
        }
        private void PositionInfo_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn & senderGrid.Columns[e.ColumnIndex].Name == "DeletePosition" && e.RowIndex >= 0 & edit_data == true)
            {
                int ID_Delete = (int)PositionInfo.Rows[e.RowIndex].Cells[0].Value;
                position.DeletePosition(ID_Delete);
                PositionInfo.Rows.Clear();
                structPositions.Clear();
                position.GetAllPositions(out structPositions);
                foreach (var pos in structPositions)
                    PositionInfo.Rows.Add(pos.id, pos.name);
            }
        }
    }
}