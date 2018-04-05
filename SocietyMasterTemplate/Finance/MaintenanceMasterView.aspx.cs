using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using System.Configuration;
using SocietyEntity;
using System.Web;

namespace EsquareMasterTemplate.Masters
{
    public partial class MaintenanceMasterView : System.Web.UI.Page
    {
        int ParentId;
        clsMaintainanceMasterDal objmainDal = new clsMaintainanceMasterDal();
        clsMaintenanceMstrEntity objmaininfo = new clsMaintenanceMstrEntity();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                this.BindListView();
                FillcaltypemasterDropDowns();
            }
        }
        private void ValidateUserPermissions()
        {
            if (Session["RoleId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Your session expired, you are logging out..!!');</script>", false);
                Response.Redirect("../Account/Login.aspx");
            }
            else
            {
                string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, 0);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                    ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
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
            objmaininfo.flag = "getallrecord";
          
            ds = (DataSet)objmainDal.GetMaintainanceInfo(objmaininfo,Session["LoginId"].ToString());
            lvMainMstr.DataSource = ds;
            lvMainMstr.DataBind();
        }


        private void FillcaltypemasterDropDowns()
        {
            objmaininfo.flag = "FillcaltypemasterDropDowns";
            objmainDal.FillDropDown(drpCalcMethod, ((DataSet)objmainDal.GetMaintainanceInfoByID(objmaininfo)).Tables[0], "CalculationMethod", "CalcMasterID");
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            ((DataPager) lvMainMstr.FindControl("DataPager1")).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.BindListView();
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
                objmaininfo.flag = "searchMaininfo";
                objmaininfo.PropertyType=drpPropertytype.SelectedValue;
                objmaininfo.CalcMasterID=Convert.ToInt32(drpCalcMethod.SelectedValue);
                objmaininfo.EffectiveFromDate=txtEffectivefromDate.Text;
                objmaininfo.EffectiveToDate=txtEffectiveToDate.Text;
                ds = (DataSet)objmainDal.GetMaintainanceInfo(objmaininfo,Session["LoginId"].ToString());

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

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnmainmstrID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("MaintenanceMaster", "MaintenanceID", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }


        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objdelrecord.CommonDeleteMaster("MaintenanceMaster", "MaintenanceID", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully');</script>", false);
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaintenanceMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaintenanceMasterView.aspx");
        }

    }
}