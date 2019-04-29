namespace UniversityMain
{
    partial class Teachers
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            this.panel1 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.DepartmentBox = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.FacultyBox = new System.Windows.Forms.ComboBox();
            this.TeacherInfo = new System.Windows.Forms.DataGridView();
            this.NameGroup = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.YearOfEntry = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GetDiscipline = new System.Windows.Forms.DataGridViewButtonColumn();
            this.DeleteTeacher = new System.Windows.Forms.DataGridViewButtonColumn();
            this.EditTeacher = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel3 = new System.Windows.Forms.Panel();
            this.button3 = new System.Windows.Forms.Button();
            this.label11 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.EmailTeacher = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.NameTeacher = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.FacultyInputBox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.DepartmentInputBox = new System.Windows.Forms.ComboBox();
            this.PositionBox = new System.Windows.Forms.ComboBox();
            this.button5 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.InputRating = new System.Windows.Forms.TextBox();
            this.label12 = new System.Windows.Forms.Label();
            this.PolStavka = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.TeacherInfo)).BeginInit();
            this.panel3.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.panel1.Controls.Add(this.pictureBox1);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1107, 44);
            this.panel1.TabIndex = 5;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Teacher_50px_;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(70, 44);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 13;
            this.pictureBox1.TabStop = false;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(76, 10);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(132, 20);
            this.label4.TabIndex = 12;
            this.label4.Text = "Преподаватели";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(1030, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(77, 44);
            this.panel2.TabIndex = 1;
            // 
            // button2
            // 
            this.button2.FlatAppearance.BorderSize = 0;
            this.button2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button2.Image = global::UniversityMain.Properties.Resources.Minimize;
            this.button2.Location = new System.Drawing.Point(3, 8);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(30, 28);
            this.button2.TabIndex = 4;
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Image = global::UniversityMain.Properties.Resources.close;
            this.button1.Location = new System.Drawing.Point(39, 8);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(30, 28);
            this.button1.TabIndex = 3;
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(424, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(72, 18);
            this.label2.TabIndex = 16;
            this.label2.Text = "Кафедра";
            // 
            // DepartmentBox
            // 
            this.DepartmentBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DepartmentBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DepartmentBox.FormattingEnabled = true;
            this.DepartmentBox.Location = new System.Drawing.Point(513, 57);
            this.DepartmentBox.Name = "DepartmentBox";
            this.DepartmentBox.Size = new System.Drawing.Size(305, 24);
            this.DepartmentBox.TabIndex = 15;
            this.DepartmentBox.SelectedIndexChanged += new System.EventHandler(this.DepartmentBox_SelectedIndexChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(13, 57);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(83, 18);
            this.label1.TabIndex = 14;
            this.label1.Text = "Факультет";
            // 
            // FacultyBox
            // 
            this.FacultyBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.FacultyBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FacultyBox.FormattingEnabled = true;
            this.FacultyBox.Location = new System.Drawing.Point(104, 57);
            this.FacultyBox.Name = "FacultyBox";
            this.FacultyBox.Size = new System.Drawing.Size(305, 24);
            this.FacultyBox.TabIndex = 13;
            this.FacultyBox.SelectedIndexChanged += new System.EventHandler(this.faculty_choise_SelectedIndexChanged);
            // 
            // TeacherInfo
            // 
            this.TeacherInfo.AllowUserToAddRows = false;
            this.TeacherInfo.AllowUserToDeleteRows = false;
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.TeacherInfo.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle5;
            this.TeacherInfo.BackgroundColor = System.Drawing.Color.White;
            this.TeacherInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle6.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.TeacherInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle6;
            this.TeacherInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.TeacherInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.NameGroup,
            this.YearOfEntry,
            this.email,
            this.GetDiscipline,
            this.DeleteTeacher,
            this.EditTeacher});
            this.TeacherInfo.Location = new System.Drawing.Point(7, 88);
            this.TeacherInfo.Name = "TeacherInfo";
            this.TeacherInfo.ReadOnly = true;
            this.TeacherInfo.Size = new System.Drawing.Size(1088, 267);
            this.TeacherInfo.TabIndex = 12;
            this.TeacherInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.TeacherInfo_CellContentClick);
            // 
            // NameGroup
            // 
            this.NameGroup.HeaderText = "Имя";
            this.NameGroup.Name = "NameGroup";
            this.NameGroup.ReadOnly = true;
            this.NameGroup.Width = 300;
            // 
            // YearOfEntry
            // 
            this.YearOfEntry.HeaderText = "Должность";
            this.YearOfEntry.Name = "YearOfEntry";
            this.YearOfEntry.ReadOnly = true;
            this.YearOfEntry.Width = 250;
            // 
            // email
            // 
            this.email.HeaderText = "Email";
            this.email.Name = "email";
            this.email.ReadOnly = true;
            this.email.Width = 225;
            // 
            // GetDiscipline
            // 
            this.GetDiscipline.HeaderText = "Предметы";
            this.GetDiscipline.Name = "GetDiscipline";
            this.GetDiscipline.ReadOnly = true;
            // 
            // DeleteTeacher
            // 
            this.DeleteTeacher.HeaderText = "Удалить";
            this.DeleteTeacher.Name = "DeleteTeacher";
            this.DeleteTeacher.ReadOnly = true;
            this.DeleteTeacher.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.DeleteTeacher.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.DeleteTeacher.Width = 80;
            // 
            // EditTeacher
            // 
            this.EditTeacher.HeaderText = "Изменить";
            this.EditTeacher.Name = "EditTeacher";
            this.EditTeacher.ReadOnly = true;
            this.EditTeacher.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.EditTeacher.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.EditTeacher.Width = 80;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.label12);
            this.panel3.Controls.Add(this.PolStavka);
            this.panel3.Controls.Add(this.button3);
            this.panel3.Controls.Add(this.label11);
            this.panel3.Controls.Add(this.label10);
            this.panel3.Controls.Add(this.textBox3);
            this.panel3.Controls.Add(this.label3);
            this.panel3.Controls.Add(this.EmailTeacher);
            this.panel3.Controls.Add(this.label8);
            this.panel3.Controls.Add(this.NameTeacher);
            this.panel3.Controls.Add(this.label7);
            this.panel3.Controls.Add(this.FacultyInputBox);
            this.panel3.Controls.Add(this.label6);
            this.panel3.Controls.Add(this.label5);
            this.panel3.Controls.Add(this.DepartmentInputBox);
            this.panel3.Controls.Add(this.PositionBox);
            this.panel3.Controls.Add(this.button5);
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label9);
            this.panel3.Controls.Add(this.InputRating);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Location = new System.Drawing.Point(0, 375);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(1107, 148);
            this.panel3.TabIndex = 17;
            this.panel3.Visible = false;
            // 
            // button3
            // 
            this.button3.FlatAppearance.BorderSize = 0;
            this.button3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button3.Image = global::UniversityMain.Properties.Resources.Discipline;
            this.button3.Location = new System.Drawing.Point(417, 70);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(46, 34);
            this.button3.TabIndex = 29;
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label11.Location = new System.Drawing.Point(306, 76);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(96, 18);
            this.label11.TabIndex = 28;
            this.label11.Text = "Дисциплины";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label10.Location = new System.Drawing.Point(704, 70);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(85, 18);
            this.label10.TabIndex = 27;
            this.label10.Text = "Почасовка";
            // 
            // textBox3
            // 
            this.textBox3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.textBox3.Location = new System.Drawing.Point(795, 68);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(190, 21);
            this.textBox3.TabIndex = 26;
            this.textBox3.Text = "0";
            this.textBox3.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox3_KeyPress);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(48, 36);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(45, 18);
            this.label3.TabIndex = 25;
            this.label3.Text = "Email";
            // 
            // EmailTeacher
            // 
            this.EmailTeacher.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.EmailTeacher.Location = new System.Drawing.Point(100, 36);
            this.EmailTeacher.Name = "EmailTeacher";
            this.EmailTeacher.Size = new System.Drawing.Size(190, 21);
            this.EmailTeacher.TabIndex = 24;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label8.Location = new System.Drawing.Point(48, 8);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(44, 18);
            this.label8.TabIndex = 23;
            this.label8.Text = "ФИО";
            // 
            // NameTeacher
            // 
            this.NameTeacher.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.NameTeacher.Location = new System.Drawing.Point(100, 8);
            this.NameTeacher.Name = "NameTeacher";
            this.NameTeacher.Size = new System.Drawing.Size(190, 21);
            this.NameTeacher.TabIndex = 22;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label7.Location = new System.Drawing.Point(324, 8);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(83, 18);
            this.label7.TabIndex = 21;
            this.label7.Text = "Факультет";
            // 
            // FacultyInputBox
            // 
            this.FacultyInputBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.FacultyInputBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FacultyInputBox.FormattingEnabled = true;
            this.FacultyInputBox.Location = new System.Drawing.Point(417, 8);
            this.FacultyInputBox.Name = "FacultyInputBox";
            this.FacultyInputBox.Size = new System.Drawing.Size(248, 23);
            this.FacultyInputBox.TabIndex = 20;
            this.FacultyInputBox.SelectedIndexChanged += new System.EventHandler(this.FacultyInputBox_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label6.Location = new System.Drawing.Point(326, 39);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(72, 18);
            this.label6.TabIndex = 14;
            this.label6.Text = "Кафедра";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.Location = new System.Drawing.Point(3, 64);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(89, 18);
            this.label5.TabIndex = 19;
            this.label5.Text = "Должность";
            // 
            // DepartmentInputBox
            // 
            this.DepartmentInputBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DepartmentInputBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DepartmentInputBox.FormattingEnabled = true;
            this.DepartmentInputBox.Location = new System.Drawing.Point(417, 39);
            this.DepartmentInputBox.Name = "DepartmentInputBox";
            this.DepartmentInputBox.Size = new System.Drawing.Size(248, 23);
            this.DepartmentInputBox.TabIndex = 13;
            // 
            // PositionBox
            // 
            this.PositionBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.PositionBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.PositionBox.FormattingEnabled = true;
            this.PositionBox.Location = new System.Drawing.Point(100, 64);
            this.PositionBox.Name = "PositionBox";
            this.PositionBox.Size = new System.Drawing.Size(190, 23);
            this.PositionBox.TabIndex = 18;
            // 
            // button5
            // 
            this.button5.FlatAppearance.BorderSize = 0;
            this.button5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button5.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button5.Image = global::UniversityMain.Properties.Resources.OK;
            this.button5.Location = new System.Drawing.Point(1057, 102);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(50, 46);
            this.button5.TabIndex = 17;
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.OK;
            this.button4.Location = new System.Drawing.Point(924, 193);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(50, 46);
            this.button4.TabIndex = 10;
            this.button4.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label9.Location = new System.Drawing.Point(725, 15);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(58, 18);
            this.label9.TabIndex = 6;
            this.label9.Text = "Ставка";
            // 
            // InputRating
            // 
            this.InputRating.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputRating.Location = new System.Drawing.Point(795, 13);
            this.InputRating.Name = "InputRating";
            this.InputRating.Size = new System.Drawing.Size(190, 21);
            this.InputRating.TabIndex = 5;
            this.InputRating.Text = "0";
            this.InputRating.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.InputYearEntry_KeyPress);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label12.Location = new System.Drawing.Point(705, 43);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(84, 18);
            this.label12.TabIndex = 31;
            this.label12.Text = "Полставки";
            // 
            // PolStavka
            // 
            this.PolStavka.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.PolStavka.Location = new System.Drawing.Point(795, 41);
            this.PolStavka.Name = "PolStavka";
            this.PolStavka.Size = new System.Drawing.Size(190, 21);
            this.PolStavka.TabIndex = 30;
            this.PolStavka.Text = "0";
            // 
            // Teachers
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1107, 523);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.DepartmentBox);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.FacultyBox);
            this.Controls.Add(this.TeacherInfo);
            this.Controls.Add(this.panel1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "Teachers";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Teachers";
            this.Load += new System.EventHandler(this.Teachers_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.TeacherInfo)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox DepartmentBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox FacultyBox;
        private System.Windows.Forms.DataGridView TeacherInfo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox NameTeacher;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox FacultyInputBox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox DepartmentInputBox;
        private System.Windows.Forms.ComboBox PositionBox;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox InputRating;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox EmailTeacher;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameGroup;
        private System.Windows.Forms.DataGridViewTextBoxColumn YearOfEntry;
        private System.Windows.Forms.DataGridViewTextBoxColumn email;
        private System.Windows.Forms.DataGridViewButtonColumn GetDiscipline;
        private System.Windows.Forms.DataGridViewButtonColumn DeleteTeacher;
        private System.Windows.Forms.DataGridViewButtonColumn EditTeacher;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.TextBox PolStavka;
    }
}