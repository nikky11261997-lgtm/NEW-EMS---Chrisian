using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;

namespace Employee_Management_System 
{
    public class GoogleSheetsData
    {

        public DataTable GetData(string EmpID, string Date, string Year)
        {
            // Google API Scopes
            string[] Scopes = { SheetsService.Scope.SpreadsheetsReadonly };
            string ApplicationName = "Employee Management System";


        // 🔧 Replace with your own Google Sheet info
        string spreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s";
            string sheetName = "TimeKeep"; // Sheet tab name

            // 🔧 Path to credentials.json (from Google Cloud Console)
            string credPath = HttpContext.Current.Server.MapPath("~/App_Data/service-account.json");

            GoogleCredential credential;
            using (var stream = new FileStream(credPath, FileMode.Open, FileAccess.Read))
            {
                credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
            }

            var service = new SheetsService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });

            var range = $"{sheetName}!A:J"; // columns: EmpID, TimeIn, TimeOut
            var request = service.Spreadsheets.Values.Get(spreadsheetId, range);
            var response = request.Execute();
            var values = response.Values;

            DataTable dt = new DataTable();
            dt.Columns.Add("EmpID");
            dt.Columns.Add("TimeIn");
            dt.Columns.Add("TimeOut");

            if (values != null && values.Count > 1)
            {
                foreach (var row in values.Skip(1))
                {
                    if (row.Count >= 7 && row[0].ToString() == EmpID)
                    {
                        dt.Rows.Add(row[0], row[3], row[7]);
                    }
                }
            }

            return dt;
        }
    }

}
