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
    public partial class UserDash : System.Web.UI.Page
    {

        string[] Scopes = { SheetsService.Scope.Spreadsheets };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345...
        private static string EmpSheet = "EmpList"; // Sheet tab name
        private static string TimeKeepSheet = "TimeKeep";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Welcome.Text = "Time Logs";
            }
            else
            {
                Session.RemoveAll();
                Response.Redirect("Login.aspx");
            }

           
            Response.Clear();
            CurrentMM.Text = DateTime.Now.AddHours(8).ToString("MMM");
            CurrentYear.Text = DateTime.Now.AddHours(8).ToString("yyyy");
            Year.Text = CurrentYear.Text;
        }
        protected void BtnView_Click(object sender, EventArgs e)
        {
            try 
            {
                // 1️⃣ Load credentials
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
                }

                // 2️⃣ Create Sheets service
                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                string username = Session["Username"].ToString();
                string month = DdlCurMonth.SelectedValue;
                string year = Year.Text;

                // 3️⃣ Read employee data
                var empRequest = service.Spreadsheets.Values.Get(SpreadsheetId, $"{EmpSheet}!A2:J");
                var empResponse = empRequest.Execute();
                var empValues = empResponse.Values ?? new List<IList<object>>();

                // Find EmpID by username
                string empId = null;
                string empName = null;
                foreach (var row in empValues)
                {
                    if (row.Count > 7 && row[7].ToString().Equals(username, StringComparison.OrdinalIgnoreCase))
                    {
                        empId = row[0].ToString();
                        empName = $"{row[1]}, {row[2]}";
                        break;
                    }
                }

                if (empId == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('Employee not found in EmpList sheet.');", true);
                    return;
                }

                // 4️⃣ Read TimeKeep data
                var timeRequest = service.Spreadsheets.Values.Get(SpreadsheetId, $"{TimeKeepSheet}!A2:F");
                var timeResponse = timeRequest.Execute();
                var timeValues = timeResponse.Values ?? new List<IList<object>>();

                // 5️⃣ Filter rows
                var filtered = timeValues
                    .Where(r =>
                        r.Count >= 6 &&
                        r[0].ToString() == empId &&
                        r[1].ToString().Contains(month) &&
                        r[1].ToString().Contains(year))
                    .OrderBy(r => r[5]) // Date1 column
                    .ToList();

                // 6️⃣ Prepare DataTable
                DataTable dt = new DataTable();
                dt.Columns.Add("Employee No.");
                dt.Columns.Add("Employee Name");
                dt.Columns.Add("Time In");
                dt.Columns.Add("Time Out");
                dt.Columns.Add("Duration");

                foreach (var row in filtered)
                {
                    dt.Rows.Add(
                        empId,
                        empName,
                        row.Count > 2 ? row[2].ToString() : "",
                        row.Count > 3 ? row[3].ToString() : "",
                        row.Count > 4 ? row[4].ToString() : ""
                    );
                }

                // 7️⃣ Bind to GridView
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void BtnLogOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("Login.aspx");
            Session.Abandon();
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));

        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Width = Unit.Pixel(70); //Employee No.
                e.Row.Cells[1].Width = Unit.Pixel(130); //Employee Name
                //e.Row.Cells[2].Width = Unit.Pixel(90); //Date
                e.Row.Cells[2].Width = Unit.Pixel(130); //Time In
                e.Row.Cells[3].Width = Unit.Pixel(130); //Time Out
                e.Row.Cells[4].Width = Unit.Pixel(65); //Duration
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string strTemp = e.Row.Cells[2].Text;
                e.Row.Cells[2].Text = Convert.ToDateTime(strTemp).ToString("MM/dd/yyyy hh:mm:ss tt").ToUpper();
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[3];
                if (cell.Text == "&nbsp;")
                {
                    //cell.BackColor = Color.Red;
                }
                else
                {
                    cell.Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("MM/dd/yyyy hh:mm:ss tt").ToUpper();
                }

            }
        }

    }
}