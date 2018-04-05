using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using SocietyEntity;
using SocietyDAL;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;

namespace EsquareMasterTemplate.Finance
{
    public partial class RechargeWallet : System.Web.UI.Page
    {
        clsRechargeWalletEntity objRewallet = new clsRechargeWalletEntity();
        clRechargeWalletDAL objRewalletDal = new clRechargeWalletDAL();
        public string action1 = string.Empty;
        public string hash1 = string.Empty;
        public string txnid1 = string.Empty;
        string maintenanceId;
        string Mainamount, MName, MEmail, MPhone, surl, furl, productinfoinfoJeson, message;
        char flag;
        string propertytype;

        protected void Page_Load(object sender, EventArgs e)
        {
            ShowHideControls();
            try
            {
                key.Value = ConfigurationManager.AppSettings["MERCHANT_KEY"];

                if (!IsPostBack)
                {
                    ExpressionBindingCollection();
                }
                else
                {

                }
                if (string.IsNullOrEmpty(Request.Form["hash"]))
                {
                    btnMakePayment.Visible = true;
                }
                else
                {
                    btnMakePayment.Visible = false;
                }
            }
            catch (Exception)
            {
                throw;
            }

        }

        private void ShowHideControls()
        {
            if (Convert.ToString(Request.QueryString["Opt"]) == "R")
            {
                OtherMaintenanceInfo.Style.Add("display", "inline");
                Amount.Style.Add("display", "inline");
            }
            else if (Convert.ToString(Request.QueryString["Opt"]) == "O")
            {
                maintenanceId = Request.QueryString["Mid"].ToString();
                propertytype = Convert.ToString(Request.QueryString["Ptype"].ToString());
                OutstandingMaintenanceInfo.Style.Add("display", "inline");
                Amount.Style.Add("display", "inline");
            }
            else if (Convert.ToString(Request.QueryString["Opt"]) == "H")
            {
                maintenanceId = Request.QueryString["Mid"].ToString();
                propertytype = Convert.ToString(Request.QueryString["Ptype"].ToString());
                CurrentMaintenanceInfo.Style.Add("display", "inline");
                Amount.Style.Add("display", "inline");
            }
        }

        private void ExpressionBindingCollection()
        {
                objRewallet.flag = Convert.ToString(Request.QueryString["Opt"]);

                objRewallet.MaintenanceId = maintenanceId;
                objRewallet.Id = Convert.ToString(Session["Id"]);
                objRewallet.proptype = propertytype == null ?" " :propertytype.Trim();
                try
                {
                    DataSet ds = (DataSet)objRewalletDal.GetPaymentDetail(objRewallet);
                    BindData(ds);
                }
                catch (Exception ex)
                {
                    Response.Write("<span style='color:red'>" + ex.Message + "</span>");
                }
        }

