using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyDAL;
using System.IO;
using Syncfusion.Pdf;
using Syncfusion.Pdf.Graphics;
using System.Text;

using EsquareMasterTemplate.Common;
using SocietyEntity;
using Syncfusion.Pdf.Security;
using EsquareMasterTemplate.PrintPdfReferemce;
using System.Net;
using System.Net.Mail;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
//using iTextSharp.tool.xml;

namespace EsquareMasterTemplate.Reports
{
    public partial class GenerateReceipt : System.Web.UI.Page
    {
        clsPaymentDAL objPaymentDAL = new clsPaymentDAL();
        clsReportDal objReportDal = new clsReportDal();
        clsReportParameterEntity objReport = new clsReportParameterEntity();
        CommonHelper ch = new CommonHelper();
        public Syncfusion.Pdf.PdfDocument doc = null;
        string Title, Description, Imagepath;
        string PropertyType = string.Empty;
        string MaintenanceID = string.Empty;
        string Option = string.Empty;
        char flag;
        float Headerheight;
        string PrimId = string.Empty;
        string BaseUrl = string.Empty;
        long societyId;
        int columncount, k;

        string GenerateTable = string.Empty;
        clsUserDAL objMainDal = new clsUserDAL();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        EncryptDecrypt encdec = new EncryptDecrypt();
        protected void Page_Load(object sender, EventArgs e)
        {
            Option = encdec.Decrypt(HttpUtility.UrlDecode(Request.QueryString["Opt"]));
            if (Option == "ViewBill")
            {
                PropertyType = encdec.Decrypt(HttpUtility.UrlDecode(Request.QueryString["P"]));
                MaintenanceID = encdec.Decrypt(HttpUtility.UrlDecode(Request.QueryString["MId"]));
                PrimId = "";
                flag = 'H';
                societyId = Int16.Parse(encdec.Decrypt(HttpUtility.UrlDecode(Request.QueryString["SID"])));
            }
            else
            {
                PropertyType = Convert.ToString(Request.QueryString["P"]);
                MaintenanceID = Convert.ToString(Request.QueryString["MId"]);
                flag = Convert.ToChar(Request.QueryString["flag"]);
                //   PrimId = Convert.ToString(Request.QueryString["PrimId"]) == "SD" ? GetPrimIdByFlatMaintainanceID(MaintenanceID, PropertyType) : Convert.ToString(Request.QueryString["PrimId"]);
                societyId = Int16.Parse(Request.QueryString["SID"]);
            }
            if (!IsPostBack)
            {
                HtmlTableGetMaintenancePaymentReceipt(PropertyType, MaintenanceID, flag, PrimId, societyId, "", Option);
            }
        }

