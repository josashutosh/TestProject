using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using SocietyDAL;

namespace EsquareMasterTemplate.UserControls
{
    public partial class TopMenu : System.Web.UI.UserControl
    {
         clsUserRegistrationDAL ObjAdmin = new clsUserRegistrationDAL();
        public string UType, RoleId, str_MenuId;
        protected void Page_Load(object sender, EventArgs e)
        {
             //string GetURLBase = HttpContext.Current.Request.Url.Host;
             string GetURLBase = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
            RoleId = "1";// Convert.ToString(Session["Role_ID"]);
            string strHtml = string.Empty;
            StringBuilder sb = new StringBuilder();
            string targetWindow = string.Empty;

            try
            {
                DataSet ds = (DataSet)ObjAdmin.GetMenu(RoleId, "1", "");//Convert.ToString(Session["UID"])
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    HorrizontalsideMenu.InnerHtml = "<ul class = \"nav navbar-nav\"  id=\"menu_a\">";
                    HorrizontalsideMenu.InnerHtml += "<li class=\"sidebar-toggler-wrapper\"><div class=\"sidebar-toggler\"></div></li>";
                    foreach (DataRow dr in ds.Tables[0].Select("ParentID=0"))
                    {
                        if ( Convert.ToString(dr["MenuName"]) == "Dashboard")
	                    {
                            HorrizontalsideMenu.InnerHtml += "<li class = \"start active open\">";
	                    }
                        else
	                    {
                            HorrizontalsideMenu.InnerHtml += "<li>";
	                    }
                        if (Convert.ToString(dr["MenuName"]) == "Dashboard")
                        {
                            if (Convert.ToString(Session["LoginType"]) == "Admin")
                            {
                                GetURLBase = GetURLBase + "/Dashboards/AdminDashboard.aspx";
                                HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                            }
                            else if(Convert.ToString(Session["LoginType"]) == "CommitteeMember")
                            {
                                GetURLBase = GetURLBase + "/Dashboards/CommitteeMemberDashboard.aspx";
                                HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                            }        
                            else if(Convert.ToString(Session["LoginType"]) == "Employee")
                            {
                                GetURLBase = GetURLBase + "/Dashboards/EmployeeDashboard.aspx";
                                HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                            }        
                            else if(Convert.ToString(Session["LoginType"]) == "Guest")
                            {
                                GetURLBase = GetURLBase + "Dashboards/GuestDashboard.aspx";
                                HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                            }
                            else if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
                            {
                                GetURLBase = GetURLBase + "/Dashboards/SocietyMemberDashboard.aspx";
                                HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                            }        
                        }
                        else
                        {
                            
                            HorrizontalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + dr["URL"].ToString() + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                        }
                        if ( Convert.ToString(dr["MenuName"]) == "Dashboard")
	                    {
                            HorrizontalsideMenu.InnerHtml += "<span class=\"selected\"></span><span class=\"arrow open\"></span></a><ul class=\"sub-menu\">";
	                    }
                        else
	                    {
                            HorrizontalsideMenu.InnerHtml += "<span class=\"arrow \"></span></a><ul class=\"sub-menu\">";
	                    }  
                        
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            if (Convert.ToString(dr["RootID"]) == Convert.ToString(row["ParentID"]))
                            {
                                HorrizontalsideMenu.InnerHtml += "<li><a href=\"" + GetURLBase + row["URL"].ToString() + "\"><i class=\"" + dr["CssIcon"] + "\"></i>" + row["MenuName"] + "</a></li>";
                            }
                        }
                        HorrizontalsideMenu.InnerHtml += "</ul></li>";
                    }
                    HorrizontalsideMenu.InnerHtml += "</ul>";
                }

            }

            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}