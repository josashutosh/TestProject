using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyDAL;
using System.Data;
namespace EsquareMasterTemplate.Masters
{
    public partial class ParkingMasterView : System.Web.UI.Page
    {
        int CurrentPage, ParentId;
        clsParkingMasterDal objparkingDal = new clsParkingMasterDal();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
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

            //if (objEmpinfo.EmployeeId == 0)
            //{
            //    objEmpinfo.EmployeeId = 0;
            //}
            int parkid = 0;
            ds = (DataSet)objparkingDal.GetAllParkingdata(parkid,Convert.ToString(Session["LoginId"]));

            lvParkingMaster.DataSource = ds;
            lvParkingMaster.DataBind();
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvParkingMaster.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvParkingMaster.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvParkingMaster.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnParkID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("ParkingMaster", "ParkingId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();
        }

        public void getsearchserult()
        {
            string search;
            try
            {
                search = txtsearch.Text.Trim();

                DataSet ds = new DataSet();
                ds = (DataSet)objparkingDal.GetPaarkingbyflat(search, 0, Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvParkingMaster.DataSource = ds;
                    lvParkingMaster.DataBind();
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
                objdelrecord.CommonDeleteMaster("ParkingMaster", "ParkingId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParkingMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParkingMasterView.aspx");
        }

    }
}