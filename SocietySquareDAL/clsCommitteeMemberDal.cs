using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyDAL;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using SocietyDAL;
using SocietyEntity;

namespace SocietyDAL
{
 public class clsCommitteeMemberDal
 {
     #region insert Committee Memeber master
   
        public string Insertmaintainance(clsCommitteeMemberEntity objComMstr)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[8];
                
                objSqlParam[0] = new SqlParameter("@CommiteeMemberId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objComMstr.CommiteeMemberId;

                objSqlParam[1] = new SqlParameter("@OwnerId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objComMstr.OwnerId;

                objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objComMstr.FlatId;

                objSqlParam[3] = new SqlParameter("@Designation",SqlDbType.VarChar, 100);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objComMstr.Designation;

                objSqlParam[4] = new SqlParameter("@EffectiveFrom", SqlDbType.VarChar, 100);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objComMstr.EffectiveFrom;

                objSqlParam[6] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objComMstr.CreatedBy;

                objSqlParam[7] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[7].Direction = ParameterDirection.Output;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertCommitteeMaster", objSqlParam);
                return Convert.ToString(objSqlParam[7].Value);
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

     #region GetComitteeInfo

        public DataSet GetcommitteeInfo(clsCommitteeMemberEntity objcominfo)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objcominfo.flag;

                objSqlParam[1] = new SqlParameter("@Designation", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objcominfo.Designation;

                objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objcominfo.FlatId;


                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetCommitteeInfo", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

     #region GetCommitteeInfoid

        public DataSet GetCommitteeInfoid(clsCommitteeMemberEntity objcominfo)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objcominfo.flag;

                objSqlParam[1] = new SqlParameter("@CommiteeMemberId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objcominfo.CommiteeMemberId;


                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetCommitteeInfobyid", objSqlParam);

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
