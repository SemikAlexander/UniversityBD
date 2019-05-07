using Npgsql;
using System;
using System.Collections.Generic;
using System.Globalization;
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
            try
            {
                List<string> type_subj1 = new List<string>
                {
                    "лекции",
                    "практические (семинарские) занятия",
                    "лабораторные занятия",
                    "НИРС",
                    "контр. раб. студентов-заочников",
                    "проведение консультаций по курсу",
                    "проведение экзаменационнных консультаций",
                    "проверка контр. (мод.)работ, которые вып. в ауд.",
                    "проверка  контр. (мод.) работ (сам. работа)"

                };
                List<string> type_subj2 = new List<string>
                {
                    "рефератов, переводов",
                    "рассчётных, графических, рассч.-граф. работ",
                    "курсовых проектов, работ"
                };
                List<string> type_subj3 = new List<string>
                {
                   "проведение семестровых экзаменов",
                    "руководство практикой",
                    "проведение государственных экзаменов",
                    "рук-во, рец-е и пров-е защит ВКР",
                    "рук-во асп., соискателями и стажировкой преп.",
                    "другие виды учебной нагрузки",
                    "ИТОГО"

                };
                int count = type_subj1.Count + type_subj2.Count + type_subj3.Count;
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
                        switch (type_Oplaty_Teacher)
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
                        sheetPivot=(Excel.Worksheet)Workbook.Worksheets.get_Item(j);

                        var temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[1, "A"], sheetPivot.Cells[1, ((char)((int)'A' + count + 1)).ToString()]];
                        temp.Cells.Merge();
                        sheetPivot.Cells[1, "A"] = q.nameteacher;

                         temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[3, "A"], sheetPivot.Cells[5, "A"]];
                        temp.Cells.Merge();
                        temp.Orientation = 90;
                        sheetPivot.Cells[3, "A"] = "Дата";

                        temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[3, "B"], sheetPivot.Cells[5, "B"]];
                        temp.Cells.Merge();
                        temp.Orientation = 90;
                        sheetPivot.Cells[3, "B"] = "Группа";

                        temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[3, "C"], sheetPivot.Cells[3, ((char)((int)'A' + count + 1)).ToString()]];
                        temp.Cells.Merge();
                        temp.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
                        sheetPivot.Cells[3, "C"] = "Виды занятий";
                        char qtps = 'C';

                        foreach (var tpsub in type_subj1)
                        {
                            temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[4, qtps.ToString()], sheetPivot.Cells[5, qtps.ToString().ToString()]];
                            temp.Cells.Merge();
                            temp.Orientation = 90;
                            sheetPivot.Cells[4, qtps.ToString()] = tpsub;
                            qtps = (char)((int)qtps + 1);
                        }
                        char tmp = qtps;char qtmp = ' ';
                        foreach (var tpsub in type_subj2)
                        {
                            temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[5, qtps.ToString()], sheetPivot.Cells[5, qtps.ToString().ToString()]];
                            temp.Cells.Merge();
                            temp.Orientation = 90;
                            sheetPivot.Cells[5, qtps.ToString()] = tpsub;
                            qtmp = qtps;
                            qtps = (char)((int)qtps + 1);
                        }
                        temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[4, tmp.ToString()], sheetPivot.Cells[4, qtmp.ToString().ToString()]];
                        sheetPivot.Cells[4, tmp.ToString()] = "рук-во и приём инд. заданий:";
                        foreach (var tpsub in type_subj3)
                        {
                            temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[4, qtps.ToString()], sheetPivot.Cells[5, qtps.ToString().ToString()]];
                            temp.Cells.Merge();
                            temp.Orientation = 90;
                            sheetPivot.Cells[4, qtps.ToString()] = tpsub;
                            qtps = (char)((int)qtps + 1);
                        }
                        for (int r = 0; r < count + 1; r++) sheetPivot.Cells[6, ((char)(((int)'C')+r)).ToString()] = r+1;
                        temp = (Excel.Range)sheetPivot.Range[sheetPivot.Cells[7,"A"], sheetPivot.Cells[7, (((char)(((int)'C') + count+1)).ToString())]];
                        temp.Cells.Merge();
                        temp.Cells.HorizontalAlignment = Excel.Constants.xlCenter;
                        var sq = month.ToString("MMMM", CultureInfo.CurrentCulture);
                        sheetPivot.Cells[7, "A"] =sq;
                        


                        List<reportsStruct> reportsStructs = GetReports(type_Oplaty_Teacher, faculty, department, q.nameteacher, month, start_semestr);
                        try
                        {
                            var tempID = reportsStructs[0].date_para;
                            string GetRecord = "";
                            for (int k = 0; k <= reportsStructs.Count; k++)
                            {
                                try
                                {
                                    if (reportsStructs[k].date_para == tempID)
                                    {
                                        GetRecord += reportsStructs[k].Abbr + " " + reportsStructs[k].Year_of_Entry.ToString()[reportsStructs[k].Year_of_Entry.ToString().Length - 2] + reportsStructs[k].Year_of_Entry.ToString()[reportsStructs[k].Year_of_Entry.ToString().Length - 1] + reportsStructs[k].SubnameGroup + ", ";
                                        continue;
                                    }
                                }
                                catch (Exception)
                                {
                                    sheetPivot.Cells[7 + k, "A"] = tempID;
                                    sheetPivot.Cells[7 + k, "B"] = GetRecord;
                                    tempID = reportsStructs[k].date_para;
                                    break;
                                }
                                sheetPivot.Cells[7 + k, "A"] = tempID;
                                sheetPivot.Cells[7 + k, "B"] = GetRecord;
                                tempID = reportsStructs[k].date_para;
                                GetRecord = "";
                                k -= 1;
                            }

                        }
                        catch (Exception)
                        {

                        }
                        #endregion

                        i += 1;
                        j += 1;
                    }
                }

                Workbook.Save();
                Workbook.Close(true);
                return true;
            }
            catch (Exception)
            {
                Workbook.Close(false);

                return false;
            }
        }

        List<reportsStruct> GetReports(MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher, string faculty, string department,string FIO, DateTime month, DateTime start_semestr)
        {
            List<reportsStruct> _reportsStructs = new List<reportsStruct>();
            if (_connectionDB == null) { exception = "Подключение не установленно"; return null; }
            try
            {
                var conn = new NpgsqlConnection(this._connectionDB.ConnectString);
                conn.Open();

                using (var cmd = new NpgsqlCommand($"SELECT * FROM get_reports_from_months('{faculty}','{department}','{FIO}',{(int)type_Oplaty_Teacher},'{month}','{start_semestr}') ORDER BY \"date_para\" ASC;", conn))
                using (var reader = cmd.ExecuteReader())
                    while (reader.Read())
                    {
                        var qqqq = new DateTime(reader.GetDateTime(1).Year, reader.GetDateTime(1).Month, reader.GetDateTime(1).Day);
                        var qqqqq= new DateTime(reader.GetDate(11).Year,
                                reader.GetDate(11).Month,
                                reader.GetDate(11).Day);
                        var qqqqqq = reader.GetTimeSpan(2);
                        _reportsStructs.Add(
                            new reportsStruct() {
                                id = reader.GetInt32(0),
                                datesession = qqqq,
                                Time =qqqqqq,
                                numlesson = reader.GetInt32(3),
                                SubnameGroup = reader.GetString(4),
                                Year_of_Entry = reader.GetInt32(5),
                                Housing = reader.GetInt32(6),
                                numclassroom = reader.GetInt32(7),
                                Name_subject = reader.GetString(8),
                                type_Lesson = ((reader.GetChar(9) == 'O') ? Books.TypeSubject.type_lesson.Study : Books.TypeSubject.type_lesson.Session),
                                Abbr= reader.GetString(10),
                                date_para=qqqqq,
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
