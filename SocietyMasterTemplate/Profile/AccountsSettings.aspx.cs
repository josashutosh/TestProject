using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.IO;
using SocietyDAL;
using SocietyEntity;

namespace EsquareMasterTemplate.Profile
{
    public partial class AccountsSettings : System.Web.UI.Page
    {
        SaltEncryption objEnc = new SaltEncryption();
        string Output = string.Empty;
        string Jscript, Client, strEncPass, strPass, pwd, str, oldpwd, newpwd;
        int strUID, uid;

        clsUserDAL objuserDal = new clsUserDAL();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindDashboard();
            }
        }
        clsProfileBasicInfoEntity objProfileInfo = new clsProfileBasicInfoEntity();
        clsProfileBasicInfoDal objProfileDal = new clsProfileBasicInfoDal();
//**************************************************** Basic Info Insert **************************************//
      
        
        [WebMethod]
        public static List<string> CheckotherInfoCount()
        {

            string count = "";
            String daresult = null;
            List<string> result = new List<string>();
            clsProfileBasicInfoDal objBasicinfoDal = new clsProfileBasicInfoDal();
            clsProfileBasicInfoEntity objBasicinfo = new clsProfileBasicInfoEntity();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            objBasicinfo.flag = "otherinfobyID";
            string id1 = HttpContext.Current.Session["ID"].ToString();
            //string id1 = "1";
            objBasicinfo.ID = Convert.ToInt32(id1);
            objBasicinfo.LoginId = HttpContext.Current.Session["LoginId"].ToString();
            ds = (DataSet)objBasicinfoDal.GetInfoByID(objBasicinfo);

            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow item in ds.Tables[0].Rows)
                {
                    result.Add(item["BasicinfoID"].ToString());
                    result.Add(item["ID"].ToString());
                    result.Add(item["WebsiteUrl"].ToString());
                    result.Add(item["Facebook"].ToString());
                    result.Add(item["Twitter"].ToString());
                    result.Add(item["GooglePlus"].ToString());
                    result.Add(item["LinkedIn"].ToString());
                }

                dt = ds.Tables[0];
                //dt.WriteXml("abc.xml");
                //daresult = DataSetToJSON(dt);
            }
            else
            {

                result.Add(Convert.ToString(ds.Tables[0].Rows.Count));
            }

            return result;

        }
             
        [WebMethod]
        public static List<string> CheckBasicInfoCount()
        {
            string count = "";
            String daresult = null;
            List<string> result = new List<string>();
            clsProfileBasicInfoDal objBasicinfoDal = new clsProfileBasicInfoDal();
            clsProfileBasicInfoEntity objBasicinfo = new clsProfileBasicInfoEntity();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            objBasicinfo.flag = "BasicinfobyID";
            string id1 = HttpContext.Current.Session["ID"].ToString();
            objBasicinfo.LoginId= HttpContext.Current.Session["LoginId"].ToString();
            //string id1 = "1";
            objBasicinfo.ID = Convert.ToInt32(id1);
            ds = (DataSet)objBasicinfoDal.GetInfoByID(objBasicinfo);
                     
            if (ds.Tables[0].Rows.Count > 0)
            {                
                 foreach (DataRow item in ds.Tables[0].Rows)
                 {
                        //var BasicinfoID, ID, Name, PersonalContact, OfficeContact, Email,
      //   txtName, txtPersonalContact, TextEmail, txtOfficeContact,
                     result.Add(item["BasicinfoID"].ToString());
                     result.Add(item["ID"].ToString());
                     result.Add(item["Name"].ToString());
                     result.Add(item["PersonalContact"].ToString());
                     result.Add(item["OfficeContact"].ToString());
                     result.Add(item["Gender"].ToString());
                     result.Add(item["Birthday"].ToString());
                     result.Add(item["Relationship"].ToString());
                     result.Add(item["OtherName"].ToString());
                     result.Add(item["Interests"].ToString());
                     result.Add(item["Occupation"].ToString());
                     result.Add(item["Tagline"].ToString());
                     result.Add(item["AboutUs"].ToString());    
                     result.Add(item["Email"].ToString());    
                 }

                dt = ds.Tables[0];
                //dt.WriteXml("abc.xml");
                //daresult = DataSetToJSON(dt);
            }
            else
            {
                result.Add(Convert.ToString(ds.Tables[0].Rows.Count));
            }

            return result;

        }

        [WebMethod]
        public static string InsertOtherinfo(int BasicinfoID, int ID, string WebUrl, string Facebook, string Twitter, string GooglePlus, string LinkedIn)
        {
            clsProfileBasicInfoDal objBasicinfoDal = new clsProfileBasicInfoDal();
            clsProfileBasicInfoEntity objBasicinfo = new clsProfileBasicInfoEntity();
            DataSet ds = new DataSet();
            try
            {
                string status = "";

                //ID = Convert.ToInt32(HttpContext.Current.Session["ID"]);
                objBasicinfo.BasicinfoID = BasicinfoID;
                objBasicinfo.ID = ID;
                objBasicinfo.WebsiteUrl = WebUrl;
                objBasicinfo.Facebook = Facebook;
                objBasicinfo.Twitter = Twitter;
                objBasicinfo.GooglePlus = GooglePlus;
                objBasicinfo.LinkedIn = LinkedIn;
               
                objBasicinfo.CreatedBy = HttpContext.Current.Session["LoginId"].ToString();

                status = objBasicinfoDal.InsertOtherinfo(objBasicinfo);
                return status;
            }
            catch (Exception ex)
            { 
                throw ex; 
            }

        }
             
        [WebMethod]
        public static string InsertBasicinfo(int BasicinfoID, int ID, string Name, string PersonalContact, string OfficeContact, string Gender, string Birthday, string Relationship, string OtherName, string Interests, string Occupation, string Tagline, string AboutUs,string Email)
        {
            clsProfileBasicInfoDal objBasicinfoDal = new clsProfileBasicInfoDal();
            clsProfileBasicInfoEntity objBasicinfo = new clsProfileBasicInfoEntity();
            DataSet ds = new DataSet();
            try
            {
                string status = "";
                
                //ID = Convert.ToInt32(HttpContext.Current.Session["ID"]);

                objBasicinfo.BasicinfoID = BasicinfoID;
                objBasicinfo.ID = ID;
                objBasicinfo.Name = Name;
                objBasicinfo.PersonalContact = PersonalContact;
                objBasicinfo.OfficeContact = OfficeContact;
                 objBasicinfo.Email = Email;
                objBasicinfo.Gender = Gender;
                objBasicinfo.Birthday = Birthday;
                objBasicinfo.Relationship = Relationship;
                objBasicinfo.OtherName = OtherName;
                objBasicinfo.Interests = Interests;
                objBasicinfo.Occupation = Occupation;
                objBasicinfo.Tagline = Tagline;
                objBasicinfo.AboutUs = AboutUs;
                objBasicinfo.CreatedBy = HttpContext.Current.Session["LoginId"].ToString();
                objBasicinfo.LoginId = HttpContext.Current.Session["UID"].ToString();
                status = objBasicinfoDal.InsertBasicinfo(objBasicinfo);
                clsAlert.Show(status);
                return status;
            }
            catch (Exception ex)
            { 
                throw ex; 
            }

        }

        //**************************************************** Basic Info Insert **************************************//

        public static string DataSetToJSON(DataTable dt)
        {

            Dictionary<string, object> dict = new Dictionary<string, object>();
            //foreach (DataTable dt in ds.Tables)
            //{
            object[] arr = new object[dt.Rows.Count + 1];

            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                arr[i] = dt.Rows[i].ItemArray;
            }

            dict.Add(dt.TableName, arr);
            //}

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(dict);
        }

        public void bindDashboard()
        {

            DataSet ds = new DataSet();
            objProfileInfo.ID = Convert.ToInt32(Session["ID"]);
            objProfileInfo.Login_Type = Session["LoginType"].ToString();
            objProfileInfo.flag = "GetProfileInfo";
            if (Session["LoginType"].ToString() == "Admin" || Session["LoginType"].ToString() == "SuperAdmin")
            {
                objProfileInfo.flatId = 0;
            }
            else if (Session["LoginType"].ToString() == "SocietyMember")
            {
                objProfileInfo.flatId = Convert.ToInt32(Session["FlatId"]);
            }
           
            objProfileInfo.LoginId = Convert.ToString(Session["LoginId"]);
            //objSocMemDashEntity.OwnerID=7;
            //objSocMemDashEntity.LoginType = "SocietyMember";

            ds = (DataSet)objProfileDal.GetProfileinfoByID(objProfileInfo);

            if (ds.Tables[0].Rows.Count > 0)
            {
                ProfileView.DataSource = ds;
                ProfileView.DataBind();
            }
            else
            {
                ProfileView.DataSource = ds;
                ProfileView.DataBind();
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

    

      protected void btnUpload_Click(object sender, EventArgs e)
        {
             string fileName = Path.GetFileName(FuAvatar.PostedFile.FileName);
            string fileExtension = System.IO.Path.GetExtension(fileName);
            string fileMimeType = FuAvatar.PostedFile.ContentType;
            int fileLengthInKB = FuAvatar.PostedFile.ContentLength / 1024;

            System.IO.Stream stream = FuAvatar.PostedFile.InputStream;
            System.Drawing.Image image = System.Drawing.Image.FromStream(stream);


            string randomc = Session["ID"].ToString();
            if (FuAvatar.HasFile)
            {
                string CreatedBy;
                string FileType = Path.GetExtension(FuAvatar.PostedFile.FileName).ToLower().Trim();
                // Checking the format of the uploaded file.
                if ((FileType != ".jpg" && FileType != ".png" && FileType != ".gif" && FileType != ".bmp"))
                {
                    clsAlert.Show("Select Student Photo size less than 160kb and' file type should be jpg, .png, .bmp Only");
                }
                else if (fileLengthInKB <= 500)
                {
                    if (image.Height < 300 && image.Width < 300)
                    {



                        string path = Server.MapPath(@"../Images/Profile/" + randomc + "profile"+fileExtension);

                        CreatedBy = Session["LoginId"].ToString();
                        string output = objProfileDal.InsertAvatar(Convert.ToInt32(Session["ID"]), randomc + "profile" + fileExtension, CreatedBy);

                        FuAvatar.PostedFile.SaveAs(path);

                        clsAlert.Show(output);
                    }
                    else 
                    {
                        clsAlert.Show("Your Image Height Should Be Less Than 300 x 300");
                    }
                }
                else
                {
                    //Please choose a file less than 1MB
                    clsAlert.Show("Please choose a file less than 500kb");
                }
            }

        }

        /// Forget Password///
        

      protected void BtnChnagePassword_click(object sender, EventArgs e)
      {

          DataSet dsout = new DataSet();
          oldpwd = txtoldPassword.Text.Trim();
          Session["OldPwd"] = oldpwd;
          dsout = (DataSet)objuserDal.GetUserInfobyUID(Convert.ToInt32(Session["UID"]));
          DataRow drLogin = dsout.Tables[0].Rows[0];
          strPass = Convert.ToString(drLogin["Password"]);
          Session["Password"] = strPass;


          if (ValidateUserCredentials() == true)
          {
              string newpass = objEnc.ComputeHash(txtNewPassword.Text.Trim().ToString(), "SHA512", null);
              string Password = newpass;

              objuserDal.fnChangePassword(Password,Convert.ToInt32(Session["UID"]));
              ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Password Changed Successfully....'); </script>", false);            

          }
          else
          {
              ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Old Password Is Worng'); </script>", false);
              //toastr.warning("Old Password Is Worng");
              
          }
          Session["Password"] = null;
      }

      private bool ValidateUserCredentials()
      {
          bool PassValid = objEnc.VerifyHash(txtoldPassword.Text.Trim().ToString(), "SHA512", strPass);

          if (PassValid == true)
          {
              return true;
          }
          else
          {
              return false;
          }
      }

      protected void btnRefresh_Click(object sender, EventArgs e)
      {
          Response.Redirect("AccountsSettings.aspx");
      }

        /// END Password//
    }
}