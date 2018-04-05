using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Syncfusion.Pdf;
using Syncfusion.Pdf.Graphics;
using System.Drawing;
using System.Threading;
using Syncfusion.Pdf.HtmlToPdf;
using System.Text;
using System.IO;
//using Syncfusion.WebKitHtmlConverter;
using Syncfusion.HtmlConverter;
using System.Drawing.Imaging;
using Syncfusion.Pdf.Parsing;
using Syncfusion.Pdf.Barcode;
using EsquareMasterTemplate.Common;
using Syncfusion.Pdf.Grid;
using SocietyDAL;
using SocietyEntity;
using System.Data;
using Syncfusion.Pdf.Security;
using EsquareMasterTemplate.PrintPdfReferemce;
using Syncfusion.Windows.Forms.PdfViewer;

namespace EsquareMasterTemplate.Reports
{
    public partial class ReportsHome : System.Web.UI.Page
    {
        clsPaymentDAL objPaymentDAL = new clsPaymentDAL();
        clsReportDal objReportDal = new clsReportDal();
        clsReportParameterEntity objReport = new clsReportParameterEntity();
        CommonHelper ch = new CommonHelper();
        public PdfDocument doc = null;
        string Title, Description, Imagepath;
        string PropertyType = string.Empty;
        string MaintenanceID = string.Empty;
        char flag;
        float Headerheight;
        string PrimId = string.Empty;
        string BaseUrl = string.Empty;
        long societyId;
        int columncount, k;

        string GenerateTable = string.Empty;
        clsUserDAL objMainDal = new clsUserDAL();

        clsCommonDAL objCommonDAL = new clsCommonDAL();
        protected void Page_Load(object sender, EventArgs e)
        {

            PropertyType=  Convert.ToString(Request.QueryString["P"]);
            MaintenanceID = Convert.ToString(Request.QueryString["MId"]);
            flag =  Convert.ToChar(Request.QueryString["flag"]) ;
            PrimId = Convert.ToString(Request.QueryString["PrimId"]) == "SD" ? GetPrimIdByFlatMaintainanceID(MaintenanceID, PropertyType) : Convert.ToString(Request.QueryString["PrimId"]);
           societyId =long.Parse(Request.QueryString["SID"]);

            if (!IsPostBack)
            {
                //Generate Receipt(PDF)
                //GeneratePdfFormatting("Residential", "4",'H', "17",3,"");
                GenerateReceipt(PropertyType, MaintenanceID, flag,PrimId, societyId);

                ////Generate Receipt(Html)
                    //GenerateReceipt(PropertyType, MaintenanceID, flag,PrimId, societyId);
                   //  GenerateReceipt("Residential", "4", 'H', "17", 3);

            }

        }

        private string GetPrimIdByFlatMaintainanceID(string MaintenanceID, string PropertyType)
        {
            objReport.FlatmaintenanceId = MaintenanceID;
            objReport.PropertyType = PropertyType; 

            return objReportDal.GetPrimIdByFlatMaintainanceID(objReport);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //soNDnD  soWDnD sender Id
            string username = "8655096955";
            string password = "rampandu17";
            var cli = new System.Net.WebClient();
            string Message = "4 and message";
            string number = "9029150847,9029583367";//Formultiple Number seprated by comma
            string SenderName = "060000";
            //  http://bhashsms.com/api/sendmsg.php?user={0}&pass={1}&sender=Society&phone=Mobile No&text=Test SMS&priority=Priority&stype=smstype

            var format = @"http://bhashsms.com/api/sendmsg.php?user={2}&pass={3}&sender={4}&phone={0}&text=Test SMS YOUR Maintenance ID  {1} Successfully&priority=dnd&stype=normal";

            cli.DownloadString(string.Format(format, number, Message, username, password, SenderName));
        }

