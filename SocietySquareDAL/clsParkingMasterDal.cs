using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using SocietyDAL;

namespace SocietyDAL
{
    public class clsParkingMasterDal
    {
        public string Insertparking(int PrkID, int flatid, int ownid, string IsparkAvailable, string prktype, int count, string prk1, string prk2, string prk3, string createdby, string Parking1Type, string Parking2Type, string Parking3Type)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[14];

                objSqlParam[0] = new SqlParameter("@ParkingId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = PrkID;

                objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = flatid;

                objSqlParam[2] = new SqlParameter("@OwnerId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = ownid;

                objSqlParam[3] = new SqlParameter("@ParkingType", SqlDbType.VarChar, 50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = prktype;

                objSqlParam[4] = new SqlParameter("@NumberOfParking", SqlDbType.Int);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = count;

                objSqlParam[5] = new SqlParameter("@Parking1", SqlDbType.VarChar, 50);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = prk1;

                objSqlParam[6] = new SqlParameter("@Parking2", SqlDbType.VarChar, 50);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = prk2;

                objSqlParam[7] = new SqlParameter("@Parking3", SqlDbType.VarChar, 50);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = prk3;

                objSqlParam[8] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = createdby;

                objSqlParam[9] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[9].Direction = ParameterDirection.Output;

                objSqlParam[10] = new SqlParameter("@Parking1Type", SqlDbType.VarChar, 50);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = Parking1Type;

                objSqlParam[11] = new SqlParameter("@Parking2Type", SqlDbType.VarChar, 50);
                objSqlParam[11].Direction = ParameterDirection.Input;
                objSqlParam[11].Value = Parking2Type;

                objSqlParam[12] = new SqlParameter("@Parking3Type", SqlDbType.VarChar, 50);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = Parking3Type;

                objSqlParam[13] = new SqlParameter("@IsParkingAvailable", SqlDbType.VarChar);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = IsparkAvailable;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "ParkingMasterInsert", objSqlParam);
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

        public DataSet GetparkingDetails(int EvntId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@EventId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                if (EvntId == 0)
                {
                    objSqlParam[0].Value = null;
                }
                else
                {
                    objSqlParam[0].Value = EvntId;
                }

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "ParkingGetById", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }




        public DataSet GetAllParkingdata(int id, string LoginId)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];


                objSqlParam[0] = new SqlParameter("@ParkingId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = id;

                objSqlParam[1] = new SqlParameter("@LoginId", SqlDbType.VarChar, 50);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "ParkingDetailsGet", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region SearchPaarking By Flatid
        public DataSet GetPaarkingbyflat(string flatno)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@FlatNo", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = flatno;

                objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = "searchownerinfo";

                //objSqlParam[2] = new SqlParameter("@ParkingId", SqlDbType.Int);
                //objSqlParam[2].Direction = ParameterDirection.Input;
                //objSqlParam[2].Value = id;

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



        #region SearchPaarking By searchbyFlatNo
        public DataSet GetPaarkingbyflat(string flatno,int id,string LoginId)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[4];

                objSqlParam[0] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 150);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = flatno;

                objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = "searchbyFlatNo";

                objSqlParam[2] = new SqlParameter("@ParkingId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = id;

                objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetParkingInfo", objSqlParam);

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
       


    }
}
