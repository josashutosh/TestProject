using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyEntity;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace SocietyDAL
{
    public class SecuritySalaryDAL
    {

        public string InsertSecuritySalary(SecuritySalaryEntity objsecurityinfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[10];

                objSqlParam[0] = new SqlParameter("@SecurityId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objsecurityinfo.SecurityId;

                objSqlParam[1] = new SqlParameter("@CompanyName", SqlDbType.VarChar, 100);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objsecurityinfo.CompanyName;

                objSqlParam[2] = new SqlParameter("@NoOfSecurityGuards", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objsecurityinfo.NoOfSecurityGuards;

                objSqlParam[3] = new SqlParameter("@GuardSalary", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objsecurityinfo.GuardSalary;

                objSqlParam[4] = new SqlParameter("@NoOfSupervisor", SqlDbType.Int);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objsecurityinfo.NoOfSupervisor;

                objSqlParam[5] = new SqlParameter("@SupervisorSalary", SqlDbType.Int);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objsecurityinfo.SupervisorSalary;

                objSqlParam[6] = new SqlParameter("@TotalSalary", SqlDbType.Int);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objsecurityinfo.TotalSalary;

                objSqlParam[7] = new SqlParameter("@TotalGuardsal", SqlDbType.Int);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objsecurityinfo.Totalguardsal;

                objSqlParam[8] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objsecurityinfo.createdBy;

                objSqlParam[9] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[9].Direction = ParameterDirection.Output;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "[InsertSecuritysalaryInfo]", objSqlParam);
                return Convert.ToString(objSqlParam[9].Value);
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