using Npgsql;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Excel = Microsoft.Office.Interop.Excel;

namespace Logics.reports
{
    public  class Reports
    {
        #region Variable
        public string exception = "";
        private string file_excep = ".xls";
        private Functions.Connection.ConnectionDB _connectionDB = null;
        #endregion
        public Reports(Functions.Connection.ConnectionDB connectionDB) => _connectionDB = connectionDB;
        private Excel.Application excel;
        Excel.Workbook Workbook;
        private struct reportsStruct
        {
            public int id;
            public DateTime datesession;
            public TimeSpan Time;
            public int numlesson;
            public string SubnameGroup;
            public int Year_of_Entry;
            public int Housing;
            public int numclassroom;
            public string Name_subject;
            public Books.TypeSubject.type_lesson type_Lesson;
            public string Abbr;
            public DateTime date_para;
        }



        public bool RunReports(MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher,string faculty,string department, DateTime month,DateTime start_semestr,string path_to_dir)
        {
            BinaryWriter binaryWriter = new BinaryWriter(File.OpenWrite(Path.Combine(path_to_dir, "otchet" + file_excep)));
            binaryWriter.Write(Resource1.journal);
            binaryWriter.Close();
            excel = new Excel.Application();
            Workbook = excel.Workbooks.Open(Path.Combine(path_to_dir, "otchet" + file_excep));
            Excel.Worksheet sheet = (Excel.Worksheet)Workbook.Worksheets.get_Item(1);
            sheet.Cells[31, "D"] = department;
            sheet.Cells[35, "D"] = faculty;
            if (month.Month <= 6)
                sheet.Cells[27, "B"] = "весенний";
            else sheet.Cells[27, "B"] = "осенний";
            if (start_semestr.Month < 6)
                sheet.Cells[24, "B"] = (start_semestr.Year - 1).ToString() + "/" + start_semestr.Year.ToString();
            else
                sheet.Cells[24, "B"] = (start_semestr.Year).ToString() + "/" + (start_semestr.Year + 1).ToString();
            sheet = (Excel.Worksheet)Workbook.Worksheets.get_Item(2);
            var _teachers = new MainTable.Teachers(this._connectionDB);
            List<MainTable.Teachers.TeachersStructure> teachers = new List<MainTable.Teachers.TeachersStructure>();
            if (_teachers.GetTeachers(faculty, department, out teachers))
            {
                int i = 1, j = 3;
                foreach (var q in teachers)
                {
                    sheet.Cells[j, "A"] = i;
                    sheet.Cells[j, "B"] = q.nameteacher;
                    sheet.Cells[j, "C"] = q.nameposition;
                    switch(type_Oplaty_Teacher)
                    {
                        case MainTable.TimeTable.type_oplaty_teacher.Pochasovka:
                            sheet.Cells[j, "D"] = q.hourlypayment;
                            break;
                        case MainTable.TimeTable.type_oplaty_teacher.PolStavka:
                            sheet.Cells[j, "D"] = q.pol_stavka;
                            break;
                        case MainTable.TimeTable.type_oplaty_teacher.Stavka:
                            sheet.Cells[j, "D"] = q.rating;
                            break;
                    }
                    sheet.Cells[j, "E"] = j;
                    Excel.Worksheet sheetPivot = (Excel.Worksheet)Workbook.Worksheets.Add(Type.Missing, Workbook.Worksheets[j - 1], Type.Missing, Type.Missing);
                    sheetPivot.Name = q.nameteacher.Split(' ')[0];
                    #region Заполнение отчета
                    /*дописать вывод в страницы уже самого отчета, как в твоем рассписании используя sheetPivot и массив ниже*/
                    List<reportsStruct> reportsStructs = GetReports(type_Oplaty_Teacher, faculty, department, q.nameteacher, month, start_semestr);
                    int tempID = reportsStructs[0].id;
                    string GetRecord = "";
                    for (int k = 0; k < reportsStructs.Count; k++)
                    {
                        if (reportsStructs[k].id == tempID)
                        {
                            GetRecord += reportsStructs[k].SubnameGroup + " " + reportsStructs[k].Year_of_Entry.ToString()[reportsStructs[k].Year_of_Entry.ToString().Length - 2] + reportsStructs[k].Year_of_Entry.ToString()[reportsStructs[k].Year_of_Entry.ToString().Length - 1] + reportsStructs[k].SubnameGroup + " ";
                            /*По идее тут должно быть заполенение*/
                            continue;
                        }
                    }
                    #endregion

                    i += 1;
                    j += 1;
                }
            }

            Workbook.Save();
            return true;
        }

        List<reportsStruct> GetReports(MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher, string faculty, string department,string FIO, DateTime month, DateTime start_semestr)
        {
            List<reportsStruct> _reportsStructs = new List<reportsStruct>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return null; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_reports_from_months('{faculty}','{department}','{FIO}','{type_Oplaty_Teacher}','{month}','{start_semestr}');", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        _reportsStructs.Add(
                            new reportsStruct() {
                                id = reader.GetInt32(0),
                                datesession = reader.GetDateTime(2),
                                Time = reader.GetTimeSpan(2),
                                numlesson = reader.GetInt32(3),
                                SubnameGroup = reader.GetString(4),
                                Year_of_Entry = reader.GetInt32(5),
                                Housing = reader.GetInt32(6),
                                numclassroom = reader.GetInt32(7),
                                Name_subject = reader.GetString(8),
                                type_Lesson = ((reader.GetChar(9) == 'O') ? Books.TypeSubject.type_lesson.Study : Books.TypeSubject.type_lesson.Session),
                                Abbr= reader.GetString(10),
                                date_para=reader.GetDateTime(11)
                            }
                        );
                    }
                conn.Close();
                return _reportsStructs;
            }
            catch (Exception ex)
            {
                exception = ex.Message;
                return null;
            }
        }
    }
}
