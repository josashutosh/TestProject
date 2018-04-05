using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using SocietyDAL;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Configuration;
using System.Text;
using SocietyEntity;
using EsquareMasterTemplate.Common;


namespace EsquareMasterTemplate
{
    public partial class Login1 : System.Web.UI.Page
    {
        CommonHelper objcommon = new CommonHelper();
        SaltEncryption objenc = new SaltEncryption();
        public string strPass, str, url, path, Redirecturl;
        clsUserDAL objuserDal = new clsUserDAL();
        clsUserRegistrationDAL objRegDal = new clsUserRegistrationDAL();
        clsUserEntity objuserinfo = new clsUserEntity();
        Mail objMail = new Mail();
        SaltEncryption objEncrypt = new SaltEncryption();
        string LoginType, output, username;
        int Subscription, hitcount, remhit, lockStatus, strUID;
        int intEmailStatus;
        public string UID,Output;
      
        protected void Page_Load(object sender, EventArgs e)
        {
            //urlformart =http://localhost:3538/Account/Login.aspx?loginId=Admin&Sub=1

            LoginType = Request.QueryString["Login_Type"];
            
            Subscription =Convert.ToInt32(Request.QueryString["Sub"]);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
           

            Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);
           
            //Uri theRealURL = new Uri(HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.RawUrl);
           // string yourValue = HttpUtility.ParseQueryString(theRealURL.Query).AllKeys[0];
            if (IsPostBack)
            {
                username=txtUsername.Text;
                
                if (username == (Convert.ToString(Session["username"])))
                {
                    hitcount = Convert.ToInt32(Session["hitcount"]);
                }
                else
                {
                    hitcount = 0;
                }
            }
            else
            {
               // string baseurl = objcommon.GetBaseURL() + "Account/login.aspx";
               // Page.ClientScript.RegisterStartupScript(this.GetType(), "clearHistory", "ClearHistory('" + baseurl + "');", true);
                FillDropdowns();
            }
        }