        private void BindData(DataSet ds)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                txtAddres.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                txtphone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                if (ds.Tables[0].Rows[0]["WalletAmount"].ToString() == "")
                {
                    lblWalletAmount.Text = "0.00";
                }
                else
                {
                    lblWalletAmount.Text = ds.Tables[0].Rows[0]["WalletAmount"].ToString();
                }
                  if (Convert.ToString(Request.QueryString["Opt"]) == "H")
                {
                    txtAmount.Text = ds.Tables[0].Rows[0]["Amount"].ToString();
                    txtAmount.ReadOnly = true;
                    txtCurrentMaintenanceInfo.Text = "Maintenance for " + Convert.ToString(ds.Tables[0].Rows[0]["Month"]) + " is " + ds.Tables[0].Rows[0]["Amount"].ToString();
                }
                if (Convert.ToString(Request.QueryString["Opt"]) == "O")
                {
                    string outstandingamtperiod = GetCommaSeperatedMonths(ds);
                    txtOutstandingMaintenanceInfo.Text = "Total outstanding maintenance for month " + outstandingamtperiod + " is " + ds.Tables[1].Rows[0]["OutstandingAmount"].ToString();
                    txtAmount.Text = ds.Tables[1].Rows[0]["OutstandingAmount"].ToString();
                    txtAmount.ReadOnly = true;
                }
            }
            else
            {
                lblWalletAmount.Text = "0.00";
            }
        }

        private string GetCommaSeperatedMonths(DataSet ds)
        {
            string MonthString = "";
            if (ds.Tables[2].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[2].Rows)
                {
                    if (MonthString == "")
                    {
                        MonthString = Convert.ToString(row["OutstandingAmountMonths"]);
                    }
                    else
                    {
                        MonthString = MonthString + " , " + Convert.ToString(row["OutstandingAmountMonths"]);
                    }
                }
            }
            return MonthString;
        }
        public string GetBaseURL()
        {

            string GetURLBase;
            GetURLBase = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
            return GetURLBase;

        }
        protected void btnMakePayment_Click(object sender, EventArgs e)
        {
            try
            {
                string[] hashVarsSeq;
                string hash_string = string.Empty;
                surl = GetBaseURL() + "Finance/ResponseHandling.aspx";
                furl = GetBaseURL() + "Finance/ResponseHandling.aspx";


                if (string.IsNullOrEmpty(Request.Form["txnid"])) // generating txnid
                {
                    Random rnd = new Random();
                    string strHash = Generatehash512(rnd.ToString() + DateTime.Now);
                    txnid1 = strHash.ToString().Substring(0, 20) + propertytype + maintenanceId;
                }
                else
                {
                    txnid1 = Request.Form["txnid"] + propertytype + maintenanceId;
                }

                if (string.IsNullOrEmpty(Request.Form["hash"])) // generating hash value
                {

                    if (Convert.ToString(Request.QueryString["Opt"]) == "H")
                    {
                        message = "yo";
                        flag='H';
                    }
                    else if (Convert.ToString(Request.QueryString["Opt"]) == "R")
                    {
                        Mainamount = txtAmount.Text;
                        message = txtotherremark.Text.Trim();
                        flag = 'R';
                    }
                    else if (Convert.ToString(Request.QueryString["Opt"]) == "O")
                    {
                        Mainamount = lblOutStanding.Text;
                        flag = 'O';
                    }
                    message = Convert.ToString(Request.QueryString["Opt"]) == "H" ? txtCurrentMaintenanceInfo.Text.Trim() :
                              Convert.ToString(Request.QueryString["Opt"]) == "R" ? txtotherremark.Text.Trim():txtOutstandingMaintenanceInfo.Text.Trim();
                    flag = Convert.ToString(Request.QueryString["Opt"]) == "H" ? 'H' :
                              Convert.ToString(Request.QueryString["Opt"]) == "R" ? 'R':'O';
                    Mainamount = txtAmount.Text.Trim();
                    MName = txtName.Text.Trim();
                    MEmail = txtEmail.Text.Trim();
                    MPhone = txtphone.Text.Trim();


                    //Request.Form["txtAmount"]
                    //Request.Form["txtName"]
                    //Request.Form["txtEmail"]
                    //Request.Form["txtphone"]
                    if (
                        string.IsNullOrEmpty(ConfigurationManager.AppSettings["MERCHANT_KEY"]) ||
                        string.IsNullOrEmpty(txnid1) ||
                        string.IsNullOrEmpty(Mainamount) ||
                        string.IsNullOrEmpty(MName) ||
                        string.IsNullOrEmpty(MEmail) ||
                        string.IsNullOrEmpty(MPhone) ||
                        //  string.IsNullOrEmpty(Request.Form["txtCurrentMaintenanceInfo"]) ||
                        string.IsNullOrEmpty(surl) ||
                        string.IsNullOrEmpty(furl) ||
                        string.IsNullOrEmpty("payu_paisa")
                        )
                    {
                        //error
                        frmError.Visible = true;
                        return;
                    }

                    else
                    {


                        var MaintenanceInfoList = new List<MaintenanceInfo>
                        {
                                new MaintenanceInfo(){
                                            InfoMaintenanceID=Convert.ToString(maintenanceId).Trim(),
                                                  InfoPropertyType   =propertytype.Trim(),
                                                  InfoMessage=message.Trim(),
                                                  flag= flag,
                                                  Amount=Convert.ToDouble(Mainamount),
                                                  SocietyId= Int64.Parse(Session["Id"].ToString())
                                              //    InfoRemark=(txtotherremark.Text!="" ? txtotherremark.Text: "")

                                }
                        };

                        productinfoinfoJeson = Newtonsoft.Json.JsonConvert.SerializeObject(MaintenanceInfoList);
                        productinfoinfoJeson = "{\"paymentParts\":" + productinfoinfoJeson.Trim().ToString() + "}";
                        frmError.Visible = false;
                        hashVarsSeq = ConfigurationManager.AppSettings["hashSequence"].Split('|'); // spliting hash sequence from config
                        hash_string = "";
                        foreach (string hash_var in hashVarsSeq)
                        {
                            if (hash_var == "key")
                            {
                                hash_string = hash_string + ConfigurationManager.AppSettings["MERCHANT_KEY"];
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "txnid")
                            {
                                hash_string = hash_string + txnid1;
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "amount")
                            {
                                hash_string = hash_string + Convert.ToDecimal(Mainamount).ToString("g29");
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "productinfo")
                            {
                                hash_string = hash_string + productinfoinfoJeson;
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "firstname")
                            {
                                hash_string = hash_string + MName;
                                hash_string = hash_string + '|';
                            }
                            else if (hash_var == "email")
                            {
                                hash_string = hash_string + MEmail;
                                hash_string = hash_string + '|';
                            }

                            else
                            {

                                hash_string = hash_string + (Request.Form[hash_var] != null ? Request.Form[hash_var] : "");// isset if else
                                hash_string = hash_string + '|';
                            }
                        }

                        hash_string += ConfigurationManager.AppSettings["SALT"].Trim();// appending SALT
                        hash1 = Generatehash512(hash_string).ToLower();         //generating hash
                        action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";// setting URL
                    }
                }

                else if (!string.IsNullOrEmpty(Request.Form["hash"]))
                {
                    hash1 = Request.Form["hash"];
                    action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";
                }

                if (!string.IsNullOrEmpty(hash1))
                {
                    hash.Value = hash1;
                    txnid.Value = txnid1;

                    System.Collections.Hashtable data = new System.Collections.Hashtable(); // adding values in gash table for data post
                    data.Add("hash", hash.Value);
                    data.Add("txnid", txnid.Value);
                    data.Add("key", key.Value);
                    Mainamount = Convert.ToDecimal(Mainamount).ToString("g29");// eliminating trailing zeros
                    //txtAmount.Text = AmountForm;
                    data.Add("amount", Mainamount);
                    data.Add("firstname", txtName.Text.Trim());
                    data.Add("email", txtEmail.Text.Trim());
                    data.Add("phone", txtphone.Text.Trim());
                    data.Add("curl", "https://www.google.co.in");
                    data.Add("productinfo", HttpUtility.HtmlEncode(productinfoinfoJeson));
                    data.Add("surl", surl);//surl.Text.Trim()
                    data.Add("furl", furl);//furl.Text.Trim()
                    data.Add("address", txtAddres.Text.Trim());
                    data.Add("service_provider", "payu_paisa");

                    string strForm = PreparePOSTForm(action1, data);
                    Page.Controls.Add(new LiteralControl(strForm));

                }

                else
                {
                    //no hash
                }
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

        private string PreparePOSTForm(string url, System.Collections.Hashtable data)      // post form
        {
            //Set a name for the form
            string formID = "PostForm";
            //Build the form using the specified data to be posted.
            StringBuilder strForm = new StringBuilder();
            strForm.Append("<form id=\"" + formID + "\" name=\"" +
                           formID + "\" action=\"" + url +
                           "\" method=\"POST\" target=\"_blank\">");

            foreach (System.Collections.DictionaryEntry key in data)
            {

                strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                               "\" value=\"" + key.Value + "\">");
            }


            strForm.Append("</form>");
            //Build the JavaScript which will do the Posting operation.
            StringBuilder strScript = new StringBuilder();
            strScript.Append("<script language='javascript'>");
            strScript.Append("var v" + formID + " = document." +
                             formID + ";");
            strScript.Append("v" + formID + ".submit();");
            strScript.Append("</script>");
            //Return the form and the script concatenated.
            //(The order is important, Form then JavaScript)
            return strForm.ToString() + strScript.ToString();
        }




    }
}