<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDB.aspx.cs" Inherits="Employee_Management_System.AdminDB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chrisian EMS</title>
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link runat="server" rel="shortcut icon" href="chrisian.ico" type="image/x-icon"/>
    <link runat="server" rel="icon" href="ChrisianNew.ico" type="image/ico"/>
    <script type="text/javascript" >
        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
    <script type="text/javascript">
        function fnValidate() {
            if (document.getElementById("EmpID").value == '') { 
                alert('Enter 8 digit Employee No.')
            }
        }
    </script>
     <script runat="server">
         protected void Timer1_Tick(object sender, EventArgs e)
         {
             CurrentDT.Text = DateTime.Now.AddHours(8).ToString("U");
             DateTime datetime = Convert.ToDateTime(CurrentDT.Text);
             CurrentDT.Text = datetime.ToString("ddd. MMMM d, yyyy hh:mm:ss tt");
         }
    </script>
    <style>

    *{
      list-style: none;
      text-decoration: none;
      box-sizing: border-box;
      font-family: 'Segoe UI';
    }
    body{
      background: #e1ecf2;
      text-align: center;
      margin-left: 100px;
      margin-right: 80px;
    }

    .wrapper{
        margin: 10px;
    }
        .wrapper .top_navbar {
            width: calc(100% - 20px);
            height: 50px;
            display: flex;
            position: fixed;
            top: 10px;
            right: 10px;
        }

        .wrapper .top_navbar .top_menu {
            width: 100%;
            height: 100%;
            background: White;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 1px rgba(0,0,0,0.1);
        }

            .wrapper .top_navbar .top_menu .logo {
                color: #2e4ead;
                font-size: 20px;
                font-weight: 700;
                letter-spacing: 3px;
            }

            .wrapper .top_navbar .top_menu ul {
                display: flex;
            }

                .wrapper .top_navbar .top_menu ul li a {
                    display: block;
                    width: 35px;
                    height: 35px;
                    line-height: 35px;
                    text-align: center;
                    border: 1px solid #2e4ead;
                    border-radius: 50%;
                    color: #2e4ead;
                    margin-right: 10px;
                }

                    .wrapper .top_navbar .top_menu ul li a:hover {
                        background: #4360b5;
                        color: #fff;
                    }

                        .wrapper .top_navbar .top_menu ul li a:hover i {
                            color: #fff;
                        }

        .a1 {
            margin-left: -30px;
        }

        .wrapper .sidebar {
            position: fixed;
            top: 65px;
            left: 10px;
            background: #2e4ead;
            width: 50px;
            height: calc(100% - 80px);
            border-bottom-left-radius: 10px;
            transition: all 0.3s ease;
        }

            .wrapper .sidebar ul li a {
                display: block;
                margin-left: -40px;
                padding: 10px;
                color: #fff;
                position: relative;
                margin-bottom: 1px;
                color: #92a6e2;
                white-space: nowrap;
            }

                .wrapper .sidebar ul li a:before {
                    content: "";
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 3px;
                    height: 100%;
                    background: #92a6e2;
                    display: none;
                }

                .wrapper .sidebar ul li a span.icon {
                    margin-right: 10px;
                    display: inline-block;
                }

                .wrapper .sidebar ul li a span.title {
                    display: inline-block;
                }

                .wrapper .sidebar ul li a:hover,
                .wrapper .sidebar ul li a.active {
                    background: #4360b5;
                    color: #fff;
                    height: 40px;
                }

                    .wrapper .sidebar ul li a:hover:before,
                    .wrapper .sidebar ul li a.active:before {
                        display: block;
                    }

        .wrapper .main_container {
            width: 60%;
            margin-top: 25px;
            margin-left: 50px;
            padding: 15px;
            transition: all 0.3s ease;
        }

            .wrapper .main_container .item {
                background: #fff;
                margin-bottom: 10px;
                padding: 15px;
                font-size: 14px;
                line-height: 22px;
            }

        #Welcome {
            font-family: 'Segoe UI';
            margin-top: 6px;
            margin-left: 0px;
            text-align: left;
            font-size: 15px;
            font-weight: bold;
        }

        #TimeTable {
            margin-top: 120px;
            margin-bottom: 100px;
            background-color: #EBF7F9;
        }

        #Column1 {
            align-content: center;
            padding: 10px;
            min-width: 250px;
        }

        #Image1 {
            margin-top: -10px;
            margin-bottom: 10px;
        }

        #CurrentDT {
            font-family: 'Segoe UI';
            text-align: center;
            font-size: 15px;
        }

        #EmpID {
            background-image: url(icon_UserName.png);
            background-position-x: 12px;
            background-position-y: 6px;
            background-size: 18px;
            background-repeat: no-repeat;
            height: 40px;
            border: medium;
            font-family: 'Segoe UI';
            font-size: 13px;
            border-radius: 25px 0 0 25px;
            background-color: white;
            padding-right: 15px;
            padding-left: 40px;
            outline: none;
            margin-left: 10px;
        }

        #BtnView{
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 60px;
            margin-left: -6px;
            margin-right: -25px;
            height: 40px;
            border: none;
            border-radius: 0 25px 25px 0;
            outline: none;
        }
            #BtnView:hover, #BtnTimeIN:hover,
            #BtnTimeOUT:hover, #BtnClear:hover {
                background-color: #5DBCD2;
                color: dimgray;
            }

        #BtnTimeIN, #BtnTimeOUT {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 90px;
            margin-left: -10px;
            margin-top: -10px;
            margin-bottom: 10px;
            height: 35px;
            border: none;
            border-radius: 15px;
            outline: none;
        }

        #BtnClear {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 65px;
            margin-left: 3px;
            margin-top: -10px;
            margin-bottom: 10px;
            height: 35px;
            border: none;
            border-radius: 15px;
            outline: none;
        }

        .GridPager a, .GridPager span {
            display: block;
            height: 15px;
            width: 15px;
            font-weight: bold;
            font-size: 10px;
            text-align: center;
            text-decoration: none;
        }

        .GridPager a {
            background-color: dimgray;
            color: #969696;
            border: 1px solid #969696;
        }
        .GridPager span {
            background-color: #A1DCF2;
            color: #000;
            border: 1px solid #3AC0F2;
        }

        #BtnLogin {
            font-family: 'Segoe UI';
            font-size: 13px;
            margin-top: 5px;
            margin-left: 0;
            margin-right: 6px;
            height: 34px;
            width: 80px;
            border: none;
        }
            #BtnLogin:hover {
                border: none;
                background-color: #5DBCD2;
                color: dimgray;
            }

        #Username {
            padding-left: 5px;
            width: 150px;
            margin-top: 5px;
            font-family: 'Segoe UI';
            font-size: 13px;
            height: 22px;
        }

        #Password {
            padding-left: 5px;
            width: 120px;
            margin-top: 5px;
            font-family: 'Segoe UI';
            font-size: 13px;
            height: 32px;
            border: none;
        }

        #Column2 {
            vertical-align: text-top;
            min-width: 450px;
        }

        #GridView1 {
            font-family: 'Segoe UI';
            font-size: 12px;
        }
        #footer {
            font-family: 'Segoe UI';
            color: navy; /*#FF6347*/
            font-size: 12px;
            position: fixed;
            margin-top: 2%;
            right: 1%;
            bottom: 1%;
            float: none;
        }
            #footer a {
                color: dodgerblue;
                text-emphasis: none;
            }
                #footer a:hover {
                    color: darkred;
                }

    #HiUser {
        font-family: 'Segoe UI';
        padding-left: 5px;
        padding-top: 2px;
        padding-bottom: 2px;
        float: left;
        font-size: 15px;
        font-weight: bold;
    }

    #HiUser1 {
        font-family: 'Segoe UI';
        padding-left: 0;
        padding-top: 2px;
        padding-bottom: 2px;
        float: left;
        font-size: 15px;
        font-weight: bold;
    }

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
        <div class="top_navbar">
            <div class="top_menu">
                <ul>
                <li><a href="?" class="a1"><i class="fas fa-user"></i></a></li>
                <asp:Label ID="Welcome" runat="server" Visible="true"></asp:Label>
                <asp:Label ID="idas" runat="server" Visible="false"></asp:Label>
                <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
                </ul>
                <ul>
                <li><a onclick="preventBack()" href="Login.aspx"><i class="fa fa-sign-out-alt" title="Logout"></i></a></li>
                </ul>
                
            </div>
        </div>
      <div class="sidebar">
          <ul>
            <li><a href="AdminDashboard1.aspx"><i class="fas fa-user-clock" title="Time Logs"></i></a></li>
            <li><a href="ChangePass.aspx"><i class="fas fa-user-edit" title="Change Password"></i></a></li>
            <li><a href="ResetPW.aspx"><i class="fas fa-users-cog" title="Reset User Password"></i></a></li>
            <li><a href="Register.aspx"><i class="fas fa-user-plus" title="Add User"></i></a></li>
        </ul>
      </div>
    </div>
        <br />
    <div>
        <asp:Table runat="server" CellPadding="5" GridLines="Both" BorderWidth="2px" BorderColor="#6fdbdb" HorizontalAlign="Center" ID="TimeTable">
            <asp:TableRow>
                <asp:TableCell ID="Column1" Width="250px" Height="315px">
                    <br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="Chrisian-New Logo.png" width="220" ImageAlign="AbsMiddle"/>
                    <br /><br />
                <asp:ScriptManager ID="ScriptManager1" runat="server" /> 
                <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
                    <ContentTemplate> 
                        <asp:Timer ID="Timer1" runat="server" Interval="1000" ontick="Timer1_Tick"/> 
                            <asp:Label ID="CurrentDT" runat="server" Width="270"></asp:Label>
                    </ContentTemplate> 
                </asp:UpdatePanel>
                    <br />
                    <br />
                    <table id="BtnOnly">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <asp:Button ID="BtnTimeIN" runat="server" Text="Time In" OnClick="BtnTimeIN_Click" onclientclick="fnValidate()"/>
                            &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="BtnTimeOUT" runat="server" Text="Time Out" OnClick="BtnTimeOUT_Click" onclientclick="fnValidate()"/>
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
                <asp:TableCell ID="Column2" Width="470px" Height="315px">
                    <asp:Label ID="HiUser" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="HiUser1" runat="server" Text="!" Visible="False"></asp:Label>
                    <table>
                        <tr>
                        <td>
                       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="10" BorderColor="White"
    AllowPaging="True" CellSpacing="4" CellPadding="4" ForeColor="#333333" Width="450px">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <RowStyle HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField DataField="EmpID" HeaderText="Employee No." SortExpression="EmpID" ItemStyle-Width="105" />
        <asp:BoundField DataField="TimeIn" HeaderText="Time In" SortExpression="TimeIn"
            ItemStyle-Width="180" DataFormatString="{0:MM/dd/yyyy hh\\:mm\\:ss\\ tt}" />
        <asp:BoundField DataField="TimeOut" HeaderText="Time Out" SortExpression="TimeOut"
            ItemStyle-Width="180" DataFormatString="{0:MM/dd/yyyy hh\\:mm\\:ss\\ tt}" />
    </Columns>
    <EditRowStyle BackColor="#999999" />
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Right" CssClass="GridPager" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
    <SortedAscendingCellStyle BackColor="#E9E7E2" />
    <SortedAscendingHeaderStyle BackColor="#506C8C" />
    <SortedDescendingCellStyle BackColor="#FFFDF8" />
    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    <EmptyDataTemplate>No Record Available</EmptyDataTemplate>
