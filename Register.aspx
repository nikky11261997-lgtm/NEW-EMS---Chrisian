<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Employee_Management_System.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chrisian EMS - Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link runat="server" rel="shortcut icon" href="chrisian.ico" type="image/x-icon"/>
    <link runat="server" rel="icon" href="ChrisianNew.ico" type="image/ico"/>
    <script type = "text/javascript">
        function functionx(evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                alert("Allow Only Numbers");
                return false;
            }
        }
    </script>
    <script>
        $(document).ready(function () {
            $("#TxtboxConfirmPW").keyup(validate);
        });

        function validate() {
            var TxtboxPassword = $("#TxtboxPassword").val(); 
            var TxtboxConfirmPW = $("#TxtboxConfirmPW").val();

            if (TxtboxPassword == TxtboxConfirmPW) {
                $(this).css({ 'color': 'green' })
            }
            else {
                $(this).css({ 'color': 'red' })
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

        #ErrorMsg, #ErrorMsg1 {
            font-family: 'Segoe UI';
            font-size: 15px;
            margin-left: 5px;
            color: red;
        }

        #Welcome {
            font-family: 'Segoe UI';
            margin-top: 6px;
            margin-left: 0px;
            text-align: left;
            font-size: 15px;
            font-weight: bold;
        }

        #RegisterTable {
            padding: 10px;
            margin-top: 100px;
            margin-bottom: 100px;
            background-color: #EBF7F9;
        }

        #Column1 {
            font-family: 'Segoe UI';
            align-content: center;
            padding: 10px;
        }

        .GridPager a, .GridPager span {
            display: block;
            height: 15px;
            width: 15px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
        }

        .GridPager a {
            background-color: #f5f5f5;
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
            height: 35px;
            width: 80px;
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
            height: 30px;
        }
        #LblEmpID, #LblFName, #LblMName, #LblLName,
        #LblUserType, #LblUsername, #LblPassword,
        #LblConfirmPW, #LblEmail, #LblMobile {
            text-align: right;
            font-size: 14px;
        }

        #TxtboxEmpID, #TxtboxFname, #TxtboxMname,
        #TxtboxLname, #TxtboxUsername, #TxtboxEmail,
        #TxtboxMobile {
            height: 35px;
            border: solid 1px cadetblue;
            font-family: 'Segoe UI';
            font-size: 14px;
            border-radius: 25px;
            background-color: white;
            padding-right: 15px;
            padding-left: 20px;
            outline: none;
            margin-left: 10px;
        }

        #TxtboxPassword, #TxtboxConfirmPW {
            height: 35px;
            border: solid 1px cadetblue;
            font-family: 'Segoe UI';
            font-size: 15px;
            border-radius: 25px;
            background-color: white;
            padding-right: 15px;
            padding-left: 20px;
            outline: none;
            margin-left: 10px;
        }

        .UserTypeChckBox {
            padding-left: 8px;
            font-family: 'Segoe UI';
            font-size: 13px;
        }

        #LblRegTitle {
            font-family: 'Segoe UI';
            font-size: 20px;
            text-align: center;
            padding-bottom: 10px;
        }
        #BtnSave, #BtnCancel {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 80px;
            margin-top: 5px;
            margin-bottom: -10px;
            height: 33px;
            border: none;
            border-radius: 15px;
            outline: none;
        }
            #BtnSave:hover, #BtnCancel:hover, #BtnClear:hover {
                background-color: #5DBCD2;
                color: dimgray;
            }

        #BtnClear {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 60px;
            margin-top: 5px;
            margin-bottom: -10px;
            height: 33px;
            border: none;
            border-radius: 15px;
            outline: none;
        }

        #DdlUserType {
            position: static;
            width: 100px;
            height: 35px;
            margin-left: 10px;
            padding-left: 20px;
            margin-right: 20px;
            font-family: 'Segoe UI';
            background-color: white;
            border-radius: 25px;
            border: solid 1px cadetblue;
            outline: none;
        }

        .footer {
            font-family: 'Segoe UI';
            color: navy; /*#FF6347*/
            font-size: 12px;
            position: fixed;
            margin-top: 2%;
            right: 1%;
            bottom: 1%;
            float: none;
        }
           .footer a {
                color: navy;
                text-emphasis: none;
            }
                .footer a:hover {
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
                <li><a href="AdminDB.aspx" class="a1"><i class="fas fa-user"></i></a></li>
                <asp:Label ID="Welcome" runat="server" Visible="true"></asp:Label>
                </ul>
            </div>
        </div>
      <div class="sidebar">
          <ul>
            <li><a href="AdminDB.aspx"><i class="fas fa-home" title="Home"></i></a></li>
            <li><a href="AdminDashboard1.aspx"><i class="fas fa-user-clock" title="Time Logs"></i></a></li>
            <li><a href="ChangePass.aspx"><i class="fas fa-user-edit" title="Change Password"></i></a></li>
            <li><a href="ResetPW.aspx"><i class="fas fa-users-cog" title="Reset User Password"></i></a></li>
        </ul>
      </div>
    </div>
    <div>
        <asp:Table runat="server" CellPadding="5" GridLines="None" BorderWidth="2px" BorderColor="#6fdbdb" HorizontalAlign="Center" ID="RegisterTable">
            <asp:TableRow>
                <asp:TableCell ID="Column1" Width="200px" Height="450px" VerticalAlign="Top">
                    <asp:Label ID="LblRegTitle" runat="server" Text="Register" Width="380px"></asp:Label>
                    <hr />
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblEmpID" runat="server" Text="Employee No:" Width="120px"></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxEmpID" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled" onkeypress="return functionx(event)"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblFName" runat="server" Text="First Name:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxFname" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblMName" runat="server" Text="Middle Name:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxMname" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblLName" runat="server" Text="Last Name:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxLname" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblUserType" runat="server" Text="User Type:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlUserType" runat="server">
                                <asp:ListItem Enabled="True" Text="" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblEmail" runat="server" Text="Email:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxEmail" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblMobile" runat="server" Text="Mobile:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxMobile" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled" onkeypress="return functionx(event)"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblUsername" runat="server" Text="Username:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxUsername" runat="server" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblPassword" runat="server" Text="Password:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxPassword" runat="server" TextMode="Password" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                    <table>
                    <tr>
                        <td>
                        <asp:Label ID="LblConfirmPW" runat="server" Text="Confirm Password:" Width="120px" ></asp:Label>
                        </td>
                        <td>
                        <asp:TextBox ID="TxtboxConfirmPW" runat="server" TextMode="Password" Width="230" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                        </td>
                   </tr>
                    </table>
                    <hr />
                        <table id="BtnOnly">
                         <tr>
                             <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                             <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                             <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:Button ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click" />
                        </td>
                        <td>
                            <asp:Button ID="BtnCancel" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />
                        </td>
                        <td>
                            <asp:Button ID="BtnClear" runat="server" Text="Clear" OnClick="BtnClear_Click"/>
                        </td>
                         </tr>
                     </table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    </form>
    <div class="footer">SJMC/MNMP - Powered by&nbsp;&nbsp;<a href="https://www.chrisian.com/">Chrisian Inc.</a>&nbsp;&nbsp;© 2020</div>
</body>
</html>