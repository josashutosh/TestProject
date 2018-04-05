using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using Newtonsoft;
using System.Web.Services;
using EsquareMasterTemplate;
using Newtonsoft.Json;
using System.Web.UI.HtmlControls;
using SocietyEntity;
using System.Text;
using EsquareMasterTemplate.Common;

namespace EsquareMasterTemplate.Dashboards
{
    public partial class SocietyMemberDashboard : System.Web.UI.Page
    {
        int CurrentPage;
        clsSocietyMemberDashboardDal objSocMemDashDal =new clsSocietyMemberDashboardDal();
        clsSocietyMemberDashboardEntity objSocMemDashEntity = new clsSocietyMemberDashboardEntity();
        EncryptDecrypt encdec = new EncryptDecrypt();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsCommitteeMemberDal objcommiDal = new clsCommitteeMemberDal();
        clsCommitteeMemberEntity objcommiinfo = new clsCommitteeMemberEntity();
        int SocietyId;
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!IsPostBack)
            {
               // Response.Write(Convert.ToString(Session["RedirectUrl"]));
               // Response.Write(Convert.ToString(Session["Url"]));
               // Response.Write(Convert.ToString(Session["path"]));
                bindDashboard();
                committee();
            }
        }

        private void ValidateUserPermissions()
        {
            //string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
            //DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url,0);
            //if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
            //{
            //    Response.Redirect("../error-page/Success-page.aspx");
            //}
            //else
            //{
            //    //To do: inpage rolewise retrictions if required.
            //}

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
                    // ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }

        public void committee()
        {
            DataSet ds = new DataSet();
            objcommiinfo.flag = "getallrecord";
            objcommiinfo.FlatId = Convert.ToInt32(Session["FlatId"].ToString());
            ds = (DataSet)objcommiDal.GetcommitteeInfo(objcommiinfo);
            committeeMaster.DataSource = ds;
            committeeMaster.DataBind();
        }

        public void bindDashboard()
        {
            DataSet ds = new DataSet();
            objSocMemDashEntity.OwnerID = Convert.ToInt32(Session["ID"]);
            objSocMemDashEntity.LoginType = Convert.ToString(Session["LoginType"]);
            objSocMemDashEntity.FlatID = Convert.ToInt32(Session["FlatId"]);

            ds = (DataSet)objSocMemDashDal.GetSocietyMemDashDetail(objSocMemDashEntity);

            
            if (Convert.ToString(Session["IsRented"]) == "")
            {
                Session["IsRented"] = ds.Tables[1].Rows[0]["IsRented"] == "Yes" ? 1 : 0;
            }

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblCurrentMaintenance.Text = "Rs. "+ ds.Tables[0].Rows[0]["AMOUNT"].ToString();
                }
                else
                {
                    lblCurrentMaintenance.Text = "-";
                }

                if (ds.Tables[1].Rows.Count > 0)
                {
                    lblIsRented.Text = ds.Tables[1].Rows[0]["IsRented"].ToString();
                }

                if (ds.Tables[2].Rows.Count > 0)
                {
                    lblAccountDetail.Text = ds.Tables[2].Rows[0]["AccountDetails"].ToString();
                }

                if (ds.Tables[3].Rows.Count > 0)
                {
                    lblHelpDesk.Text = ds.Tables[3].Rows[0]["SocietyHelpdesk"].ToString();
                }

                if (ds.Tables[4].Rows.Count > 0)
                {
                    ProfileView.DataSource = ds.Tables[4];
                    ProfileView.DataBind();
                    if (ds.Tables[4].Rows.Count > 1)
                    {
                        foreach (DataRow row in ds.Tables[4].Rows)
                        {
                            if (lblFlatNumber.Text =="" ||lblBuildingNumber.Text=="")
                            {
                                lblFlatNumber.Text = Convert.ToString(row["FlatNumber"]);
                              
                                lblBuildingNumber.Text = Convert.ToString(row["BuildingName"]);
                            }
                            else
                            {
                                lblFlatNumber.Text = lblFlatNumber.Text + ", " + Convert.ToString(row["FlatNumber"]);
                                if (lblBuildingNumber.Text != Convert.ToString(row["BuildingName"]))
                                {
                                    lblBuildingNumber.Text = lblBuildingNumber.Text + ", " + Convert.ToString(row["BuildingName"]);
                                }
                            }
                        }
                    }
                    else
                    {
                        lblFlatNumber.Text = ds.Tables[4].Rows[0]["FlatNumber"].ToString();
                        lblBuildingNumber.Text = ds.Tables[4].Rows[0]["BuildingName"].ToString();
                    }
                    lblFullName.Text = ds.Tables[4].Rows[0]["OwnerName"].ToString();
                    if (Convert.ToString(ds.Tables[4].Rows[0]["LoginType"]) == "SocietyMember")
                    {
                        lblLoginType.Text = "Society Member";
                    }

                    if (System.IO.File.Exists(Server.MapPath("../Images/Profile/" + ds.Tables[4].Rows[0]["ImagePath1"].ToString())) == false)
                    {
                        imgProfile.ImageUrl = imgProfile.ResolveUrl("../Images/Profile/No-Image.png");
                    }
                    else
                    {
                        imgProfile.ImageUrl = imgProfile.ResolveUrl("../Images/Profile/" + ds.Tables[4].Rows[0]["ImagePath1"].ToString());
                    }
                }
                if (ds.Tables[5].Rows.Count > 0)
                {
                    MaintenanceView.DataSource = ds.Tables[5];
                    MaintenanceView.DataBind();
                }
                else
                {
                    MaintenanceView.DataSource = ds.Tables[5];
                    MaintenanceView.DataBind();
                }

                if (ds.Tables[6].Rows.Count > 0)
                {
                    EventMaster.DataSource = ds.Tables[6];
                    EventMaster.DataBind();
                }
                else
                {
                    EventMaster.DataSource = ds.Tables[6];
                    EventMaster.DataBind();
                }
            }
            else 
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found');');</script>", false);
            }
        }

        protected void committeeMaster_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // If the Repeater contains no data.
            if (committeeMaster.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    HtmlGenericControl dvNoRec = e.Item.FindControl("FootercommitteeMaster") as HtmlGenericControl;
                    if (dvNoRec != null)
                    {
                        dvNoRec.Visible = true;
                    }
                }
            }
        }
         
        protected void GenerateReceipt(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btnPaynow = sender as Button;
            ListViewItem item = btnPaynow.NamingContainer as ListViewItem;
            HiddenField myMainId = btnPaynow.NamingContainer.FindControl("hdnMainIdhistory") as HiddenField;
            HiddenField myPropertyType = btnPaynow.NamingContainer.FindControl("hdnPropertyType") as HiddenField;
            SocietyId = int.Parse(Session["SID"].ToString());
            try
            {
                string PropertyType = HttpUtility.UrlEncode(encdec.Encrypt(myPropertyType.Value));
                string MainId = HttpUtility.UrlEncode(encdec.Encrypt(myMainId.Value));
                string SocId = HttpUtility.UrlEncode(encdec.Encrypt(Convert.ToString(SocietyId)));
                string opt = HttpUtility.UrlEncode(encdec.Encrypt("ViewBill"));
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('../Reports/GenerateReceipt.aspx?Opt=" + opt + "&P=" + PropertyType + "&MId=" + MainId + "&SId=" + SocId + "');", true);
            } 
            catch (Exception ex)
            {
               // Response.Write(ex.Message.ToString());
            }
        }

        protected void hyHistoryPaynow(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btnPaynow = sender as Button;
            ListViewItem item = btnPaynow.NamingContainer as ListViewItem;
            //    HiddenField hfMainId = item.FindControl("hdnMainId") as HiddenField;
            HiddenField myMainId = btnPaynow.NamingContainer.FindControl("hdnMainIdhistory") as HiddenField;
            //  HiddenField hfPropertyType = item.FindControl("hdnMainId") as HiddenField;
            HiddenField myPropertyType = btnPaynow.NamingContainer.FindControl("hdnPropertyType") as HiddenField;
            SocietyId = int.Parse(Session["SID"].ToString());

            string PropertyType = HttpUtility.UrlEncode(encdec.Encrypt(myPropertyType.Value));
            string MainId = HttpUtility.UrlEncode(encdec.Encrypt(myMainId.Value));
            string SocId = HttpUtility.UrlEncode(encdec.Encrypt(Convert.ToString(SocietyId)));
            string opt = HttpUtility.UrlEncode(encdec.Encrypt("ViewBill"));
            if (btnPaynow.Text == "Pay Now")
            {
                //Response.Redirect("~/Finance/RechargeWallet.Aspx?Opt=H&Mid=" + myMainId.Value + "&Ptype=" + myPropertyType.Value);

                ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('../Finance/RechargeWallet.Aspx?Opt=H&Mid=" + myMainId.Value + "&Ptype=" + myPropertyType.Value + "');", true);

            }
            else if (btnPaynow.Text == "Receipt")
            {
                try
                {
                    //Response.Redirect("~/Reports/ReportsHome.aspx?P=" + myPropertyType.Value + "&MId=" + myMainId.Value + "&Flag=H&PrimId=SD&SId=" + SocietyId);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('../Reports/GenerateReceipt.aspx?Opt=" + opt + "&P=" + PropertyType + "&MId=" + MainId + "&SId=" + SocId + "');", true);
                }
                catch (Exception ex)
                {
                    Response.Write("<span style='color:red'>" + ex.Message + "</span>");
                }
            }
        }

        protected void MaintenanceView_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // If the Repeater contains no data.

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //dynamic person = e.Item.DataItem as dynamic;
                DataRowView row = e.Item.DataItem as DataRowView;
                string Status = row["Status"].ToString();
                //  int MainID = Convert.ToInt32(row["MaintenanceId"].ToString());
                // string PropertyType = Convert.ToString(row["PropertyType"]);
                //string Payurl = "../Finance/RechargeWallet.aspx?Mid=" + MainID + "?Ptype=" + PropertyType;
                //  string receipt = "../Finance/RechargeWallet.aspx?Mid=" + MainID + "?Ptype=" + PropertyType;

                if (Status == "UnPaid")
                {

                    ((Button)e.Item.FindControl("hyHistoryPaynow")).Text = "Pay Now";


                }
                else if (Status == "Paid")
                {
                    ((Button)e.Item.FindControl("hyHistoryPaynow")).Text = "Receipt";
                }

                // string name = person.Name;
                //  int age = person.Age;
            }


            if (MaintenanceView.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    HtmlGenericControl dvNoRec = e.Item.FindControl("FooterMaintenanceHistory") as HtmlGenericControl;
                    if (dvNoRec != null)
                    {
                        dvNoRec.Visible = true;

                    }
                }
            }


        }

        protected void hyHistoryViewbill(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btnPaynow = sender as Button;
            ListViewItem item = btnPaynow.NamingContainer as ListViewItem;
            HiddenField myMainId = btnPaynow.NamingContainer.FindControl("hdnMainIdhistory") as HiddenField;
            HiddenField myPropertyType = btnPaynow.NamingContainer.FindControl("hdnPropertyType") as HiddenField;
            SocietyId = int.Parse(Session["SID"].ToString());
            try
            {
                string PropertyType = HttpUtility.UrlEncode(encdec.Encrypt(myPropertyType.Value));
                string MainId = HttpUtility.UrlEncode(encdec.Encrypt(myMainId.Value));
                string SocId = HttpUtility.UrlEncode(encdec.Encrypt(Convert.ToString(SocietyId)));
                string opt = HttpUtility.UrlEncode(encdec.Encrypt("ViewBill"));
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('../Reports/MonthlyBillReceipt.aspx?Opt=" + opt + "&P=" + PropertyType + "&MId=" + MainId + "&SId=" + SocId + "');", true);
            }
            catch (Exception ex)
            {
               // Response.Write(ex.Message.ToString());
            }
            
        }

        protected void EventMaster_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // If the Repeater contains no data.
            if (EventMaster.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    HtmlGenericControl dvNoRec = e.Item.FindControl("FooterEventMaster") as HtmlGenericControl;
                    if (dvNoRec != null)
                    {
                        dvNoRec.Visible = true;
                    }
                }
            }
        }

        protected void ProfileView_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // If the Repeater contains no data.
            if (ProfileView.Items.Count < 1)
            {
                if (e.Item.ItemType == ListItemType.Footer)
                {
                    HtmlGenericControl dvNoRec = e.Item.FindControl("FooterProfileView") as HtmlGenericControl;
                    if (dvNoRec != null)
                    {
                        dvNoRec.Visible = true;
                    }
                }
            }
        }

        public class maintenance 
        {
          public int MaintenanceID { get; set; }
          public string PropertyType { get; set; }
          public int CalculationMethodId { get; set; }
          public float PropertyTaxes { get; set; }
          public float ElectricityCharges { get; set; }
          public float WaterCharges { get; set; }
          public float SecuritySalary { get; set; }
          public float HousekeepingSalary { get; set; }
            public float ManagerSalary { get; set; }
            public float Stationary { get; set; }
            public float DgSet { get; set; }
            public float GymInstructor { get; set; }
            public float CommunityHall { get; set; }
            public float InsuranceCharges { get; set; }
            public float Miscellaneous { get; set; }
            public float SupervisorSalary { get; set; }
            public float MaintenancePerFlat { get; set; }
            public float TenantMaintenance { get; set; }
            public float PerSquareFeetRate { get; set; }
            public int FixedSqft { get; set; }
            public float FixedRate { get; set; }
            public int AdditionalSqft { get; set; }
            public float AdditionalSqftRate { get; set; }
            public string EffectiveFromDate { get; set; }
            public string EffectiveToDate { get; set; }

          public float RepairsMaintenanceFund { get; set; }
          public float LiftCharges { get; set; }
          public float SinkingFund { get; set; }
          public float ServiceCharges { get; set; }
          public float CarParkingCharges { get; set; }
          public float InterestonDefaultedCharges { get; set; }
          public float RepaymentInstmntLoanInterest { get; set; }
          public float NonOccupancyCharges { get; set; }         
          public float LeaseRent { get; set; }
          public float NonAgriculturalTax { get; set; }
          public float OtherCharges { get; set; }
          public float TotalMaintenanceSum { get; set; }
       
          public int TotalArea { get; set; }
          public int FlatCount { get; set; }
          public string IsRented { get; set; }
          public string CalculationMethod { get; set; }
           
        }

        [WebMethod(EnableSession=true)]
        public static string GetCurrentmaintenanceInfo(string Id)
        {
             clsSocietyMemberDashboardDal objSocMemDashDal =new clsSocietyMemberDashboardDal();
           clsSocietyMemberDashboardEntity objSocMemDashEntity = new clsSocietyMemberDashboardEntity();
            clsMaintenanceMstrEntity objMaininfo = new clsMaintenanceMstrEntity();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            objSocMemDashEntity.OwnerID = Convert.ToInt32(HttpContext.Current.Session["ID"]);
            objSocMemDashEntity.LoginType = HttpContext.Current.Session["LoginType"].ToString();
            objSocMemDashEntity.FlatID = Convert.ToInt32(HttpContext.Current.Session["FlatId"].ToString());
            objSocMemDashEntity.MaintenanceId = Convert.ToInt32(Id);
         
            ds = (DataSet)objSocMemDashDal.GetMaintenanceDetail(objSocMemDashEntity);
            List<maintenance> M = new List<maintenance>();
             if (ds.Tables.Count > 0)
            {
               
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 1)
                    {
                           maintenance MF = new maintenance();
                            
                            for(int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                MF.MaintenanceID=Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                                MF.PropertyType=ds.Tables[0].Rows[0]["PropertyType"].ToString();
                                MF.CalculationMethodId=Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                                MF.PropertyTaxes=float.Parse(ds.Tables[0].Rows[0]["PropertyTaxes"].ToString());
                                MF.WaterCharges=float.Parse(ds.Tables[0].Rows[0]["WaterCharges"].ToString());
                                MF.IsRented = ds.Tables[0].Rows[0]["IsRented"].ToString();
                                MF.SecuritySalary = float.Parse(ds.Tables[0].Rows[0]["SecuritySalary"].ToString());
                                MF.HousekeepingSalary = float.Parse(ds.Tables[0].Rows[0]["HousekeepingSalary"].ToString());
                                MF.ManagerSalary = float.Parse(ds.Tables[0].Rows[0]["ManagerSalary"].ToString());
                                MF.Stationary = float.Parse(ds.Tables[0].Rows[0]["Stationary"].ToString());
                                MF.DgSet = float.Parse(ds.Tables[0].Rows[0]["DgSet"].ToString());
                                MF.GymInstructor = float.Parse(ds.Tables[0].Rows[0]["GymInstructor"].ToString());
                                MF.CommunityHall = float.Parse(ds.Tables[0].Rows[0]["CommunityHall"].ToString());
                                MF.InsuranceCharges = float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString());
                                MF.SupervisorSalary = float.Parse(ds.Tables[0].Rows[0]["SupervisorSalary"].ToString());
                                MF.ElectricityCharges=float.Parse(ds.Tables[0].Rows[0]["ElectricityCharges"].ToString());
                                MF.RepairsMaintenanceFund=float.Parse(ds.Tables[0].Rows[0]["RepairsMaintenanceFund"].ToString());
                                MF.LiftCharges=float.Parse(ds.Tables[0].Rows[0]["LiftCharges"].ToString());
                                MF.SinkingFund=float.Parse(ds.Tables[0].Rows[0]["SinkingFund"].ToString());
                                MF.ServiceCharges=float.Parse(ds.Tables[0].Rows[0]["ServiceCharges"].ToString());
                                MF.CarParkingCharges=float.Parse(ds.Tables[0].Rows[0]["CarParkingCharges"].ToString());
                                MF.InterestonDefaultedCharges=float.Parse(ds.Tables[0].Rows[0]["InterestonDefaultedCharges"].ToString());
                                MF.RepaymentInstmntLoanInterest=float.Parse(ds.Tables[0].Rows[0]["RepaymentInstmntLoanInterest"].ToString());
                                MF.NonOccupancyCharges=float.Parse(ds.Tables[0].Rows[0]["NonOccupancyCharges"].ToString());
                                MF.InsuranceCharges=float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString());
                                MF.LeaseRent=float.Parse(ds.Tables[0].Rows[0]["LeaseRent"].ToString());
                                MF.NonAgriculturalTax=float.Parse(ds.Tables[0].Rows[0]["NonAgriculturalTax"].ToString());
                                MF.OtherCharges=float.Parse(ds.Tables[0].Rows[0]["OtherCharges"].ToString());
                                MF.TotalMaintenanceSum=float.Parse(ds.Tables[0].Rows[0]["TotalMaintenanceSum"].ToString());
                                MF.MaintenancePerFlat = float.Parse(ds.Tables[0].Rows[0]["MaintenancePerFlat"].ToString());
                                MF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                                MF.EffectiveToDate=ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                                MF.FlatCount = Convert.ToInt32(ds.Tables[0].Rows[0]["FlatCount"].ToString());
                                MF.TenantMaintenance = Convert.ToInt32(ds.Tables[0].Rows[0]["TenantMaintenance"].ToString());
                                MF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                               
                            }
                            M.Add(MF);
                        
                    }
