using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;
using Newtonsoft;
using System.Web.Services;
using EsquareMasterTemplate;
using Newtonsoft.Json;
using System.Web.UI.HtmlControls;
using SocietyEntity;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace EsquareMasterTemplate.Dashboards
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        clsSocietyMemberDashboardDal objSocMemDashDal = new clsSocietyMemberDashboardDal();
        clsSocietyMemberDashboardEntity objSocMemDashEntity = new clsSocietyMemberDashboardEntity();
        int ParentId;
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            //string xyz = string.Empty;
            //for (int i = 0; i < Session.Count; i++)
            //{
                
            //    var crntSession = Session.Keys[i];
            //  string abc=  string.Concat(crntSession, "=", Session[crntSession]);

            //   xyz = xyz +" "+ abc;

            //}
            ValidateUserPermissions();
            if (!IsPostBack)
            {
           
                bindDashboard();
            }
        }

        public void bindDashboard()
        {
            DataSet ds = new DataSet();
            objSocMemDashEntity.OwnerID = Convert.ToInt32(Session["ID"]);
            objSocMemDashEntity.LoginType = Session["LoginType"].ToString();
            //objSocMemDashEntity.OwnerID=7;
            //objSocMemDashEntity.LoginType = "SocietyMember";

            ds = (DataSet)objSocMemDashDal.GetSocietyMemDashDetail(objSocMemDashEntity);

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblMonthlyIncome.Text = ds.Tables[0].Rows[0]["Income"].ToString(); 
                }
                else
                {
                    lblMonthlyIncome.Text = "-";
                }

                 if (ds.Tables[1].Rows.Count > 0)
                {
                    lblMonthlyExpense.Text = ds.Tables[1].Rows[0]["Expense"].ToString();
                }
                else
                {
                    lblMonthlyExpense.Text = "-";
                }
                  
            }  

        }

        private void ValidateUserPermissions()
        {
            if (Session["RoleId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Your session expired, you are logging out..!!');</script>", false);
                Response.Redirect("../Account/Login.aspx");
            }
            else
            {
                string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, 0);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                   // ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }

        [WebMethod(EnableSession=true)]
        public static List<GetExpenseChart> GetExpenseChart()
        {
            clsChartEntity objChart = new clsChartEntity();
            clsChartDal objChartDal = new clsChartDal();
            objChart.Flag = "ExpenseChart";
            List<GetExpenseChart> dataList = new List<GetExpenseChart>();

          //  long SocietyId=HttpContext.Current.Session["SocityId"].ToString()!=""?long.Parse(HttpContext.Current.Session["SocityId"].ToString()):0;
            long SocietyId = 1;

            if (SocietyId > 0)
            {
                DataSet ds=(DataSet)objChartDal.GetChart(objChart);
                     if (ds.Tables[0].Rows.Count > 0)
                     {
                           
                             //dt.TableName = "MyTable";
                         DataTable dt = ds.Tables[0];
                        
                             foreach (DataRow dtrow in dt.Rows)
                             {
                                 string html=string.Empty;
                                           StringBuilder objhtml = new StringBuilder();

                                           objhtml.Append("<div class=\"table-responsive\"><table class=\"table table-condensed\">");
                                           objhtml.Append("<tr><td style=\"padding:1px 3px\"><b>Plan Name  :</b><td><td>" + dtrow[0].ToString() + "</td></tr>");
                                           objhtml.Append("<tr><td style=\"padding:1px 3px\"><b>Amount Name  :</b><td><td>" + dtrow[1].ToString() + "</td></tr>"); 
                                 objhtml.Append("</table></div>");

    
 


                                 GetExpenseChart details = new GetExpenseChart();
                                 details.PlanName = dtrow[0].ToString();
                                 details.PaymentAmount = Convert.ToInt32(dtrow[1]);
                                 details.HtmlContent = objhtml.ToString();

                      



                                 dataList.Add(details);
                             }
                     }
                     return dataList;
            }
            else 
            {
                return dataList;
            }

        }

        


    }
}