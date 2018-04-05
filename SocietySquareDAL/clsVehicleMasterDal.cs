using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyDAL;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace SocietyDAL
{
    public class clsVehicleMasterDal
    {
        #region InsertOwnerMaster
        public string InsertVehicleMstr(clsVehicleEntity objvehicleEntity)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[18];

                objSqlParam[0] = new SqlParameter("@Vehicleid", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objvehicleEntity.vehicleid;

                objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objvehicleEntity.FlatId;

                objSqlParam[2] = new SqlParameter("@NoOfVehichle", SqlDbType.VarChar, 15);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objvehicleEntity.noOfvehicle;

                objSqlParam[3] = new SqlParameter("@VehicleType1", SqlDbType.VarChar, 15);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objvehicleEntity.VehicleTypeVeh1;

                objSqlParam[4] = new SqlParameter("@VehicleNumber1", SqlDbType.VarChar, 15);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objvehicleEntity.VehicleNumberVeh1;

                objSqlParam[5] = new SqlParameter("@IsStickerGiven1", SqlDbType.Bit);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objvehicleEntity.ISstickerGivenVeh1;


                objSqlParam[6] = new SqlParameter("@VehicleType2", SqlDbType.VarChar, 15);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objvehicleEntity.VehicleTypeVeh2;

                objSqlParam[7] = new SqlParameter("@VehicleNumber2", SqlDbType.VarChar, 15);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objvehicleEntity.VehicleNumberVeh2;

                objSqlParam[8] = new SqlParameter("@IsStickerGiven2", SqlDbType.Bit);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objvehicleEntity.ISstickerGivenVeh2;


                objSqlParam[9] = new SqlParameter("@VehicleType3", SqlDbType.VarChar, 15);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objvehicleEntity.VehicleTypeVeh3;

                objSqlParam[10] = new SqlParameter("@VehicleNumber3", SqlDbType.VarChar, 15);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objvehicleEntity.VehicleNumberVeh3;

                objSqlParam[11] = new SqlParameter("@IsStickerGiven3", SqlDbType.Bit);
                objSqlParam[11].Direction = ParameterDirection.Input;
                objSqlParam[11].Value = objvehicleEntity.ISstickerGivenVeh3;

                objSqlParam[12] = new SqlParameter("@VehicleType4", SqlDbType.VarChar, 15);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = objvehicleEntity.VehicleTypeVeh4;

                objSqlParam[13] = new SqlParameter("@VehicleNumber4", SqlDbType.VarChar, 15);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = objvehicleEntity.VehicleNumberVeh4;

                objSqlParam[14] = new SqlParameter("@IsStickerGiven4", SqlDbType.Bit);
                objSqlParam[14].Direction = ParameterDirection.Input;
                objSqlParam[14].Value = objvehicleEntity.ISstickerGivenVeh4;

                objSqlParam[15] = new SqlParameter("@ExtraInfo", SqlDbType.VarChar, 15);
                objSqlParam[15].Direction = ParameterDirection.Input;
                objSqlParam[15].Value = objvehicleEntity.Extravehinfo;
                

                objSqlParam[16] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[16].Direction = ParameterDirection.Input;
                objSqlParam[16].Value = objvehicleEntity.createdBy;

                objSqlParam[17] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                objSqlParam[17].Direction = ParameterDirection.Output;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InstertVehicleInfo", objSqlParam);

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




        #region GetVehicleInfo

        public DataSet GetVehicleInfo(clsVehicleEntity objvehinfo, string LoginId)
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
                objSqlParam[0].Value = objvehinfo.flag;

                objSqlParam[1] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objvehinfo.FlatNumber;

                objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objvehinfo.FlatId;

                objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetVehicleInfo", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion


        #region GetVehicleInfobyvehicleid

        public DataSet GetVehicleInfobyVehicleId(clsVehicleEntity objvehinfo)
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
                objSqlParam[0].Value = objvehinfo.flag;

                objSqlParam[1] = new SqlParameter("@Vehicleid", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objvehinfo.vehicleid;


                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetVehicleInfobyID", objSqlParam);

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
