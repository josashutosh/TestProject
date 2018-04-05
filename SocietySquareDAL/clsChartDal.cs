using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyEntity;

namespace SocietyDAL
{
   public class clsChartDal
    {
       #region GetEmployeeInfo

       public DataSet GetChart(clsChartEntity objChart)
       {
           DataSet ds = new DataSet();

           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[2];

               objSqlParam[0] = new SqlParameter("@SocietyId", SqlDbType.BigInt);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objChart.SocietyId;

               objSqlParam[1] = new SqlParameter("@Flag", SqlDbType.VarChar, 50);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objChart.Flag;

               ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetChartDetail", objSqlParam);
               return ds;
           }
           catch (Exception e)
           {
               throw e;
           }
       }

       #endregion
    }
}
