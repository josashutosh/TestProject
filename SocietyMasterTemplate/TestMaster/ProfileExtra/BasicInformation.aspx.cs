using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using SocietySquareDAL;
using SocietySquareEntity;
using System.Web.Script.Serialization;
namespace EsquareMasterTemplate.Profile.ProfileExtra
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }

        [WebMethod]
        public static string CheckBasicInfoCount()
        {
            string count = "";
            String daresult = null;
            clsProfileBasicInfoDal objBasicinfoDal = new clsProfileBasicInfoDal();
            clsProfileBasicInfoEntity objBasicinfo = new clsProfileBasicInfoEntity();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            objBasicinfo.flag = "BasicinfobyID";
           string id1=HttpContext.Current.Session["ID"].ToString();
            //string id1 = "1";
           objBasicinfo.ID = Convert.ToInt32(id1);
            ds = objBasicinfoDal.GetInfoByID(objBasicinfo);
            if (ds.Tables[0].Rows.Count > 0)
            {
                

                dt = ds.Tables[0];
                //dt.WriteXml("abc.xml");
                daresult = DataSetToJSON(dt);
            }
            else 
            {
               
                daresult = Convert.ToString(ds.Tables[0].Rows.Count);
            }

            return daresult;
          
        }


        public static string DataSetToJSON(DataTable dt)
        {

            Dictionary<string, object> dict = new Dictionary<string, object>();
            //foreach (DataTable dt in ds.Tables)
            //{
            object[] arr = new object[dt.Rows.Count + 1];

            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                arr[i] = dt.Rows[i].ItemArray;
            }

            dict.Add(dt.TableName, arr);
            //}

            JavaScriptSerializer json = new JavaScriptSerializer();
            return json.Serialize(dict);
        }

    }
}