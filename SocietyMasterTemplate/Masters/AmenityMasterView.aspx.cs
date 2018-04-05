using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using SocietyEntity;

namespace EsquareMasterTemplate.Masters
{
    public partial class AmenityMasterView : System.Web.UI.Page
    {


        int CurrentPage, ParentId;
        clsBuildingMasterDal objbuildinginfoDal = new clsBuildingMasterDal();
        clsAmenityDal objAminitydal = new clsAmenityDal();
        clsAmenityEntity objAminityEntity = new clsAmenityEntity();
        clsBuildingEntity objbuildinginfo = new clsBuildingEntity();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                this.BindListView();
                this.BindBuildingid();
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
           // string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            //if (objEmpinfo.EmployeeId == 0)
            //{
            //    objEmpinfo.EmployeeId = 0;
            //}
            objAminityEntity.BuildingId = drpBuildingid.SelectedValue == "" ? 0 :int.Parse(drpBuildingid.SelectedValue);
            string SocietyId = Convert.ToString(Session["ID"]) as string;
           
            objAminityEntity.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
   
            ds = (DataSet)objAminitydal.GetAminityInfo(objAminityEntity);

            lvAmenitymstr.DataSource = ds;
            lvAmenitymstr.DataBind();
        }
        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvAmenitymstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvAmenitymstr.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvAmenitymstr.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.BindListView();
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnamenityID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("AminityMaster", "AminityId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
             
            getsearchresult();

        }
        public void BindBuildingid()
        {
            DataSet ds = new DataSet();

            
            string SocietyId = Convert.ToString(Session["ID"]) as string;


            objbuildinginfo.SocietyIdvar = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            ds = (DataSet)objbuildinginfoDal.GetAllBuildingInfo(objbuildinginfo, Convert.ToString(Session["LoginId"]));
            drpBuildingid.DataSource = ds;
            drpBuildingid.DataTextField = "Name";
            drpBuildingid.DataValueField = "BuildingId";
            drpBuildingid.DataBind();

            ListItem objLI = new ListItem();
            drpBuildingid.Items.Insert(0, objLI);
        }
        
        public void getsearchresult()
        {
            try
            {
                objAminityEntity.BuildingId = drpBuildingid.SelectedValue == "" ? 0 : Convert.ToInt32(drpBuildingid.SelectedValue);
                //objAminityEntity.AminityId = Convert.ToInt32(drpBuildingid.SelectedValue);
                DataSet ds = new DataSet();

                string SocietyId = Convert.ToString(Session["ID"]) as string;


                objAminityEntity.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
                ds = (DataSet)objAminitydal.GetAmenitybyBuildname(objAminityEntity,Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvAmenitymstr.DataSource = ds;
                    lvAmenitymstr.DataBind();
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
                objdelrecord.CommonDeleteMaster("AminityMaster", "AminityId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record deleted successfully.');</script>", false);
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AmenityMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AmenityMasterView.aspx");
        }




    }
}