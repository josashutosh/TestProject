using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Syncfusion.Pdf;
using Syncfusion.Pdf.Graphics;
using System.Text;
using System.Data;
using SocietyDAL;
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
using System.Security;
using System.Security.Permissions;


namespace EsquareMasterTemplate.Reports
{
    public partial class MonthlyBillReceipt : System.Web.UI.Page
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
                PrimId = Convert.ToString(Request.QueryString["PrimId"]) == "SD" ? GetPrimIdByFlatMaintainanceID(MaintenanceID, PropertyType) : Convert.ToString(Request.QueryString["PrimId"]);
                societyId = Int16.Parse(Request.QueryString["SID"]);
            }
            if (!IsPostBack)
            {
                HtmlTableGenerateReceipt(PropertyType, MaintenanceID, flag, PrimId, societyId, "", Option);
            }

            // GeneratePdfFormatting(PropertyType, MaintenanceID, flag, PrimId, societyId, "", Option);
        }


        public void HtmlTableGenerateReceipt(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId, string generate, string Opt)
        {
            DataSet ds = null;
            if (Option == "ViewBill")
            {
                ds = (DataSet)objPaymentDAL.GenerateMonthlyBill(PropertyType, MaintenanceID, societyId);
            }
            else
            {
                ds = (DataSet)objPaymentDAL.GenerateReceiptMonthly(PropertyType, MaintenanceID, flag, PrimId, societyId);
            }

            string logo=string.Empty, Address, genetable = string.Empty;

            StringBuilder receipt = new StringBuilder();


            StringBuilder sb = new StringBuilder();
            sb.Append("Hi " + ds.Tables[1].Rows[0]["OwnerName1"].ToString() + "<br/>");
            sb.Append("Society Name: " + ds.Tables[4].Rows[0]["SocietyName"].ToString() + "<br/>");
            sb.Append("Flat Number: " + ds.Tables[1].Rows[0]["FlatNumber"].ToString() + "<br/>");
            sb.Append("Maintenance Date: " + ds.Tables[2].Rows[0]["EffectiveFromDate"].ToString() + " To " + ds.Tables[2].Rows[0]["EffectiveToDate"].ToString() + "<br/>");
            sb.Append("Property Type: " + ds.Tables[1].Rows[0]["PropertyType"].ToString() + "<br/>");
            hdninfo.Value = sb.ToString();

            hdnEmail.Value = string.IsNullOrWhiteSpace(ds.Tables[1].Rows[0]["EmailId"].ToString()) == true ? "" : ds.Tables[1].Rows[0]["EmailId"].ToString();

            BaseUrl = ch.GetBaseURL();

            if (ds.Tables[4].Rows[0]["Logo"].ToString() != "" && File.Exists(Server.MapPath("../" + ds.Tables[4].Rows[0]["Logo"].ToString())) == true)
            {
                logo = BaseUrl + ds.Tables[4].Rows[0]["Logo"].ToString();
            }
            else
            {
                //logo = BaseUrl + "Images/logo.png";
                logo = "";
            }
            string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            Address = ds.Tables[4].Rows[0]["SocietyAddress"].ToString();
            if (Address != "")
            {
                Address = Address.Replace(",", ",\n");
            }


            receipt.Append("<table width=\"564\" border=\"0\" style=\"border:#FFFFFF\" bordercolor=\"#FFFFFF\" bgcolor=\"#FFFFFF\">");
            receipt.Append("<tr>");
            receipt.Append("<td bordercolor=\"#FFFFFF\" style=\"border:#FFFFFF\"  bgcolor=\"#FFFFFF\">");
            receipt.Append("<table width=\"564\" border=\"0\">");
            receipt.Append("<tr><td width=\"200\" border=\"0\" style=\"color:black; border:#FFFFFF;width:200px\">");

            if (logo == "" || logo == null)
            {
                receipt.Append("");
            }
            else
            {
                receipt.Append("<img src =\"" + logo + "\"  style=\"margin-top:3px\" class=\"img-responsive\" alt=\"Logo\" />");

            }

            receipt.Append("</td>");
            //receipt.Append("<td width=\"102\" border=\"0\" style=\"color:black;style=\"border:#FFFFFF\"></td>");
            receipt.Append("<td width=\"552\" border=\"0\" style=\"border:#FFFFFF;text-align:right;\" ><p style=\"font-size:17px;color:black;font-weight:bold;\">" + ds.Tables[4].Rows[0]["SocietyName"].ToString() + "</p><p style=\"font-size:15px;color:black;\">" + ds.Tables[4].Rows[0]["SocietyAddress"].ToString() + "</p></td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("");
            receipt.Append("<table width=\"564\" border=\"1\">");
            receipt.Append("<tr>");
            string srNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNo"]) + "/" + Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]).Substring(0, 3);
            string BillingForPeriod = Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]) + "-" + Convert.ToString(ds.Tables[2].Rows[0]["Year"]);
            string FlatNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNumber"]);
            string Ownername = Convert.ToString(ds.Tables[1].Rows[0]["OwnerName1"]);
            string BillDate = Convert.ToString(ds.Tables[1].Rows[0]["BillDate"]) + "-" + BillingForPeriod;


            receipt.Append("<td bordercolor=\"#666666\"><div align=\"justify\"><span style=\"color:black;font-weight:bold\" >Sr No : </span>" + srNo + "</div></td>");
            receipt.Append("<td><span class=\"style3\"><span style=\"color:black;font-weight:bold\" >Billing For The Period : </span>" + BillingForPeriod + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr bordercolor=\"#666666\">");
            receipt.Append("<td><span style=\"color:black;font-weight:bold\" >Flat No : </span>" + FlatNo + "</td>");
            receipt.Append("<td><span style=\"color:black;font-weight:bold\" >Bill Date : </span> " + BillDate + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td colspan=\"2\"><span style=\"color:black;font-weight:bold\" >Name : </span> " + Ownername + "</td>");
            receipt.Append("  ");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td colspan=\"2\" border=\"0\" bordercolor=\"#FFFFFF\"><span style=\"color:black;font-weight:bold\" >&nbsp;&nbsp;</span></td>");
            receipt.Append("</tr>");

            receipt.Append("</table>");



            receipt.Append("<table width=\"564\" border=\"1\" bordercolor=\"#FFFFFF\">");
            receipt.Append("<tr>");
            receipt.Append("<td nowrap bordercolor=\"#F0F0F0\"  bgcolor=\"#993300\"><h3 align=\"center\" style=\"color:#ffffff;font-size:15px\">Monthly Maintenance Bill</h3></td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("<table width=\"100%\" border=\"1\">");
            receipt.Append("<tr>");
            receipt.Append("<th width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Sr No</th>");
            receipt.Append("<th width=\"70%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Particulars</th>");
            receipt.Append("<th width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Amount</th>");
            receipt.Append("</tr>");

            dynamic MonthlyCharge = ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString();
            dynamic NonOccupencyCharge = ds.Tables[2].Rows[0]["TenantMaintenance"].ToString();
            dynamic NOCChargesforNonOccupants = ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString();
            dynamic SinkingFund = ds.Tables[2].Rows[0]["SinkingFund"].ToString();

            dynamic TOTALBILLINGMONTH=0.00, FMonthlyCharge, FNonOccupencyCharge, FNOCChargesforNonOccupants, FSinkingFund;
            if (MonthlyCharge == "--")
            {

                FMonthlyCharge = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + FMonthlyCharge;
                FMonthlyCharge = MonthlyCharge;
            }
            else
            {
                FMonthlyCharge = string.Format("{0:0.00}", float.Parse(MonthlyCharge.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FMonthlyCharge.ToString());
            }
            if (NonOccupencyCharge == "--")
            {
                FNonOccupencyCharge = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNonOccupencyCharge.ToString());
                FNonOccupencyCharge = NonOccupencyCharge;

            }
            else
            {
                FNonOccupencyCharge = string.Format("{0:0.00}", float.Parse(NonOccupencyCharge.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNonOccupencyCharge.ToString());
            }


            if (NOCChargesforNonOccupants == "--")
            {
                FNOCChargesforNonOccupants = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNOCChargesforNonOccupants.ToString());
                FNOCChargesforNonOccupants = NOCChargesforNonOccupants;
            }
            else
            {
                FNOCChargesforNonOccupants = string.Format("{0:0.00}", float.Parse(NOCChargesforNonOccupants.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNOCChargesforNonOccupants.ToString());
            }


            if (SinkingFund == "--")
            {
                FSinkingFund = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FSinkingFund.ToString());
                FSinkingFund = SinkingFund;
            }
            else
            {
                FSinkingFund = string.Format("{0:0.00}", float.Parse(SinkingFund.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FSinkingFund.ToString());
            }



            

            dynamic DuePayment = ds.Tables[2].Rows[0]["OutstandingAmount"].ToString();
            dynamic InterestonDefaulted = "--";//float.Parse(ds.Tables[2].Rows[0]["InterestRate"].ToString())
            dynamic CreditAmountBalance = ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString();

            dynamic TotalPayment=0.00,FDuePayment, FInterestonDefaulted, FCreditAmountBalance;
            if (DuePayment == "--")
            {
                FDuePayment = string.Format("{0:0.00}", 0);
                TotalPayment = float.Parse(TOTALBILLINGMONTH.ToString())  + float.Parse(FDuePayment.ToString());
                FDuePayment = DuePayment;
            }
            else
            {
                FDuePayment = string.Format("{0:0.00}", float.Parse(DuePayment.ToString()));
                TotalPayment = float.Parse(TOTALBILLINGMONTH.ToString()) + float.Parse(FDuePayment.ToString());
            }

            if (InterestonDefaulted == "--")
            {
                FInterestonDefaulted = string.Format("{0:0.00}", 0);
                TotalPayment = TotalPayment + float.Parse(FInterestonDefaulted.ToString());
                FInterestonDefaulted = InterestonDefaulted;
            }
            else
            {
                FInterestonDefaulted = string.Format("{0:0.00}", float.Parse(InterestonDefaulted.ToString()));
                TotalPayment = TotalPayment + float.Parse(FInterestonDefaulted.ToString());
            }

            if (CreditAmountBalance == "--")
            {
                FCreditAmountBalance = string.Format("{0:0.00}", 0);
                TotalPayment = TotalPayment + float.Parse(FCreditAmountBalance.ToString());
                FCreditAmountBalance = CreditAmountBalance;
            }
            else
            {
                FCreditAmountBalance = string.Format("{0:0.00}", float.Parse(CreditAmountBalance.ToString()));
                TotalPayment = TotalPayment + float.Parse(FCreditAmountBalance.ToString());
            }


           

            receipt.Append("<tr>");
            receipt.Append("<td  width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >1</span></td>");
            receipt.Append("<td  width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Monthly Maintenance Charges  </span></td>");
            receipt.Append("<td  width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FMonthlyCharge + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >2</span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Non Occupancy Charges  </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FNonOccupencyCharge + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >3</span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >NOC Charges for Non Occupants  </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FNOCChargesforNonOccupants + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >4 </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Sinking Fund </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FSinkingFund + " </span></td>");
            receipt.Append("</tr>");



            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" > </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"  style=\"color:black; text-align: right; font-weight:bold; padding:1px 5px;\"><span>Total Of Billing Month</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"color:black;text-align:center; padding:1px 5px;\"><span  >" + string.Format("{0:0.00}", string.Format("{0:0.00}", float.Parse(TOTALBILLINGMONTH.ToString()))) + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >5  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FDuePayment + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >6  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Interest on Defaulted Dues</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FInterestonDefaulted + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >7  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Credit Amount Balance Towards Society (Less Adjustment)</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FCreditAmountBalance + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" > </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"  style=\"color:black; text-align: right; font-weight:bold; padding:1px 5px;\"><span>Total Payment</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"color:black;text-align:center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + string.Format("{0:0.00}", float.Parse(TotalPayment.ToString())) + " </span></td>");
            receipt.Append("</tr>");

            string Registrationnumber = ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();
            string Notes = ds.Tables[4].Rows[0]["ReceiptNotes"].ToString().Replace("|", "<br/>");

            receipt.Append("</table>");
            receipt.Append("<table width=\"564\" border=\"0\">");
            receipt.Append("<tr>");
            receipt.Append("<td bordercolor=\"#FFFFFF\"  bgcolor=\"#FFFFFF\"><span style=\"color:red;\">Notes:</span></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td>" + Notes + "</td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("<table bordercolor=\"#FFFFFF\" width=\"100%\" border=\"1\">");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\"></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\"  style=\"text-align:right;background-color:#FFFFFF;padding-right:10px;\" >" + SocietyName + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\"></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF;font-size:15px;color:black;font-weight:bold;text-align:right; padding-right:10px;\"> <p>Manager/Secretary/Treasurer/Chairman</p></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("</tr>");
            receipt.Append("</table></td></tr></table>");

            invoice.InnerHtml = receipt.ToString();
        }




        public void HtmlGenerateReceipt(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId, string generate, string Opt)
        {
            DataSet ds = null;
            if (Option == "ViewBill")
            {
                ds = (DataSet)objPaymentDAL.GenerateMonthlyBill(PropertyType, MaintenanceID, societyId);
            }
            else
            {
                ds = (DataSet)objPaymentDAL.GenerateReceiptMonthly(PropertyType, MaintenanceID, flag, PrimId, societyId);
            }

            string logo, Address, genetable = string.Empty;



            StringBuilder receipt = new StringBuilder();
            #region Generate Logo
            BaseUrl = ch.GetBaseURL();
            if (ds.Tables[4].Rows[0]["Logo"].ToString() != "" && File.Exists(Server.MapPath("../" + ds.Tables[4].Rows[0]["Logo"].ToString())) == true)
            {
                logo = BaseUrl + ds.Tables[4].Rows[0]["Logo"].ToString();
            }
            else
            {
                //logo = BaseUrl + "Images/logo.png";
                logo = "";
            }
            string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            Address = ds.Tables[4].Rows[0]["SocietyAddress"].ToString();
            if (Address != "")
            {
                Address = Address.Replace(",", ",\n");
            }

            receipt.Append("<div class=\"row invoice-logo\"><div class=\"col-xs-4 invoice-logo-space\">");
            if (logo == "" || logo == null)
            {
                receipt.Append("");
            }
            else
            {
                receipt.Append("< img src =\"" + logo + "\"  style=\"margin-top:3px\" class=\"img-responsive\" alt=\"Logo\">");

            }
            receipt.Append("</td>");
            receipt.Append("<div class=\"col-xs-8\" style=\"text-align:right;padding-right:30px;\"><p>");
            receipt.Append("<p style=\"font-size:17px;color:black;font-weight:bold;\">" + ds.Tables[4].Rows[0]["SocietyName"].ToString() + "</p>");
            receipt.Append("<p style=\"font-size:15px;color:black;\">" + ds.Tables[4].Rows[0]["SocietyAddress"].ToString() + "</p>");
            receipt.Append("</p></div></div><hr>");
            #endregion

            receipt.Append("<div class=\"alert alert-success\" style=\"color:White;background-color:#A66A6B;text-align:center;font-weight:bold;font-size:18px;\"><strong>Monthly Maintenanac Bill </div>");

            string srNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNo"]) + "/" + Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]);
            string BillingForPeriod = Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]) + "-" + Convert.ToString(ds.Tables[2].Rows[0]["Year"]);
            string FlatNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNumber"]);
            string Ownername = Convert.ToString(ds.Tables[1].Rows[0]["OwnerName1"]);
            string BillDate = Convert.ToString(ds.Tables[1].Rows[0]["BillDate"]) + "-" + BillingForPeriod;

            receipt.Append("<div class=\"table-responsive\"><table class=\"table table-bordered\">");
            receipt.Append(" <tbody><tr><td><span style=\"color:black;font-weight:bold;\">Sr.No : </span> " + srNo + "</td>");
            receipt.Append("<td> <span  style=\"color:black;font-weight:bold;\">Billing For The Period : </span>" + BillingForPeriod + " </td></tr>");
            receipt.Append("<tr><td> <span style=\"color:black;font-weight:bold;\">Flat No : </span>" + FlatNo + " </td>");
            receipt.Append("<td> <span style=\"color:black;font-weight:bold;\">Bill Date: </span>" + BillDate + " </td></tr>");
            receipt.Append(" <tr><td colspan=2>  <span  style=\"color:black;font-weight:bold;\">Name: </span>" + Ownername + " </td> </tr></tbody></table> </div>");






            float MonthlyCharge = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString());
            float NonOccupencyCharge = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["TenantMaintenance"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["TenantMaintenance"].ToString());
            float NOCChargesforNonOccupants = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString());
            float SinkingFund = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["SinkingFund"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["SinkingFund"].ToString());
            float TOTALBILLINGMONTH = MonthlyCharge + NonOccupencyCharge + NOCChargesforNonOccupants + SinkingFund;
            float DuePayment = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["OutstandingAmount"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["OutstandingAmount"].ToString()); ;
            float InterestonDefaulted = 0;//float.Parse(ds.Tables[2].Rows[0]["InterestRate"].ToString())
            float CreditAmountBalance = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString());
            float TotalPayment = TOTALBILLINGMONTH + DuePayment + CreditAmountBalance;

            receipt.Append("<div class=\"table-responsive\"><table class=\"table table-bordered\">");
            receipt.Append("<tbody><tr class=\"text-center\" ><th>Sr No</th><th>Particulars</th><th class=\"text-center\">Amount</th></tr></tbody>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\">1 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Monthly Maintenance Charges</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + MonthlyCharge + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 2 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Non Occupancy Charges</span></td>");
            receipt.Append("<td class=\"text-center\"> <span  style=\"color:black;\">" + NonOccupencyCharge + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 3 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">NOC Charges for Non Occupants</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + NOCChargesforNonOccupants + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 4 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Sinking Fund</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + SinkingFund + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td><span style=\"color:black;font-weight:bold;\">  </span></td>");
            receipt.Append("<td style=\"text-align:right\" ><span style=\"color:black;font-weight:bold;\">Total Of Billing Month</span></td>");
            receipt.Append("<td style=\"text-align:center\"> <span  style=\"color:black;font-weight:bold;text-align:center\">" + TOTALBILLINGMONTH + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 5 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + DuePayment + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 6 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Interest on Defaulted Dues</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + InterestonDefaulted + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 7 </span></td>");
            receipt.Append("<td><span style=\"color:black;\">Credit Amount Balance Towards Society (Less Adjustment)</span></td>");
            receipt.Append("<td class=\"text-center\"> <span style=\"color:black\" style=\"color:black;\">" + CreditAmountBalance + "</span> </td></tr>");

            receipt.Append("<tbody><tr><td><span style=\"color:black;font-weight:bold;\">  </span></td>");
            receipt.Append("<td style=\"text-align:right\"><span style=\"color:black;font-weight:bold;\">Total Payment</span></td>");
            receipt.Append("<td style=\"text-align:center\"> <span  style=\"color:black;font-weight:bold;text-align:center;\">" + TotalPayment + "</span> </td></tr></tbody></table></div>");


            #region Footer
            string Registrationnumber = ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();
            string Notes = ds.Tables[4].Rows[0]["ReceiptNotes"].ToString().Replace("|", "<br/>");
            receipt.Append("<div class=\"row\"><div class=\"col-xs-12\"><div style=\"background-color:white\" class=\"well\">");
            if (ds.Tables[4].Rows[0]["RegistrationNumber"].ToString() != "")
            {
                receipt.Append("<span Style=\"Color:red\">Notes :</span><br/>");
            }
            receipt.Append("<address>" + Notes + "</address></div>	</div>");

            //  receipt.Append("	<div class=\"col-xs-8 invoice-block\">" + Address + "<br>");
            receipt.Append("<div style=\" text-align:right; padding-right:105px;\" class=\"col-xs-12\">For " + SocietyName + " </div>");

            string secretorySign;
            //if (ds.Tables[4].Rows[0]["Secretorysign"].ToString() != "" && File.Exists(Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString())) == true)
            //{
            //    secretorySign = BaseUrl + ds.Tables[4].Rows[0]["Secretorysign"].ToString();
            //    receipt.Append("<div style=\" text-align:right; padding-right:100px;\" class=\"col-xs-12\"><img    src=\"" + secretorySign + "\" width=\"200\" Height=\"45\"  style=\"margin-top:3px; float:right;width:200px; height:50px;\" class=\"img-responsive\" alt=\"secretorySign\" ></div> <br/>");
            //}
            //else
            //{
            //    //<!--a class=\"btn btn-lg blue hidden-print \" onclick=\"javascript:window.print();\">Print <i class=\"fa fa-print\"></i></a-->
            //    receipt.Append("<div style=\" text-align:right; padding-right:55px;\" class=\"col-xs-12\">No Sign Available </div><br/>");
            //}

            receipt.Append("<div style=\" text-align:right; padding-right:55px;\" class=\"col-xs-12\"><p style=\"font-size:15px;color:black;font-weight:bold;text-align:right \">Manager/Secretary/Treasurer/Chairman</p></div>");


            receipt.Append("</div></div>");

            #endregion

            invoice.InnerHtml = receipt.ToString();
        }



        private string GetPrimIdByFlatMaintainanceID(string MaintenanceID, string PropertyType)
        {
            objReport.FlatmaintenanceId = MaintenanceID;
            objReport.PropertyType = PropertyType;
            return objReportDal.GetPrimIdByFlatMaintainanceID(objReport);
        }

        //protected void Generatepdf_Click(object sender, EventArgs e)
        //{
        //    GeneratePdfFormatting(PropertyType, MaintenanceID, flag, PrimId, societyId, "");
        //}

        public void GeneratePdfFormatting(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId, string generate, string Opt)
        {
            DataSet ds = null;
            if (Option == "ViewBill")
            {
                ds = (DataSet)objPaymentDAL.GenerateMonthlyBill(PropertyType, MaintenanceID, societyId);
            }
            else
            {
                ds = (DataSet)objPaymentDAL.GenerateReceiptMonthly(PropertyType, MaintenanceID, flag, PrimId, societyId);
            }

            //create an object reference for the Serviceclient


            PdfLayoutResult result;
            // /Creates a new PDF document.
            Syncfusion.Pdf.PdfDocument document = new Syncfusion.Pdf.PdfDocument();
            //Accesses document information.       
            document.DocumentInformation.Author = ds.Tables[1].Rows[0]["OwnerName1"].ToString();
            //document.DocumentInformation.Title = ds.Tables[2].Rows[0]["CalculationMethod"].ToString() + " - " + ds.Tables[1].Rows[0]["OwnerName1"].ToString();
            // document.DocumentInformation.Subject = ds.Tables[2].Rows[0]["CalculationMethod"].ToString();
            document.DocumentInformation.Keywords = "XXX";
            document.DocumentInformation.Creator = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            document.DocumentInformation.Producer = ds.Tables[4].Rows[0]["SocietyName"].ToString();

            //Adds a page to the document.
            Syncfusion.Pdf.PdfPage page = document.Pages.Add();
            //Sets landscape page orientation.
            document.PageSettings.Orientation = PdfPageOrientation.Landscape;
            // Sets the page size.
            document.PageSettings.Size = PdfPageSize.A4;

            //Creates PDF graphics for the page.
            PdfGraphics graphics = page.Graphics;
            //Sets the font.
            Syncfusion.Pdf.Graphics.PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12);

            document.PageSettings.Margins.All = 25;
            //Set Header

            if (ds.Tables[4].Rows.Count > 0)
            {
                string Logo=string.Empty, AddressRegistrationNumber;
                string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString() == "" ? "-" : ds.Tables[4].Rows[0]["SocietyName"].ToString();
                AddressRegistrationNumber = ds.Tables[4].Rows[0]["SocietyAddress"].ToString() + "," + ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();
                if (AddressRegistrationNumber != "")
                {
                    AddressRegistrationNumber = AddressRegistrationNumber.Replace(",", ",\n");
                }

                if (File.Exists(Server.MapPath("../" + ds.Tables[4].Rows[0]["Logo"].ToString())) == true && "../" + ds.Tables[4].Rows[0]["Logo"].ToString() != "")
                {
                    Logo = "../" + ds.Tables[4].Rows[0]["Logo"].ToString();
                }
                else
                {
                    // Logo = "~/Images/logo.png";
                    Logo = "";
                }

                Headerheight = ch.AddHeader(document, SocietyName, AddressRegistrationNumber, Server.MapPath(Logo));
            }
            ch.AddFooter(document, "@Esquareinfotech.com");

            string Date = ds.Tables[2].Rows[0]["EffectiveFromDate"].ToString();
            string CalculationMethod = ds.Tables[2].Rows[0]["CalculationMethod"].ToString();
            result = ch.receiptInfoMonthy(graphics, page, CalculationMethod, Date, "Monthly Maintenance Bill", Headerheight);


            // DataSet ds = (DataSet)objMainDal.GetCountryList();
            GenerateTable = "Yes";

            columncount = 2;


            result = ch.BasicBillInfo(result, graphics, page, ds, GenerateTable, columncount, k);

            columncount = 3;
            result = ch.InsertAmountDetail(result, graphics, page, ds, GenerateTable, columncount, k);

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
                document.Security.KeySize = PdfEncryptionKeySize.Key128Bit;
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
                //var client = new PrintPdfService.PrintPdfServiceClient("BasicHttpBinding_Service1");
                MemoryStream memoryStream = new MemoryStream();
                document.Save(memoryStream);
                byte[] byteArray = memoryStream.ToArray();
                //call the PrintService method in the service with byte array as parameter
                client.PrintService(byteArray);
            }


            #endregion

            //Closes the document.
            document.Close(true);

        }

        protected void btnGeneratePdf_Click(object sender, EventArgs e)
        {

            // invoice.RenderControl(hw);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            invoice.RenderControl(hw);
            string HTMLContent = sw.ToString();

            // string HTMLContent = "<table class=\"table table-bordered\"><tbody><tr><td><span style=\"color:black;font-weight:bold;\">SR.NO : </span> 1-October</td><td><span  style=\"color:black;font-weight:bold;\">BILLING FOR THE PERIOD : </span>October-2015 </td></tr><tr><td><span style=\"color:black;font-weight:bold;\">FLAT NO : </span>Shree Shagun A- 101  </td><td><span style=\"color:black;font-weight:bold;\">BILL DATE: </span>31-October-2015  </td></tr><tr><td colspan=2><span  style=\"color:black;font-weight:bold;\">NAME: </span>Mr. Ajit Kumar Singh </td></tr></tbody></table></div><div class=\"table-responsive\"><table class=\"table table-bordered\"><tbody><tr class=\"text-center\" ><th>Sr No</th><th>Particulars</th><th class=\"text-center\">Amount</th></tr></tbody><tbody><tr><td class=\"text-center\"><span style=\"color:black;\">1 </span></td><td><span style=\"color:black;\">Monthly Maintenance Charges</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">1200</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 2 </span></td><td><span style=\"color:black;\">Non Occupancy Charges</span></td><td class=\"text-center\"><span  style=\"color:black;\">150</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 3 </span></td><td><span style=\"color:black;\">NOC Charges for Non Occupants</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 4 </span></td><td><span style=\"color:black;\">Sinking Fund</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\" ><span style=\"color:black;font-weight:bold;\">Total Of Billing Month</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center\">1350</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 5 </span></td><td><span style=\"color:black;\">Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">8250</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 6 </span></td><td><span style=\"color:black;\">Interest on Defaulted Dues</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td class=\"text-center\"><span style=\"color:black;\"> 7 </span></td><td><span style=\"color:black;\">Credit Amount Balance Towards Society (Less Adjustment)</span></td><td class=\"text-center\"><span style=\"color:black\" style=\"color:black;\">0</span></td></tr><tbody><tr><td><span style=\"color:black;font-weight:bold;\"></span></td><td style=\"text-align:right\"><span style=\"color:black;font-weight:bold;\">Total Payment</span></td><td style=\"text-align:center\"><span  style=\"color:black;font-weight:bold;text-align:center;\">9600</span></td></tr></tbody></table>";

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
            doc.AddSubject("Monthly Maintenanac Bill ");
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

            if (hdnEmail.Value == "" && txtEmail.Text != "")
            {
                Email = txtEmail.Text;
            }
            else if (hdnEmail.Value != "" && txtEmail.Text == "")
            {
                Email = hdnEmail.Value;
            }
            else if (hdnEmail.Value != "" && txtEmail.Text != "")
            {

                Email = txtEmail.Text;
            }


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