using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using System.Configuration;
using SocietyEntity;

namespace EsquareMasterTemplate.Masters
{
    public partial class MonthlyMaintenanceMasterView : System.Web.UI.Page
    {
        int CurrentPage;
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        MonthlyMaintenanceMasterDAL objmainDal = new MonthlyMaintenanceMasterDAL();
        clsMonthlyMaintenaceEntity objentity = new clsMonthlyMaintenaceEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                //ValidateUserPermissions();
                this.BindListView();
                //ValidateUserPermissions();
               // FillcaltypemasterDropDowns();
            }

        }

        //private void ValidateUserPermissions()
        //{
        //    string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
        //    DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url);
        //    if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
        //    {
        //        Response.Redirect("../error-page/Success-page.aspx");
        //    }
        //    else
        //    {
        //        //To do: inpage rolewise retrictions if required.
        //    }
        //}

        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objdelrecord.CommonDeleteMaster("MonthlyMaintenanceMaster", "MonthlyMaintenaceId", strAllID,Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
               this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully');</script>", false);
            }
        }


        private void BindListView()
        {
            DataSet ds = new DataSet();
            string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            //if (objEmpinfo.EmployeeId == 0)
            //{
            //    objEmpinfo.EmployeeId = 0;
            //}
           
            objentity.MonthlyMaintenaceId = 0;
            
            ds = (DataSet)objmainDal.GetMonthlyMaintainanceinfobyid(objentity);
             //lvMainMstr.DataSource = ds.Tables[0];
            lvMainMstr.DataSource = ds;
            lvMainMstr.DataBind();
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMainMstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvMainMstr.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvMainMstr.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("MonthlyMaintenanceMaster.aspx");
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("MonthlyMaintenanceMasterView.aspx");
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();
        }


        public void getsearchserult()
        {
            try
            {

                DataSet ds = new DataSet();
                objentity.flag = "searchMonthlyMaininfo";
                objentity.PropertyType = drpPropertytype.SelectedValue;
                objentity.CalculationMethod = drpCalcMethod.SelectedValue;
                objentity.EffectiveFromDate = txtEffectivefromDate.Text;
                objentity.EffectiveToDate = txtEffectiveToDate.Text;
                ds = (DataSet)objmainDal.GetMonthlyMaintenanceInfo(objentity);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvMainMstr.DataSource = ds;
                    lvMainMstr.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        
        }

    }
}