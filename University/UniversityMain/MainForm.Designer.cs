namespace UniversityMain
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.VerticalMenu = new System.Windows.Forms.Panel();
            this.INFO = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.VerticalMenuStatus = new System.Windows.Forms.Button();
            this.button8 = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button7 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.timetable = new System.Windows.Forms.Button();
            this.VerticalMenu.SuspendLayout();
            this.INFO.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // VerticalMenu
            // 
            this.VerticalMenu.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.VerticalMenu.Controls.Add(this.INFO);
            this.VerticalMenu.Controls.Add(this.label1);
            this.VerticalMenu.Controls.Add(this.button4);
            this.VerticalMenu.Controls.Add(this.timetable);
            this.VerticalMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.VerticalMenu.Location = new System.Drawing.Point(0, 0);
            this.VerticalMenu.Name = "VerticalMenu";
            this.VerticalMenu.Size = new System.Drawing.Size(210, 615);
            this.VerticalMenu.TabIndex = 1;
            // 
            // INFO
            // 
            this.INFO.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.INFO.Controls.Add(this.button8);
            this.INFO.Controls.Add(this.pictureBox1);
            this.INFO.Controls.Add(this.label2);
            this.INFO.Controls.Add(this.button7);
            this.INFO.Controls.Add(this.button6);
            this.INFO.Controls.Add(this.button5);
            this.INFO.Location = new System.Drawing.Point(0, 111);
            this.INFO.Name = "INFO";
            this.INFO.Size = new System.Drawing.Size(210, 42);
            this.INFO.TabIndex = 6;
            this.INFO.Click += new System.EventHandler(this.INFO_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Century Gothic", 14.25F);
            this.label2.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.label2.Location = new System.Drawing.Point(52, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(137, 22);
            this.label2.TabIndex = 0;
            this.label2.Text = "Справочники";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Century Gothic", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(66, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(91, 30);
            this.label1.TabIndex = 4;
            this.label1.Text = "МЕНЮ";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Controls.Add(this.VerticalMenuStatus);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(210, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(899, 44);
            this.panel1.TabIndex = 3;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown_1);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button3);
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(789, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(110, 44);
            this.panel2.TabIndex = 1;
            // 
            // button3
            // 
            this.button3.FlatAppearance.BorderSize = 0;
            this.button3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button3.Image = global::UniversityMain.Properties.Resources.Maximize;
            this.button3.Location = new System.Drawing.Point(37, 8);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(30, 28);
            this.button3.TabIndex = 5;
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click_2);
            // 
            // button2
            // 
            this.button2.FlatAppearance.BorderSize = 0;
            this.button2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button2.Image = global::UniversityMain.Properties.Resources.Minimize;
            this.button2.Location = new System.Drawing.Point(1, 8);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(30, 28);
            this.button2.TabIndex = 4;
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click_2);
            // 
            // button1
            // 
            this.button1.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Image = global::UniversityMain.Properties.Resources.close;
            this.button1.Location = new System.Drawing.Point(73, 8);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(30, 28);
            this.button1.TabIndex = 3;
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_2);
            // 
            // VerticalMenuStatus
            // 
            this.VerticalMenuStatus.FlatAppearance.BorderSize = 0;
            this.VerticalMenuStatus.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.VerticalMenuStatus.ForeColor = System.Drawing.Color.Black;
            this.VerticalMenuStatus.Image = ((System.Drawing.Image)(resources.GetObject("VerticalMenuStatus.Image")));
            this.VerticalMenuStatus.Location = new System.Drawing.Point(3, 3);
            this.VerticalMenuStatus.Name = "VerticalMenuStatus";
            this.VerticalMenuStatus.Size = new System.Drawing.Size(40, 38);
            this.VerticalMenuStatus.TabIndex = 2;
            this.VerticalMenuStatus.UseVisualStyleBackColor = true;
            this.VerticalMenuStatus.Click += new System.EventHandler(this.button4_Click);
            // 
            // button8
            // 
            this.button8.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button8.FlatAppearance.BorderSize = 0;
            this.button8.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button8.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button8.Image = global::UniversityMain.Properties.Resources.Classroom;
            this.button8.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button8.Location = new System.Drawing.Point(-1, 196);
            this.button8.Name = "button8";
            this.button8.Size = new System.Drawing.Size(210, 42);
            this.button8.TabIndex = 8;
            this.button8.Text = "        Аудитории";
            this.button8.UseVisualStyleBackColor = true;
            this.button8.Click += new System.EventHandler(this.button8_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.OpenDir;
            this.pictureBox1.ImageLocation = "";
            this.pictureBox1.Location = new System.Drawing.Point(3, 3);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(32, 32);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 7;
            this.pictureBox1.TabStop = false;
            this.pictureBox1.Click += new System.EventHandler(this.pictureBox1_Click);
            // 
            // button7
            // 
            this.button7.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button7.FlatAppearance.BorderSize = 0;
            this.button7.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button7.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button7.Image = global::UniversityMain.Properties.Resources.Groups;
            this.button7.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button7.Location = new System.Drawing.Point(-1, 148);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(210, 42);
            this.button7.TabIndex = 5;
            this.button7.Text = "        Группы";
            this.button7.UseVisualStyleBackColor = true;
            this.button7.Click += new System.EventHandler(this.button7_Click);
            // 
            // button6
            // 
            this.button6.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button6.FlatAppearance.BorderSize = 0;
            this.button6.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button6.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button6.Image = global::UniversityMain.Properties.Resources.Teacher;
            this.button6.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button6.Location = new System.Drawing.Point(-1, 52);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(210, 42);
            this.button6.TabIndex = 2;
            this.button6.Text = "   Преподаватели";
            this.button6.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.button6.UseVisualStyleBackColor = true;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // button5
            // 
            this.button5.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button5.FlatAppearance.BorderSize = 0;
            this.button5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button5.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button5.Image = global::UniversityMain.Properties.Resources.Department;
            this.button5.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button5.Location = new System.Drawing.Point(-3, 100);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(210, 42);
            this.button5.TabIndex = 1;
            this.button5.Text = "         Факультеты";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button4
            // 
            this.button4.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.Help;
            this.button4.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button4.Location = new System.Drawing.Point(0, 573);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(210, 42);
            this.button4.TabIndex = 3;
            this.button4.Text = "         Помощь";
            this.button4.UseVisualStyleBackColor = true;
            // 
            // timetable
            // 
            this.timetable.Cursor = System.Windows.Forms.Cursors.Hand;
            this.timetable.FlatAppearance.BorderSize = 0;
            this.timetable.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.timetable.Font = new System.Drawing.Font("Century Gothic", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.timetable.Image = ((System.Drawing.Image)(resources.GetObject("timetable.Image")));
            this.timetable.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.timetable.Location = new System.Drawing.Point(-1, 63);
            this.timetable.Name = "timetable";
            this.timetable.Size = new System.Drawing.Size(210, 42);
            this.timetable.TabIndex = 0;
            this.timetable.Text = "         Расписание";
            this.timetable.UseVisualStyleBackColor = true;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.ClientSize = new System.Drawing.Size(1109, 615);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.VerticalMenu);
            this.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MainForm";
            this.VerticalMenu.ResumeLayout(false);
            this.VerticalMenu.PerformLayout();
            this.INFO.ResumeLayout(false);
            this.INFO.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel VerticalMenu;
        private System.Windows.Forms.Button VerticalMenuStatus;
        private System.Windows.Forms.Button timetable;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button7;
        private System.Windows.Forms.Panel INFO;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button button8;
    }
}