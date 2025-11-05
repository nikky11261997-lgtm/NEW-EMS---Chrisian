using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
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
    public partial class Login : System.Web.UI.Page
    {

        private static string[] Scopes = { SheetsService.Scope.SpreadsheetsReadonly };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345... 
        private static string SheetName = "EmpList"; // Sheet tab name
        protected void Page_Load(object sender, EventArgs e)
        {
            TxtboxUsername.Focus();

            if (!Page.IsPostBack)
            {
                if (Request.Cookies["Username"] != null)
                    TxtboxUsername.Text = Request.Cookies["Username"].Value;

                if (Request.Cookies["Password"] != null)
                    TxtboxPassword.Attributes.Add("value", Request.Cookies["Password"].Value);

                if (Request.Cookies["Username"] != null && Request.Cookies["Password"] != null)
                    RememberMe.Checked = true;
            }
        }
        protected void BtnUserLogin_Click(object sender, EventArgs e)
        {
            string username = TxtboxUsername.Text.Trim();
            string password = TxtboxPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Please enter username and password');", true);
                return;
            }
            try
            {
                // Load Google credentials
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
                }

                // Create Sheets API service
                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                // Read data from Google Sheet
                var range = $"{SheetName}!A2:E"; 
                SpreadsheetsResource.ValuesResource.GetRequest request =
                    service.Spreadsheets.Values.Get(SpreadsheetId, range);

                var response = request.Execute();
                var values = response.Values;

                if (values == null || values.Count == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('No employee data found.');", true);
                    return;
                }

                // Find matching row
                var match = values.FirstOrDefault(row =>
                    row.Count >= 5 &&
                    row[1].ToString().Equals(username, StringComparison.OrdinalIgnoreCase) &&
                    row[2].ToString().Equals(password) &&
                    row[3].ToString().Equals("Active", StringComparison.OrdinalIgnoreCase));

                if (match != null)
                {
                    string userType = match[4].ToString();

                    Session["Username"] = username;
                    if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                        Response.Redirect("AdminDB.aspx?Username=" + username);
                    else
                        Response.Redirect("UserDB.aspx?Username=" + username);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('Invalid username or password.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }
        }
    }
}