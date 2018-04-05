using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SocietyDAL;
using System.Configuration;
using SocietyDAL;
using System.Web.UI.WebControls;
using SocietyEntity;

namespace SocietyDAL
{
    public class clsMaintainanceMasterDal
    {
        public string Insertmaintainance(clsMaintenanceMstrEntity objmaininfo)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[29];

                objSqlParam[0] = new SqlParameter("@MaintenanceID", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objmaininfo.MaintenanceID;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar,100);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmaininfo.PropertyType;

                objSqlParam[2] = new SqlParameter("@CalculationMethod", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objmaininfo.CalcMasterID;

                objSqlParam[3] = new SqlParameter("@ElectricityCharges", SqlDbType.Float);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objmaininfo.ElectricityCharges;

                objSqlParam[4] = new SqlParameter("@SecuritySalary", SqlDbType.Float);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objmaininfo.SecuritySalary;
                
                objSqlParam[5] = new SqlParameter("@HousekeepingSalary", SqlDbType.Float);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objmaininfo.HousekeepingSalary;

                objSqlParam[6] = new SqlParameter("@ManagerSalary", SqlDbType.Float);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objmaininfo.ManagerSalary;

                objSqlParam[7] = new SqlParameter("@Stationary", SqlDbType.Float);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objmaininfo.Stationary;

                objSqlParam[8] = new SqlParameter("@DgSet", SqlDbType.Float);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objmaininfo.DgSet;

                objSqlParam[9] = new SqlParameter("@GymInstructor", SqlDbType.Float);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objmaininfo.GymInstructor;

                objSqlParam[10] = new SqlParameter("@CommunityHall", SqlDbType.Float);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objmaininfo.CommunityHall;

                objSqlParam[12] = new SqlParameter("@InsuranceCharges", SqlDbType.Float);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = objmaininfo.InsuranceCharges;
                
                objSqlParam[13] = new SqlParameter("@OtherCharges", SqlDbType.Float);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = objmaininfo.Miscellaneous;

                objSqlParam[14] = new SqlParameter("@TenantMaintenance", SqlDbType.Float);
                objSqlParam[14].Direction = ParameterDirection.Input;
                objSqlParam[14].Value = objmaininfo.TenantMaintenance;

                objSqlParam[15] = new SqlParameter("@TotalMaintenanceSum", SqlDbType.Float);
                objSqlParam[15].Direction = ParameterDirection.Input;
                objSqlParam[15].Value = objmaininfo.TotalMaintenanceSum;

                objSqlParam[16] = new SqlParameter("@MaintenancePerFlat", SqlDbType.Float);
                objSqlParam[16].Direction = ParameterDirection.Input;
                objSqlParam[16].Value = objmaininfo.MaintenancePerFlat;

                objSqlParam[17] = new SqlParameter("@PerSquareFeetRate", SqlDbType.Float);
                objSqlParam[17].Direction = ParameterDirection.Input;
                objSqlParam[17].Value = objmaininfo.PerSquareFeetRate;

                objSqlParam[18] = new SqlParameter("@FixedSqft", SqlDbType.Int);
                objSqlParam[18].Direction = ParameterDirection.Input;
                objSqlParam[18].Value = objmaininfo.FixedSqft;

                objSqlParam[19] = new SqlParameter("@FixedRate", SqlDbType.Float);
                objSqlParam[19].Direction = ParameterDirection.Input;
                objSqlParam[19].Value = objmaininfo.FixedRate;

                objSqlParam[20] = new SqlParameter("@AdditionalSqft", SqlDbType.Int);
                objSqlParam[20].Direction = ParameterDirection.Input;
                objSqlParam[20].Value = objmaininfo.AdditionalSqft;

                objSqlParam[21] = new SqlParameter("@AdditionalSqftRate", SqlDbType.Float);
                objSqlParam[21].Direction = ParameterDirection.Input;
                objSqlParam[21].Value = objmaininfo.AdditionalSqftRate;

                objSqlParam[22] = new SqlParameter("@WaterCharges", SqlDbType.Float);
                objSqlParam[22].Direction = ParameterDirection.Input;
                objSqlParam[22].Value = objmaininfo.WaterCharges;

                objSqlParam[23] = new SqlParameter("@EffectiveFromDate", SqlDbType.VarChar);
                objSqlParam[23].Direction = ParameterDirection.Input;
                objSqlParam[23].Value = objmaininfo.EffectiveFromDate;

                objSqlParam[24] = new SqlParameter("@EffectiveToDate", SqlDbType.VarChar);
                objSqlParam[24].Direction = ParameterDirection.Input;
                objSqlParam[24].Value = objmaininfo.EffectiveToDate;
                
                objSqlParam[25] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[25].Direction = ParameterDirection.Input;
                objSqlParam[25].Value = objmaininfo.Createdby;

                objSqlParam[26] = new SqlParameter("@SupervisorSalary", SqlDbType.Float);
                objSqlParam[26].Direction = ParameterDirection.Input;
                objSqlParam[26].Value = objmaininfo.SupervisorSalary;

                objSqlParam[27] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[27].Direction = ParameterDirection.Output;

                objSqlParam[28] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objSqlParam[28].Direction = ParameterDirection.Input;
                objSqlParam[28].Value = objmaininfo.SocietyId;
                
                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertMaintenanceMaster", objSqlParam);
                return Convert.ToString(objSqlParam[27].Value);
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


        public DataSet GetMaintainanceinfobyid(clsMaintenanceMstrEntity objmaininfo)
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
                objSqlParam[0].Value = objmaininfo.flag;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmaininfo.MaintenanceID;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "MaintenanceGetById", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        #region GetMaintainanceInfo

        public DataSet GetMaintainanceInfo(clsMaintenanceMstrEntity objcominfo,string LoginId)
        {
            DataSet ds = new DataSet();
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[6];

                objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objcominfo.flag;

                objSqlParam[1] = new SqlParameter("@CalculationMethod", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objcominfo.CalcMasterID;

                objSqlParam[2] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 150);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objcominfo.PropertyType;

                objSqlParam[3] = new SqlParameter("@EffectiveFromDate", SqlDbType.VarChar, 150);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objcominfo.EffectiveFromDate;

                objSqlParam[4] = new SqlParameter("@EffectiveToDate", SqlDbType.VarChar, 150);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objcominfo.EffectiveToDate;

                objSqlParam[5] = new SqlParameter("@LoginId", SqlDbType.VarChar, 150);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMaintenanceInfo", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region get Info b yID

        public DataSet GetMaintainanceInfoByID(clsMaintenanceMstrEntity objcominfo)
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
                objSqlParam[0].Value = objcominfo.flag;

                objSqlParam[1] = new SqlParameter("@Id", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objcominfo.ID;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMaintenanceInfobyId", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region filldropdown GlobalParking
        public void FillDropDown(DropDownList ddl, DataTable dt, string TextField, string ValueField)
        {
            ddl.Items.Clear();
            if (!(dt == null || dt.Rows.Count == 0))
            {
                ddl.DataSource = dt;
                ddl.DataTextField = TextField;
                ddl.DataValueField = ValueField;
                ddl.DataBind();
            }
            //ddl.Items.Insert(0, new ListItem("--Select--", "0"));
            // ListItem objLI = new ListItem("--Select --", "0");
            //DrpOwnerID.Items.Insert(0, objLI);
        }
        #endregion

        public DataSet GetSalary()
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
