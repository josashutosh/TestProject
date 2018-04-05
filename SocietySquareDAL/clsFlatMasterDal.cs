using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using System.Configuration;
using SocietyDAL;
using SocietyEntity;
using System.Web.UI.WebControls;

namespace SocietyDAL
{
  public class clsFlatMasterDal
    {

      #region InsertFlatMaster
      public string InsertFlatMstr(clsFlatEntity objflatinfo)
      {
          SqlConnection objSqlConn = new SqlConnection();
          try
          {
              objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objSqlParam = new SqlParameter[15];

              objSqlParam[0] = new SqlParameter("@FlatId", SqlDbType.Int);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = objflatinfo.FlatId;

              objSqlParam[1] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 100);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objflatinfo.FlatNumber;

              objSqlParam[2] = new SqlParameter("@CarpetArea", SqlDbType.Int);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objflatinfo.CarpetArea;

              objSqlParam[3] = new SqlParameter("@TotalArea", SqlDbType.Int);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = objflatinfo.TotalArea;

              objSqlParam[4] = new SqlParameter("@FlatType", SqlDbType.VarChar, 10);
              objSqlParam[4].Direction = ParameterDirection.Input;
              objSqlParam[4].Value = objflatinfo.FlatType;

              objSqlParam[5] = new SqlParameter("@IsShareCertificateGiven", SqlDbType.Bit);
              objSqlParam[5].Direction = ParameterDirection.Input;
              objSqlParam[5].Value = objflatinfo.IsShareCertificateGiven;

              objSqlParam[6] = new SqlParameter("@IsRented", SqlDbType.Bit);
              objSqlParam[6].Direction = ParameterDirection.Input;
              objSqlParam[6].Value = objflatinfo.IsRented;

              objSqlParam[7] = new SqlParameter("@BuildingId", SqlDbType.Int);
              objSqlParam[7].Direction = ParameterDirection.Input;
              objSqlParam[7].Value = objflatinfo.BuildingId;

              objSqlParam[8] = new SqlParameter("@OwnerId", SqlDbType.Int);
              objSqlParam[8].Direction = ParameterDirection.Input;
              objSqlParam[8].Value = objflatinfo.OwnerId;

              objSqlParam[9] = new SqlParameter("@PropertyType", SqlDbType.VarChar, 50);
              objSqlParam[9].Direction = ParameterDirection.Input;
              objSqlParam[9].Value = objflatinfo.PropertyType;

              objSqlParam[10] = new SqlParameter("@BusinessType", SqlDbType.VarChar,50);
              objSqlParam[10].Direction = ParameterDirection.Input;
              objSqlParam[10].Value = objflatinfo.businesstype;

              objSqlParam[11] = new SqlParameter("@LicenseNo", SqlDbType.VarChar, 50);
              objSqlParam[11].Direction = ParameterDirection.Input;
              objSqlParam[11].Value = objflatinfo.LicenseNo;

              objSqlParam[12] = new SqlParameter("@ShopDescription", SqlDbType.VarChar,200);
              objSqlParam[12].Direction = ParameterDirection.Input;
              objSqlParam[12].Value = objflatinfo.ShopDescription;

              objSqlParam[13] = new SqlParameter("@CreatedBy", SqlDbType.VarChar, 20);
              objSqlParam[13].Direction = ParameterDirection.Input;
              objSqlParam[13].Value = objflatinfo.CreatedBy;

              objSqlParam[14] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 100);
              objSqlParam[14].Direction = ParameterDirection.Output;

              int intVal = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "InsertFlatInfo", objSqlParam);

              return Convert.ToString(objSqlParam[14].Value);
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


      #region GetownerInfo

      public DataSet GetflatInfo(clsFlatEntity objflatinfo,string LoginId)
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
              objSqlParam[0].Value = "getallrecord";

