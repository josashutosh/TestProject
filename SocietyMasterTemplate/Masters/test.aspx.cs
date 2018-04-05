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

namespace EsquareMasterTemplate.Masters
{
    public partial class test : System.Web.UI.Page
    {
        CommonHelper ch = new CommonHelper();

        public PdfDocument doc = null;
        string Title, Description, Imagepath;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void SendSms(object Sender, EventArgs args)
        { 
                   
        
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
                  //soNDnD  soWDnD sender Id
                        string username = "8655096955";
                        string password = "rampandu17";
                        string Message = "4 and message";
                        string number = "8655096955";//Formultiple Number seprated by comma
                        string SenderName = "TESTTO";
                        string MessageType = "ndnd";

                     SendSms( username, password, SenderName, MessageType, number, Message);
            //or
                 //    ch.SendSms(username, password, SenderName, MessageType, number, Message);

        }

        public void SendSms(string username, string password, string SenderName, string MessageType, string number, string Message)
        {
                string MessageID;
                var cli = new System.Net.WebClient();

                var smsbalance = @"http://bhashsms.com/api/checkbalance.php?user={0}&pass={1}";

                //Get balance sms Count
                string count = cli.DownloadString(string.Format(smsbalance, username, password));

                if (Int32.Parse(count) > 0)
                {
                    var format = @"http://bhashsms.com/api/sendmsg.php?user={0}&pass={1}&sender={2}&priority={3}&stype=normal&phone={4}&text={5}";
                    MessageID = cli.DownloadString(string.Format(format, username, password, SenderName, MessageType, number, Message));
                    //Get Status of Sent Sms = sent-still pending but not DELIVRD,  DELIVRD-Successfully sent
                    if (MessageID != "")
                    {
                        var sendingreport = @"http://bhashsms.com/api/recdlr.php?user={0}&msgid={1}&phone={2}&msgtype={3}";
                        string status = cli.DownloadString(string.Format(sendingreport, username, MessageID, number, MessageType));
                    }
                }
        
        }

        protected void Generatepdf_Click(object Sender, EventArgs e)
        {

            GeneratePdfFormatting();
       //     GeneratePdfWebkit(html);
          //  SetThreadGenPdf();

        }

        private void SetThreadGenPdf()
        {
            Thread t = new Thread(GeneratePdfString2);
            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();

            doc.Save("~/Images/Receipt/Sample.pdf", Response, HttpReadType.Save);
            doc.Close(true);
        }

        private void GeneratePdfHtmlString()
        {
            StringBuilder sb = new StringBuilder();
            StringWriter tw = new StringWriter(sb);
            HtmlTextWriter hw = new HtmlTextWriter(tw);
            invoice.RenderControl(hw);
            var HtmlString = sb.ToString();

            // Create PDF Generator
            doc = new PdfDocument();

            // Add Pages
            PdfPage page = doc.Pages.Add();

            PdfUnitConvertor convertor = new PdfUnitConvertor();

            float width = convertor.ConvertToPixels(page.GetClientSize().Width, PdfGraphicsUnit.Point);
            float height = -1;

            using (HtmlConverter html = new HtmlConverter())
            {
                html.EnableHyperlinks = true;
                html.EnableActiveXContents = true;
                html.EnableJavaScript = true;
                using (HtmlToPdfResult result = html.Convert(HtmlString, "", ImageType.Metafile, (int)width, (int)height, AspectRatio.None))
                {
                    if (result != null)
                    {
                        PdfMetafile mf = new PdfMetafile(result.RenderedImage as Metafile);

                        PdfMetafileLayoutFormat format = new PdfMetafileLayoutFormat();
                        format.Break = PdfLayoutBreakType.FitPage;
                        format.Layout = PdfLayoutType.Paginate;
                        format.SplitTextLines = false;
                        format.SplitImages = false;

                        result.Render(page, format);
                    }
                }
            }
        }

        #region webkit
        //  private void GeneratePdfWebkit(string html)
        //{
        //    //Create a PDF document
        //    PdfDocument document = new PdfDocument();

        //    //Set page margins and dimensions.
        //    //Sets landscape orientation for the pages.
        //    document.PageSettings.Orientation = PdfPageOrientation.Landscape;
        //    //Sets the margin for all the pages as 50 points.
        //    document.PageSettings.Margins.All = 50;
        //    document.PageSettings.Size = PdfPageSize.A4;

        //    //Add a page to the document
        //    PdfPage page = document.Pages.Add();

        //    PdfGraphics graphics = page.Graphics;
        //    //Creates a solid brush.
        //    PdfBrush brush = new PdfSolidBrush(Color.Black);
        //    //Sets the font.
        //    // PdfFont font = new PdfStandardFont(PdfFontFamily.Helvetica,14);

        //    //Get the width and height of the page – client size in pixels

        //    PdfUnitConvertor convertor = new PdfUnitConvertor();

        //    float width = convertor.ConvertToPixels(document.PageSettings.Width, PdfGraphicsUnit.Point);

