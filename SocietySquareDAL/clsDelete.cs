using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyDAL;

namespace SocietyDAL
{
    public class clsDelete
    {
        protected string SqlCmd, SqlCon;
        DBHelper objDBHelper = new DBHelper();
       
        public void CommonDelete(string TableName, string FieldName, string ids)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                //ids = ids.Contains(",") ? (ids.Replace(",", "','")) : string.Empty;
                SqlCmd = "Update " + TableName + " set Active = 0 where " + FieldName + " in (" + ids + ") and Active =1";
                SqlHelper.ExecuteNonQuery(objSqlCon, CommandType.Text, SqlCmd);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
