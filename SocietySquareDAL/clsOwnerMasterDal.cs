using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SocietyDAL;
using System.Configuration;
using System.Data;

using SocietyEntity;
namespace SocietyDAL
{
   public class clsOwnerMasterDal
    {
       #region InsertOwnerMaster
       public string InsertOwnerMaster(clsOwnerInfo objownerEntity)
       {
           SqlConnection objSqlConn = new SqlConnection();
           try
           {
               objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[19];

               objSqlParam[0] = new SqlParameter("@OwnerId", SqlDbType.Int);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objownerEntity.ownerId;

               objSqlParam[1] = new SqlParameter("@OwnerName", SqlDbType.VarChar, 100);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objownerEntity.ownername;

               objSqlParam[2] = new SqlParameter("@ContactNo", SqlDbType.BigInt);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objownerEntity.ContactNumber;

               objSqlParam[3] = new SqlParameter("@Occupation", SqlDbType.VarChar, 500);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = objownerEntity.Occupation;

               objSqlParam[4] = new SqlParameter("@OfficeAddress", SqlDbType.VarChar, 1000);
               objSqlParam[4].Direction = ParameterDirection.Input;
               objSqlParam[4].Value = objownerEntity.OfficeAddress;

               objSqlParam[5] = new SqlParameter("@OfficeContactNo", SqlDbType.BigInt);
               objSqlParam[5].Direction = ParameterDirection.Input;
               objSqlParam[5].Value = objownerEntity.OfficeContactNo;

               objSqlParam[6] = new SqlParameter("@PAN", SqlDbType.VarChar, 10);
               objSqlParam[6].Direction = ParameterDirection.Input;
               objSqlParam[6].Value = objownerEntity.PAN;

               objSqlParam[7] = new SqlParameter("@AadhaarCard", SqlDbType.VarChar, 12);
               objSqlParam[7].Direction = ParameterDirection.Input;
               objSqlParam[7].Value = objownerEntity.AdhaarCard;

               objSqlParam[8] = new SqlParameter("@IsCommiteeMember", SqlDbType.Bit);
               objSqlParam[8].Direction = ParameterDirection.Input;
               objSqlParam[8].Value = objownerEntity.IsCommiteeMember;

               objSqlParam[9] = new SqlParameter("@Photo", SqlDbType.VarChar, 250);
               objSqlParam[9].Direction = ParameterDirection.Input;
               objSqlParam[9].Value = objownerEntity.Photo;

               objSqlParam[10] = new SqlParameter("@ResidingFrom", SqlDbType.VarChar,250);
               objSqlParam[10].Direction = ParameterDirection.Input;
               objSqlParam[10].Value = objownerEntity.ResidingFrom;

               objSqlParam[11] = new SqlParameter("@DOB", SqlDbType.VarChar,250);
               objSqlParam[11].Direction = ParameterDirection.Input;
               objSqlParam[11].Value = objownerEntity.DOB;

               objSqlParam[12] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
               objSqlParam[12].Direction = ParameterDirection.Input;
               objSqlParam[12].Value = objownerEntity.CreatedBy;

               objSqlParam[13] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
               objSqlParam[13].Direction = ParameterDirection.Output;

               objSqlParam[14] = new SqlParameter("@permanentAddress", SqlDbType.VarChar, 1000);
               objSqlParam[14].Direction = ParameterDirection.Input;
               objSqlParam[14].Value = objownerEntity.perAddress;

               objSqlParam[15] = new SqlParameter("@TempAddress", SqlDbType.VarChar, 1000);
               objSqlParam[15].Direction = ParameterDirection.Input;
               objSqlParam[15].Value = objownerEntity.TempAddress;

               objSqlParam[16] = new SqlParameter("@Designation", SqlDbType.VarChar, 250);
               objSqlParam[16].Direction = ParameterDirection.Input;
               objSqlParam[16].Value = objownerEntity.Designation;

               objSqlParam[17] = new SqlParameter("@Effectivefrom", SqlDbType.VarChar, 250);
               objSqlParam[17].Direction = ParameterDirection.Input;
               objSqlParam[17].Value = objownerEntity.Effectivefrom;

               objSqlParam[18] = new SqlParameter("@FlatId", SqlDbType.VarChar, 50);
               objSqlParam[18].Direction = ParameterDirection.Input;
               objSqlParam[18].Value = objownerEntity.Flatid;

               int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertOwnerInfo", objSqlParam);

               return Convert.ToString(objSqlParam[13].Value);
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

       #region GetownerInfo

       public DataSet GetownerInfo(clsOwnerInfo objownerinfo, string LoginId)
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
               objSqlParam[0].Value = "getallrecord";

               objSqlParam[1] = new SqlParameter("@Ownername1", SqlDbType.VarChar, 150);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objownerinfo.ownername;

               objSqlParam[2] = new SqlParameter("@OwnerId", SqlDbType.Int);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objownerinfo.ownerId;

               objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 30);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = LoginId;

               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetownerInfo", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }

       #endregion

         #region GetownerInfo

       public DataSet GetownerInfobyID(int ID,string flag)
       {
           DataSet ds = new DataSet();

           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[2];        

               objSqlParam[0] = new SqlParameter("@OwnerId", SqlDbType.Int);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = ID;

               objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value =flag;


               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetownerInfo", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }

       #endregion

       #region Searchowner By PanNo
       public DataSet GetownerbyPan(clsOwnerInfo objownerinfo,string LoginId)
       {
           SqlConnection objSqlCon = new SqlConnection();
           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

               DataSet dsGetDetails = new DataSet();
               SqlParameter[] objSqlParam = new SqlParameter[4];

               objSqlParam[0] = new SqlParameter("@OwnerName1", SqlDbType.VarChar, 150);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objownerinfo.ownername;

               objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = "searchownerinfo";

               objSqlParam[2] = new SqlParameter("@OwnerId", SqlDbType.Int);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objownerinfo.ownerId;

               objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 30);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = LoginId;

               dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetownerInfo", objSqlParam);

               objSqlCon.Close();

               return dsGetDetails;
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }
       #endregion



       #region getowner info by flatid

       public DataSet getownerinfobyflatid(string Id, string LoginId)
       {
           DataSet ds = new DataSet();
           SqlConnection objSqlCon = new SqlConnection();

           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[3];

               objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = "getallrecord";

               objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.VarChar);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = Id;

               objSqlParam[2] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = LoginId;
               ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetOwnerinfobyflatID", objSqlParam);
           }
           catch (Exception Ex)
           {
               throw Ex;
           }
           return ds;
       }

       #endregion
    }
}
