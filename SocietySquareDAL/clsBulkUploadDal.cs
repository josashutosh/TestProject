using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocietyEntity;
using System.Data.SqlClient;
using System.Data;

namespace SocietyDAL
{
    public class clsBulkUploadDal
    {
      

        #region FlatBulkUpload


        #region Remove Null Entry and Update UniqueKey and SocietyId


        #endregion

        public string RemoveNullAndUpdateFlatMaster(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param=new SqlParameter[5]; 
	 
                try 
	            {	        
		           
                    Param[0]=new SqlParameter("@SocietyId",SqlDbType.Int);
                    Param[0].Direction=ParameterDirection.Input;
                    Param[0].Value=objBlk.SocietyId;

                    Param[1]=new SqlParameter("@UniqueId",SqlDbType.VarChar);
                    Param[1].Direction=ParameterDirection.Input;
                    Param[1].Value=objBlk.UniqueId;

                    Param[2]=new SqlParameter("@Date",SqlDbType.VarChar);
                    Param[2].Direction=ParameterDirection.Input;
                    Param[2].Value=objBlk.Date;

                    Param[3]=new SqlParameter("@Flag",SqlDbType.VarChar);
                    Param[3].Direction=ParameterDirection.Input;
                    Param[3].Value=objBlk.Flag;

                    Param[4]=new SqlParameter("@MessageOutput",SqlDbType.VarChar,300);
                    Param[4].Direction=ParameterDirection.Output;

                    int output=SqlHelper.ExecuteNonQuery(conn,CommandType.StoredProcedure,"BlkRemoveNullEntryFromColumn",Param);

                   return Convert.ToString(Param[4].Value);
                    
	            }
                catch(Exception ex)
                    {
                        throw ex;
                    }   
	            finally
	            {
                    conn = null;
	            }

        }

        #endregion



        public DataSet SelectDuplicateRecordflatmaster(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[4];

            try
            {

                Param[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = objBlk.SocietyId;

                Param[1] = new SqlParameter("@UniqueId", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = objBlk.UniqueId;

                Param[2] = new SqlParameter("@Date", SqlDbType.VarChar);
                Param[2].Direction = ParameterDirection.Input;
                Param[2].Value = objBlk.Date;

                Param[3] = new SqlParameter("@Flag", SqlDbType.VarChar);
                Param[3].Direction = ParameterDirection.Input;
                Param[3].Value = objBlk.Flag;


                DataSet ds = SqlHelper.ExecuteDataset(conn, CommandType.StoredProcedure, "[BlkGetDuplicateRecord]", Param);

                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn = null;
            }
            
        }

        public DataSet BlkUpdateStatusTempTable(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[4];

            try
            {

                Param[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = objBlk.SocietyId;

                Param[1] = new SqlParameter("@UniqueId", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = objBlk.UniqueId;

                Param[2] = new SqlParameter("@Date", SqlDbType.VarChar);
                Param[2].Direction = ParameterDirection.Input;
                Param[2].Value = objBlk.Date;

                Param[3] = new SqlParameter("@Flag", SqlDbType.VarChar);
                Param[3].Direction = ParameterDirection.Input;
                Param[3].Value = objBlk.Flag;

                DataSet ds = SqlHelper.ExecuteDataset(conn, CommandType.StoredProcedure, "BlkUpdateStatusTempTable", Param);

                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn = null;
            }
             
        }

        public string BlkInsertTempToMainTable(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[6];

            try
            {

                Param[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = objBlk.SocietyId;

                Param[1] = new SqlParameter("@UniqueId", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = objBlk.UniqueId;

                Param[2] = new SqlParameter("@Date", SqlDbType.VarChar);
                Param[2].Direction = ParameterDirection.Input;
                Param[2].Value = objBlk.Date;

                Param[3] = new SqlParameter("@Flag", SqlDbType.VarChar);
                Param[3].Direction = ParameterDirection.Input;
                Param[3].Value = objBlk.Flag;

                Param[4] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
                Param[4].Direction = ParameterDirection.Input;
                Param[4].Value = objBlk.CreatedBy;

                Param[5] = new SqlParameter("@OutputMessage", SqlDbType.VarChar, 300);
                Param[5].Direction = ParameterDirection.Output;

                int output = SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, "BlkInsertTempToMainTable", Param);

                return Convert.ToString(Param[5].Value);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn = null;
            }
        }

        public string BlkTrucateTempTable(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[3];

            try
            {

                Param[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = objBlk.SocietyId;

                Param[1] = new SqlParameter("@Flag", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = objBlk.Flag;

                Param[2] = new SqlParameter("@MessageOutput", SqlDbType.VarChar, 300);
                Param[2].Direction = ParameterDirection.Output;

                int output = SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, "BlkTrucateTempTable", Param);

                return Convert.ToString(Param[2].Value);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn = null;
            }
        }

        public string UpdateDuplicateRecords(clsBulkUploadEntity objBlk)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[7];
            try
            {
               
                Param[0] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = objBlk.SocietyId;

                Param[1] = new SqlParameter("@UniqueId", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = objBlk.UniqueId;

                Param[2] = new SqlParameter("@Date", SqlDbType.VarChar);
                Param[2].Direction = ParameterDirection.Input;
                Param[2].Value = objBlk.Date;

                Param[3] = new SqlParameter("@Flag", SqlDbType.VarChar);
                Param[3].Direction = ParameterDirection.Input;
                Param[3].Value = objBlk.Flag;

                Param[4] = new SqlParameter("@CreatedBy", SqlDbType.VarChar);
                Param[4].Direction = ParameterDirection.Input;
                Param[4].Value = objBlk.CreatedBy;

                Param[5] = new SqlParameter("@FlatIds", SqlDbType.VarChar);
                Param[5].Direction = ParameterDirection.Input;
                Param[5].Value = objBlk.FlatIds;

                Param[6] = new SqlParameter("@OutputMessage", SqlDbType.VarChar, 300);
                Param[6].Direction = ParameterDirection.Output;

                int output = SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, "BlkUpdateDuplicateRecords", Param);

                return Convert.ToString(Param[6].Value);
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                conn = null;
            }

        }

        public DataSet GetamilnasSmsByFlatIDs(string Action, string FlatIDs, int SocietyId)
        {
            string conn = DBHelper.ConnectionString();
            SqlParameter[] Param = new SqlParameter[3];

            try
            {

                Param[0] = new SqlParameter("@Opt", SqlDbType.VarChar);
                Param[0].Direction = ParameterDirection.Input;
                Param[0].Value = Action;

                Param[1] = new SqlParameter("@FlatIds", SqlDbType.VarChar);
                Param[1].Direction = ParameterDirection.Input;
                Param[1].Value = FlatIDs;

                Param[2] = new SqlParameter("@SocietyId", SqlDbType.Int);
                Param[2].Direction = ParameterDirection.Input;
                Param[2].Value = SocietyId;

                DataSet ds = SqlHelper.ExecuteDataset(conn, CommandType.StoredProcedure, "[GetEmailPhoneForBulkSend]", Param);

                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn = null;
            }
        }
    }
}