/////////////////////////////////////////// SquareFeet/////////////////////////////////////////////////////////////////////////
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 2)
                    {
                        maintenance SF = new maintenance();
                       
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                SF.IsRented = ds.Tables[0].Rows[0]["IsRented"].ToString();
                                SF.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                                SF.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                                SF.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                                SF.TotalArea = Convert.ToInt32(ds.Tables[0].Rows[0]["TotalArea"].ToString());
                                SF.PerSquareFeetRate = float.Parse(ds.Tables[0].Rows[0]["PerSquareFeetRate"].ToString());
                             
                                SF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                                SF.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                                SF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                            }
                            M.Add(SF);
                    }
///////////////////////////////////////////End SquareFeet////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////Per Square Feet Rate /////////////////////////////////////////////////////////////////////////
                  
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 3)
                    {
                         maintenance PF = new maintenance();

                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                PF.IsRented = ds.Tables[0].Rows[0]["IsRented"].ToString();
                                PF.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                                PF.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                                PF.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                                PF.FixedSqft = Convert.ToInt32(ds.Tables[0].Rows[0]["FixedSqft"].ToString());
                                PF.FixedRate = float.Parse(ds.Tables[0].Rows[0]["FixedRate"].ToString());
                                PF.AdditionalSqft = Convert.ToInt32(ds.Tables[0].Rows[0]["AdditionalSqft"].ToString());
                                PF.AdditionalSqftRate = float.Parse(ds.Tables[0].Rows[0]["AdditionalSqftRate"].ToString());
                                PF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                                PF.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                                PF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                            }
                            M.Add(PF);
                        
                    }
 ///////////////////////////////////////////End Per Square Feet Rate /////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////Mix Approch /////////////////////////////////////////////////////////////////////////////////////                  
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 4)
                    {
                        maintenance MP = new maintenance();
                   }
 ///////////////////////////////////////////END Mix Approch ////////////////////////////////////////////////////////////////////////////////  
                    ///////////////////////////////////////////Lumpsum Fee Approch //////////////////////////////////////////////////////////////////////////////// 
                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 5)
                    {
                        maintenance LF = new maintenance();

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            LF.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                            LF.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                            LF.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                            LF.PropertyTaxes = float.Parse(ds.Tables[0].Rows[0]["PropertyTaxes"].ToString());
                            LF.WaterCharges = float.Parse(ds.Tables[0].Rows[0]["WaterCharges"].ToString());
                            LF.IsRented = ds.Tables[0].Rows[0]["IsRented"].ToString();
                            LF.SecuritySalary = float.Parse(ds.Tables[0].Rows[0]["SecuritySalary"].ToString());
                            LF.HousekeepingSalary = float.Parse(ds.Tables[0].Rows[0]["HousekeepingSalary"].ToString());
                            LF.ManagerSalary = float.Parse(ds.Tables[0].Rows[0]["ManagerSalary"].ToString());
                            LF.Stationary = float.Parse(ds.Tables[0].Rows[0]["Stationary"].ToString());
                            LF.DgSet = float.Parse(ds.Tables[0].Rows[0]["DgSet"].ToString());
                            LF.GymInstructor = float.Parse(ds.Tables[0].Rows[0]["GymInstructor"].ToString());
                            LF.CommunityHall = float.Parse(ds.Tables[0].Rows[0]["CommunityHall"].ToString());
                            LF.InsuranceCharges = float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString());
                            LF.SupervisorSalary = float.Parse(ds.Tables[0].Rows[0]["SupervisorSalary"].ToString());
                            LF.ElectricityCharges = float.Parse(ds.Tables[0].Rows[0]["ElectricityCharges"].ToString());
                            LF.RepairsMaintenanceFund = float.Parse(ds.Tables[0].Rows[0]["RepairsMaintenanceFund"].ToString());
                            LF.LiftCharges = float.Parse(ds.Tables[0].Rows[0]["LiftCharges"].ToString());
                            LF.SinkingFund = float.Parse(ds.Tables[0].Rows[0]["SinkingFund"].ToString());
                            LF.ServiceCharges = float.Parse(ds.Tables[0].Rows[0]["ServiceCharges"].ToString());
                            LF.CarParkingCharges = float.Parse(ds.Tables[0].Rows[0]["CarParkingCharges"].ToString());
                            LF.InterestonDefaultedCharges = float.Parse(ds.Tables[0].Rows[0]["InterestonDefaultedCharges"].ToString());
                            LF.RepaymentInstmntLoanInterest = float.Parse(ds.Tables[0].Rows[0]["RepaymentInstmntLoanInterest"].ToString());
                            LF.NonOccupancyCharges = float.Parse(ds.Tables[0].Rows[0]["NonOccupancyCharges"].ToString());
                            LF.InsuranceCharges = float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString());
                            LF.LeaseRent = float.Parse(ds.Tables[0].Rows[0]["LeaseRent"].ToString());
                            LF.NonAgriculturalTax = float.Parse(ds.Tables[0].Rows[0]["NonAgriculturalTax"].ToString());
                            LF.OtherCharges = float.Parse(ds.Tables[0].Rows[0]["OtherCharges"].ToString());
                            LF.TotalMaintenanceSum = float.Parse(ds.Tables[0].Rows[0]["TotalMaintenanceSum"].ToString());
                            LF.MaintenancePerFlat = float.Parse(ds.Tables[0].Rows[0]["MaintenancePerFlat"].ToString());
                            LF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                            LF.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                            LF.FlatCount = Convert.ToInt32(ds.Tables[0].Rows[0]["FlatCount"].ToString());
                            LF.TenantMaintenance = float.Parse(ds.Tables[0].Rows[0]["TenantMaintenance"].ToString());
                            LF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                               

                        }
                        M.Add(LF);

                    }

                    ///////////////////////////////////////////ENDLumpsum Fee Approch //////////////////////////////////////////////////////////////////////////////// 
 
                }
            }
             else
             {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
             }
             
             return JsonConvert.SerializeObject(M);

        }

        //////////////////////
        public class Memberbyowner
        {
           public int Id  { get; set; }
           public string FlatId  { get; set; }
           public string Name  { get; set; }
           public string ResidingFrom  { get; set; }
           public string ResidingTo  { get; set; }
           public Double Rent  { get; set; }
           public string PAN  { get; set; }
           public long AadhaarCard  { get; set; }
           public string Relation  { get; set; }
           public string OtherRelation { get; set; }
           public string Address { get; set; }
           public long ContactNo  { get; set; }
           public long ContactNo2 { get; set; }
           public string DOB  { get; set; }
           public string Gender { get; set; }
           public long rowcount { get; set; }
           public long total { get; set; }
         
        }

        public class Eventdetail 
        {
            public string Detail { get; set; }
         
        }

        [WebMethod(EnableSession = true)]
        public static string GetEventDetail(long EventId)
        { 
            clsEvent objEventDAL = new clsEvent();

            DataSet ds = (DataSet)objEventDAL.GetEventDetailbyId(EventId);
 
            if(ds.Tables[0].Rows.Count>0)
            {
                
                string EventTime=(ds.Tables[0].Rows[0]["EventTime"].ToString()!=""?ds.Tables[0].Rows[0]["EventTime"].ToString() : "-");
                string Eventname =ds.Tables[0].Rows[0]["EventName"].ToString() ;
                StringBuilder sbEvnt = new StringBuilder();
                DateTime eventon= Convert.ToDateTime(ds.Tables[0].Rows[0]["EventOn"].ToString());
                    string description=ds.Tables[0].Rows[0]["EventDescription"].ToString();
               sbEvnt.Append("<div class=\"news-blocks\"><h3>Title :<a href=\"page_news_item.html\">"+Eventname+"</a></h3>");
								sbEvnt.Append("<div class=\"news-block-tags\"><strong>Event ON :"+eventon+" </strong><em>Event Time : "+EventTime+"</em></div>");
									sbEvnt.Append("<p>"+description+"</p>");
								sbEvnt.Append("<a href=\"page_news_item.html\" class=\"news-block-btn\"><i class=\"m-icon-swapright m-icon-black\"></i></a></div>");


                 //sbEvnt.Append(" <div class=\"portlet light \"><div class=\"portlet-title\"><div class=\"caption\">	<i class=\"icon-share font-blue-steel hide\"></i>");
                 //sbEvnt.Append("<span class=\"caption-subject font-blue-steel bold uppercase\">" + Convert.ToDateTime(ds.Tables[0].Rows[0]["EventOn"].ToString()) + "</span></div><div class=\"actions\"><div class=\"btn-group\"><a class=\"btn btn-sm btn-default btn-circle\" href=\"#\" > Event Time:" + EventTime + " <i class=\"fa fa-angle-down\"></i></a></div></div></div>");
                 //sbEvnt.Append("<div class=\"portlet-body\"> <div class=\"caption-subject font-red-sunglo bold uppercase\" Style=\"margin-bottom:10px;\" >" + ds.Tables[0].Rows[0]["EventName"].ToString() + "</div><div class=\"clearfix\"></div><div class=\"slimScrollDiv\" style=\"position: relative; overflow: hidden; width: auto; height: 300px;\"><div style=\"font-size:14;line-height:18px;\">" + ds.Tables[0].Rows[0]["EventDescription"].ToString() + "</div></div>");


                List<Eventdetail> objeventDtl=new List<Eventdetail>{

                    new Eventdetail()
                    {
                    
                        Detail=sbEvnt.ToString()
                      
                    }
                };
                return Newtonsoft.Json.JsonConvert.SerializeObject(objeventDtl);
            }
            else
            {
                return "N";
            }
        }
        [WebMethod(EnableSession = true)]
        public static string GetTotalOutStandingMaintenance() 
        {
            string json="N";
           
               string LoginType= Convert.ToString(HttpContext.Current.Session["LoginType"]);
               int FlatId = Convert.ToInt32(HttpContext.Current.Session["FlatId"]);
               clsSocietyMemberDashboardDal objSocMemDashDal = new clsSocietyMemberDashboardDal();
               DataSet ds = (DataSet)objSocMemDashDal.GetTotalOutStandingMaintenance(LoginType, FlatId);

             if ((ds.Tables[0].Rows.Count > 0) && (ds.Tables[0].Rows.Count > 0))
             {
                DataTable Dt= CommonHelper.GenerateTotalPendingExpense(ds);



                json = JsonConvert.SerializeObject(Dt, Formatting.Indented);
             }

             return json;
        }
    
        [WebMethod(EnableSession = true)]
        public static string GetsocietyInfobyID()
        {
            string json = "N";
            clsSocietyInformationEntity objsocInfo = new clsSocietyInformationEntity();
            clsSocietyinfoDal objsocDal = new clsSocietyinfoDal(); 
            objsocInfo.flag = "searchSocityinfobyFlatID";


            objsocInfo.Id = Convert.ToInt32(HttpContext.Current.Session["FlatId"].ToString());
            DataSet ds = (DataSet)objsocDal.GetSocietyinfoByID(objsocInfo);
            if (ds.Tables[0].Rows.Count > 0)
            {

                 json = JsonConvert.SerializeObject(ds, Formatting.Indented);
            }
            else
            {
                 json="N";
            }
            return json;
        }

        [WebMethod(EnableSession = true)]
        public static string GetMemberInfobyID(int PageIndex)
        {
             bool IsRented;
            clsMemberMasterDal objMemDAL = new clsMemberMasterDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            String MemberLoginType = HttpContext.Current.Session["LoginType"].ToString();
            int ID = Convert.ToInt32(HttpContext.Current.Session["ID"]);
            int flatId=Convert.ToInt32 (HttpContext.Current.Session["FlatId"].ToString());

            if( Convert.ToString(HttpContext.Current.Session["IsRented"])=="True")
            {
              IsRented =true;
            }
            else
            {
                IsRented=false;
            }


            ds = (DataSet)objMemDAL.GetMemberbyownerID(ID, MemberLoginType, PageIndex, 10, 0, flatId, IsRented);
            List<Memberbyowner> M = new List<Memberbyowner>();
     
            if (ds.Tables.Count > 0)
            {

                Memberbyowner MF1 = new Memberbyowner();
                MF1.rowcount = Convert.ToInt32(ds.Tables[1].Rows[0]["RecordCount"]);
                MF1.total = Convert.ToInt32(ds.Tables[1].Rows[0]["total"]);                     

                if(Convert.ToInt32(ds.Tables[1].Rows[0]["IsRented"]) == 1)
                {
                    string isrented = ds.Tables[1].Rows[0]["IsRented"].ToString();
                    HttpContext.Current.Session["isrented"] = isrented;

                    string rowcount, total;
                    rowcount = ds.Tables[1].Rows[0]["RecordCount"].ToString();
                    HttpContext.Current.Session["rowcount"] = rowcount;
                    total = ds.Tables[1].Rows[0]["total"].ToString();
                    HttpContext.Current.Session["total"] = total;


                     if (ds.Tables[0].Rows.Count > 0)
                    {
                        //M.Clear();
                        
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            Memberbyowner MF = new Memberbyowner();
                            MF.Id = Convert.ToInt32(ds.Tables[0].Rows[i]["ID"].ToString());
                            MF.FlatId = ds.Tables[0].Rows[i]["FlatId"].ToString();
                            MF.Name = ds.Tables[0].Rows[i]["TenantName"].ToString().ToString();
                            MF.ResidingFrom = ds.Tables[0].Rows[i]["ResidingFrom"].ToString().ToString();
                            MF.ResidingTo = ds.Tables[0].Rows[i]["ResidingTo"].ToString().ToString();
                            MF.Rent = double.Parse(ds.Tables[0].Rows[i]["Rent"].ToString());
                            MF.PAN = ds.Tables[0].Rows[i]["PAN"].ToString();
                            MF.AadhaarCard = Convert.ToInt64(ds.Tables[0].Rows[i]["AadhaarCard"].ToString());
                            MF.Address = ds.Tables[0].Rows[i]["PermanantAddress"].ToString();
                            MF.ContactNo = Convert.ToInt64(ds.Tables[0].Rows[i]["ContactNo1"].ToString());
                            MF.ContactNo2 = Convert.ToInt64(ds.Tables[0].Rows[i]["ContactNo2"].ToString());
                            MF.DOB = ds.Tables[0].Rows[i]["DOB"].ToString();
                            MF.Gender = ds.Tables[0].Rows[i]["Gender"].ToString();
                            MF.total = Convert.ToUInt32(total);
                            MF.rowcount = PageIndex;
                            M.Add(MF);
                            
                        }
                        M.Add(MF1);
                    }
                     
                }
                else
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            //M.Clear();

                            string rowcount, total;
                            rowcount = ds.Tables[1].Rows[0]["RecordCount"].ToString();
                            HttpContext.Current.Session["rowcount"] = rowcount;
                            total = ds.Tables[1].Rows[0]["total"].ToString();
                            HttpContext.Current.Session["total"] = total;
                            string isrented = ds.Tables[1].Rows[0]["IsRented"].ToString();
                            HttpContext.Current.Session["isrented"] = isrented;

                           

                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                Memberbyowner MF = new Memberbyowner();
                                MF.Id = Convert.ToInt32(ds.Tables[0].Rows[i]["ID"].ToString());
                                MF.FlatId = ds.Tables[0].Rows[i]["FlatId"].ToString();
                                MF.Name = ds.Tables[0].Rows[i]["Name"].ToString().ToString();
                                MF.ResidingFrom = ds.Tables[0].Rows[i]["ResidingFrom"].ToString().ToString();
                                MF.Relation = ds.Tables[0].Rows[i]["Relation"].ToString().ToString();
                                MF.OtherRelation = ds.Tables[0].Rows[i]["OtherRelation"].ToString().ToString();
                                MF.PAN = ds.Tables[0].Rows[i]["PAN"].ToString();
                                MF.AadhaarCard = Convert.ToInt64(ds.Tables[0].Rows[i]["AadhaarCard"].ToString());
                                MF.Address = ds.Tables[0].Rows[i]["Address"].ToString();
                                MF.ContactNo = Convert.ToInt64(ds.Tables[0].Rows[i]["ContactNo"].ToString());
                                MF.DOB = ds.Tables[0].Rows[i]["DOB"].ToString();
                                MF.Gender = ds.Tables[0].Rows[i]["Gender"].ToString();
                                MF.total =  Convert.ToUInt32(total);
                                MF.rowcount = PageIndex;
                                M.Add(MF);
                             
                            }
                            M.Add(MF1);
                        }
                 
                    }
              
                }
                else
                {
                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
                }

         
            return JsonConvert.SerializeObject(M);
        }

    }
}

