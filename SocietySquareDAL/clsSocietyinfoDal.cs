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
    public class clsSocietyinfoDal
    {
        #region Insert Society Info
        public string InsertSocietyMaster(clsSocietyInformationEntity objsocInfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[19];

                objSqlParam[0] = new SqlParameter("@ID", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objsocInfo.Id;

                objSqlParam[1] = new SqlParameter("@societyName", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objsocInfo.societyName;

                objSqlParam[2] = new SqlParameter("@SocietyAddress", SqlDbType.VarChar, 1000);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objsocInfo.SocietyAddress;

                objSqlParam[3] = new SqlParameter("@BuildingCount", SqlDbType.Int );
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objsocInfo.BuildingCount;

                objSqlParam[4] = new SqlParameter("@FlatCount", SqlDbType.Int);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objsocInfo.FlatCount;

                objSqlParam[5] = new SqlParameter("@RegistrationNumber", SqlDbType.VarChar, 50);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objsocInfo.RegistrationNumber;

                objSqlParam[6] = new SqlParameter("@FuLogo", SqlDbType.VarChar, 150);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objsocInfo.FuLogo;

                objSqlParam[7] = new SqlParameter("@fustamp", SqlDbType.VarChar, 150);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objsocInfo.fustamp;

                objSqlParam[8] = new SqlParameter("@fuSign", SqlDbType.VarChar, 150);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objsocInfo.fuSign;

                objSqlParam[9] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objsocInfo.CreatedBy;

                objSqlParam[10] = new SqlParameter("@ModifiedBy", SqlDbType.VarChar, 20);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objsocInfo.ModifiedBy;

                objSqlParam[11] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                objSqlParam[11].Direction = ParameterDirection.Output;

                objSqlParam[12] = new SqlParameter("@IntrestRate", SqlDbType.Float);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = objsocInfo.IntrestRate;

                objSqlParam[13] = new SqlParameter("@ReceiptNotes", SqlDbType.VarChar,4000);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = objsocInfo.ReceiptNotes;

                objSqlParam[14] = new SqlParameter("@accountNumber", SqlDbType.VarChar);
                objSqlParam[14].Direction = ParameterDirection.Input;
                objSqlParam[14].Value = objsocInfo.accountNumber;

                objSqlParam[15] = new SqlParameter("@branch", SqlDbType.VarChar);
                objSqlParam[15].Direction = ParameterDirection.Input;
                objSqlParam[15].Value = objsocInfo.branch;

                objSqlParam[16] = new SqlParameter("@bankName", SqlDbType.VarChar);
                objSqlParam[16].Direction = ParameterDirection.Input;
                objSqlParam[16].Value = objsocInfo.bankName;

                objSqlParam[17] = new SqlParameter("@Ifsc", SqlDbType.VarChar);
                objSqlParam[17].Direction = ParameterDirection.Input;
                objSqlParam[17].Value = objsocInfo.Ifsc ;

                objSqlParam[18] = new SqlParameter("@SenderName", SqlDbType.VarChar);
                objSqlParam[18].Direction = ParameterDirection.Input;
                objSqlParam[18].Value = objsocInfo.SenderName;
              
           
                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertSocietyInfo", objSqlParam);

                return Convert.ToString(objSqlParam[11].Value);
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
        #endregion


        #region Get profileInfo ByID

        public DataSet GetSocietyinfoByID(clsSocietyInformationEntity objsocInfo)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objsocInfo.flag;

                objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objsocInfo.Id;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetSocietyInfobyFlag", objSqlParam);

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
