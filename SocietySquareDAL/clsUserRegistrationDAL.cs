using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using SocietyDAL;
using SocietyEntity;



namespace SocietyDAL
{
   public class clsUserRegistrationDAL
    {
       SqlConnection objSqlConn = new SqlConnection();
        public string SqlCmd, SqlCon;
        public DataSet ds;

         #region Registration
        public string InsertUserRegisterInfo(clsUserEntity objuserinfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[12];

                objSqlParam[0] = new SqlParameter("@UID", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objuserinfo.UID;

                objSqlParam[1] = new SqlParameter("@emailid", SqlDbType.VarChar,50);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objuserinfo.EmailID;

                objSqlParam[2] = new SqlParameter("@mobileno", SqlDbType.VarChar, 15);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objuserinfo.mobileno;

                objSqlParam[3] = new SqlParameter("@Country", SqlDbType.VarChar, 100);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objuserinfo.Country;

                objSqlParam[4] = new SqlParameter("@City", SqlDbType.VarChar,150);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objuserinfo.City;

                objSqlParam[5] = new SqlParameter("@username", SqlDbType.VarChar, 50);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objuserinfo.username;

                objSqlParam[6] = new SqlParameter("@password", SqlDbType.NVarChar, 200);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objuserinfo.password;

                objSqlParam[7] = new SqlParameter("@LoginType", SqlDbType.VarChar,20);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objuserinfo.LoginType;

                objSqlParam[8] = new SqlParameter("@RoleID", SqlDbType.Int);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objuserinfo.RoleID;

                objSqlParam[9] = new SqlParameter("@Subscription", SqlDbType.Int);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objuserinfo.Subscription;

                objSqlParam[10] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objuserinfo.CreatedBy;

                objSqlParam[11] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 300);
                objSqlParam[11].Direction = ParameterDirection.Output;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "SocietyRegistrationGuest", objSqlParam);

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

       public DataSet GetMenu(string RoleId, string Opt, string MenuName)
       {
           try
           {
               objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[3];

               objSqlParam[0] = new SqlParameter("@RoleId", SqlDbType.VarChar);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = RoleId;

               objSqlParam[1] = new SqlParameter("@UID", SqlDbType.VarChar);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = Opt;

               objSqlParam[2] = new SqlParameter("@Parentid", SqlDbType.VarChar);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = MenuName;

               ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "Get_MenuTab", objSqlParam);
           }
           catch (Exception ex)
           {
               throw ex;
           }
           return ds;
       }


       //public DataSet GetUserInfo(string strUser, string uid)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();
       //    DataSet dsOut = new DataSet();
       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[3];

       //        objSqlParam[0] = new SqlParameter("@UserName", SqlDbType.VarChar, 100);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = strUser;

       //        objSqlParam[2] = new SqlParameter("@UID", SqlDbType.Int);
       //        objSqlParam[2].Direction = ParameterDirection.Input;
       //        objSqlParam[2].Value = Convert.ToInt32(uid);

       //        dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "LoginCheck", objSqlParam);

