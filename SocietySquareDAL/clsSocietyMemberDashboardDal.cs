using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyEntity;

namespace SocietyDAL
{
   public class clsSocietyMemberDashboardDal
   {

       #region Get Info clsSocietyMemberDashboard

       public DataSet GetSocietyMemDashDetail(clsSocietyMemberDashboardEntity objSocMember)
       {
           SqlConnection objSqlConn = new SqlConnection();
           try
           {
               objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[3];

               objSqlParam[0] = new SqlParameter("@LoginType", SqlDbType.VarChar,50);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objSocMember.LoginType;

               objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objSocMember.OwnerID;

               objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objSocMember.FlatID;

               dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetDashboardDetails]", objSqlParam);

               objSqlConn.Close();

               return dsGetDetails;
           }
           catch (Exception e)
           {
               throw e;
           }
       #endregion
       }


        public DataSet GetCommitteeinformation(clsSocietyMemberDashboardEntity objSocMember)
       {
           SqlConnection objSqlConn = new SqlConnection();
           try
           {
               objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
              
               dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetCommitteeinformation]");

               objSqlConn.Close();

               return dsGetDetails;
           }
           catch (Exception e)
           {
               throw e;
           }
      
       }


        public DataSet GetMaintenanceDetail(clsSocietyMemberDashboardEntity objSocMemDashEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[4];

                objSqlParam[0] = new SqlParameter("@LoginType", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objSocMemDashEntity.LoginType;

                objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objSocMemDashEntity.OwnerID;

                objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objSocMemDashEntity.FlatID;

                objSqlParam[3] = new SqlParameter("@MaintenanceId", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objSocMemDashEntity.MaintenanceId;



                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetMaintenanceDetail]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public DataSet GetMultipleFlatDetails(string ownerid)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@OwnerId", SqlDbType.VarChar, 5);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = ownerid;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetMultipleFlatDetails]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }      
        }




        public DataSet GetTotalOutStandingMaintenance(string LoginType, int FlatId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@LoginType", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = LoginType;

                objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = FlatId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetTotalOutStandingMaintenance]", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            } 

        }


   }
}