        protected void Generatepdf_Click(object Sender, EventArgs e)
        {

            GeneratePdfFormatting(PropertyType, MaintenanceID, flag, PrimId, societyId,"");
            //     GeneratePdfWebkit(html);
            //  SetThreadGenPdf();

        }

        public void GenerateReceipt(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId)
        {
            DataSet ds = (DataSet)objPaymentDAL.GetPaymentReceiptDetails(PropertyType, MaintenanceID, flag, PrimId, societyId);
            string logo, Address, genetable=string.Empty;
            StringBuilder receipt = new StringBuilder();

            #region Generate Logo
            BaseUrl = ch.GetBaseURL();
            if (ds.Tables[4].Rows[0]["Logo"].ToString() != "" && File.Exists(Server.MapPath("../"+ds.Tables[4].Rows[0]["Logo"].ToString())) == true)
            {
                logo = BaseUrl +ds.Tables[4].Rows[0]["Logo"].ToString();
            }
            else
            {
                logo = BaseUrl+"Images/logo.png";
            }
            string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            Address = ds.Tables[4].Rows[0]["SocietyAddress"].ToString();
            if (Address != "")
            {
                Address = Address.Replace(",", ",\n");
            }

            receipt.Append("<div class=\"row invoice-logo\"><div class=\"col-xs-6 invoice-logo-space\">");
            receipt.Append("<img src=\"" + logo + "\" width=\"200\" Height=\"45\" style=\"margin-top:3px;width:200px; height:50px;\" class=\"img-responsive\" alt=\"Logo\"></div>");
            receipt.Append("<div class=\"col-xs-6\" style=\"text-align:right;padding-right:30px;\"><p>");
            receipt.Append("<p>"+SocietyName+"</p>");
            receipt.Append("<p style=\"font-size:15px;color:blue;\">Calculation Type:" + ds.Tables[2].Rows[0]["CalculationMethod"].ToString() + "</p>");
            receipt.Append("</p></div></div><hr>");
            #endregion

            #region  Owner info and payment info

            receipt.Append(" <div class=\"row\"><div class=\"col-xs-6\" style=\"text-align:left;padding-left:30px \"><h3>Owner Detail:</h3>	<ul class=\"list-unstyled\">");
            receipt.Append("<li> " + ds.Tables[1].Rows[0]["OwnerName1"].ToString() + "</li>");
            receipt.Append("<li>" + ds.Tables[1].Rows[0]["PropertyType"].ToString() + " " + ds.Tables[1].Rows[0]["FlatNumber"].ToString() + "</li>");
            receipt.Append("<li>" + ds.Tables[1].Rows[0]["permanentAddress"].ToString() + "</li>");
            receipt.Append("<li>" + ds.Tables[1].Rows[0]["ContactNumber"].ToString() + "</li> 	</ul></div>");
           // receipt.Append("<div class=\"col-xs-1\"></div>");
            receipt.Append("<div class=\"col-xs-6 invoice-payment\" style=\"text-align:right;padding-right:30px \"><h3>Payment Details:</h3><ul class=\"list-unstyled\">");
          
            if (long.Parse(ds.Tables[1].Rows[0]["PaymentdetailId"].ToString()) != 0)
            {
                receipt.Append("<li><strong>Name on card: </strong>" + ds.Tables[3].Rows[0]["NameOnCard"].ToString() + "</li>");
                receipt.Append("<li><strong>Card Number : </strong>" + ds.Tables[3].Rows[0]["CardNumber"].ToString() + "</li>");
                receipt.Append("<li><strong>Bank ref Number : </strong>" + ds.Tables[3].Rows[0]["BankRefNumber"].ToString() + "</li>");
                receipt.Append("<li><strong>Mode: </strong>" + ds.Tables[3].Rows[0]["Mode"].ToString() + "</li>");
                receipt.Append("<li><strong>Date: </strong>" + ds.Tables[3].Rows[0]["addedon"].ToString() + "</li></ul></div></div>");
            }
            else 
                {
                    string BankName = Convert.ToString(ds.Tables[3].Rows[0]["BankName"]) == "" ? "-" : ds.Tables[3].Rows[0]["BankName"].ToString();
                    string InstrumentNumber = Convert.ToString(ds.Tables[3].Rows[0]["InstrumentNumber"]) == "" ? "-" : ds.Tables[3].Rows[0]["InstrumentNumber"].ToString();
                    string InstrumentDate = Convert.ToString(ds.Tables[3].Rows[0]["InstrumentDate"]) == "" ? "-" : ds.Tables[3].Rows[0]["InstrumentNumber"].ToString();
                    receipt.Append("<li><strong>Payment Type: </strong>" + ds.Tables[3].Rows[0]["PaymentType"].ToString() + "</li>");

                    receipt.Append("<li><strong>Bank Name : </strong>" + BankName + "</li>");
                    receipt.Append("<li><strong>Instrument Number: </strong>" + InstrumentNumber + "</li>");
                    receipt.Append("<li><strong>Date: </strong>" + InstrumentDate + "</li></ul></div></div>");
                    //receipt.Append("<li><strong>Card Number : </strong> Rs: " + ds.Tables[3].Rows[0]["CardNumber"].ToString() + "</li>");
            }

            #endregion

            #region Generate Table

            receipt.Append("<div class=\"row\"><div class=\"col-xs-12\" style=\"padding:27px\"><table class=\"table table-striped table-hover\">");
           

            if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 1)
            {
                DataTable dt = (DataTable)ch.GenerateDatasetToDatatable(ds, "FlatMonthlyFee");
                //  grid.DataSource = dt;
                genetable = GenerateTableFromdatatable(dt, 4);
             

            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 2)
            {
                DataTable dt = (DataTable)ch.GenerateDatasetToDatatable(ds, "PerSquareFeetRate");
                genetable = GenerateTableFromdatatable(dt, 2);
               
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 3)
            {
                DataTable dt = (DataTable)ch.GenerateDatasetToDatatable(ds, "PartialFlatRate");
                genetable = GenerateTableFromdatatable(dt, 2);
           
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 4)
            {
                DataTable dt = (DataTable)ch.GenerateDatasetToDatatable(ds, "MixedApproach");
                genetable = GenerateTableFromdatatable(dt, 2);
               
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 5)
            {
                DataTable dt = (DataTable)ch.GenerateDatasetToDatatable(ds, "LumpsumFee");
                genetable = GenerateTableFromdatatable(dt, 4);
             
            }

