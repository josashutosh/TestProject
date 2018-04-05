using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyDAL;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using SocietyDAL;
using SocietyEntity;


namespace SocietyDAL
{
    public class clsAmenityDal
    {
        public string InsertAminityInformation(clsAmenityEntity objAminityEntity)
        {
            #region
            SqlConnection objSqlConn = new SqlConnection();

            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter[] objSqlParam = new SqlParameter[28];

                objSqlParam[0] = new SqlParameter("@AminityId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objAminityEntity.AminityId;

                objSqlParam[1] = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objAminityEntity.BuildingId;

                objSqlParam[2] = new SqlParameter("@Gymnasium", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objAminityEntity.Gymnasium;

                objSqlParam[3] = new SqlParameter("@GymDesc", SqlDbType.VarChar, 1000);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = objAminityEntity.GymDesc;

                objSqlParam[4] = new SqlParameter("@Parking", SqlDbType.Int);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objAminityEntity.Parking;

                objSqlParam[5] = new SqlParameter("@ParkingDesc", SqlDbType.VarChar, 1000);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = objAminityEntity.ParkingDesc;

                objSqlParam[6] = new SqlParameter("@Lift", SqlDbType.Int);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = objAminityEntity.Lift;

                objSqlParam[7] = new SqlParameter("@LiftDesc", SqlDbType.VarChar, 1000);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = objAminityEntity.LiftDesc;

                objSqlParam[8] = new SqlParameter("@CCTV", SqlDbType.Int);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = objAminityEntity.CCTV;

                objSqlParam[9] = new SqlParameter("@CCTVDesc", SqlDbType.VarChar, 100);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = objAminityEntity.CCTVDesc;

                objSqlParam[10] = new SqlParameter("@InterCom", SqlDbType.Int);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = objAminityEntity.InterCom;

                objSqlParam[11] = new SqlParameter("@IntercomDesc", SqlDbType.VarChar, 1000);
                objSqlParam[11].Direction = ParameterDirection.Input;
                objSqlParam[11].Value = objAminityEntity.IntercomDesc;

                objSqlParam[12] = new SqlParameter("@Security", SqlDbType.Int);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = objAminityEntity.Security;

                objSqlParam[13] = new SqlParameter("@SecurityDesc", SqlDbType.VarChar, 1000);
                objSqlParam[13].Direction = ParameterDirection.Input;
                objSqlParam[13].Value = objAminityEntity.SecurityDesc;

                objSqlParam[14] = new SqlParameter("@GeneratorBkp", SqlDbType.Int);
                objSqlParam[14].Direction = ParameterDirection.Input;
                objSqlParam[14].Value = objAminityEntity.GeneratorBkp;

                objSqlParam[15] = new SqlParameter("@GeneratorDesc", SqlDbType.VarChar, 1000);
                objSqlParam[15].Direction = ParameterDirection.Input;
                objSqlParam[15].Value = objAminityEntity.GeneratorDesc;

                objSqlParam[16] = new SqlParameter("@CommunityHall", SqlDbType.Int);
                objSqlParam[16].Direction = ParameterDirection.Input;
                objSqlParam[16].Value = objAminityEntity.CommunityHall;

                objSqlParam[17] = new SqlParameter("@CommunityDesc", SqlDbType.VarChar, 1000);
                objSqlParam[17].Direction = ParameterDirection.Input;
                objSqlParam[17].Value = objAminityEntity.CommunityDesc;

                objSqlParam[18] = new SqlParameter("@SwimmingPool", SqlDbType.Int);
                objSqlParam[18].Direction = ParameterDirection.Input;
                objSqlParam[18].Value = objAminityEntity.SwimmingPool;

                objSqlParam[19] = new SqlParameter("@SwimmingDesc", SqlDbType.VarChar, 1000);
                objSqlParam[19].Direction = ParameterDirection.Input;
                objSqlParam[19].Value = objAminityEntity.SwimmingDesc;

                objSqlParam[20] = new SqlParameter("@Chairs", SqlDbType.Int);
                objSqlParam[20].Direction = ParameterDirection.Input;
                objSqlParam[20].Value = objAminityEntity.Chairs;

                objSqlParam[21] = new SqlParameter("@ChairsDesc", SqlDbType.VarChar, 1000);
                objSqlParam[21].Direction = ParameterDirection.Input;
                objSqlParam[21].Value = objAminityEntity.ChairsDesc;

                objSqlParam[22] = new SqlParameter("@Tables", SqlDbType.Int);
                objSqlParam[22].Direction = ParameterDirection.Input;
                objSqlParam[22].Value = objAminityEntity.Tables;

                objSqlParam[23] = new SqlParameter("@TablesDesc", SqlDbType.VarChar, 1000);
                objSqlParam[23].Direction = ParameterDirection.Input;
                objSqlParam[23].Value = objAminityEntity.TablesDesc;

                objSqlParam[24] = new SqlParameter("@MusicSystem", SqlDbType.Int);
                objSqlParam[24].Direction = ParameterDirection.Input;
                objSqlParam[24].Value = objAminityEntity.MusicSystem;

                objSqlParam[25] = new SqlParameter("@MusicSysDesc", SqlDbType.VarChar, 1000);
                objSqlParam[25].Direction = ParameterDirection.Input;
                objSqlParam[25].Value = objAminityEntity.MusicSysDesc;

                objSqlParam[26] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                objSqlParam[26].Direction = ParameterDirection.Input;
                objSqlParam[26].Value = objAminityEntity.CreatedBy;

                objSqlParam[27] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                objSqlParam[27].Direction = ParameterDirection.Output;

                int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertAminityInfo", objSqlParam);

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
            #endregion


        #region GetBuildingInfo

        public DataSet GetAllBuildingInfo(clsAmenityEntity objAminityEntity)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter objSqlParam = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam.Direction = ParameterDirection.Input;
                objSqlParam.Value = objAminityEntity.BuildingId;





                //objSqlParam[0] = new SqlParameter("@AminityId", SqlDbType.Int);
                //objSqlParam[0].Direction = ParameterDirection.Input;
                //objSqlParam[0].Value = objAminityEntity.AminityId;

                ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetBuildingInfo", objSqlParam);
                return ds;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        #endregion


        #region GetAminityInfo

        public DataSet GetAminityInfo(clsAmenityEntity objAminityEntity)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                          SqlParameter[] objSqlParam = new SqlParameter[2];
                objSqlParam[0] = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objAminityEntity.BuildingId;

                objSqlParam[1] = new SqlParameter("@SocietyId", SqlDbType.VarChar,15);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = objAminityEntity.SocietyId;

                ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetAminityInfo", objSqlParam);
                return ds;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        #endregion


        #region searchamenuty By searchbybuildingname
        public DataSet GetAmenitybyBuildname(clsAmenityEntity objAminityEntity, string LoginId)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[5];

                objSqlParam[0] = new SqlParameter("@AminityId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = objAminityEntity.AminityId;

                objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 30);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = "searchbyname";

                objSqlParam[2] = new SqlParameter("@BuildingId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = objAminityEntity.BuildingId;

                objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = LoginId;

                objSqlParam[4] = new SqlParameter("@SocietyId", SqlDbType.VarChar, 15);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = objAminityEntity.SocietyId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetAmenitybyFlag", objSqlParam);

                objSqlCon.Close();

                return dsGetDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion













        #region GetAminityInfobyAminityId

        public DataSet GetAminityMstrInfo(clsAmenityEntity objAminityEntity)
        {
            DataSet ds = new DataSet();

            SqlConnection objSqlCon = new SqlConnection();
            try
            {
                objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter objSqlParam = new SqlParameter("@AminityId", SqlDbType.Int);
                objSqlParam.Direction = ParameterDirection.Input;
                objSqlParam.Value = objAminityEntity.AminityId;



                ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetAminityInfobyId", objSqlParam);
                return ds;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        #endregion

    }
}


