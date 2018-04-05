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
    public partial class FlatMaster : System.Web.UI.Page
    {

        string output, flatnumber, wingname;
        int FlatId, ParentId;
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsOwnerMasterDal objownerDal = new clsOwnerMasterDal();
        clsOwnerInfo objownerinfo = new clsOwnerInfo();
        clsBuildingEntity objbuildinfo = new clsBuildingEntity();
        clsBuildingMasterDal objbuidDal = new clsBuildingMasterDal();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatDal = new clsFlatMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            FlatId = Convert.ToInt32(Request.QueryString["FlatId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);

            if (!IsPostBack)
            {
                ValidateUserPermissions();
                hideshow();
                FillBuildingDropDowns();
                UpdateFlatMaster();
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

        private void FillBuildingDropDowns()
        {
            string SocietyId = string.Empty;

            if (SocietyId == "") { SocietyId = ""; } else { SocietyId = Convert.ToString(Session["ID"]); }
            objbuildinfo.SocietyIdvar = SocietyId;
            objCommonDAL.FillDropDown(drpBuildingID, ((DataSet)objbuidDal.GetAllBuildingInfo(objbuildinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "Name", "BuildingId", "-- Select Building Name --");
        }
        
        protected void UpdateFlatMaster()
        {
            if (FlatId != 0)
            {
                DataSet ds = new DataSet();

                string flag = "searchflatinfo";
                objflatinfo.FlatId = FlatId;
                string SocietyId = Convert.ToString(Session["ID"]) as string;
           

                    objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
                ds = (DataSet)objflatDal.getflatinfobyflatidFlag(flag, Convert.ToString(FlatId), Convert.ToString(Session["LoginId"]), SocietyId);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpPropertytype.SelectedValue = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                    txtFlatNumber.Attributes.Add("readonly", "readonly");
                    if (ds.Tables[0].Rows[0]["PropertyType"].ToString() == "Commercial")
                    {
                        DivFlattype.Attributes["style"] = "display:none";
                        divCarpetarea.Attributes["style"] = "display:none";
                        Commercial.Attributes["style"] = "display:block";
                        txtLicenseNo.Text = ds.Tables[0].Rows[0]["LicenseNo"].ToString();
                        txtbusinesstype.Text = ds.Tables[0].Rows[0]["BusinessType"].ToString();
                        txtDescription.Text = ds.Tables[0].Rows[0]["ShopDescription"].ToString();
                    }

                    else {
                        Commercial.Attributes["style"] = "display:none";    
                        DivFlattype.Attributes["style"] = "display:block";
                        divCarpetarea.Attributes["style"] = "display:block";
                        txtCarpetarea.Text = ds.Tables[0].Rows[0]["CarpetArea"].ToString();
                        drpFlattype.SelectedValue = ds.Tables[0].Rows[0]["FlatType"].ToString(); 
                    }

                   
                    txtFlatNumber.Text = ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                    txtnumber.Text = ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                    txtTotalArea.Text = ds.Tables[0].Rows[0]["TotalArea"].ToString();
                   
                        
                    //objParkingDal.FillDropDown(drpBuildingID, ((DataSet)objbuidDal.GetAllBuildingInfoByID(Convert.ToInt32(0))).Tables[0], "Name", "BuildingId");
                    drpBuildingID.SelectedValue = ds.Tables[0].Rows[0]["BuildingId"].ToString();            

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["IsShareCertificateGiven"]) == true)
                    {
                        chkcertificate.Checked = true;
                    }
                    else
                    {
                        chkcertificate.Checked = false;
                    }
                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["IsRented"]) == true)
                    {
                        rbtnRented1.Checked = true;
                    }
                    else
                    {
                        rbtnRented2.Checked = true;
                    }
                    Session["_FlatId"] = FlatId.ToString();
                    btnSubmit.Text = "Update";
                }
                else
                {
                    btnSubmit.Text = "Submit";
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Convert.ToString(Session["_FlatId"]) == "")
            {
                objflatinfo.FlatId = 0;
            }
            else
            {
                Session["_FlatId"] = FlatId.ToString();
                objflatinfo.FlatId = FlatId;
            }

            objflatinfo.FlatNumber = txtnumber.Text;
            
            objflatinfo.TotalArea =txtTotalArea.Text==""?0:Convert.ToInt32(txtTotalArea.Text);
      

            if (chkcertificate.Checked == true)
            {
                objflatinfo.IsShareCertificateGiven = 1;
                objflatinfo.ShareCertificateNumber = Txtsharecertificateno.Text.Trim();
            }
            else
            {
                objflatinfo.IsShareCertificateGiven = 0;
                objflatinfo.ShareCertificateNumber = null;
            }

            objflatinfo.PropertyType = drpPropertytype.SelectedValue;

            if (drpPropertytype.SelectedValue == "Commercial")
            {
                objflatinfo.FlatType = "Shop";
                objflatinfo.CarpetArea = 0;
                objflatinfo.LicenseNo = txtLicenseNo.Text;
                objflatinfo.ShopDescription = txtbusinesstype.Text;
                objflatinfo.businesstype = txtDescription.Text;
            }
            else
            {
                objflatinfo.FlatType = drpFlattype.SelectedValue;
                objflatinfo.CarpetArea = txtCarpetarea.Text==""?0:Convert.ToInt32(txtCarpetarea.Text);
                objflatinfo.LicenseNo = "";
                objflatinfo.ShopDescription = "";
                objflatinfo.businesstype = "";
            }

            objflatinfo.BuildingId = Convert.ToInt32(drpBuildingID.SelectedValue);
            if (rbtnRented1.Checked == true)
            {
                objflatinfo.IsRented = 1;
            }
            else
            {
                objflatinfo.IsRented = 0;
            }

            objflatinfo.CreatedBy = Convert.ToString(Session["LoginId"]);
            output = objflatDal.InsertFlatMstr(objflatinfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');windows.location.href = 'Masters/FlatMasterView.aspx?PId=5'</script>", false);
            clearall();
            btnSubmit.Text = "Submit";
        }

        private void clearall()
        {
            txtFlatNumber.Text = "";
            txtCarpetarea.Text = "";
            txtTotalArea.Text = "";
            drpFlattype.SelectedValue="";
            txtnumber.Text = "";
            drpBuildingID.SelectedValue = "";
            chkcertificate.Checked = false;
            rbtnRented2.Checked = true;
            //Session["BuildingId"] = null;
           // Session.Clear();
            txtLicenseNo.Text = "";
            txtDescription.Text = "";
            txtbusinesstype.Text = "";
            drpPropertytype.SelectedValue = "";
        }

        public void hideshow()
        {
            if (drpPropertytype.SelectedValue == "" || drpPropertytype.SelectedValue == "Residential") 
            {
                Commercial.Attributes["style"] = "display:none;";

                lblTotalArea.InnerText = "Built Up Area";
                //SpanTotalArea.InnerText = "Enter Built Up Area";

                lblFlatNo.InnerText = "Flat Number";
               // SpanFlatNo.InnerText = "Enter Flat Number";

                lblFlatRented.InnerText = "Flat Rented Information";

                lblFlatType.InnerText = "Flat Type";
                //SpanFlatType.InnerText = "Enter Flat Type";

                //lblCarpetArea.InnerText = "Flat Carpet Area";
               // SpanCarpetArea.InnerText = "Enter Flat Carpet Area";
            }
            else 
            {
                Commercial.Attributes["style"] = "display:block;";

                lblTotalArea.InnerText = "Shop Area";
                //SpanTotalArea.InnerText = "Enter Shop Area";

                lblFlatNo.InnerText = "Shop Number";
                //SpanFlatNo.InnerText = "Enter Shop Number";

                lblFlatRented.InnerText = "Shop Rented Information";

                lblFlatType.InnerText = "Shop Type";
                //SpanFlatType.InnerText = "Enter Shop Type";

                //lblCarpetArea.InnerText = "Shop Carpet Area";
               // SpanCarpetArea.InnerText = "Enter Shop Carpet Area";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("FlatMasterView.aspx");
        }

        protected void chkcertificate_CheckedChanged(object sender, EventArgs e)
        {
            Txtsharecertificateno.Visible = true;
        }
                      
    }

}
