using SocietyDAL;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SocietyEntity;
using System.Data;
namespace EsquareMasterTemplate.Masters
{
    public partial class SociteyInformation : System.Web.UI.Page
    {
        int SocietyId,ParentId;
        string output,pathlogo,pathsign,pathstamp;
        clsSocietyInformationEntity objsocInfo = new clsSocietyInformationEntity();
        clsSocietyinfoDal objsocDal = new clsSocietyinfoDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            SocietyId = Convert.ToInt32(Request.QueryString["SocietyId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();              
                UpdateMaster();
            } 
        }

        private void ValidateUserPermissions()
        {
            string Roletype = Session["LoginType"] as string;
            if (Roletype == "Admin")
            {
                if (SocietyId == 0)
                {
                    Response.Redirect("SocietyInformationView.aspx");
                }
            }
            else if (Roletype != "SuperAdmin" || Roletype == null || Roletype == "")
            {
                Response.Redirect("../Account/Login.aspx");
            }
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
        protected void btnBuildingSubmit_Click(object sender, EventArgs e)
        {
            if (SocietyId == 0)
            {
                objsocInfo.Id = 0;
                objsocInfo.CreatedBy = Convert.ToString(Session["LoginId"]);
            }
            else
            {
                objsocInfo.Id = SocietyId;
                objsocInfo.ModifiedBy = Convert.ToString(Session["LoginId"]);
            }

            objsocInfo.societyName = txtSocietyName.Text;
            objsocInfo.SocietyAddress = TxtSocietyAddress.Text;
            objsocInfo.RegistrationNumber = TxtRegistrationNumber.Text;
            objsocInfo.BuildingCount =String.IsNullOrWhiteSpace(TxtBuildingCnt.Text)?0: Convert.ToInt16(TxtBuildingCnt.Text);
            objsocInfo.FlatCount =String.IsNullOrWhiteSpace(TxtFlatsCnt.Text)?0: Convert.ToInt16(TxtFlatsCnt.Text);
            objsocInfo.IntrestRate = String.IsNullOrWhiteSpace(txtintrestrate.Text) ? 0 : float.Parse(txtintrestrate.Text);
            objsocInfo.ReceiptNotes = String.IsNullOrWhiteSpace(txtreceiptnotes.Text) ? "" : txtreceiptnotes.Text;
            objsocInfo.accountNumber = String.IsNullOrWhiteSpace(txtbankAccount.Text) ? "" : txtbankAccount.Text;
            objsocInfo.bankName = String.IsNullOrWhiteSpace(txtBankName.Text) ? "" : txtBankName.Text;
            objsocInfo.branch = String.IsNullOrWhiteSpace(txtBranch.Text) ? "" : txtBranch.Text;
            objsocInfo.Ifsc = String.IsNullOrWhiteSpace(txtIFSC.Text) ? "" : txtIFSC.Text;
            objsocInfo.SenderName = String.IsNullOrWhiteSpace(txtSenderName.Text) ? "" : txtSenderName.Text;
        
            //FuLogo
            //fustamp
            //fuSign
            string randomc = Convert.ToString(Session["Id"]);
            if (FuLogo.HasFile)
            {
                string fileName = Path.GetFileName(FuLogo.PostedFile.FileName);
                string fileExtension = System.IO.Path.GetExtension(fileName);
                string fileMimeType = FuLogo.PostedFile.ContentType;
                int fileLengthInKB = FuLogo.PostedFile.ContentLength / 1024;
                System.IO.Stream stream = FuLogo.PostedFile.InputStream;
                System.Drawing.Image image = System.Drawing.Image.FromStream(stream);

                string FileType = Path.GetExtension(FuLogo.PostedFile.FileName).ToLower().Trim();
                // Checking the format of the uploaded file.
                if ((FileType != ".jpg" && FileType != ".jpeg" && FileType != ".png" && FileType != ".gif" && FileType != ".bmp"))
                {
                    clsAlert.Show("file file type should be jpg, .png, .bmp Only");
                }
                else if (fileLengthInKB <= 500)
                {
                    objsocInfo.FuLogo = "Images/SocietyInfo/" + randomc + "Logo" + FileType;
                    Session["pathlogo"] = Server.MapPath(@"../Images/SocietyInfo/" + randomc + fileName);
                    // clsAlert.Show(output);
                }

            }
            else
            {
                if (SocietyId != 0)
                {
                    objsocInfo.FuLogo = lbllogo.Text;
                }
                else
                {
                    objsocInfo.FuLogo = "Images/SocietyInfo/logo.png";
                }
            }

            if (fustamp.HasFile)
            {
                string FileType = Path.GetExtension(fustamp.PostedFile.FileName).ToLower().Trim();
                // Checking the format of the uploaded file.
                if ((FileType != ".jpg" && FileType != ".jpeg" && FileType != ".png" && FileType != ".gif" && FileType != ".bmp"))
                {
                    clsAlert.Show(" file type should be jpg, .png, .bmp Only");
                }
                else if ((fustamp.PostedFile.ContentLength / 1024) <= 500)
                {

                    objsocInfo.fustamp = "Images/SocietyInfo/" + randomc + "SocietyStamp" + FileType;

                    Session["pathstamp"] = Server.MapPath(@"../Images/SocietyInfo/" + randomc + Path.GetFileName(fustamp.PostedFile.FileName));
                    // clsAlert.Show(output);
                }

            }
            else
            {
                if (SocietyId != 0)
                {
                    objsocInfo.fustamp = lblstamp.Text;
                }
                else 
                {
                    objsocInfo.fustamp = "Images/SocietyInfo/authorized-stamp.gif";
                }
                //Please choose a file less than 1MB  
            }

            if (fuSign.HasFile)
            {
                string FileType = Path.GetExtension(fuSign.PostedFile.FileName).ToLower().Trim();
                // Checking the format of the uploaded file.
                if ((FileType != ".jpg" && FileType != ".jpeg" && FileType != ".png" && FileType != ".gif" && FileType != ".bmp"))
                {
                    clsAlert.Show(" file type should be jpg, .png, .bmp Only");
                }
                else if ((fuSign.PostedFile.ContentLength / 1024) <= 500)
                {
                    objsocInfo.fuSign = "Images/SocietyInfo/" + randomc +"Sign"+ FileType;
                    Session["pathsign"] = Server.MapPath(@"../Images/SocietyInfo/" + randomc + Path.GetFileName(fuSign.PostedFile.FileName));
                    // clsAlert.Show(output);
                }

            }
            else
            {
                if (SocietyId != 0)
                {
                    objsocInfo.fuSign = lblSign.Text;
                }
                else
                {
                    objsocInfo.fuSign = "Images/SocietyInfo/sign.png";
                }
            }

            output = objsocDal.InsertSocietyMaster(objsocInfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');Response.Redirect('SocietyInformationView.aspx');</script>", false);

            if (Convert.ToString(Session["pathsign"]) != "")
            {
                fuSign.PostedFile.SaveAs(Session["pathsign"].ToString());
            }

            if (Convert.ToString(Session["pathstamp"]) != "")
            {
                fustamp.PostedFile.SaveAs(Session["pathstamp"].ToString());
            }
            if (Convert.ToString(Session["pathlogo"]) != "")
            {
                FuLogo.PostedFile.SaveAs(Session["pathlogo"].ToString());
            }

            Session["pathsign"] = null;
            Session["pathstamp"] = null;
            Session["pathlogo"] = null;
            clearall();
            Response.Redirect("SocietyInformationView.aspx");
        }

        private void clearall()
        {
            txtSocietyName.Text = "";
            TxtSocietyAddress.Text = "";
            lbllogo.Text = "";
            lblSign.Text = "";
            lblstamp.Text = "";
            txtintrestrate.Text = "";
            txtreceiptnotes.Text = "";
            txtSenderName.Text = "";
            TxtFlatsCnt.Text = "";
            TxtBuildingCnt.Text = "";
            TxtRegistrationNumber.Text = "";
        }

        protected void UpdateMaster()
        {
            if (SocietyId != 0)
            {
                objsocInfo.flag = "searchSocityinfobyID";
                objsocInfo.Id = SocietyId;
               DataSet ds = (DataSet)objsocDal.GetSocietyinfoByID(objsocInfo);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtSocietyName.Text = ds.Tables[0].Rows[0]["SocietyName"].ToString();
                    TxtSocietyAddress.Text = ds.Tables[0].Rows[0]["SocietyAddress"].ToString();
                    lbllogo.Text = ds.Tables[0].Rows[0]["Logo"].ToString();
                    lblSign.Text = ds.Tables[0].Rows[0]["Secretorysign"].ToString();
                    lblstamp.Text = ds.Tables[0].Rows[0]["SocietyStamp"].ToString();
                    TxtRegistrationNumber.Text = Convert.ToString(ds.Tables[0].Rows[0]["RegistrationNumber"]);
                    TxtBuildingCnt.Text = Convert.ToString(ds.Tables[0].Rows[0]["BuildingCount"]);
                    txtSenderName.Text = ds.Tables[0].Rows[0]["SenderName"].ToString();
                    TxtFlatsCnt.Text = Convert.ToString(ds.Tables[0].Rows[0]["TotalFlatsCount"]);
                    txtintrestrate.Text = Convert.ToString(ds.Tables[0].Rows[0]["InterestRate"]);
                    txtreceiptnotes.Text = Convert.ToString(ds.Tables[0].Rows[0]["ReceiptNotes"]);
                    txtIFSC.Text = Convert.ToString(ds.Tables[0].Rows[0]["IfscCode"]);
                    txtbankAccount.Text = Convert.ToString(ds.Tables[0].Rows[0]["AccountNumber"]);
                    txtBankName.Text = Convert.ToString(ds.Tables[0].Rows[0]["BankName"]);
                    txtBranch.Text = Convert.ToString(ds.Tables[0].Rows[0]["Bankbranch"]); 
                    btnBuildingSubmit.Text = "Update";
                }

                else
                {
                    btnBuildingSubmit.Text = "Submit";
                }

            }

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("SocietyInformationView.aspx");
        }

        }
    }
