using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyDAL;
using System.Data;
using SocietyEntity;
using EsquareMasterTemplate.Common;
using System.Web.Services;
using System.IO;
using System.Configuration;
using System.Data.OleDb;
using System.Data.Common;
using System.Data.SqlClient;
using System.Globalization;
using Newtonsoft.Json;

namespace EsquareMasterTemplate.Masters
{
    public partial class FlatMasterView : System.Web.UI.Page
    {
        int ParentId;
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatDal = new clsFlatMasterDal();
        clsCommonDeleteDal objdelrecord = new clsCommonDeleteDal();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        ExportToExcel objExcel = new ExportToExcel();
        protected void Page_Load(object sender, EventArgs e)
        {
            int ParentId;
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                BindListView();
                FillPageDropDowns();
                drpFlatID.Items.Insert(0, new ListItem("--Select Flat Number--", ""));
                drpFlatID.SelectedIndex = 0;
            }
        }

        private void BindListView()
        {
            DataSet ds = new DataSet();
            string FlatId = Convert.ToString(0);
            string flag = "searchflatinfo";
            string SocietyId = Convert.ToString(Session["ID"]) as string;
          

                objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            ds = (DataSet)objflatDal.getflatinfobyflatidFlag(flag, FlatId, Convert.ToString(Session["LoginId"]), SocietyId);
            lvFlatMaster.DataSource = ds;
            lvFlatMaster.DataBind();
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

        private void FillPageDropDowns()
        {
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatDal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");

        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvFlatMaster.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.BindListView();
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            Button btndelete = sender as Button;
            ListViewItem item = btndelete.NamingContainer as ListViewItem;
            HiddenField hf = item.FindControl("hdnflatID") as HiddenField;
            HiddenField myhiddenfield = btndelete.NamingContainer.FindControl("hiddenID") as HiddenField;
            string id = hf.Value;
            objdelrecord.CommonDeleteMaster("FlatMaster", "FlatId", id, Convert.ToString(Session["LoginId"]));
            BindListView();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();
        }


        public void getsearchserult()
        {
            string search;
            string SocietyId;
            try
            {
                if (drpFlatID.SelectedValue == "")
                {
                    objflatinfo.FlatId = 0;
                }
                else {
                    objflatinfo.FlatId = Convert.ToInt32(drpFlatID.SelectedValue);
                
                }
                DataSet ds = new DataSet();
                
                objflatinfo.flag = "searchflatinfoview";
                SocietyId = Convert.ToString(Session["ID"]) as string;
               
                    objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);

                
                ds = (DataSet)objflatDal.GetFlatbyFlatId(objflatinfo);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvFlatMaster.DataSource = ds;
                    lvFlatMaster.DataBind();
                }

                else
                {
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
                objdelrecord.CommonDeleteMaster("FlatMaster", "FlatId", strAllID, Convert.ToString(Session["LoginId"]));
                hdnAllID.Value = "";
                this.BindListView();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("FlatMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("FlatMasterView.aspx");
        }


        protected void imgExport_Click(object sender, ImageClickEventArgs e)
        {
            DataSet ds = new DataSet();

            string FlatId = Convert.ToString(drpFlatID.SelectedIndex) == "" ? "" : Convert.ToString(drpFlatID.SelectedIndex);
            string flag = FlatId == "0" ? "searchflatinfo" : "searchflatinfoview";
            objflatinfo.FlatId = Convert.ToInt32(FlatId);
            objflatinfo.flag = flag;
            string SocietyId = Convert.ToString(Session["ID"]) as string;
            

                objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            DataSet ds1 = FlatId == "0" ? (DataSet)objflatDal.getflatinfobyflatidFlag(flag, FlatId, Convert.ToString(Session["LoginId"]), SocietyId)
                : (DataSet)objflatDal.GetFlatbyFlatno(objflatinfo, Convert.ToString(Session["LoginId"]));



            DateTime d = DateTime.Now;
            string dateString = d.ToString("yyyyMMddHHmmss");
            string fileName = "FlatView" + dateString;

            string strPath = Server.MapPath(Request.ApplicationPath);
            strPath = strPath + "\\Images\\Document\\" + fileName + ".xls";


            objExcel.ExcelExport(ds1, strPath);

            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ClearContent();
            Response.ContentType = "application/ms-excel";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName + ".xls");
            Response.WriteFile(strPath);
            Response.End();
            Response.Flush();
        }

        [WebMethod(EnableSession = true)]
        public static string GetFlatExcelPattern()
        {
            string Folderpath = string.Empty;


            clsFlatMasterDal objFlatmaster = new clsFlatMasterDal();
            ExportToExcel objExcel = new ExportToExcel();
            DataSet ds = (DataSet)objFlatmaster.GetFlatInfobySocietyID(int.Parse(HttpContext.Current.Session["Id"].ToString()), "FlatMaster");

            if (ds.Tables[0].Rows.Count > 0)
            {
                DateTime d = DateTime.Now;
                string dateString = d.ToString("yyyyMMddHHmmss");
                string fileName = "FlatView" + dateString;

                string strPath = HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath);

                Folderpath = strPath + "\\Images\\Document\\FlatMaster";

                if (!Directory.Exists(Folderpath))
                {
                    Directory.CreateDirectory(Folderpath);
                }
                else
                {
                    CommonHelper.DeleteAllFile(Folderpath);
                }

                strPath = strPath + "\\Images\\Document\\FlatMaster\\" + fileName + ".xls";

                objExcel.ExcelExport(ds, strPath);

                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ContentType = "application/ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + fileName + ".xls");
                HttpContext.Current.Response.WriteFile(strPath);
                //HttpContext.Current.Response.End();
                //  HttpContext.Current.Response.Flush();


            }
            return "Success";
        }

