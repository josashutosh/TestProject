using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Data.SqlClient;
using SocietyDAL;
using SocietyDAL;
using System.Globalization;
using SocietyEntity;
namespace EsquareMasterTemplate.Masters
{
    public partial class FlatMemberMaster : System.Web.UI.Page
    {
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        //clsMaintainanceDal objMenDal = new clsMaintainanceDal();
        clsMemberMasterDal objmemberDal = new clsMemberMasterDal();
        clsMemberMasterEntity objMemberInfo = new clsMemberMasterEntity(); 
        DataTable dtTenant = new DataTable();
        DataTable dtFamilyMember = new DataTable();
        DataSet ds;
        int ID;
        string membertype, relation, FlatId, flag, output;
        protected void Page_Load(object sender, EventArgs e)
        {

            ID = Convert.ToInt32(Request.QueryString["PageID"]);
            Session["MemMster_ID"]=ID;

        if (!IsPostBack)
            {

                ValidateUserPermissions();
             
                if (Convert.ToInt32(Session["Role_ID"]) == 1)
                {
               
                    if (ID != 0)
                    {
                        hideall();
                        if (Convert.ToBoolean(Session["IsRented"]) == true)
                        {
                            TenantMstr.Attributes["style"] = "display:block";
                            FamilyinfoMstr.Attributes["style"] = "display:none;";
                            rowAdmindisplay.Attributes["style"] = "display:none;";
                        }
                        else
                        {
                            TenantMstr.Attributes["style"] = "display:none";
                            FamilyinfoMstr.Attributes["style"] = "display:block";
                            rowAdmindisplay.Attributes["style"] = "display:none;";
                        }
                    }
                    else
                    {
                        showTenent();
                        FamilyInfo();
                        hideall();
                        FillPageDropDowns();
                        rowAdmindisplay.Attributes["style"] = "display:block;";
                        selectMemberType.Attributes["style"] = "display:none;";
                        selectMemberType.Visible = true;
                        drpFlatID.Items.Insert(0, new ListItem("--Select Flat Name--", ""));
                        drpFlatID.SelectedIndex = 0;
                    }

                }
                else
                {
                    rowAdmindisplay.Attributes["style"] = "display:none;";
                    if (Session["IsRented"] == null && Session["FlatId"] == null)
                    {
                        Response.Redirect("~/Dashboards/FlatSelector.aspx?Action=SelectFlat");
                    }
                    else 
                    {
                        if (Convert.ToBoolean(Session["IsRented"]) == true)
                        {
                            TenantMstr.Attributes["style"] = "display:block";
                            FamilyinfoMstr.Attributes["style"] = "display:none;";
                            rowAdmindisplay.Attributes["style"] = "display:none;";
                        }
                        else
                        {
                            TenantMstr.Attributes["style"] = "display:none";
                            FamilyinfoMstr.Attributes["style"] = "display:block";
                            rowAdmindisplay.Attributes["style"] = "display:none;";
                        }
                    }

                  
                }
                Updatemaster();
            }       
        }

