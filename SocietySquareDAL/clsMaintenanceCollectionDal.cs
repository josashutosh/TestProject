using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SocietyDAL;
using System.Web.UI.WebControls;
using System.Configuration;
using SocietyEntity;

namespace SocietyDAL
{
    public class clsMaintenanceCollectionDal
    {
        #region Insert
        public string InsertmaintenanceCollection(clsMaintenanceCollectionEntity objMaincoll)
        {

            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[10];

                objSqlParam[0] = new SqlParameter("@MainCollID", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMaincoll.ID;

                objSqlParam[1] = new SqlParameter("@MaintenanceID", SqlDbType.VarChar);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMaincoll.CollectionIds;

                objSqlParam[2] = new SqlParameter("@PaidAmount", SqlDbType.Float);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objMaincoll.PaidAmount;

                objSqlParam[3] = new SqlParameter("@ModePayment", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objMaincoll.ModePayment;

                objSqlParam[4] = new SqlParameter("@InstrumentNumber", SqlDbType.BigInt);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objMaincoll.InstrumentNumber;

                objSqlParam[5] = new SqlParameter("@InstrumentDate", SqlDbType.VarChar);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objMaincoll.InstrumentDate;

                objSqlParam[6] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objMaincoll.CreatedBy;

                objSqlParam[7] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                objSqlParam[7].Direction = ParameterDirection.Output;

                objSqlParam[8] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objMaincoll.PropertyType;

                objSqlParam[9] = new SqlParameter("@MaintenanceWalletAmt", SqlDbType.Float);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objMaincoll.MaintenanceWalletAmount;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertMaintenanceCollection", objSqlParam);

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

        #region get Get FlatNumber by Property_Type

        public DataSet GetFlatNumberByBuildingId(clsMaintenanceCollectionEntity objmainColl)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@BuildingID", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objmainColl.BuildingId;

                objSqlParam[1] = new SqlParameter("@LoginId", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmainColl.LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetFlatNumberByBuildId]", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region get Get FlatNumber by Property_Type

        public DataSet GetMaintenanceCollection(clsMaintenanceCollectionEntity objmainColl)
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
                objSqlParam[0].Value = objmainColl.Flag;

                objSqlParam[1] = new SqlParameter("@Id", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmainColl.ID;

                objSqlParam[2] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 150);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objmainColl.PropertyType;

                objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 150);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objmainColl.LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMaintenanceCollection", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        public DataSet GetMaintenanceCollectionAmount(clsMaintenanceCollectionEntity objmainColl)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@Id", SqlDbType.VarChar, 200);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objmainColl.CollectionIds;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objmainColl.PropertyType;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetMaintenanceCollectionAmount", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        #region filldropdown
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

        public void Filllistbox(ListBox ddl, DataTable dt, string TextField, string ValueField)
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

        public DataSet GetMaintainanceView(clsMaintenanceCollectionEntity objMainCollEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[8];

                objSqlParam[0] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMainCollEntity.FlatId;

                objSqlParam[1] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMainCollEntity.SocietyId;

                objSqlParam[2] = new SqlParameter("@PropertyType", SqlDbType.VarChar);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objMainCollEntity.PropertyType;

                objSqlParam[3] = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objMainCollEntity.BuildingId;

                objSqlParam[4] = new SqlParameter("@MaintenanceFromYear", SqlDbType.VarChar);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objMainCollEntity.Fromyear;

                objSqlParam[5] = new SqlParameter("@MaintenanceFromMonth", SqlDbType.VarChar);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objMainCollEntity.FromMonth;

                objSqlParam[6] = new SqlParameter("@MaintenanceToYear", SqlDbType.VarChar);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objMainCollEntity.ToYear;

                objSqlParam[7] = new SqlParameter("@MaintenanceToMonth", SqlDbType.VarChar);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objMainCollEntity.ToMonth;

                DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetMaintenanceCollectionForView", objSqlParam);

                return ds;
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




        public string DeleteMaintainanceDetail(clsMaintenanceCollectionEntity objMainCollEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@CollectionId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMainCollEntity.ID;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMainCollEntity.PropertyType;

                objSqlParam[2] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[2].Direction = ParameterDirection.Output;

                objSqlParam[3] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objMainCollEntity.CreatedBy;

                objSqlParam[4] = new SqlParameter("@Remark", SqlDbType.VarChar, 1000);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objMainCollEntity.Remark;




                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "DeleteCollectionRecord", objSqlParam);

                return Convert.ToString(objSqlParam[2].Value);
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

        public DataSet GetCollectionInfoByCollectionId(clsMaintenanceCollectionEntity objMainCollEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[10];

                objSqlParam[0] = new SqlParameter("@PropertyType", SqlDbType.VarChar);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMainCollEntity.PropertyType;

                objSqlParam[1] = new SqlParameter("@CollectionId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMainCollEntity.ID;

                DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetmaintainanceCollectionFromCollectionId", objSqlParam);

                return ds;
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

        public string DeleteMaintainanceCalculationDetail(clsMaintenanceCollectionEntity objMainCollEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@CollectionId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMainCollEntity.ID;

                objSqlParam[1] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 20);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMainCollEntity.PropertyType;

                objSqlParam[2] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[2].Direction = ParameterDirection.Output;

                objSqlParam[3] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objMainCollEntity.CreatedBy;

                objSqlParam[4] = new SqlParameter("@Remark", SqlDbType.VarChar, 1000);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objMainCollEntity.Remark;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "DeleteCalculationRecord", objSqlParam);

                return Convert.ToString(objSqlParam[2].Value);
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

        public DataSet GetMaintainanceCalculationView(clsMaintenanceCollectionEntity objMainCollEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[8];

                objSqlParam[0] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objMainCollEntity.FlatId;

                objSqlParam[1] = new SqlParameter("@SocietyId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objMainCollEntity.SocietyId;

                objSqlParam[2] = new SqlParameter("@PropertyType", SqlDbType.VarChar);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objMainCollEntity.PropertyType;

                objSqlParam[3] = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objMainCollEntity.BuildingId;

                objSqlParam[4] = new SqlParameter("@MaintenanceFromYear", SqlDbType.VarChar);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objMainCollEntity.Fromyear;

                objSqlParam[5] = new SqlParameter("@MaintenanceFromMonth", SqlDbType.VarChar);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objMainCollEntity.FromMonth;

                objSqlParam[6] = new SqlParameter("@MaintenanceToYear", SqlDbType.VarChar);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objMainCollEntity.ToYear;

                objSqlParam[7] = new SqlParameter("@MaintenanceToMonth", SqlDbType.VarChar);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objMainCollEntity.ToMonth;

                DataSet ds = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetMaintenanceCollectionForView", objSqlParam);

                return ds;
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