        [WebMethod(EnableSession = true)]
        public static string UpdateDuplicateFlatinfo(string FlatIds, string Date, string UniqueKey)
        {
            //string FlatIds, string Date, string UniqueKey;
            clsBulkUploadDal objBlkdal = new clsBulkUploadDal();
            clsBulkUploadEntity objBlkEntity = new clsBulkUploadEntity();
            objBlkEntity.FlatIds = FlatIds;
            objBlkEntity.Date = Date;
            objBlkEntity.UniqueId = UniqueKey;
            objBlkEntity.CreatedBy = HttpContext.Current.Session["LoginId"].ToString();
            objBlkEntity.SocietyId = Int32.Parse(HttpContext.Current.Session["Id"].ToString());
            objBlkEntity.Flag = "UpdateDuplicateRecordsFlatMaster";
            string Output = objBlkdal.UpdateDuplicateRecords(objBlkEntity);

            return Output;
        }

        [WebMethod(EnableSession = true)]
        public static string InsertExcelDataToTempFlatmster(string Filepath)
        {
            Dictionary<string, List<TempFlatMaster>> myDict = new Dictionary<string, List<TempFlatMaster>>();
           
            string uniqueKey=string.Empty,Output=string.Empty, Datetime=string.Empty;
            string conStr = "";
            int SocietyId;
            string ReCount=string.Empty, UniqueRecord = string.Empty;
           

            //Call Connection String
            SqlConnection SqlCon = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["society"].ToString());

            //Create DAL and Entity Object

            clsBulkUploadDal objBlkdal = new clsBulkUploadDal();
            clsBulkUploadEntity objBlkEntity = new clsBulkUploadEntity();

            Filepath = HttpContext.Current.Server.MapPath("../Images/Document/FlatMaster/TempFlatfile/"+Filepath);
           // string FileName = string.Empty;
        
            
         
            #region Generate UniqueKey and Set In Session
            uniqueKey = CommonHelper.GenerateUniqueKey();    
            
            HttpContext.Current.Session["uniqueKey"] = uniqueKey;
         #endregion 

           //GetFile Extension
            string Extension = Path.GetExtension(Filepath).ToLower().Trim();

            //GetExcelConnection
           conStr= CommonHelper.GetExcelConnection(Extension);
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

                           bulkCopy.DestinationTableName = "TempFlatMaster";
                           bulkCopy.ColumnMappings.Add("BuildingName", "BuildingName");
                           bulkCopy.ColumnMappings.Add("FlatNumber", "FlatNumber");
                           bulkCopy.ColumnMappings.Add("CarpetArea", "CarpetArea");
                           bulkCopy.ColumnMappings.Add("TotalArea", "TotalArea");
                           bulkCopy.ColumnMappings.Add("FlatType", "FlatType");
                           bulkCopy.ColumnMappings.Add("IsShareCertificateGiven", "IsShareCertificateGiven");
                           bulkCopy.ColumnMappings.Add("ShareCertificateNumber", "ShareCertificateNumber");
                           bulkCopy.ColumnMappings.Add("IsRented", "IsRented");
                           bulkCopy.ColumnMappings.Add("BusinessType", "BusinessType");
                           bulkCopy.ColumnMappings.Add("LicenseNo", "LicenseNo");
                           bulkCopy.ColumnMappings.Add("ShopDescription", "ShopDescription");
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
                               objBlkEntity.Flag = "TruncteTempFlatMaster";

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

           objBlkEntity.Flag = "RemoveNull&UpdateFlatMaster";

                Output = objBlkdal.RemoveNullAndUpdateFlatMaster(objBlkEntity);

           #endregion

