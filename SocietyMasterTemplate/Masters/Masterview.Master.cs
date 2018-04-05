using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Optimization;

namespace EsquareMasterTemplate.Masters
{
    public partial class Masterview : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["ReUrl"] = null;
                Session["ReUrl"] = Request.Url.ToString();
            }
        }
    }
}