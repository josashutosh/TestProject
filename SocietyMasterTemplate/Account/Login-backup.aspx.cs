using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using SocietyDAL;

namespace EsquareMasterTemplate
{
    public partial class Login : System.Web.UI.Page
    {
        SaltEncryption objenc = new SaltEncryption();
        public string strPass, str;
        clsUserDAL objdal = new clsUserDAL();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            try
            {
                ds = (DataSet)objdal.GetUserDetails(txtUsername.Text.Trim().ToString());

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow drLogin = ds.Tables[0].Rows[0];
                    strPass = Convert.ToString(drLogin["Password"]);
                    //Session["Password"] = strPass;

                    if (ValidateUserCredentials() == true)
                    {
                        // Session["Roomno"] = ds.Tables[0].Rows[0]["Roomno"];
                        Session["UID"] = ds.Tables[0].Rows[0]["UID"];
                        Session["Flatno"] = ds.Tables[0].Rows[0]["Flatno"];
                        Session["RollId"] = ds.Tables[0].Rows[0]["RollId"];
                        Session["RollType"] = ds.Tables[0].Rows[0]["RollType"];
                        Response.Redirect("TestMaster/FormControlHor.aspx");
                    }
                    else
                    {
                        //clsAlert.Show("daadad");
                       ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('The username or password you entered is incorrect.... ')</script>", false);
                        
                        //SocietyMgmtDAL.Alert.Show("The username or password you entered is incorrect.... ");
                       // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "toastr.warning", "<script type='text/javascript'>tostWarn();</script>", false);
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "toastr.warning", "tostWarn();", true);
                    }

                }
                else
                {
                    //clsAlert.Show("daadad");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "tostWarn();", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "toastr", "<script type='text/javascript' language='javascript'>toastr.warning('The username or password you entered is incorrect.... ');</script>", false);
                    //SocietyMgmtDAL.Alert.Show("The username or password you entered is incorrect.... ");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                ds.Dispose();
            }
        }

        private bool ValidateUserCredentials()
        {
            bool PassValid = objenc.VerifyHash(txtPassword.Text.Trim().ToString(), "SHA512", strPass);

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