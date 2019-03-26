namespace UniversityMain
{
    partial class Classroom
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Classroom));
            this.panel1 = new System.Windows.Forms.Panel();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.ClassroomInfo = new System.Windows.Forms.DataGridView();
            this.IDFaculty = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NameFaculty = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Logo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DeleteFaculty = new System.Windows.Forms.DataGridViewButtonColumn();
            this.EditFaculty = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel3 = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.InputClassroom = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.InputHousing = new System.Windows.Forms.TextBox();
            this.UpButton = new System.Windows.Forms.Button();
            this.DownButton = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ClassroomInfo)).BeginInit();
            this.panel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
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
            this.panel1.Size = new System.Drawing.Size(393, 44);
            this.panel1.TabIndex = 2;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Century Gothic", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(77, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(97, 21);
            this.label4.TabIndex = 14;
            this.label4.Text = "Аудитории";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(320, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(73, 44);
            this.panel2.TabIndex = 1;
            // 
            // ClassroomInfo
            // 
            this.ClassroomInfo.AllowUserToAddRows = false;
            this.ClassroomInfo.AllowUserToDeleteRows = false;
            this.ClassroomInfo.BackgroundColor = System.Drawing.Color.White;
            this.ClassroomInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.ClassroomInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.ClassroomInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.ClassroomInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IDFaculty,
            this.NameFaculty,
            this.Logo,
            this.DeleteFaculty,
            this.EditFaculty});
            this.ClassroomInfo.Location = new System.Drawing.Point(0, 42);
            this.ClassroomInfo.Name = "ClassroomInfo";
            this.ClassroomInfo.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.ClassroomInfo.RowsDefaultCellStyle = dataGridViewCellStyle2;
            this.ClassroomInfo.Size = new System.Drawing.Size(393, 297);
            this.ClassroomInfo.TabIndex = 3;
            this.ClassroomInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.ClassroomInfo_CellContentClick);
            // 
            // IDFaculty
            // 
            this.IDFaculty.HeaderText = "ID";
            this.IDFaculty.Name = "IDFaculty";
            this.IDFaculty.ReadOnly = true;
            this.IDFaculty.Visible = false;
            // 
            // NameFaculty
            // 
            this.NameFaculty.HeaderText = "Корпус";
            this.NameFaculty.Name = "NameFaculty";
            this.NameFaculty.ReadOnly = true;
            this.NameFaculty.Width = 90;
            // 
            // Logo
            // 
            this.Logo.HeaderText = "Аудитория";
            this.Logo.Name = "Logo";
            this.Logo.ReadOnly = true;
            this.Logo.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.Logo.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            this.Logo.Width = 90;
            // 
            // DeleteFaculty
            // 
            this.DeleteFaculty.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.DeleteFaculty.HeaderText = "Удалить";
            this.DeleteFaculty.Name = "DeleteFaculty";
            this.DeleteFaculty.ReadOnly = true;
            this.DeleteFaculty.Width = 80;
            // 
            // EditFaculty
            // 
            this.EditFaculty.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.EditFaculty.HeaderText = "Изменить";
            this.EditFaculty.Name = "EditFaculty";
            this.EditFaculty.ReadOnly = true;
            this.EditFaculty.Width = 80;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label2);
            this.panel3.Controls.Add(this.InputClassroom);
            this.panel3.Controls.Add(this.label1);
            this.panel3.Controls.Add(this.InputHousing);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Location = new System.Drawing.Point(0, 386);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(393, 114);
            this.panel3.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(3, 43);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(88, 20);
            this.label2.TabIndex = 10;
            this.label2.Text = "Аудитория";
            // 
            // InputClassroom
            // 
            this.InputClassroom.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputClassroom.Location = new System.Drawing.Point(97, 40);
            this.InputClassroom.Name = "InputClassroom";
            this.InputClassroom.Size = new System.Drawing.Size(236, 26);
            this.InputClassroom.TabIndex = 9;
            this.InputClassroom.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox1_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(26, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(65, 20);
            this.label1.TabIndex = 8;
            this.label1.Text = "Корпус";
            // 
            // InputHousing
            // 
            this.InputHousing.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputHousing.Location = new System.Drawing.Point(97, 8);
            this.InputHousing.Name = "InputHousing";
            this.InputHousing.Size = new System.Drawing.Size(236, 26);
            this.InputHousing.TabIndex = 7;
            this.InputHousing.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.InputNameFaculty_KeyPress);
            // 
            // UpButton
            // 
            this.UpButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.UpButton.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.UpButton.Image = global::UniversityMain.Properties.Resources.UP;
            this.UpButton.Location = new System.Drawing.Point(335, 345);
            this.UpButton.Name = "UpButton";
            this.UpButton.Size = new System.Drawing.Size(24, 23);
            this.UpButton.TabIndex = 13;
            this.UpButton.UseVisualStyleBackColor = true;
            this.UpButton.Click += new System.EventHandler(this.UpButton_Click);
            // 
            // DownButton
            // 
            this.DownButton.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.DownButton.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.DownButton.Image = ((System.Drawing.Image)(resources.GetObject("DownButton.Image")));
            this.DownButton.Location = new System.Drawing.Point(365, 345);
            this.DownButton.Name = "DownButton";
            this.DownButton.Size = new System.Drawing.Size(24, 23);
            this.DownButton.TabIndex = 12;
            this.DownButton.UseVisualStyleBackColor = true;
            this.DownButton.Click += new System.EventHandler(this.DownButton_Click);
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.OK;
            this.button4.Location = new System.Drawing.Point(339, 65);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(50, 46);
            this.button4.TabIndex = 11;
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Classroom_50_;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(70, 44);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 15;
            this.pictureBox1.TabStop = false;
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
            // Classroom
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            this.ClientSize = new System.Drawing.Size(393, 500);
            this.Controls.Add(this.UpButton);
            this.Controls.Add(this.DownButton);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.ClassroomInfo);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Classroom";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Classroom";
            this.Load += new System.EventHandler(this.Classroom_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ClassroomInfo)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridView ClassroomInfo;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDFaculty;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameFaculty;
        private System.Windows.Forms.DataGridViewTextBoxColumn Logo;
        private System.Windows.Forms.DataGridViewButtonColumn DeleteFaculty;
        private System.Windows.Forms.DataGridViewButtonColumn EditFaculty;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox InputHousing;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox InputClassroom;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button DownButton;
        private System.Windows.Forms.Button UpButton;
    }
}