        public void HtmlTableGetMaintenancePaymentReceipt(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId, string generate, string Opt)
        {
            DataSet ds = null;
            if (Option == "ViewBill")
            {
                ds = (DataSet)objPaymentDAL.GetMaintenancePaymentReceipt(PropertyType, MaintenanceID, societyId);
            }
            else
            {
                //Not Implemented
                //ds = (DataSet)objPaymentDAL.GenerateReceiptMonthly(PropertyType, MaintenanceID, flag, PrimId, societyId);
            }

            var SocietyName = string.Empty;
            var SocietyAddress = string.Empty;
            var VoucherNumber = string.Empty;
            var CBFNo = string.Empty;
            var Date = string.Empty;

            var PaymentMode = string.Empty;
            var ChequeNo = string.Empty;
            var BankName = string.Empty;
            var To = string.Empty;
            var Being = string.Empty;
            var PaidAmount = string.Empty;
            StringBuilder sb = new StringBuilder();
            sb.Append("<table bordercolor=\"white\" style=\"background-color:white\" width=\"589\" border=\"0\" style=\"width:589px;border:#FFFFFF;\" cellpadding=\"2\" bordercolor=\"white\" bgcolor=\"white\">");
            sb.Append("<tr>");
            sb.Append("<td width=\"589\" bordercolor=\"white\"  style=\"width:589px;border:#FFFFFF;\" >");
            sb.Append("<table width=\"589\" bordercolor=\"white\" style=\"width:589px;border:#FFFFFF;\" cellpadding=\"2\">");
            sb.Append("<tr>");
            sb.Append("<td width=\"589\" bordercolor=\"white\" style=\"width:589px;border:0px normal white;\" align=\"center\" valign=\"middle\">");
            SocietyName = string.IsNullOrWhiteSpace(ds.Tables[0].Rows[0]["SocietyName"].ToString()) == true ? "......................" : ds.Tables[0].Rows[0]["SocietyName"].ToString();
            SocietyAddress = string.IsNullOrWhiteSpace(ds.Tables[0].Rows[0]["SocietyAddress"].ToString()) == true ? "......................" : ds.Tables[0].Rows[0]["SocietyAddress"].ToString();

            sb.Append("<h2 style=\"font-size:16px;line-height:15px;text-transform: uppercase;\">" + SocietyName + "</h2>");
            sb.Append("<h3 style=\"font-size:16px\">" + SocietyAddress + "</h3>");

            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            // sb.Append("<hr>");
            sb.Append("<table width=\"589\" border=\"0\"  bordercolor=\"white\" style=\"width:589px; border:#FFFFFF\" cellpadding=\"2\">");
            sb.Append("<tr>");
            sb.Append("<td bordercolor=\"white\" width=\"295\" style=\"width:295px;border:0px normal white;\"></td>");
            sb.Append("<td bordercolor=\"white\" width=\"295\" style=\"width:295px;border:0px normal white;\">");
            if (ds.Tables[1].Rows.Count > 0)
            {
                VoucherNumber = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["VoucherNo"].ToString()) == true ? "................................" : ds.Tables[1].Rows[0]["VoucherNo"].ToString();
                CBFNo = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["CBFNo"].ToString()) == true ? "........................................" : ds.Tables[1].Rows[0]["CBFNo"].ToString();
                Date = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["Date"].ToString()) == true ? ".........................................." : ds.Tables[1].Rows[0]["Date"].ToString();
                PaymentMode = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["PaymentMode"].ToString()) == true ? "....................................." : ds.Tables[1].Rows[0]["PaymentMode"].ToString();
                ChequeNo = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["ChequeNo"].ToString()) == true ? "..................................................." : ds.Tables[1].Rows[0]["ChequeNo"].ToString();
                BankName = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["BankName"].ToString()) == true ? "....................................................." : ds.Tables[1].Rows[0]["BankName"].ToString();
                To = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["To"].ToString()) == true ? "............................................................................................................................................................." : ds.Tables[1].Rows[0]["To"].ToString();
                Being = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["Being"].ToString()) == true ? ".........................................................................................................................................................." + "<br/>" +
                  "........................................................................................................................................................................" : ds.Tables[1].Rows[0]["Being"].ToString();
                PaidAmount = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["PaidAmount"].ToString()) == true ? "............................................" : ds.Tables[1].Rows[0]["PaidAmount"].ToString();
            }
            else
            {
                VoucherNumber = "................................";
                CBFNo = "........................................";
                Date = ".........................................";
                PaymentMode = ".....................................";
                ChequeNo = "...................................................";
                BankName = ".....................................................";
                To = ".............................................................................................................................................................";
                Being = ".........................................................................................................................................................." + "<br/>" +
                  "........................................................................................................................................................................";
                PaidAmount = "............................................";
            }

            sb.Append("<table width=\"589\" border=\"0\" bordercolor=\"white\" align=\"right\" style=\"text-align:right\" cellpadding=\"2\">");
            sb.Append("<tr>");

            sb.Append("<td bordercolor=\"white\" align=\"right\" style=\"margin-right:30px;border:#FFFFFF;text-align:right\">");
            sb.Append("<p style=\"margin-right:30px;\"><span style=\"color:black;font-weight:bold\" >Voucher Number: </span> " + VoucherNumber + " </p></td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td bordercolor=\"white\" align=\"right\" style=\"margin-right:30px;border:#FFFFFF;text-align:right\">");
            sb.Append("<p style=\"margin-right:30px;\"><span style=\"color:black;font-weight:bold\" >CBF No: </span>" + CBFNo + " </p></td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td bordercolor=\"white\" align=\"right\" style=\"margin-right:30px;border:#FFFFFF;text-align:right\">");
            sb.Append("<p style=\"margin-right:30px;\"><span style=\"color:black;font-weight:bold\" >Date: </span> " + Date + " </p></td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");

            sb.Append("<table width=\"589\" bordercolor=\"white\" style=\"width:589px;\" border=\"0\" cellpadding=\"2\">");
            sb.Append("<tr>");
            sb.Append("<td width=\"589\" bordercolor=\"white\" bordercolor=\"white\"  style=\"width:589x\">");
            string paymentMode = string.Empty;
            if (ds.Tables[1].Rows[0]["PaymentMode"].ToString() == "Cheque")
            {
                paymentMode = " Paid By Cheque No";
            }
            else if (ds.Tables[1].Rows[0]["PaymentMode"].ToString() == "Cash")
            {
                paymentMode = " Paid In Cash";
            }
            else if (ds.Tables[1].Rows[0]["PaymentMode"].ToString() == "ECS")
            {
                paymentMode = " Paid By Bank";
            }
            else if (ds.Tables[1].Rows[0]["PaymentMode"].ToString() == "DD")
            {
                paymentMode = " Paid By DD";
            }

            sb.Append("<p style=\"padding:1px 0px 1px 5px;\"><span style=\"color:black;font-weight:bold\" > " + paymentMode + "  </span>" + ChequeNo + " <span style=\"color:black;font-weight:bold\" >  On bank: </span> " + BankName + " </p>");
            sb.Append("<p style=\"padding:1px 0px 1px 5px;\"><span style=\"color:black;font-weight:bold\" >Rs: </span> " + PaidAmount + " <span style=\"color:black;font-weight:bold\" > (Rupees : </span> ...........................................................................................................)</p>");
            sb.Append("<p style=\"padding:1px 0px 1px 5px;\"><span style=\"color:black;font-weight:bold\" >To : </span> " + To + "</p>");
            sb.Append("<p style=\"padding:1px 0px 1px 5px;\"><span style=\"color:black;font-weight:bold\" >Being : </span> " + Being + "<br/></p>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            sb.Append("</br>");
            sb.Append("</br>");
            sb.Append("<table width=\"589\" bordercolor=\"white\" style=\"width:589px;\" border=\"0\" cellpadding=\"2\">");
            sb.Append("<tr>");
            sb.Append("<td  width=\"295\" bordercolor=\"white\"  style=\"width:295px\">");
            sb.Append("<table width=\"350\" bordercolor=\"white\" style=\"width:295px;backgrond-color:white\" border=\"0\" cellpadding=\"1\">");
            sb.Append("<tr>");
            sb.Append("<td width=\"175\" height=\"50px\" valign=\"bottom\" bordercolor=\"white\"  style=\"width:175px\">");
            sb.Append("<span style=\"color:black;font-weight:bold\" >Chairman/Treasurer </span>");
            sb.Append("</td>");
            sb.Append("<td  width=\"175\" height=\"40px\" valign=\"bottom\" bordercolor=\"white\"  style=\"width:175px\">");
            sb.Append("<span style=\"color:black;font-weight:bold\" >Secretary/Jt Secretary </span>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td width=\"175\" valign=\"bottom\" bordercolor=\"white\"  style=\"width:175px\">");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Debit:  </span> ....................... A/c </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Debit: </span> ....................... A/c </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Debit: </span> ....................... A/c </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Debit: </span> ....................... A/c </p>");
            sb.Append("</td>");
            sb.Append("<td  width=\"175\" valign=\"top\" bordercolor=\"white\"  style=\"width:175px\">");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Rs: </span> .............................. </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Rs: </span> .............................. </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Rs: </span> .............................. </p>");
            sb.Append("<p><span style=\"color:black;font-weight:bold\" >Rs: </span> .............................. </p>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            sb.Append("</td>");
            sb.Append("<td  width=\"240\" height=\"100px\" align=\"center\" bordercolor=\"white\" style=\"width:240px;background-color:white\">");

            var Secretorysign = string.Empty;

            if (ds.Tables[0].Rows[0]["Secretorysign"].ToString() != "" && File.Exists(Server.MapPath("../" + ds.Tables[0].Rows[0]["Secretorysign"].ToString())) == true)
            {
                BaseUrl = ch.GetBaseURL();
                Secretorysign = BaseUrl + ds.Tables[0].Rows[0]["Secretorysign"].ToString();
                sb.Append("<p><img style=\"margin:10px 0px\" src =\"" + Secretorysign + "\"  style=\"margin-top:3px\" class=\"img-responsive\" alt=\"Logo\" /></p>");
            }
            else
            {
                Secretorysign = "";
            }

           

            sb.Append("<p> <label style=\"color:black;font-weight:bold\">Receiver Signature </label>  </p>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");


            invoice.InnerHtml = sb.ToString();
        }

        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {

            //invoice.RenderControl(hw);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            invoice.RenderControl(hw);
            string HTMLContent = sw.ToString();

            //  string HTMLContent = "<table class=\"table table-bordered\"><tbody><tr><td><span style=\"color:black;font-weight:bold;\">SR.NO : </span> 1-October</td><td><span  style=\"color:black;font-weight:bold;\">BILLING FOR THE PERIOD : </span>October-2015 </td></tr><tr><td><span style=\"color:black;font-weight:bold;\">FLAT NO : </span>Shree Shagun A- 101  </td><td><span style=\"color:black;font-weight:bold;\">BILL DATE: </span>31-October-2015  </td></tr><tr><td colspan=2><span  style=\"color:black;font-weight:bold;\">NAME: </span>Mr. Ajit Kumar Singh </td></tr></tbody></table></div><div class=\"table-responsive\"><table class=\"table table-bordered\"><tbody><tr class=\"text-center\" ><th>Sr No</th><th>Particulars</th><th class=\"text-center\">Amount</th></tr></tbody><tbody><tr><td class=\"text-center\"><span style=\"color:black;\">1 </span></td><td><span style=\"color:black;\">Monthly Maintenance Charges</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">1200</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 2 </span></td><td><span style=\"color:black;\">Non Occupancy Charges</span></td><td class=\"text-center\"><span  style=\"color:black;\">150</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 3 </span></td><td><span style=\"color:black;\">NOC Charges for Non Occupants</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 4 </span></td><td><span style=\"color:black;\">Sinking Fund</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\" ><span style=\"color:black;font-weight:bold;\">Total Of Billing Month</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center\">1350</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 5 </span></td><td><span style=\"color:black;\">Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">8250</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 6 </span></td><td><span style=\"color:black;\">Interest on Defaulted Dues</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 7 </span></td><td><span style=\"color:black;\">Credit Amount Balance Towards Society (Less Adjustment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\"><span style=\"color:black;font-weight:bold;\">Total Payment</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center;\">9600</span></td></tr></tbody></table>";

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + "PDFfile.pdf");
            // Response.AddHeader("content-disposition", "attachment;filename=" + "PDFfile.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(GetPDF(HTMLContent));
            Response.End();

        }

        public byte[] GetPDF(string pHTML)
        {
            byte[] bPDF = null;

            string serverpath = Server.MapPath("..") + @"\";
            BaseUrl = ch.GetBaseURL();
            StringBuilder sb = new StringBuilder();
            sb.Append(pHTML);
            sb.Replace(BaseUrl, serverpath);

            // MemoryStream ms = new MemoryStream();
            // StringReader sr = new StringReader(pHTML);


            // // 1: create object of a itextsharp document class
            // Document pdfDoc = new Document(PageSize.A4, 25, 25, 25, 25);

            // PdfWriter writer = PdfWriter.GetInstance(pdfDoc, ms);
            // pdfDoc.Open();
            // XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
            // pdfDoc.Close();


            //// htmlWorker.Parse(txtReader);
            // doc.Close();
            // // 6: close the document and the worker
            // //htmlWorker.EndDocument();
            // //htmlWorker.Close();


            MemoryStream ms = new MemoryStream();
            TextReader txtReader = new StringReader(sb.ToString());



            // 1: create object of a itextsharp document class
            Document doc = new Document(PageSize.A4, 10, 5, 25, 5);
            // Document doc = new Document(new Rectangle()); 

            //doc.AddAuthor("Micke Blomquist");
            doc.AddCreator("esquareinfotech.com");
            //doc.AddKeywords("PDF tutorial education");
            doc.AddSubject("Generate ");
            //doc.AddTitle("The document title - PDF creation using iTextSharp");


            // 2: we create a itextsharp pdfwriter that listens to the document and directs a XML-stream to a file
            PdfWriter oPdfWriter = PdfWriter.GetInstance(doc, ms);

            // 3: we create a worker parse the document
            HTMLWorker htmlWorker = new HTMLWorker(doc);

            // 4: we open document and start the worker on the document
            doc.Open();
            htmlWorker.StartDocument();

            // 5: parse the html into the document
            htmlWorker.Parse(txtReader);

            // 6: close the document and the worker
            htmlWorker.EndDocument();

            htmlWorker.Close();
            doc.Close();

            bPDF = ms.ToArray();

            return bPDF;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        public string sendmail(byte[] stream, string subject, string Email)
        {
            string output = string.Empty;
            string username = System.Configuration.ConfigurationManager.AppSettings.Get("userName");
            string host = System.Configuration.ConfigurationManager.AppSettings.Get("host");
            string password = System.Configuration.ConfigurationManager.AppSettings.Get("password");
            string from = System.Configuration.ConfigurationManager.AppSettings.Get("From");
            if (string.IsNullOrWhiteSpace(Email) != true)
            {
                StringBuilder mySB = new StringBuilder();

                MailMessage mMailMessage = new MailMessage();
                try
                {
                    // assign from address
                    mMailMessage.From = new MailAddress(from);

                    // assign to address

                    mMailMessage.Attachments.Add(new Attachment(new MemoryStream(stream), "Maintenanace.pdf"));
                    mMailMessage.To.Add(new MailAddress(Email));

                    //mMailMessage.To.Add(new MailAddress(""));

                    //set subject
                    mMailMessage.Subject = subject;

                    mySB.Append("<table cellpadding=0 bgcolor=#e1f5fc cellspacing=0 width=800 align=left>");
                    mySB.Append("<tr>");
                    mySB.Append("<td style=\"color:red;font-size:15px;margin-bottom:10px;\">");
                    mySB.Append("Monthly Maintenanac Bill from");
                    mySB.Append("</td></tr>");
                    mySB.Append("<tr>");
                    mySB.Append("<td align=left>");
                    mySB.Append("<font size=2 color=black face=verdana>");
                    mySB.Append(hdninfo.Value);
                    mySB.Append("</b>");
                    mySB.Append("</font>");
                    mySB.Append("</td></tr>");
                    mySB.Append("</table>");
                    mMailMessage.Body = mySB.ToString();
                    // check email type HTML or NOT
                    mMailMessage.IsBodyHtml = true;
                    // define new SMTP mail client
                    SmtpClient mSmtpClient = new SmtpClient();
                    mSmtpClient.Host = host;

                    mSmtpClient.Credentials = new NetworkCredential(username, password);
                    mMailMessage.Priority = MailPriority.High;

                    //send email using defined SMTP client
                    mSmtpClient.Send(mMailMessage);
                    output = "Mail Send Successfully";
                }
                catch
                {
                    output = "for technical reason , Sending mail Action Failed !";
                }
            }
            else
            {
                output = "Please Update Your Emaild Id !";
            }

            return output;
        }
        protected void btnSendmail_Click(object sender, EventArgs e)
        {
            // invoice.RenderControl(hw);
            string output = string.Empty;
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            string Email = string.Empty;
            invoice.RenderControl(hw);
            string HTMLContent = sw.ToString();

            //if (hdnEmail.Value == "" && txtEmail.Text != "")
            //{
            //    Email = txtEmail.Text;
            //}
            //else if (hdnEmail.Value != "" && txtEmail.Text == "")
            //{
            //    Email = hdnEmail.Value;
            //}
            //else if (hdnEmail.Value != "" && txtEmail.Text != "")
            //{

            //    Email = txtEmail.Text;
            //}


            // string HTMLContent = "<table class=\"table table-bordered\"><tbody><tr><td><span style=\"color:black;font-weight:bold;\">SR.NO : </span> 1-October</td><td><span  style=\"color:black;font-weight:bold;\">BILLING FOR THE PERIOD : </span>October-2015 </td></tr><tr><td><span style=\"color:black;font-weight:bold;\">FLAT NO : </span>Shree Shagun A- 101  </td><td><span style=\"color:black;font-weight:bold;\">BILL DATE: </span>31-October-2015  </td></tr><tr><td colspan=2><span  style=\"color:black;font-weight:bold;\">NAME: </span>Mr. Ajit Kumar Singh </td></tr></tbody></table></div><div class=\"table-responsive\"><table class=\"table table-bordered\"><tbody><tr class=\"text-center\" ><th>Sr No</th><th>Particulars</th><th class=\"text-center\">Amount</th></tr></tbody><tbody><tr><td class=\"text-center\"><span style=\"color:black;\">1 </span></td><td><span style=\"color:black;\">Monthly Maintenance Charges</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">1200</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 2 </span></td><td><span style=\"color:black;\">Non Occupancy Charges</span></td><td class=\"text-center\"><span  style=\"color:black;\">150</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 3 </span></td><td><span style=\"color:black;\">NOC Charges for Non Occupants</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 4 </span></td><td><span style=\"color:black;\">Sinking Fund</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\" ><span style=\"color:black;font-weight:bold;\">Total Of Billing Month</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center\">1350</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 5 </span></td><td><span style=\"color:black;\">Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">8250</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 6 </span></td><td><span style=\"color:black;\">Interest on Defaulted Dues</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 7 </span></td><td><span style=\"color:black;\">Credit Amount Balance Towards Society (Less Adjustment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\"><span style=\"color:black;font-weight:bold;\">Total Payment</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center;\">9600</span></td></tr></tbody></table>";

            Response.Clear();
            // Response.ContentType = "application/pdf";
            //  Response.AddHeader("content-disposition", "attachment;filename=" + "PDFfile.pdf");
            // Response.Cache.SetCacheability(HttpCacheability.NoCache);
            byte[] stream = GetPDF(HTMLContent);
            output = sendmail(stream, "Monthly Maintenanac Bill", Email);
            //   Response.Flush();
            // Response.End();
            message.InnerHtml = output;
            //  ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "'); <script>", false);
        }
    }
}







