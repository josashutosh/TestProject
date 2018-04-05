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
    public partial class EmployeeMaster : System.Web.UI.Page
    {
        string output, Name, EmployeeNo, JobDescription, Address, PAN, AadhaarCard, Salary, Designation, DOJ, DOL;
        int ContactNo, EmployeeId, ParentId;
        clsEmployeeEntity objEmpinfo = new clsEmployeeEntity();
        EmployeeMasterDal objEmpinfoDal = new EmployeeMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            EmployeeId = Convert.ToInt32(Request.QueryString["EmployeeId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();
                UpdateEmployeemaster();
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
        protected void UpdateEmployeemaster()
        {
            if (EmployeeId != 0)
            {
                DataSet ds = new DataSet();

                objEmpinfo.EmployeeId = EmployeeId;

                ds = (DataSet)objEmpinfoDal.GetAllEmployeeInfo(objEmpinfo,Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtname.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                    txtEmpNo.Text = ds.Tables[0].Rows[0]["EmployeeNo"].ToString();
                    txtJobdescription.Text = ds.Tables[0].Rows[0]["JobDescription"].ToString();
                    txtContactNo.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                    txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                    txtPan.Text = ds.Tables[0].Rows[0]["PAN"].ToString();
                    txtAadhaarcard.Text = ds.Tables[0].Rows[0]["AadhaarCard"].ToString();
                    txtSalary.Text = ds.Tables[0].Rows[0]["Salary"].ToString();
                    txtDesignation.Text = ds.Tables[0].Rows[0]["Designation"].ToString();

                    if (ds.Tables[0].Rows[0]["DOJ"].ToString() == null)
                    {
                        txtDOJ.Text = ds.Tables[0].Rows[0]["DOJ"].ToString();
                    }
                    else
                    {

                        DOJ = StrDate(ds.Tables[0].Rows[0]["DOJ"].ToString());
                        txtDOJ.Text = DOJ;

                    }


                    if (ds.Tables[0].Rows[0]["DOL"].ToString() == null)
                    {
                        txtDOL.Text = ds.Tables[0].Rows[0]["DOL"].ToString();
                    }
                    else
                    {

                        DOL = StrDate(ds.Tables[0].Rows[0]["DOL"].ToString());
                        txtDOL.Text = DOL;

                    }


                    Session["_EmployeeId"] = EmployeeId.ToString();
                    btnInsertEmployee.Text = "Update";
                }

            }
            else
            {
                btnInsertEmployee.Text = "Save";
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



        protected void btnInsertEmployee_Click(object sender, EventArgs e)
        {
            if (EmployeeId == 0)
            {
                objEmpinfo.EmployeeId = 0;
            }
            else
            {
                Session["_EmployeeId"] = EmployeeId.ToString();
                objEmpinfo.EmployeeId = Convert.ToInt32(Session["_EmployeeId"]);
            }

            objEmpinfo.Name = txtname.Text;
            objEmpinfo.EmployeeNo = txtEmpNo.Text;
            objEmpinfo.JobDescription = txtJobdescription.Text;
            if (txtContactNo.Text == "" || txtContactNo.Text == null)
            {
                objEmpinfo.ContactNo = 0;
            }
            else
            {
                objEmpinfo.ContactNo = Convert.ToInt64(txtContactNo.Text);
            }

            objEmpinfo.Address = txtAddress.Text;
            objEmpinfo.PAN = txtPan.Text;
            objEmpinfo.AadhaarCard = txtAadhaarcard.Text;

            if (txtSalary.Text == "" || txtSalary.Text == null)
            {
                objEmpinfo.Salary = 0;
            }
            else { objEmpinfo.Salary = float.Parse(txtSalary.Text); }

            objEmpinfo.Designation = txtDesignation.Text;
            objEmpinfo.DOJ = txtDOJ.Text;

            if (txtDOL.Text == null || txtDOL.Text == "")
            { objEmpinfo.DOL = null; }
            else
            { objEmpinfo.DOL = txtDOL.Text; }

            objEmpinfo.SocietyId = Convert.ToString(Session["Id"]);
            objEmpinfo.CreatedBy = Convert.ToString(Session["LoginId"]);
            // objEmpinfo.CreatedBy = Session["UserName"].ToString();
            output = objEmpinfoDal.InsertEmployeeInformation(objEmpinfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
            clerall();
        }

        public void clerall()
        {
            txtname.Text = "";
            txtEmpNo.Text = "";
            txtContactNo.Text = "";
            txtAddress.Text = "";
            txtJobdescription.Text = "";
            txtPan.Text = "";
            txtAadhaarcard.Text = "";
            txtSalary.Text = "";
            txtDesignation.Text = "";
            txtDOJ.Text = "";
            txtDOL.Text = "";
           // Session["_EmployeeId"] = null;
            //Session.Clear();
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Session["_EmployeeId"] = null;
           Response.Redirect("EmployeeMasterView.aspx");
        }

       
    }
}