                if (Output == "Y")
                {
                   
                    //Deleting Duplicate entries by Flat Number
                      
                    // Inserting non duplicate records
                      objBlkEntity.Flag = "BlkUpdateStatusTempTableFlatMaster";
                      DataSet ds2 = (DataSet)objBlkdal.BlkUpdateStatusTempTable(objBlkEntity);

                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        ReCount = ds2.Tables[0].Rows[0]["RECount"].ToString();
                        UniqueRecord = ds2.Tables[0].Rows[0]["UniqueRecord"].ToString();


                        //Insert into main table
                        objBlkEntity.Flag = "BlkInsertTempToMainTableFlatMaster";
                        objBlkEntity.CreatedBy = Convert.ToString(HttpContext.Current.Session["LoginId"]);
                        Output = objBlkdal.BlkInsertTempToMainTable(objBlkEntity);

                        if (Output == "Y")
                        {
                            // Display Dupicate Record From Excel
                            #region DisplayDuplicateRecord
                            objBlkEntity.Flag = "SelectDuplicateRecordflatmaster";
                           
                            List<TempFlatMaster> ByFlatNumber = new List<TempFlatMaster>();
                            List<SetHiddenvalue> SetHiddenvalue = new List<SetHiddenvalue>();
                            List<List<TempFlatMaster>> data1 = new List<List<TempFlatMaster>>();
                            List<List<SetHiddenvalue>> data2 = new List<List<SetHiddenvalue>>();
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
                                            TempFlatMaster MF = new TempFlatMaster();
                                            MF.BuildingName = ds.Tables[0].Rows[j]["BuildingName"].ToString();
                                            MF.BuildingId = ds.Tables[0].Rows[j]["BuildingId"].ToString();
                                            MF.FlatNumber = ds.Tables[0].Rows[j]["FlatNumber"].ToString();
                                            MF.FlatId = ds.Tables[0].Rows[j]["FlatId"].ToString();
                                            MF.IsRented = ds.Tables[0].Rows[j]["IsRented"].ToString();
                                            MF.FlatType = ds.Tables[0].Rows[j]["FlatType"].ToString();
                                            MF.PropertyType = ds.Tables[0].Rows[j]["PropertyType"].ToString();
                                            MF.UniqueId = uniqueKey;
                                            MF.Date = Datetime;
                                            MF.SocietyId = SocietyId.ToString();
                                            ByFlatNumber.Add(MF);
                                        }

                                        
                                       // data1.Add(ByFlatNumber);
                                   }
                                   
                                }




                                myDict.Add("ByFlatmember", ByFlatNumber);
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

        #region AutoGenerate property
            public class selectDupicateRecord
            {
                
                public List<TempFlatMaster> ByFlatNumber { get; set; }
                public List<SetHiddenvalue> SetHiddenvalue { get; set; }
            }

            public class TempFlatMaster 
            {
                public string BuildingName { get; set; }
                public string BuildingId { get; set; }
                public string FlatId { get; set; }
                public string FlatNumber { get; set; }
                public string CarpetArea { get; set; }
                public string TotalArea { get; set; }
                public string FlatType { get; set; }
                public string IsShareCertificateGiven { get; set; }
                public string ShareCertificateNumber { get; set; }
                public string IsRented { get; set; }
                public string PropertyType { get; set; }
                public string BusinessType { get; set; }
                public string LicenseNo { get; set; }
                public string ShopDescription { get; set; }
                public string UniqueId { get; set; }
                public string SocietyId { get; set; }
                public string Date { get; set; }
            }
       
            public class SetHiddenvalue
            {
                public string UniqueId { get; set; }
                public string SocietyId { get; set; }
                public string Date { get; set; }
            } 

        #endregion


        protected void btnDownloadPattern_click(object Sender, EventArgs e)
        {
            string Folderpath = string.Empty;


            DataSet ds = (DataSet)objflatDal.GetFlatInfobySocietyID(int.Parse(HttpContext.Current.Session["Id"].ToString()), "FlatMaster");

            if (ds.Tables[0].Rows.Count > 0)
            {
                DateTime d = DateTime.Now;
                string dateString = d.ToString("yyyyMMddHHmmss");
                string fileName = "FlatView" + dateString;

                string strPath = HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath);

                Folderpath = strPath + "\\Images\\Document\\FlatMaster";

                if (!Directory.Exists(Folderpath))
                {
                    Directory.CreateDirectory(Folderpath);
                }
                else
                {
                    CommonHelper.DeleteAllFile(Folderpath);
                }

                strPath = strPath + "\\Images\\Document\\FlatMaster\\" + fileName + ".xls";

                objExcel.ExcelExport(ds, strPath);

                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ContentType = "application/ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" + fileName + ".xls");
                HttpContext.Current.Response.WriteFile(strPath);
                HttpContext.Current.Response.End();
                HttpContext.Current.Response.Flush();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>DisplayPopup();</script>", false);
            }

        }

      


    }
}