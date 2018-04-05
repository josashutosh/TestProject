using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyDAL;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using SocietyEntity;


namespace SocietyDAL
{
    public class clsBuildingMasterDal
    {

       public string InsertBuildingInformation(clsBuildingEntity objBuildinginfo)
        {
            #region
                SqlConnection objSqlConn = new SqlConnection();

                try
                {
                    objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                    SqlParameter[] objSqlParam = new SqlParameter[8];

                    objSqlParam[0] = new SqlParameter("@BuildingId", SqlDbType.Int);
                    objSqlParam[0].Direction = ParameterDirection.Input;
                    objSqlParam[0].Value = objBuildinginfo.BuildingId;

                    objSqlParam[1] = new SqlParameter("@Name", SqlDbType.VarChar, 200);
                    objSqlParam[1].Direction = ParameterDirection.Input;
                    objSqlParam[1].Value = objBuildinginfo.Name;

                    //objSqlParam[2] = new SqlParameter("@Lifts", SqlDbType.Int);
                    //objSqlParam[2].Direction = ParameterDirection.Input;
                    //objSqlParam[2].Value = objBuildinginfo.Lifts;

                    objSqlParam[2] = new SqlParameter("@Floors", SqlDbType.Int);
                    objSqlParam[2].Direction = ParameterDirection.Input;
                    objSqlParam[2].Value = objBuildinginfo.Floors;

                    objSqlParam[3] = new SqlParameter("@Flats", SqlDbType.Int);
                    objSqlParam[3].Direction = ParameterDirection.Input;
                    objSqlParam[3].Value = objBuildinginfo.Flats;

                    objSqlParam[4] = new SqlParameter("@Totalarea", SqlDbType.Int);
                    objSqlParam[4].Direction = ParameterDirection.Input;
                    objSqlParam[4].Value = objBuildinginfo.TotalArea;

                    objSqlParam[5] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
                    objSqlParam[5].Direction = ParameterDirection.Input;
                    objSqlParam[5].Value = objBuildinginfo.CreatedBy;

                    objSqlParam[6] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 50);
                    objSqlParam[6].Direction = ParameterDirection.Output;

                    objSqlParam[7] = new SqlParameter("@SocietyId", SqlDbType.Int);
                    objSqlParam[7].Direction = ParameterDirection.Input;
                    objSqlParam[7].Value = objBuildinginfo.SocietyId;

                    int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertBuildingInfo", objSqlParam);

                    return Convert.ToString(objSqlParam[6].Value);
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

            public DataSet GetAllBuildingInfo(clsBuildingEntity objBuildinginfo,string LoginId)
            {
                DataSet ds = new DataSet();

                SqlConnection objSqlCon = new SqlConnection();
                
                try
                {
                    objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
                    SqlParameter[] objSqlParam = new SqlParameter[2];

                    objSqlParam[0] = new SqlParameter("@BuildingId", SqlDbType.Int);
                    objSqlParam[0].Direction = ParameterDirection.Input;
                    objSqlParam[0].Value = objBuildinginfo.BuildingId;

                    objSqlParam[1] = new SqlParameter("@LoginId", SqlDbType.VarChar, 30);
                    objSqlParam[1].Direction = ParameterDirection.Input;
                    objSqlParam[1].Value = LoginId;

                 

                    ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetBuildingInfo", objSqlParam);
                    return ds;
                }
                catch (Exception e)
                {
                    throw e;
                }
            }

       
            #endregion
        
            #region SearchBuilding by building name
            public DataSet GetBuildingName(clsBuildingEntity objbuildMstrinfo,string LoginId)
            {
                SqlConnection objSqlCon = new SqlConnection();
                try
                {
                    objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                    DataSet dsGetDetails = new DataSet();
                    SqlParameter[] objSqlParam = new SqlParameter[4];

                    objSqlParam[0] = new SqlParameter("@BuildingName", SqlDbType.VarChar, 150);
                    objSqlParam[0].Direction = ParameterDirection.Input;
                    objSqlParam[0].Value = objbuildMstrinfo.Name;

                    objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                    objSqlParam[1].Direction = ParameterDirection.Input;
                    objSqlParam[1].Value = "searchbyBuildname";

                    objSqlParam[2] = new SqlParameter("@BuildingId", SqlDbType.Int);
                    objSqlParam[2].Direction = ParameterDirection.Input;
                    objSqlParam[2].Value = objbuildMstrinfo.BuildingId;

                    objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 30);
                    objSqlParam[3].Direction = ParameterDirection.Input;
                    objSqlParam[3].Value = LoginId;

                    dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GeteBuildingMstrbyNam", objSqlParam);

                    objSqlCon.Close();

                    return dsGetDetails;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            #endregion

            #region GetBuildingInfoByID

            public DataSet GetAllBuildingInfoByID(int ID)
            {
                DataSet ds = new DataSet();

                SqlConnection objSqlCon = new SqlConnection();
                try
                {
                    objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

                    SqlParameter objSqlParam = new SqlParameter("@BuildingId", SqlDbType.Int);
                    objSqlParam.Direction = ParameterDirection.Input;
                    objSqlParam.Value = ID;

                    ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetBuildingInfo", objSqlParam);
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
