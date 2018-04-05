using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyDAL;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SocietyDAL
{
    public class clsMaintenanceCalculationDal
    {
        public string CalculateMaintenance(int societyid, string PropertyType)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = societyid;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar,15);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = PropertyType;

                DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "CalculateMaintenance", objSqlParam);

                return Convert.ToString(ds.Tables[0].Rows[0][0]);
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

        public DataSet MonthlyPdfGeneration(SocietyEntity.clsMaintenanceCollectionEntity objmainCol)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objmainCol.SocietyId;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 15);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmainCol.PropertyType;

                objSqlParam[2] = new SqlParameter("@Month", SqlDbType.VarChar, 15);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objmainCol.FromMonth;

                objSqlParam[3] = new SqlParameter("@Year", SqlDbType.VarChar, 15);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objmainCol.Fromyear;

                objSqlParam[4] = new SqlParameter("@FlatIds", SqlDbType.VarChar, 400);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objmainCol.FlatIds;

                DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetMaintenanceId]", objSqlParam);

                return ds;
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
    }
}
