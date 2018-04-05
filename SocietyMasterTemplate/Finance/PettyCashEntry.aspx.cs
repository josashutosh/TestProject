using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;
using SocietyEntity;
using System.Data;

namespace EsquareMasterTemplate.Finance
{
    public partial class PityCashentry : System.Web.UI.Page
    {
        clsPettyCashDal ObjPCashDal = new clsPettyCashDal();
        clsPettyCashEntity ObjPCashEntity =new clsPettyCashEntity();
        string Output = String.Empty;
        float balance= 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ObjPCashEntity.SocietyId = int.Parse(Session["Id"].ToString());
                DataSet ds = (DataSet)ObjPCashDal.GetPettyCashBalanceAmount(ObjPCashEntity);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    balance = float.Parse(ds.Tables[0].Rows[0]["PettyCashBalance"].ToString());
                    lblbalance.Text = "Rs : " + balance.ToString("F2");
                    lblAlert.Text = ds.Tables[0].Rows[0]["Alert"].ToString();
                }
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           
            ObjPCashEntity.PettyCashId = 0;
            ObjPCashEntity.ExpenseDecription = txtExpDescription.Text;
            ObjPCashEntity.Amount = float.Parse(txtAmount.Text);
            ObjPCashEntity.SocietyId =int.Parse(Session["Id"].ToString());
            ObjPCashEntity.CreatedBy = Session["LoginId"].ToString();
            ObjPCashEntity.TransctionType = ddlTransType.SelectedValue;
            DataSet ds =(DataSet) ObjPCashDal.InsertPettyCashdetail(ObjPCashEntity);
            if (ds.Tables[0].Rows.Count > 0)
            {
                 balance =    float.Parse(ds.Tables[0].Rows[0]["PettyCashBalance"].ToString());

                lblbalance.Text = "Rs : " + balance.ToString("F2");
                lblAlert.Text = ds.Tables[0].Rows[0]["Alert"].ToString();
                Output = ds.Tables[0].Rows[0]["Message"].ToString(); 
            }
           
           ClearAll();
           ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning(" + Output + "); </script>", false);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }

        public void ClearAll()
        {
            txtAmount.Text = "";
            txtExpDescription.Text = "";
        }
    }
}