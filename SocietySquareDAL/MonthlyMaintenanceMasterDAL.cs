using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using SocietyEntity;

namespace SocietyDAL
{
   public class MonthlyMaintenanceMasterDAL
    {
       public string InsertMonthlymaintainance(clsMonthlyMaintenaceEntity objmaininfo)
       {
           SqlConnection objSqlConn = new SqlConnection();
           DataSet dsOut = new DataSet();
           try
           {
               objSqlConn.ConnectionString = objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

               SqlParameter[] objSqlParam = new SqlParameter[11];

               objSqlParam[0] = new SqlParameter("@MonthlyMaintenaceId", SqlDbType.Int);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objmaininfo.MonthlyMaintenaceId;

               objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar,50);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objmaininfo.PropertyType;

               objSqlParam[2] = new SqlParameter("@CalculationMethod", SqlDbType.VarChar,50);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objmaininfo.CalculationMethod;

               objSqlParam[3] = new SqlParameter("@OwnerMonthlyMaintenance", SqlDbType.Float);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = objmaininfo.OwnerMonthlyMaintenance;

               objSqlParam[4] = new SqlParameter("@TenantMonthlyMaintenance", SqlDbType.Float);
               objSqlParam[4].Direction = ParameterDirection.Input;
               objSqlParam[4].Value = objmaininfo.TenantMonthlyMaintenance;

               objSqlParam[5] = new SqlParameter("@TotalMonthlyMaintenace", SqlDbType.Float);
               objSqlParam[5].Direction = ParameterDirection.Input;
               objSqlParam[5].Value = objmaininfo.TotalMonthlyMaintenace;

               objSqlParam[6] = new SqlParameter("@PerSquareFeetRate", SqlDbType.Float);
               objSqlParam[6].Direction = ParameterDirection.Input;
               objSqlParam[6].Value = objmaininfo.PerSquareFeetRate;


               objSqlParam[7] = new SqlParameter("@EffectiveFromDate", SqlDbType.VarChar);
               objSqlParam[7].Direction = ParameterDirection.Input;
               objSqlParam[7].Value = objmaininfo.EffectiveFromDate;

               objSqlParam[8] = new SqlParameter("@EffectiveToDate", SqlDbType.VarChar);
               objSqlParam[8].Direction = ParameterDirection.Input;
               objSqlParam[8].Value = objmaininfo.EffectiveToDate;


               objSqlParam[9] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
               objSqlParam[9].Direction = ParameterDirection.Input;
               objSqlParam[9].Value = objmaininfo.Createdby;

               objSqlParam[10] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
               objSqlParam[10].Direction = ParameterDirection.Output;

               int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "[InsertMonthlyMaintenanceMaster]", objSqlParam);
               return Convert.ToString(objSqlParam[10].Value);
           }
           catch (Exception ex)
           {
               throw ex;
           }
           finally
           {
               objSqlConn = null;
           }
       }



       public DataSet GetMonthlyMaintainanceinfobyid(clsMonthlyMaintenaceEntity objmaininfo)
       {
           DataSet ds = new DataSet();

           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[1];

               objSqlParam[0] = new SqlParameter("@MonthlyMaintenaceId", SqlDbType.Int);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objmaininfo.MonthlyMaintenaceId;

               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetMonthlyMaintenaceInfobyId]", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }


       public DataSet GetMonthlyRecordbyId(clsMonthlyMaintenaceEntity objmaininfo)
       {
           DataSet ds = new DataSet();

           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[1];

               objSqlParam[0] = new SqlParameter("@MonthlyMaintenaceId", SqlDbType.Int);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objmaininfo.MonthlyMaintenaceId;

               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetMonthlyRecordbyId]", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }




       #region GetMaintainanceInfo

       public DataSet GetMonthlyMaintenanceInfo(clsMonthlyMaintenaceEntity objcominfo)
       {
           DataSet ds = new DataSet();

           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[5];

               objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 30);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objcominfo.flag;

               objSqlParam[1] = new SqlParameter("@CalculationMethod", SqlDbType.VarChar, 50);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objcominfo.CalculationMethod;

               objSqlParam[2] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 50);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objcominfo.PropertyType;

               objSqlParam[3] = new SqlParameter("@EffectiveFromDate", SqlDbType.VarChar, 50);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = objcominfo.EffectiveFromDate;

               objSqlParam[4] = new SqlParameter("@EffectiveToDate", SqlDbType.VarChar, 50);
               objSqlParam[4].Direction = ParameterDirection.Input;
               objSqlParam[4].Value = objcominfo.EffectiveToDate;


               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetMonthlyMaintenanceInfo]", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }

       #endregion
    }
}
