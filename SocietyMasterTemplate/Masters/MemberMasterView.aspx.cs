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

namespace EsquareMasterTemplate.Masters
{
    public partial class MemberMasterView : System.Web.UI.Page
    {
        int ID, PageIndex, PageSize, RecordCount, ParentId;
        string MemberType, logintype;
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatDal = new clsFlatMasterDal();
        clsDelete objdelrecord = new clsDelete();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsMemberMasterDal objmemberdal = new clsMemberMasterDal();
        clsMemberMasterEntity objmembermasterEntity = new clsMemberMasterEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidateUserPermissions();
            logintype = Convert.ToString(Session["LoginType"]); 
          
            if (!IsPostBack)
            {
                if (logintype == "SocietyMember")
                {
                    BindListView();
                }
                if (logintype == "Admin")
                {
                    DataSet ds = new DataSet();
                    FillPageDropDowns();
                    drpFlatID.Items.Insert(0, new ListItem("--Select Flat Number--", "0"));
                    drpFlatID.SelectedIndex = 0;
                     if(Convert.ToInt32(Session["drpFlatID"]) !=0)
                     {
                         drpFlatID.SelectedValue = Session["drpFlatID"].ToString();
                         ds = (DataSet)objmemberdal.GetMemberbyFlatID(Convert.ToInt32(Session["drpFlatID"]), logintype, 1, 10, 0);


                         if (ds.Tables[0].Rows.Count > 0)
                         {
                             lvMemberMaster.DataSource = ds.Tables[0];
                             lvMemberMaster.DataBind();
                             if (Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]) == true)
                             {
                                 Session["IsRented_Info"] = "tenant";
                             }
                             else
                             {
                                 Session["IsRented_Info"] = "Owner";
                             }
                             Session["IsRented"] = Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]);
                             Session["drpFlatID"] = null;
                         }
                         else
                         {
                             lvMemberMaster.DataSource = ds.Tables[0];
                             lvMemberMaster.DataBind();
                             ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
                             Session["drpFlatID"] = null;
                         }
                     }
                }
                  
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
            if (logintype == "SocietyMember")
            {
                ID = Convert.ToInt32(Session["ID"]);
                PageIndex = 1;
                PageSize = 10;
                RecordCount = 0;
            }



            ds = (DataSet)objmemberdal.GetMemberbyFlatID(ID, logintype, PageIndex, PageSize, RecordCount);

            
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]) == true)
                {
                    Session["IsRented_Info"] = "Tenent";
                }
                else
                {
                    Session["IsRented_Info"] = "Owner";
                }
                Session["IsRented"] = Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]);

                lvMemberMaster.DataSource = ds.Tables[0];
                lvMemberMaster.DataBind();
            }
        }


        protected void drpFlatID_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            if (logintype == "Admin")
            {
                ID = Convert.ToInt32(drpFlatID.SelectedValue);
                PageIndex = 1;
                PageSize = 10;
                RecordCount = 0;
            }



            ds = (DataSet)objmemberdal.GetMemberbyFlatID(ID, logintype, PageIndex, PageSize, RecordCount);
           
           
            if (ds.Tables[0].Rows.Count > 0)
            {
                lvMemberMaster.DataSource = ds.Tables[0];
                lvMemberMaster.DataBind();
                if (Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]) == true)
                {
                    Session["IsRented_Info"] = "Tenent";
                }
                else
                {
                    Session["IsRented_Info"] = "Owner";
                }
                Session["IsRented"] = Convert.ToBoolean(ds.Tables[1].Rows[0]["IsRented"]);
            }
            else
            {
                lvMemberMaster.DataSource = ds.Tables[0];
                lvMemberMaster.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
            }



        }

      

        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            if (Session["IsRented_Info"].ToString() == "Tenent")
            {
                if (hdnAllID.Value != "")
                {
                    string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                    objdelrecord.CommonDelete("TenantMaster", "TenantId", strAllID);
                    hdnAllID.Value = "";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
                }
            }
            else 
            {
                if (hdnAllID.Value != "")
                {
                    string strAllID = hdnAllID.Value.Substring(0, hdnAllID.Value.Length - 1);
                    objdelrecord.CommonDelete("OwnerFamilyMaster", "OwnerFamilyId", strAllID);
                    hdnAllID.Value = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Record Deleted Successfully.');</script>", false);
                }
            }


            if (logintype == "SocietyMember")
            {
                ID = Convert.ToInt32(Session["ID"]);

            }
            else {
                ID = Convert.ToInt32(drpFlatID.SelectedValue);
            }

            PageIndex = 1;
            PageSize = 10;
            RecordCount = 0;

            ds = (DataSet)objmemberdal.GetMemberbyFlatID(ID, logintype, PageIndex, PageSize, RecordCount);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lvMemberMaster.DataSource = ds.Tables[0];
                lvMemberMaster.DataBind();
            }
            else 
            {
                lvMemberMaster.DataSource = ds.Tables[0];
                lvMemberMaster.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('No record Found');</script>", false);
            }
        }

        private void FillPageDropDowns()
        {
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatDal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");
        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvMemberMaster.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
          //  this.BindListView();
        }

     
        }

    }
