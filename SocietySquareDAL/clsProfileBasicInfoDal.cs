using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyDAL;
using SocietyEntity;
namespace SocietyDAL
{
  public class clsProfileBasicInfoDal
  {

      #region Insert basic Info
      public string InsertBasicinfo(clsProfileBasicInfoEntity objInsbasicinfo)
      {
          SqlConnection objSqlCon = new SqlConnection();
          try
          {
           

              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objsqlparam = new SqlParameter[17];

              objsqlparam[0] = new SqlParameter("@BasicinfoID", SqlDbType.Int);
              objsqlparam[0].Direction = ParameterDirection.Input;
              objsqlparam[0].Value = objInsbasicinfo.BasicinfoID;

              objsqlparam[1] = new SqlParameter("@ID", SqlDbType.Int);
              objsqlparam[1].Direction = ParameterDirection.Input;
              objsqlparam[1].Value = objInsbasicinfo.ID;

              objsqlparam[2] = new SqlParameter("@Name", SqlDbType.VarChar, 150);
              objsqlparam[2].Direction = ParameterDirection.Input;
              objsqlparam[2].Value = objInsbasicinfo.Name.ToString();

              objsqlparam[3] = new SqlParameter("@PersonalContact", SqlDbType.VarChar, 150);
              objsqlparam[3].Direction = ParameterDirection.Input;
              objsqlparam[3].Value = objInsbasicinfo.PersonalContact;

              objsqlparam[4] = new SqlParameter("@Gender", SqlDbType.VarChar);
              objsqlparam[4].Direction = ParameterDirection.Input;
              objsqlparam[4].Value = objInsbasicinfo.Gender;

              objsqlparam[5] = new SqlParameter("@Birthday", SqlDbType.VarChar);
              objsqlparam[5].Direction = ParameterDirection.Input;
              objsqlparam[5].Value = objInsbasicinfo.Birthday;

              objsqlparam[6] = new SqlParameter("@Relationship", SqlDbType.VarChar, 100);
              objsqlparam[6].Direction = ParameterDirection.Input;
              objsqlparam[6].Value = objInsbasicinfo.Relationship;

              objsqlparam[7] = new SqlParameter("@OtherName", SqlDbType.VarChar, 100);
              objsqlparam[7].Direction = ParameterDirection.Input;
              objsqlparam[7].Value = objInsbasicinfo.OtherName;

              objsqlparam[8] = new SqlParameter("@Interests", SqlDbType.VarChar);
              objsqlparam[8].Direction = ParameterDirection.Input;
              objsqlparam[8].Value = objInsbasicinfo.Interests;

              objsqlparam[9] = new SqlParameter("@Occupation", SqlDbType.VarChar, 100);
              objsqlparam[9].Direction = ParameterDirection.Input;
              objsqlparam[9].Value = objInsbasicinfo.Occupation;

              objsqlparam[10] = new SqlParameter("@Tagline", SqlDbType.NVarChar, 200);
              objsqlparam[10].Direction = ParameterDirection.Input;
              objsqlparam[10].Value = objInsbasicinfo.Tagline;

              objsqlparam[11] = new SqlParameter("@AboutUs", SqlDbType.VarChar, 250);
              objsqlparam[11].Direction = ParameterDirection.Input;
              objsqlparam[11].Value = objInsbasicinfo.AboutUs;

              objsqlparam[12] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
              objsqlparam[12].Direction = ParameterDirection.Input;
              objsqlparam[12].Value = objInsbasicinfo.CreatedBy;

              objsqlparam[13] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
              objsqlparam[13].Direction = ParameterDirection.Output;

              objsqlparam[14] = new SqlParameter("@OfficeContact", SqlDbType.VarChar);
              objsqlparam[14].Direction = ParameterDirection.Input;
              objsqlparam[14].Value = objInsbasicinfo.OfficeContact;

              objsqlparam[15] = new SqlParameter("@Email", SqlDbType.VarChar);
              objsqlparam[15].Direction = ParameterDirection.Input;
              objsqlparam[15].Value = objInsbasicinfo.Email;

              objsqlparam[16] = new SqlParameter("@LoginId", SqlDbType.VarChar);
              objsqlparam[16].Direction = ParameterDirection.Input;
              objsqlparam[16].Value = objInsbasicinfo.LoginId;

              int val = SqlHelper.ExecuteNonQuery(objSqlCon, CommandType.StoredProcedure, "InsertBasicInfo", objsqlparam);
              return Convert.ToString(objsqlparam[13].Value);
          }
          catch (Exception e)
          {
              throw e;
          }
      }
      #endregion

