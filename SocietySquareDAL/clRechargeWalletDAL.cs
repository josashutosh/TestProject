using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyEntity;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;


namespace SocietyDAL
{
    public class clRechargeWalletDAL
    {

        public DataSet GetPaymentDetail(clsRechargeWalletEntity objReWallet) 
        {
            var objSqlCon = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["society"].ConnectionString.ToString());

            try
            {
                SqlParameter[] objsqlparam = new SqlParameter[4];


                objsqlparam[0] = new SqlParameter("@MaintenanceId", SqlDbType.VarChar);
                objsqlparam[0].Direction = ParameterDirection.Input;
                objsqlparam[0].Value = objReWallet.MaintenanceId;

                objsqlparam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar);
                objsqlparam[1].Direction = ParameterDirection.Input;
                objsqlparam[1].Value = objReWallet.proptype;

                objsqlparam[2] = new SqlParameter("@flag", SqlDbType.Char);
                objsqlparam[2].Direction = ParameterDirection.Input;
                objsqlparam[2].Value = objReWallet.flag;

                objsqlparam[3] = new SqlParameter("@Id", SqlDbType.Int);
                objsqlparam[3].Direction = ParameterDirection.Input;
                objsqlparam[3].Value = Convert.ToInt32(objReWallet.Id);

                DataSet ds = (DataSet)SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMaintenanceInformation", objsqlparam);

                return ds;

            }
            catch (Exception)
            {

                throw;
            }
            finally {
                objSqlCon = null;
            }
        }


    }
}
