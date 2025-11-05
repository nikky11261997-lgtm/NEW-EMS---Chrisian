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
using static Google.Apis.Sheets.v4.SheetsService;

namespace Employee_Management_System
{
    public partial class ChangePass : System.Web.UI.Page
    {

        string[] Scopes = { SheetsService.Scope.Spreadsheets };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345...
        private static string SheetName = "EmpList"; // Sheet tab name
        private static string SheetNameTime = "TimeKeep";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Welcome.Text = "Change Password";
                name.Text = Session["Username"].ToString();
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
                // 1️⃣ Load Google credentials
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(SheetsService.Scope.Spreadsheets);
                }

                // 2️⃣ Create Sheets API service
                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                // 3️⃣ Read data from Google Sheet (A: Username, B: Password, C: UserType, etc.)
                var range = $"{SheetNameTime}!A2:E";
                var request = service.Spreadsheets.Values.Get(SpreadsheetId, range);
                var response = request.Execute();
                var values = response.Values;

                if (values == null || values.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('No employee data found.');", true);
                    return;
                }

                string username = name.Text.Trim();
                string oldPW = TxtboxOldPW.Text.Trim();
                string newPW = TxtboxConfirmPW.Text.Trim();

                int rowIndex = 2; // start from 2 because A1:E1 are headers
                string userType = "";
                bool found = false;

                // 4️⃣ Find matching row
                foreach (var row in values)
                {
                    if (row.Count >= 2 && row[0].ToString().Equals(username, StringComparison.OrdinalIgnoreCase)
                        && row[1].ToString().Equals(oldPW))
                    {
                        found = true;
                        if (row.Count >= 3) userType = row[2].ToString();
                        break;
                    }
                    rowIndex++;
                }

                if (!found)
                {
                    TxtboxOldPW.Focus();
                    TxtboxOldPW.Text = String.Empty;
                    TxtboxPassword.Text = String.Empty;
                    TxtboxConfirmPW.Text = String.Empty;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('Old Password is Invalid!');", true);
                    return;
                }


                //DataRow[] res = dt.Select("Password=" + TxtboxOldPW.Text);
                //if (res.Count() > 0)
                //{
                if (TxtboxOldPW.Text.Equals(""))
                {
                    TxtboxOldPW.Focus();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please input Old Password!');", true);
                }
                else if ((TxtboxOldPW.Text != null) && TxtboxPassword.Text.Equals(""))
                {
                    TxtboxOldPW.Focus();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please input New Password!');", true);
                }
                else if ((TxtboxOldPW.Text != null) && (TxtboxPassword.Text != null) && TxtboxConfirmPW.Text.Equals(""))
                {
                    TxtboxOldPW.Focus();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please confirm Password!');", true);
                }
                else if (TxtboxPassword.Text != TxtboxConfirmPW.Text)
                {
                    TxtboxOldPW.Focus();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Passwords do not match!');", true);
                }
        
                else if (TxtboxOldPW.Text.Equals(""))
                {
                    TxtboxOldPW.Focus();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please input Old Password!');", true);
                }
                else
                {
                    TxtboxOldPW.Focus();
                    TxtboxOldPW.Text = String.Empty;
                    TxtboxPassword.Text = String.Empty;
                    TxtboxConfirmPW.Text = String.Empty;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Old Password is Invalid!');", true);
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                    $"alert('Error: {ex.Message}');", true);
            }

        }
        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                // 1️⃣ Load Google credentials
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(SheetsService.Scope.Spreadsheets);
                }

                // 2️⃣ Create Sheets API service
                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                // 3️⃣ Read EmpList sheet data
                string range = $"{SheetName}!A2:J"; // Adjust columns as needed (Username, UserType, etc.)
                var request = service.Spreadsheets.Values.Get(SpreadsheetId, range);
                var response = request.Execute();
                var values = response.Values;

                if (values == null || values.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('No employee records found in Google Sheet.');", true);
                    return;
                }

                // 4️⃣ Find user by username 
                string username = name.Text.Trim();
                string userType = null;

                foreach (var row in values)
                {
                    // Assuming Username is in column H (index 7), UserType in column E (index 4)
                    if (row.Count > 1 && row[1].ToString().Equals(username, StringComparison.OrdinalIgnoreCase))
                    {
                        if (row.Count > 4)
                            userType = row[4].ToString();
                        break;
                    }
                }

                // 5️⃣ Redirect based on user type
                if (!string.IsNullOrEmpty(userType))
                {
                    if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("AdminDB.aspx?Username=" + username);
                    }
                    else
                    {
                        Response.Redirect("UserDB.aspx?Username=" + username);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('User not found in Google Sheet.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                    $"alert('Error: {ex.Message}');", true);
            }
        }
    }
}