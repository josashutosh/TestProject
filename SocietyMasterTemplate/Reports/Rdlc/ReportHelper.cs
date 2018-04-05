using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EsquareMasterTemplate.Reports
{
    public class ReportViewerHelper
    {
        public static string GetReportPath(string path)
        {
            string serverPath = System.Web.HttpContext.Current.Server.MapPath("");
            //string serverSamplePath = serverPath.Substring(0, serverPath.IndexOf(""));
            //serverSamplePath += @"Rdlc\" + path;
             serverPath += @"\Rdlc\" + path;
             return serverPath;
        }
    }
}