namespace UniversityMain
{
    partial class Discipline
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Discipline));
            this.panel1 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.DisciplineInfo = new System.Windows.Forms.DataGridView();
            this.IDDiscipline = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NameDiscipline = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DeleteDiscipline = new System.Windows.Forms.DataGridViewButtonColumn();
            this.EditDiscipline = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel3 = new System.Windows.Forms.Panel();
            this.button4 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.InputDiscipline = new System.Windows.Forms.TextBox();
            this.DownButton = new System.Windows.Forms.Button();
            this.UpButton = new System.Windows.Forms.Button();
            this.FacultyBox = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.DepartmentBox = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DisciplineInfo)).BeginInit();
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
            this.panel1.Size = new System.Drawing.Size(523, 44);
            this.panel1.TabIndex = 3;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Discipline_50_;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(70, 44);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 15;
            this.pictureBox1.TabStop = false;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(77, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 20);
            this.label4.TabIndex = 14;
            this.label4.Text = "Дисциплины";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(450, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(73, 44);
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
            // DisciplineInfo
            // 
            this.DisciplineInfo.AllowUserToAddRows = false;
            this.DisciplineInfo.AllowUserToDeleteRows = false;
            this.DisciplineInfo.BackgroundColor = System.Drawing.Color.White;
            this.DisciplineInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.DisciplineInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.DisciplineInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DisciplineInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IDDiscipline,
            this.NameDiscipline,
            this.DeleteDiscipline,
            this.EditDiscipline});
            this.DisciplineInfo.Location = new System.Drawing.Point(0, 42);
            this.DisciplineInfo.Name = "DisciplineInfo";
            this.DisciplineInfo.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DisciplineInfo.RowsDefaultCellStyle = dataGridViewCellStyle2;
            this.DisciplineInfo.Size = new System.Drawing.Size(523, 297);
            this.DisciplineInfo.TabIndex = 4;
            this.DisciplineInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.DisciplineInfo_CellContentClick);
            // 
            // IDDiscipline
            // 
            this.IDDiscipline.HeaderText = "ID";
            this.IDDiscipline.Name = "IDDiscipline";
            this.IDDiscipline.ReadOnly = true;
            this.IDDiscipline.Visible = false;
            // 
            // NameDiscipline
            // 
            this.NameDiscipline.HeaderText = "Название";
            this.NameDiscipline.Name = "NameDiscipline";
            this.NameDiscipline.ReadOnly = true;
            this.NameDiscipline.Width = 300;
            // 
            // DeleteDiscipline
            // 
            this.DeleteDiscipline.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.DeleteDiscipline.HeaderText = "Удалить";
            this.DeleteDiscipline.Name = "DeleteDiscipline";
            this.DeleteDiscipline.ReadOnly = true;
            this.DeleteDiscipline.Width = 80;
            // 
            // EditDiscipline
            // 
            this.EditDiscipline.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.EditDiscipline.HeaderText = "Изменить";
            this.EditDiscipline.Name = "EditDiscipline";
            this.EditDiscipline.ReadOnly = true;
            this.EditDiscipline.Width = 80;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label1);
            this.panel3.Controls.Add(this.InputDiscipline);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Location = new System.Drawing.Point(0, 447);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(523, 48);
            this.panel3.TabIndex = 5;
            this.panel3.Visible = false;
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.OK;
            this.button4.Location = new System.Drawing.Point(483, 8);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(40, 24);
            this.button4.TabIndex = 11;
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(5, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(75, 18);
            this.label1.TabIndex = 8;
            this.label1.Text = "Название";
            // 
            // InputDiscipline
            // 
            this.InputDiscipline.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputDiscipline.Location = new System.Drawing.Point(92, 8);
            this.InputDiscipline.Name = "InputDiscipline";
            this.InputDiscipline.Size = new System.Drawing.Size(374, 24);
            this.InputDiscipline.TabIndex = 7;
            // 
            // DownButton
            // 
            this.DownButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DownButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DownButton.Image = ((System.Drawing.Image)(resources.GetObject("DownButton.Image")));
            this.DownButton.Location = new System.Drawing.Point(495, 345);
            this.DownButton.Name = "DownButton";
            this.DownButton.Size = new System.Drawing.Size(24, 23);
            this.DownButton.TabIndex = 15;
            this.DownButton.UseVisualStyleBackColor = true;
            this.DownButton.Click += new System.EventHandler(this.DownButton_Click);
            // 
            // UpButton
            // 
            this.UpButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.UpButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.UpButton.Image = global::UniversityMain.Properties.Resources.UP;
            this.UpButton.Location = new System.Drawing.Point(465, 345);
            this.UpButton.Name = "UpButton";
            this.UpButton.Size = new System.Drawing.Size(24, 23);
            this.UpButton.TabIndex = 14;
            this.UpButton.UseVisualStyleBackColor = true;
            this.UpButton.Click += new System.EventHandler(this.UpButton_Click);
            // 
            // FacultyBox
            // 
            this.FacultyBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.FacultyBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FacultyBox.FormattingEnabled = true;
            this.FacultyBox.Location = new System.Drawing.Point(94, 381);
            this.FacultyBox.Name = "FacultyBox";
            this.FacultyBox.Size = new System.Drawing.Size(374, 24);
            this.FacultyBox.TabIndex = 19;
            this.FacultyBox.SelectedIndexChanged += new System.EventHandler(this.FacultyBox_SelectedIndexChanged_1);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(3, 386);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(83, 18);
            this.label3.TabIndex = 18;
            this.label3.Text = "Факультет";
            // 
            // DepartmentBox
            // 
            this.DepartmentBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DepartmentBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DepartmentBox.FormattingEnabled = true;
            this.DepartmentBox.Location = new System.Drawing.Point(94, 416);
            this.DepartmentBox.Name = "DepartmentBox";
            this.DepartmentBox.Size = new System.Drawing.Size(374, 24);
            this.DepartmentBox.TabIndex = 17;
            this.DepartmentBox.SelectedIndexChanged += new System.EventHandler(this.DepartmentBox_SelectedIndexChanged_1);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(5, 419);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(72, 18);
            this.label2.TabIndex = 16;
            this.label2.Text = "Кафедра";
            // 
            // Discipline
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.ClientSize = new System.Drawing.Size(523, 495);
            this.Controls.Add(this.FacultyBox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.DepartmentBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.DownButton);
            this.Controls.Add(this.UpButton);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.DisciplineInfo);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Discipline";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Discipline";
            this.Load += new System.EventHandler(this.Discipline_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.DisciplineInfo)).EndInit();
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
        private System.Windows.Forms.DataGridView DisciplineInfo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox InputDiscipline;
        private System.Windows.Forms.Button UpButton;
        private System.Windows.Forms.Button DownButton;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDDiscipline;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameDiscipline;
        private System.Windows.Forms.DataGridViewButtonColumn DeleteDiscipline;
        private System.Windows.Forms.DataGridViewButtonColumn EditDiscipline;
        private System.Windows.Forms.ComboBox FacultyBox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox DepartmentBox;
        private System.Windows.Forms.Label label2;
    }
}