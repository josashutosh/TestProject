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
using SocietyEntity;
using EsquareMasterTemplate.Common;
namespace EsquareMasterTemplate.Masters
{
    public partial class EmployeeMasterView : System.Web.UI.Page
    {
        string output;
        int CurrentPage, ParentId;
        EmployeeMasterDal objEmpinfoDal = new EmployeeMasterDal();
        clsEmployeeEntity objEmpinfo = new clsEmployeeEntity();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        ExportToExcel objExcel = new ExportToExcel();

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
            string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            ds = (DataSet)objEmpinfoDal.GetAllEmployeeInfo(objEmpinfo,Convert.ToString(Session["LoginId"]));
            if (ds.Tables[0].Rows.Count > 0)
            {
                lvEmployee.DataSource = ds;
                lvEmployee.DataBind();
            }
            else
            {
                lvEmployee.DataSource = null;
                lvEmployee.DataBind();
            }
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvEmployee.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvEmployee.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvEmployee.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnempID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("EmployeeMaster", "EmployeeId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }

        protected void Content_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            LinkButton btndelete = sender as LinkButton;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnempID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("EmployeeMaster", "EmployeeId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();

        }

        public void getsearchserult()
        {

            try
            {
                objEmpinfo.EmployeeNo = txtsearch.Text.Trim();
                DataSet ds = new DataSet();
                ds = (DataSet)objEmpinfoDal.GetemployeebyEmpNo(objEmpinfo,Convert.ToString(Session["loginId"]));


                if (ds.Tables[0].Rows.Count > 0)
                {

                    lvEmployee.DataSource = ds;
                    lvEmployee.DataBind();
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
                objdelrecord.CommonDeleteMaster("EmployeeMaster", "EmployeeId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeMasterView.aspx");
        }

        protected void imgExport_Click(object sender, ImageClickEventArgs e)
        {
            objEmpinfo.EmployeeNo = txtsearch.Text == "" ? "" : txtsearch.Text.Trim();
            //objBuildingEntity.BuildingId = 0;
            DataSet ds = txtsearch.Text == "" ? (DataSet)objEmpinfoDal.GetAllEmployeeInfo(objEmpinfo, Convert.ToString(Session["LoginId"]))
                : (DataSet)objEmpinfoDal.GetemployeebyEmpNo(objEmpinfo, Convert.ToString(Session["loginId"]));

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