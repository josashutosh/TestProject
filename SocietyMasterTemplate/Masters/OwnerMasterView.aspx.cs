using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;

using System.Data;
using System.Configuration;
using SocietyEntity;
using EsquareMasterTemplate.Common;
using System.Web.Services;
using System.Data.SqlClient;

using System.Data.OleDb;
using System.Data.Common;
using System.IO;
using Newtonsoft.Json;

namespace EsquareMasterTemplate.Masters
{
    public partial class OwnerMasterView : System.Web.UI.Page
    {
        int ParentId;
       ExportToExcel objExcel = new ExportToExcel();
        clsOwnerMasterDal objownerDal = new clsOwnerMasterDal();
        clsOwnerInfo objownerinfo = new clsOwnerInfo();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                this.BindListView();
            }
        }
        private void ValidateUserPermissions()
        {
            if (Session["RoleId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Your session expired, you are logging out..!!');</script>", false);
                Response.Redirect("../Account/Login.aspx");
            }
            else
            {
                string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, 0);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                    ParentId = Convert.ToInt32(dsmm.Tables[0].Rows[0]["ParentId"]);
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }

        private void BindListView()
        {
            DataSet ds = new DataSet();
            string constr = ConfigurationManager.ConnectionStrings["society"].ConnectionString;
            ds = (DataSet)objownerDal.GetownerInfo(objownerinfo, Convert.ToString(Session["LoginId"]));
            if (ds.Tables[0].Rows.Count > 0)
            {
                lvowner.DataSource = ds.Tables[0];
                lvowner.DataBind();    
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
            }
            
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvowner.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.BindListView();
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnownerID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("OwnerMaster", "OwnerId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();
        }


        public void getsearchserult()
        {
            try
            {
                objownerinfo.ownername = txtsearch.Text.Trim();
                DataSet ds = new DataSet();
                ds = (DataSet)objownerDal.GetownerbyPan(objownerinfo, Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvowner.DataSource = ds;
                    lvowner.DataBind();
                }

                else
                {
                    lvowner.DataSource = null;
                    lvowner.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
           

        }
        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objdelrecord.CommonDeleteMaster("OwnerMaster", "OwnerId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("OwnerMaster.aspx?PId="+ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("OwnerMasterView.aspx");
        }
        protected void imgExport_Click(object sender, ImageClickEventArgs e)
        {
            objownerinfo.ownername = txtsearch.Text == "" ? "" : txtsearch.Text.Trim();
            //objBuildingEntity.BuildingId = 0;
            DataSet ds = txtsearch.Text == "" ? (DataSet)objownerDal.GetownerInfo(objownerinfo, Convert.ToString(Session["LoginId"]))
                : (DataSet)objownerDal.GetownerbyPan(objownerinfo, Convert.ToString(Session["LoginId"]));

            DateTime d = DateTime.Now;
            string dateString = d.ToString("yyyyMMddHHmmss");
            string fileName = "OwnerView" + dateString;

            string strPath = Server.MapPath(Request.ApplicationPath);
            strPath = strPath + "\\Images\\Document\\" + fileName + ".xls";

            //   string strPath = Server.MapPath(Request.ApplicationPath);
            objExcel.ExcelExport(ds, strPath);

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ClearContent();
            Response.ContentType = "application/ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename= "+fileName+".xls");
            System.IO.FileInfo fi = new System.IO.FileInfo(strPath);
            Response.WriteFile(strPath);
            Response.End();
            Response.Flush();
        }

        [WebMethod(EnableSession = true)]
        public static string InsertExcelDataToTempFlatmster(string Filepath)
        {
            Dictionary<string, List<TempOwnerMaster>> myDict = new Dictionary<string, List<TempOwnerMaster>>();

            string uniqueKey = string.Empty, Output = string.Empty, Datetime = string.Empty;
            string conStr = "";
            int SocietyId;
            string ReCount = string.Empty, UniqueRecord = string.Empty;


            //Call Connection String
            SqlConnection SqlCon = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString());

            //Create DAL and Entity Object

            clsBulkUploadDal objBlkdal = new clsBulkUploadDal();
            clsBulkUploadEntity objBlkEntity = new clsBulkUploadEntity();

            Filepath = HttpContext.Current.Server.MapPath("../Images/Document/FlatMaster/TempFlatfile/" + Filepath);
            // string FileName = string.Empty;



            #region Generate UniqueKey and Set In Session
            uniqueKey = CommonHelper.GenerateUniqueKey();

            HttpContext.Current.Session["uniqueKey"] = uniqueKey;
            #endregion

            //GetFile Extension
            string Extension = Path.GetExtension(Filepath).ToLower().Trim();

            //GetExcelConnection
            conStr = CommonHelper.GetExcelConnection(Extension);
            //Get OledbConnection
            OleDbConnection Conn = (OleDbConnection)CommonHelper.GetExcelOledbConnection(Filepath);


            using (Conn)
            {
                #region Select Record From Excel
                OleDbCommand command = new OleDbCommand("Select * FROM [Sheet1$]", Conn);
                #endregion

                Conn.Open();

                #region Map ExcelColum and Table Column
                using (DbDataReader dr = command.ExecuteReader())
                {
                    using (OleDbTransaction transaction = Conn.BeginTransaction())
                    {
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(SqlCon))
                        {

                            bulkCopy.DestinationTableName = "TempOwnerMaster";
                            bulkCopy.ColumnMappings.Add("OwnerName1", "OwnerName1");
                            bulkCopy.ColumnMappings.Add("ContactNumber", "ContactNumber");
                            bulkCopy.ColumnMappings.Add("Occupation", "Occupation");
                            bulkCopy.ColumnMappings.Add("OfficeAddress", "OfficeAddress");
                            bulkCopy.ColumnMappings.Add("OfficeContactNo", "OfficeContactNo");
                            bulkCopy.ColumnMappings.Add("PAN", "PAN");
                            bulkCopy.ColumnMappings.Add("AdhaarCard", "AdhaarCard");
                            bulkCopy.ColumnMappings.Add("IsCommiteeMember", "IsCommiteeMember");
                            bulkCopy.ColumnMappings.Add("DOB", "DOB");
                            bulkCopy.ColumnMappings.Add("permanentAddress", "permanentAddress");
                            bulkCopy.ColumnMappings.Add("Designation", "Designation");
                            bulkCopy.ColumnMappings.Add("Effectivefrom", "Effectivefrom");
                            bulkCopy.ColumnMappings.Add("TempAddress", "TempAddress");
                            bulkCopy.ColumnMappings.Add("FlatId", "FlatId");
                            bulkCopy.ColumnMappings.Add("ResidingFrom", "ResidingFrom");
                            //bulkCopy.ColumnMappings.Add("", "UniqueId");
                            //bulkCopy.ColumnMappings.Add("", "SocietyId");
                            //bulkCopy.ColumnMappings.Add("", "Status");
                            try
                            {
                                //Truncate Table FlatMaster
                                #region  Table FlatMaster
                                SocietyId = Convert.ToInt32(HttpContext.Current.Session["Id"]);
                                DateTime d = DateTime.Now;
                                Datetime = d.ToString("dd/MM/yyyy");

                                objBlkEntity.SocietyId = SocietyId;
                                objBlkEntity.UniqueId = uniqueKey;
                                objBlkEntity.Date = Datetime;
                                objBlkEntity.Flag = "TruncteTempOwnerMaster";

                                objBlkdal.BlkTrucateTempTable(objBlkEntity);
                                #endregion



                                SqlCon.Open();
                                bulkCopy.WriteToServer(dr);
                                transaction.Commit();

                            }
                            catch (Exception exc)
                            {
                                transaction.Rollback();

                                // lblErrorMsg.Text = "Branch Details Upload Failed ";
                                //JScript = "<script language ='javascript'>alert('Branch Details Upload Failed  !!!')</script>";
                                //ClientScript.RegisterClientScriptBlock(this.GetType(), "SetAlert(); return false;", JScript);
                                throw exc;
                            }
                            finally
                            {
                                dr.Close();
                                SqlCon.Close();
                            }
                        }
                    }
                }

                #endregion

            }

            //Remove Null value and insert UniqueId,date,societyId

            #region insert UniqueId,date,societyId

            objBlkEntity.Flag = "RemoveNull&UpdateOwnerMaster";

            Output = objBlkdal.RemoveNullAndUpdateFlatMaster(objBlkEntity);

            #endregion

            if (Output == "Y")
            {

                //Deleting Duplicate entries by Flat Number

                // Inserting non duplicate records
                objBlkEntity.Flag = "BlkUpdateStatusTempTableOwnerMaster";
                DataSet ds2 = (DataSet)objBlkdal.BlkUpdateStatusTempTable(objBlkEntity);

                if (ds2.Tables[0].Rows.Count > 0)
                {
                    ReCount = ds2.Tables[0].Rows[0]["RECount"].ToString();
                    UniqueRecord = ds2.Tables[0].Rows[0]["UniqueRecord"].ToString();

                  

                    //Insert into main table
                    objBlkEntity.Flag = "BlkInsertTempToMainTableOwnerMaster";
                    objBlkEntity.CreatedBy = Convert.ToString(HttpContext.Current.Session["LoginId"]);
                    Output = objBlkdal.BlkInsertTempToMainTable(objBlkEntity);

                    if (Output == "Y")
                    {
                        // Display Dupicate Record From Excel
                        #region DisplayDuplicateRecord
                        objBlkEntity.Flag = "SelectDuplicateRecordOwnermaster";

                        List<TempOwnerMaster> ByOwnerMaster = new List<TempOwnerMaster>();
                        DataSet ds = (DataSet)objBlkdal.SelectDuplicateRecordflatmaster(objBlkEntity);

                        if (ds.Tables.Count > 0)
                        {
                            //M.Clear();
                            #region Add Two list
                            for (int i = 0; i < ds.Tables.Count; i++)
                            {
                                if (ds.Tables[0].Rows.Count > 0)
                                {
                                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                                    {
                                        TempOwnerMaster MF = new TempOwnerMaster();
                                        MF.OwnerId = ds.Tables[0].Rows[j]["OwnerId"].ToString();
                                        MF.IsCommiteeMember = ds.Tables[0].Rows[j]["IsCommiteeMember"].ToString();
                                        MF.OwnerName = ds.Tables[0].Rows[j]["OwnerName"].ToString();
                                        MF.Occupation = ds.Tables[0].Rows[j]["Occupation"].ToString();
                                        MF.ResidingFrom = ds.Tables[0].Rows[j]["ResidingFrom"].ToString();
                                        MF.UniqueId = uniqueKey;
                                        MF.Date = Datetime;
                                        MF.SocietyId = SocietyId.ToString();
                                        ByOwnerMaster.Add(MF);
                                    }

                                    // data1.Add(ByFlatNumber);
                                }

                            }




                            myDict.Add("ByOwnerMaster", ByOwnerMaster);
                            #endregion
                        }


                        #endregion
                    }
                    else
                    {
                        Output = "Upload Is Fail. Contact Administrator.";
                    }

                }
                else
                {
                    Output = "No Record Found";
                }
            }


            return JsonConvert.SerializeObject(myDict);
        }



        [WebMethod(EnableSession = true)]
        public static string UpdateDuplicateFlatinfo(string OwnerIds, string Date, string UniqueKey)
        {
            //string FlatIds, string Date, string UniqueKey;
            clsBulkUploadDal objBlkdal = new clsBulkUploadDal();
            clsBulkUploadEntity objBlkEntity = new clsBulkUploadEntity();
            objBlkEntity.FlatIds = OwnerIds;
            objBlkEntity.Date = Date;
            objBlkEntity.UniqueId = UniqueKey;
            objBlkEntity.CreatedBy = HttpContext.Current.Session["LoginId"].ToString();
            objBlkEntity.SocietyId = Int32.Parse(HttpContext.Current.Session["Id"].ToString());
            objBlkEntity.Flag = "UpdateDuplicateRecordsFlatMaster";
            string Output = objBlkdal.UpdateDuplicateRecords(objBlkEntity);

            return Output;
        }


        public class TempOwnerMaster 
        {
            public string OwnerId { get; set; }
            public string OwnerName { get; set;}
            public string ContactNumber { get; set;}
            public string Occupation { get; set; }
            public string OfficeAddress { get; set;}
            public string OfficeContactNo { get; set;}
            public string PAN { get; set; }
            public string IsCommiteeMember { get; set;}
            public string DOB { get; set; }
            public string permanentAddress { get; set;}
            public string Designation { get; set; }
            public string Effectivefrom { get; set; }
            public string TempAddress { get; set; }
            public string FlatId { get; set; }
            public string UniqueId { get; set; }
            public string SocietyId { get; set; }
            public string Date { get; set; }
            public string Status { get; set; }
            public string ResidingFrom { get; set;}
        }


    }
}