       //        return dsOut;
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {

       //        objSqlConn = null;
       //    }
       //}

       //public DataSet GetInfoForReset(string addmisID, string ddlusertype)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();
       //    DataSet dsOut = new DataSet();
       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[2];

       //        objSqlParam[0] = new SqlParameter("@loginID", SqlDbType.NVarChar);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = addmisID;

       //        objSqlParam[1] = new SqlParameter("@LoginType", SqlDbType.NVarChar);
       //        objSqlParam[1].Direction = ParameterDirection.Input;
       //        objSqlParam[1].Value = ddlusertype;

       //        dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "Get_InfoForResetPassword", objSqlParam);

       //        return dsOut;
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {

       //        objSqlConn = null;
       //    }
       //}

       //public string fnChangePassword(string strEncPass, string uid)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();
       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[2];

       //        objSqlParam[0] = new SqlParameter("@NewPassword", SqlDbType.VarChar, 100);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = strEncPass;

       //        objSqlParam[1] = new SqlParameter("@UID", SqlDbType.VarChar, 100);
       //        objSqlParam[1].Direction = ParameterDirection.Input;
       //        objSqlParam[1].Value = Convert.ToInt32(uid);

       //        int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "ChangePassword", objSqlParam);

       //        return "";
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {
       //        objSqlConn = null;
       //    }
       //}

       //public string fnResetPassword(string strEncPass, string logintype, string loginID)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();
       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[3];

       //        objSqlParam[0] = new SqlParameter("@NewPassword", SqlDbType.NVarChar, 150);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = strEncPass;

       //        objSqlParam[0] = new SqlParameter("@LoginType", SqlDbType.VarChar, 100);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = logintype;

       //        objSqlParam[1] = new SqlParameter("@LoginId", SqlDbType.VarChar, 100);
       //        objSqlParam[1].Direction = ParameterDirection.Input;
       //        objSqlParam[1].Value = loginID;

       //        int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "ResetPassword", objSqlParam);

       //        return "";
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {
       //        //objSqlConn.Close();
       //        objSqlConn = null;
       //    }
       //}

       //public string InsertUserInformation(clsUserEntity objuserEntity)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();

       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[7];

       //        objSqlParam[0] = new SqlParameter("@fullname", SqlDbType.VarChar);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = objuserEntity.fullname;

       //        objSqlParam[1] = new SqlParameter("@login_id", SqlDbType.VarChar);
       //        objSqlParam[1].Direction = ParameterDirection.Input;
       //        objSqlParam[1].Value = objuserEntity.strloginID;

       //        objSqlParam[2] = new SqlParameter("@LoginType", SqlDbType.VarChar);
       //        objSqlParam[2].Direction = ParameterDirection.Input;
       //        objSqlParam[2].Value = objuserEntity.strlogintype;

       //        objSqlParam[3] = new SqlParameter("@password", SqlDbType.VarChar);
       //        objSqlParam[3].Direction = ParameterDirection.Input;
       //        objSqlParam[3].Value = objuserEntity.password;

       //        objSqlParam[4] = new SqlParameter("@emailid", SqlDbType.VarChar);
       //        objSqlParam[4].Direction = ParameterDirection.Input;
       //        objSqlParam[4].Value = objuserEntity.emailid;

       //        objSqlParam[5] = new SqlParameter("@Role_ID", SqlDbType.Int);
       //        objSqlParam[5].Direction = ParameterDirection.Input;
       //        objSqlParam[5].Value = objuserEntity.roleid;

       //        objSqlParam[6] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
       //        objSqlParam[6].Direction = ParameterDirection.Output;

       //        int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "UserInfoInsert", objSqlParam);

       //        return Convert.ToString(objSqlParam[6].Value);
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {
       //        objSqlConn = null;
       //    }

       //}

       //public DataSet RegistrationUserGet(string opt, string Name, string code, string loginID, string logintype)
       //{
       //    SqlConnection objSqlConn = new SqlConnection();

       //    try
       //    {
       //        objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["PUCollege"].ToString();

       //        SqlParameter[] objSqlParam = new SqlParameter[7];

       //        objSqlParam[0] = new SqlParameter("@opt", SqlDbType.VarChar);
       //        objSqlParam[0].Direction = ParameterDirection.Input;
       //        objSqlParam[0].Value = opt;

       //        objSqlParam[1] = new SqlParameter("@login_id", SqlDbType.VarChar);
       //        objSqlParam[1].Direction = ParameterDirection.Input;
       //        objSqlParam[1].Value = loginID;

       //        objSqlParam[2] = new SqlParameter("@LoginType", SqlDbType.VarChar);
       //        objSqlParam[2].Direction = ParameterDirection.Input;
       //        objSqlParam[2].Value = logintype;

       //        objSqlParam[3] = new SqlParameter("@Name", SqlDbType.VarChar);
       //        objSqlParam[3].Direction = ParameterDirection.Input;
       //        objSqlParam[3].Value = Name;

       //        objSqlParam[4] = new SqlParameter("@code", SqlDbType.VarChar);
       //        objSqlParam[4].Direction = ParameterDirection.Input;
       //        objSqlParam[4].Value = code;

       //        DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "RegistrationUserGet", objSqlParam);

       //        return ds;
       //    }
       //    catch (Exception ex)
       //    {
       //        throw ex;
       //    }
       //    finally
       //    {
       //        objSqlConn = null;
       //    }

       //}
    }
}


    