            receipt.Append(genetable);



            #endregion



            #region Footer
            string Registrationnumber = ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();

            receipt.Append("<div class=\"row\"><div class=\"col-xs-5\"><div class=\"well\">");
            if (ds.Tables[4].Rows[0]["RegistrationNumber"].ToString() != "")
            {
                receipt.Append("<span>" + Registrationnumber + "</span><br/>");
            }
            receipt.Append("<address>" + Address + "</address></div>	</div>");


          //  receipt.Append("	<div class=\"col-xs-8 invoice-block\">" + Address + "<br>");
            receipt.Append("<div style=\" text-align:right; margin-right:1px;\" class=\"col-xs-6\">Sign<br/>");

            string secretorySign;
            if (ds.Tables[4].Rows[0]["Secretorysign"].ToString() != "" && File.Exists(Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString())) == true)
            {
                secretorySign = BaseUrl + ds.Tables[4].Rows[0]["Secretorysign"].ToString();
                receipt.Append("<img    src=\"" + secretorySign + "\" width=\"200\" Height=\"45\"  style=\"margin-top:3px; float:right;width:200px; height:50px;\" class=\"img-responsive\" alt=\"secretorySign\" ></div> <br/>");
            }
            else
            {
                //<!--a class=\"btn btn-lg blue hidden-print \" onclick=\"javascript:window.print();\">Print <i class=\"fa fa-print\"></i></a-->
                receipt.Append("No Sign Available </div><br/>");
            }
            
            
            receipt.Append("</div></div>");

