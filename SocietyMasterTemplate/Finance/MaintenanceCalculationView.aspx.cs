using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyEntity;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;

namespace EsquareMasterTemplate.Finance
{
    public partial class MaintenanceCalculationView : System.Web.UI.Page
    {
        int CurrentPage, ParentId;

        clsBuildingMasterDal objbuildinginfoDal = new clsBuildingMasterDal();
        clsBuildingEntity objbuildinginfo = new clsBuildingEntity();
        clsBuildingEntity objbuildinfo = new clsBuildingEntity();
        clsBuildingMasterDal objbuidDal = new clsBuildingMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
        clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        string output = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ValidateUserPermissions();

                BindBuildingid();

                drpBuildingid.Items.Insert(0, new ListItem("--Select Building Name--", ""));
                drpBuildingid.SelectedIndex = 0;
            }
        }


        private void BindListView()
        {
            DataSet ds = new DataSet();
            string FlatId = Convert.ToString(0);
            string flag = "searchflatinfo";
            string SocietyId = Convert.ToString(Session["ID"]) as string;


            //  objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            //ds = (DataSet)objflatDal.getflatinfobyflatidFlag(flag, FlatId, Convert.ToString(Session["LoginId"]), SocietyId);
            lvMstr.DataSource = ds;
            lvMstr.DataBind();
        }

        public void BindBuildingid()
        {
            DataSet ds = new DataSet();
            objbuildinginfo.BuildingId = 0;
            string SocietyId = Convert.ToString(Session["ID"]) as string;
            objbuildinginfo.SocietyIdvar = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            //objbuildinginfo.SocietyIdvar = "3";
            ds = (DataSet)objbuildinginfoDal.GetAllBuildingInfo(objbuildinginfo, Convert.ToString(Session["LoginId"]));
            drpBuildingid.DataSource = ds;
            drpBuildingid.DataTextField = "Name";
            drpBuildingid.DataValueField = "BuildingId";
            drpBuildingid.DataBind();

            //ListItem objLI = new ListItem("", "0");
            //drpBuildingid.Items.Insert(0, objLI);
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
                    ViewState["ParentId"] = ParentId;
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }

        private void FillBuildingDropDowns()
        {
            string SocietyId = string.Empty;

            if (SocietyId == "") { SocietyId = ""; } else { SocietyId = Convert.ToString(Session["ID"]); }
            objbuildinfo.SocietyIdvar = SocietyId;
            objCommonDAL.FillDropDown(drpBuildingid, ((DataSet)objbuidDal.GetAllBuildingInfo(objbuildinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "Name", "BuildingId", "-- Select Building Name --");
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.BindListView();
        }
        public class clsFlatNumber
        {
            public int FlatId { get; set; }
            public string MaintenancePeriod { get; set; }
            public string PropertyType { get; set; }
            public string FlatNumber { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static string getFlatsbyBuildName(string BuildingId)
        {
            clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
            clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();


            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            // objMainCollEntity.LoginId = "sunder";
            objMainCollEntity.BuildingId = Int32.Parse(BuildingId);
            ds = (DataSet)objMainCollDAL.GetFlatNumberByBuildingId(objMainCollEntity);
            List<clsFlatNumber> M = new List<clsFlatNumber>();
            if (ds.Tables.Count > 0)
            {   
                //M.Clear();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    clsFlatNumber MF = new clsFlatNumber();
                    MF.FlatId = Convert.ToInt32(ds.Tables[0].Rows[i]["FlatId"].ToString());
                    MF.FlatNumber = ds.Tables[0].Rows[i]["FlatNumber"].ToString();
                    M.Add(MF);
                }
            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }
            return JsonConvert.SerializeObject(M);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            objMainCollEntity.BuildingId = Convert.ToInt32(drpBuildingid.SelectedValue);
            objMainCollEntity.FlatId = Convert.ToInt32(Request.Form[drpFlatID.UniqueID]);
            objMainCollEntity.SocietyId = Convert.ToInt32(Session["Id"].ToString());
            objMainCollEntity.PropertyType = drpPropertytype.SelectedItem.Text;
            objMainCollEntity.Fromyear = txtfromyear.Text.Trim();
            objMainCollEntity.FromMonth = txtfrommonth.Text.Trim();
            objMainCollEntity.ToYear = txtToyear.Text.Trim();
            objMainCollEntity.ToMonth = txtTomonth.Text.Trim();
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            // objMainCollEntity.LoginId = "sunder";
            objMainCollEntity.BuildingId = Convert.ToInt32(drpBuildingid.SelectedValue);

            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objMainCollDAL.GetFlatNumberByBuildingId(objMainCollEntity)).Tables[0], "FlatNumber", "FlatId");
            drpFlatID.SelectedValue = Request.Form[drpFlatID.UniqueID].ToString().Trim();

            //objMainCollEntity.BuildingId = 1;
            //objMainCollEntity.FlatId = 7;
            //objMainCollEntity.SocietyId = 3;
            //objMainCollEntity.PropertyType = "Residential";
            //objMainCollEntity.From = "2015-05-01";
            //objMainCollEntity.To = "2015-10-31";

            DataSet ds = (DataSet)objMainCollDAL.GetMaintainanceView(objMainCollEntity);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lvMstr.DataSource = ds;
                lvMstr.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found.'); </script>", false);
            }

        }


        protected void btndelete_Click(Object sender, EventArgs e)
        {
            //Button myButton = (Button)sender;

            objMainCollEntity.PropertyType = hidnpropertyType.Value;
            objMainCollEntity.ID = Convert.ToInt32(hidnResidentialCollID.Value);
            objMainCollEntity.Remark = txtRemark.Text.TrimStart();
            objMainCollEntity.CreatedBy = Session["LoginId"].ToString();
            string propertyType = drpPropertytype.SelectedItem.Text;

            objMainCollEntity.Fromyear = txtfromyear.Text.Trim();
            objMainCollEntity.FromMonth = txtfrommonth.Text.Trim();
            objMainCollEntity.ToYear = txtToyear.Text.Trim();
            objMainCollEntity.ToMonth = txtTomonth.Text.Trim();
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            objMainCollEntity.BuildingId = Convert.ToInt32(drpBuildingid.SelectedValue);
            objMainCollEntity.FlatId = Convert.ToInt32(Request.Form[drpFlatID.UniqueID]);
            objMainCollEntity.SocietyId = Convert.ToInt32(Session["Id"].ToString());

            string DeleteClienDetails = objMainCollDAL.DeleteMaintainanceCalculationDetail(objMainCollEntity);

            objMainCollEntity.PropertyType = propertyType;

            // objMainCollEntity.LoginId = "sunder";

            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objMainCollDAL.GetFlatNumberByBuildingId(objMainCollEntity)).Tables[0], "FlatNumber", "FlatId");
            drpFlatID.SelectedValue = Request.Form[drpFlatID.UniqueID].ToString().Trim();

            DataSet ds = (DataSet)objMainCollDAL.GetMaintainanceCalculationView(objMainCollEntity);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lvMstr.DataSource = ds;
                lvMstr.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found.'); </script>", false);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + DeleteClienDetails + "'); </script>", false);

        }



        protected void btnAddCollmaster_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaintenanceCalculation.aspx?PId=" + ViewState["ParentId"].ToString());
        }



    }

}