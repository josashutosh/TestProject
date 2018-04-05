using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyEntity;
using System.Data;
using Newtonsoft.Json;
using System.Web.Services;
using System.IO;
using EsquareMasterTemplate.Common;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.html;

namespace EsquareMasterTemplate.Finance
{
    public partial class MaintenanaceCalculation : System.Web.UI.Page
    {
        clsMaintenanceCalculationDal objmaintcalc = new clsMaintenanceCalculationDal();
        clsMaintenanceCollectionEntity objmainCol = new clsMaintenanceCollectionEntity();
        clsPaymentDAL objPaymentDAL = new clsPaymentDAL();
        clsBuildingMasterDal objbuildinginfoDal = new clsBuildingMasterDal();
        clsBuildingEntity objbuildinginfo = new clsBuildingEntity();
        
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        CommonHelper objhelper = new CommonHelper();
        int ParentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();
                BindBuildingid();
                DrpBuildingID.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Building Name--", ""));
                DrpBuildingID.SelectedIndex = 0;
            }
        }

        protected void btnMaintenanceCalculation_Click(object sender, EventArgs e)
        {
            int societyid = Convert.ToInt16(Session["ID"]);
            try 
	        {
                string status = objmaintcalc.CalculateMaintenance(societyid, drpPropertytype.SelectedValue);
                lblStatus.Text = status;
                lblStatus.Visible = true;
            }
	        catch (Exception ex)
	        {
		        Response.Write(ex.Message.ToString());
	        }
        }

        public void BindBuildingid()
        {
            DataSet ds = new DataSet();
            objbuildinginfo.BuildingId = 0;
            string SocietyId = Convert.ToString(Session["ID"]) as string;
            objbuildinginfo.SocietyIdvar = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            ds = (DataSet)objbuildinginfoDal.GetAllBuildingInfo(objbuildinginfo, Convert.ToString(Session["LoginId"]));
            DrpBuildingID.DataSource = ds;
            DrpBuildingID.DataTextField = "Name";
            DrpBuildingID.DataValueField = "BuildingId";
            DrpBuildingID.DataBind();

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

        public class clsFlatList
        {
            public int FlatId { get; set; }
            public string Name { get; set; }
        }

        
      [WebMethod(EnableSession = true)]
        public static string GetSmsEmils(string Action, string FlatIDs)
        {
            string Output=string.Empty;
            clsBulkUploadDal bulkmailsmsdal = new clsBulkUploadDal();
            int SocietyId = Convert.ToInt32(HttpContext.Current.Session["ID"].ToString());
            DataSet ds = (DataSet)bulkmailsmsdal.GetamilnasSmsByFlatIDs(Action, FlatIDs, SocietyId);

            if (ds.Tables[0].Rows.Count > 0)
            {
              
                   // Output =    ds.Tables[0].Rows[0]["MobileNos"].ToString();
               
                   // Output = ds.Tables[0].Rows[0]["EmailIds"].ToString();
                    Output = JsonConvert.SerializeObject(ds);
                
                
            }

             return Output;
        }

      
        [WebMethod(EnableSession = true)]
        public static string GetFlatList(int BuildingId)
        {

            clsFlatMasterDal flatmasterdal = new clsFlatMasterDal();

            DataSet ds = (DataSet)flatmasterdal.GetFlatbybuildingid(BuildingId);

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
        protected void btnSendMail_Click(object sender, EventArgs e)
        {

        }

        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {

            string propertyType = drppropertyTypepdf.SelectedValue;
            int SocietyId= string.IsNullOrWhiteSpace(Session["ID"].ToString()) == true ? 0 : Convert.ToInt32(Session["ID"]);

            objmainCol.PropertyType = propertyType;
            objmainCol.FromMonth = txtfrommonth.Text;
            objmainCol.Fromyear = txtfromyear.Text;
            objmainCol.FlatIds = hdnFlatids.Value;
            objmainCol.SocietyId = SocietyId;

            DataSet ds = (DataSet)objmaintcalc.MonthlyPdfGeneration(objmainCol);


            if (ds.Tables[0].Rows.Count > 0)
            {
                // invoice.RenderControl(hw);
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=" + "PDFfile.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

              



                // 1: create object of a itextsharp document class

                Document doc = new Document(PageSize.A4, 10, 5, 25, 5);
                HTMLWorker parser = new HTMLWorker(doc);
                // Document doc = new Document(new Rectangle()); 
                MemoryStream ms = new MemoryStream();

                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                //doc.AddAuthor("Micke Blomquist");
                doc.AddCreator("esquareinfotech.com");
                //doc.AddKeywords("PDF tutorial education");
                doc.AddSubject("Monthly Maintenanac Bill ");

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    DataSet ds1 = (DataSet)objPaymentDAL.GenerateMonthlyBill(propertyType, ds.Tables[0].Rows[i]["FlatmaintenanceId"].ToString(), SocietyId);
                    string HTMLContent = objhelper.HtmlGenerateReceipt(ds1);
                    StringReader reader = new StringReader(HTMLContent);
                    parser.Parse(reader);
                    doc.NewPage();
                }

                parser.EndDocument();

                parser.Close();
                doc.Close();

                Response.BinaryWrite(ms.ToArray());
                Response.End();
            
            }
        }

        [WebMethod(EnableSession = true)]
        public static string getFlatNoByPropertyType(string PropertyType)
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

        public class clsFlatNumber
        {
            public int FlatId { get; set; }
            public string MaintenancePeriod { get; set; }
            public string PropertyType { get; set; }
            public string FlatNumber { get; set; }
        }


        protected void btnSendSms_Click(object sender, EventArgs e)
        {
            string Output = string.Empty;
              string username = string.Empty;
           string Password = string.Empty;
           string message = string.Empty;
           string Numbers = string.Empty;
            string Message=string.Empty;
            string SenderName=string.Empty;
        //  string Email = string.Empty;
            username= System.Configuration.ConfigurationManager.AppSettings.Get("SmsbulkUsername");
            Password=System.Configuration.ConfigurationManager.AppSettings.Get("SmsbulkPassword");
            Numbers=    txttosmsemail.Text;
            string MessageType = "normal";
            string Priority = "ndnd";
            message=txtsmsmessage.Text;
            SenderName = hdnSendername.Value;
         Output=   objhelper.SendSms(username, Password, SenderName,Priority, MessageType, Numbers, message);

         ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + Output + "'); </script>", false);
        }
        protected void btnsendEmail_Click(object sender, EventArgs e)
        {
            string username = string.Empty;
            string Password = string.Empty;
            string message = string.Empty;
           
            string Message = string.Empty;
            string SenderName = string.Empty;
             string Email = string.Empty;
            username = System.Configuration.ConfigurationManager.AppSettings.Get("SmsbulkUsername");
            Password = System.Configuration.ConfigurationManager.AppSettings.Get("SmsbulkPassword");
            Email = txttosmsemail.Text;
   
            message = txtEmailDescription.Text;
         
          
        }
        

        


    }
}