using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyDAL;
using System.Data;
using System.Configuration;
using SocietyDAL;
namespace EsquareMasterTemplate.Masters
{
    public partial class VehicleMasterView : System.Web.UI.Page
    {
        int CurrentPage,ParentId;
        clsVehicleEntity objvehicleinfo = new clsVehicleEntity();
        clsVehicleMasterDal objvehDal = new clsVehicleMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                this.BindListView();
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
                    ParentId = Convert.ToInt16(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }
        private void BindListView()
        {
            DataSet ds = new DataSet();
            //string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            //if (objEmpinfo.EmployeeId == 0)
            //{
            //    objEmpinfo.EmployeeId = 0;
            //}
            objvehicleinfo.flag = "getallrecord";
            objvehicleinfo.FlatId = 0;
            ds = (DataSet)objvehDal.GetVehicleInfo(objvehicleinfo,Convert.ToString(Session["LoginId"]));

            lvVehicleMstr.DataSource = ds;
            lvVehicleMstr.DataBind();
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvVehicleMstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvVehicleMstr.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvVehicleMstr.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }


        //protected void btndelete_Click(object sender, EventArgs e)
        //{
        //    DataSet ds = new DataSet();
        //    Button btndelete = sender as Button;
        //    ListViewItem item = btndelete.NamingContainer as ListViewItem;
        //    HiddenField hf = item.FindControl("hdnVehicleID") as HiddenField;
        //    HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
        //    string id = hf.Value;
        //    objdelrecord.CommonDeleteMaster("VehicleMaster", "Vehicleid", id, Convert.ToString(Session["LoginId"]));
        //    BindListView();
        //}

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();

        }

        public void getsearchserult()
        {
            try
            {
                objvehicleinfo.FlatNumber = txtsearch.Text.Trim();
                DataSet ds = new DataSet();
                objvehicleinfo.flag = "searchVehicleinfo";
                ds = (DataSet)objvehDal.GetVehicleInfo(objvehicleinfo,Convert.ToString(Session["LoginId"]));
                if (ds.Tables[0].Rows.Count > 0)
                {

                    lvVehicleMstr.DataSource = ds;
                    lvVehicleMstr.DataBind();

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

        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objdelrecord.CommonDeleteMaster("VehicleMaster", "Vehicleid", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("VehicleMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("VehicleMasterView.aspx");
        }

    }
}