              objSqlParam[1] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 150);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objflatinfo.FlatNumber;

              objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objflatinfo.FlatId;

              objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = LoginId;
              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatInfo", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }

      #endregion

      public DataSet GetAllFlatnoInfo(clsFlatEntity objflatinfo)
      {
          DataSet ds = new DataSet();

          SqlConnection objSqlCon = new SqlConnection();
           try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();


              DataSet dsGetDetails = new DataSet();
              SqlParameter[] objSqlParam = new SqlParameter[1];

              objSqlParam[0] = new SqlParameter("@FlatId", SqlDbType.Int);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = objflatinfo.FlatId;

              //objSqlParam[1] = new SqlParameter("@BuildingId", SqlDbType.Int);
              //objSqlParam[1].Direction = ParameterDirection.Input;
              //objSqlParam[1].Value = objflatinfo.BuildingId;


              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetFlatno]", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }
      #region getflatname by ID

      public DataSet Getflatinfobyid(string Id, string LoginId, string flag,string SocietyId)
      {
          DataSet ds = new DataSet();
          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objSqlParam = new SqlParameter[5];

              objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = "getallrecord";

              objSqlParam[1] = new SqlParameter("@ownerId", SqlDbType.VarChar);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = Id;

              objSqlParam[2] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = LoginId;

              objSqlParam[3] = new SqlParameter("@Operartion", SqlDbType.VarChar, 20);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = flag;

              objSqlParam[4] = new SqlParameter("@SocietyId", SqlDbType.VarChar, 20);
              objSqlParam[4].Direction = ParameterDirection.Input;
              objSqlParam[4].Value = SocietyId;

              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatinfobyID", objSqlParam
                  );
          }
          catch (Exception Ex)
          {
              throw Ex;
          }
          return ds;
      }

      #endregion

      #region getflatlist by building id

      public DataSet GetFlatListbybuildingid(int BuildingId)
      {//For owner Master Page
          DataSet ds = new DataSet();
          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter objSqlParam = new SqlParameter();

              objSqlParam = new SqlParameter("@buildingId", SqlDbType.Int);
              objSqlParam.Direction = ParameterDirection.Input;
              objSqlParam.Value = BuildingId;
                          
              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatListbybuildingid", objSqlParam);
          }
          catch (Exception Ex)
          {
              throw Ex;
          }
          return ds;
      }

      public DataSet GetFlatbybuildingid(int BuildingId)
      {
          DataSet ds = new DataSet();
          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter objSqlParam = new SqlParameter();

              objSqlParam = new SqlParameter("@buildingId", SqlDbType.Int);
              objSqlParam.Direction = ParameterDirection.Input;
              objSqlParam.Value = BuildingId;

              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "[GetFlatsbybuildingid]", objSqlParam);
          }
          catch (Exception Ex)
          {
              throw Ex;
          }
          return ds;
      }

      #endregion


      #region getFlatInfo By SocietyId

      public DataSet GetAllFlatInfo(int societyId)
      {
          DataSet ds = new DataSet();

          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objSqlParam = new SqlParameter[1];

              objSqlParam[0] = new SqlParameter("@societyId", SqlDbType.Int);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = societyId;

              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatListbySocietyid", objSqlParam);
              return ds;
          }
          catch (Exception e)
          {
              throw e;
          }
      }

      #endregion

      #region SearchFlat By Flatid and Number
      public DataSet GetFlatbyFlatno(clsFlatEntity objflatinfo, string LoginId)
      {
          SqlConnection objSqlCon = new SqlConnection();
          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

              DataSet dsGetDetails = new DataSet();
              SqlParameter[] objSqlParam = new SqlParameter[5];

              objSqlParam[0] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 150);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = objflatinfo.FlatNumber;

              objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objflatinfo.flag;

              objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objflatinfo.FlatId;

              objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar, 50);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = LoginId;

              objSqlParam[4] = new SqlParameter("@ID", SqlDbType.VarChar, 50);
              objSqlParam[4].Direction = ParameterDirection.Input;
              objSqlParam[4].Value = objflatinfo.SocietyId;

              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatinfoByFlag", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }

      public DataSet GetFlatbyFlatId(clsFlatEntity objflatinfo)
      {
          SqlConnection objSqlCon = new SqlConnection();
          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();

              DataSet dsGetDetails = new DataSet();
              SqlParameter[] objSqlParam = new SqlParameter[4];

              objSqlParam[0] = new SqlParameter("@FlatNumber", SqlDbType.VarChar, 150);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = objflatinfo.FlatNumber;

              objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = objflatinfo.flag;

              objSqlParam[2] = new SqlParameter("@FlatId", SqlDbType.Int);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = objflatinfo.FlatId;

              objSqlParam[3] = new SqlParameter("@ID", SqlDbType.VarChar, 50);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = objflatinfo.SocietyId;

              dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatinfoByFlag", objSqlParam);

              objSqlCon.Close();

              return dsGetDetails;
          }
          catch (Exception ex)
          {
              throw ex;
          }
      }
      #endregion

      #region getflat info by flatid&flag

      public DataSet getflatinfobyflatidFlag(string flag,string Id, string LoginId,string SocietyId)
      {
          DataSet ds = new DataSet();
          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objSqlParam = new SqlParameter[4];

              objSqlParam[0] = new SqlParameter("@flag", SqlDbType.VarChar);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = flag;

              objSqlParam[1] = new SqlParameter("@FlatId", SqlDbType.VarChar);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = Id;

              objSqlParam[2] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
              objSqlParam[2].Direction = ParameterDirection.Input;
              objSqlParam[2].Value = LoginId;

              objSqlParam[3] = new SqlParameter("@ID", SqlDbType.VarChar, 50);
              objSqlParam[3].Direction = ParameterDirection.Input;
              objSqlParam[3].Value = SocietyId;
           
              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatinfoByFlag", objSqlParam);
          }
          catch (Exception Ex)
          {
              throw Ex;
          }
          return ds;
      }

      #endregion


      #region getflat ID by OwnerID

      public DataSet getflatIDbyownerID(string flag, string Id)
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

              objSqlParam[1] = new SqlParameter("@ID", SqlDbType.VarChar);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = Id;
              //SqlCon = objDBHelper.GetConnectionString();
              //SqlParameter[] param ={ 
              //                    SqlHelper.MakeParam("@Opt", "CityState"),
              //                    SqlHelper.MakeParam("@ID",StateId)
              //                  };
              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GetFlatinfoByFlag", objSqlParam
                  );
          }
          catch (Exception Ex)
          {
              throw Ex;
          }
          return ds;
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

      #region getFlatInfo By SocietyId with flag

      public DataSet GetFlatInfobySocietyID(int societyId, string flag)
      {
          DataSet ds = new DataSet();

          SqlConnection objSqlCon = new SqlConnection();

          try
          {
              objSqlCon.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString();
              SqlParameter[] objSqlParam = new SqlParameter[2];

              objSqlParam[0] = new SqlParameter("@societyId", SqlDbType.Int);
              objSqlParam[0].Direction = ParameterDirection.Input;
              objSqlParam[0].Value = societyId;

              objSqlParam[1] = new SqlParameter("@Flag", SqlDbType.VarChar);
              objSqlParam[1].Direction = ParameterDirection.Input;
              objSqlParam[1].Value = flag;


              ds = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "GenerateUploadExcelPattern", objSqlParam);
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
