using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using SocietyDAL;
using SocietyDAL;
using SocietyEntity;
namespace EsquareMasterTemplate.Masters
{
    public partial class VehicleMaster : System.Web.UI.Page
    {
        int flatid, vehicleid, flatname, ParentId;
        string output;
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsVehicleEntity objvehinfo = new clsVehicleEntity();
        clsVehicleMasterDal objvehdal = new clsVehicleMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        protected void Page_Load(object sender, EventArgs e)
        {

            vehicleid = Convert.ToInt32(Request.QueryString["VehicleId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
           
            if (!IsPostBack)
            {
                Bindflatinfo("Insert");
                ValidateUserPermissions();
                UpdateVehiclemaster();
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
        protected void UpdateVehiclemaster()
        {
            if (vehicleid != 0)
            {
                DataSet ds = new DataSet();

                objvehinfo.vehicleid = vehicleid;
                objvehinfo.flag = "getallrecordbyvehid";
                ds = (DataSet)objvehdal.GetVehicleInfobyVehicleId(objvehinfo);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Bindflatinfo("Update");
                    drpFlatNo.SelectedValue = ds.Tables[0].Rows[0]["FlatId"].ToString();
                    drpNoOfvehicle.SelectedValue = ds.Tables[0].Rows[0]["NoOfVehichle"].ToString();
                    //*************************** Update info if Vehicle NO=1 *****************************//
                    if (drpNoOfvehicle.SelectedValue == "one")
                    {
                        showvehicleone();
                        drpVehtype1.SelectedValue = ds.Tables[0].Rows[0]["VehicleType1"].ToString();
                        txtvehno1.Text = ds.Tables[0].Rows[0]["VehicleNumber1"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven1"]) == 1)
                        {
                            chkisstickerveh1.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh1.Checked = false;
                        }

                    }
                    //*************************** Update info if Vehicle NO=Two *****************************//
                    if (drpNoOfvehicle.SelectedValue == "Two")
                    {

                        showvehicleTwo();
                        drpVehtype1.SelectedValue = ds.Tables[0].Rows[0]["VehicleType1"].ToString();
                        txtvehno1.Text = ds.Tables[0].Rows[0]["VehicleNumber1"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven1"]) == 1)
                        {
                            chkisstickerveh1.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh1.Checked = false;
                        }


                        drpVehtype2.SelectedValue = ds.Tables[0].Rows[0]["VehicleType2"].ToString();
                        txtvehno2.Text = ds.Tables[0].Rows[0]["VehicleNumber2"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven2"]) == 1)
                        {
                            chkisstickerveh2.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh2.Checked = false;
                        }
                    }
                    //*************************** Update info if Vehicle NO=Three *****************************//
                    if (drpNoOfvehicle.SelectedValue == "Three")
                    {
                        showvehicleThree();
                        drpVehtype1.SelectedValue = ds.Tables[0].Rows[0]["VehicleType1"].ToString();
                        txtvehno1.Text = ds.Tables[0].Rows[0]["VehicleNumber1"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven1"]) == 1)
                        {
                            chkisstickerveh1.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh1.Checked = false;
                        }


                        drpVehtype2.SelectedValue = ds.Tables[0].Rows[0]["VehicleType2"].ToString();
                        txtvehno2.Text = ds.Tables[0].Rows[0]["VehicleNumber2"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven2"]) == 1)
                        {
                            chkisstickerveh2.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh2.Checked = false;
                        }

                        drpVehtype3.SelectedValue = ds.Tables[0].Rows[0]["VehicleType3"].ToString();
                        txtvehno3.Text = ds.Tables[0].Rows[0]["VehicleNumber3"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven3"]) == 1)
                        {
                            chkisstickerveh3.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh3.Checked = false;
                        }
                    }
                    //*************************** Update info if Vehicle NO=Four *****************************//
                    if (drpNoOfvehicle.SelectedValue == "Four")
                    {
                        showvehicleFour();
                        drpVehtype1.SelectedValue = ds.Tables[0].Rows[0]["VehicleType1"].ToString();
                        txtvehno1.Text = ds.Tables[0].Rows[0]["VehicleNumber1"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven1"]) == 1)
                        {
                            chkisstickerveh1.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh1.Checked = false;
                        }


                        drpVehtype2.SelectedValue = ds.Tables[0].Rows[0]["VehicleType2"].ToString();
                        txtvehno2.Text = ds.Tables[0].Rows[0]["VehicleNumber2"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven2"]) == 1)
                        {
                            chkisstickerveh2.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh2.Checked = false;
                        }

                        drpVehtype3.SelectedValue = ds.Tables[0].Rows[0]["VehicleType3"].ToString();
                        txtvehno3.Text = ds.Tables[0].Rows[0]["VehicleNumber3"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven3"]) == 1)
                        {
                            chkisstickerveh3.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh3.Checked = false;
                        }

                        drpVehtype4.SelectedValue = ds.Tables[0].Rows[0]["VehicleType4"].ToString();
                        txtvehno4.Text = ds.Tables[0].Rows[0]["VehicleNumber4"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven4"]) == 1)
                        {
                            chkisstickerveh4.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh4.Checked = false;
                        }
                    }
                    //*************************** Update info if Vehicle NO=FourPlus *****************************//
                    if (drpNoOfvehicle.SelectedValue == "FourPlus")
                    {
                        showvehicleFourplus();
                        drpVehtype1.SelectedValue = ds.Tables[0].Rows[0]["VehicleType1"].ToString();
                        txtvehno1.Text = ds.Tables[0].Rows[0]["VehicleNumber1"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven1"]) == 1)
                        {
                            chkisstickerveh1.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh1.Checked = false;
                        }


                        drpVehtype2.SelectedValue = ds.Tables[0].Rows[0]["VehicleType2"].ToString();
                        txtvehno2.Text = ds.Tables[0].Rows[0]["VehicleNumber2"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven2"]) == 1)
                        {
                            chkisstickerveh2.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh2.Checked = false;
                        }

                        drpVehtype3.SelectedValue = ds.Tables[0].Rows[0]["VehicleType3"].ToString();
                        txtvehno3.Text = ds.Tables[0].Rows[0]["VehicleNumber3"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven3"]) == 1)
                        {
                            chkisstickerveh3.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh3.Checked = false;
                        }

                        drpVehtype4.SelectedValue = ds.Tables[0].Rows[0]["VehicleType4"].ToString();
                        txtvehno4.Text = ds.Tables[0].Rows[0]["VehicleNumber4"].ToString();
                        if (Convert.ToInt32(ds.Tables[0].Rows[0]["IsStickerGiven4"]) == 1)
                        {
                            chkisstickerveh4.Checked = true;
                        }
                        else
                        {
                            chkisstickerveh4.Checked = false;
                        }

                        txtExtravehinfo.Text = ds.Tables[0].Rows[0]["ExtraInfo"].ToString();
                    }

                    //txtcontactno.Text = ds.Tables[0].Rows[0]["ContactNumber"].ToString();
                    //txtOccupatn.Text = ds.Tables[0].Rows[0]["Occupation"].ToString();


                    Session["_vehicleid"] = vehicleid.ToString();
                    btnSubmit.Text = "Update";
                }

            }
            else
            {
                btnSubmit.Text = "Submit";
            }
        }


        public void Bindflatinfo(string flag)
        {
                   string SocietyId = Convert.ToString(Session["ID"]) as string;
           

                objflatinfo.SocietyId = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            DataSet ds = new DataSet();
            ds = (DataSet)objflatdal.Getflatinfobyid(Convert.ToString(0), Convert.ToString(Session["LoginId"]), flag, SocietyId);
            drpFlatNo.DataSource = ds;
            drpFlatNo.DataTextField = "FlatNumber";
            drpFlatNo.DataValueField = "FlatId";
            drpFlatNo.DataBind();

            ListItem objLI = new ListItem("--Select Flat Number --", "0");
            drpFlatNo.Items.Insert(0, objLI);
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (vehicleid == 0)
            {
                objvehinfo.vehicleid = 0;
            }
            else
            {
                Session["_vehicleid"] = vehicleid.ToString();
                objvehinfo.vehicleid = Convert.ToInt32(Session["_vehicleid"]);
            }

            objvehinfo.FlatId = Convert.ToInt32(drpFlatNo.SelectedValue);
            objvehinfo.noOfvehicle = Convert.ToString(drpNoOfvehicle.SelectedValue);


            if (objvehinfo.noOfvehicle == "one")
            {
                showvehicleone();
                if (drpVehtype1.SelectedValue == Convert.ToString(0))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please Select Vehicle Type');</script>", false);
                }
                fisrtvehicle();
                ClearSecondvehicle();
                Clearthirdvehicle();
                ClearFourthvehicle();
                ClearFourplusthvehicle();
            }


            if (objvehinfo.noOfvehicle == "Two")
            {
                showvehicleTwo();
                if (drpVehtype1.SelectedValue == Convert.ToString(0) || drpVehtype2.SelectedValue == Convert.ToString(0))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please Select Vehicle Type');</script>", false);
                }
                fisrtvehicle();
                Secondvehicle();
                Clearthirdvehicle();
                ClearFourthvehicle();
                ClearFourplusthvehicle();
            }


            if (objvehinfo.noOfvehicle == "Three")
            {
                showvehicleThree();
                if (drpVehtype1.SelectedValue == Convert.ToString(0) || drpVehtype2.SelectedValue == Convert.ToString(0) || drpVehtype3.SelectedValue == Convert.ToString(0))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please Select Vehicle Type');</script>", false);
                }
                fisrtvehicle();
                Secondvehicle();
                Thirdvehicle();

                ClearFourthvehicle();
                ClearFourplusthvehicle();
            }


            if (objvehinfo.noOfvehicle == "Four")
            {
                showvehicleFour();
                if (drpVehtype1.SelectedValue == Convert.ToString(0) || drpVehtype2.SelectedValue == Convert.ToString(0) || drpVehtype3.SelectedValue == Convert.ToString(0) || drpVehtype4.SelectedValue == Convert.ToString(0))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please Select Vehicle Type');</script>", false);
                }

                fisrtvehicle();
                Secondvehicle();
                Thirdvehicle();
                Fourthvehicle();
                ClearFourplusthvehicle();
            }

            if (objvehinfo.noOfvehicle == "FourPlus")
            {
                showvehicleFourplus();
                if (drpVehtype1.SelectedValue == Convert.ToString(0) || drpVehtype2.SelectedValue == Convert.ToString(0) || drpVehtype3.SelectedValue == Convert.ToString(0) || drpVehtype4.SelectedValue == Convert.ToString(0))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please Select Vehicle Type');</script>", false);
                }
                if (txtvehno4.Text == "")
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('Please enterExtra Vehicle Info');</script>", false);
                }
                fisrtvehicle();
                Secondvehicle();
                Thirdvehicle();
                Fourthvehicle();
                objvehinfo.Extravehinfo = txtExtravehinfo.Text;
            }

            objvehinfo.createdBy = Convert.ToString(Session["LoginId"]);

            string result = objvehdal.InsertVehicleMstr(objvehinfo);
            clearall();
            Session["_vehicleid"] = null;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + result + "');</script>", false);

        }
        /*************************** Clear Vehicleinfo Function*****************************/
        public void clearall()
        {
            drpFlatNo.SelectedValue = Convert.ToString(0);
            drpNoOfvehicle.SelectedValue = Convert.ToString(0);
            vehicle1.Attributes["style"] = "display:none;";
            vehicle2.Attributes["style"] = "display:none;";
            vehicle3.Attributes["style"] = "display:none;";
            vehicle4.Attributes["style"] = "display:none;";
            vehicle5.Attributes["style"] = "display:none;";
        }

        public void fisrtvehicle()
        {
            objvehinfo.VehicleTypeVeh1 = drpVehtype1.SelectedValue;
            objvehinfo.VehicleNumberVeh1 = txtvehno1.Text.Trim();
            if (chkisstickerveh1.Checked == true)
            {
                objvehinfo.ISstickerGivenVeh1 = 1;
            }
            else
            {
                objvehinfo.ISstickerGivenVeh1 = 0;
            }

        }

        public void Secondvehicle()
        {
            objvehinfo.VehicleTypeVeh2 = drpVehtype2.SelectedValue;
            objvehinfo.VehicleNumberVeh2 = txtvehno2.Text.Trim();
            if (chkisstickerveh2.Checked == true)
            {
                objvehinfo.ISstickerGivenVeh2 = 1;
            }
            else
            {
                objvehinfo.ISstickerGivenVeh2 = 0;
            }
        }

        public void Thirdvehicle()
        {
            objvehinfo.VehicleTypeVeh3 = drpVehtype3.SelectedValue;
            objvehinfo.VehicleNumberVeh3 = txtvehno3.Text.Trim();
            if (chkisstickerveh3.Checked == true)
            {
                objvehinfo.ISstickerGivenVeh3 = 1;
            }
            else
            {
                objvehinfo.ISstickerGivenVeh3 = 0;
            }
        }

        public void Fourthvehicle()
        {
            objvehinfo.VehicleTypeVeh4 = drpVehtype4.SelectedValue;
            objvehinfo.VehicleNumberVeh4 = txtvehno4.Text.Trim();
            if (chkisstickerveh4.Checked == true)
            {
                objvehinfo.ISstickerGivenVeh4 = 1;
            }
            else
            {
                objvehinfo.ISstickerGivenVeh4 = 0;
            }

        }



        public void ClearSecondvehicle()
        {
            objvehinfo.VehicleTypeVeh2 = "";
            objvehinfo.VehicleNumberVeh2 = "";
            objvehinfo.ISstickerGivenVeh2 = 0;

        }

        public void Clearthirdvehicle()
        {
            objvehinfo.VehicleTypeVeh3 = "";
            objvehinfo.VehicleNumberVeh3 = "";
            objvehinfo.ISstickerGivenVeh3 = 0;
        }

        public void ClearFourthvehicle()
        {
            objvehinfo.VehicleTypeVeh4 = "";
            objvehinfo.VehicleNumberVeh4 = "";
            objvehinfo.ISstickerGivenVeh4 = 0;
        }

        public void ClearFourplusthvehicle()
        {
            objvehinfo.Extravehinfo = "";
        }
        /*************************** HideShow Vehicle Section Function*****************************/
        public void showvehicleone()
        {
            vehicle1.Attributes["style"] = "display:block;";
            vehicle2.Attributes["style"] = "display:none;";
            vehicle3.Attributes["style"] = "display:none;";
            vehicle4.Attributes["style"] = "display:none;";
            vehicle5.Attributes["style"] = "display:none;";
        }
        public void showvehicleTwo()
        {
            vehicle1.Attributes["style"] = "display:block;";
            vehicle2.Attributes["style"] = "display:block;";
            vehicle3.Attributes["style"] = "display:none;";
            vehicle4.Attributes["style"] = "display:none;";
            vehicle5.Attributes["style"] = "display:none;";
        }

        public void showvehicleThree()
        {
            vehicle1.Attributes["style"] = "display:block;";
            vehicle2.Attributes["style"] = "display:block;";
            vehicle3.Attributes["style"] = "display:block;";
            vehicle4.Attributes["style"] = "display:none;";
            vehicle5.Attributes["style"] = "display:none;";
        }

        public void showvehicleFour()
        {
            vehicle1.Attributes["style"] = "display:block;";
            vehicle2.Attributes["style"] = "display:block;";
            vehicle3.Attributes["style"] = "display:block;";
            vehicle4.Attributes["style"] = "display:block;";
            vehicle5.Attributes["style"] = "display:none;";
        }

        public void showvehicleFourplus()
        {
            vehicle1.Attributes["style"] = "display:block;";
            vehicle2.Attributes["style"] = "display:block;";
            vehicle3.Attributes["style"] = "display:block;";
            vehicle4.Attributes["style"] = "display:block;";
            vehicle5.Attributes["style"] = "display:block;";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
           // Session.Clear();
            Session["_vehicleid"] = null;
            Response.Redirect("VehicleMasterView.aspx");
        }
       
    }
}