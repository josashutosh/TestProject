using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using SocietyEntity;
using SocietyDAL;
using System.Data;
namespace EsquareMasterTemplate.Finance
{
    public partial class ResponseHandling : System.Web.UI.Page
    {
        clsPaymentDAL objPaymentDAL = new clsPaymentDAL();
        clsPaymentGetwayEntity objPayGetwayEntity = new clsPaymentGetwayEntity();
        string Amttype = string.Empty;
        string merc_hash = string.Empty;
        string order_id = string.Empty;
        double PaidAmount = 0.00;
        double Amount = 0.00;
        long societyId;
        char flag;
        string InfoPropertyType = string.Empty;
        string InfoMaintenanceID = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string[] merc_hash_vars_seq;
                string merc_hash_string = string.Empty;
              
                

                string hash_seq = "key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";

                if (Request.Form["status"] == "success")
                {
                    merc_hash_vars_seq = hash_seq.Split('|');
                    Array.Reverse(merc_hash_vars_seq);
                    merc_hash_string = ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];

                    foreach (string merc_hash_var in merc_hash_vars_seq)
                    {
                        merc_hash_string += "|";
                        merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");
                    }

                    if (Request.Form["productinfo"] != "")
                    {
                        //  Reque st.Form["productinfo"].ToString());
                        var productDetail = Newtonsoft.Json.JsonConvert.DeserializeObject<ProductInfo>(Request.Form["productinfo"]);
                        InfoPropertyType = productDetail.paymentParts[0].InfoPropertyType;
                        InfoMaintenanceID = productDetail.paymentParts[0].InfoMaintenanceID;
                        flag = productDetail.paymentParts[0].flag;
                        PaidAmount = productDetail.paymentParts[0].PaidAmount;
                        Amount = productDetail.paymentParts[0].Amount;
                        societyId = productDetail.paymentParts[0].SocietyId;
                    }
                    Response.Write(merc_hash_string);
                    //exit;
                    merc_hash = Generatehash512(merc_hash_string).ToLower();

                    if (merc_hash != Request.Form["hash"])
                    {
                        Response.Write("Hash value did not matched");
                    }
                    else
                    {
                        objPayGetwayEntity.PaymentDetailId = 0;
                        objPayGetwayEntity.PgType = Request.Form["PG_TYPE"];
                        objPayGetwayEntity.BankRefNumber = Request.Form["bank_ref_num"];
                        objPayGetwayEntity.BankCode = Request.Form["bankcode"];
                        objPayGetwayEntity.Error = Request.Form["error"];
                        objPayGetwayEntity.Status = Request.Form["status"];
                        objPayGetwayEntity.ErrorMessage = Request.Form["error_Message"];
                        objPayGetwayEntity.NameOnCard = Request.Form["name_on_card"];
                        objPayGetwayEntity.CardNumber = Request.Form["cardnum"];
                        objPayGetwayEntity.PayuMoneyId = Request.Form["payuMoneyId"];
                        objPayGetwayEntity.NetAmount = Request.Form["net_amount_debit"];
                        objPayGetwayEntity.Mode = Request.Form["mode"];
                        objPayGetwayEntity.addedon = Request.Form["addedon"];
                        objPayGetwayEntity.unmappedstatus = Request.Form["unmappedstatus"];
                        string PaymentDetailId = objPaymentDAL.InsertPaymentdetail(objPayGetwayEntity);
                        order_id = Request.Form["txnid"];
                        UpdateSuccessfulTrxnDetails(InfoPropertyType, InfoMaintenanceID, flag, PaidAmount, Amount, order_id, PaymentDetailId, societyId);
                        Response.Write("value matched");

                        //Hash value did not matched
                    }

                }

                else
                {

                    Response.Write("Hash value did not matched");
                    // osc_redirect(osc_href_link(FILENAME_CHECKOUT, 'payment' , 'SSL', null, null,true));

                }
            }

            catch (Exception ex)
            {
                Response.Write("<span style='color:red'>" + ex.Message + "</span>");

            }
        }

        private void UpdateSuccessfulTrxnDetails(string InfoPropertyType, string InfoMaintenanceID, char flag, double PaidAmount, double Amount, string order_id, string PaymentDetailId, long societyId)
        {
            try
            {
                int PrimId = objPaymentDAL.UpdateSuccessfulTrxnDetails(InfoPropertyType, InfoMaintenanceID, flag, PaidAmount, Amount, order_id, Convert.ToString(Session["LoginId"]), PaymentDetailId);
                if (PrimId > 0)
                {
                    GetPaymentReceiptDetails(InfoPropertyType, InfoMaintenanceID, flag, PrimId, societyId);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<span style='color:red'>" + ex.Message + "</span>");
            }
        }

        private void GetPaymentReceiptDetails(string PropertyType, string MaintenanceID, char flag, int PrimId, long societyId)
        {
            try
            {
               Response.Redirect("~/Reports/ReportsHome.aspx?P=" + PropertyType + "&MId=" + MaintenanceID + "&Flag=" + flag + "&PrimId=" + PrimId + "&SId=" + societyId);
            }
            catch (Exception ex)
            {
                Response.Write("<span style='color:red'>" + ex.Message + "</span>");
            }
        }

        public string Generatehash512(string text)
        {

            byte[] message = Encoding.UTF8.GetBytes(text);

            UnicodeEncoding UE = new UnicodeEncoding();
            byte[] hashValue;
            SHA512Managed hashString = new SHA512Managed();
            string hex = "";
            hashValue = hashString.ComputeHash(message);
            foreach (byte x in hashValue)
            {
                hex += String.Format("{0:x2}", x);
            }
            return hex;

        }


    }

}