using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyDAL;
using System.Configuration;
using SocietyEntity;

namespace SocietyDAL
{
   public class clsMemberMasterDal
   {

       #region GetMemberbyownerID 

       public DataSet GetMemberbyownerID(int ID, string MemberType, int PageIndex, int PageSize, int RecordCount,int FlatId,bool IsRented)
        {
            DataSet ds = new DataSet();
            SqlConnection objSqlCon = new SqlConnection();

            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[7];

                objSqlParam[0] = new SqlParameter("@ID", SqlDbType.VarChar);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = ID;

                objSqlParam[1] = new SqlParameter("@MemberLoginType", SqlDbType.VarChar);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = MemberType;

                objSqlParam[2] = new SqlParameter("@PageIndex", SqlDbType.VarChar);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = PageIndex;

                objSqlParam[3] = new SqlParameter("@PageSize", SqlDbType.VarChar);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = PageSize;

                objSqlParam[4] = new SqlParameter("@RecordCount", SqlDbType.VarChar);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = RecordCount;

                objSqlParam[5] = new SqlParameter("@flatID", SqlDbType.Int);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = FlatId;


                objSqlParam[6] = new SqlParameter("@IsRented", SqlDbType.Bit);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value =  IsRented;


                ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMemberMasterInfoByOwnerID", objSqlParam);
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
            return ds;
        }

       #endregion

       #region GET Info by flatID

       public DataSet GetMemberbyFlatID(int ID, string MemberType, int PageIndex, int PageSize, int RecordCount)
       {
           DataSet ds = new DataSet();
           SqlConnection objSqlCon = new SqlConnection();

           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[5];

               objSqlParam[0] = new SqlParameter("@ID", SqlDbType.VarChar);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = ID;

               objSqlParam[1] = new SqlParameter("@MemberLoginType", SqlDbType.VarChar);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = MemberType;

               objSqlParam[2] = new SqlParameter("@PageIndex", SqlDbType.VarChar);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = PageIndex;

               objSqlParam[3] = new SqlParameter("@PageSize", SqlDbType.VarChar);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = PageSize;

               objSqlParam[4] = new SqlParameter("@RecordCount", SqlDbType.VarChar);
               objSqlParam[4].Direction = ParameterDirection.Input;
               objSqlParam[4].Value = RecordCount;

               ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMemberMasterInfoByFlatID", objSqlParam);
           }
           catch (Exception Ex)
           {
               throw Ex;
           }
           return ds;
       }

       #endregion

       #region GetmemberMasterbyID

       public DataSet GetmemberMasterbyID(string flag, int Id)
       {
           DataSet ds = new DataSet();
           SqlConnection objSqlCon = new SqlConnection();

           try
           {
               objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[2];

               objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = flag;

               objSqlParam[1] = new SqlParameter("@Id", SqlDbType.VarChar);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = Id;

               ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetmemberMasterbyID", objSqlParam);
           }
           catch (Exception Ex)
           {
               throw Ex;
           }
           return ds;
       }

       #endregion

       #region Insert Member Info
           public string InsertMemberMstr(clsMemberMasterEntity objmemberinfo)
           {
               SqlConnection objSqlConn = new SqlConnection();
               try
               {
                   objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                   SqlParameter[] objSqlParam = new SqlParameter[18];

                   objSqlParam[0] = new SqlParameter("@ID", SqlDbType.Int);
                   objSqlParam[0].Direction = ParameterDirection.Input;
                   objSqlParam[0].Value = objmemberinfo.Id;

                   objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.Int);
                   objSqlParam[1].Direction = ParameterDirection.Input;
                   objSqlParam[1].Value = objmemberinfo.FlatId;

                   objSqlParam[2] = new SqlParameter("@Name", SqlDbType.VarChar, 150);
                   objSqlParam[2].Direction = ParameterDirection.Input;
                   objSqlParam[2].Value = objmemberinfo.Name;

                   objSqlParam[3] = new SqlParameter("@ResidingFrom", SqlDbType.VarChar, 50);
                   objSqlParam[3].Direction = ParameterDirection.Input;
                   objSqlParam[3].Value = objmemberinfo.ResidingFrom;

                   objSqlParam[4] = new SqlParameter("@ResidingTo", SqlDbType.VarChar, 50);
                   objSqlParam[4].Direction = ParameterDirection.Input;
                   objSqlParam[4].Value = objmemberinfo.ResidingTO;

                   objSqlParam[5] = new SqlParameter("@Rent", SqlDbType.Money);
                   objSqlParam[5].Direction = ParameterDirection.Input;
                   objSqlParam[5].Value = objmemberinfo.Rent;

                   objSqlParam[6] = new SqlParameter("@PAN", SqlDbType.VarChar, 50);
                   objSqlParam[6].Direction = ParameterDirection.Input;
                   objSqlParam[6].Value = objmemberinfo.PAN;

                   objSqlParam[7] = new SqlParameter("@AadhaarCard", SqlDbType.BigInt);
                   objSqlParam[7].Direction = ParameterDirection.Input;
                   objSqlParam[7].Value = objmemberinfo.AadhaarCard;

                   objSqlParam[8] = new SqlParameter("@PermanantAddress", SqlDbType.VarChar, 550);
                   objSqlParam[8].Direction = ParameterDirection.Input;
                   objSqlParam[8].Value = objmemberinfo.PermanantAddress;

                   objSqlParam[9] = new SqlParameter("@ContactNo1", SqlDbType.BigInt);
                   objSqlParam[9].Direction = ParameterDirection.Input;
                   objSqlParam[9].Value = objmemberinfo.ContactNo1;

                   objSqlParam[10] = new SqlParameter("@ContactNo2", SqlDbType.BigInt);
                   objSqlParam[10].Direction = ParameterDirection.Input;
                   objSqlParam[10].Value = objmemberinfo.ContactNo2;

                   objSqlParam[11] = new SqlParameter("@DOB", SqlDbType.VarChar, 50);
                   objSqlParam[11].Direction = ParameterDirection.Input;
                   objSqlParam[11].Value = objmemberinfo.DOB;

                   objSqlParam[12] = new SqlParameter("@Gender", SqlDbType.VarChar, 50);
                   objSqlParam[12].Direction = ParameterDirection.Input;
                   objSqlParam[12].Value = objmemberinfo.Gender;

                   objSqlParam[13] = new SqlParameter("@OtherRelation", SqlDbType.VarChar, 50);
                   objSqlParam[13].Direction = ParameterDirection.Input;
                   objSqlParam[13].Value = objmemberinfo.OtherRelation;

                   objSqlParam[14] = new SqlParameter("@Relation", SqlDbType.VarChar, 50);
                   objSqlParam[14].Direction = ParameterDirection.Input;
                   objSqlParam[14].Value = objmemberinfo.Relation;

                   objSqlParam[15] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                   objSqlParam[15].Direction = ParameterDirection.Input;
                   objSqlParam[15].Value = objmemberinfo.CreatedBy;

                   objSqlParam[16] = new SqlParameter("@IsRented", SqlDbType.Int);
                   objSqlParam[16].Direction = ParameterDirection.Input;
                   objSqlParam[16].Value = objmemberinfo.IsRented;

                   objSqlParam[17] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                   objSqlParam[17].Direction = ParameterDirection.Output;

                   int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertMemberMaster", objSqlParam);

                   return Convert.ToString(objSqlParam[17].Value);
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

   }
}
