using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
using Google.Apis.Sheets.v4.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Employee_Management_System
{
    public partial class Register : System.Web.UI.Page
    {
        string[] Scopes = { SheetsService.Scope.Spreadsheets };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345...
        private static string SheetName = "EmpList"; // Sheet tab name
        private static string SheetNameTime = "TimeKeep";

        protected void Page_Load(object sender, EventArgs e) 
        {
            Response.Clear();
            TxtboxEmpID.Focus();

            if (Session["Username"] != null)
            {
                Welcome.Text = "Register New User";
            }
            else
            {
                Session.RemoveAll();
                Response.Redirect("Login.aspx");
            }
        }
        protected void BtnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // 1️⃣ Basic validation
                if (string.IsNullOrWhiteSpace(TxtboxEmpID.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxFname.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxLname.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxUsername.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxPassword.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxConfirmPW.Text) ||
                    string.IsNullOrWhiteSpace(TxtboxEmail.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('Please complete all required information!');", true);
                    return;
                }

                if (TxtboxPassword.Text != TxtboxConfirmPW.Text)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('Passwords do not match!');", true);
                    return;
                }

                // 2️⃣ Setup Google credentials
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(SheetsService.Scope.Spreadsheets);
                }

                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = "Employee Management System"
                });

                string range = $"{SheetName}!A2:J"; // Assuming columns A–J are used (adjust as needed)
                var getRequest = service.Spreadsheets.Values.Get(SpreadsheetId, range);
                var getResponse = getRequest.Execute();
                var existing = getResponse.Values ?? new List<IList<object>>();

                // 3️⃣ Check for duplicate EmpID or Email
                bool exists = existing.Any(row =>
                    (row.Count > 0 && row[0].ToString().Equals(TxtboxEmpID.Text, StringComparison.OrdinalIgnoreCase)) ||
                    (row.Count > 5 && row[5].ToString().Equals(TxtboxEmail.Text, StringComparison.OrdinalIgnoreCase)));

                if (exists)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('You are already registered!');window.location='Register.aspx';", true);
                    return;
                }

                // 4️⃣ Prepare data row to insert
                IList<object> newRow = new List<object>
        {
            TxtboxEmpID.Text,          // A - EmpID
              TxtboxUsername.Text,       // H - Username
            TxtboxPassword.Text,       // I - Password
            "Active" ,                  // J - Status
            DdlUserType.SelectedValue, // E - UserType          
            TxtboxFname.Text,          // C - FirstName
            TxtboxLname.Text,          // B - LastName
            TxtboxMname.Text,          // D - MiddleName
            TxtboxEmail.Text,          // F - Email
            TxtboxMobile.Text,         // G - Mobile
          
        };

                // 5️⃣ Append new employee to Google Sheet
                var valueRange = new ValueRange
                {
                    Values = new List<IList<object>> { newRow }
                };

                var appendRequest = service.Spreadsheets.Values.Append(valueRange, SpreadsheetId, range);
                appendRequest.ValueInputOption = SpreadsheetsResource.ValuesResource.AppendRequest.ValueInputOptionEnum.RAW;
                appendRequest.InsertDataOption = SpreadsheetsResource.ValuesResource.AppendRequest.InsertDataOptionEnum.INSERTROWS;
                appendRequest.Execute();

                // 6️⃣ Success message
                Response.Write("<script>alert('Registered successfully!');window.location='AdminDB.aspx';</script>");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDB.aspx");
        }
        protected void BtnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
            TxtboxEmpID.Focus();
        }
    }
}