        //    float height = convertor.ConvertToPixels(document.PageSettings.Height, PdfGraphicsUnit.Point);


        //    // Create layout format for Metafile.
        //    PdfMetafileLayoutFormat metafileFormat = new PdfMetafileLayoutFormat();
        //    metafileFormat.Break = PdfLayoutBreakType.FitPage;
        //    metafileFormat.Layout = PdfLayoutType.Paginate;
        //    metafileFormat.SplitTextLines = false;
        //    metafileFormat.SplitImages = false;


        //    //Initialize WebKit rendering Engine
        //    WebKitHtmlConverter renderer = new WebKitHtmlConverter();

        //    renderer.EnableHyperlinks = true;
        //    renderer.EnableJavaScript = true;
        //    //Need to provide Qt WebKit Binaries Path
        //    renderer.WebKitPath = @"QTBinaries";
        //    //Convert the URL/HTML string by providing the required width and          height.
        //    HtmlToPdfResult result = renderer.Convert(html, 500, 700);

        //    //Create a layout format to enable pagination
        //    PdfMetafileLayoutFormat format = new PdfMetafileLayoutFormat();
        //    //Fit the HTML conversion to the page
        //    format.Break = PdfLayoutBreakType.FitPage;
        //    //Enable document pagination
        //    format.Layout = PdfLayoutType.Paginate;
        //    //Disable text line break across pages
        //    format.SplitTextLines = true;
        //    //Disable image split across pages
        //    format.SplitImages = true;
        //    //Render the HTML content on the PDF page
        //    result.Render(page, format);


        //    // Save and close the document.
        //    document.Save(Server.MapPath( "~/Images/Receipt/Sample.pdf"));
        //    document.Close(true);
        //}
        #endregion

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }


        private void GeneratePdfString2()
        {
            // Create PDF Generator
            doc = new PdfDocument();

            // Add Pages
            PdfPage page = doc.Pages.Add();

            PdfUnitConvertor convertor = new PdfUnitConvertor();

            float width = convertor.ConvertToPixels(page.GetClientSize().Width, PdfGraphicsUnit.Point);
            float height = -1;

            using (HtmlConverter html = new HtmlConverter())
            {
                html.EnableHyperlinks = true;
                using (HtmlToPdfResult result = html.Convert(Request.Url.AbsoluteUri, ImageType.Metafile, (int)width, (int)height, AspectRatio.None))
                {
                    if (result != null)
                    {
                        PdfMetafile mf = new PdfMetafile(result.RenderedImage as Metafile);

                        PdfMetafileLayoutFormat format = new PdfMetafileLayoutFormat();
                        format.Break = PdfLayoutBreakType.FitPage;
                        format.Layout = PdfLayoutType.Paginate;
                        format.SplitTextLines = false;
                        format.SplitImages = false;

                        result.Render(page, format);
                    }
                }
            }
        }



        public void GeneratePdfFormatting()
        {

               // /Creates a new PDF document.
                PdfDocument document = new PdfDocument();
                //Accesses document information.       
                document.DocumentInformation.Author = "pranav";
                document.DocumentInformation.Title = "Test Pdf";
                document.DocumentInformation.Subject = "Monthly maintenance";
                document.DocumentInformation.Keywords = "XXX";
                document.DocumentInformation.Creator = "XXX";
                document.DocumentInformation.Producer = "XXX";

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

                string CalculationMethod = string.Empty;
                document.PageSettings.Margins.All = 50;
                //Set Header
                float Headerheight = ch.AddHeader(document, "HI", "Traders\n67, rue des Cinquante Otages,\nElgin,\nIndia.", Server.MapPath("~/Images/logo.png"));
                ch.AddFooter(document, "@Esquareinfotech.com");

          
       
            string ReceiptNo="111";
            string OwnerID="ANIL";
            string Date="1/1/2015 T0 2/1/2015";

            PdfLayoutResult result = ch.receiptInfo(graphics, page, ReceiptNo, OwnerID, Date, Headerheight);

      string ownerinfo = "Traders\n67, rA Type Panvel,\nPin-410206,\nIndia.";
      string PaymentDetail="Traders\n67, rA Type Panvel,\nPin-410206,\nIndia.";
      ch.OwnerandpaymentDetail(result, graphics, page, ownerinfo, PaymentDetail);
         




                //Hides viewer application's menu bar.
                document.ViewerPreferences.HideMenubar = true;
                //Hides viewer application's toolbar.
                document.ViewerPreferences.HideToolbar = true;
                //Shows user interface elements in the document's window (such as scroll bars and navigation controls).
                document.ViewerPreferences.HideWindowUI = false;
                //Displays one page at a time.
                document.ViewerPreferences.PageLayout = PdfPageLayout.SinglePage;
                //Uses default viewer application page mode.
                document.ViewerPreferences.PageMode = PdfPageMode.UseNone;
                //Saves the document.\\

          


                document.Save(Server.MapPath("~/Images/Receipt/Sample.pdf"));
                //Closes the document.
                document.Close(true);

        }



    }
}