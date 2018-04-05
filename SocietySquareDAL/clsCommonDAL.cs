using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace SocietyDAL
{
    public class clsCommonDAL
    {
        public DataSet GetPagePermission(int RoleId, string pageurl, int PId)
        { 
            SqlConnection objSqlConn = new SqlConnection();

            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();

                SqlParameter[] objSqlParam = new SqlParameter[3];

                objSqlParam[0] = new SqlParameter("@RoleId", SqlDbType.Int);
                objSqlParam[0].Direction = ParameterDirection.Input;
                objSqlParam[0].Value = RoleId;

                objSqlParam[1] = new SqlParameter("@pageurl", SqlDbType.VarChar, 50);
                objSqlParam[1].Direction = ParameterDirection.Input;
                objSqlParam[1].Value = pageurl;

                objSqlParam[2] = new SqlParameter("@ParentId", SqlDbType.Int);
                objSqlParam[2].Direction = ParameterDirection.Input;
                objSqlParam[2].Value = PId;
                            
                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetPagePermission", objSqlParam);

                return dsOut;
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

        #region filldropdown
        public void FillDropDown(DropDownList ddl, DataTable dt, string TextField, string ValueField, string SelectText)
        {
            ddl.Items.Clear();
            if (!(dt == null || dt.Rows.Count == 0))
            {
                ddl.DataSource = dt;
                ddl.DataTextField = TextField;
                ddl.DataValueField = ValueField;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem(SelectText, ""));
        }
        #endregion

        public DataSet GetSocietyList(string LoginId)
        {
            SqlConnection objSqlConn = new SqlConnection();

            DataSet dsOut = new DataSet();
            try
            {
                objSqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["society"].ToString();
                SqlParameter objSqlParam = new SqlParameter();
                objSqlParam = new SqlParameter("@LoginId", SqlDbType.VarChar,20);
                objSqlParam.Direction = ParameterDirection.Input;
                objSqlParam.Value = LoginId;

                dsOut = SqlHelper.ExecuteDataset(objSqlConn, CommandType.StoredProcedure, "GetSocietyList", objSqlParam);

                return dsOut;
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