        private void Updatemaster()
        {
            if (ID != 0)
            {
                DataSet ds = new DataSet();
                if (Convert.ToBoolean(Session["IsRented"]) == true)
                {

                    ds = (DataSet)objmemberDal.GetmemberMasterbyID("GetTenantInfo", ID);
                    if (ds.Tables.Count > 0)
                    {
                        txtotherrelation.Attributes["style"] = "display:none";
                        var FlatId = ds.Tables[0].Rows[0]["FlatId"].ToString();
                        Session["FlatId"] = FlatId;
                        txttenantName.Text = ds.Tables[0].Rows[0]["TenantName"].ToString();
                        txtresidingfrom.Text = StrDate(ds.Tables[0].Rows[0]["ResidingFrom"].ToString());
                        txtresidingto.Text = StrDate(ds.Tables[0].Rows[0]["ResidingTo"].ToString());
                        txtrent.Text = ds.Tables[0].Rows[0]["Rent"].ToString();
                        txtpan.Text = ds.Tables[0].Rows[0]["PAN"].ToString();
                        txtaadhar.Text = ds.Tables[0].Rows[0]["AadhaarCard"].ToString();
                        txtpermanantaddress.Text = ds.Tables[0].Rows[0]["PermanantAddress"].ToString();
                        txtcontactno1.Text = ds.Tables[0].Rows[0]["ContactNo1"].ToString();
                        txtcontactno2.Text = ds.Tables[0].Rows[0]["ContactNo2"].ToString();
                        txttenantDob.Text = StrDate(ds.Tables[0].Rows[0]["DOB"].ToString());
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Gender"]) == "Male")
                        {
                            rbtngendertM.Checked = true;
                            rbtngendertF.Checked = false;
                        }
                        else
                        {
                            rbtngendertM.Checked = false;
                            rbtngendertF.Checked = true;
                        }

                        Session["MemMster_ID"] = ID.ToString();
                        btnUpdate.Text = "Update";
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found'); alert('Please ');</script>", false);
                    }


                }
                else 
                {
                    ds = (DataSet)objmemberDal.GetmemberMasterbyID("GetOwnerFamilyInfo", ID);
                    if (ds.Tables.Count > 0)
                    {
                        var FlatId = ds.Tables[0].Rows[0]["FlatId"].ToString();
                        Session["FlatId"] = FlatId;
                        txtFlatMemberName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                        txtFlatMemberResfrom.Text = StrDate(ds.Tables[0].Rows[0]["ResidingFrom"].ToString());
                        txtFlatMemberPan.Text = ds.Tables[0].Rows[0]["PAN"].ToString();
                        txtFlatMemberAdhaar.Text = ds.Tables[0].Rows[0]["AadhaarCard"].ToString();
                        txtFlatMemberAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                        txtFlatMemberConNo.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();


                        if (Convert.ToString(ds.Tables[0].Rows[0]["Relation"]) == "Other")
                        {
                            txtotherrelation.Text = ds.Tables[0].Rows[0]["OtherRelation"].ToString();
                            txtotherrelation.Attributes["style"] = "display:block";
                        }
                        else
                        {
                            txtotherrelation.Attributes["style"] = "display:none";
                            txtotherrelation.Text = ds.Tables[0].Rows[0]["OtherRelation"].ToString();
                            drpFlatMemberRelation.SelectedValue = ds.Tables[0].Rows[0]["Relation"].ToString();
                        }


                        txtFlatMemberDob.Text = StrDate(ds.Tables[0].Rows[0]["DOB"].ToString());

                        if (Convert.ToString(ds.Tables[0].Rows[0]["Gender"]) == "Male")
                        {
                            rbtnGenderff.Checked = false;
                            rbtnGenderfm.Checked = true;
                        }
                        else
                        {
                            rbtnGenderff.Checked = true;
                            rbtnGenderfm.Checked = false;
                        }

                        Session["MemMster_ID"] = ID.ToString();
                        btnUpdate.Text = "Update";
                    }
                    else 
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found');</script>", false);
                    }

                }

            }
            else
            {
                btnUpdate.Text = "Submit";
            }
        }



        protected void btnCancelupdate_Click(object sender, EventArgs e)
        {
            
            if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
            {
                Session["MemMster_ID"] = null;
                Response.Redirect("MemberMasterView.aspx");
            }

            if (Convert.ToString(Session["LoginType"]) == "Admin")
            {
                Session["MemMster_ID"] = null;
                Response.Redirect("MemberMasterView.aspx");
            }

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            if (Convert.ToString(Session["MemMster_ID"]) == "")
            {
                objMemberInfo.Id = 0;
            }
            else
            {
                Session["MemMster_ID"] = ID.ToString();
                objMemberInfo.Id = ID;
            }


            if (Convert.ToBoolean(Session["IsRented"]) == true)
            {
                objMemberInfo.FlatId = Convert.ToInt32(Session["FlatId"]);
                Session["drpFlatID"] = objMemberInfo.FlatId;
                 objMemberInfo.Name=  txttenantName.Text;
                 objMemberInfo.ResidingFrom =  txtresidingfrom.Text;
                 objMemberInfo.ResidingTO= txtresidingto.Text;
                 objMemberInfo.Rent = Convert.ToDouble(txtrent.Text);
                 objMemberInfo.PAN = txtpan.Text;
                 objMemberInfo.AadhaarCard = Convert.ToInt64(txtaadhar.Text);
                 objMemberInfo.PermanantAddress =  txtpermanantaddress.Text;
                 objMemberInfo.ContactNo1 = Convert.ToInt64(txtcontactno1.Text);
                 objMemberInfo.ContactNo2 = Convert.ToInt64(txtcontactno2.Text);
                 objMemberInfo.DOB= txttenantDob.Text;
                 if (rbtnGenderfm.Checked == true)
                 {
                     objMemberInfo.Gender = "Male";
                 }
                 else
                 {
                     objMemberInfo.Gender = "Female";
                 }
                 objMemberInfo.IsRented = 1;
                 objMemberInfo.CreatedBy = Session["LoginId"].ToString();
            }
            else 
            {
                objMemberInfo.FlatId = Convert.ToInt32(Session["FlatId"]);
                Session["drpFlatID"] = objMemberInfo.FlatId;
               objMemberInfo.Name = txtFlatMemberName.Text;
               objMemberInfo.ResidingFrom = txtFlatMemberResfrom.Text;
               objMemberInfo.PAN = txtFlatMemberPan.Text;
               objMemberInfo.AadhaarCard = Convert.ToInt64(txtFlatMemberAdhaar.Text);
                objMemberInfo.PermanantAddress = txtFlatMemberAddress.Text; 
               objMemberInfo.ContactNo1 = Convert.ToInt64(txtFlatMemberConNo.Text);

                if(drpFlatMemberRelation.SelectedValue=="Other")
                {
                    objMemberInfo.OtherRelation = txtotherrelation.Text;
                }
                else
                {
                   objMemberInfo.Relation = drpFlatMemberRelation.SelectedValue;
                }               
                
                objMemberInfo.DOB = txtFlatMemberDob.Text;

                if (rbtnGenderfm.Checked == true)
                {
                    objMemberInfo.Gender = "Male";
                }
                else
                {
                    objMemberInfo.Gender = "Female";
                }
                objMemberInfo.IsRented = 0;
                objMemberInfo.CreatedBy = Session["LoginId"].ToString();
            }

            output = objmemberDal.InsertMemberMstr(objMemberInfo);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);

