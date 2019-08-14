using System;
using System.Drawing;
using System.Security.Cryptography;

namespace AAADICSWebApplication.UserAuth
{
    public partial class WebForm1 //: System.Web.UI.Page
    {
        public string randamString = "";
        //Validation validate = new Validation();
        //UserManager userManager = new UserManager();
        public static readonly string  encryptionKey = "9882102908908908";
        public static readonly string encryptionIV = "9089089882102908";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Cache.SetNoStore();
            //SetFocus(txtloginid);
            //if (!Page.IsPostBack)
            //{
            //    Session["remoteAddress"] = Request.UserHostAddress.ToString();
            //    MD5 md5Hash = MD5.Create();
            //    randamString = userManager.GetMd5Hash(md5Hash, UserManager.GenerateString(20, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"));
            //    Session["randamString"] = randamString;
            //    submit.Attributes.Add("onClick", "return EncryptPassword('" + Convert.ToString(randamString) + "');");
            //}
        }



        protected void getUserLogin(object sender, EventArgs e)
        {
            //if (txtloginid.Text.Trim() == "")
            //{
            //    validate.MessageBox("Please Enter User ID", this);
            //    txtloginid.BackColor = Color.LightPink;
            //    SetFocus(txtloginid);
            //    return;
            //}
            //else if (Validation.CheckValidCharacter(txtloginid.Text, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.-_"))
            //{
            //    validate.MessageBox("Please Enter Valid Charcter !!!", this);
            //    txtloginid.BackColor = Color.LightPink;
            //    SetFocus(txtloginid);
            //    return;
            //}

            //else if (txtpwd.Text.Trim() == "")
            //{
            //    validate.MessageBox("Please Enter The Password", this);
            //    txtpwd.BackColor = Color.LightPink;
            //    SetFocus(txtpwd);
            //    return;
            //}

            //else
            if (System.Web.HttpContext.Current.Session["CAPTCHA"].ToString() != (txtcaptcha.Text))
            {

                //validate.MessageBox("Captacha Not Matched !!!", this);
                txtcaptcha.Text = "";
                txtcaptcha.BackColor = Color.LightPink;
                return;
            }
            //else if (Session["remoteAddress"].ToString() != Request.UserHostAddress.ToString())
            //{
            //    // add login log
            //    Context.Response.AddHeader("refresh", "0;url=LoginPage.aspx");
            //}
            //else
            //{
                

            //    string password = Crypto.DecryptStringAES(txtpwd.Text.Trim(), encryptionKey,encryptionIV);
            //    try
            //    {
            //        UserManager userManager = new UserManager();
            //        String[] getUserLogin = new String[12];
            //        //get data record
            //        getUserLogin = userManager.userLogingetUserDetail(txtloginid.Text);
                   
            //        if (getUserLogin[0] == "EMPTYUSER")
            //        {
            //            validate.MessageBox("User Does not Exists !!!!!", this);
            //            return;
            //        }
            //        else if (getUserLogin[10] == "ANA")
            //        {
            //            validate.MessageBox("Your Account is not active. Please contact to Administrator!", this);
            //            return;
            //        }
            //        else if (getUserLogin[11] == "LA")
            //        {
            //            validate.MessageBox("Your account is locked. Please contact to Administrator to unlock the account.", this);
            //            return;
            //        }
            //        else if (userManager.CreatePasswordHash(password, getUserLogin[8]) != getUserLogin[9])
            //        {
            //            validate.MessageBox("Incorrect Password. save: " + userManager.CreatePasswordHash(password, getUserLogin[8]) + " password " + getUserLogin[9], this);
            //            return;
            //        }
            //        else
            //        {
            //            //set session
            //            SessionManager.UserName = getUserLogin[1];
            //            SessionManager.UserDesignation = "Task Holder";
            //            SessionManager.UserId = getUserLogin[0];
            //            SessionManager.UserRoleId = getUserLogin[12]; 
            //            SessionManager.UserRoleName = getUserLogin[13];
            //            SessionManager.LoginTime = DateTime.Now.ToString();
            //            validate.MessageBox("Hurreeyyy! You are logged in.", this);
            //            Response.Redirect("../admin/dashboard/index.aspx");
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        validate.MessageBox("Some Technical Error Occurred Please Contact to Website Administrator", this);
            //    }
            //}
        }
    }
}