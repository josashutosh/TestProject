using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyDAL;

namespace EsquareMasterTemplate.Account
{
    public partial class Changepassword : System.Web.UI.Page
    {
        SaltEncryption objEnc = new SaltEncryption();
        string Output = string.Empty;
        string Jscript, Client, strEncPass, strPass, pwd, str, oldpwd, newpwd ;
        int strUID, uid;

        clsUserDAL objuserDal = new clsUserDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                strUID = Convert.ToInt32(Request.QueryString["om"]);
                Session["strUID"] = strUID;
            }
           // string url = Session["REurl"].ToString();
            
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            DataSet dsout = new DataSet();
            oldpwd = txtoldpasswrd.Text.Trim();
            Session["OldPwd"] = oldpwd;
            uid = Convert.ToInt32(Session["strUID"]);
            dsout = (DataSet)objuserDal.GetUserInfobyUID(uid);
            DataRow drLogin = dsout.Tables[0].Rows[0];
            strPass = Convert.ToString(drLogin["Password"]);
            Session["Password"] = strPass;


            if (ValidateUserCredentials() == true)
            {
                string newpass = objEnc.ComputeHash(txtnewpasswrd.Text.Trim().ToString(), "SHA512", null); 
        
                string Password = newpass;

                objuserDal.fnChangePassword(Password,Convert.ToInt32(Session["strUID"]));


                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Password Changed Successfully....'); </script>", false);
               // toastr.warning("Password Changed Successfully....");
                //Jscript = "<script>alert('Password Changed Succesfully!!!!');</script>";
                //Page.RegisterClientScriptBlock("SetAlert();", Jscript);
                //Response.Redirect("Login.aspx");
                Response.AddHeader("REFRESH", "5;URL= '" + "Login.aspx" + "'");

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Old Password Is Worng'); </script>", false);
                //toastr.warning("Old Password Is Worng");

            }
        }

        private bool ValidateUserCredentials()
        {
            bool PassValid = objEnc.VerifyHash(txtoldpasswrd.Text.Trim().ToString(), "SHA512", strPass);

            if (PassValid == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
