namespace UniversityMain
{
    partial class WeekForm
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
            this.WeekInfo = new System.Windows.Forms.DataGridView();
            this.panel3 = new System.Windows.Forms.Panel();
            this.WeekBox = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.button4 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.InputWeek = new System.Windows.Forms.TextBox();
            this.IDWeek = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NameWeek = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TypeWeek = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DeleteWeek = new System.Windows.Forms.DataGridViewButtonColumn();
            this.EditWeek = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.WeekInfo)).BeginInit();
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
            this.panel1.TabIndex = 4;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Week__50_;
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
            this.label4.Font = new System.Drawing.Font("Century Gothic", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(77, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 21);
            this.label4.TabIndex = 14;
            this.label4.Text = "Дни недели";
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
            // WeekInfo
            // 
            this.WeekInfo.AllowUserToAddRows = false;
            this.WeekInfo.AllowUserToDeleteRows = false;
            this.WeekInfo.BackgroundColor = System.Drawing.Color.White;
            this.WeekInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.WeekInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.WeekInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.WeekInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.IDWeek,
            this.NameWeek,
            this.TypeWeek,
            this.DeleteWeek,
            this.EditWeek});
            this.WeekInfo.Location = new System.Drawing.Point(0, 42);
            this.WeekInfo.Name = "WeekInfo";
            this.WeekInfo.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.WeekInfo.RowsDefaultCellStyle = dataGridViewCellStyle2;
            this.WeekInfo.Size = new System.Drawing.Size(523, 297);
            this.WeekInfo.TabIndex = 5;
            this.WeekInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.WeekInfo_CellContentClick);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.WeekBox);
            this.panel3.Controls.Add(this.label3);
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label1);
            this.panel3.Controls.Add(this.InputWeek);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Location = new System.Drawing.Point(0, 340);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(523, 123);
            this.panel3.TabIndex = 6;
            // 
            // WeekBox
            // 
            this.WeekBox.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.WeekBox.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.WeekBox.FormattingEnabled = true;
            this.WeekBox.Items.AddRange(new object[] {
            "Верхняя неделя",
            "Нижняя неделя"});
            this.WeekBox.Location = new System.Drawing.Point(103, 45);
            this.WeekBox.Name = "WeekBox";
            this.WeekBox.Size = new System.Drawing.Size(374, 25);
            this.WeekBox.TabIndex = 15;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(6, 45);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(91, 20);
            this.label3.TabIndex = 14;
            this.label3.Text = "Тип недели";
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button4.Image = global::UniversityMain.Properties.Resources.OK;
            this.button4.Location = new System.Drawing.Point(479, 76);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(40, 40);
            this.button4.TabIndex = 11;
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(17, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 20);
            this.label1.TabIndex = 8;
            this.label1.Text = "Название";
            // 
            // InputWeek
            // 
            this.InputWeek.Font = new System.Drawing.Font("Century Gothic", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.InputWeek.Location = new System.Drawing.Point(103, 8);
            this.InputWeek.Name = "InputWeek";
            this.InputWeek.Size = new System.Drawing.Size(374, 26);
            this.InputWeek.TabIndex = 7;
            // 
            // IDWeek
            // 
            this.IDWeek.HeaderText = "ID";
            this.IDWeek.Name = "IDWeek";
            this.IDWeek.ReadOnly = true;
            this.IDWeek.Visible = false;
            // 
            // NameWeek
            // 
            this.NameWeek.HeaderText = "Название";
            this.NameWeek.Name = "NameWeek";
            this.NameWeek.ReadOnly = true;
            this.NameWeek.Width = 150;
            // 
            // TypeWeek
            // 
            this.TypeWeek.HeaderText = "Тип недели";
            this.TypeWeek.Name = "TypeWeek";
            this.TypeWeek.ReadOnly = true;
            this.TypeWeek.Width = 150;
            // 
            // DeleteWeek
            // 
            this.DeleteWeek.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.DeleteWeek.HeaderText = "Удалить";
            this.DeleteWeek.Name = "DeleteWeek";
            this.DeleteWeek.ReadOnly = true;
            this.DeleteWeek.Width = 80;
            // 
            // EditWeek
            // 
            this.EditWeek.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.EditWeek.HeaderText = "Изменить";
            this.EditWeek.Name = "EditWeek";
            this.EditWeek.ReadOnly = true;
            this.EditWeek.Width = 80;
            // 
            // WeekForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(523, 463);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.WeekInfo);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "WeekForm";
            this.Text = "WeekForm";
            this.Load += new System.EventHandler(this.WeekForm_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.WeekInfo)).EndInit();
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
        private System.Windows.Forms.DataGridView WeekInfo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.ComboBox WeekBox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox InputWeek;
        private System.Windows.Forms.DataGridViewTextBoxColumn IDWeek;
        private System.Windows.Forms.DataGridViewTextBoxColumn NameWeek;
        private System.Windows.Forms.DataGridViewTextBoxColumn TypeWeek;
        private System.Windows.Forms.DataGridViewButtonColumn DeleteWeek;
        private System.Windows.Forms.DataGridViewButtonColumn EditWeek;
    }
}