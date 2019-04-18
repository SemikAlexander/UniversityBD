﻿namespace UniversityMain
{
    partial class TransferPara
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.panel3 = new System.Windows.Forms.Panel();
            this.ParaInfo = new System.Windows.Forms.DataGridView();
            this.NameTeacher = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NameLesson = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TransferGroup = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.WeekDay = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NumLesson = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TypeLesson = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ParaInfo)).BeginInit();
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
            this.panel1.Size = new System.Drawing.Size(1038, 44);
            this.panel1.TabIndex = 5;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.Panel1_MouseDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(77, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(116, 20);
            this.label4.TabIndex = 14;
            this.label4.Text = "Перенос пары";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(965, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(73, 44);
            this.panel2.TabIndex = 1;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.TransferLesson_50_;
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
            this.button2.Click += new System.EventHandler(this.Button2_Click);
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
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.ParaInfo);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel3.Location = new System.Drawing.Point(0, 44);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(1038, 319);
            this.panel3.TabIndex = 6;
            // 
            // ParaInfo
            // 
            this.ParaInfo.AllowUserToAddRows = false;
            this.ParaInfo.AllowUserToDeleteRows = false;
            this.ParaInfo.BackgroundColor = System.Drawing.Color.White;
            this.ParaInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.ParaInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.ParaInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.ParaInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.NameTeacher,
            this.NameLesson,
            this.TransferGroup,
            this.WeekDay,
            this.NumLesson,
            this.TypeLesson});
            this.ParaInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ParaInfo.Location = new System.Drawing.Point(0, 0);
            this.ParaInfo.Name = "ParaInfo";
            this.ParaInfo.ReadOnly = true;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.ParaInfo.RowsDefaultCellStyle = dataGridViewCellStyle4;
            this.ParaInfo.Size = new System.Drawing.Size(1038, 319);
            this.ParaInfo.TabIndex = 11;
            // 
            // NameTeacher
            // 
            this.NameTeacher.HeaderText = "Преподаватель";
            this.NameTeacher.Name = "NameTeacher";
            this.NameTeacher.ReadOnly = true;
            this.NameTeacher.Width = 250;
            // 
            // NameLesson
            // 
            this.NameLesson.HeaderText = "Название пары";
            this.NameLesson.Name = "NameLesson";
            this.NameLesson.ReadOnly = true;
            this.NameLesson.Width = 200;
            // 
            // TransferGroup
            // 
            this.TransferGroup.HeaderText = "Группа";
            this.TransferGroup.Name = "TransferGroup";
            this.TransferGroup.ReadOnly = true;
            // 
            // WeekDay
            // 
            this.WeekDay.HeaderText = "День недели";
            this.WeekDay.Name = "WeekDay";
            this.WeekDay.ReadOnly = true;
            this.WeekDay.Width = 175;
            // 
            // NumLesson
            // 
            this.NumLesson.HeaderText = "Номер пары";
            this.NumLesson.Name = "NumLesson";
            this.NumLesson.ReadOnly = true;
            this.NumLesson.Width = 135;
            // 
            // TypeLesson
            // 
            this.TypeLesson.HeaderText = "Тип знятия";
            this.TypeLesson.Name = "TypeLesson";
            this.TypeLesson.ReadOnly = true;
            this.TypeLesson.Width = 135;
            // 
            // TransferPara
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1038, 450);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "TransferPara";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "TransferPara";
            this.Load += new System.EventHandler(this.TransferPara_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ParaInfo)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Panel panel3;
        public System.Windows.Forms.DataGridView ParaInfo;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameTeacher;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameLesson;
        private System.Windows.Forms.DataGridViewTextBoxColumn TransferGroup;
        private System.Windows.Forms.DataGridViewTextBoxColumn WeekDay;
        private System.Windows.Forms.DataGridViewTextBoxColumn NumLesson;
        private System.Windows.Forms.DataGridViewTextBoxColumn TypeLesson;
    }
}