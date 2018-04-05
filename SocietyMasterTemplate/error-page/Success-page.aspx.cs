using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EsquareMasterTemplate.error_page
{
    public partial class Success_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Convert.ToString(Request.QueryString["method"]) == "Logout")
            {
                Session.Clear();
                Session.Abandon();
                Session.RemoveAll();
                Response.Redirect("../Account/Login.aspx");          
            }
            else 
            {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('You Dont Have enough Permission');toastr.warning('Wait For 5 Second.....'); </script>", false);

                if (Convert.ToString(Session["REurl"]) == "")
                {
                    Response.AddHeader("REFRESH", "5;URL=../Account/Login.aspx");
                }
                else
                {
                    string url = Session["REurl"].ToString();
                    Response.AddHeader("REFRESH", "5;URL= '" + url + "'");
                }

            }
        }
    }
}