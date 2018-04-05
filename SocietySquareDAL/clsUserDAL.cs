using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using SocietyDAL;
using SocietyDAL;
using SocietyEntity;
using System.Web.UI.WebControls;

namespace SocietyDAL
{
    public class clsUserDAL
    {

        #region Insert Lock
        public string InsertLock(string Username)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objsqlparam = new SqlParameter[2];

                objsqlparam[0] = new SqlParameter("@LoginId", SqlDbType.Int);
                objsqlparam[0].Direction = ParameterDirection.Input;
                objsqlparam[0].Value = Username;

                objsqlparam[1] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objsqlparam[1].Direction = ParameterDirection.Output;

                int val = SqlHelper.ExecuteNonQuery(objSqlCon, CommandType.StoredProcedure, "InsertBasicInfo", objsqlparam);
                return Convert.ToString(objsqlparam[1].Value);
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        #endregion

        public DataSet GetUserDetails(string LoginId)
        {
            SqlConnection objSqlConn = new SqlConnection();

            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@LoginId", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = LoginId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "ValidateLogin", objSqlParam);

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

        public DataSet ForgotPassword(clsUserEntity objuserinfo)
        {
            int intVal;
            DataSet dsOut = new DataSet();
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@EmailID", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objuserinfo.EmailID;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "ForgotPassword", objSqlParam);

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

        public DataSet getinfobyemilid(clsUserEntity objuserinfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@Username", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objuserinfo.EmailID;


                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetInfoByUserName", objSqlParam);

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

        public string fnChangePassword(string pwd, int UID)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[2];

                //objSqlParam[0] = new SqlParameter("@OldPassword", SqlDbType.NVarChar, 150);
                //objSqlParam[0].Direction = ParameterDirection.Input;
                //objSqlParam[0].Value = objUserEntity.OldPassword;

                objSqlParam[0] = new SqlParameter("@NewPassword", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = pwd;

                objSqlParam[1] = new SqlParameter("@UID", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = UID;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "FnchangePassword", objSqlParam);

                return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //objSqlConn.Close();
                objSqlConn = null;
            }
        }

        public string fnChangePassword_profile(string pwd, int UID)
        {

            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[2];

                //objSqlParam[0] = new SqlParameter("@OldPassword", SqlDbType.NVarChar, 150);
                //objSqlParam[0].Direction = ParameterDirection.Input;
                //objSqlParam[0].Value = objUserEntity.OldPassword;

                objSqlParam[0] = new SqlParameter("@NewPassword", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = pwd;

                objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = UID;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "fnChangePasswordprofile", objSqlParam);

                return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //objSqlConn.Close();
                objSqlConn = null;
            }
        }

        public DataSet GetUserInfobyUID(int UID)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@UID", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = UID;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetUserInfobyUID", objSqlParam);

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

        public DataSet GetUserInfo(string UID)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@UID", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = UID;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "Changepassword", objSqlParam);

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

        public DataSet GetCountryList()
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetCountryList");
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

        #region filldropdown
        public void FillDropDown(DropDownList ddl, DataTable dt, string TextField, string ValueField, string SelectText)
        {
            ddl.Items.Clear();
            if (!(dt == null || dt.Rows.Count == 0))
            {
                ddl.DataSource = dt;
                ddl.DataTextField = TextField;
                ddl.DataValueField = ValueField;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem(SelectText, ""));
        }
        #endregion


        public DataSet LockUserByUserName(string Username)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@Username", SqlDbType.VarChar, 100);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = Username;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "LockUserByUserName", objSqlParam);

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





   

        


