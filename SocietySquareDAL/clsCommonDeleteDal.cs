using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using SocietyDAL;

namespace SocietyDAL
{
    public class clsCommonDeleteDal
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["society"].ConnectionString);
        protected string SqlCmd, SqlCon;
        public void CommonDeleteMaster(string TableName, string FieldName, string ids,string LoginId)
        {
            try
            {

                //ids = ids.Contains(",") ? (ids.Replace(",", "','")) : string.Empty;
                SqlCmd = "Update " + TableName + " set Active = 0,ModifiedOn='"+System.DateTime.Now.ToUniversalTime().ToShortDateString()+"' ,ModifiedBy='" + LoginId + "' where " + FieldName + " in (" + ids + ") and Active =1";
                SqlHelper.ExecuteNonQuery(con, CommandType.Text, SqlCmd);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
