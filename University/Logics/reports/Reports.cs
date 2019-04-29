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
        public bool RunReports(MainTable.TimeTable.type_oplaty_teacher type_Oplaty_Teacher,string faculty,string department, DateTime month,DateTime start_semestr,string path_to_dir)
        {
            BinaryWriter binaryWriter = new BinaryWriter(File.OpenWrite(Path.Combine(path_to_dir, "otchet" + month.ToString() + file_excep)));
            binaryWriter.Write(Resource1.journal);
            binaryWriter.Close();
            excel = new Excel.Application();
            Workbook = excel.Workbooks.Open(Path.Combine(path_to_dir, month.ToString() + file_excep));
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
                    sheetPivot.Name = q.nameteacher;

                    /*дописать вывод в страницы уже самого отчета*/

                    i += 1;
                    j += 1;
                }
            }

            Workbook.Save();
            return true;
        }
    }
}
