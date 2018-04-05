using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SocietyDAL;
using SocietyEntity;


namespace SocietyDAL
{
    public class clsReportDal
    {


        #region Get Info GetMonthlyDetail entity

        public DataSet GetMonthlyDetail(clsReportParameterEntity objReportEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@Login_Type", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objReportEntity.Login_Type;

                objSqlParam[1] = new SqlParameter("@flatNumber", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objReportEntity.flatNumber;

                objSqlParam[2] = new SqlParameter("@ReportDate", SqlDbType.VarChar, 50);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objReportEntity.ReportDate;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[MonthlyMaintenance]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
      


        }

         #endregion


        #region Get Info GetMonthlyDetail Parameter 

        public DataSet GetMonthlyDetail(string _LoginType, string _ReportDate, int _flatnumber)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@Login_Type", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = _LoginType;

                objSqlParam[1] = new SqlParameter("@flatNumber", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value =  _flatnumber;

                objSqlParam[2] = new SqlParameter("@ReportDate", SqlDbType.VarChar, 50);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = _ReportDate;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[MonthlyMaintenance]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }



        }

        #endregion


        #region GetInfo GetSocietyInfo

        public DataSet GetSocietyInfo()
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[0];

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetSocietyInfo]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }



        }

        #endregion

        #region Get PrimId By FlatMaintainanceID
        public string GetPrimIdByFlatMaintainanceID(clsReportParameterEntity objGetPrimId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@MaintenanceId", SqlDbType.VarChar, 15);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objGetPrimId.FlatmaintenanceId;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 35);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objGetPrimId.PropertyType;



                objSqlParam[2] = new SqlParameter("@Ins_out_Message", SqlDbType.VarChar, 300);
                objSqlParam[2].Direction = ParameterDirection.Output;

                SqlHelper.ExecuteReader(objSqlConn, CommandType.StoredProcedure, "GetPrimIdByFlatMaintainanceID", objSqlParam);

                return objSqlParam[2].Value.ToString();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally 
            {
                objSqlConn.Close();
            }



        }
        #endregion


    }
}
