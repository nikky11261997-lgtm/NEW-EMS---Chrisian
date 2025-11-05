<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPW.aspx.cs" Inherits="Employee_Management_System.ResetPW" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chrisian EMS - Reset Password</title>
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

        #Welcome {
            font-family: 'Segoe UI';
            margin-top: 6px;
            margin-left: 0px;
            text-align: left;
            font-size: 15px;
            font-weight: bold;
        }

        #LoginPage {
            padding: 10px;
            margin-top: 100px;
            margin-bottom: 100px;
            background-color: #EBF7F9;
            align-content: center;
        }

        #Column1 {
            align-content: center;
            padding: 10px;
            min-width: 250px;
        }

        #Image1 {
            margin-top: 7px;
            margin-bottom: 8px;
        }

        #LblResetTitle {
            font-family: 'Segoe UI';
            font-size: 20px;
            text-align: center;
            padding-bottom: 15px;
        }

        #LblUsername, #LblPassword,
        #LblConfirmPW {
            text-align: right;
            font-size: 13px;
        }

        #TxtboxUsername {
            height: 35px;
            border: medium;
            font-family: 'Segoe UI';
            font-size: 14px;
            border: solid 1px cadetblue;
            border-radius: 25px;
            background-color: white;
            padding-right: 20px;
            padding-left: 20px;
            outline: none;
            margin-left: 10px;
            margin-right: 10px;
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
            margin-right: 10px;
        }

        #BtnReset, #BtnCancel {
            font-family: 'Segoe UI';
            background-color: dimgrey;
            color: white;
            width: 80px;
            float: right;
            margin-bottom: 15px;
            height: 35px;
            border: none;
            border-radius: 15px;
            outline: none;
        }

            #BtnReset:hover, #BtnCancel:hover {
                border: none;
                background-color: #5DBCD2;
                color: dimgray;
            }

        #Forgot a {
            font-size: 14px;
            color: dimgray;
            text-emphasis: none;
            text-underline-position: unset;
            text-decoration-line: none;
            font-family: 'Segoe UI';
        }

            #Forgot a:hover {
                color: orangered;
                text-underline-position: below;
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
            <li><a href="Register.aspx"><i class="fas fa-user-plus" title="Add User"></i></a></li>
        </ul>
      </div>
    </div>
    <div>
        <asp:Table runat="server" CellPadding="5" GridLines="Both" BorderWidth="2px" BorderColor="#6fdbdb" HorizontalAlign="Center" ID="LoginPage">
            <asp:TableRow>
                <asp:TableCell ID="Column1" Width="280px" Height="315px">
                    <br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="Chrisian-New Logo.png" width="230" ImageAlign="AbsMiddle"/>
                    <br /><br />
                <asp:Label ID="LblResetTitle" runat="server" Text="Reset Password" Width="200"/>
                <hr />
                <table>
                <tr>
                    <td>
                    <asp:Label ID="LblUsername" runat="server" Text="Username:" Width="75px" ></asp:Label>
                    </td>
                    <td>
                    <asp:TextBox ID="TxtboxUsername" runat="server" Width="185" MaxLength="30" AutoCompleteType="Disabled"></asp:TextBox>
                    </td>
                </tr>
                </table>
                <table>
                <tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>&nbsp;</td>
                    <td>
                    <td>
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" OnClick="BtnReset_Click"/>
                    </td>
                    <td>
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />
                    </td>
                </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    </div>
    </form>
<footer id="footer" runat="server" class="auto-style1">SMA - Powered by&nbsp;&nbsp;<a href="https://www.chrisian.com/">Chrisian Inc.</a>&nbsp;&nbsp;© 2020</footer>
</body>
</html>
