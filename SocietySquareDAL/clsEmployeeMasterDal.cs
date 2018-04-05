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
   public class EmployeeMasterDal
   {
       #region InsertEmployeeInfo
         public string InsertEmployeeInformation(clsEmployeeEntity objEmpEntity)
       {
           SqlConnection objSqlConn = new SqlConnection();

           try
           {
               objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
               SqlParameter[] objSqlParam = new SqlParameter[15];

               objSqlParam[0] = new SqlParameter("@EmployeeId", SqlDbType.VarChar, 50);
               objSqlParam[0].Direction = ParameterDirection.Input;
               objSqlParam[0].Value = objEmpEntity.EmployeeId;

               objSqlParam[1] = new SqlParameter("@Name", SqlDbType.VarChar, 100);
               objSqlParam[1].Direction = ParameterDirection.Input;
               objSqlParam[1].Value = objEmpEntity.Name;

               objSqlParam[2] = new SqlParameter("@EmployeeNo", SqlDbType.VarChar, 50);
               objSqlParam[2].Direction = ParameterDirection.Input;
               objSqlParam[2].Value = objEmpEntity.EmployeeNo;

               objSqlParam[3] = new SqlParameter("@JobDescription", SqlDbType.VarChar, 1000);
               objSqlParam[3].Direction = ParameterDirection.Input;
               objSqlParam[3].Value = objEmpEntity.JobDescription;

               objSqlParam[4] = new SqlParameter("@ContactNo", SqlDbType.BigInt);
               objSqlParam[4].Direction = ParameterDirection.Input;
               objSqlParam[4].Value = objEmpEntity.ContactNo;

               objSqlParam[5] = new SqlParameter("@Address", SqlDbType.VarChar, 100);
               objSqlParam[5].Direction = ParameterDirection.Input;
               objSqlParam[5].Value = objEmpEntity.Address;

               objSqlParam[6] = new SqlParameter("@PAN", SqlDbType.VarChar, 10);
               objSqlParam[6].Direction = ParameterDirection.Input;
               objSqlParam[6].Value = objEmpEntity.PAN;

               objSqlParam[7] = new SqlParameter("@AadhaarCard", SqlDbType.VarChar, 12);
               objSqlParam[7].Direction = ParameterDirection.Input;
               objSqlParam[7].Value = objEmpEntity.AadhaarCard;

               objSqlParam[8] = new SqlParameter("@Salary", SqlDbType.Money);
               objSqlParam[8].Direction = ParameterDirection.Input;
               objSqlParam[8].Value = objEmpEntity.Salary;

               objSqlParam[9] = new SqlParameter("@Designation", SqlDbType.VarChar, 50);
               objSqlParam[9].Direction = ParameterDirection.Input;
               objSqlParam[9].Value = objEmpEntity.Designation;

               objSqlParam[10] = new SqlParameter("@DOJ", SqlDbType.VarChar);
               objSqlParam[10].Direction = ParameterDirection.Input;
               objSqlParam[10].Value = objEmpEntity.DOJ;

               objSqlParam[11] = new SqlParameter("@DOL", SqlDbType.VarChar);
               objSqlParam[11].Direction = ParameterDirection.Input;
               objSqlParam[11].Value = objEmpEntity.DOL;

               objSqlParam[12] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
               objSqlParam[12].Direction = ParameterDirection.Input;
               objSqlParam[12].Value = objEmpEntity.CreatedBy;

               objSqlParam[13] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
               objSqlParam[13].Direction = ParameterDirection.Output;

               objSqlParam[14] = new SqlParameter("@SocietyId", SqlDbType.Int);
               objSqlParam[14].Direction = ParameterDirection.Input;
               objSqlParam[14].Value = objEmpEntity.SocietyId;

               int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertEmployeeInfo", objSqlParam);

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


       #region GetEmployeeInfo

         public DataSet GetAllEmployeeInfo(clsEmployeeEntity objEmpinfo,string LoginId)
         {
             DataSet ds = new DataSet();

             SqlConnection objSqlCon = new SqlConnection();
             try
             {
                 objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                 SqlParameter[] objSqlParam = new SqlParameter[2];

                 objSqlParam[0] = new SqlParameter("@EmployeeId", SqlDbType.Int);
                 objSqlParam[0].Direction = ParameterDirection.Input;
                 objSqlParam[0].Value = objEmpinfo.EmployeeId;

                 objSqlParam[1] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
                 objSqlParam[1].Direction = ParameterDirection.Input;
                 objSqlParam[1].Value = LoginId;

                 ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetEmployeeInfo", objSqlParam);
                 return ds;
             }
             catch (Exception e)
             {
                 throw e;
             }
         }

         #endregion


      


         #region SearchEmployee By EmployeeNo
         public DataSet GetemployeebyEmpNo(clsEmployeeEntity objempinfo, string LoginId)
         {
             SqlConnection objSqlCon = new SqlConnection();
             try
             {
                 objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                 DataSet dsGetDetails = new DataSet();
                 SqlParameter[] objSqlParam = new SqlParameter[4];

                 objSqlParam[0] = new SqlParameter("@EmployeeNo", SqlDbType.VarChar, 150);
                 objSqlParam[0].Direction = ParameterDirection.Input;
                 objSqlParam[0].Value = objempinfo.EmployeeNo;

                 objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                 objSqlParam[1].Direction = ParameterDirection.Input;
                 objSqlParam[1].Value = "searchbyempno";

                 objSqlParam[2] = new SqlParameter("@EmployeeId", SqlDbType.Int);
                 objSqlParam[2].Direction = ParameterDirection.Input;
                 objSqlParam[2].Value = objempinfo.EmployeeId;

                 objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar,100);
                 objSqlParam[3].Direction = ParameterDirection.Input;
                 objSqlParam[3].Value = LoginId;

                 dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetEmployeebyFlag", objSqlParam);

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
