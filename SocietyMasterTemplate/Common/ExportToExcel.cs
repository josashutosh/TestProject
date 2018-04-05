using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Text;
using System.Data;
using System.Web.UI;
using System.IO;

namespace EsquareMasterTemplate.Common
{
    public class ExportToExcel
    {
        static StringBuilder createColList;
        static StringBuilder insertColList;
        static StringBuilder paramMarks;

        public void ExcelExport(DataSet ds, string strPath)
        {

            //if (!Directory.Exists(strPath + "Masters\\ExportedFiles\\"))
            //{
            //    Directory.CreateDirectory(strPath + "Masters\\ExportedFiles\\");
            //}
            
            //string filePath = strPath + "Masters\\ExportedFiles\\" + fileName + ".xls";
            exportToExcelSlow(ds.Tables[0], strPath);
         //   return filePath;
        }

        private static void exportToExcelSlow(DataTable dt,string filePath)
        {
            #region initialization
            //if the file already exists then delete it
            System.IO.FileInfo fi = new System.IO.FileInfo(filePath);
            if (fi.Exists)
            {
                fi.Delete();
            }

          

            ////set the table name if its not there
            //if (dt.TableName == string.Empty)
            //{
            //    dt.TableName = "Sheet1";
            //}
            //else//remove $ from table name if it is there
            //{
            //    dt.TableName = dt.TableName.Replace("$", string.Empty);
            //}
            #endregion

            //string sql = GetTableCreationSql(dt);
            OleDbConnection connection = GetConnection(filePath);
            OleDbCommand command = new OleDbCommand();
            command.Connection = connection;
            try
            {
                int rowCount = 0;
                int sheetCount = 1;

                createColList = new StringBuilder();
                insertColList = new StringBuilder();
                paramMarks = new StringBuilder();

                #region Get Column List

                //Create a list of column names and their data types, e.g
                //[ColumnName1] nvarchar, [ColumnName2] nvarchar,...[ColumnNamen] nvarchar
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.Ordinal == 0)
                    {
                        createColList.Append("[");
                        insertColList.Append("[");
                        paramMarks.Append("?");
                    }
                    else
                    {
                        createColList.Append(", [");
                        insertColList.Append(", [");
                        paramMarks.Append(",?");
                    }
                    createColList.Append(col.ColumnName.Trim());
                    createColList.Append("] nvarchar");

                    insertColList.Append(col.ColumnName.Trim());
                    insertColList.Append("] ");
                }

                #endregion


                string SheetName = "Sheet" + sheetCount;

                #region Create table
                command.CommandText = GetTableCreationSql(SheetName);
                command.Connection.Open();
                command.ExecuteNonQuery();
                #endregion

                #region Insert Into Table

                command.CommandText = GetInsertSql(SheetName);

                UnicodeEncoding en = new UnicodeEncoding();
                string argumentName = string.Empty;
                int index = 0;

                foreach (DataRow row in dt.Rows)
                {
                    rowCount++;
                    //if the number of rows is > 64000 create a new page to continue output
                    if (rowCount == 64000)
                    {
                        rowCount = 0;
                        sheetCount++;
                        SheetName = "Sheet" + sheetCount;

                        command.CommandText = GetTableCreationSql(SheetName);
                        command.ExecuteNonQuery();

                        command.CommandText = GetInsertSql(SheetName);
                    }

                    // passing parameteres

                    index = 0;
                    command.Parameters.Clear();
                    foreach (DataColumn col in row.Table.Columns)
                    {
                        argumentName = "@Args" + index;
                        command.Parameters.Add(new OleDbParameter(argumentName, OleDbType.VarBinary)).Value = en.GetBytes(row[col].ToString());
                        index++;
                    }

                    //

                    //SetParametersInCommand(row, command);

                    command.ExecuteNonQuery();
                }
                #endregion
            }
            finally
            {
                command.Connection.Close();
            }
        }

        private static OleDbConnection GetConnection(string filePath)
        {
            return new System.Data.OleDb.OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=\"Excel 8.0;HDR=YES;\"");
        }

        // form a string which should be the sqlCommand for creating Table in oleDB
        // create table [tableName] ( Column1 type, ..., Columnn Type) 
        private static string GetTableCreationSql(string SheetName) //DataTable dt,
        {
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.Append("create table [");
            sqlBuilder.Append(SheetName);
            sqlBuilder.Append("] ( ");
            sqlBuilder.Append(createColList);
            sqlBuilder.Append(" )");

            return sqlBuilder.ToString();
        }

        // form a insert statement to insert data into oleDB
        // Insert Into tableName ([ColumnName1], [ColumnName2] ,...[ColumnNamen]) values (?,?,..,?)
        private static string GetInsertSql(string SheetName)
        {
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.Append("Insert Into [");
            sqlBuilder.Append(SheetName);
            sqlBuilder.Append("] ( ");
            sqlBuilder.Append(insertColList);
            sqlBuilder.Append(" ) values (");
            sqlBuilder.Append(paramMarks.ToString());
            sqlBuilder.Append(")");

            return sqlBuilder.ToString();
        }


    }
}