      #region Insert basic Info
      public string InsertOtherinfo(clsProfileBasicInfoEntity objInsbasicinfo)
      {
          SqlConnection objSqlCon = new SqlConnection();
          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objsqlparam = new SqlParameter[15];

              objsqlparam[0] = new SqlParameter("@BasicinfoID", SqlDbType.Int);
              objsqlparam[0].Direction = ParameterDirection.Input;
              objsqlparam[0].Value = objInsbasicinfo.BasicinfoID;

              objsqlparam[1] = new SqlParameter("@ID", SqlDbType.Int);
              objsqlparam[1].Direction = ParameterDirection.Input;
              objsqlparam[1].Value = objInsbasicinfo.ID;

              objsqlparam[2] = new SqlParameter("@WebsiteUrl", SqlDbType.VarChar, 50);
              objsqlparam[2].Direction = ParameterDirection.Input;
              objsqlparam[2].Value = objInsbasicinfo.WebsiteUrl.ToString();

              objsqlparam[3] = new SqlParameter("@Facebook", SqlDbType.VarChar, 150);
              objsqlparam[3].Direction = ParameterDirection.Input;
              objsqlparam[3].Value = objInsbasicinfo.Facebook;

              objsqlparam[4] = new SqlParameter("@Twitter", SqlDbType.VarChar);
              objsqlparam[4].Direction = ParameterDirection.Input;
              objsqlparam[4].Value = objInsbasicinfo.Twitter;

              objsqlparam[5] = new SqlParameter("@GooglePlus", SqlDbType.VarChar);
              objsqlparam[5].Direction = ParameterDirection.Input;
              objsqlparam[5].Value = objInsbasicinfo.GooglePlus;

              objsqlparam[6] = new SqlParameter("@LinkedIn", SqlDbType.VarChar, 20);
              objsqlparam[6].Direction = ParameterDirection.Input;
              objsqlparam[6].Value = objInsbasicinfo.LinkedIn;

              objsqlparam[7] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
              objsqlparam[7].Direction = ParameterDirection.Input;
              objsqlparam[7].Value = objInsbasicinfo.CreatedBy;

              objsqlparam[8] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
              objsqlparam[8].Direction = ParameterDirection.Output;


              int val = SqlHelper.ExecuteNonQuery(objSqlCon, CommandType.StoredProcedure, "InsertOtherinfo", objsqlparam);
              return Convert.ToString(objsqlparam[8].Value);
          }
          catch (Exception e)
          {
              throw e;
          }
      }
      #endregion

      #region Get Info ByID

      public DataSet GetInfoByID(clsProfileBasicInfoEntity objIdinfo)
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
              objSqlParam[0].Value = objIdinfo.flag;

              objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objIdinfo.ID;

              objSqlParam[2] = new SqlParameter("@LoginId", SqlDbType.VarChar);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objIdinfo.LoginId;

              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetProfileInfobyID", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }

      #endregion

      #region Get profileInfo ByID

      public DataSet GetProfileinfoByID(clsProfileBasicInfoEntity objIdinfo)
      {
          DataSet ds = new DataSet();

          SqlConnection objSqlCon = new SqlConnection();
          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

              DataSet dsGetDetails = new DataSet();
              SqlParameter[] objSqlParam = new SqlParameter[4];

              objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = objIdinfo.flag;

              objSqlParam[1] = new SqlParameter("@ID", SqlDbType.Int);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objIdinfo.ID;

              objSqlParam[2] = new SqlParameter("@flatId", SqlDbType.Int);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objIdinfo.flatId;

              objSqlParam[3] = new SqlParameter("@loginId", SqlDbType.VarChar);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = objIdinfo.LoginId;

              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetProfileDetails", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }

      #endregion

      #region Insert basic Info
      public string InsertAvatar(int ID, string avatar, string CreatedBy)
      {
          SqlConnection objSqlCon = new SqlConnection();
          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objsqlparam = new SqlParameter[4];

              objsqlparam[0] = new SqlParameter("@Avatar", SqlDbType.VarChar);
              objsqlparam[0].Direction = ParameterDirection.Input;
              objsqlparam[0].Value = avatar;

              objsqlparam[1] = new SqlParameter("@ID", SqlDbType.Int);
              objsqlparam[1].Direction = ParameterDirection.Input;
              objsqlparam[1].Value = ID;

              objsqlparam[2] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
              objsqlparam[2].Direction = ParameterDirection.Input;
              objsqlparam[2].Value = CreatedBy;

              objsqlparam[3] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
              objsqlparam[3].Direction = ParameterDirection.Output;


              int val = SqlHelper.ExecuteNonQuery(objSqlCon, CommandType.StoredProcedure, "InsertAvatar", objsqlparam);
              return Convert.ToString(objsqlparam[3].Value);
          }
          catch (Exception e)
          {
              throw e;
          }
      }
      #endregion
      
    }
}
