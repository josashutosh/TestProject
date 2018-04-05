using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyDAL;
using System.Data;

namespace EsquareMasterTemplate.Masters
{
    public partial class EventMasterView : System.Web.UI.Page
    {
        int CurrentPage,ParentId;
        clsEvent obj = new clsEvent();
        clsDelete objd = new clsDelete();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        string Eventname, Eventdate;
        int Eventid;


        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            if (!this.IsPostBack)
            {
                this.binddata();
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
        private void binddata()
        {
            string SocietyId = string.Empty;
            DataSet ds = new DataSet();
            SocietyId = Convert.ToString(Session["ID"]) as string;
            if (SocietyId == "") { SocietyId = ""; } else {SocietyId= Convert.ToString(Session["ID"]); }
            ds = (DataSet)obj.Getdata(SocietyId);
            lvEventMstr.DataSource = ds;
            lvEventMstr.DataBind();
        }
        protected void btndelete_Click(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            LinkButton btndelete = sender as LinkButton;
            DataListItem item = btndelete.NamingContainer as DataListItem;
            HiddenField hf = item.FindControl("hdneventID") as HiddenField;
            string hid = hf.Value;

            objd.CommonDelete("EventMaster", "EventId", hid);

            binddata();
        }



        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvEventMstr.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            CurrentPage = (((lvEventMstr.FindControl("DataPager1") as DataPager).StartRowIndex) / (lvEventMstr.FindControl("DataPager1") as DataPager).MaximumRows) + 1;
            Session["CurrentPage"] = CurrentPage;
            this.binddata();
        }



        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            if (hdnAllID.Value != "")
            {
                string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                objd.CommonDelete("EventMaster", "EventId", strAllID);
                hdnAllID.Value = "";
                this.binddata();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getsearchserult();

        }



        public void getsearchserult()
        {
            string SocietyId = string.Empty;
            SocietyId = Convert.ToString(Session["ID"]) as string;
            if (SocietyId == "") { SocietyId = ""; } else { SocietyId = Convert.ToString(Session["ID"]); }
           
            try
            {
                Eventname =txtsearch.Text.TrimStart();
                Eventdate = txtEventOn.Text.Trim();
                DataSet ds = new DataSet();

                ds = (DataSet)obj.GetEventByName(Eventname, Eventdate,Convert.ToString(Session["LoginId"]));


                if (ds.Tables[0].Rows.Count > 0)
                {
                    lvEventMstr.DataSource = ds;
                    lvEventMstr.DataBind();
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("EventMaster.aspx?PId=" + ParentId);
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("EventMasterView.aspx");
        }

        
    }
}