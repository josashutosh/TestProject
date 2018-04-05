using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using SocietyEntity;
using Newtonsoft.Json;

namespace EsquareMasterTemplate.Masters
{
    public partial class OwnerMaster : System.Web.UI.Page
    {

        int OwnerId, ParentId;
        string output, residence, DOB, effectivefrm;
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsOwnerInfo objOwnerEntity = new clsOwnerInfo();
        clsOwnerMasterDal objOwnerDal = new clsOwnerMasterDal();
        protected void Page_Load(object sender, EventArgs e)
        {
            OwnerId = Convert.ToInt32(Request.QueryString["OwnerId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();
                UpdateOwnermaster();
                astempadrress();
                FillDropDowns();
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
        }

        private void FillDropDowns()
        {
            objCommonDAL.FillDropDown(ddlSocietyName, ((DataSet)objCommonDAL.GetSocietyList(Convert.ToString(Session["LoginId"]))).Tables[0], "SocietyName", "SocietyId", "- Select Society Name -");
        }

        [WebMethod(EnableSession = true)]
        public static string GetBuildingList(int societyId)
        {
            clsBuildingEntity objBuildinginfo = new clsBuildingEntity();
            clsBuildingMasterDal Objbuildingmasterdal = new clsBuildingMasterDal();
            objBuildinginfo.SocietyId = societyId;
            DataSet ds = (DataSet)Objbuildingmasterdal.GetAllBuildingInfo(objBuildinginfo, Convert.ToString(HttpContext.Current.Session["LoginId"]));
            List<clsBuildingList> M = new List<clsBuildingList>();
            if (ds.Tables.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    clsBuildingList BL = new clsBuildingList();
                    BL.BuildingId = Convert.ToInt32(ds.Tables[0].Rows[i]["BuildingId"].ToString());
                    BL.Name = ds.Tables[0].Rows[i]["Name"].ToString();
                    M.Add(BL);
                }
            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }

            return JsonConvert.SerializeObject(M);
        }

        [WebMethod(EnableSession = true)]
        public static string GetFlatList(int societyId)
        {
    
            clsFlatMasterDal flatmasterdal= new clsFlatMasterDal();
                
            DataSet ds = (DataSet)flatmasterdal.GetAllFlatInfo(societyId);

            List<clsFlatList> M = new List<clsFlatList>();
            if (ds.Tables.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    clsFlatList BL = new clsFlatList();
                    BL.FlatId = Convert.ToInt32(ds.Tables[0].Rows[i]["FlatId"].ToString());
                    BL.Name = ds.Tables[0].Rows[i]["FlatNumber"].ToString();
                    M.Add(BL);
                }
            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }

            return JsonConvert.SerializeObject(M);
        }

        public class clsBuildingList
        {
            public int BuildingId { get; set; }
            public string Name { get; set; }
        }
        public class clsFlatList
        {
            public int FlatId { get; set; }
            public string Name { get; set; }
        }
        public void astempadrress()
        {
            if (chkconfirm.Checked == true)
            {
                txttempaddress.Attributes["style"] = "display:none";
            }
            else
            {
                txttempaddress.Attributes["style"] = "display:block";
                txttempaddress.Attributes["style"] = "margin-left:0px;";
            }
        }

