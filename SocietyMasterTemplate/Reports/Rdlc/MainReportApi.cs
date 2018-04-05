using Syncfusion.EJ.ReportViewer;
using Syncfusion.Reports.EJ;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Collections;
using System.Data;
using System.Reflection;
using EsquareMasterTemplate.Reports;

namespace WebApiReportRdlc
{
    public class MonthlyMainReportApi : ApiController,IReportController
    {
        // GET api/<controller>
       //Post action for processing the rdl/rdlc report

        public object PostReportAction(Dictionary<string, object> jsonResult)
        {
            return ReportHelper.ProcessReport(jsonResult, this);
        }

        //Get action for getting resources from the report

        [System.Web.Http.ActionName("GetResource")]
        [AcceptVerbs("GET")]
        public object GetResource(string key, string resourcetype, bool isPrint)

        {
            return ReportHelper.GetResource(key, resourcetype, isPrint);
        }

        //Method will be called when initialize the report options before start processing the report    
        public void OnInitReportOptions(ReportViewerOptions reportOption)

        {

            var reportName = reportOption.ReportModel.ReportPath;
            reportOption.ReportModel.ReportPath = ReportViewerHelper.GetReportPath(reportOption.ReportModel.ReportPath);
            if (reportName.Contains("Product Catalog.rdlc"))
            {
                reportOption.ReportModel.DataSources.Clear();
                reportOption.ReportModel.DataSources.Add(new ReportDataSource { Name = "ProductCatalog", Value = Report.GetData() });
            }
            else if (reportName.Contains("drilldown.rdlc"))
            {
                reportOption.ReportModel.DataSources.Clear();
                reportOption.ReportModel.DataSources.Add(new ReportDataSource { Name = "Customers", Value = Report.GetData() });
            }

        }

 

        //Method will be called when reported is loaded

        public void OnReportLoaded(ReportViewerOptions reportOption)

        {
           
            var reportName = reportOption.ReportModel.ReportPath;
            if (reportName.Contains("Region.rdlc"))
            {
                reportOption.ReportModel.DataSources.Clear();
                reportOption.ReportModel.DataSources.Add(new ReportDataSource { Name = "StoreSales", Value = Report.GetData() });
            }
        }   

    }

}



public class Report
{
    public string ProdSubCat { get; set; }

    public static IList GetData()
    {
        List<Report> datas = new List<Report>();
        Report data = null;
        return datas;
    }
}