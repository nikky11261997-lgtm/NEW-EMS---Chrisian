<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDash.aspx.cs" Inherits="Employee_Management_System.UserDash" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chrisian EMS - User</title>
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link runat="server" rel="shortcut icon" href="chrisian.ico" type="image/x-icon"/>
    <link runat="server" rel="icon" href="ChrisianNew.ico" type="image/ico"/>
    <script type="text/javascript">
        function fnValidate() {
            if (document.getElementById("EmpLastName").value == '') {
                alert('Enter Employee Last Name')
            }
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
      margin-left: 80px;
      margin-right: 80px;
      margin-top: 40px;
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

    .wrapper .sidebar{
      position: fixed;
      top: 65px;
      left: 10px;
      background: #2e4ead;
      width: 50px;
      height: calc(100% - 80px);
      border-bottom-left-radius: 10px;
      transition: all 0.3s ease;
    }

    .wrapper .sidebar ul li a{
        display: block;
        margin-left: -40px;
        padding: 10px;
        color: #fff;
        position: relative;
        margin-bottom: 1px;
        color: #92a6e2;
        white-space: nowrap;
    }

    .wrapper .sidebar ul li a:before{
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 3px;
      height: 100%;
      background: #92a6e2;
      display: none;
    }

    .wrapper .sidebar ul li a span.icon{
      margin-right: 10px;
      display: inline-block;
    }

    .wrapper .sidebar ul li a span.title{
      display: inline-block;
    }

    .wrapper .sidebar ul li a:hover,
    .wrapper .sidebar ul li a.active{
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
            margin-top: 7px;
            margin-left: 0px;
            text-align: left;
            font-size: 15px;
            font-weight: bold;
        }

        #TimeTable {
            margin-top: 60px;
            margin-bottom: 60px;
            background-color: #EBF7F9;
            padding-left: 100px;
        }

        #Column1 {
            align-content: center;
            padding: 10px;
            min-width: 800px;
        }

        #BtnView {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 70px;
            height: 40px;
            border: none;
            border-radius: 0 25px 25px 0;
            outline: none;
        }

            #BtnView:hover, #BtnClear:hover {
                background-color: #5DBCD2;
                color: dimgray;
            }

        #DdlCurMonth {
            flex: none;
            width: 120px;
            height: 40px;
            /*margin-left: 5px;*/
            padding-left: 15px;
            padding-right: 5px;
            font-family: 'Segoe UI';
            background-color: white;
            border-radius: 0;
            border: none;
            outline: none;
        }

        #Year {
            flex: none;
            width: 55px;
            height: 40px;
            /*margin-left: 5px;*/
            padding-left: 15px;
            padding-right: 5px;
            font-family: 'Segoe UI';
            background-color: white;
            border-radius: 25px 0 0 25px;
            border: none;
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
        background-color: dimgray; /*#f5f5f5*/
        color: #969696;
        border: 1px solid #969696;
    }
    .GridPager span {
        background-color: #A1DCF2; /*#A1DCF2*/
        color: #000;
        border: 1px solid #3AC0F2;
    }

    #BtnLogout {
        font-family: 'Segoe UI';
        font-size: 13px;
        margin-top: 7px;
        margin-left: 0;
        margin-right: 6px;
        height: 35px;
        width: 80px;
        border: none;
    }

        #BtnLogout:hover {
            border: none;
            background-color: #5DBCD2;
            color: dimgray;
        }

    #Username, #Password {
        font-family: 'Segoe UI';
        font-size: 13px;
        height: 22px;
    }
    #GridView1 {
        font-family: 'Segoe UI';
        font-size: 13px;
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
        <div class="top_navbar">
            <div class="top_menu">
                <ul>
                <li><a href="#" class="a1"><i class="fas fa-user"></i></a></li>
                <asp:Label ID="Welcome" runat="server" Visible="true"></asp:Label>
                </ul>
                <ul>
                </ul>
            </div>
        </div>
      <div class="sidebar">
          <ul>
            <li><a href="UserDB.aspx"><i class="fas fa-home"></i></a></li>
            <li><a href="ChangePass.aspx"><i class="fas fa-user-edit" title="Change Password"></i></a></li>
        </ul>
      </div>
    </div>
        <br /><br />
        <div>
            <asp:Table runat="server" CellPadding="5" GridLines="Both" BorderWidth="2px" BorderColor="#6fdbdb" HorizontalAlign="Center" ID="TimeTable">
               <asp:TableRow>
                 <asp:TableCell ID="Column1" Width="800px" Height="700px" VerticalAlign="Top">
                     <table>
                     <tr>
                         <td>
                          <asp:TextBox ID="Year" runat="server" MaxLength="4" AutoCompleteType="Disabled"></asp:TextBox>
                         </td>
                         <td>
                            <asp:DropDownList ID="DdlCurMonth" runat="server">
                                <asp:ListItem Enabled="True" Text="Month" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="January" Value="Jan"></asp:ListItem>
                                <asp:ListItem Text="February" Value="Feb"></asp:ListItem>
                                <asp:ListItem Text="March" Value="Mar"></asp:ListItem>
                                <asp:ListItem Text="April" Value="Apr"></asp:ListItem>
                                <asp:ListItem Text="May" Value="May"></asp:ListItem>
                                <asp:ListItem Text="June" Value="Jun"></asp:ListItem>
                                <asp:ListItem Text="July" Value="Jul"></asp:ListItem>
                                <asp:ListItem Text="August" Value="Aug"></asp:ListItem>
                                <asp:ListItem Text="September" Value="Sep"></asp:ListItem>
                                <asp:ListItem Text="October" Value="Oct"></asp:ListItem>
                                <asp:ListItem Text="November" Value="Nov"></asp:ListItem>
                                <asp:ListItem Text="December" Value="Dec"></asp:ListItem>
                            </asp:DropDownList>
                         </td>
                         <td>
                         <asp:Button ID="BtnView" runat="server" Text="View" OnClick="BtnView_Click"/>
                         </td>
                     </tr>
                     </table>
                     <hr />
                     <table>
                         <tr>
                            <td>
                                <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_OnRowDataBound" AllowPaging="False" PageSize="22" BorderColor="White" CellPadding="4" ForeColor="#333333" Width="790px" PagerSettings-PageButtonCount="15">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <RowStyle HorizontalAlign="Center"/>
                                    
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
                            </td>
                         </tr>
                     </table>
                 </asp:TableCell>
               </asp:TableRow>
            </asp:Table>
            <asp:Label ID="CurrentMM" runat="server" Text="Label" Visible="False"></asp:Label>
            <asp:Label ID="CurrentYear" runat="server" Text="" Visible="False"></asp:Label>
        </div>
        <footer ID="footer" runat="server">SMA - Powered by&nbsp;&nbsp;<a href="https://www.chrisian.com/">Chrisian Inc.</a>&nbsp;&nbsp;© 2020</footer>
    </form>
</body>
</html>