        protected void UpdateOwnermaster()
        {
            clsBuildingEntity objBuildinginfo = new clsBuildingEntity();
            clsBuildingMasterDal Objbuildingmasterdal = new clsBuildingMasterDal();
            if (OwnerId != 0)
            {
                DataSet ds = new DataSet();

                objOwnerEntity.ownerId = OwnerId;

                ds = (DataSet)objOwnerDal.GetownerInfo(objOwnerEntity, Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtOwnername.Text = ds.Tables[0].Rows[0]["OwnerName"].ToString();
                    txtcontactno.Text = ds.Tables[0].Rows[0]["ContactNumber"].ToString();
                    txtOccupatn.Text = ds.Tables[0].Rows[0]["Occupation"].ToString();
                    txtperAddress.Text = ds.Tables[0].Rows[0]["permanentAddress"].ToString();
                    string tempAdd = ds.Tables[0].Rows[0]["TempAddress"].ToString();
                    if (txtperAddress.Text == tempAdd)
                    {
                        tempaddress.Attributes["style"] = "display:none";
                        chkconfirm.Checked = true;
                    }
                    else
                    {
                        tempaddress.Attributes["style"] = "display:block";
                        chkconfirm.Checked = false;
                        txttempaddress.Text = ds.Tables[0].Rows[0]["TempAddress"].ToString();
                    }

                    txtOffaddr.Text = ds.Tables[0].Rows[0]["OfficeAddress"].ToString();
                    txtOfficeno.Text = ds.Tables[0].Rows[0]["OfficeContactNo"].ToString();
                    txtPanno.Text = ds.Tables[0].Rows[0]["PAN"].ToString();
                    txtAdharno.Text = ds.Tables[0].Rows[0]["AdhaarCard"].ToString();

                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsCommiteeMember"]) == 1)
                    {
                        chkCommitemem.Checked = true;
                        effectivefrom.Attributes["style"] = "display:block";
                        designation.Attributes["style"] = "display:block";
                        if (ds.Tables[0].Rows[0]["Designation"].ToString() == "Chairman")
                        {
                            drpDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation"].ToString();
                        }
                        if (ds.Tables[0].Rows[0]["Designation"].ToString() == "Secretary")
                        {
                            drpDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation"].ToString();
                        }
                        if (ds.Tables[0].Rows[0]["Designation"].ToString() == "Treasurer")
                        {
                            drpDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation"].ToString();
                        }
                        if (ds.Tables[0].Rows[0]["Designation"].ToString() == "Member")
                        {
                            drpDesignation.SelectedValue = ds.Tables[0].Rows[0]["Designation"].ToString();
                        }

                        if (ds.Tables[0].Rows[0]["Effectivefrom"].ToString() == null)
                        {
                            txtEffectvfrm.Text = ds.Tables[0].Rows[0]["Effectivefrom"].ToString();
                        }
                        else
                        {
                            effectivefrm = StrDate(ds.Tables[0].Rows[0]["Effectivefrom"].ToString());
                            txtEffectvfrm.Text = effectivefrm;
                        }
                    }
                    else
                    {
                        chkCommitemem.Checked = false;
                        effectivefrom.Attributes["style"] = "display:none";
                        designation.Attributes["style"] = "display:none";
                    }

                    if (ds.Tables[0].Rows[0]["ResidingFrom"].ToString() == null)
                    {
                        txtresidence.Text = ds.Tables[0].Rows[0]["ResidingFrom"].ToString();
                    }
                    else
                    {
                        residence = StrDate(ds.Tables[0].Rows[0]["ResidingFrom"].ToString());
                        txtresidence.Text = residence;
                    }

                    if (ds.Tables[0].Rows[0]["DOB"].ToString() == null)
                    {
                        txtDOB.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                    }
                    else
                    {
                        DOB = StrDate(ds.Tables[0].Rows[0]["DOB"].ToString());
                        txtDOB.Text = DOB;
                    }
                    txtOffaddr.Text = Convert.ToString(ds.Tables[0].Rows[0]["OfficeAddress"]);
                    ddlSocietyName.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SocietyId"]);
                    objBuildinginfo.SocietyId = Convert.ToInt32(ds.Tables[0].Rows[0]["SocietyId"]);
                   // objCommonDAL.FillDropDown(drpBuildingID, ((DataSet)Objbuildingmasterdal.GetAllBuildingInfo(objBuildinginfo, Convert.ToString(HttpContext.Current.Session["LoginId"]))).Tables[0], "Name", "BuildingId", "- Select Building Name -");
                   //drpBuildingID.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BuildingId"]);
                    lblFlatnumber.Text = Convert.ToString(ds.Tables[0].Rows[0]["FlatId"]);
                    lblFlatnumber.Visible = true;
                    Session["_ownerId"] = OwnerId.ToString();
                    btnSubmit.Text = "Update";
                }

            }
            else
            {
                btnSubmit.Text = "Submit";
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (OwnerId == 0)
            {
                objOwnerEntity.ownerId = 0;
            }
            else
            {
                Session["_ownerId"] = OwnerId.ToString();
                objOwnerEntity.ownerId = Convert.ToInt32(Session["_ownerId"]);
            }

            objOwnerEntity.ownername = txtOwnername.Text;

            if (txtcontactno.Text == "" || txtcontactno.Text == null)
            {
                objOwnerEntity.ContactNumber = "0";
            }
            else
            {
                objOwnerEntity.ContactNumber = txtcontactno.Text;
            }

            objOwnerEntity.Occupation = txtOccupatn.Text;

            objOwnerEntity.perAddress = txtperAddress.Text;

            if (chkconfirm.Checked == true)
            {
                objOwnerEntity.TempAddress = txtperAddress.Text;
            }
            else
            {
                objOwnerEntity.TempAddress = txttempaddress.Text;
            }

            objOwnerEntity.OfficeAddress = txtOffaddr.Text;

            if (txtOfficeno.Text == "" || txtOfficeno.Text == null)
            {
                objOwnerEntity.OfficeContactNo = 0;
            }
            else
            {
                objOwnerEntity.OfficeContactNo = Convert.ToInt64(txtOfficeno.Text);
            }

            objOwnerEntity.PAN = txtPanno.Text;
            objOwnerEntity.AdhaarCard = txtAdharno.Text;

            if (chkCommitemem.Checked == true)
            {
                objOwnerEntity.IsCommiteeMember = 1;
                objOwnerEntity.Designation = drpDesignation.SelectedValue;
                objOwnerEntity.Effectivefrom = txtEffectvfrm.Text;
            }
            else
            {
                objOwnerEntity.IsCommiteeMember = 0;
                objOwnerEntity.Designation = "";
                objOwnerEntity.Effectivefrom = "";
            }

            objOwnerEntity.ResidingFrom = txtresidence.Text;
            objOwnerEntity.DOB = txtDOB.Text;

            if (Convert.ToString(Session["username"]) == null)
            {
                objOwnerEntity.CreatedBy = Convert.ToString(Session["LoginId"]);
            }
            else
            {
                objOwnerEntity.CreatedBy = Convert.ToString(Session["LoginId"]);
            }

            if (OwnerId != 0)
            {
                objOwnerEntity.Flatid = lblFlatnumber.Text;
            }
            else 
            {
                objOwnerEntity.Flatid = Convert.ToString(hdnAllID.Value).Substring(0, hdnAllID.Value.Length - 1);
            }
                   
            if (objOwnerEntity.Flatid != "") 
            { 
                hdnAllID.Value = ""; 
            }
            // objEmpinfo.CreatedBy = Session["UserName"].ToString();
            output = objOwnerDal.InsertOwnerMaster(objOwnerEntity);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
            Session["_ownerId"] = null;
            btnSubmit.Text = "Submit";
            lblFlatnumber.Visible = false;
            clearall();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session["_ownerId"] = null;
            Response.Redirect("OwnerMasterView.aspx");
        }

        public void clearall()
        {
            txtperAddress.Text = "";
            txtOwnername.Text = "";
            txtcontactno.Text = "";
            txtOccupatn.Text = "";
            txtOffaddr.Text = "";
            txtOfficeno.Text = "";
            txtPanno.Text = "";
            txtperAddress.Text = "";
            txttempaddress.Text = "";
            chkconfirm.Checked = false;
            txtAdharno.Text = "";
            chkCommitemem.Checked = false;
            txtresidence.Text = "";
            txtDOB.Text = "";
            drpDesignation.SelectedValue = "0";
          //  drpBuildingID.SelectedValue = "";
            txtEffectvfrm.Text = "";
            ddlSocietyName.SelectedValue = "";
            
        }
    }
}