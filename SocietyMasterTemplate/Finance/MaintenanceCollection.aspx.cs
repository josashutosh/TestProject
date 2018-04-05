using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using SocietyEntity;


namespace EsquareMasterTemplate.Masters
{
    public partial class MaintenanceCollection : System.Web.UI.Page
    {
        string output;
        int MaincollID, ParentId;
        string propertytype=string.Empty, CollectionId=string.Empty;
        clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
        clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
      

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MaincollID = Convert.ToInt32(Request.QueryString["MaincollID"]);
                ParentId = Convert.ToInt32(Request.QueryString["PId"]);
                ValidateUserPermissions();


                if (string.IsNullOrEmpty(Request.QueryString["ColId"]) != true)
                {
                    propertytype = Request.QueryString["Ptype"].ToString();
                    CollectionId = Request.QueryString["ColId"].ToString();
                    modefpayment();
                    drpModeofPayment.Items.Insert(0, new ListItem("--Select Payment Mode--", ""));
                    drpModeofPayment.SelectedIndex = 0;
                    UpdateCollectionInfo(Int32.Parse(CollectionId), propertytype);
                }

                else 
                {
                    modefpayment();
                    drpModeofPayment.Items.Insert(0, new ListItem("--Select Payment Mode--", ""));
                    drpModeofPayment.SelectedIndex = 0;
                }
               
                //drpFlatnumber.Items.Insert(0, new ListItem("--Select Flat Name--", ""));
                //drpFlatnumber.SelectedIndex = 0;

