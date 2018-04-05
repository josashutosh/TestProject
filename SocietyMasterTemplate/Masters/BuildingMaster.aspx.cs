using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyDAL;
using SocietyEntity;
namespace EsquareMasterTemplate.Masters
{
    public partial class BuildingMaster : System.Web.UI.Page
    {
        string output, Name, LoginType;
        int Floors, Flats, Totalarea, BuildingId, ParentId;

        clsBuildingMasterDal objBuildingDal = new clsBuildingMasterDal();
        clsBuildingEntity objBuildinginfo = new clsBuildingEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            BuildingId = Convert.ToInt32(Request.QueryString["BuildingId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            LoginType = Convert.ToString(Session["LoginType"]);

            if (!IsPostBack)
            {
                ValidateUserPermissions(ParentId);
                FillDropDowns();
                UpdateBuildingMaster();
                HideShowControls();
            }
        }

        private void HideShowControls()
        {
            if (LoginType == "SuperAdmin")
            {
                societynameddl.Visible = true;
            }
        }

        private void FillDropDowns()
        {
            objCommonDAL.FillDropDown(ddlSocietyName, ((DataSet)objCommonDAL.GetSocietyList(Convert.ToString(Session["LoginId"]))).Tables[0], "SocietyName", "SocietyId", "- Select Society Name -"); 
        }

        private void ValidateUserPermissions(int ParentId)
        {
            if (Session["RoleId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Your session expired, you are logging out..!!');</script>", false);
                Response.Redirect("../Account/Login.aspx");
            }
            else
            {
                string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, ParentId);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                    //ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }
        private void UpdateBuildingMaster()
        {
            if (BuildingId != 0)
            {
                DataSet ds = new DataSet();

                objBuildinginfo.BuildingId = BuildingId;

                ds = (DataSet)objBuildingDal.GetAllBuildingInfo(objBuildinginfo, Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtBuildingname.Text = ds.Tables[0].Rows[0]["Name"].ToString().Trim() ;
                    ddlSocietyName.SelectedValue = LoginType == "SuperAdmin" ? ds.Tables[0].Rows[0]["SocietyId"].ToString() : Convert.ToString(Session["SocietyId"]);
                    txtFloors.Text = ds.Tables[0].Rows[0]["Floors"].ToString();
                    txtFlats.Text = ds.Tables[0].Rows[0]["Flats"].ToString();
                    txtArea.Text = ds.Tables[0].Rows[0]["TotalArea"].ToString();
                    Session["_BuildingId"] = BuildingId.ToString();
                    btnBuildingSubmit.Text = "Update";
                }
            }
            else
            {
                btnBuildingSubmit.Text = "Save";
            }
        }
        protected void btnBuildingSubmit_Click(object sender, EventArgs e)
        {
            if (BuildingId == 0)
            {
                objBuildinginfo.BuildingId = 0;
            }
            else
            {
                Session["_BuildingId"] = BuildingId.ToString();
                objBuildinginfo.BuildingId = Convert.ToInt32(Session["_BuildingId"]);
            }
            objBuildinginfo.Name = txtBuildingname.Text;
            objBuildinginfo.SocietyId = LoginType == "SuperAdmin" ? Convert.ToInt16(ddlSocietyName.SelectedValue) : Convert.ToInt16(Session["ID"]);
            objBuildinginfo.Floors = Convert.ToInt32(txtFloors.Text);
            objBuildinginfo.Flats = Convert.ToInt32(txtFlats.Text);
            objBuildinginfo.TotalArea = Convert.ToInt32(txtArea.Text);
            objBuildinginfo.CreatedBy = Convert.ToString(Session["LoginId"]);

            output = objBuildingDal.InsertBuildingInformation(objBuildinginfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
            clearall();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session["_BuildingId"] = null;
            Response.Redirect("BuildingMasterView.aspx");
        }

        private void clearall()
        {
            txtBuildingname.Text = "";
            txtFloors.Text = "";
            txtFlats.Text = "";
            txtArea.Text = "";
            Session["_BuildingId"] = null;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clearall();
            Session["_BuildingId"] = null;
        }
    }
}