<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Employee_Management_System.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chrisian EMS - Login</title>
	<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link runat="server" rel="shortcut icon" href="chrisian.ico" type="image/x-icon"/>
    <link runat="server" rel="icon" href="ChrisianNew.ico" type="image/ico"/>
    
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

    #LoginPage {
        padding: 10px;
        margin-top: 120px;
        margin-bottom: 120px;
        background-color: #EBF7F9;
        align-content: center;
    }

    #Column1 {
        align-content: center;
        padding: 10px;
        min-width: 250px;
    }

    #Image1 {
        margin-top: 10px;
        margin-bottom: 8px;
    }

    #LblLoginTitle {
        font-family: 'Segoe UI';
        font-size: 20px;
        text-align: center;
        padding-bottom: 15px;
    }

    #TxtboxUsername {
        background-image: url(icon_UserName.png);
        background-position-x: 12px;
        background-position-y: 6px;
        background-size: 18px;
        background-repeat: no-repeat;
        height: 38px;
        border: solid;
        border-width: 1px;
        border-color: cadetblue;
        font-family: 'Segoe UI';
        font-size: 13px;
        border-radius: 25px;
        background-color: white;
        padding-right: 15px;
        padding-left: 40px;
        outline: none;
        margin-left: 20px;
        margin-right: 18px;
    }

    #TxtboxPassword {
        background-image: url(userpw_icon.png);
        background-position-x: 12px;
        background-position-y: 6px;
        background-size: 18px;
        background-repeat: no-repeat;
        height: 38px;
        border: solid;
        border-width: 1px;
        border-color: cadetblue;
        font-family: 'Segoe UI';
        font-size: 13px;
        border-radius: 25px;
        background-color: white;
        padding-right: 15px;
        padding-left: 40px;
        outline: none;
        margin-left: 20px;
        margin-right: 18px;
    }
    #RememberMe {
        margin-left: 20px;
    }

    #BtnLoginUser {
        font-family: 'Segoe UI';
        background-color: dimgrey;
        color: white;
        width: 120px;
        float: right;
        margin-left: 137px;
        margin-right: 18px;
        margin-top: -5px;
        margin-bottom: 15px;
        height: 38px;
        border: none;
        border-radius: 25px;
        outline: none;
    }
        #BtnLoginUser:hover {
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
    <div>
        <asp:Table runat="server" CellPadding="5" GridLines="Both" BorderWidth="2px" BorderColor="#6fdbdb" HorizontalAlign="Center" ID="LoginPage">
            <asp:TableRow>
                <asp:TableCell ID="Column1" Width="280px" Height="315px">
                    <br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="Chrisian-New Logo.png" width="230" ImageAlign="AbsMiddle"/>
                    <br /><br />
                <asp:Label ID="LblLoginTitle" runat="server" Text="Welcome!" Width="200"/>
                
		        <table>
		        <tr>
		            <td>
                    <asp:TextBox ID="TxtboxUsername" runat="server" Width="240" MaxLength="25" Placeholder="Username" AutoCompleteType="Disabled"/>
                    </td>
		        </tr>
		        </table>
                <table>
                <tr>
                    <td>
                    <asp:TextBox ID="TxtboxPassword" runat="server" Width="240" MaxLength="25" Placeholder="Password" TextMode="Password" AutoCompleteType="Disabled"></asp:TextBox>
                    </td>
                </tr>
                </table>
                <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember Me" Width="130" Height="35" Font-Names="Segoe UI" Font-Size="Small" Visible="False"/>
                    </td>
                </tr>
                </table>
                <table>
                <tr>
                    <td>
                    <asp:Button ID="BtnLoginUser" runat="server" Text="Login" OnClick="BtnUserLogin_Click"/>
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
