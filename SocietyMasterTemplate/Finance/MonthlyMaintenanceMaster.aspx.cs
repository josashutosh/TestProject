using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyEntity;
using SocietyDAL;
using System.Data;

namespace EsquareMasterTemplate.Masters
{
    public partial class MonthlyMaintenanceMaster : System.Web.UI.Page
    {
        MonthlyMaintenanceMasterDAL objMainDal = new MonthlyMaintenanceMasterDAL();
        clsMonthlyMaintenaceEntity objMaininfo = new clsMonthlyMaintenaceEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        int MonthlyMaintenaceId, ParentId;
        string output;

        protected void Page_Load(object sender, EventArgs e)
        {
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            MonthlyMaintenaceId = Convert.ToInt32(Request.QueryString["PageID"]);
            if (!IsPostBack)
            {
                UpdateMaintainancemaster();
               //ValidateUserPermissions();

            }
        }

        //private void ValidateUserPermissions()
        //{
        //    string Page_Url = System.IO.Path.GetFileName(HttpContext.Current.Request.FilePath);
        //    DataSet dsmm = objCommonDAL.GetPagePermission(Convert.ToInt32(Session["RoleId"].ToString()), Page_Url,0);
        //    if (dsmm.Tables[0].Rows[0]["msg"].ToString() == "Restricted Entry")
        //    {
        //        Response.Redirect("../error-page/Success-page.aspx");
        //    }
        //    else
        //    {
        //        //To do: inpage rolewise retrictions if required.
        //    }
        //}

        protected void btnmensubmit_Click(object sender, EventArgs e)
        {
            if (MonthlyMaintenaceId == 0)
            {
                objMaininfo.MonthlyMaintenaceId = 0;
            }
            else
            {
                Session["MonthlyMaintenaceId"] = MonthlyMaintenaceId.ToString();
                objMaininfo.MonthlyMaintenaceId = Convert.ToInt32(Session["MonthlyMaintenaceId"]);
            }
            if (drpCalcMethod.SelectedValue == "FlatMonthlyFee")
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalculationMethod = drpCalcMethod.SelectedValue;
                objMaininfo.OwnerMonthlyMaintenance = float.Parse(txtOwnerMaintenance.Text);
                objMaininfo.TenantMonthlyMaintenance = float.Parse(txtTenantMaintenance.Text);
                objMaininfo.TotalMonthlyMaintenace = float.Parse(txtMainpermonth.Text);
                //objMaininfo.PerSquareFeetRate = float.Parse(txtPerSquareFeetRate.Text);
                objMaininfo.PerSquareFeetRate = 0;
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["LoginId"]);
            }

            if (drpCalcMethod.SelectedValue == "PerSquareFeetRate")
            {
                objMaininfo.PropertyType = drpPropertytype.SelectedValue;
                objMaininfo.CalculationMethod = drpCalcMethod.SelectedValue;
                objMaininfo.OwnerMonthlyMaintenance = 0;
                objMaininfo.TenantMonthlyMaintenance = 0;
                objMaininfo.TotalMonthlyMaintenace = 0;

                objMaininfo.PerSquareFeetRate = float.Parse(txtPerSquareFeetRate.Text);
                objMaininfo.EffectiveFromDate = txtEffectiveFromDateM.Text;
                objMaininfo.EffectiveToDate = "";
                objMaininfo.Createdby = Convert.ToString(Session["Flatno"]);
            }
            output = objMainDal.InsertMonthlymaintainance(objMaininfo);
            Session["MonthlyMaintenaceId"] = null;
            btnmensubmit.Text = "Submit";
            clearall();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);

        }




        protected void UpdateMaintainancemaster()
        {
            if (MonthlyMaintenaceId != 0)
            {
                DataSet ds = new DataSet();
               // objMaininfo.flag = "getallrecordbyMenid";
                objMaininfo.MonthlyMaintenaceId = MonthlyMaintenaceId;
                ds = (DataSet)objMainDal.GetMonthlyRecordbyId(objMaininfo);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpCalcMethod.SelectedValue = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                    drpPropertytype.SelectedValue = ds.Tables[0].Rows[0]["PropertyType"].ToString();



                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["OwnerMonthlyMaintenance"]) == 0)
                    {
                        txtOwnerMaintenance.Text = "";
                    }
                    else
                    {
                        txtOwnerMaintenance.Text = ds.Tables[0].Rows[0]["OwnerMonthlyMaintenance"].ToString();
                    }

                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["TenantMonthlyMaintenance"]) == 0)
                    {
                        txtTenantMaintenance.Text = "";
                    }
                    else
                    {
                        txtTenantMaintenance.Text = ds.Tables[0].Rows[0]["TenantMonthlyMaintenance"].ToString();
                    }

                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["TotalMonthlyMaintenace"]) == 0)
                    {
                        txtMainpermonth.Text = "";
                    }
                    else
                    {
                        txtMainpermonth.Text = ds.Tables[0].Rows[0]["TotalMonthlyMaintenace"].ToString();
                    }


                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["PerSquareFeetRate"]) == 0)
                    {
                        txtPerSquareFeetRate.Text = "";
                    }
                    else
                    {
                        txtPerSquareFeetRate.Text = ds.Tables[0].Rows[0]["PerSquareFeetRate"].ToString();
                    }


                    if (Convert.ToString(ds.Tables[0].Rows[0]["EffectiveFromDate"]) == "")
                    {
                        txtEffectiveFromDateM.Text = "";
                    }
                    else
                    {
                        txtEffectiveFromDateM.Text = StrDate(ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString());
                    }

                    if (Convert.ToString(ds.Tables[0].Rows[0]["EffectiveToDate"]) == "")
                    {
                        EffectiveToDate.Text = "";
                    }
                    else
                    {
                        EffectiveToDate.Text = StrDate(ds.Tables[0].Rows[0]["EffectiveToDate"].ToString());
                    }


                    Session["MonthlyMaintenaceId"] = MonthlyMaintenaceId.ToString();
                    btnmensubmit.Text = "Update";
                }
            }
            else
            {
                btnmensubmit.Text = "Submit";
            }
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

        private void clearall()
        {

            drpPropertytype.SelectedValue = "";
            drpCalcMethod.SelectedValue = "0";
            txtOwnerMaintenance.Text = "";
            txtTenantMaintenance.Text = "";
            txtMainpermonth.Text = "";
            txtPerSquareFeetRate.Text = "";
            txtEffectiveFromDateM.Text = "";
            EffectiveToDate.Text = "";

        }
    }
}