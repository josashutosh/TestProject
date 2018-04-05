using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsquareMasterTemplate.UserControls
{
    public partial class NavigationTopMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Convert.ToString(Session["LoginId"]) != "")
                {

                    SpanUsername.InnerHtml = "Welcome " + Session["LoginId"].ToString();

                }

                if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
                {
                    lblFlatnumber.Text =Convert.ToString(Session["FlatNumber"]);
                    myprofile.Visible = true;
                }
                else 
                {
                    lblFlatnumber.Visible = false;
                    myprofile.Visible = false;
                }    
            }
        }
    }
}