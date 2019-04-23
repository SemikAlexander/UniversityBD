namespace UniversityMain
{
    partial class StudyPlan
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            this.panel1 = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.label4 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.PlanStadInfo = new System.Windows.Forms.DataGridView();
            this.StartStuding = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.EndStuding = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.StartSession = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.EndSession = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DeletePlane = new System.Windows.Forms.DataGridViewButtonColumn();
            this.panel3 = new System.Windows.Forms.Panel();
            this.EndSess = new System.Windows.Forms.DateTimePicker();
            this.StartSess = new System.Windows.Forms.DateTimePicker();
            this.EndStad = new System.Windows.Forms.DateTimePicker();
            this.StartStad = new System.Windows.Forms.DateTimePicker();
            this.label8 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.button5 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.PlanStadInfo)).BeginInit();
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
            this.panel1.Size = new System.Drawing.Size(718, 44);
            this.panel1.TabIndex = 5;
            this.panel1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.panel1_MouseDown);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::UniversityMain.Properties.Resources.Syllabus;
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
            this.label4.Font = new System.Drawing.Font("Century Gothic", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(76, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(123, 21);
            this.label4.TabIndex = 12;
            this.label4.Text = "Учебный план";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.button2);
            this.panel2.Controls.Add(this.button1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(641, 0);
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
            // PlanStadInfo
            // 
            this.PlanStadInfo.AllowUserToAddRows = false;
            this.PlanStadInfo.AllowUserToDeleteRows = false;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.PlanStadInfo.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle4;
            this.PlanStadInfo.BackgroundColor = System.Drawing.Color.White;
            this.PlanStadInfo.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle5.BackColor = System.Drawing.Color.White;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Century Gothic", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.PlanStadInfo.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle5;
            this.PlanStadInfo.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.PlanStadInfo.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.StartStuding,
            this.EndStuding,
            this.StartSession,
            this.EndSession,
            this.DeletePlane});
            this.PlanStadInfo.Location = new System.Drawing.Point(12, 47);
            this.PlanStadInfo.Name = "PlanStadInfo";
            this.PlanStadInfo.ReadOnly = true;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            this.PlanStadInfo.RowsDefaultCellStyle = dataGridViewCellStyle6;
            this.PlanStadInfo.Size = new System.Drawing.Size(704, 259);
            this.PlanStadInfo.TabIndex = 6;
            this.PlanStadInfo.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.PlanStadInfo_CellContentClick);
            // 
            // StartStuding
            // 
            this.StartStuding.HeaderText = "Начало учёбы";
            this.StartStuding.Name = "StartStuding";
            this.StartStuding.ReadOnly = true;
            this.StartStuding.Width = 140;
            // 
            // EndStuding
            // 
            this.EndStuding.HeaderText = "Конец учёбы";
            this.EndStuding.Name = "EndStuding";
            this.EndStuding.ReadOnly = true;
            this.EndStuding.Width = 140;
            // 
            // StartSession
            // 
            this.StartSession.HeaderText = "Начало сессии";
            this.StartSession.Name = "StartSession";
            this.StartSession.ReadOnly = true;
            this.StartSession.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.StartSession.Width = 140;
            // 
            // EndSession
            // 
            this.EndSession.HeaderText = "Конец сессии";
            this.EndSession.Name = "EndSession";
            this.EndSession.ReadOnly = true;
            this.EndSession.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.EndSession.Width = 140;
            // 
            // DeletePlane
            // 
            this.DeletePlane.HeaderText = "Удалить";
            this.DeletePlane.Name = "DeletePlane";
            this.DeletePlane.ReadOnly = true;
            this.DeletePlane.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.DeletePlane.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.DeletePlane.Width = 80;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.EndSess);
            this.panel3.Controls.Add(this.StartSess);
            this.panel3.Controls.Add(this.EndStad);
            this.panel3.Controls.Add(this.StartStad);
            this.panel3.Controls.Add(this.label8);
            this.panel3.Controls.Add(this.label6);
            this.panel3.Controls.Add(this.label5);
            this.panel3.Controls.Add(this.button5);
            this.panel3.Controls.Add(this.button4);
            this.panel3.Controls.Add(this.label9);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel3.Font = new System.Drawing.Font("Century Gothic", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.panel3.Location = new System.Drawing.Point(0, 311);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(718, 65);
            this.panel3.TabIndex = 13;
            this.panel3.Visible = false;
            // 
            // EndSess
            // 
            this.EndSess.Location = new System.Drawing.Point(451, 34);
            this.EndSess.Name = "EndSess";
            this.EndSess.Size = new System.Drawing.Size(200, 21);
            this.EndSess.TabIndex = 27;
            // 
            // StartSess
            // 
            this.StartSess.Location = new System.Drawing.Point(451, 8);
            this.StartSess.Name = "StartSess";
            this.StartSess.Size = new System.Drawing.Size(200, 21);
            this.StartSess.TabIndex = 26;
            // 
            // EndStad
            // 
            this.EndStad.Location = new System.Drawing.Point(108, 34);
            this.EndStad.Name = "EndStad";
            this.EndStad.Size = new System.Drawing.Size(200, 21);
            this.EndStad.TabIndex = 25;
            // 
            // StartStad
            // 
            this.StartStad.Location = new System.Drawing.Point(108, 8);
            this.StartStad.Name = "StartStad";
            this.StartStad.Size = new System.Drawing.Size(200, 21);
            this.StartStad.TabIndex = 24;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label8.Location = new System.Drawing.Point(344, 37);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(101, 17);
            this.label8.TabIndex = 23;
            this.label8.Text = "Конец сессии";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label6.Location = new System.Drawing.Point(3, 37);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(91, 17);
            this.label6.TabIndex = 14;
            this.label6.Text = "Конец учёбы";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.Location = new System.Drawing.Point(3, 11);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(99, 17);
            this.label5.TabIndex = 19;
            this.label5.Text = "Начало учёбы";
            // 
            // button5
            // 
            this.button5.FlatAppearance.BorderSize = 0;
            this.button5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button5.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button5.Image = global::UniversityMain.Properties.Resources.OK;
            this.button5.Location = new System.Drawing.Point(657, 8);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(58, 46);
            this.button5.TabIndex = 17;
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button4
            // 
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
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
            this.label9.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label9.Location = new System.Drawing.Point(336, 11);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(109, 17);
            this.label9.TabIndex = 6;
            this.label9.Text = "Начало сессии";
            // 
            // StudyPlan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(718, 376);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.PlanStadInfo);
            this.Controls.Add(this.panel1);
            this.Font = new System.Drawing.Font("Century Gothic", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "StudyPlan";
            this.Text = "StudyPlan";
            this.Load += new System.EventHandler(this.StudyPlan_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.PlanStadInfo)).EndInit();
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
        private System.Windows.Forms.DataGridView PlanStadInfo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.DateTimePicker EndSess;
        private System.Windows.Forms.DateTimePicker StartSess;
        private System.Windows.Forms.DateTimePicker EndStad;
        private System.Windows.Forms.DateTimePicker StartStad;
        private System.Windows.Forms.DataGridViewTextBoxColumn StartStuding;
        private System.Windows.Forms.DataGridViewTextBoxColumn EndStuding;
        private System.Windows.Forms.DataGridViewTextBoxColumn StartSession;
        private System.Windows.Forms.DataGridViewTextBoxColumn EndSession;
        private System.Windows.Forms.DataGridViewButtonColumn DeletePlane;
    }
}