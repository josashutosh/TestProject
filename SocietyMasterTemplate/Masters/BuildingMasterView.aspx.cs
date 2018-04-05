using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;

using System.Data;
using SocietyEntity;
using EsquareMasterTemplate.Common;
namespace EsquareMasterTemplate.Masters
{
    public partial class BuildingMasterView : System.Web.UI.Page
    {
        clsBuildingMasterDal objBuildingMstrdal = new clsBuildingMasterDal();
        clsBuildingEntity objBuildingEntity = new clsBuildingEntity();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        ExportToExcel objExcel = new ExportToExcel();
        int CurrentPage,ParentId;

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
                    ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }
        private void BindListView()
        {
            DataSet ds = new DataSet();
            objBuildingEntity.BuildingId = 0;
        
            ds = (DataSet)objBuildingMstrdal.GetAllBuildingInfo(objBuildingEntity, Convert.ToString(Session["LoginId"]));

            lvBuildMstr.DataSource = ds;
            lvBuildMstr.DataBind();
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvBuildMstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
             CurrentPage = (((lvBuildMstr.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvBuildMstr.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }
        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnbuildingID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("BuildingMaster", "BuildingId", id, Convert.ToString(Session["LoginId"]));
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
                objBuildingEntity.Name = txtsearch.Text.Trim();
                DataSet ds = new DataSet();
                ds = (DataSet)objBuildingMstrdal.GetBuildingName(objBuildingEntity,Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {

                    lvBuildMstr.DataSource = ds;
                    lvBuildMstr.DataBind();
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
                objdelrecord.CommonDeleteMaster("BuildingMaster", "BuildingId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record deleted successfully.');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuildingMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuildingMasterView.aspx");
        }

       

        protected void imgExport_Click(object sender, ImageClickEventArgs e)
        {
            objBuildingEntity.Name = txtsearch.Text == "" ? "" : txtsearch.Text.Trim();
            objBuildingEntity.BuildingId = 0;
            DataSet ds = txtsearch.Text == "" ? (DataSet)objBuildingMstrdal.GetAllBuildingInfo(objBuildingEntity, Convert.ToString(Session["LoginId"]))
                : (DataSet)objBuildingMstrdal.GetBuildingName(objBuildingEntity, Convert.ToString(Session["LoginId"]));

            DateTime d = DateTime.Now;
            string dateString = d.ToString("yyyyMMddHHmmss");
            string fileName = "BuildingView" + dateString;
            string strPath = Server.MapPath(Request.ApplicationPath);
            strPath = strPath + "\\Images\\Document\\" + fileName + ".xls";

            objExcel.ExcelExport(ds, strPath);

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ClearContent();
            Response.ContentType = "application/ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + ".xls");
            Response.WriteFile(strPath);
            Response.End();
            Response.Flush();
        }
    }
}