            #endregion

            invoice.InnerHtml = receipt.ToString();

        }


       


        public string GenerateTableFromdatatable(DataTable dt, int columncount)
        {

            StringBuilder GenString = new StringBuilder();

            

                GenString.Append("<thead>");
                for (int h = 0; h < dt.Columns.Count; h++)
                {
                    GenString.Append("<th> " + dt.Columns[h].ColumnName + "</th>");
                }
            GenString.Append("</thead>");
          

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                 
                   GenString.Append("<tbody>");


                GenString.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                        GenString.Append("<td> " + dt.Rows[i][j] + "</td>");
                    
                }
                GenString.Append("</tr>");

            }
            GenString.Append("</tbody></table></div></div>");
            return GenString.ToString();
        }


        public void GeneratePdfFormatting(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId,string generate)
        {
            DataSet ds = (DataSet)objPaymentDAL.GetPaymentReceiptDetails(PropertyType, MaintenanceID, flag, PrimId, societyId);
            //create an object reference for the Serviceclient
           

            PdfLayoutResult result;
            // /Creates a new PDF document.
            PdfDocument document = new PdfDocument();
            //Accesses document information.       
            document.DocumentInformation.Author = ds.Tables[1].Rows[0]["OwnerName1"].ToString();
            document.DocumentInformation.Title = ds.Tables[2].Rows[0]["CalculationMethod"].ToString() + " - " + ds.Tables[1].Rows[0]["OwnerName1"].ToString();
            document.DocumentInformation.Subject = ds.Tables[2].Rows[0]["CalculationMethod"].ToString() ;
            document.DocumentInformation.Keywords = "XXX";
            document.DocumentInformation.Creator = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            document.DocumentInformation.Producer = ds.Tables[4].Rows[0]["SocietyName"].ToString();

            //Adds a page to the document.
            PdfPage page = document.Pages.Add();
            //Sets landscape page orientation.
            document.PageSettings.Orientation = PdfPageOrientation.Landscape;
            // Sets the page size.
            document.PageSettings.Size = PdfPageSize.A4;

            //Creates PDF graphics for the page.
            PdfGraphics graphics = page.Graphics;
            //Sets the font.
            PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12);

            document.PageSettings.Margins.All = 25;
            //Set Header
          
            if (ds.Tables[4].Rows.Count > 0)
            {
                string Logo, Address;
                string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString() == "" ? "-" : ds.Tables[4].Rows[0]["SocietyName"].ToString();
                Address = ds.Tables[4].Rows[0]["SocietyAddress"].ToString() + "," + ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();
                if (Address != "")
                {
                    Address = Address.Replace(",", ",\n");
                }

                if (File.Exists(Server.MapPath("../"+ds.Tables[4].Rows[0]["Logo"].ToString())) == true && "../"+ds.Tables[4].Rows[0]["Logo"].ToString() != "")
                {
                    Logo = "../"+ds.Tables[4].Rows[0]["Logo"].ToString();
                }
                else
                {
                    Logo = "~/Images/logo.png";
                }

                

                Headerheight = ch.AddHeader(document, SocietyName, Address, Server.MapPath(Logo));
            }
            ch.AddFooter(document, "@Esquareinfotech.com");



            string OwnerID = "ANIL";
            string Date = ds.Tables[2].Rows[0]["EffectiveFromDate"].ToString();
            string CalculationMethod =  ds.Tables[2].Rows[0]["CalculationMethod"].ToString();
            result = ch.receiptInfo(graphics, page, CalculationMethod, OwnerID, Date, Headerheight);

            StringBuilder Ownerinfo = new StringBuilder();

            Ownerinfo.Append(ds.Tables[1].Rows[0]["OwnerName1"].ToString() + "\n");
            Ownerinfo.Append(ds.Tables[1].Rows[0]["PropertyType"].ToString() + " " + ds.Tables[1].Rows[0]["FlatNumber"].ToString() + "\n");
            Ownerinfo.Append(ds.Tables[1].Rows[0]["permanentAddress"].ToString() + "\n");
            Ownerinfo.Append(ds.Tables[1].Rows[0]["ContactNumber"].ToString() + "\n");



            string ownerinfo = Ownerinfo.ToString();
            StringBuilder Paymentinfo = new StringBuilder();
           

            if (long.Parse(ds.Tables[1].Rows[0]["PaymentdetailId"].ToString()) != 0)
            {
                Paymentinfo.Append("Name on card: " + ds.Tables[3].Rows[0]["NameOnCard"].ToString() + "\n");
                Paymentinfo.Append("Card Number : " + ds.Tables[3].Rows[0]["CardNumber"].ToString() + "\n");
                Paymentinfo.Append("Bank ref Number : " + ds.Tables[3].Rows[0]["BankRefNumber"].ToString() + "\n");
                Paymentinfo.Append("Mode: " + ds.Tables[3].Rows[0]["Mode"].ToString() + "\n");
                Paymentinfo.Append("Date: " + ds.Tables[3].Rows[0]["addedon"].ToString());
            }
            else
            {
                string BankName = Convert.ToString(ds.Tables[3].Rows[0]["BankName"]) == "" ? "-" : ds.Tables[3].Rows[0]["BankName"].ToString();
                string InstrumentNumber = Convert.ToString(ds.Tables[3].Rows[0]["InstrumentNumber"]) == "" ? "-" : ds.Tables[3].Rows[0]["InstrumentNumber"].ToString();
                string InstrumentDate = Convert.ToString(ds.Tables[3].Rows[0]["InstrumentDate"]) == "" ? "-" : ds.Tables[3].Rows[0]["InstrumentNumber"].ToString();
                Paymentinfo.Append("Payment Type: " + ds.Tables[3].Rows[0]["PaymentType"].ToString() + "\n");

                Paymentinfo.Append("Bank Name : " + BankName + "\n");
                Paymentinfo.Append("Instrument Number: " + InstrumentNumber + "\n");
                Paymentinfo.Append("Date: " + InstrumentDate + "\n");
                //receipt.Append("<li><strong>Card Number : </strong> Rs: " + ds.Tables[3].Rows[0]["CardNumber"].ToString() + "</li>");
            }


            string PaymentDetail = Paymentinfo.ToString();
            result = ch.OwnerandpaymentDetail(result, graphics, page, ownerinfo, PaymentDetail);
            // DataSet ds = (DataSet)objMainDal.GetCountryList();
            GenerateTable = "Yes";

            if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 1)
            {
                columncount = 4;
                k = 2;
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 2)
            {
                columncount = 2;
                k = 1;
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) ==3)
            {
                columncount = 2;
                k = 1;
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 4)
            {
                columncount = 2;
                k = 1;
            }
            else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 5)
            {
                columncount = 4;
                k = 2;
            }

            result = ch.GeneratePayDetailGrid(result, graphics, page, ds, GenerateTable, columncount, k);

            //Hides viewer application's menu bar.
            document.ViewerPreferences.HideMenubar = true;
            //Hides viewer application's toolbar.
            document.ViewerPreferences.HideToolbar = false;
            //Shows user interface elements in the document's window (such as scroll bars and navigation controls).
            document.ViewerPreferences.HideWindowUI = false;
            //Displays one page at a time.
            document.ViewerPreferences.PageLayout = PdfPageLayout.SinglePage;
            //Uses default viewer application page mode.
            document.ViewerPreferences.PageMode = PdfPageMode.UseNone;
            //Saves the document.\\
            document.Compression = Syncfusion.Pdf.PdfCompressionLevel.Best;


           // Set Password To Pdf
            if (generate != "Print")
            {
                //document.Security.UserPassword = ds.Tables[1].Rows[0]["FlatNumber"].ToString();
                //document.Security.OwnerPassword = ds.Tables[1].Rows[0]["FlatNumber"].ToString();
                //document.Security.KeySize = PdfEncryptionKeySize.Key128Bit;
            }
           // document.Security.Permissions = PdfPermissionsFlags.Print | PdfPermissionsFlags.FullQualityPrint;
            document.Security.Permissions = PdfPermissionsFlags.Print;


            document.Security.Permissions = PdfPermissionsFlags.EditContent;
            document.Security.Permissions = PdfPermissionsFlags.EditAnnotations;
            document.Security.Permissions = PdfPermissionsFlags.CopyContent;
            document.Security.Permissions = PdfPermissionsFlags.AccessibilityCopyContent;

            //watermark
            //if (ds.Tables[4].Rows[0]["SocietyStamp"].ToString() != "" && File.Exists(HttpContext.Current.Server.MapPath("../"+ds.Tables[4].Rows[0]["SocietyStamp"].ToString())) == true)
            //{
            //    ch.WaterMarkOnPDF(document, "", Server.MapPath("../"+ds.Tables[4].Rows[0]["SocietyStamp"].ToString()));
            //}
            //else
            //{
            //    ch.WaterMarkOnPDF(document, "Your Society Stamp", "");
            //}

            #region print

            PrintPdfClient client = new PrintPdfClient();

            if (generate != "Print")
            {

                //document.Save(Server.MapPath("~/Images/Receipt/" + ds.Tables[1].Rows[0]["FlatId"].ToString() + "Sample.pdf"));
                //Response.ContentType = "image/jpeg";
                //Response.AppendHeader("Content-Disposition", "attachment; filename=sample.pdf");
                //Response.TransmitFile(Server.MapPath("~/Images/Receipt/" + ds.Tables[1].Rows[0]["FlatId"].ToString() + "Sample.pdf"));
                //Response.End();

                //create new MemoryStream object and add PDF file’s content to outStream.
                    MemoryStream outStream = new MemoryStream();
                    document.Save(outStream);
                    //specify the duration of time before a page cached on a browser expires
                    Response.Expires = 0;

                    //specify the property to buffer the output page
                    Response.Buffer = true;

                    //erase any buffered HTML output
                    Response.ClearContent();

                    //add a new HTML header and value to the Response sent to the client
                    Response.AddHeader("content-disposition", "inline; filename=sample");

                    //specify the HTTP content type for Response as Pdf
                    Response.ContentType = "application/pdf";

                    //write specified information of current HTTP output to Byte array
                    Response.BinaryWrite(outStream.ToArray());

                    //close the output stream
                    outStream.Close();

                    //end the processing of the current page to ensure that no other HTML content is sent
                    Response.End();

            }
            else
            {

                //Create an instance for MemoryStream

                MemoryStream memoryStream = new MemoryStream();

                //Save the PDF document as a MemoryStream

                document.Save(memoryStream);

                byte[] byteArray = memoryStream.ToArray();

                //Create an instance of PdfDocumentView

                PdfDocumentView view = new PdfDocumentView();

                //Load the document in the viewer as stream

                view.Load(new MemoryStream(byteArray));


                //Silently print the document to default printer
                view.PrintDocument.Print();



                ////var client = new PrintPdfService.PrintPdfServiceClient("BasicHttpBinding_Service1");
                //MemoryStream memoryStream = new MemoryStream();
                //document.Save(memoryStream);
                //byte[] byteArray = memoryStream.ToArray();
                ////call the PrintService method in the service with byte array as parameter
                //client.PrintService(byteArray);
            }


            #endregion
      
            //Closes the document.
            document.Close(true);

        }

        protected void PrintPdf_Click(object sender, EventArgs e)
        {
           // GeneratePdfFormatting("Residential", "4", 'H', "17", 3, "Print");


            GeneratePdfFormatting(PropertyType, MaintenanceID, flag, PrimId, societyId,"Print");
        }

    }
}