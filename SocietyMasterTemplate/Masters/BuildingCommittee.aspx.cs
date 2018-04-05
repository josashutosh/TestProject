using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyDAL;
using System.Data;
using SocietyEntity;

namespace EsquareMasterTemplate.Masters
{
    public partial class BuildingCommitte : System.Web.UI.Page
    {
        int committeeID, ParentId;
        string output, Effectivefrom;
      
        clsOwnerMasterDal objownerdal = new clsOwnerMasterDal();
        clsOwnerInfo objownerinfo = new clsOwnerInfo();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsParkingMasterDal obparkingDal = new clsParkingMasterDal();
        clsCommitteeMemberEntity objComminfo = new clsCommitteeMemberEntity();
        clsCommitteeMemberDal objCommDal = new clsCommitteeMemberDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            CallBack();
            committeeID = Convert.ToInt32(Request.QueryString["CommiteeMemberId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {

                ValidateUserPermissions();
                      // Bindownerinfo();
                FillPageDropDowns();
                UpdateBuildingCommmittee();
              
            }
        }
        private void ValidateUserPermissions()
        {
            string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
            DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, ParentId);
            if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
            {
                Response.Redirect("../error-page/Success-page.aspx");
            }
            else
            {
                //To do: inpage rolewise retrictions if required.
            }
        }
        protected void UpdateBuildingCommmittee()
        {
            if (committeeID != 0)
            {
                DataSet ds = new DataSet();

                objComminfo.CommiteeMemberId = committeeID;
                objComminfo.flag = "GetCommitteeInfobyid";
                ds = (DataSet)objCommDal.GetCommitteeInfoid(objComminfo);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpFlatID.SelectedValue = ds.Tables[0].Rows[0]["FlatId"].ToString();
                    objflatinfo.FlatId = Convert.ToInt32(drpFlatID.SelectedValue);
                  //  drpFlatID.SelectedItem.Text = Convert.ToString(ds.Tables[0].Rows[0]["FlatNumber"]);
                    obparkingDal.FillDropDown(DrpOwnerID, ((DataSet)objownerdal.getownerinfobyflatid(drpFlatID.SelectedValue, Convert.ToString(Session["LoginId"]))).Tables[0], "OwnerName1", "OwnerId");
                    DrpOwnerID.SelectedValue = ds.Tables[0].Rows[0]["OwnerId"].ToString();

                    drpDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation"].ToString();
                  //  txtEffectivefrom.Text = ds.Tables[0].Rows[0]["OfficeAddress"].ToString();


                    if (ds.Tables[0].Rows[0]["EffectiveFrom"].ToString() == null)
                    {
                        txtEffectivefrom.Text = ds.Tables[0].Rows[0]["EffectiveFrom"].ToString();
                    }
                    else
                    {

                        Effectivefrom = StrDate(ds.Tables[0].Rows[0]["EffectiveFrom"].ToString());
                        txtEffectivefrom.Text = Effectivefrom;

                    }

                    Session["committeeID"] = committeeID.ToString();
                    btnmemsubmit.Text = "Update";
                }

            }
            else
            {
                btnmemsubmit.Text = "Submit";
            }
        }
        private string StrDate(string Date)
        {
            if (Date != "")
            {
                string[] Date1 = Date.Split('/');


                // Date = Date1[2] + "/" + Date1[1] + "/" + Date1[0];

                string[] Date2 = Date1[2].Split(' ');

                Date = Date1[1] + "/" + Date1[0] + "/" + Date2[0];
                return (Date);
            }
            else
            {
                return null;
            }
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
        private void FillPageDropDowns()
        {
            obparkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");
        }

      
        protected void btnmemsubmit_Click(object sender, EventArgs e)
        {

            if (committeeID == 0)
            {
                objComminfo.CommiteeMemberId = 0;
            }
            else
            {
                Session["committeeID"] = committeeID.ToString();
                objComminfo.CommiteeMemberId = Convert.ToInt32(Session["committeeID"]);
            }

            objComminfo.FlatId = Convert.ToInt32(drpFlatID.SelectedValue);
            objComminfo.OwnerId = Convert.ToInt32(Request.Form[DrpOwnerID.UniqueID]);
            objComminfo.Designation = Convert.ToString(drpDesignation.SelectedValue);

            objComminfo.EffectiveFrom = txtEffectivefrom.Text;
            objComminfo.CreatedBy = Convert.ToString(Session["LoginId"]);
            Session["committeeID"] = null;
            output = objCommDal.Insertmaintainance(objComminfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
            clearall();
        
        }

        private void clearall()
        {
            drpFlatID.Items.Clear();
            DrpOwnerID.Items.Clear(); 
            DrpOwnerID.SelectedValue ="0";
            drpDesignation.SelectedValue = "0";
            txtEffectivefrom.Text = "";
        }


        protected void btnsub_Click1(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Member Inserted....');</script>", false);
        }

        protected void btnbck_Click(object sender, EventArgs e)
        {
            Session["committeeID"] = null;
           
            Server.Transfer("BuildingCommitteeMasterView.aspx");
        }
    }
}