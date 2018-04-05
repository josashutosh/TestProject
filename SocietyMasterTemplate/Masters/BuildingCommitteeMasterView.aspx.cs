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
    public partial class BuildingCommitteMasterView : System.Web.UI.Page
    {
        int ParentId;
        clsCommitteeMemberDal objcommiDal = new clsCommitteeMemberDal();
        clsCommitteeMemberEntity objcommiinfo = new clsCommitteeMemberEntity();
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
            string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
            DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url,0);
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

        private void BindListView()
        {
            DataSet ds = new DataSet();
            string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            //if (objEmpinfo.EmployeeId == 0)
            //{
            //    objEmpinfo.EmployeeId = 0;
            //}
            objcommiinfo.flag = "getallrecord";
            ds = (DataSet)objcommiDal.GetcommitteeInfo(objcommiinfo);
            
            lvCommittee.DataSource = ds;
            lvCommittee.DataBind();
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCommittee.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
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
                objcommiinfo.Designation = txtsearch.Text.Trim();
                DataSet ds = new DataSet();
                objcommiinfo.flag = "searchCommitteeinfo";
                ds = (DataSet)objcommiDal.GetcommitteeInfo(objcommiinfo);

                if (ds.Tables[0].Rows.Count > 0)
                {

                    lvCommittee.DataSource = ds;
                    lvCommittee.DataBind();

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
            HiddenField hf = item.FindControl("CommiteeMemberId") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("CommiteeMemberMaster", "CommiteeMemberId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }
        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objdelrecord.CommonDeleteMaster("CommiteeMemberMaster", "CommiteeMemberId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuildingCommittee.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuildingCommitteeMasterView.aspx");
        }







    }
}