            if (Convert.ToString(Session["LoginType"]) == "SocietyMember")
            {     Session["MemMster_ID"]=null;
                Response.Redirect("MemberMasterView.aspx");
            }

            if (Convert.ToString(Session["LoginType"]) == "Admin")
            {
                Session["MemMster_ID"] = null;
                Response.Redirect("MemberMasterView.aspx");
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
                    //To do: inpage rolewise retrictions if required.
                }
            }
        }

        private void FillPageDropDowns()
        {
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");
        }

        protected void Flatnumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            objflatinfo.FlatId =Convert.ToInt32(drpFlatID.SelectedValue);
            DataSet ds1 = new DataSet();
            ds1 = (DataSet)objflatdal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]));
            if (ds1.Tables[0].Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('No Record Found'); alert('Please ');</script>", false);
            }
            else
            {
                var Isrented = ds1.Tables[0].Rows[0]["IsRented"].ToString();
                if (Convert.ToBoolean(Isrented) == true)
                {
                    TenantMstr.Attributes["style"] = "display:block";
                    FamilyinfoMstr.Attributes["style"] = "display:none;";
                }
                else
                {
                    TenantMstr.Attributes["style"] = "display:none";
                    FamilyinfoMstr.Attributes["style"] = "display:block;";
                }
            }

        }

        //*************************** HIde Show Div**********************************//     
        public void showTenent()
        {
            membertype = drpFamilyinfo.SelectedValue;
            if (membertype == "Tenent")
            {
                TenantMstr.Attributes["style"] = "display:block;";
                FamilyinfoMstr.Attributes["style"] = "display:none;";
            }

        }

        public void FamilyInfo()
        {
            membertype = drpFamilyinfo.SelectedValue;
            if (membertype == "FamilyInfo")
            {

                TenantMstr.Attributes["style"] = "display:none;";
                FamilyinfoMstr.Attributes["style"] = "display:block;";
            }
        }

        public void hideall()
        {
            membertype = drpFamilyinfo.SelectedValue;
            if (membertype == "zero")
            {

                TenantMstr.Attributes["style"] = "display:none;";
                FamilyinfoMstr.Attributes["style"] = "display:none;";
            }

            if (drpFlatMemberRelation.SelectedValue == "Other")
            {
                txtotherrelation.Attributes["style"] = "display:block;";
            }
            else
            {
                txtotherrelation.Attributes["style"] = "display:none;";
            }

        }
        //***************************END HIde Show Div**********************************//  

        //*************************** Insert Tenant master Info**********************************//  
        protected void btnTenantsubmit_Click1(object sender, EventArgs e)
        {
            dtTenant.Columns.Add("FlatId");
            dtTenant.Columns.Add("TenantName");
            dtTenant.Columns.Add("ResidingFrom");
            dtTenant.Columns.Add("ResidingTo");
            dtTenant.Columns.Add("Rent");
            dtTenant.Columns.Add("PAN");
            dtTenant.Columns.Add("AadhaarCard");
            dtTenant.Columns.Add("PermanantAddress");
            dtTenant.Columns.Add("ContactNo1");
            dtTenant.Columns.Add("ContactNo2");
            dtTenant.Columns.Add("DOB");
            dtTenant.Columns.Add("Gender");
            dtTenant.Columns.Add("Active");
            dtTenant.Columns.Add("CreatedBy");
            // dtTenant.Columns.Add("CreatedOn");

            dgTenant.Columns[12].Visible = false;
            dgTenant.Columns[13].Visible = false;
            //dgTenant.Columns[12].Visible = false;
            DataRow row;
            int i = 0;
            while (i <= dgTenant.Items.Count)
            {
                row = dtTenant.NewRow();
                if (i < dgTenant.Items.Count)
                {
                    row["FlatId"] = dgTenant.Items[i].Cells[0].Text;
                    row["TenantName"] = dgTenant.Items[i].Cells[1].Text;
                    row["ResidingFrom"] = dgTenant.Items[i].Cells[2].Text;
                    row["ResidingTo"] = dgTenant.Items[i].Cells[3].Text;
                    row["Rent"] = dgTenant.Items[i].Cells[4].Text;
                    row["PAN"] = dgTenant.Items[i].Cells[5].Text;
                    row["AadhaarCard"] = dgTenant.Items[i].Cells[6].Text;
                    row["PermanantAddress"] = dgTenant.Items[i].Cells[7].Text;
                    row["ContactNo1"] = dgTenant.Items[i].Cells[8].Text;
                    row["ContactNo2"] = dgTenant.Items[i].Cells[9].Text;
                    row["DOB"] = dgTenant.Items[i].Cells[10].Text;
                    row["Gender"] = dgTenant.Items[i].Cells[11].Text;
                    row["Active"] = "";
                    row["CreatedBy"] = "";
                    //   row["CreatedOn"] = "";

                    dtTenant.Rows.Add(row);
                }
                else
                {
                    if (Convert.ToInt32(Session["Role_ID"]) == 1)
                    {
                        row["FlatId"] = drpFlatID.SelectedValue;
                    }
                    else
                    {
                        FlatId = Convert.ToString(Session["FlatId"]);
                        row["FlatId"] = FlatId;
                    }

                    row["TenantName"] = txttenantName.Text;
                    row["ResidingFrom"] = DateTime.ParseExact(txtresidingfrom.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    row["ResidingTo"] = DateTime.ParseExact(txtresidingto.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    row["DOB"] = DateTime.ParseExact(txttenantDob.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);


                    if (txtrent.Text == "" || txtrent.Text == null)
                    {
                        row["Rent"] = 0;
                    }
                    else
                    {
                        row["Rent"] = float.Parse(txtrent.Text);
                    }


                    //  row["Rent"] = txtrent.Text;
                    row["PAN"] = txtpan.Text;
                    row["AadhaarCard"] = txtaadhar.Text;
                    row["PermanantAddress"] = txtpermanantaddress.Text;
                    row["ContactNo1"] = Convert.ToInt64(txtcontactno1.Text);
                    if (txtcontactno2.Text == null || txtcontactno2.Text == "")
                    {
                        row["ContactNo2"] = Convert.ToInt64(0);
                    }
                    else
                    {
                        row["ContactNo2"] = Convert.ToInt64(txtcontactno2.Text);
                    }

                    if (rbtngendertM.Checked == true)
                    {
                        row["Gender"] = "Male";
                    }
                    else 
                    {
                        row["Gender"] = "Female";
                    }

                    //row["Active"] = "";
                    //  row["CreatedBy"] ="" ;
                    dtTenant.Rows.Add(row);
                }
                i++;
            }
            dgTenant.DataSource = dtTenant;
            dgTenant.DataBind();
            btnTenantsubmit.Text = "Add";
            Session["tblTenant"] = dtTenant;
            drpFamilyinfo.SelectedValue = "Tenent";
            txttenantName.Text = "";
            txtresidingfrom.Text = "";
            txtresidingto.Text = "";
            txtrent.Text = "";
            txtpan.Text = "";
            txtaadhar.Text = "";
            txttenantDob.Text = "";
            txtpermanantaddress.Text = "";
            txtcontactno1.Text = "";
            txtcontactno2.Text = "";

           //drpFlatID.Items.Clear();
            if (drpFamilyinfo.SelectedValue == "Tenent")
            {
                TenantMstr.Attributes["style"] = "display:block;";
                FamilyinfoMstr.Attributes["style"] = "display:none;";
                TenantGrid.Attributes["style"] = "display:block;";
            }
           
            //******show tenant InsertItemPosition button******//
            btnInsertTenant.Attributes["style"] = "display:block;";
            btnInsertTenant.Attributes["style"] = "text-align: center";
            temptenanttable.Attributes["style"] = "display:block;";
           
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('One row Inserted .. ');</script>", false);

        }
        protected void dgTenant_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            //*************************** Delete Tenant Row**********************************//
              dgTenant.Columns[12].Visible = false;
              dgTenant.Columns[13].Visible = false;
            //  dgTenant.Columns[12].Visible = false;
            if (e.CommandName == "Delete")
            {
                int Attachid = e.Item.ItemIndex;
                dtTenant = (DataTable)Session["tblTenant"];
                btnTenantsubmit.Text = "Add";
                if (dtTenant.Rows.Count > 0)
                {
                    dtTenant.Rows[Attachid].Delete();
                    dgTenant.DataSource = dtTenant;
                    dgTenant.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('One row Deleted .. ');</script>", false);
                }
                else
                {
                    dgTenant.DataSource = null;
                    dgTenant.DataBind();
                }
            }
        }

        protected void dgTenant_EditCommand(object source, DataGridCommandEventArgs e)
        {
            dgTenant.Columns[12].Visible = false;
            dgTenant.Columns[13].Visible = false;
            //  dgTenant.Columns[12].Visible = false;
            if (e.CommandName == "Edit")
            {
                int Attachid = e.Item.ItemIndex;
                dtTenant = (DataTable)Session["tblTenant"];
                if (Convert.ToInt32(Session["Role_ID"]) == 1)
                {
                    drpFlatID.SelectedValue = dgTenant.Items[Attachid].Cells[0].Text;
                }
               
                
                txttenantName.Text = dgTenant.Items[Attachid].Cells[1].Text;
                if (dgTenant.Items[Attachid].Cells[2].Text == null)
                {
                    txtresidingfrom.Text = "";
                }
                else
                {
                    txtresidingfrom.Text = StrDate(dgTenant.Items[Attachid].Cells[2].Text);
                }
                if (dgTenant.Items[Attachid].Cells[3].Text == null)
                {
                    txtresidingto.Text = "";
                }
                else
                {
                    txtresidingto.Text = StrDate(dgTenant.Items[Attachid].Cells[3].Text);
                }
                //txtresidingfrom.Text = dgTenant.Items[Attachid].Cells[2].Text;
                //txtresidingto.Text = dgTenant.Items[Attachid].Cells[3].Text;
                txtrent.Text = dgTenant.Items[Attachid].Cells[4].Text;
                txtpan.Text = dgTenant.Items[Attachid].Cells[5].Text;
                txtaadhar.Text = dgTenant.Items[Attachid].Cells[6].Text;
                txtpermanantaddress.Text = dgTenant.Items[Attachid].Cells[7].Text;
                txtcontactno1.Text = dgTenant.Items[Attachid].Cells[8].Text;
                txtcontactno2.Text = dgTenant.Items[Attachid].Cells[9].Text;
                txttenantDob.Text = StrDate(dgTenant.Items[Attachid].Cells[10].Text);

                if (dgTenant.Items[Attachid].Cells[11].Text == "Male")
                {
                    rbtngendertM.Checked = true;

                }
                else 
                {
                    rbtngendertF.Checked = true;
                }

                btnTenantsubmit.Text = "Save";
                if (dtTenant.Rows.Count > 0)
                {
                    dtTenant.Rows[Attachid].Delete();
                    dgTenant.DataSource = dtTenant;
                    dgTenant.DataBind();
                }
                else
                {
                    dgTenant.DataSource = null;
                    dgTenant.DataBind();
                }
            }
        }

        protected void btnInsertTenant_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection(DBHelper.ConnectionString());
            con.Open();
            SqlTransaction objSqlTrasaction = con.BeginTransaction("MyTrasnsaction");


            if (Session["tblTenant"] != null)
            {
                dtTenant = (DataTable)Session["tblTenant"];
                if (dtTenant.Rows.Count > 0)
                {
                    //for null variable
                    for (int i = 0; i < dtTenant.Rows.Count; i++)
                    {

                        dtTenant.Rows[i][12] = true;
                        dtTenant.Rows[i][13] = Convert.ToString(Session["Flatno"]);
                        // dtTenant.Rows[i][12] = "";

                    }
                    using (SqlBulkCopy copy = new SqlBulkCopy(con, SqlBulkCopyOptions.Default, objSqlTrasaction))
                    {
                        copy.ColumnMappings.Add(0, 1);
                        copy.ColumnMappings.Add(1, 2);
                        copy.ColumnMappings.Add(2, 3);
                        copy.ColumnMappings.Add(3, 4);
                        copy.ColumnMappings.Add(4, 5);
                        copy.ColumnMappings.Add(5, 6);
                        copy.ColumnMappings.Add(6, 7);
                        copy.ColumnMappings.Add(7, 8);
                        copy.ColumnMappings.Add(8, 9);
                        copy.ColumnMappings.Add(9, 10);
                        copy.ColumnMappings.Add(10, 11);
                        copy.ColumnMappings.Add(11, 12);
                        copy.ColumnMappings.Add(12, 13);
                        copy.ColumnMappings.Add(13, 14);
                        // copy.ColumnMappings.Add(12, 13);
                        copy.DestinationTableName = "TenantMaster";
                        copy.WriteToServer(dtTenant);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Tenant Info Inserted Successfully .. ');</script>", false);
                        Page.Session.Remove("tblTenant");
                        Session["tblTenant"] = null;
                        temptenanttable.Attributes["style"] = "display:none;";
                        dgTenant.DataSource = null;
                        dgTenant.DataBind();
                    }
                }
            }

            objSqlTrasaction.Commit();
            
        }



        //*************************** End Tenant master Info**********************************// 

        //***************************  Family Member master Info**********************************//
        protected void btnFamilyMemAdd_Click(object sender, EventArgs e)
        {

            dtFamilyMember.Columns.Add("FlatId");
            dtFamilyMember.Columns.Add("Name");
            dtFamilyMember.Columns.Add("ResidingFrom");
            dtFamilyMember.Columns.Add("ContactNo");
            dtFamilyMember.Columns.Add("PAN");
            dtFamilyMember.Columns.Add("AadhaarCard");
            dtFamilyMember.Columns.Add("Relation");
            dtFamilyMember.Columns.Add("DOB");
            dtFamilyMember.Columns.Add("Address");
            dtFamilyMember.Columns.Add("OtherRelation");
            dtFamilyMember.Columns.Add("Gender");
            dtFamilyMember.Columns.Add("Active");
            dtFamilyMember.Columns.Add("CreatedBy");
            // FamilyMember.Columns.Add("CreatedOn");

            dgFamilyMember.Columns[11].Visible = false;
            dgFamilyMember.Columns[12].Visible = false;
            //FamilyMember.Columns[12].Visible = false;
            DataRow row;
            int i = 0;
            while (i <= dgFamilyMember.Items.Count)
            {
                row = dtFamilyMember.NewRow();
                if (i < dgFamilyMember.Items.Count)
                {
                    row["FlatId"] = dgFamilyMember.Items[i].Cells[0].Text;
                    row["Name"] = dgFamilyMember.Items[i].Cells[1].Text;
                    row["ResidingFrom"] = dgFamilyMember.Items[i].Cells[2].Text;
                    row["ContactNo"] = dgFamilyMember.Items[i].Cells[3].Text;
                    row["PAN"] = dgFamilyMember.Items[i].Cells[4].Text;
                    row["AadhaarCard"] = dgFamilyMember.Items[i].Cells[5].Text;
                    row["Relation"] = dgFamilyMember.Items[i].Cells[6].Text;
                    row["DOB"] = dgFamilyMember.Items[i].Cells[7].Text;
                    row["Address"] = dgFamilyMember.Items[i].Cells[8].Text;
                    row["OtherRelation"] = dgFamilyMember.Items[i].Cells[9].Text;
                    row["Gender"] = dgFamilyMember.Items[i].Cells[10].Text;
                    row["Active"] = "";
                    row["CreatedBy"] = "";
                    //   row["CreatedOn"] = "";

                    dtFamilyMember.Rows.Add(row);
                }
                else
                {
                  
                    if (Convert.ToInt32(Session["Role_ID"]) == 1)
                    {

                        row["FlatId"] = drpFlatID.SelectedValue;
                      
                    }
                    else
                    {
                        FlatId = Convert.ToString(Session["FlatID"]);
                        row["FlatId"] = FlatId;
                        
                    }


                    row["Name"] = txtFlatMemberName.Text;
                   
                    row["ResidingFrom"] = DateTime.ParseExact(txtFlatMemberResfrom.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

                    if (txtFlatMemberConNo.Text == null || txtFlatMemberConNo.Text == "")
                    {
                        row["ContactNo"] = Convert.ToInt64(0);
                    }
                    else
                    {
                        row["ContactNo"] = Convert.ToInt64(txtFlatMemberConNo.Text);
                    }

                    //  row["Rent"] = txtrent.Text;
                    row["PAN"] = txtFlatMemberPan.Text;
                    row["AadhaarCard"] = txtFlatMemberAdhaar.Text;

                    if (drpFlatMemberRelation.SelectedValue == "Other")
                    {
                        row["Relation"] = drpFlatMemberRelation.SelectedValue;
                        row["OtherRelation"] = txtotherrelation.Text;

                    }
                    else
                    {
                        row["Relation"] = drpFlatMemberRelation.SelectedValue;
                    }

                    row["DOB"] = DateTime.ParseExact(txtFlatMemberDob.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    row["Address"] = txtFlatMemberAddress.Text;

                    if (rbtnGenderfm.Checked == true)
                    {
                        row["Gender"] = "Male";
                    }
                    else {
                        row["Gender"] = "Female";
                    }

                    row["Active"] = "";
                    row["CreatedBy"] = "";
                    dtFamilyMember.Rows.Add(row);
                }
                i++;
            }
            dgFamilyMember.DataSource = dtFamilyMember;
            dgFamilyMember.DataBind();
            btnFamilyMemAdd.Text = "Add";
            Session["tblFamilyMember"] = dtFamilyMember;
            drpFamilyinfo.SelectedValue = "FamilyInfo";
            txtFlatMemberName.Text = "";
            txtFlatMemberResfrom.Text = "";
            txtFlatMemberConNo.Text = "";
            txtFlatMemberPan.Text = "";
            txtFlatMemberAdhaar.Text = "";
            drpFlatMemberRelation.SelectedValue = "None";
            txtotherrelation.Text = "";
            txtFlatMemberDob.Text = "";
            //drpFlatID.Items.Clear();
            txtFlatMemberAddress.Text = "";
            if (drpFamilyinfo.SelectedValue == "FamilyInfo")
            {
                TenantMstr.Attributes["style"] = "display:none;";
                FamilyinfoMstr.Attributes["style"] = "display:block;";
                FamilyGrid.Attributes["style"] = "display:block;";
            }
            btnInsertFamilymember.Attributes["style"] = "display:block;";
            btnInsertFamilymember.Attributes["style"] = "text-align: center";
            tempFamilytable.Attributes["style"] = "display:block;";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('One row added .... ');</script>", false);
        }

        protected void dgFamilyMember_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            //*************************** Delete Tenant Row**********************************//
            dgFamilyMember.Columns[11].Visible = false;
            dgFamilyMember.Columns[12].Visible = false;
            //  dgTenant.Columns[12].Visible = false;
            if (e.CommandName == "Delete")
            {
                int Attachid = e.Item.ItemIndex;
                dtFamilyMember = (DataTable)Session["tblFamilyMember"];
                btnFamilyMemAdd.Text = "Add";
                if (dtFamilyMember.Rows.Count > 0)
                {
                    dtFamilyMember.Rows[Attachid].Delete();
                    dgFamilyMember.DataSource = dtFamilyMember;
                    dgFamilyMember.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Row Deleted successfully...');</script>", false);

                }
                else
                {
                    dgFamilyMember.DataSource = null;
                    dgFamilyMember.DataBind();
                }
            }
        }

        protected void dgFamilyMember_EditCommand(object source, DataGridCommandEventArgs e)
        {
            dgFamilyMember.Columns[11].Visible = false;
            dgFamilyMember.Columns[12].Visible = false;
            //  dgTenant.Columns[12].Visible = false;
            if (e.CommandName == "Edit")
            {
                int Attachid = e.Item.ItemIndex;
                dtFamilyMember = (DataTable)Session["tblFamilyMember"];
                if (Convert.ToInt32(Session["Role_ID"]) == 1)
                {
                    drpFlatID.SelectedValue = dgFamilyMember.Items[Attachid].Cells[0].Text;
                }

                txtFlatMemberName.Text = dgFamilyMember.Items[Attachid].Cells[1].Text;
                if (dgFamilyMember.Items[Attachid].Cells[2].Text == null)
                {
                    txtFlatMemberResfrom.Text = "";
                }
                else
                {
                    txtFlatMemberResfrom.Text = StrDate(dgFamilyMember.Items[Attachid].Cells[2].Text);
                }

                txtFlatMemberConNo.Text = dgFamilyMember.Items[Attachid].Cells[3].Text;

                txtFlatMemberPan.Text = dgFamilyMember.Items[Attachid].Cells[4].Text;
                txtFlatMemberAdhaar.Text = dgFamilyMember.Items[Attachid].Cells[5].Text;

                if (dgFamilyMember.Items[Attachid].Cells[6].Text == "Other")
                {
                    txtotherrelation.Attributes["style"] = "display:block;";
                    drpFlatMemberRelation.SelectedValue = dgFamilyMember.Items[Attachid].Cells[6].Text;
                    txtotherrelation.Text = dgFamilyMember.Items[Attachid].Cells[9].Text;
                }
                else
                {
                    txtotherrelation.Attributes["style"] = "display:none;";
                    drpFlatMemberRelation.SelectedValue = dgFamilyMember.Items[Attachid].Cells[6].Text;
                }

                if (dgFamilyMember.Items[Attachid].Cells[7].Text == null)
                {
                    txtFlatMemberDob.Text = "";
                }
                else
                {
                    txtFlatMemberDob.Text = StrDate(dgFamilyMember.Items[Attachid].Cells[7].Text);
                }

                txtFlatMemberAddress.Text = dgFamilyMember.Items[Attachid].Cells[8].Text;

                if (dgFamilyMember.Items[Attachid].Cells[10].Text == "Male")
                {
                    rbtnGenderfm.Checked = true;
                }

                else
                {
                    rbtnGenderff.Checked = true;
                }



                btnFamilyMemAdd.Text = "Save";
                if (dtFamilyMember.Rows.Count > 0)
                {
                    dtFamilyMember.Rows[Attachid].Delete();
                    dgFamilyMember.DataSource = dtFamilyMember;
                    dgFamilyMember.DataBind();
                }
                else
                {
                    dgFamilyMember.DataSource = null;
                    dgFamilyMember.DataBind();
                }
            }
        }



        protected void btnInsertFamilymember_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection(DBHelper.ConnectionString());
            con.Open();
            SqlTransaction objSqlTrasaction = con.BeginTransaction("MyTrasnsaction");


            if (Session["tblFamilyMember"] != null)
            {
                dtFamilyMember = (DataTable)Session["tblFamilyMember"];
                if (dtFamilyMember.Rows.Count > 0)
                {
                    //for null variable
                    for (int i = 0; i < dtFamilyMember.Rows.Count; i++)
                    {

                        dtFamilyMember.Rows[i][11] = true;
                        dtFamilyMember.Rows[i][12] = Convert.ToString(Session["Flatno"]);
                        // dtTenant.Rows[i][12] = "";
                    }
                    using (SqlBulkCopy copy = new SqlBulkCopy(con, SqlBulkCopyOptions.Default, objSqlTrasaction))
                    {
                        copy.ColumnMappings.Add(0, 1);
                        copy.ColumnMappings.Add(1, 2);
                        copy.ColumnMappings.Add(2, 3);
                        copy.ColumnMappings.Add(3, 4);
                        copy.ColumnMappings.Add(4, 5);
                        copy.ColumnMappings.Add(5, 6);
                        copy.ColumnMappings.Add(6, 7);
                        copy.ColumnMappings.Add(7, 8);
                        copy.ColumnMappings.Add(8, 9);
                        copy.ColumnMappings.Add(9, 10);
                        copy.ColumnMappings.Add(10, 11);
                        copy.ColumnMappings.Add(11, 12);
                        copy.ColumnMappings.Add(12, 13);
                        // copy.ColumnMappings.Add(12, 13);
                        copy.DestinationTableName = "OwnerFamilyMaster";
                        copy.WriteToServer(dtFamilyMember);
                        Page.Session.Remove("tblFamilyMember");
                        Session["tblFamilyMember"] = null;
                        tempFamilytable.Attributes["style"] = "display:none;";
                        dgFamilyMember.DataSource = null;
                        dgFamilyMember.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Family Member Record Inserted Successfully.. ');</script>", false);
                    }
                }
            }

            objSqlTrasaction.Commit();
           
        }

        //***************************End  Family Member master Info**********************************//

        //*************************** Date time Coverion *************************************//
        private string StrDate(string Date)
        {
            if (Date != "")
            {
                string[] Date1 = Date.Split('/');
                // Date = Date1[2] + "/" + Date1[1] + "/" + Date1[0];
                string[] Date2 = Date1[2].Split(' ');

                Date = Date1[0] + "/" + Date1[1] + "/" + Date2[0];
                return (Date);
            }
            else
            {
                return null;
            }
        }
        //***************************End Date time*******************************************//
    }
}