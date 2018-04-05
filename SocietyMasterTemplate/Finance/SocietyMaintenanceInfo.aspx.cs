using System;
using System.Web.UI;
using SocietyEntity;
using SocietyDAL;
using System.Data;
using System.Configuration;
using System.Web;

namespace EsquareMasterTemplate.Masters
{
    public partial class SocietyMaintenanceInfo : System.Web.UI.Page
    {
        SocietyMonthlyExpensesEntity objMonthlyExpense = new SocietyMonthlyExpensesEntity();
        MonthlyExpensesDAL objdal =new MonthlyExpensesDAL();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        string Output = string.Empty;
        int MonthlyExpenseId;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            //txtTotal.Attributes.Add("onfocus", "totalsum(this.value);");
            //txtSecuritycharge.Focus();
            //txtSupervisor.Focus();
    
            if (!this.IsPostBack)
            {
                this.getSalary();
                ValidateUserPermissions();
            }

        }

        private void ValidateUserPermissions()
        {
            string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
            DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url,0);
            if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
            {
                Response.Redirect("../error-page/Success-page.aspx");
            }
            else
            {
                //To do: inpage rolewise retrictions if required.
            }
        }
        protected void getSalary()
        {
           
        DataSet ds = new DataSet();
        string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
       
        ds = objdal.GetSalary(objMonthlyExpense);
        if (ds.Tables[0].Rows.Count > 0)
        {
            txtSecuritycharge.Text = ds.Tables[0].Rows[0]["TotalGuardsal"].ToString();
            txtSupervisor.Text = ds.Tables[0].Rows[0]["SupervisorSalary"].ToString();
            txtTotal.Text = ds.Tables[0].Rows[0]["TotalSalary"].ToString();
        }
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>focus();</script>", false);
}


        protected void btnmensubmit_Click(object sender, EventArgs e)
        {


            if (MonthlyExpenseId == 0)
            {
                objMonthlyExpense.MonthlyExpenseId = 0;
            }
            else
            {
                Session["MonthlyExpenseId"] = MonthlyExpenseId.ToString();
                objMonthlyExpense.MonthlyExpenseId = Convert.ToInt32(Session["MonthlyExpenseId"]);
            }

            objMonthlyExpense.SecurityId = Convert.ToInt32(Session["SecurityId"]);
            objMonthlyExpense.PowerCharges = float.Parse(txtPowerbill.Text);
            objMonthlyExpense.WaterCharges = float.Parse(txtWaterCharges.Text);
            objMonthlyExpense.SecuritySalary = float.Parse(txtSecuritycharge.Text);
            objMonthlyExpense.HousekeepingSalary = float.Parse(txtHousekeepingsal.Text);
            objMonthlyExpense.ManagerSalary = float.Parse(txtManagersalary.Text);
            objMonthlyExpense.Stationary = float.Parse(txtStationary.Text);
            objMonthlyExpense.DgSet = float.Parse(txtDgsetexpense.Text);
            objMonthlyExpense.GymInstructor = float.Parse(txtgyminspector.Text);
            objMonthlyExpense.CommunityHall = float.Parse(txtCommunityhall.Text);
            objMonthlyExpense.InsurancePremium = float.Parse(txtRepayment.Text);
            objMonthlyExpense.Miscellaneous = float.Parse(txtOtherCharges.Text);
           objMonthlyExpense.SupervisorSalary = float.Parse(txtSupervisor.Text);
            objMonthlyExpense.FromDate = txtEffectiveFromDateM.Text;
            objMonthlyExpense.ToDate = EffectiveToDate.Text;

            objMonthlyExpense.SumTotal = float.Parse(txtTotal.Text);

            objMonthlyExpense.CreatedBy = Session["LoginId"].ToString() ;
           
           Output = objdal.InsertMonthlyExpenses(objMonthlyExpense);

            btnmensubmit.Text = "Submit";
            //clearall();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + Output + "');</script>", false);
        }
        }
    }