using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyEntity;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace SocietyDAL
{
    public class clsPettyCashDal
    {
        public DataSet InsertPettyCashdetail(clsPettyCashEntity objPettyCashEntity)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ConnectionString.ToString();
            try
            {
                SqlParameter[] objsqlparam = new SqlParameter[6];

                objsqlparam[0] = new SqlParameter("@PettyCashId", SqlDbType.BigInt);
                objsqlparam[0].Direction = ParameterDirection.Input;
                objsqlparam[0].Value = objPettyCashEntity.PettyCashId;

                objsqlparam[1] = new SqlParameter("@transactionTypes", SqlDbType.VarChar);
                objsqlparam[1].Direction = ParameterDirection.Input;
                objsqlparam[1].Value = objPettyCashEntity.TransctionType;


                objsqlparam[2] = new SqlParameter("@ExpenseDecription", SqlDbType.VarChar);
                objsqlparam[2].Direction = ParameterDirection.Input;
                objsqlparam[2].Value = objPettyCashEntity.ExpenseDecription;

                objsqlparam[3] = new SqlParameter("@Amount", SqlDbType.Float);
                objsqlparam[3].Direction = ParameterDirection.Input;
                objsqlparam[3].Value = objPettyCashEntity.Amount;

                objsqlparam[4] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
                objsqlparam[4].Direction = ParameterDirection.Input;
                objsqlparam[4].Value = objPettyCashEntity.CreatedBy;

                objsqlparam[5] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objsqlparam[5].Direction = ParameterDirection.Input;
                objsqlparam[5].Value = objPettyCashEntity.SocietyId;

                DataSet ds =SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "InsertPettyCash", objsqlparam);

                return ds;
            }
            catch (Exception)
            {

                throw;
            }

            finally
            {
                con.Close();
            }
        }

        public DataSet GetPettyCashBalanceAmount(clsPettyCashEntity objPettyCashEntity)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ConnectionString.ToString();
            try
            {
                SqlParameter[] objsqlparam = new SqlParameter[6];

                objsqlparam[0] = new SqlParameter("@SocietyId", SqlDbType.BigInt);
                objsqlparam[0].Direction = ParameterDirection.Input;
                objsqlparam[0].Value = objPettyCashEntity.SocietyId;

               DataSet ds =SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "GetPettyCashBalanceAmount", objsqlparam);

                return ds;
            }
             catch (Exception)
            {

                throw;
            }

            finally
            {
                con.Close();
            }
        }
    }
}
