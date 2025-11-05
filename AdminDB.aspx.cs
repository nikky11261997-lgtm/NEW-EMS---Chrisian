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
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Employee_Management_System
{
    public partial class AdminDB : System.Web.UI.Page
    {

        string[] Scopes = { SheetsService.Scope.Spreadsheets };
        private static string ApplicationName = "Employee Management Login";
        private static string SpreadsheetId = "19heHp6TmWrZbEUuGoq-eSPLlXVQk_fyJEEpylBTot0s"; // e.g. 1x2YzAbcD12345...
        private static string SheetName = "EmpList"; // Sheet tab name
        private static string SheetNameTime = "TimeKeep";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    Welcome.Text = "Welcome " + Session["Username"].ToString() + "!";
                    Label1.Text = Session["Username"].ToString();
                }
                else
                {
                    Session.RemoveAll();
                    Response.Redirect("Login.aspx");
                    Session.Abandon();
                    Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
                }
            }
            Response.Clear();
            HttpContext currentcontext = HttpContext.Current;
            string user_agent = currentcontext.Request.ServerVariables["HTTP_USER_AGENT"];

            string devname = Environment.MachineName;

            string dev;
            if (Request.Browser.IsMobileDevice)
            {
                dev = "Mobile_" + Request.Browser.MobileDeviceModel.ToString() + "_" + user_agent;
            }
            else
            {
                dev = "PC_" + Request.Browser.Type + "_" + user_agent;
            }

            Devicename.Text = dev + "_" + devname;

            //string myHostName = Dns.GetHostName();
            //string devname = Environment.GetEnvironmentVariable("COMPUTERNAME");//Dns.GetHostEntry(Request.ServerVariables["REMOTE_ADDR"]).HostName;
            //Devicename.Text = devname + myHostName;

            CurrentYear.Text = DateTime.Now.ToString("yyyy");
            CurrentMM.Text = DateTime.Now.ToString("MMM");

            CurrentDate.Text = DateTime.Now.ToString("D");
            DateTime datetime = Convert.ToDateTime(CurrentDate.Text);
            CurrentDate.Text = datetime.ToString("ddd. MMM dd, yyyy");

            //CurrentDate.Text = DateTime.Now.ToString("ddd. MMM dd, yyyy");
            //CurrentDate.Text = DateTime.Now.AddHours(8).ToString("ddd. MMM dd, yyyy");
            //CurrentDate.Text = DateTime.UtcNow.ToLocalTime().AddHours(8).ToString("ddd. MMM dd, yyyy");
            CurrentTime.Text = DateTime.Now.AddHours(8).ToString("U");
            //CurrentTime1.Text = DateTime.UtcNow.ToLocalTime().ToString("ddd. MMMM d, yyyy HH:mm:ss tt");

            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ip))
            {
                ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }
            IpAdd.Text = ip;

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
                    row[1].ToString().Equals(Label1.Text, StringComparison.OrdinalIgnoreCase));

                if (match != null)
                {
                    string EmpID = match[0].ToString();

                    idas.Text = EmpID.ToString();
                    idas.Visible = false;

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('Can't Find Employee ID');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }

        }

        protected void LoadGoogleSheetData()
        {
            try
            {
                // === Setup Google Sheets connection ===
                string[] Scopes = { SheetsService.Scope.SpreadsheetsReadonly };
                string ApplicationName = "Chrisian EMS";
                string spreadsheetId = "YOUR_SPREADSHEET_ID"; // 🔹 Replace with your real Google Sheet ID
                string sheetName = "TimeKeep";                // 🔹 Replace with your actual sheet/tab name

                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/credentials.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
                }

                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                // === Read data from Google Sheets ===
                string range = $"{sheetName}!A:H"; // Assuming columns: EmpID | Date | TimeIn | TimeOut
                SpreadsheetsResource.ValuesResource.GetRequest request = service.Spreadsheets.Values.Get(spreadsheetId, range);
                ValueRange response = request.Execute();
                IList<IList<object>> values = response.Values;

                if (values == null || values.Count == 0)
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    return;
                }

                // === Convert to DataTable ===
                DataTable dt = new DataTable();
                dt.Columns.Add("EmpID");
                dt.Columns.Add("TimeIn");
                dt.Columns.Add("TimeOut");

                string empId = idas.Text.Trim();
                string month = CurrentMM.Text.Trim();
                string year = CurrentYear.Text.Trim();

                foreach (var row in values.Skip(1)) // Skip header
                {
                    if (row.Count < 4) continue; // Skip incomplete rows

                    string sheetEmpId = row[0].ToString();
                    string sheetDate = row[1].ToString();
                    string timeIn = row[3].ToString();
                    string timeOut = row[7].ToString();

                    if (sheetEmpId == empId && sheetDate.Contains(month) && sheetDate.Contains(year))
                    {
                        DataRow dr = dt.NewRow();
                        dr["EmpID"] = sheetEmpId;
                        dr["TimeIn"] = timeIn;
                        dr["TimeOut"] = timeOut;
                        dt.Rows.Add(dr);
                    }
                }

                // === Bind to GridView ===
                GridView1.DataSource = dt;
                GridView1.DataBind();

                // === Optional: Display greeting ===
                if (dt.Rows.Count > 0)
                {
                    HiUser.Text = "Hi, " + empId;
                    HiUser1.Visible = true;
                }

                idas.Focus();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
        protected void BtnTimeIN_Click(object sender, EventArgs e)
        {
            try
            {
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/App_Data/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
                }

                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                // Get all current records
                var request = service.Spreadsheets.Values.Get(SpreadsheetId, $"{SheetNameTime}!A:G");
                var response = request.Execute();
                var values = response.Values ?? new List<IList<object>>();

                // Check if already time-in today
                string empId = idas.Text.Trim();
                string currentDate = CurrentDate.Text.Trim();

                bool alreadyIn = values.Skip(1).Any(row =>
                    row.ElementAtOrDefault(0)?.ToString() == empId &&
                    row.ElementAtOrDefault(2)?.ToString() == currentDate);

                if (alreadyIn)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('You are already IN for today!');", true);
                    return;
                }

                // Prepare new entry
                IList<object> newRow = new List<object>()
        {
            empId,                   // EmpID
            HiUser.Text.Replace("Hi, ", ""),  // FirstName (optional)
            currentDate,             // Date 
            CurrentTime.Text,        // TimeIn
            Devicename.Text,         // DeviceName
            IpAdd.Text               // IPAddress
        };

                // Append to Google Sheet
                var appendRequest = service.Spreadsheets.Values.Append(
                    new ValueRange { Values = new List<IList<object>> { newRow } },
                    SpreadsheetId,
                    $"{SheetNameTime}!A:G"
                );
                appendRequest.ValueInputOption = SpreadsheetsResource.ValuesResource.AppendRequest.ValueInputOptionEnum.USERENTERED;
                appendRequest.Execute();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Time In Recorded Successfully!');", true);

                // Refresh grid (if you’re loading data from Sheets)
             //   LoadGoogleSheetData();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void BtnTimeOUT_Click(object sender, EventArgs e)
        {
            try
            {
                // Authenticate with Google Sheets
                GoogleCredential credential;
                using (var stream = new FileStream(Server.MapPath("~/service-account.json"), FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped(Scopes);
                }

                var service = new SheetsService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = ApplicationName,
                });

                string empId = idas.Text.Trim();
                string currentDate = CurrentDate.Text.Trim();
                string currentTime = CurrentTime.Text.Trim();
                string deviceName = Devicename.Text.Trim();

                // Load all existing rows
                var getRequest = service.Spreadsheets.Values.Get(SpreadsheetId, $"{SheetNameTime}!A:H");
                var getResponse = getRequest.Execute();
                var values = getResponse.Values ?? new List<IList<object>>();

                if (values.Count <= 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('No records found for this employee!');", true);
                    return;
                }

                // Find the latest record for this EmpID
                int lastRowIndex = -1;
                DateTime? latestDate = null;

                for (int i = 1; i < values.Count; i++)
                {
                    var row = values[i];
                    if (row.Count > 0 && row[0].ToString() == empId)
                    {
                        DateTime parsed;
                        if (DateTime.TryParse(row.ElementAtOrDefault(3)?.ToString(), out parsed))
                        {
                            if (latestDate == null || parsed > latestDate)
                            {
                                latestDate = parsed;
                                lastRowIndex = i;
                            }
                        }
                    }
                }

                if (lastRowIndex == -1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                        "alert('No matching record found for this employee!');", true);
                    return;
                }

                // Prepare updated values for that row
                int targetRow = lastRowIndex + 1; // +1 because Sheets is 1-based
                var range = $"{SheetNameTime}!G{targetRow}:J{targetRow}"; // columns F-H for TimeOut, Date2, DeviceName1

                IList<object> updateRow = new List<object>()
        {
            currentDate,  // Date2
            currentTime,   // TimeOut
            deviceName,    // DeviceName1
            Devicename.Text,         // DeviceName
            IpAdd.Text
        };

                var valueRange = new ValueRange { Values = new List<IList<object>> { updateRow } };

                // Update the row
                var updateRequest = service.Spreadsheets.Values.Update(valueRange, SpreadsheetId, range);
                updateRequest.ValueInputOption = SpreadsheetsResource.ValuesResource.UpdateRequest.ValueInputOptionEnum.USERENTERED;
                updateRequest.Execute();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                    "alert('Time Out recorded successfully!');", true);

                // Optionally refresh your GridView from Sheets again
                //LoadGoogleSheetData();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void BtnView_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(idas.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please enter Employee ID first!');", true);
                return;
            }

            // Update hidden fields for month/year
            DateTime now = DateTime.Now.AddHours(8);
            CurrentMM.Text = now.ToString("MM");
            CurrentYear.Text = now.ToString("yyyy");

            // Greet user using data from Google Sheet
            // Optional: you can also fetch employee name from another sheet
            HiUser.Text = "Hi, " + idas.Text;
            HiUser.Visible = true;
            HiUser1.Visible = true;

            // Refresh ObjectDataSource
            SqlDataSource1.SelectParameters["EmpID"].DefaultValue = idas.Text;
            SqlDataSource1.SelectParameters["Date"].DefaultValue = CurrentMM.Text;
            SqlDataSource1.SelectParameters["Year"].DefaultValue = CurrentYear.Text;

            GridView1.DataBind(); // Refresh data from Google Sheets

            // Keep focus
            idas.Focus();
            //string year = DateTime.Now.AddHours(16).ToString("yyyy");
            //string strcon = ConfigurationManager.ConnectionStrings["DB_A4EF79_chems"].ConnectionString;
            //SqlConnection con = new SqlConnection(strcon);

            //SqlCommand scm = new SqlCommand("select EmpID, FirstName from EmpList where EmpID=@EmpID", con);
            //SqlDataAdapter sda6 = new SqlDataAdapter(scm);

            //scm.Parameters.AddWithValue("@EmpID", idas.Text);

            //DataTable dt = new DataTable();
            //sda6.Fill(dt);
            //con.Open();

            //SqlDataReader sdr2 = scm.ExecuteReader();
            //sdr2.Read();
            //HiUser.Text = "Hi, " + sdr2["FirstName"].ToString();
            //HiUser1.Visible = true;
            //sdr2.Close();

            //scm.ExecuteNonQuery();

            //SqlCommand sqlcomm = new SqlCommand("Select FirstName.EmpList  TimeKeep.EmpID AS 'Employee No.', TimeKeep.TimeIn AS 'Time In', TimeKeep.TimeOut AS 'Time Out' from " +
            //    "dbo.TimeKeep WHERE TimeKeep.EmpID=@EmpID AND TimeKeep.Date LIKE '%' + @CurrentMonth + '%' AND TimeKeep.Date LIKE '%' + @CurrentYear + '%' ORDER BY TimeKeep.Date DESC");

            //sqlcomm.Parameters.AddWithValue("@EmpID", idas.Text);
            //sqlcomm.Parameters.AddWithValue("@CurrentMonth", CurrentMM.Text);
            //sqlcomm.Parameters.AddWithValue("@CurrentYear", year);
            //// con.Open();

            //if (idas.Text.Equals(""))
            //{
            //    idas.Focus();
            //}
            //else
            //{
            //    SqlDataAdapter sda = new SqlDataAdapter(sqlcomm);
            //    sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            //    con.Close();
            //    GridView1.DataBind();

            //}
            //idas.Focus();
        }

        protected void BtnClear_Click(object sender, EventArgs e)
        {

        }
        protected void BtnLogOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("Login.aspx");
            Session.Abandon();
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));

        }

    }
}