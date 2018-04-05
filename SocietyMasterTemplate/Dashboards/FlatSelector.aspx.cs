using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SocietyDAL;
using SocietyEntity;

namespace EsquareMasterTemplate.Dashboards
{
    public partial class FlatSelector : System.Web.UI.Page
    {
        clsSocietyMemberDashboardDal objSocMemDashDal = new clsSocietyMemberDashboardDal();
        clsFlatMasterDal objflatmasterDal = new clsFlatMasterDal();
        clsCommonDAL commcls = new clsCommonDAL();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        public string Redirecturl, url, path;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Convert.ToString(Request.QueryString["Action"]) == "SelectFlat")

            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'> toastr['error']('Please select Flat to Process.')</script>", false);
            }

            if (!IsPostBack)
            {
                DataSet ds = objSocMemDashDal.GetMultipleFlatDetails(Convert.ToString(Session["Id"]));
                if (ds.Tables[0].Rows.Count > 1)
                {
                    lblSocietyName.Text = ds.Tables[0].Rows[0]["SocietyName"].ToString();
                    commcls.FillDropDown(ddlUnitId, ds.Tables[0], "FlatNumber", "FlatId", "- Select Flat -");
                }
            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Session["FlatId"] = ddlUnitId.SelectedValue;
            objflatinfo.FlatId = Convert.ToInt16(ddlUnitId.SelectedValue);
            objflatinfo.FlatNumber = ddlUnitId.SelectedItem.Text;
            Session["FlatNumber"] = ddlUnitId.SelectedItem.Text;
            DataSet dsflat = objflatmasterDal.GetflatInfo(objflatinfo,Convert.ToString(Session["Id"]));
            Session["IsRented"] = Convert.ToString(dsflat.Tables[0].Rows[0]["IsRented"]);
            url = HttpContext.Current.Request.Url.AbsoluteUri;
            path = HttpContext.Current.Request.Url.AbsolutePath;
            Redirecturl = url.Replace(path, "/Dashboards/SocietyMemberDashboard.aspx");
            Response.Redirect(Redirecturl);
        }
    }
}