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
    public partial class MaintenanceMaster : System.Web.UI.Page
    {
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsParkingMasterDal obparkingDal = new clsParkingMasterDal();
        clsMaintainanceMasterDal objMainDal = new clsMaintainanceMasterDal();
        clsMaintenanceMstrEntity objMaininfo = new clsMaintenanceMstrEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        int MntID, ParentId;
        string output, LastdateOfPayment, Effectivefrom;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            MntID = Convert.ToInt32(Request.QueryString["mntnid"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();
                FillcaltypemasterDropDowns();
                drpCalcMethod.Items.Insert(0, new ListItem("--Select Calculated Method--", "0"));
                drpCalcMethod.SelectedIndex = 0;
                getflatcount();
                hideshow();
                if (MntID != 0)
                {
                    UpdateMaintainancemaster();
                }
            }
            getSalary();    
        }
        private void getSalary()
        {
            DataSet ds = new DataSet();
            ds = objMainDal.GetSalary();
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtSecuritycharge.Text = Txt_LmpSecuritySalary.Text = ds.Tables[0].Rows[0]["TotalGuardsal"].ToString();
                txtSupervisor.Text = Txt_LmpsupervisorSalary.Text = ds.Tables[0].Rows[0]["SupervisorSalary"].ToString();
            }
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>focus();</script>", false);
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
        public void getflatcount()
        {
            objflatinfo.flag = "FlatCount";
            objflatinfo.FlatNumber = Convert.ToString(0);
            objflatinfo.FlatId = 0;
           string SocietyId = Convert.ToString(Session["ID"]) as string;
           

                objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            DataSet ds = new DataSet();
            ds = (DataSet)objflatdal.GetFlatbyFlatno(objflatinfo,Convert.ToString(Session["LoginId"]));

           if (ds.Tables[0].Rows.Count > 0)
           {
               txtTotalNoFlat.InnerText = ds.Tables[0].Rows[0]["count"].ToString();
           }
        }

        public void hideshow()
        {
            if (MntID != 0)
            {
                EffectiveDatespan.Attributes["style"] = "display:block;";
            }
            else 
            {
                EffectiveDatespan.Attributes["style"] = "display:none;";
            }

            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 0)
            { 
                 FlatMonthlyFee.Attributes["style"]="display:none;";
                 FlatMonthlyLumpsumFee.Attributes["style"] = "display:none;";
                 SumTotal.Attributes["style"]="display:none;";
                 PerSquarefeetrate.Attributes["style"]="display:none;";
                 PartialFlatRate.Attributes["style"]="display:none;";
                 MixedApproach.Attributes["style"]="display:none;";
                 date.Attributes["style"]="display:none;";
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 1)
            {
                FlatMonthlyFee.Attributes["style"] = "display:block;";
                SumTotal.Attributes["style"] = "display:block;";
                PerSquarefeetrate.Attributes["style"] = "display:none;";
                PartialFlatRate.Attributes["style"] = "display:none;";
                MixedApproach.Attributes["style"] = "display:none;";
                date.Attributes["style"] = "display:block;";
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 2)
            {
                FlatMonthlyFee.Attributes["style"] = "display:none;";
                SumTotal.Attributes["style"] = "display:none;";
                PerSquarefeetrate.Attributes["style"] = "display:block;";
                PartialFlatRate.Attributes["style"] = "display:none;";
                MixedApproach.Attributes["style"] = "display:none;";
                date.Attributes["style"] = "display:block;";
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 3)
            {
                FlatMonthlyFee.Attributes["style"] = "display:none;";
                SumTotal.Attributes["style"] = "display:none;";
                PerSquarefeetrate.Attributes["style"] = "display:none;";
                PartialFlatRate.Attributes["style"] = "display:block;";
                MixedApproach.Attributes["style"] = "display:none;";
                date.Attributes["style"] = "display:block;";
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 4)
            {
                FlatMonthlyFee.Attributes["style"] = "display:none;";
                SumTotal.Attributes["style"] = "display:none;";
                PerSquarefeetrate.Attributes["style"] = "display:none;";
                PartialFlatRate.Attributes["style"] = "display:none;";
                MixedApproach.Attributes["style"] = "display:block;";
                date.Attributes["style"] = "display:block;";
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 5)
            {
                FlatMonthlyLumpsumFee.Attributes["style"] = "display:block;";
                PerSquarefeetrate.Attributes["style"] = "displayss:none;";
                PartialFlatRate.Attributes["style"] = "display:none;";
                MixedApproach.Attributes["style"] = "display:none;";
                date.Attributes["style"] = "display:block;";
            }
        }



        private void FillcaltypemasterDropDowns()
        {
            objMaininfo.flag = "FillcaltypemasterDropDowns";
            //objMaininfo.LoginId = Session["LoginId"].ToString();
            objMainDal.FillDropDown(drpCalcMethod, ((DataSet)objMainDal.GetMaintainanceInfoByID(objMaininfo)).Tables[0], "CalculationMethod", "CalcMasterID");
        }

        
       
        private void FillPageDropDowns()
        {
          //  obparkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo)).Tables[0], "FlatNumber", "FlatId");
        }

        protected void UpdateMaintainancemaster()
        {
            if (MntID != 0)
            {
                DataSet ds = new DataSet();
                objMaininfo.flag = "getallrecordbyMenid";
                objMaininfo.MaintenanceID = MntID;
                ds = (DataSet)objMainDal.GetMaintainanceinfobyid(objMaininfo);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpCalcMethod.SelectedValue = ds.Tables[0].Rows[0]["CalculationMethodid"].ToString();
                    drpPropertytype.SelectedValue = ds.Tables[0].Rows[0]["PropertyType"].ToString();

                    if (ds.Tables[0].Rows[0]["CalculationMethodid"].ToString() == "1")
                    {
                        SumTotal.Attributes["style"]="display:block";
                        PerSquarefeetrate.Attributes["style"]="display:none";
                        PartialFlatRate.Attributes["style"]="display:none";

                        if (float.Parse(ds.Tables[0].Rows[0]["WaterCharges"].ToString()) == 0)
                        {
                                txtWaterCharges.Text = "0";
                        }
                        else
                        {
                              txtWaterCharges.Text = ds.Tables[0].Rows[0]["WaterCharges"].ToString();
                        }

                        if (float.Parse(ds.Tables[0].Rows[0]["ElectricityCharges"].ToString()) == 0)
                        {
                            txtPowerbill.Text = "0";
                        }
                        else
                        {
                            txtPowerbill.Text = ds.Tables[0].Rows[0]["ElectricityCharges"].ToString();
                        }


                        if (float.Parse(ds.Tables[0].Rows[0]["SecuritySalary"].ToString()) == 0)
                        {
                            txtSecuritycharge.Text = "0";
                        }
                        else
                        {
                            txtSecuritycharge.Text = ds.Tables[0].Rows[0]["SecuritySalary"].ToString();
                        }

                         if (float.Parse(ds.Tables[0].Rows[0]["HousekeepingSalary"].ToString()) == 0)
                        {
                            txtHousekeepingsal.Text = "0";
                        }
                        else
                        {
                            txtHousekeepingsal.Text = ds.Tables[0].Rows[0]["HousekeepingSalary"].ToString();
                        }

                       if (float.Parse(ds.Tables[0].Rows[0]["ManagerSalary"].ToString()) == 0)
                        {
                            txtManagersalary.Text = "0";
                        }
                        else
                        {
                            txtManagersalary.Text = ds.Tables[0].Rows[0]["ManagerSalary"].ToString();
                        }

                        if (float.Parse(ds.Tables[0].Rows[0]["Stationary"].ToString()) == 0)
                        {
                            txtStationary.Text = "0";
                        }
                        else
                        {
                            txtStationary.Text = ds.Tables[0].Rows[0]["Stationary"].ToString();
                        }

                         if (float.Parse(ds.Tables[0].Rows[0]["DgSet"].ToString()) == 0)
                        {
                            txtDgsetexpense.Text = "0";
                        }
                        else
                        {
                            txtDgsetexpense.Text = ds.Tables[0].Rows[0]["DgSet"].ToString();
                        }

                          if (float.Parse(ds.Tables[0].Rows[0]["GymInstructor"].ToString()) == 0)
                        {
                            txtgyminspector.Text = "0";
                        }
                        else
                        {
                            txtgyminspector.Text = ds.Tables[0].Rows[0]["GymInstructor"].ToString();
                        }

                       if (float.Parse(ds.Tables[0].Rows[0]["CommunityHall"].ToString()) == 0)
                        {
                            txtCommunityhall.Text = "0";
                        }
                        else
                        {
                            txtCommunityhall.Text = ds.Tables[0].Rows[0]["CommunityHall"].ToString();
                        }

                        if (float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString()) == 0)
                        {
                            txtRepayment.Text = "0";
                        }
                        else
                        {
                            txtRepayment.Text = ds.Tables[0].Rows[0]["InsuranceCharges"].ToString();
                        }

                        if (float.Parse(ds.Tables[0].Rows[0]["SupervisorSalary"].ToString()) == 0)
                        {
                            txtSupervisor.Text = "0";
                        }
                        else
                        {
                            txtSupervisor.Text = ds.Tables[0].Rows[0]["SupervisorSalary"].ToString();
                        }

                           if (float.Parse(ds.Tables[0].Rows[0]["OtherCharges"].ToString()) == 0)
                        {
                            txtOtherCharges.Text = "0";
                        }
                        else
                        {
                            txtOtherCharges.Text = ds.Tables[0].Rows[0]["OtherCharges"].ToString();
                        }

                            if (float.Parse(ds.Tables[0].Rows[0]["TotalMaintenanceSum"].ToString()) == 0)
                        {
                            txtTotal.Text = "0";
                        }
                        else
                        {
                            txtTotal.Text = ds.Tables[0].Rows[0]["TotalMaintenanceSum"].ToString();
                        }

                            if (float.Parse(ds.Tables[0].Rows[0]["MaintenancePerFlat"].ToString()) == 0)
                        {
                            txtMainpermoth.Text = "0";
                        }
                        else
                        {
                            txtMainpermoth.Text = ds.Tables[0].Rows[0]["MaintenancePerFlat"].ToString();
                        }
                        

                          if (float.Parse(ds.Tables[0].Rows[0]["TenantMaintenance"].ToString()) == 0)
                        {
                            txtTenantMaintenance.Text = "0";
                        }
                        else
                        {
                            txtTenantMaintenance.Text = ds.Tables[0].Rows[0]["TenantMaintenance"].ToString();
                        }
       

                    }
                    else if (ds.Tables[0].Rows[0]["CalculationMethodid"].ToString() == "2")
                    {

                        SumTotal.Attributes["style"] = "display:none";
                        PerSquarefeetrate.Attributes["style"] = "display:block";
                        PartialFlatRate.Attributes["style"] = "display:none";

                              if (float.Parse(ds.Tables[0].Rows[0]["PerSquareFeetRate"].ToString()) == 0)
                        {
                            txtPerSquareFeetRate.Text = "0";
                        }
                        else
                        {
                            txtPerSquareFeetRate.Text = ds.Tables[0].Rows[0]["PerSquareFeetRate"].ToString();
                        }



                    }
                      else if (ds.Tables[0].Rows[0]["CalculationMethodid"].ToString() == "3")
                    {
                        SumTotal.Attributes["style"] = "display:none";
                        PerSquarefeetrate.Attributes["style"] = "display:none";
                        PartialFlatRate.Attributes["style"] = "display:block";
                            if (float.Parse(ds.Tables[0].Rows[0]["FixedSqft"].ToString()) == 0)
                            {
                                txtFixedSqft.Text = "0";
                            }
                            else
                            {
                                txtFixedSqft.Text = ds.Tables[0].Rows[0]["FixedSqft"].ToString();
                            }

                            if (Convert.ToInt32(ds.Tables[0].Rows[0]["FixedRate"].ToString()) == 0)
                            {
                                txtFixedrate.Text = "0";
                            }
                            else
                            {
                                txtFixedrate.Text = ds.Tables[0].Rows[0]["FixedRate"].ToString();
                            }

                            if (Convert.ToInt32(ds.Tables[0].Rows[0]["AdditionalSqft"].ToString()) == 0)
                            {
                                txtAdditionalsqft.Text = "0";
                            }
                            else
                            {
                                txtAdditionalsqft.Text = ds.Tables[0].Rows[0]["AdditionalSqft"].ToString();
                            }
                      
                          if (float.Parse(ds.Tables[0].Rows[0]["AdditionalSqftRate"].ToString()) == 0)
                            {
                                txtAdditionalsqftRate.Text = "0";
                            }
                            else
                            {
                                txtAdditionalsqftRate.Text = ds.Tables[0].Rows[0]["AdditionalSqftRate"].ToString();
                            }
                      }
                      

                    if (Convert.ToString(ds.Tables[0].Rows[0]["EffectiveFromDate"]) == "")
                    {
                        txtEffectiveFromDateM.Text = "";
                    }
                    else
                    {
                        txtEffectiveFromDateM.Text = StrDate(ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString());
                    }

                    if (Convert.ToString(ds.Tables[0].Rows[0]["EffectiveToDate"]) == "")
                    {
                        EffectiveToDate.Text = "";
                    }
                    else
                    {
                        EffectiveToDate.Text = StrDate(ds.Tables[0].Rows[0]["EffectiveToDate"].ToString());
                    }

                    Session["MntID"] = MntID.ToString();
                    btnmensubmit.Text = "Update";
                }
            }
            else
            {
                btnmensubmit.Text = "Submit";
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

        private void clearall()
        {
            drpPropertytype.SelectedValue="";
            drpCalcMethod.SelectedValue = "0";
            txtWaterCharges.Text = "";
            txtPowerbill.Text = "";
            txtSecuritycharge.Text = "";
            txtHousekeepingsal.Text = "";
            txtManagersalary.Text="";
            txtStationary.Text = "";
            txtDgsetexpense.Text = "";
            txtgyminspector.Text = "";
            txtCommunityhall.Text = "";
            txtRepayment.Text="";
            txtOtherCharges.Text="";
            txtSupervisor.Text ="";
            txtRepayment.Text = "";
            txtOtherCharges.Text = "";
            txtTotal.Text = "";
            txtMainpermoth.Text = "";
            txtPerSquareFeetRate.Text = "";
            txtEffectiveFromDateM.Text = "";
            txtFixedSqft.Text = "";
            txtFixedrate.Text = "";
            txtAdditionalsqft.Text="";
            txtAdditionalsqftRate.Text = "";
           EffectiveToDate.Text = "";

            
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
            Session["MntID"] = null;
           
            Response.Redirect("MaintenanceMaster.aspx");
        }

        protected void btnmensubmit_Click1(object sender, EventArgs e)
        {
            if (MntID == 0)
            {
                objMaininfo.MaintenanceID = 0;
            }
            else
            {
                Session["MntID"] = MntID.ToString();
                objMaininfo.MaintenanceID = Convert.ToInt32(Session["MntID"]);
            }
            objMaininfo.SocietyId = Convert.ToInt32(Session["ID"]);
            //code
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 1)
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalcMasterID = Convert.ToInt32(drpCalcMethod.SelectedValue);
                objMaininfo.ElectricityCharges = txtPowerbill.Text ==""? 0: float.Parse(txtPowerbill.Text);
                objMaininfo.WaterCharges = txtWaterCharges.Text ==""? 0:float.Parse(txtWaterCharges.Text);
                objMaininfo.SecuritySalary = txtSecuritycharge.Text ==""? 0:float.Parse(txtSecuritycharge.Text);
                objMaininfo.HousekeepingSalary = txtHousekeepingsal.Text ==""? 0:float.Parse(txtHousekeepingsal.Text);
                objMaininfo.ManagerSalary = txtManagersalary.Text ==""? 0:float.Parse(txtManagersalary.Text);
                objMaininfo.Stationary = txtStationary.Text ==""? 0:float.Parse(txtStationary.Text);
                objMaininfo.DgSet = txtDgsetexpense.Text ==""? 0:float.Parse(txtDgsetexpense.Text);
                objMaininfo.GymInstructor = txtgyminspector.Text ==""? 0:float.Parse(txtgyminspector.Text);
                objMaininfo.CommunityHall = txtCommunityhall.Text ==""? 0:float.Parse(txtCommunityhall.Text);
                objMaininfo.InsuranceCharges = txtRepayment.Text ==""? 0:float.Parse(txtRepayment.Text);
                objMaininfo.Miscellaneous = txtOtherCharges.Text ==""? 0:float.Parse(txtOtherCharges.Text);
                objMaininfo.SupervisorSalary = txtSupervisor.Text ==""? 0:float.Parse(txtSupervisor.Text);
                objMaininfo.TotalMaintenanceSum = txtTotal.Text ==""? 0:float.Parse(txtTotal.Text);
                objMaininfo.MaintenancePerFlat = txtMainpermoth.Text ==""? 0:float.Parse(txtMainpermoth.Text);
                objMaininfo.TenantMaintenance = txtTenantMaintenance.Text == "" ? 0 : float.Parse(txtTenantMaintenance.Text);
                objMaininfo.PerSquareFeetRate = 0;
                objMaininfo.FixedSqft = 0;
                objMaininfo.FixedRate = 0;
                objMaininfo.AdditionalSqft = 0;
                objMaininfo.AdditionalSqftRate = 0;
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["LoginId"]); 
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 2)
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalcMasterID = Convert.ToInt32(drpCalcMethod.SelectedValue);
                objMaininfo.ElectricityCharges = 0;
                objMaininfo.WaterCharges = 0;
                objMaininfo.SecuritySalary = 0;
                objMaininfo.ManagerSalary = 0;
                objMaininfo.Stationary = 0;
                objMaininfo.DgSet = 0;
                objMaininfo.GymInstructor = 0;
                objMaininfo.CommunityHall = 0;
                objMaininfo.InsuranceCharges = 0;
                objMaininfo.Miscellaneous = 0;
                objMaininfo.TotalMaintenanceSum = 0;
                objMaininfo.MaintenancePerFlat = 0;
                objMaininfo.TenantMaintenance = 0;
                objMaininfo.PerSquareFeetRate = float.Parse(txtPerSquareFeetRate.Text);
                objMaininfo.FixedSqft = 0;
                objMaininfo.FixedRate = 0;
                objMaininfo.AdditionalSqft = 0;
                objMaininfo.AdditionalSqftRate = 0;
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["LoginId"]);
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 3)
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalcMasterID = Convert.ToInt32(drpCalcMethod.SelectedValue);
                objMaininfo.ElectricityCharges = 0;
                objMaininfo.WaterCharges = 0;
                objMaininfo.SecuritySalary = 0;
                objMaininfo.ManagerSalary = 0;
                objMaininfo.Stationary = 0;
                objMaininfo.DgSet = 0;
                objMaininfo.GymInstructor = 0;
                objMaininfo.CommunityHall = 0;
                objMaininfo.InsuranceCharges = 0;
                objMaininfo.Miscellaneous = 0;
                objMaininfo.TotalMaintenanceSum = 0;
                objMaininfo.MaintenancePerFlat = 0;
                objMaininfo.TenantMaintenance = 0;
                objMaininfo.PerSquareFeetRate = 0;
                objMaininfo.FixedSqft = Convert.ToInt32(txtFixedSqft.Text);
                objMaininfo.FixedRate = float.Parse(txtFixedSqft.Text);
                objMaininfo.AdditionalSqft = Convert.ToInt32(txtAdditionalsqft.Text);
                objMaininfo.AdditionalSqftRate = float.Parse(txtAdditionalsqftRate.Text);
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["LoginId"]);
            }
            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 4)
            {
                // pending to implement
            }

            if (Convert.ToInt32(drpCalcMethod.SelectedValue) == 5)
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalcMasterID = Convert.ToInt32(drpCalcMethod.SelectedValue);
                objMaininfo.ElectricityCharges = Txt_LmpPowerCharges.Text == "" ? 0 : float.Parse(Txt_LmpPowerCharges.Text);
                objMaininfo.WaterCharges = Txt_LmpWaterCharges.Text == "" ? 0 : float.Parse(Txt_LmpWaterCharges.Text);
                objMaininfo.SecuritySalary = Txt_LmpSecuritySalary.Text == "" ? 0 : float.Parse(Txt_LmpSecuritySalary.Text);
                objMaininfo.HousekeepingSalary = Txt_LmpHouseKeepingSalary.Text == "" ? 0 : float.Parse(Txt_LmpHouseKeepingSalary.Text);
                objMaininfo.ManagerSalary = Txt_LmpManagerSalary.Text == "" ? 0 : float.Parse(Txt_LmpManagerSalary.Text);
                objMaininfo.Stationary = Txt_LmpStationaryExpense.Text == "" ? 0 : float.Parse(Txt_LmpStationaryExpense.Text);
                objMaininfo.DgSet = Txt_LmpDGSet.Text == "" ? 0 : float.Parse(Txt_LmpDGSet.Text);
                objMaininfo.GymInstructor = Txt_LmpGymInstructor.Text == "" ? 0 : float.Parse(Txt_LmpGymInstructor.Text);
                objMaininfo.CommunityHall = Txt_LmpCommunityHall.Text == "" ? 0 : float.Parse(Txt_LmpCommunityHall.Text);
                objMaininfo.InsuranceCharges = Txt_LmpInsurancePremium.Text == "" ? 0 : float.Parse(Txt_LmpInsurancePremium.Text);
                objMaininfo.Miscellaneous = Txt_LmpMiscellaneousExpenses.Text == "" ? 0 : float.Parse(Txt_LmpMiscellaneousExpenses.Text);
                objMaininfo.SupervisorSalary = Txt_LmpsupervisorSalary.Text == "" ? 0 : float.Parse(Txt_LmpsupervisorSalary.Text);
                objMaininfo.MaintenancePerFlat = Txt_LmpOwnerMonthlyAmount.Text == "" ? 0 : float.Parse(Txt_LmpOwnerMonthlyAmount.Text);
                objMaininfo.TenantMaintenance = Txt_LmpTenantExtraMonthlyAmount.Text == "" ? 0 : float.Parse(Txt_LmpTenantExtraMonthlyAmount.Text);
                objMaininfo.PerSquareFeetRate = 0;
                objMaininfo.FixedSqft = 0;
                objMaininfo.FixedRate = 0;
                objMaininfo.AdditionalSqft = 0;
                objMaininfo.AdditionalSqftRate = 0;
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["LoginId"]); 
            }
            output = objMainDal.Insertmaintainance(objMaininfo);
  
            btnmensubmit.Text = "Submit";


            if(Convert.ToInt32(Session["MntID"]) !=0)
                {
                    btnBack.Text = "Back to View Page";
                 }
            clearall();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
            Session["MntID"] = null;
        }

        protected void btnBack_Click1(object sender, EventArgs e)
        {
            Response.Redirect("MaintenanceMasterView.aspx");
        }


    }
}