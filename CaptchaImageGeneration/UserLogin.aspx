<%@ Page Title="Aid Accounts & Audit Division" Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="AAADICSWebApplication.UserAuth.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
   <head id="Head1" runat="server">
      <title>Aid Accounts & Audit Division</title>
      <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
      <link rel="stylesheet" href="../css/bootstrap.min.css" />
      <link href="../css/style.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="../js/jquery.min.js"></script>
      <script type="text/javascript" src="../js/bootstrap.min.js"></script>
      <script type="text/javascript" src="../js/crypto-js.js"></script>
      <link rel="icon" href="img/favicon.ico" />
      <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" type="text/css" />
      
          
     <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
      <script type="text/javascript">
          function EncryptPassword(str) {
              try {
                  if (document.getElementById('<%= txtloginid.ClientID %>').value == '') {
                     alert('User ID field cannot be blank.');
                     document.getElementById('<%= txtpwd.ClientID %>').value = ''
                     document.getElementById('<%= txtloginid.ClientID %>').focus();
                     return false;
                 }
                 if (document.getElementById('<%= txtpwd.ClientID %>').value == '') {
                     alert('Password Field cannot be blank');
                     document.getElementById('<%= txtpwd.ClientID %>').value = ''
                     document.getElementById('<%= txtpwd.ClientID %>').focus();
                     return false;
                 }
                  if (document.getElementById('<%= txtpwd.ClientID %>').value != "") {
                      var key = CryptoJS.enc.Utf8.parse(<%= encryptionKey %>);
                      var iv = CryptoJS.enc.Utf8.parse(<%= encryptionIV %>);
                      var encryptedpassword = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(document.getElementById('<%= txtpwd.ClientID %>').value), key,
                          {
                              keySize: 128 / 8,
                              iv: iv,
                              mode: CryptoJS.mode.CBC,
                              padding: CryptoJS.pad.Pkcs7
                          });
                      document.getElementById("<%=txtpwd.ClientID %>").value = encryptedpassword;


                     <%--var md5encypt = hex_md5(document.getElementById('<%= txtpwd.ClientID %>').value);
                     var passstr = str + (md5encypt);
                     document.getElementById('<%= txtpwd.ClientID %>').value = hex_md5(passstr);--%>
                  }
                  return true;
              }
              catch (err) {
                  alert(err.message);
              }
          }
      </script>
   </head>
<body style='background:#f2f2f2'>
<div class="top-area">
	<section>
		<div class='loginwrapper'>
			<div><img style='width:100%' src="../img/updates/logo-new.png" /></div>
			<div class='loginrow'>
                           <form id="form1" runat="server" autocomplete="off">
                              <asp:HiddenField ID="hash" runat="server" />
                                     <div class="inputbox">
                                      <label>Username</label>
                                        <asp:TextBox ID="txtloginid" CssClass="text" runat="server" MaxLength="255"
                                           oncopy="return false" onpaste="return false" oncut="return false"
                                            Text="qweqwe"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                           ErrorMessage="User ID can't be blank" ControlToValidate="txtloginid" ValidationGroup="val"></asp:RequiredFieldValidator>
                                     </div>
                                     <div class="inputbox">
                                      <label>Password</label>
                                        <asp:TextBox ID="txtpwd" TextMode="Password" CssClass="text" runat="server" MaxLength="15"
                                       oncopy="return false" oncut="return false" Text="!U21-CzA"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password can't be blank"
                                       ControlToValidate="txtpwd" ValidationGroup="val" ForeColor="Red"></asp:RequiredFieldValidator>
                                     </div>
                              <div class="captchabox">
                                      <label>&nbsp;</label>
                                    <asp:Image ID="ImgCaptcha" ImageAlign="middle" style="height: 51px;width: 85%;" runat="server" ImageUrl="captcha.ashx" />
                                     </div>
                              <div class="captchabox">
                                      <label>Enter Captcha</label>
                                    <asp:TextBox ID="txtcaptcha" runat="server" MaxLength="5" CssClass="text" oncopy="return false"
                                       onpaste="return false" oncut="return false"></asp:TextBox>
                              </div>
                                          <asp:Button ID="submit" CssClass="button btn btn-primary" runat="server" Text="Login" ValidationGroup="val" OnClick="getUserLogin"
                                             />
                                          <asp:Button ID="Cancel" CssClass="button btn btn-primary" runat="server" Text="Reset" CausesValidation="false" />
                                          <asp:HiddenField ID="ipnum" runat="server" />
                                          <asp:HiddenField ID="rnum" runat="server" />
                           </form>
                        </div>
			<div class='textbox'>
                <a href="ForgotPassword.aspx">Forgot Password</a>
                <a style='border-right: 1px solid #ccc;' href="ResetPassword.aspx">Reset Password</a>

			</div>
		</div>
	</section>
</div>
</body>
<style>
.loginwrapper {
    width: 30%;
    height: 430px;
    background: #fff;
    margin: auto;
    margin-top: 10%;
    -webkit-box-shadow: 0 8px 6px -6px #949393;
    -moz-box-shadow: 0 8px 6px -6px #949393;
    box-shadow: 0 8px 6px -6px #949393;
	    padding: 25px;
}
.loginrow {
    float: left;
    margin-top: 20px;
}
input.button {
    margin: 16px 10px 16px 47px;
    padding: 6px 15px;
	float: left;
    width: auto;
    font-size: 12px;
    height: auto;
    line-height: initial;
}
.colorbox {
    width: 100%;
    background: #ccc;
    margin-top: 15px;
    text-align: center;
    color: #fff;
    font-size: 26px;
}
.button {
    background-image: url(img/btn-bg.jpg) !important;
    background-size: 100% 100%;
    border: none;
    color: #fff;
}
.inputbox {
    width: 100%;
    float: left;
    margin: 0px;
}
.captchabox {
    width: 49%;
    float: left;
    margin: 0px;
}
input[type="text"] {
    background: #f2f2f2;
    border: 1px solid #b0b0b0;
}
.textbox {
    float: left;
    border-top: #337AB7 solid 2px;
    width: 100%;
    padding: 6px;

}
.textbox a {
    text-align: right;
    float: right;
}
.textbox a {
    text-align: right;
    float: right;
    padding: 0 11px;
}
img {
    vertical-align: middle;
}
label {
    font-size: 12px;
    color: #555;
    font-weight: normal;
    float: left;
    margin-top: 3px;
    margin-right: 4px;
    display: inline-block;
    max-width: 100%;
    margin-bottom: 5px;
}
select, input {
    width: 98%;
    height: 25px;
    padding: 0 10px;
    border-radius: 0;
    font-size: 12px;
    margin: 0 0 3px 0;
	color: #333;
}
@media screen and (min-width: 1400px) {
.loginwrapper {
    width: 23%;
	}
}
</style>
 </html>