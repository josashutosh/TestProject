using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using System.Data;


namespace EsquareMasterTemplate.Masters
{
    public partial class EventMaster : System.Web.UI.Page
    {
        clsEvent obj = new clsEvent();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        int EvntID,ParentId;
        string result;
        protected void Page_Load(object sender, EventArgs e)
        {
            EvntID = Convert.ToInt32(Request.QueryString["EventId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);

            if (!IsPostBack)
            {
                ValidateUserPermissions();
                //if (Convert.ToString(Session["Roomno"]) == "")
                //{
                //    Response.Redirect("login.aspx");
                //}
                if (EvntID == 0)
                {

                    Upload_T.Visible = true;
                    Path_T.Visible = false;
                    Button_T.Visible = false;
                }
                insertfields();
                UpdateEventMaster();
              
                
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
                DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url, ParentId);
                if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
                {
                    Response.Redirect("../error-page/Success-page.aspx");
                }
                else
                {
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }
        private void UpdateEventMaster()
        {
            if (EvntID != 0)
            {
                DataSet ds = new DataSet();


                ds = (DataSet)obj.GetEventDetails(EvntID);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txteventname.Text = ds.Tables[0].Rows[0]["EventName"].ToString();
                    txtdesc.Text = ds.Tables[0].Rows[0]["EventDescription"].ToString();

                    if (ds.Tables[0].Rows[0]["EventOn"].ToString() == null)
                    {
                        txteventon.Text = ds.Tables[0].Rows[0]["EventOn"].ToString();
                    }
                    else
                    {
                        txteventon.Text = StrDate(ds.Tables[0].Rows[0]["EventOn"].ToString());
                    }
                    if (ds.Tables[0].Rows[0]["EventTime"].ToString() == null || ds.Tables[0].Rows[0]["EventTime"].ToString() == "")
                    {
                        txteventon.Text = "";
                    }
                    else
                    {
                        txtEventTime.Text = ds.Tables[0].Rows[0]["EventTime"].ToString();
                    }

                   

                    if (ds.Tables[0].Rows[0]["FileName"].ToString().Trim() != "")
                    {
                        Upload_T.Visible = false;
                        Path_T.Visible = true;
                        Button_T.Visible = true;
                        lblFile.Visible = true;
                        Txtpath.Text = ds.Tables[0].Rows[0]["FileName"].ToString().Trim();
                        lblFile.Text = ds.Tables[0].Rows[0]["FileUploadFileName"].ToString().Trim();
                    }
                    else
                    {
                        Upload_T.Visible = true;
                        Path_T.Visible = false;
                        Button_T.Visible = false;
                        lblFile.Visible = false;
                    }

                    txtContactperson.Text = ds.Tables[0].Rows[0]["ContactPerson"].ToString();
                    txtMobileNumber.Text = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                    txtcontribution.Text = ds.Tables[0].Rows[0]["Contribution"].ToString();


                    Session["_EventID"] = EvntID.ToString();
                    btnsubmit.Text = "Update";
                }
            }
            else
            {
                btnsubmit.Text = "Save";
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {

            if (EvntID == 0)
            {
                EvntID = 0;
            }
            else
            {
                Session["_EventID"] = EvntID.ToString();
                EvntID = Convert.ToInt32(Session["_EventID"]);
            }
            string FileName = "";
            try
            {
                //Server.MapPath(@"~/");
                if (FileUpload.HasFile == true)
                {
                    FileName = Session["Id"]+ "/"+ DateTime.Now.ToString("yyyyMMdd$HHmmss$fffffff") + "_" + FileUpload.FileName;

                    if (System.IO.Directory.Exists(Server.MapPath(@"~/") + @"\Images\Event\" + Session["Id"] + "") == false)
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(@"~/") + @"\Images\Event\" + Session["Id"]);
                    }
                    
                    string FilePath = Server.MapPath(@"~/") +@"\Images\Event\"+FileName;
                    FileUpload.PostedFile.SaveAs(FilePath);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
            if (EvntID == 0)
            {
                result = obj.Insertevent(EvntID, Convert.ToString(txteventname.Text), Convert.ToString(txtdesc.Text), Convert.ToString(txteventon.Text), Convert.ToString(txtContactperson.Text), Convert.ToString(txtMobileNumber.Text), Convert.ToString(txtcontribution.Text), FileUpload.FileName, FileName, txtEventTime.Text, Convert.ToString(Session["LoginId"]), Convert.ToString(Session["Id"]));

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + result + "');</script>", false);
            }
            else 
            {

                if (FileUpload.FileName.Trim() != "")
                {
                    result = obj.Insertevent(EvntID, Convert.ToString(txteventname.Text), Convert.ToString(txtdesc.Text), Convert.ToString(txteventon.Text), Convert.ToString(txtContactperson.Text), Convert.ToString(txtMobileNumber.Text), Convert.ToString(txtcontribution.Text), FileUpload.FileName, FileName, txtEventTime.Text, Convert.ToString(Session["LoginId"]), Convert.ToString(Session["Id"]));
                }
                else if (Txtpath.Text.ToString().Trim() != "")
                {
                    result = obj.Insertevent(EvntID, Convert.ToString(txteventname.Text), Convert.ToString(txtdesc.Text), Convert.ToString(txteventon.Text), Convert.ToString(txtContactperson.Text), Convert.ToString(txtMobileNumber.Text), Convert.ToString(txtcontribution.Text), lblFile.Text, Txtpath.Text.ToString(), txtEventTime.Text, Convert.ToString(Session["LoginId"]), Convert.ToString(Session["Id"]));
                }

                else
                {
                    result = obj.Insertevent(EvntID, Convert.ToString(txteventname.Text), Convert.ToString(txtdesc.Text), Convert.ToString(txteventon.Text), Convert.ToString(txtContactperson.Text), Convert.ToString(txtMobileNumber.Text), Convert.ToString(txtcontribution.Text), "", "", txtEventTime.Text, Convert.ToString(Session["LoginId"]), Convert.ToString(Session["Id"]));
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + result + "');</script>", false);
                    
            }

            clearall();
            
        }

        protected void insertfields()
        {
            if (EvntID != 0)
            {
                DataSet ds = new DataSet();
                ds = (DataSet)obj.GetEventDetails(EvntID);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    // txtmax.Text = ds.Tables[0].Rows[0]["MAXMARKS"].ToString();
                    Session["_EventID"] = EvntID.ToString();
                    btnsubmit.Text = "Update";
                }
            }
            else
            {
                btnsubmit.Text = "Submit";
            }
        }

        private void clearall()
        {
            txtContactperson.Text = "";
            txtMobileNumber.Text = "";
            txtcontribution.Text = "";
            txtdesc.Text = "";
            txteventname.Text = "";
            txteventon.Text = "";
            txtEventTime.Text = "";
            Txtpath.Text = "";
        }
        private string StrDate(string Date)
        {
            if (Date != "")
            {
                string[] Date1 = Date.Split('/');


                // Date = Date1[2] + "/" + Date1[1] + "/" + Date1[0];

                string[] Date2 = Date1[2].Split(' ');

                Date = Date1[1] + "/" + Date1[0] + "/" + Date2[0];
                return (Date);
            }
            else
            {
                return null;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
         
            Session["_EventID"] = null;
            Response.Redirect("EventMasterView.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtContactperson.Text = "";
            txtMobileNumber.Text = "";
            txtcontribution.Text = "";
            txtdesc.Text = "";
            txteventname.Text = "";
            txteventon.Text = "";
            txtEventTime.Text = "";
            Txtpath.Text = "";
            
        }

        /***************************************File Upload***************************************************************/

        protected void btnView_Click(object sender, EventArgs e)
        {
            Download(Txtpath.Text.ToString());
        }
        protected void AddFile_Click1(object sender, EventArgs e)
        {
            Upload_T.Visible = true;
            Path_T.Visible = false;
            AddFile.Visible = false;
            btnView.Visible = false;
        }
        protected void AddCancel_Click1(object sender, EventArgs e)
        {
            Upload_T.Visible = false;
            Path_T.Visible = true;
            AddFile.Visible = true;
            btnView.Visible = true;
        }
        
        protected void btnView_Click1(object sender, EventArgs e)
        {
            Download(Txtpath.Text.ToString());
        }

        public void Download(string Path)
        {
            try
            {
                if (Path != null)
                {
                    Response.AddHeader("content-disposition", "attachment; filename=" + Path);
                    Response.WriteFile(Server.MapPath(@"../Images/Event/" + Path.ToString()));
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message.ToString());
            }
        }

        


        /***************************************End File upload***********************************************************/
        
    }
}