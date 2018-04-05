using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.IO;

namespace EsquareMasterTemplate.Common.Handler
{
    /// <summary>
    /// Summary description for UploadFile
    /// </summary>
    public class UploadFile : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {
                string fname = string.Empty;
                string fileName = string.Empty;
                string Extension = string.Empty;
                string Filepath = string.Empty;
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                 
                    string filepath = context.Server.MapPath("../../Images/Document/FlatMaster/TempFlatfile/");

                  Filepath=  context.Request["Filepath"];

                    if(!System.IO.Directory.Exists(filepath))
                    {
                        System.IO.Directory.CreateDirectory(filepath);
                    }

                    Extension = Path.GetExtension(file.FileName).ToLower().Trim();

                    CommonHelper.DeleteAllFile(filepath);

                    DateTime d = DateTime.Now;
                    string dateString = d.ToString("yyyyMMddHHmmss");
                     fileName = context.Session["Id"].ToString() + Filepath+"TempView" + dateString;

                    
                    fname = filepath + fileName + Extension;
                    file.SaveAs(fname);
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write(fileName + Extension);
            }    
     
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}