                //drpMaintenancePeriod.Items.Insert(0, new ListItem("--Select Maintenance Period--", ""));
                //drpMaintenancePeriod.SelectedIndex = 0;
               
            }
        }

        protected void UpdateCollectionInfo(int CollId, string PropertyType)
        {

            objMainCollEntity.ID = CollId;
            objMainCollEntity.PropertyType = PropertyType;
            DataSet ds = (DataSet)objMainCollDAL.GetCollectionInfoByCollectionId(objMainCollEntity);

            drpPropertytype.SelectedValue = propertytype;
            objMainCollEntity.ID = 0;
            objMainCollEntity.Flag = "FillDrpFlatNoByPropertyType";
            objMainCollEntity.PropertyType = PropertyType;
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            objParkingDal.FillDropDown(drpFlatnumber, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "FlatNumber", "FlatId");
            drpFlatnumber.SelectedValue = ds.Tables[0].Rows[0]["FlatId"].ToString();

            objMainCollEntity.ID = Int32.Parse(ds.Tables[0].Rows[0]["FlatId"].ToString());
            objMainCollEntity.Flag = "FillDrpMaintenancePeriodbyflatId";
            objMainCollEntity.PropertyType = PropertyType;
            objParkingDal.Filllistbox(drpMaintenancePeriod, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "MaintenancePeriod", "ID");
            drpMaintenancePeriod.SelectedValue = ds.Tables[0].Rows[0]["MaintenanceID"].ToString().Trim();

            drpFlatnumber.Attributes.Add("readonly", "readonly");
            drpMaintenancePeriod.Attributes.Add("readonly", "readonly");
            txtMaintenanceWalletAmt.Attributes.Add("readonly", "readonly");
            drpPropertytype.Attributes.Add("readonly", "readonly");

            objMainCollEntity.Flag = "GetMaintenanceAmountByID";
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            objMainCollEntity.ID = Int32.Parse(ds.Tables[0].Rows[0]["MaintenanceId"].ToString());

            DataSet ds1 = (DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                txtMaintenanceAmount.Text = ds1.Tables[0].Rows[0]["Amount"].ToString();
                txtMaintenanceWalletAmt.Text = ds1.Tables[0].Rows[0]["MaintenanceWalletAmount"].ToString();
            }

            txtPaidAmount.Text = ds.Tables[0].Rows[0]["PaidAmount"].ToString();

            if (ds.Tables[0].Rows[0]["ModePayment"].ToString() == "2" || ds.Tables[0].Rows[0]["ModePayment"].ToString() == "3")
            {
                
                divInstrumentnumber.Attributes["style"] = "display:block";
                
               
            }
            else
            {
                divInstrumentnumber.Attributes["style"] = "display:none";
                lblInstrumentnumber.InnerText = "";
            }
            divInstrumentDate.Attributes["style"] = "display:block";

            if (ds.Tables[0].Rows[0]["ModePayment"].ToString() == "1")
            {

                lblInstrumentDate.InnerText = "Cash";
            }
            if (ds.Tables[0].Rows[0]["ModePayment"].ToString() == "2")
            {
                lblInstrumentnumber.InnerText = "Cheque";
                lblInstrumentDate.InnerText = "Cheque Number";
            }
            else if (ds.Tables[0].Rows[0]["ModePayment"].ToString() == "3")
            {
                lblInstrumentnumber.InnerText = "DD";
                lblInstrumentDate.InnerText = "DD";
            }
            else if (ds.Tables[0].Rows[0]["ModePayment"].ToString() == "4")
            {

                lblInstrumentDate.InnerText = "ECS";
            }

            drpModeofPayment.SelectedValue = ds.Tables[0].Rows[0]["ModePayment"].ToString();
            txtInstrumentDate.Text = ds.Tables[0].Rows[0]["InstrumentDate"].ToString();

            txtInstrumentnumber.Text = ds.Tables[0].Rows[0]["InstrumentNumber"].ToString();

            Session["_CallId"] = CollId;
        
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

        //protected void drpPropertytype_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    objMainCollEntity.PropertyType = drpPropertytype.SelectedValue;
        //    objMainCollEntity.Flag = "FillDrpFlatNoByPropertyType";
        //    DataSet ds = new DataSet();
        //    objMainCollDAL.FillDropDown(drpFlatnumber, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "FlatNumber", "FlatId");

        //    drpFlatnumber.Items.Insert(0, new ListItem("--Select Flat Name--", ""));
        //    drpFlatnumber.SelectedIndex = 0;

        //    drpMaintenancePeriod.Items.Insert(0, new ListItem("--Select Maintenance Period--", ""));
        //    drpMaintenancePeriod.SelectedIndex = 0;
        //}


        private void FillcaltypemasterDropDowns()
        {
            //objMaininfo.flag = "FillcaltypemasterDropDowns";
            //objMainDal.FillDropDown(drpCalcMethod, ((DataSet)objMainDal.GetMaintainanceInfoByID(objMaininfo)).Tables[0], "CalculationMethod", "CalcMasterID");
            //obparkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo)).Tables[0], "FlatNumber", "FlatId");
        }

        private void FillMaintenancePeriod()
        {
            objMainCollEntity.Flag = "FillDrpMaintenancePeriod";
            objMainCollEntity.LoginId = Convert.ToString(Session["LoginId"]);
            if (drpPropertytype.SelectedValue == "Residentail")
            {
                objMainCollDAL.Filllistbox(drpMaintenancePeriod, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "MaintenancePeriod", "FlatmaintenanceId");
            }

            if (drpPropertytype.SelectedValue == "Commercial")
            {
                objMainCollDAL.Filllistbox(drpMaintenancePeriod, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "MaintenancePeriod", "ShopmaintenanceId");
            }

        }

        private void modefpayment()
        {
            objMainCollEntity.Flag = "GetPaymentMode";
            objMainCollDAL.FillDropDown(drpModeofPayment, ((DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity)).Tables[0], "PaymentType", "PaymentID");
        }

        public class clsFlatNumber
        {
            public int FlatId { get; set; }
            public string MaintenancePeriod { get; set; }
            public string PropertyType { get; set; }
            public string FlatNumber { get; set; }
        }

        public class clsGetmaintenancePeriod
        {
            public int ID { get; set; }
            public string MaintenancePeriod { get; set; }
        }

        public class clsMaintenanceAmount
        {
            public float Amount { get; set; }
            public float MaintenanceWalletAmount { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static string GetMaintenanceperiod(int FlatID, string PropertyType)
        {

            clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
            clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            objMainCollEntity.Flag = "FillDrpMaintenancePeriod";
            objMainCollEntity.PropertyType = PropertyType;
            objMainCollEntity.ID = FlatID;
            ds = (DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity);
            List<clsGetmaintenancePeriod> M = new List<clsGetmaintenancePeriod>();
            if (ds.Tables.Count > 0)
            {
                //M.Clear();
                
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    clsGetmaintenancePeriod MF = new clsGetmaintenancePeriod();
                    MF.ID = Convert.ToInt32(ds.Tables[0].Rows[i]["ID"].ToString());
                    MF.MaintenancePeriod = ds.Tables[0].Rows[i]["MaintenancePeriod"].ToString();
                    M.Add(MF);

                }

            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }

            return JsonConvert.SerializeObject(M);
        }

        [WebMethod(EnableSession = true)]
        public static string GetFlatNumber(string PropertyType)
        {
            clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
            clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            objMainCollEntity.Flag = "FillDrpFlatNoByPropertyType";
            objMainCollEntity.PropertyType = PropertyType;
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            ds = (DataSet)objMainCollDAL.GetMaintenanceCollection(objMainCollEntity);
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

        [WebMethod(EnableSession = true)]
        public static string GetMaintenancAmounts(string MainID, string PropertyType)
        {
            clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
            clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            objMainCollEntity.Flag = "GetMaintenanceAmountByID";
            objMainCollEntity.CollectionIds = MainID;
            objMainCollEntity.PropertyType = PropertyType;
            objMainCollEntity.LoginId = Convert.ToString(HttpContext.Current.Session["LoginId"]);
            ds = (DataSet)objMainCollDAL.GetMaintenanceCollectionAmount(objMainCollEntity);
            List<clsMaintenanceAmount> M = new List<clsMaintenanceAmount>();
            if (ds.Tables.Count > 0)
            {
                //M.Clear();
               
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    clsMaintenanceAmount MF = new clsMaintenanceAmount();
                    MF.Amount = float.Parse(ds.Tables[0].Rows[i]["Amount"].ToString());
                    MF.MaintenanceWalletAmount = float.Parse(ds.Tables[0].Rows[i]["MaintenanceWalletAmount"].ToString());
                    M.Add(MF);
                }

            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }

            return JsonConvert.SerializeObject(M);
        }

        protected void btnBuildingSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Convert.ToString(Session["_CallId"])) ==true)
            {
                objMainCollEntity.ID = 0;
            }
            else
            {
                objMainCollEntity.ID = Convert.ToInt32(Session["_CallId"]);
            }

                objMainCollEntity.PropertyType = drpPropertytype.SelectedValue;
                objMainCollEntity.CollectionIds = Convert.ToString(hdnmaintenanceid.Value);
                objMainCollEntity.PaidAmount = double.Parse(txtPaidAmount.Text);
                objMainCollEntity.ModePayment = Convert.ToInt32(drpModeofPayment.SelectedValue);
                objMainCollEntity.InstrumentNumber = Convert.ToInt64(txtInstrumentnumber.Text);
                objMainCollEntity.InstrumentDate = txtInstrumentDate.Text;
                objMainCollEntity.MaintenanceWalletAmount = double.Parse(txtMaintenanceWalletAmt.Text);
                objMainCollEntity.CreatedBy = Convert.ToString(Session["LoginId"]);
                output = objMainCollDAL.InsertmaintenanceCollection(objMainCollEntity);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);

            clerall();
        }

        public void clerall()
        {
            drpPropertytype.SelectedValue = "";
            txtPaidAmount.Text = "";
            txtInstrumentnumber.Text = "";
            txtInstrumentDate.Text = "";
            Session["_CallId"] = null;
        }

        //Get Date Format
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaintenanceCollectionView.aspx");
            Session["_CallId"] = null;
        }

    }
    
}