        private void FillDropdowns()
        {
            objuserDal.FillDropDown(drpCountry, ((DataSet)objuserDal.GetCountryList()).Tables[0], "CountryName", "CountryCode","- Select Country -");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            try
            {
                Session["username"] = txtUsername.Text;
                ds = objuserDal.GetUserDetails(txtUsername.Text.Trim().ToString());
                remhit = 3 - hitcount;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if ((hitcount != 3))
                    {
                        if (ds.Tables[0].Rows[0]["msg"].ToString() == "Invalid Username")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('The username you have entered is incorrect. '); </script>", false);
                        }
                        else
                        {
                            lockStatus = Convert.ToInt32(ds.Tables[0].Rows[0]["Lock"]);
                            if (lockStatus == 0)
                            {
                                DataRow drLogin = ds.Tables[0].Rows[0];
                                strPass = Convert.ToString(drLogin["Password"]);
                                if (ValidateUserCredentials() == true)
                                {
                                    // Storing values in session for further use 

                                    Session["UID"] = ds.Tables[0].Rows[0]["UID"];
                                    Session["LoginType"] = ds.Tables[0].Rows[0]["LoginType"];
                                    Session["LoginId"] = ds.Tables[0].Rows[0]["LoginId"];
                                    Session["ExpiryDate"] = ds.Tables[0].Rows[0]["ExpiryDate"];
                                    Session["RoleId"] = ds.Tables[0].Rows[0]["RoleId"];
                                    Session["Subscription"] = ds.Tables[0].Rows[0]["Subscription"];
                                    Session["Id"] = ds.Tables[0].Rows[0]["Id"];

                                    url = HttpContext.Current.Request.Url.AbsoluteUri; Session["Url"] = url;
                                    path = HttpContext.Current.Request.Url.AbsolutePath; Session["path"] = path;

                                    if (Convert.ToString(Session["LoginType"]) == "SuperAdmin")
                                    {
                                        Redirecturl = url.Replace(path, "/Dashboards/SuperAdminDashboard.aspx");
                                    }

                                    if (Convert.ToString(Session["LoginType"]) == "Admin")
                                    {
                                        Redirecturl = url.Replace(path, "/Dashboards/AdminDashboard.aspx");
                                    }

                                    else if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
                                    {
                                        Session["SID"] = ds.Tables[0].Rows[0]["SocietyId"];
                                        if (ds.Tables[0].Rows.Count > 1)
                                        {
                                            Redirecturl = url.Replace(path, "/Dashboards/FlatSelector.aspx");
                                        }
                                        else
                                        {
                                            Session["IsRented"] = ds.Tables[0].Rows[0]["IsRented"];
                                            Session["FlatId"] = ds.Tables[0].Rows[0]["FlatId"];
                                            Redirecturl = url.Replace(path, "/Dashboards/SocietyMemberDashboard.aspx");
                                            Session["RedirectUrl"] = Redirecturl;
                                        }
                                    }
                                    else if (Convert.ToString(Session["LoginType"]) == "CommitteeMember")
                                    {
                                        Redirecturl = url.Replace(path, "/Dashboards/CommitteeMemberDashboard.aspx");
                                    }
                                    else if (Convert.ToString(Session["LoginType"]) == "Employee")
                                    {
                                        Redirecturl = url.Replace(path, "/Dashboards/EmployeeDashboard.aspx");
                                    }
                                    else if (Convert.ToString(Session["LoginType"]) == "Guest" && Request.QueryString["flag"] == "G")
                                    {
                                        Redirecturl = url.Replace(path, "/Dashboards/GuestDashboard.aspx");
                                    }
                                    Response.Redirect(Redirecturl);
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('The username or password you have entered is incorrect.'); alert('Your " + remhit + " Login attempt remaining');</script>", false);
                                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('The username or password you entered is incorrect.'); bootbox.alert('You left " + remhit + " Attempt ');</script>", false);
                                    hitcount++;
                                    Session["hitcount"] = hitcount.ToString();
                                }
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Your Account is Locked. Please contact administrator for more information.'); </script>", false);
                            }
                        }
                    }
                    else
                    {
                        DataSet dslock = new DataSet();
                        dslock = (DataSet)objuserDal.LockUserByUserName(txtUsername.Text.Trim().ToString());
                        Output= dslock.Tables[0].Rows[0]["message"].ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + Output + "'); </script>", false);
                        txtUsername.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('The username or password you have entered is incorrect.'); alert('Your " + remhit + " Login attempt remaining');</script>", false);
                }
            }
            catch (Exception ex)
            {
               /// Response.Write(ex.Message.ToString());
            }
            finally
            {
                ds.Dispose();
            }
        }

        private bool ValidateUserCredentials()
        {
            bool PassValid = objenc.VerifyHash(txtloginPassword.Text.Trim().ToString(), "SHA512", strPass);
            string strEncPass = objEncrypt.ComputeHash(txtloginPassword.Text.Trim().ToString(), "SHA512", null);
            if (PassValid == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnregisters_Click(object sender, EventArgs e)
        {
            string strEncPass = objEncrypt.ComputeHash(txtRegPassword.Text.Trim().ToString(), "SHA512", null);
            objuserinfo.UID = 0;

            objuserinfo.EmailID = txtEmail.Text;
            objuserinfo.mobileno = txtMobileNumber.Text;
            objuserinfo.Country = drpCountry.SelectedValue;
            objuserinfo.City = txtCity.Text;
            objuserinfo.username = txtRegUsername.Text;
            objuserinfo.password = strEncPass;

            if (LoginType == "G")
            {
                objuserinfo.LoginType = "Guest";
                objuserinfo.RoleID = 10;
                objuserinfo.Subscription = Subscription;
                objuserinfo.CreatedBy = "Guest";
                output = objRegDal.InsertUserRegisterInfo(objuserinfo);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + output + "');</script>", false);
            }
        }

        protected void btnForgetPass_Click(object sender, EventArgs e)
        {
            objuserinfo.EmailID = txtEmailid.Text;
            DataSet ds = (DataSet)objuserDal.ForgotPassword(objuserinfo);
            if (Convert.ToInt32(ds.Tables[0].Rows[0]["count"]) == 1)
            {
                sendInforamtion(txtEmailid.Text.Trim());
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Provided information is not correct.');</script>", false);
            }
            clearall();
        }

        protected void clearall()
        {
            txtEmailid.Text = "";
        }

        private void sendInforamtion(string EmailID)
        {
            DataSet dsout = new DataSet();
            StringBuilder mySB = new StringBuilder();
            string subject = string.Empty;
            string frmEmail = string.Empty;
            string strUserName = "";
            string strtoEmail = "";
            string strPwd = "";
            subject = "your account information";

            SentMessage(ref dsout, mySB, ref strUserName, ref strtoEmail, ref strPwd);
        }

        private void SentMessage(ref DataSet dsout, StringBuilder mySB, ref string strUserName, ref string strtoEmail, ref string strPwd)
        {
            try
            {
                dsout = (DataSet)objuserDal.getinfobyemilid(objuserinfo);

                if (dsout.Tables[0].Rows.Count > 0)
                {
                    if (dsout.Tables[0].Rows[0]["message"].ToString()=="")
                    {
                        strUserName = dsout.Tables[0].Rows[0]["LoginId"].ToString();
                        strtoEmail = dsout.Tables[0].Rows[0]["EmailID"].ToString();
                        strPwd = dsout.Tables[0].Rows[0]["Password"].ToString();
                        strUID = Convert.ToInt32(dsout.Tables[0].Rows[0]["UID"]);
                    }
                    else {

                        string output = dsout.Tables[0].Rows[0]["message"].ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('"+output+"');</script>", false);
                    }
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Provided information is not correct.');</script>", false);

                }
                string strURL = GetBaseURL();
                //this is for Loca
                strURL = strURL + "Account/Changepassword.aspx??bff=4R/69fgh'ggtsddf345&om=" + strUID;
                //strURL = strURL + "/PasswordReset.aspx?email=" + strtoEmail + "&token=" + strPwd;

                MailMessage mMailMessage = new MailMessage();

                // assign from address
                mMailMessage.From = new MailAddress("info@jayantpumps.com");

                // assign to address
                mMailMessage.To.Add(new MailAddress(strtoEmail));

                //mMailMessage.To.Add(new MailAddress(""));

                //set subject
                mMailMessage.Subject = "Link to Change Password......";

                mySB.Append("<table cellpadding=0 bgcolor=#e1f5fc cellspacing=0 width=800 align=left>");
                mySB.Append("<tr>");
                mySB.Append("<td align=left>");
                mySB.Append("<font size=2 color=black face=verdana>");
                mySB.Append("Hi <b>");
                mySB.Append(strUserName + "</b>");
                mySB.Append("<br><br>");
                mySB.Append("Can't remember your password, We will help you Happly.");
                mySB.Append("<br>");
                mySB.Append("</font>");
                mySB.Append("</td></tr>");
                mySB.Append("<tr>");
                mySB.Append("<td align=left><br>");
                mySB.Append("<font size=2 face=verdana>");
                mySB.Append("<b>");
                mySB.Append("Please click on the link below or copy and paste the URL into your browser");
                mySB.Append("</b>");
                mySB.Append("<br>");
                mySB.Append("<a target=_new href=");
                mySB.Append(strURL);
                mySB.Append(">");
                mySB.Append(strURL);
                mySB.Append("</a>");
                mySB.Append("</font>");
                mySB.Append("</td></tr>");
                mySB.Append("<tr>");
                mySB.Append("<td>");
                mySB.Append("This will reset your password. You can then login and change it to something.");
                mySB.Append("</td></tr>");
                mySB.Append("</table>");


                mMailMessage.Body = mySB.ToString();
                // check email type HTML or NOT
                mMailMessage.IsBodyHtml = true;

                // define new SMTP mail client
                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.Host = "204.11.58.75";

                mSmtpClient.Credentials = new NetworkCredential("info@jayantpumps.com", "P@s$w0rd");
                mMailMessage.Priority = MailPriority.High;

                //send email using defined SMTP client
                mSmtpClient.Send(mMailMessage);

                // display result to sender
                //imgDisplay.Visible = true;
                //imgDisplay.ImageUrl = "images/done.jpg";
                //lblMsg.Text = "Request sent successfully";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptkey", "<script>toastr.warning('Your request has been sent successfully.Please check your mail and go throught it.');</script>");
            }
            catch (Exception ex)
            {
                // display ERROR message to sender
                //imgDisplay.Visible = true;
                //imgDisplay.ImageUrl = "images/error.jpg";
            }
            //System.Threading.Thread.Sleep(2000);
        }
           
           
        
        public string GetBaseURL()
        {
            string GetURLBase;
            GetURLBase = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
            return GetURLBase;
        }
    }
}

      




    