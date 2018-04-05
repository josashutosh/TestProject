using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using SocietyDAL;

namespace SocietyDAL
{
    public class clsEvent
    {

        public string Insertevent(int EvntID, string name, string dec, string evton, string Contactname, string MobileNumber, string contri, string FileUploadFileName, string FileName, string EventTime, string createdby, string societyId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[13];

                objSqlParam[0] = new SqlParameter("@EventId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = EvntID;

                objSqlParam[1] = new SqlParameter("@EventName", SqlDbType.VarChar, 100);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = name;

                objSqlParam[2] = new SqlParameter("@EventDescription", SqlDbType.VarChar, 500);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = dec;

                objSqlParam[3] = new SqlParameter("@EventOn", SqlDbType.VarChar,100);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = evton;

                objSqlParam[4] = new SqlParameter("@ContactPerson", SqlDbType.VarChar, 100);
                objSqlParam[4].Direction = ParameterDirection.Input;
                objSqlParam[4].Value = Contactname;
                
                objSqlParam[5] = new SqlParameter("@MobileNumber", SqlDbType.VarChar, 50);
                objSqlParam[5].Direction = ParameterDirection.Input;
                objSqlParam[5].Value = MobileNumber;

                objSqlParam[6] = new SqlParameter("@Contribution", SqlDbType.Money);
                objSqlParam[6].Direction = ParameterDirection.Input;
                objSqlParam[6].Value = contri;

                objSqlParam[7] = new SqlParameter("@FileUploadFileName", SqlDbType.VarChar, 150);
                objSqlParam[7].Direction = ParameterDirection.Input;
                objSqlParam[7].Value = FileUploadFileName;

                objSqlParam[8] = new SqlParameter("@FileName", SqlDbType.VarChar, 100);
                objSqlParam[8].Direction = ParameterDirection.Input;
                objSqlParam[8].Value = FileName;

                objSqlParam[9] = new SqlParameter("@EventTime", SqlDbType.VarChar, 100);
                objSqlParam[9].Direction = ParameterDirection.Input;
                objSqlParam[9].Value = EventTime;
                
                objSqlParam[10] = new SqlParameter("@Createdby", SqlDbType.VarChar, 100);
                objSqlParam[10].Direction = ParameterDirection.Input;
                objSqlParam[10].Value = createdby;
               
                
                objSqlParam[11] = new SqlParameter("@INS_OUT_MSG", SqlDbType.VarChar, 350);
                objSqlParam[11].Direction = ParameterDirection.Output;

                objSqlParam[12] = new SqlParameter("@SocietyId", SqlDbType.VarChar, 5);
                objSqlParam[12].Direction = ParameterDirection.Input;
                objSqlParam[12].Value = societyId;

                int val = SqlHelper.ExecuteNonQuery(objSqlConn, CommandType.StoredProcedure, "[InsertEventMaster]", objSqlParam);
                return Convert.ToString(objSqlParam[11].Value);
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


        public DataSet GetEventDetailbyId(long EventId)
        {
            var Sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["society"].ConnectionString.ToString());

            try
            {
                SqlParameter[] objsqlparam = new SqlParameter[1];

                objsqlparam[0] = new SqlParameter("@EventId", SqlDbType.BigInt);
                objsqlparam[0].Direction = ParameterDirection.Input;
                objsqlparam[0].Value = EventId;
                DataSet ds = (DataSet)SqlHelper.ExecuteDataset(Sqlcon, CommandType.StoredProcedure, "GetEventDetailbyId", objsqlparam);
                return ds;
            }
            catch (Exception)
            {
                throw;
            }
            finally {
                Sqlcon.Close();
            }

        
        }


        public DataSet GetEventDetails(int EvntID)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[2];

                objSqlParam[0] = new SqlParameter("@EventId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                if (EvntID == 0)
                {
                    objSqlParam[0].Value = null;
                }
                else
                {
                    objSqlParam[0].Value = EvntID;
                }


                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetEventById", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }




        public DataSet GetEventByName(string Eventname, string Eventdate,string LoginId)
        {
            SqlConnection objSqlConn = new SqlConnection();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[4];

                objSqlParam[0] = new SqlParameter("@EventOn", SqlDbType.VarChar, 200);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = Eventdate;
                

                objSqlParam[1] = new SqlParameter("@flag", SqlDbType.VarChar, 150);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = "searchbyEventname";

                objSqlParam[2] = new SqlParameter("@EventName", SqlDbType.VarChar, 200);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = Eventname;

                objSqlParam[3] = new SqlParameter("@LoginId", SqlDbType.VarChar,50);
                objSqlParam[3].Direction = ParameterDirection.Input;
                objSqlParam[3].Value = LoginId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetEventDetailsbyName", objSqlParam);

                objSqlConn.Close();

                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        public DataSet Getdata(string SocietyId)
        {
            SqlConnection objSqlCon = new SqlConnection();
            try
            {

                objSqlCon.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                //objSqlCon.ConnectionString = System.Configuration.ConfigurationSettings.AppSettings["society"].ToString();
                DataSet dsGetDetails = new DataSet();
                SqlParameter[] objSqlParam = new SqlParameter[1];

                objSqlParam[0] = new SqlParameter("@SocietyId", SqlDbType.VarChar, 50);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = SocietyId;

                dsGetDetails = SqlHelper.ExecuteDataset(objSqlCon, CommandType.StoredProcedure, "EventDetailsGet", objSqlParam);
                objSqlCon.Close();
                return dsGetDetails;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        
    }
}
