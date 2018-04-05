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
    public partial class SideVerticalMenu : System.Web.UI.UserControl
    {
        clsUserRegistrationDAL ObjAdmin = new clsUserRegistrationDAL();
        public string UType, RoleId, str_MenuId,UID;

        protected void Page_Load(object sender, EventArgs e)
        {
            string GetURLBase = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
            RoleId = Convert.ToString(Session["RoleId"]);
            UID = Convert.ToString(Session["UID"]);
            string strHtml = string.Empty;
            StringBuilder sb = new StringBuilder();
            string targetWindow = string.Empty;

            try
            {
                DataSet ds = (DataSet)ObjAdmin.GetMenu(RoleId, UID, "");//Convert.ToString(Session["UID"])
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    VerticalsideMenu.InnerHtml = "<ul class = \"page-sidebar-menu page-sidebar-menu-hover-submenu\" data-keep-expanded=\"false\" data-auto-scroll=\"true\" data-slide-speed=\"200\"  id=\"menu_a\">";
                    VerticalsideMenu.InnerHtml += "<li class=\"sidebar-toggler-wrapper\"><div class=\"sidebar-toggler\"></div></li>";
                    foreach (DataRow dr in ds.Tables[0].Select("ParentID=0"))
                    {
                        if ( Convert.ToString(dr["MenuName"]) == "Dashboard")
	                    {
		                    VerticalsideMenu.InnerHtml += "<li class = \"start active open\">";
                            if (Convert.ToString(Session["LoginType"]) == "SuperAdmin")
                            {
                                dr["URL"] = "Dashboards/SuperAdminDashboard.aspx";
                                //dr["URL"] = "AdminDashboard.aspx"; 
                            }
                            else if (Convert.ToString(Session["LoginType"])=="Admin")
	                        {
                                dr["URL"] = "Dashboards/AdminDashboard.aspx";
                                //dr["URL"] = "AdminDashboard.aspx"; 
	                        }
                            else if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
	                        {
                                dr["URL"] = "Dashboards/SocietyMemberDashboard.aspx";
                                //dr["URL"] = "SocietyMemberDashboard.aspx";
	                        }
                            else if (Convert.ToString(Session["LoginType"]) == "CommitteeMember")
                            {
                                dr["URL"] = "Dashboards/CommitteeMemberDashboard.aspx";
                                //dr["URL"] = "CommitteeMemberDashboard.aspx";
                            }
                            else if (Convert.ToString(Session["LoginType"]) == "Employee")
                            {
                                dr["URL"] = "Dashboards/EmployeeDashboard.aspx";
                                //dr["URL"] = "EmployeeDashboard.aspx";
                            }
                            else if (Convert.ToString(Session["LoginType"]) == "Guest")
                            {
                                dr["URL"] = "Dashboards/GuestDashboard.aspx";
                                //dr["URL"] = "GuestDashboard.aspx";
                            }   
	                    }
                        else
	                    {
                            VerticalsideMenu.InnerHtml += "<li>";
	                    }                        
                        //VerticalsideMenu.InnerHtml +="<a href=\"" + dr["URL"].ToString() + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                        VerticalsideMenu.InnerHtml += "<a href=\"" + GetURLBase + dr["URL"].ToString() + "\"><i class=\"" + dr["CssIcon"] + "\"></i><span class=\"title\">" + dr["MenuName"] + "</span>";
                        
                        if ( Convert.ToString(dr["MenuName"]) == "Dashboard")
	                    {
                            VerticalsideMenu.InnerHtml += "<span class=\"selected\"></span><span class=\"arrow open\"></span></a><ul class=\"sub-menu\">";
	                    }
                        else
	                    {
                            VerticalsideMenu.InnerHtml += "<span class=\"arrow \"></span></a><ul class=\"sub-menu\">";
	                    }  
                        
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            if (Convert.ToString(dr["RootID"]) == Convert.ToString(row["ParentID"]))
                            {
                                //VerticalsideMenu.InnerHtml += "<li><a href=\"" + GetURLBase + row["URL"].ToString() + "\"><i class=\"" + dr["CssIcon"] + "\"></i>" + row["MenuName"] + "</a></li>";
                                VerticalsideMenu.InnerHtml += "<li class=\"active\"><a href=\"" + GetURLBase + row["URL"].ToString() + "\"><i class=\"" + row["CssIcon"] + "\"></i>" + row["MenuName"] + "</a></li>";
                            }
                        }
                        VerticalsideMenu.InnerHtml += "</ul></li>";
                    }
                    VerticalsideMenu.InnerHtml += "</ul>";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}