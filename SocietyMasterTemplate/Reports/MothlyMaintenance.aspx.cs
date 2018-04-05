//using Syncfusion.JavaScript.Models.ReportViewer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EsquareMasterTemplate.Reports;
using System.Data;
using SocietySquareDAL;
using SocietySquareDAL;
using SocietySquareEntity;
//using Microsoft.
using EsquareMasterTemplate.Reports.Rdlc;

namespace EsquareMasterTemplate.Reports
{
    public partial class MothlyMaintenance : System.Web.UI.Page
    {
        string Login_Type, ReportDate;
        int flatnumber;
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsReportDal objReportDal = new clsReportDal();
        clsReportParameterEntity objReportEntity = new clsReportParameterEntity();
        protected void Page_Load(object sender, EventArgs e)
        {
            //EsquareMasterTemplate.Reports.Rdlc.MothlyReportList MothlyReport = new EsquareMasterTemplate.Reports.Rdlc.MothlyReportList();
            //List<ReportDataSource> rptDatasources = new List<ReportDataSource>();
            //this.MonthlyReport.ReportPath = ReportViewerHelper.GetReportPath(this.MonthlyReport.ReportPath);
            //ReportDataSource rptDatasource = new ReportDataSource();
            //rptDatasource.Name = "MonthlyReport";
            //rptDatasource.Value = MothlyReport.GetData();        
            //rptDatasources.Add(rptDatasource);           
            //this.MonthlyReport.DataSources = rptDatasources;
            //this.MonthlyReport.ReportServiceUrl = VirtualPathUtility.ToAbsolute("~/Reports/Rdlc");

          
          
            if (!IsPostBack)
            {

                if (Convert.ToString(Session["Login_Type"]) == "Admin")
                {
                    drpFlatID.Visible = true;
                    drpFlatID.Attributes["style"] = "display:block";
                }
                else if (Convert.ToString(Session["Login_Type"]) == "SocietyMember")
                {
                    drpFlatID.Visible = false;
                    drpFlatID.Attributes["style"] = "display:none";
                    getflatid();
                }

               
                BindFlatDropdown();
                drpFlatID.Items.Insert(0, new ListItem("--Select Flat Name--", ""));
                drpFlatID.SelectedIndex = 0;
            }

           

        }
        private void getflatid()
        {
            DataSet ds = new DataSet();

            ds = objflatdal.getflatIDbyownerID("GetFlatID",Convert.ToString(Session["ID"]));
            if(ds.Tables[0].Rows.Count>0)
            {
                Session["flatnumber"] = ds.Tables[0].Rows[0]["FlatId"].ToString();              
            }
         
        }
        private void BindFlatDropdown()
        {
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo)).Tables[0], "FlatNumber", "FlatId");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
           // ReportM.Attributes["style"] = "display:block";
       

            if (Convert.ToString(Session["Login_Type"]) == "Admin")
            {
                Login_Type = Session["Login_Type"].ToString();
                Session["ReportDate"] = txtdate.Text;
                ReportDate = Session["ReportDate"].ToString();
                Session["flatnumber"] = Convert.ToInt32(drpFlatID.SelectedValue);
                flatnumber = Convert.ToInt32(Session["flatnumber"]);

                Showreport();

            }
            else if(Convert.ToString(Session["Login_Type"]) == "SocietyMember")
            {
                Login_Type = Session["Login_Type"].ToString();
                Session["ReportDate"] = txtdate.Text;
                ReportDate = Session["ReportDate"].ToString();
                flatnumber = Convert.ToInt32(Session["flatnumber"]);
                Showreport();
            }




        }

         private DataTable GetData(string _LoginType,string _ReportDate,int _flatnumber)
        {
           
            DataSet ds = new DataSet();

        ds = (DataSet)objReportDal.GetMonthlyDetail(_LoginType, _ReportDate, _flatnumber);

        DataTable dt = new DataTable();
           
                  dt = ds.Tables[0];                     
            
            return dt;
       
        }

         private void Showreport() 
         
         {
           //Reset 

             ReportViewer1.Reset();
           //Datasource

             DataTable dt = GetData(Login_Type, ReportDate, flatnumber);
           
             DataSet ds1 = new DataSet();

             ds1 = (DataSet)objReportDal.GetSocietyInfo();
             //string serverpath = Server.MapPath(@"~/");
             string logo = new Uri(Server.MapPath(@"~/"+ ds1.Tables[0].Rows[0]["Logo"].ToString())).AbsoluteUri;
             string stamp = new Uri(Server.MapPath(@"~/"+ ds1.Tables[0].Rows[0]["SocietyStamp"].ToString())).AbsoluteUri; 
             string sign = new Uri(Server.MapPath(@"~/"+ ds1.Tables[0].Rows[0]["Secretorysign"].ToString())).AbsoluteUri; 

             DataTable dt1 = ds1.Tables[0];

             ReportDataSource rds = new ReportDataSource("MonthReport", dt);
        
             ReportDataSource rds1 = new ReportDataSource("SocietyInfo", dt1);

             ReportViewer1.LocalReport.DataSources.Add(rds);
             ReportViewer1.LocalReport.DataSources.Add(rds1);
             //Path




             ReportViewer1.LocalReport.ReportPath="Reports/Rdlc/MonthlyMaintenance.rdlc";
    
             //Parameter
            // 
             ReportViewer1.LocalReport.EnableExternalImages = true; 
             ReportParameter[] rptparams = new ReportParameter[]
             {
                new ReportParameter("Login_Type_Para",Session["Login_Type"].ToString()),
              new ReportParameter("ReportDate_Para",ReportDate),
              new ReportParameter("flatnumber_para",Session["flatnumber"].ToString()),
               new ReportParameter("Logo",logo),
                new ReportParameter("Stamp",stamp),
                new ReportParameter("Sign",sign)
             };
            
             ReportViewer1.LocalReport.SetParameters(rptparams);

             //Refresh

             ReportViewer1.LocalReport.Refresh();

             if (Convert.ToString(Session["Login_Type"]) == "Admin")
             {
                 Session["flatnumber"] = null;
             }


         }


    }
}