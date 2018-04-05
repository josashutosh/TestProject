using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyEntity;
using SocietyDAL;
using System.Data;

namespace EsquareMasterTemplate.Masters
{
    public partial class SecuritySalaryMaster : System.Web.UI.Page
    {
        string output;
        SecuritySalaryEntity objsecurityinfo = new SecuritySalaryEntity();
        SecuritySalaryDAL objdal = new SecuritySalaryDAL();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        int SecurityId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ValidateUserPermissions();
               
            }
        }

        private void ValidateUserPermissions()
        {
            string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
            DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, 0);
            if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
            {
                Response.Redirect("../error-page/Success-page.aspx");
            }
            else
            {
                //To do: inpage rolewise retrictions if required.
            }
        }


        protected void btnsubmit_Click(object sender, EventArgs e)
        {


            if (SecurityId == 0)
            {
                objsecurityinfo.SecurityId = 0;
            }
            else
            {
                Session["SecurityId"] = SecurityId.ToString();
                objsecurityinfo.SecurityId = Convert.ToInt32(Session["SecurityId"]);
            }

            objsecurityinfo.NoOfSecurityGuards = Convert.ToInt32(drpnumparking.SelectedValue);
            objsecurityinfo.GuardSalary =Convert.ToInt32(txtSalary.Text);
            objsecurityinfo.Totalguardsal = Convert.ToInt32(txtSecuritysalary.Text); 
            objsecurityinfo.NoOfSupervisor = Convert.ToInt32(txtNumberofSupervisor.Text);
            objsecurityinfo.SupervisorSalary = Convert.ToInt32(txtSupervisorsalary.Text);
            objsecurityinfo.CompanyName = txtcompanyname.Text;
            objsecurityinfo.TotalSalary = Convert.ToInt32(txttotal.Text);
            objsecurityinfo.createdBy =  Convert.ToString(Session["LoginId"]); 
            output = objdal.InsertSecuritySalary(objsecurityinfo);

            
            btnsubmit.Text = "Submit";
            clearall();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
        }

        private void clearall()
        {
            drpnumparking.SelectedValue = "";
            txtSalary.Text = "";
            txtNumberofSupervisor.Text = "";
            txtSupervisorsalary.Text = "";
            txtcompanyname.Text = "";

        }

    }
}