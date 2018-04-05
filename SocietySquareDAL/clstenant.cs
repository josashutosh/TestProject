using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SocietySquareDAL;

namespace SocietySquareDAL
{
    public class clstenant
    {
        public string Inserttenant(int tid,string flatno, string name, string residefrom, string resideto, string rent, string pan, string aadhar, string address, string contact1, string contact2,string createdby)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationSettings.AppSettings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[20];

                objSqlParam[0] = new SqlParameter("@FlatNo", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = flatno;

                objSqlParam[1] = new SqlParameter("@TenantName", SqlDbType.VarChar, 100);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = name;

                objSqlParam[2] = new SqlParameter("@ResidingFrom", SqlDbType.DateTime);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = residefrom;

                objSqlParam[3] = new SqlParameter("@ResidingTo", SqlDbType.DateTime);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = resideto;

                objSqlParam[4] = new SqlParameter("@Rent", SqlDbType.Money);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = rent;

                objSqlParam[5] = new SqlParameter("@PAN", SqlDbType.VarChar, 10);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = pan;

                objSqlParam[6] = new SqlParameter("@AadhaarCard", SqlDbType.VarChar, 12);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = aadhar;

                objSqlParam[7] = new SqlParameter("@PermanantAddress", SqlDbType.VarChar, 500);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = address;

                objSqlParam[8] = new SqlParameter("@ContactNo1", SqlDbType.VarChar, 50);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = contact1;

                objSqlParam[9] = new SqlParameter("@ContactNo2", SqlDbType.VarChar, 50);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = contact2;

                objSqlParam[10] = new SqlParameter("@TenantId", SqlDbType.Int);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = tid;

                objSqlParam[11] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[11].Direction = ParameterDirection.Input;
                objSqlParam[11].Value = createdby;

                objSqlParam[12] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[12].Direction = ParameterDirection.Output;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "TenantMasterInsert", objSqlParam);
                return Convert.ToString(objSqlParam[12].Value);
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

        #region Get tenant Details throught Id
        public DataSet GetTenantDetails(int TID)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationSettings.AppSettings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@TenantId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                if (TID == 0)
                {
                    objSqlParam[0].Value = null;
                }
                else
                {
                    objSqlParam[0].Value = TID;
                }

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "TenantGetById", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        #endregion

        public DataSet Getdata()
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationSettings.AppSettings["society"].ToString();
                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "TenantDetailsGet");
                objSqlCon.Close();
                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
