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
    public partial class MaintenacePaymentMaster : System.Web.UI.Page
    {
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsOwnerMasterDal objownerdal = new clsOwnerMasterDal();
        clsOwnerInfo objownerinfo = new clsOwnerInfo();
        clsOwnerMasterDal objownerDal = new clsOwnerMasterDal();
        clsBuildingEntity objbuildinfo = new clsBuildingEntity();
        clsBuildingMasterDal objbuidDal = new clsBuildingMasterDal();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatDal = new clsFlatMasterDal();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Convert.ToString(Session["Roomno"]) == "")
                //{
                //    Response.Redirect("login.aspx");
                //}
                FillPageDropDowns();
           
                FillBuildingDropDowns();
              
                drpBuildingID.Items.Insert(0, new ListItem("--Select Building Name--", "0"));
                drpBuildingID.SelectedIndex = 0;


                drpFlatID.Items.Insert(0, new ListItem("Select Flat Number--", ""));
                drpFlatID.SelectedIndex = 0;
            }
        }

        private void FillBuildingDropDowns()
        {
            objParkingDal.FillDropDown(drpBuildingID, ((DataSet)objbuidDal.GetAllBuildingInfo(objbuildinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "Name", "BuildingId");
        }

       
        private void FillPageDropDowns()
        {
            //objParkingDal.FillDropDown(DrpOwnerID, ((DataSet)objownerdal.getownerinfobyflatid(drpFlatID.SelectedValue)).Tables[0], "OwnerName1", "OwnerId");
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatDal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");
        }



        public void Bindownerinfo()
        {
            DataSet ds = new DataSet();
            ds = (DataSet)objownerdal.getownerinfobyflatid(drpFlatID.SelectedValue,Convert.ToString(Session["LoginId"]));
            DrpOwnerID.DataSource = ds;
            DrpOwnerID.DataTextField = "OwnerName1";
            DrpOwnerID.DataValueField = "OwnerId";
            DrpOwnerID.DataBind();

            ListItem objLI = new ListItem("--Select owner name--", "0");
            DrpOwnerID.Items.Insert(1, objLI);

        }

        private void CallBack()
        {
            if (Request.Headers["IsAjax"] != null && Convert.ToString(Request.Headers["IsAjax"]) == "true")
            {
                string ID1 = Request.Form["id1"] ?? string.Empty, Opt = Request.Form["opt"] ?? string.Empty,
                       ID2 = Request.Form["id2"] ?? string.Empty, ID3 = Request.Form["id3"] ?? string.Empty,
                       ID4 = Request.Form["id4"] ?? string.Empty;
                Response.Clear();
                Response.ContentType = "Text/xml";
                switch (Opt)
                {
                    case "1": Response.Write(objownerdal.getownerinfobyflatid(ID1.Trim(), Convert.ToString(Session["LoginId"])).GetXml()); break;
                    default: Response.Write(""); break;
                }
                Response.End();
            }
        }

    }
}