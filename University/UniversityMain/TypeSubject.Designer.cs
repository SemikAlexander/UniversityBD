namespace UniversityMain
{
    partial class TypeSubject
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.SubjectInfo = new System.Windows.Forms.DataGridView();
            this.IDSubject = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NameSubject = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DeleteSubject = new System.Windows.Forms.DataGridViewButtonColumn();
            this.EditSubject = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel3 = new System.Windows.Forms.Panel();
            this.TypeSub = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.button4 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.InputSubject = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.SubjectInfo)).BeginInit();
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
            this.panel1.Size = new System.Drawing.Size(416, 44);
            this.panel1.TabIndex = 3;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Type__50_;
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
            this.label4.Size = new System.Drawing.Size(102, 20);
            this.label4.TabIndex = 14;
            this.label4.Text = "Тип занятий";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(343, 0);
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
            // SubjectInfo
            // 
            this.SubjectInfo.AllowUserToAddRows = false;
            this.SubjectInfo.AllowUserToDeleteRows = false;
            this.SubjectInfo.BackgroundColor = System.Drawing.Color.White;
            this.SubjectInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.SubjectInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.SubjectInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.SubjectInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IDSubject,
            this.NameSubject,
            this.DeleteSubject,
            this.EditSubject});
            this.SubjectInfo.Location = new System.Drawing.Point(0, 42);
            this.SubjectInfo.Name = "SubjectInfo";
            this.SubjectInfo.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.SubjectInfo.RowsDefaultCellStyle = dataGridViewCellStyle2;
            this.SubjectInfo.Size = new System.Drawing.Size(416, 287);
            this.SubjectInfo.TabIndex = 4;
            this.SubjectInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.SubjectInfo_CellContentClick);
            // 
            // IDSubject
            // 
            this.IDSubject.HeaderText = "ID";
            this.IDSubject.Name = "IDSubject";
            this.IDSubject.ReadOnly = true;
            this.IDSubject.Visible = false;
            // 
            // NameSubject
            // 
            this.NameSubject.HeaderText = "Название";
            this.NameSubject.Name = "NameSubject";
            this.NameSubject.ReadOnly = true;
            this.NameSubject.Width = 200;
            // 
            // DeleteSubject
            // 
            this.DeleteSubject.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.DeleteSubject.HeaderText = "Удалить";
            this.DeleteSubject.Name = "DeleteSubject";
            this.DeleteSubject.ReadOnly = true;
            this.DeleteSubject.Width = 80;
            // 
            // EditSubject
            // 
            this.EditSubject.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.EditSubject.HeaderText = "Изменить";
            this.EditSubject.Name = "EditSubject";
            this.EditSubject.ReadOnly = true;
            this.EditSubject.Width = 80;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.TypeSub);
            this.panel3.Controls.Add(this.label2);
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label1);
            this.panel3.Controls.Add(this.InputSubject);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Location = new System.Drawing.Point(0, 339);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(416, 73);
            this.panel3.TabIndex = 5;
            this.panel3.Visible = false;
            // 
            // TypeSub
            // 
            this.TypeSub.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F);
            this.TypeSub.FormattingEnabled = true;
            this.TypeSub.Items.AddRange(new object[] {
            "Сессия",
            "Обучение"});
            this.TypeSub.Location = new System.Drawing.Point(104, 38);
            this.TypeSub.Name = "TypeSub";
            this.TypeSub.Size = new System.Drawing.Size(244, 26);
            this.TypeSub.TabIndex = 14;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(11, 41);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 18);
            this.label2.TabIndex = 13;
            this.label2.Text = "Отношение";
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.OK;
            this.button4.Location = new System.Drawing.Point(354, 8);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(50, 54);
            this.button4.TabIndex = 11;
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(23, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(75, 18);
            this.label1.TabIndex = 8;
            this.label1.Text = "Название";
            // 
            // InputSubject
            // 
            this.InputSubject.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputSubject.Location = new System.Drawing.Point(104, 8);
            this.InputSubject.Name = "InputSubject";
            this.InputSubject.Size = new System.Drawing.Size(244, 24);
            this.InputSubject.TabIndex = 7;
            // 
            // TypeSubject
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(416, 412);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.SubjectInfo);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "TypeSubject";
            this.Text = "TypeSubject";
            this.Load += new System.EventHandler(this.TypeSubject_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.SubjectInfo)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.DataGridView SubjectInfo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox InputSubject;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDSubject;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameSubject;
        private System.Windows.Forms.DataGridViewButtonColumn DeleteSubject;
        private System.Windows.Forms.DataGridViewButtonColumn EditSubject;
        private System.Windows.Forms.ComboBox TypeSub;
        private System.Windows.Forms.Label label2;
    }
}