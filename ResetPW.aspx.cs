using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
using Google.Apis.Sheets.v4.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Employee_Management_System
{
    public partial class ResetPW : System.Web.UI.Page
    {

        string[] Scopes = { SheetsService.Scope.Spreadsheets };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345...
        private static string SheetName = "EmpList"; // Sheet tab name
        private static string SheetNameTime = "TimeKeep";
        protected void Page_Load(object sender, EventArgs e)
        {
            TxtboxUsername.Focus();

            if (Session["Username"] != null)
            {
                Welcome.Text = "Reset Password!";
            }
            else
            {
                Session.RemoveAll();
                Response.Redirect("Login.aspx");
            }
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            if (TxtboxUsername.Text.Equals(""))
            {
                //Do Nothing
            }
            else
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(TxtboxUsername.Text))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                            "alert('Please enter a username!');", true);
                        return;
                    }

                    // 1️⃣ Load Google credentials
                    GoogleCredential credential;
                    using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                    {
                        credential = GoogleCredential.FromStream(stream).CreateScoped(SheetsService.Scope.Spreadsheets);
                    }

                    // 2️⃣ Create Google Sheets service
                    var service = new SheetsService(new BaseClientService.Initializer()
                    {
                        HttpClientInitializer = credential,
                        ApplicationName = "Employee Management System"
                    });

                    // 3️⃣ Read all employee records
                    string range = $"{SheetName}!A2:J"; // Assuming A=EmpID ... H=Username, I=Password, J=Status
                    var request = service.Spreadsheets.Values.Get(SpreadsheetId, range);
                    var response = request.Execute();
                    var values = response.Values ?? new List<IList<object>>();

                    // 4️⃣ Find matching username
                    int rowIndex = -1;
                    for (int i = 0; i < values.Count; i++)
                    {
                        if (values[i].Count > 7 && values[i][7].ToString().Equals(TxtboxUsername.Text, StringComparison.OrdinalIgnoreCase))
                        {
                            rowIndex = i + 2; // +2 since sheet starts at row 2
                            break;
                        }
                    }

                    if (rowIndex == -1)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                            "alert('Username not found!');", true);
                        return;
                    }

                    // 5️⃣ Update password to default ("123456")
                    var updateRange = $"{SheetName}!I{rowIndex}";
                    var valueRange = new ValueRange
                    {
                        Values = new List<IList<object>> { new List<object> { "123456" } }
                    };

                    var updateRequest = service.Spreadsheets.Values.Update(valueRange, SpreadsheetId, updateRange);
                    updateRequest.ValueInputOption = SpreadsheetsResource.ValuesResource.UpdateRequest.ValueInputOptionEnum.RAW;
                    updateRequest.Execute();

                    // 6️⃣ Notify success
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('Password successfully reset to 123456!');window.location='AdminDB.aspx';", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                        $"alert('Error: {ex.Message}');", true);
                }
            }
        }
        
        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDB.aspx");
        }
    }
} 