</asp:GridView>

<!-- Google Sheets data binding -->
<asp:ObjectDataSource ID="SqlDataSource1" runat="server"
    TypeName="Employee_Management_System.GoogleSheetsData"
    SelectMethod="GetData">
    <SelectParameters>
        <asp:ControlParameter ControlID="idas" Name="EmpID" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="CurrentMM" Name="Date" PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="CurrentYear" Name="Year" PropertyName="Text" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
                       <%--     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DB_A4EF79_chems %>" SelectCommand="SELECT [EmpID], [TimeIn], [TimeOut] FROM [TimeKeep] WHERE (([EmpID] = @EmpID) AND ([Date] LIKE '%' + @Date + '%') OR ([EmpID] = @EmpID) AND ([Date2] LIKE '%' + @Date + '%')) AND ([Date1] LIKE '%' + @Year + '%') ORDER BY [Date1] DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="idas" Name="EmpID" PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="CurrentMM" Name="Date" PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="CurrentYear" Name="Year" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>--%>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Label ID="CurrentYear" runat="server" Text="Year" Visible="False"></asp:Label><br/>
        <asp:Label ID="CurrentMM" runat="server" Text="Month" Visible="False"></asp:Label><br/>
        <asp:Label ID="CurrentDate" runat="server" Text="Date" Visible="False"></asp:Label><br/>
        <asp:Label ID="CurrentTime" runat="server" Text="Time" Visible="False"></asp:Label><br/>
        <asp:Label ID="CurrentTime1" runat="server" Text="Time" Visible="False"></asp:Label><br/>
        <asp:Label ID="Devicename" runat="server" Visible="False"/><br/>
        <asp:Label ID="IpAdd" runat="server" Visible="False"/>
    </div>
    </form>
<footer id="footer" runat="server" class="auto-style1">SMA - Powered by&nbsp;&nbsp;<a href="https://www.chrisian.com/">Chrisian Inc.</a>&nbsp;&nbsp;© 2020</footer>
</body>
</html>
