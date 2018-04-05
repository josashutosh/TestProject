using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyDAL;
using System.Web.Optimization;
namespace EsquareMasterTemplate.Profile
{
    public partial class ProfileMaster : System.Web.UI.MasterPage
    {
        clsProfileBasicInfoEntity objProfileInfo = new clsProfileBasicInfoEntity();
        clsProfileBasicInfoDal objProfileDal = new clsProfileBasicInfoDal();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["ReUrl"] = null;
                Session["ReUrl"] = Request.Url.ToString();
                bindDashboard();
            }

        }


        public void bindDashboard()
        {

            DataSet ds = new DataSet();
            objProfileInfo.ID = Convert.ToInt32(Session["ID"]);
            objProfileInfo.Login_Type = Session["LoginType"].ToString();
            objProfileInfo.flatId = Convert.ToInt32(Session["FlatId"].ToString());
            objProfileInfo.LoginId = Convert.ToString(Session["LoginId"]);
            objProfileInfo.flag = "GetProfileInfo";
            //objSocMemDashEntity.OwnerID=7;
            //objSocMemDashEntity.LoginType = "SocietyMember";

            ds = (DataSet)objProfileDal.GetProfileinfoByID(objProfileInfo);

            if (ds.Tables.Count > 0)
            {

                if (ds.Tables[0].Rows.Count > 0)
                {

                    profileusertitlename.InnerHtml = ds.Tables[0].Rows[0]["Name"].ToString();
                    profileusertitlejob.InnerHtml = ds.Tables[0].Rows[0]["Occupation"].ToString();

                    if (System.IO.File.Exists(Server.MapPath("../Images/Profile/" + ds.Tables[0].Rows[0]["Photo"].ToString())) == false)
                    {
                        imgProfile.ImageUrl = imgProfile.ResolveUrl("../Images/Profile/No-Image.png");
                    }
                    else
                    {
                        imgProfile.ImageUrl = imgProfile.ResolveUrl("../Images/Profile/" + ds.Tables[0].Rows[0]["Photo"].ToString());
                    }

                    if (ds.Tables[0].Rows[0]["Facebook"].ToString() == null || ds.Tables[0].Rows[0]["Facebook"].ToString() == "")
                    {
                        Facebook_social.InnerHtml = "-";
                    }
                    else
                    {
                        Facebook_social.InnerHtml = ds.Tables[0].Rows[0]["Facebook"].ToString();
                    }

                    if (ds.Tables[0].Rows[0]["WebsiteUrl"].ToString() == null || ds.Tables[0].Rows[0]["WebsiteUrl"].ToString() == "")
                    {
                        Weburl_social.InnerHtml = "-";
                    }
                    else
                    {
                        Weburl_social.InnerHtml = ds.Tables[0].Rows[0]["WebsiteUrl"].ToString();
                    }

                    if (ds.Tables[0].Rows[0]["AboutUs"].ToString() == "NULL" || ds.Tables[0].Rows[0]["AboutUs"].ToString() == null || ds.Tables[0].Rows[0]["AboutUs"].ToString() == "")
                    {
                        AboutUs.InnerHtml = "-";
                    }
                    else
                    {
                        AboutUs.InnerHtml = ds.Tables[0].Rows[0]["AboutUs"].ToString();
                    }


                    if (ds.Tables[0].Rows[0]["Twitter"].ToString() == null || ds.Tables[0].Rows[0]["Twitter"].ToString() == "")
                    {
                        twitter_social.InnerHtml = "-";
                    }
                    else
                    {
                        twitter_social.InnerHtml = ds.Tables[0].Rows[0]["Twitter"].ToString();
                    }

                    if (ds.Tables[0].Rows[0]["GooglePlus"].ToString() == null || ds.Tables[0].Rows[0]["GooglePlus"].ToString() == "")
                    {
                        Google_social.InnerHtml = "-";
                    }
                    else
                    {
                        Google_social.InnerHtml = ds.Tables[0].Rows[0]["GooglePlus"].ToString();
                    }

                    if (ds.Tables[0].Rows[0]["LinkedIn"].ToString() == null || ds.Tables[0].Rows[0]["LinkedIn"].ToString() == "")
                    {
                        linkedin_social.InnerHtml = "-";
                    }
                    else
                    {
                        linkedin_social.InnerHtml = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["LoginType"].ToString() == null || ds.Tables[0].Rows[0]["LoginType"].ToString() == "")
                    {
                        pLoginType.InnerHtml = "-";
                    }
                    else
                    {
                        pLoginType.InnerHtml = "Login Type :" + ds.Tables[0].Rows[0]["LoginType"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["FlatNumber"].ToString() == null || ds.Tables[0].Rows[0]["FlatNumber"].ToString() == "")
                    {
                        FlatInfo.InnerHtml = "-";
                    }
                    else
                    {
                        FlatInfo.InnerHtml = "Flat Number :" + ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                    }

                    if (ds.Tables[0].Rows[0]["buildingName"].ToString() == null || ds.Tables[0].Rows[0]["buildingName"].ToString() == "")
                    {
                        Buildingname.InnerHtml = "-";
                    }
                    else
                    {
                        Buildingname.InnerHtml = "building Name :" + ds.Tables[0].Rows[0]["buildingName"].ToString();
                    }


                }
                else
                {
                    profileusertitlename.InnerHtml = "-";
                    profileusertitlejob.InnerHtml = "-";
                    imgProfile.ImageUrl = imgProfile.ResolveUrl("../Images/Profile/No-Image.png");
                    Facebook_social.InnerHtml = "-";
                    Weburl_social.InnerHtml = "-";
                    AboutUs.InnerHtml = "-";
                    twitter_social.InnerHtml = "-";
                    Google_social.InnerHtml = "-";
                    linkedin_social.InnerHtml = "-";
                    Buildingname.InnerHtml = "-";
                    pLoginType.InnerHtml = "-";
                    FlatInfo.InnerHtml = "-";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('Please Insert Basic and Social Info');</script>", false);
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found');');</script>", false);
            }
        }


    }
}