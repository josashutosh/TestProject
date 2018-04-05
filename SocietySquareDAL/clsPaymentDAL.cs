using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using SocietyDAL;

namespace SocietyDAL
{
    public class clsPaymentDAL
    {
        public int UpdateSuccessfulTrxnDetails(string PropertyType, string MaintenanceID, char flag, double PaidAmount, double Amount, string orderid, string userId, string PaymentDetailId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[9];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PropertyType;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 5);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MaintenanceID;

                objSqlParam[2] = new SqlParameter("@flag", SqlDbType.Char, 1);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = flag;

                objSqlParam[3] = new SqlParameter("@PaidAmount", SqlDbType.Money);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = PaidAmount;

                objSqlParam[4] = new SqlParameter("@Amount", SqlDbType.Money);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = Amount;

                objSqlParam[5] = new SqlParameter("@orderid", SqlDbType.VarChar, 50);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = orderid;

                objSqlParam[6] = new SqlParameter("@InsertedId", SqlDbType.VarChar,12);
                objSqlParam[6].Direction = ParameterDirection.Output;

                objSqlParam[7] = new SqlParameter("@UserID", SqlDbType.VarChar, 50);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = userId;

                objSqlParam[8] = new SqlParameter("@PaymentDetailId", SqlDbType.VarChar);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = PaymentDetailId;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "[UpdateSuccessfulTrxnDetails]", objSqlParam);
                return Convert.ToInt32(objSqlParam[6].Value);
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

        public DataSet GetPaymentReceiptDetails(string PropertyType, string MaintenanceID, char flag, string  PrimId, long societyId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PropertyType;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 5);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MaintenanceID;

                objSqlParam[2] = new SqlParameter("@flag", SqlDbType.Char, 1);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = flag;

                objSqlParam[3] = new SqlParameter("@MaintenanceCollId", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = PrimId;

                objSqlParam[4] = new SqlParameter("@societyId", SqlDbType.BigInt);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = societyId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetPaymentReceiptDetails]", objSqlParam);
                return dsOut;
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

        public DataSet GenerateReceiptMonthly(string PropertyType, string MaintenanceID, char flag, string PrimId, long societyId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PropertyType;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 5);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MaintenanceID;

                objSqlParam[2] = new SqlParameter("@flag", SqlDbType.Char, 1);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = flag;

                objSqlParam[3] = new SqlParameter("@MaintenanceCollId", SqlDbType.VarChar,10);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = PrimId;

                objSqlParam[4] = new SqlParameter("@societyId", SqlDbType.Int);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = societyId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GenerateReceiptMonthly]", objSqlParam);
                return dsOut;
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

        public string InsertPaymentdetail(SocietyEntity.clsPaymentGetwayEntity objPayGetwayEntity)
        {
            SqlConnection con = new SqlConnection();
             con.ConnectionString =     ConfigurationManager.ConnectionStrings["society"].ConnectionString.ToString();
             try
             {
                            SqlParameter[] objsqlparam=new SqlParameter[15];

                 objsqlparam[0] = new SqlParameter("@PaymentDetailId", SqlDbType.BigInt);
                 objsqlparam[0].Direction=ParameterDirection.Input;
                 objsqlparam[0].Value=objPayGetwayEntity.PaymentDetailId;

                 objsqlparam[1] = new SqlParameter("@PgType", SqlDbType.VarChar);
                 objsqlparam[1].Direction = ParameterDirection.Input;
                 objsqlparam[1].Value = objPayGetwayEntity.PgType;


                 objsqlparam[2] = new SqlParameter("@BankRefNumber", SqlDbType.VarChar);
                 objsqlparam[2].Direction = ParameterDirection.Input;
                 objsqlparam[2].Value = objPayGetwayEntity.BankRefNumber;

                 objsqlparam[3] = new SqlParameter("@BankCode", SqlDbType.VarChar);
                 objsqlparam[3].Direction = ParameterDirection.Input;
                 objsqlparam[3].Value = objPayGetwayEntity.BankCode;

                 objsqlparam[4] = new SqlParameter("@Error", SqlDbType.VarChar);
                 objsqlparam[4].Direction = ParameterDirection.Input;
                 objsqlparam[4].Value = objPayGetwayEntity.Error;

                 objsqlparam[5] = new SqlParameter("@Status", SqlDbType.VarChar);
                 objsqlparam[5].Direction = ParameterDirection.Input;
                 objsqlparam[5].Value = objPayGetwayEntity.Status;

                 objsqlparam[6] = new SqlParameter("@ErrorMessage", SqlDbType.VarChar);
                 objsqlparam[6].Direction = ParameterDirection.Input;
                 objsqlparam[6].Value = objPayGetwayEntity.ErrorMessage;

                 objsqlparam[7] = new SqlParameter("@NameOnCard", SqlDbType.VarChar);
                 objsqlparam[7].Direction = ParameterDirection.Input;
                 objsqlparam[7].Value = objPayGetwayEntity.NameOnCard;

                 objsqlparam[8] = new SqlParameter("@CardNumber", SqlDbType.VarChar);
                 objsqlparam[8].Direction = ParameterDirection.Input;
                 objsqlparam[8].Value = objPayGetwayEntity.CardNumber;

                 objsqlparam[9] = new SqlParameter("@PayuMoneyId", SqlDbType.VarChar);
                 objsqlparam[9].Direction = ParameterDirection.Input;
                 objsqlparam[9].Value = objPayGetwayEntity.PayuMoneyId;

                 objsqlparam[10] = new SqlParameter("@NetAmount", SqlDbType.VarChar);
                 objsqlparam[10].Direction = ParameterDirection.Input;
                 objsqlparam[10].Value = objPayGetwayEntity.NetAmount;

                 objsqlparam[11] = new SqlParameter("@Mode", SqlDbType.VarChar);
                 objsqlparam[11].Direction = ParameterDirection.Input;
                 objsqlparam[11].Value = objPayGetwayEntity.Mode;

                 objsqlparam[12] = new SqlParameter("@addedon", SqlDbType.VarChar);
                 objsqlparam[12].Direction = ParameterDirection.Input;
                 objsqlparam[12].Value = objPayGetwayEntity.addedon;

                 objsqlparam[13] = new SqlParameter("@unmappedstatus", SqlDbType.VarChar);
                 objsqlparam[13].Direction = ParameterDirection.Input;
                 objsqlparam[13].Value = objPayGetwayEntity.unmappedstatus;

                 objsqlparam[14] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar,300);
                 objsqlparam[14].Direction = ParameterDirection.Output;

                 long PaymentGetwayId = SqlHelper.ExecuteNonQuery(con, CommandType.StoredProcedure, "InsertPaytmentDeatail", objsqlparam);

                 return Convert.ToString(objsqlparam[14].Value);
             }
             catch (Exception)
             {

                 throw;
             }

             finally {
                 con.Close();            
             }
        }

        public DataSet GenerateMonthlyBill(string PropertyType, string MaintenanceID, long societyId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PropertyType;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 5);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MaintenanceID;

                objSqlParam[2] = new SqlParameter("@societyId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = societyId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GenerateMonthlyBill]", objSqlParam);
                return dsOut;
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


            public DataSet GetMaintenancePaymentReceipt(string PropertyType, string MaintenanceID, long societyId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PropertyType;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 5);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MaintenanceID;

                objSqlParam[2] = new SqlParameter("@societyId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = societyId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "[GetMaintenancePaymentReceipt]", objSqlParam);
                return dsOut;
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
