using SocietyDAL;
using SocietyEntity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsquareMasterTemplate
{
    public partial class SociteyInformationView : System.Web.UI.Page
    {
            clsSocietyInformationEntity objsocInfo = new clsSocietyInformationEntity();
            clsSocietyinfoDal objsocDal = new clsSocietyinfoDal();
            clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
            clsCommonDAL objCommonDAL = new clsCommonDAL();
            int ParentId;

            protected void Page_Load(object sender, EventArgs e)
            {
                ValidateUserPermissions();
                if (!this.IsPostBack)
                {
                    this.BindListView();
                }
            }

            private void BindListView()
            {
                DataSet ds = new DataSet();
                objsocInfo.flag = "searchSocityinfobyID";
                objsocInfo.Id = Session["LoginType"].ToString() == "Admin" ? int.Parse(Session["ID"].ToString()) : 0;
                ds = (DataSet)objsocDal.GetSocietyinfoByID(objsocInfo);
                lvSocietyInfo.DataSource = ds;
                lvSocietyInfo.DataBind();
            }

            private void ValidateUserPermissions()
            {
                string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url,0);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                    ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }

            protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
            {
                (lvSocietyInfo.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
                this.BindListView();
            }

            protected void btnDelete_Click1(object sender, EventArgs e)
            {
                if (hdnAllID.Value != "")
                {
                    string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                    objdelrecord.CommonDeleteMaster("SocietyMaster", "SocietyID", strAllID,Convert.ToString(Session["LoginId"]));
                    hdnAllID.Value = "";
                    this.BindListView();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
                }
            }

            protected void btnADD_Click(object sender, EventArgs e)
            {
                string Roletype = Session["LoginType"] as string;
                if (Roletype == "SuperAdmin")
                {
                    Response.Redirect("SocietyInformation.aspx?PId=" + ParentId);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('You Dont Have Enough permission.');</script>", false);
                }
     
            }

            protected void btnCancel_Click(object sender, EventArgs e)
            {
                string Roletype = Session["LoginType"] as string;
                if (Roletype == "SuperAdmin")
                {
                    Response.Redirect("SocietyInformationView.aspx");
                }
               


               
            }
       }
   }
