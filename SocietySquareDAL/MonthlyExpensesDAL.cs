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
    public class MonthlyExpensesDAL
    {
        public string InsertMonthlyExpenses(SocietyMonthlyExpensesEntity objuserinfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[19];

                objSqlParam[0] = new SqlParameter("@MonthlyExpenseId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objuserinfo.MonthlyExpenseId;

                objSqlParam[1] = new SqlParameter("@SecurityId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objuserinfo.SecurityId;

                objSqlParam[2] = new SqlParameter("@PowerCharges", SqlDbType.Float);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objuserinfo.PowerCharges;

                objSqlParam[3] = new SqlParameter("@WaterCharges", SqlDbType.Float);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objuserinfo.WaterCharges;

                objSqlParam[4] = new SqlParameter("@HousekeepingSalary", SqlDbType.Float);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objuserinfo.HousekeepingSalary;

                objSqlParam[5] = new SqlParameter("@ManagerSalary", SqlDbType.Float);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objuserinfo.ManagerSalary;

                objSqlParam[6] = new SqlParameter("@Stationary", SqlDbType.Float);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objuserinfo.Stationary;

                objSqlParam[7] = new SqlParameter("@DgSet", SqlDbType.Float);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objuserinfo.DgSet;

                objSqlParam[8] = new SqlParameter("@GymInstructor", SqlDbType.Float);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objuserinfo.GymInstructor;

                objSqlParam[9] = new SqlParameter("@CommunityHall", SqlDbType.Float);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objuserinfo.CommunityHall;

                objSqlParam[10] = new SqlParameter("@InsurancePremium", SqlDbType.Float);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objuserinfo.InsurancePremium;

                objSqlParam[11] = new SqlParameter("@Miscellaneous", SqlDbType.Float);
                objSqlParam[11].Direction = ParameterDirection.Input;
                objSqlParam[11].Value = objuserinfo.Miscellaneous;

                objSqlParam[12] = new SqlParameter("@SupervisorSalary", SqlDbType.Float);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = objuserinfo.SupervisorSalary;

                objSqlParam[13] = new SqlParameter("@SumTotal", SqlDbType.Float);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = objuserinfo.SumTotal;

                objSqlParam[14] = new SqlParameter("@FromDate", SqlDbType.VarChar);
                objSqlParam[14].Direction = ParameterDirection.Input;
                objSqlParam[14].Value = objuserinfo.FromDate;

                objSqlParam[15] = new SqlParameter("@ToDate", SqlDbType.VarChar);
                objSqlParam[15].Direction = ParameterDirection.Input;
                objSqlParam[15].Value = objuserinfo.ToDate;

                objSqlParam[16] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[16].Direction = ParameterDirection.Input;
                objSqlParam[16].Value = objuserinfo.CreatedBy;


                objSqlParam[17] = new SqlParameter("@SecuritySalary", SqlDbType.Float);
                objSqlParam[17].Direction = ParameterDirection.Input;
                objSqlParam[17].Value = objuserinfo.SecuritySalary;

                objSqlParam[18] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                objSqlParam[18].Direction = ParameterDirection.Output;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "[InsertMonthlyExpenses]", objSqlParam);

                return Convert.ToString(objSqlParam[18].Value);
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




        public DataSet GetSalary(SocietyMonthlyExpensesEntity objuserinfo)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[getGuardsSalary]");
                return ds;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
