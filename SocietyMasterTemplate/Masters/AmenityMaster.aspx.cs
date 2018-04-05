using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SocietyDAL;

using System.Data;
using SocietyEntity;

namespace EsquareMasterTemplate.Masters
{
    public partial class AmenityMaster : System.Web.UI.Page
    {
        int AminityId, ParentId;
        string output, GymDesc, ParkingDesc, LiftDesc, CCTVDesc, IntercomDesc, SecurityDesc, GeneratorDesc, CommunityDesc, SwimmingDesc, ChairsDesc, TablesDesc, MusicSysDesc;


        clsBuildingMasterDal objbuildinginfoDal = new clsBuildingMasterDal();
        clsBuildingEntity objbuildinginfo = new clsBuildingEntity();
        clsAmenityDal objAminityDal = new clsAmenityDal();
        clsAmenityEntity objAminityEntity = new clsAmenityEntity();
        clsCommonDAL objCommonDAL = new clsCommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            AminityId = Convert.ToInt32(Request.QueryString["AmenityId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                ValidateUserPermissions();
                BindBuildingid();

                drpBuildingid.Items.Insert(0, new ListItem("--Select Building Name--", ""));
                drpBuildingid.SelectedIndex = 0;

                UpdateAminitymaster();
            }


        }
        private void ValidateUserPermissions()
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

        public void BindBuildingid()
        {
            DataSet ds = new DataSet();
            objbuildinginfo.BuildingId = 0;
            string SocietyId = Convert.ToString(Session["ID"]) as string;
            objbuildinginfo.SocietyIdvar = SocietyId == "" ? "" : Convert.ToString(Session["ID"]);
            ds = (DataSet)objbuildinginfoDal.GetAllBuildingInfo(objbuildinginfo, Convert.ToString(Session["LoginId"]));
            drpBuildingid.DataSource = ds;
            drpBuildingid.DataTextField = "Name";
            drpBuildingid.DataValueField = "BuildingId";
            drpBuildingid.DataBind();

            //ListItem objLI = new ListItem("", "0");
            //drpBuildingid.Items.Insert(0, objLI);
        }



        protected void UpdateAminitymaster()
        {
            if (AminityId != 0)
            {
                DataSet ds = new DataSet();

                objAminityEntity.AminityId = AminityId;

                ds = (DataSet)objAminityDal.GetAminityMstrInfo(objAminityEntity);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpBuildingid.SelectedValue = ds.Tables[0].Rows[0]["BuildingId"].ToString();

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["InterCom"]) == true)
                    {

                        rbtnInter1.Checked = true;
                        rbtnInter2.Checked = false;


                        txtIntercominfo.Attributes["style"] = "display:block;";
                        txtIntercominfo.Text = ds.Tables[0].Rows[0]["IntercomDesc"].ToString();
                    }
                    else
                    {
                        rbtnInter1.Checked = false;
                        rbtnInter2.Checked = true;
                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Parking"]) == true)
                    {

                        rbtnParking1.Checked = true;
                        rbtnParking2.Checked = false;

                        txtParkinginfo.Attributes["style"] = "display:block;";
                        txtParkinginfo.Text = ds.Tables[0].Rows[0]["ParkingDesc"].ToString();
                    }

                    else
                    {
                        rbtnParking1.Checked = false;
                        rbtnParking2.Checked = true;
                    }
                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["GeneratorBkp"]) == true)
                    {
                        rbtnGenset1.Checked = true;
                        rbtnGenset2.Checked = false;

                        txtGensetinfo.Attributes["style"] = "display:block;";
                        txtGensetinfo.Text = ds.Tables[0].Rows[0]["GeneratorDesc"].ToString();
                    }

                    else
                    {
                        rbtnGenset1.Checked = false;
                        rbtnGenset2.Checked = true;

                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Lift"]) == true)
                    {

                        rbtnLift1.Checked = true;
                        rbtnLift2.Checked = false;

                        txtLiftinfo.Attributes["style"] = "display:block;";
                        txtLiftinfo.Text = ds.Tables[0].Rows[0]["LiftDesc"].ToString();
                    }

                    else
                    {
                        rbtnLift1.Checked = false;
                        rbtnLift2.Checked = true;

                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["CCTV"]) == true)
                    {
                        rbtnCCTV1.Checked = true;
                        rbtnCCTV2.Checked = false;


                        txtCCTV.Attributes["style"] = "display:block;";
                        txtCCTV.Text = ds.Tables[0].Rows[0]["CCTVDesc"].ToString();
                    }
                    else
                    {
                        rbtnCCTV1.Checked = false;
                        rbtnCCTV2.Checked = true;
                    }


                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Security"]) == true)
                    {
                        rbtnSecurityinfo1.Checked = true;
                        rbtnSecurityinfo2.Checked = false;


                        txtSecurity.Attributes["style"] = "display:block;";
                        txtSecurity.Text = ds.Tables[0].Rows[0]["SecurityDesc"].ToString();
                    }
                    else
                    {
                        rbtnSecurityinfo1.Checked = false;
                        rbtnSecurityinfo2.Checked = true;
                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["MusicSystem"]) == true)
                    {
                        rbtnMusicsystem1.Checked = true;
                        rbtnMusicsystem2.Checked = false;

                        txtMusicsystem.Attributes["style"] = "display:block;";
                        txtMusicsystem.Text = ds.Tables[0].Rows[0]["MusicSysDesc"].ToString();
                    }
                    else
                    {
                        rbtnMusicsystem1.Checked = false;
                        rbtnMusicsystem2.Checked = true;

                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Chairs"]) == true)
                    {

                        rbtnChairs1.Checked = true;
                        rbtnChairs2.Checked = false;


                        txtChairs.Attributes["style"] = "display:block;";
                        txtChairs.Text = ds.Tables[0].Rows[0]["ChairsDesc"].ToString();
                    }
                    else
                    {
                        rbtnChairs1.Checked = false;
                        rbtnChairs2.Checked = true;
                    }



                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Tables"]) == true)
                    {

                        rbtnTable1.Checked = true;
                        rbtnTable2.Checked = false;

                        txtTable.Attributes["style"] = "display:block;";
                        txtTable.Text = ds.Tables[0].Rows[0]["TablesDesc"].ToString();
                    }

                    else
                    {
                        rbtnTable1.Checked = false;
                        rbtnTable2.Checked = true;
                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["SwimmingPool"]) == true)
                    {

                        rbtnSwimming1.Checked = true;
                        rbtnSwimming2.Checked = false;

                        txtSwimmingpool.Attributes["style"] = "display:block;";
                        txtSwimmingpool.Text = ds.Tables[0].Rows[0]["SwimmingDesc"].ToString();
                    }
                    else
                    {
                        rbtnSwimming1.Checked = false;
                        rbtnSwimming2.Checked = true;
                    }


                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["Gymnasium"]) == true)
                    {


                        rbtnGym1.Checked = true;
                        rbtnGym2.Checked = false;


                        txtGym.Attributes["style"] = "display:block;";
                        txtGym.Text = ds.Tables[0].Rows[0]["GymDesc"].ToString();
                    }
                    else
                    {
                        rbtnGym1.Checked = false;
                        rbtnGym2.Checked = true;
                    }

                    if (Convert.ToBoolean(ds.Tables[0].Rows[0]["CommunityHall"]) == true)
                    {
                        rbtnFunctionhall1.Checked = true;
                        rbtnFunctionhall2.Checked = false;

                        txtFunctionhall.Attributes["style"] = "display:block;";
                        txtFunctionhall.Text = ds.Tables[0].Rows[0]["CommunityDesc"].ToString();
                    }
                    else
                    {
                        rbtnFunctionhall1.Checked = false;
                        rbtnFunctionhall2.Checked = true;

                    }


                    Session["_AminityId"] = AminityId.ToString();
                    btnSubmit.Text = "Update";

                }
            }
            else
            {
                btnSubmit.Text = "Save";

            }
        }





        private void clearall()
        {
          // drpBuildingid.SelectedValue="";
            rbtnInter1.Checked = false;
            rbtnInter2.Checked = false;
            rbtnParking1.Checked = false;
            rbtnParking2.Checked = false;
            rbtnGenset1.Checked = false;
            rbtnGenset2.Checked = false;
            rbtnLift1.Checked = false;
            rbtnLift2.Checked = false;
            rbtnCCTV1.Checked = false;
            rbtnCCTV2.Checked = false;
            rbtnSecurityinfo1.Checked = false;
            rbtnSecurityinfo2.Checked = false;
            rbtnMusicsystem1.Checked = false;
            rbtnMusicsystem2.Checked = false;
            rbtnChairs1.Checked = false;
            rbtnChairs2.Checked = false;
            rbtnTable1.Checked = false;
            rbtnTable2.Checked = false;
            rbtnSwimming1.Checked = false;
            rbtnSwimming2.Checked = false;
            rbtnGym1.Checked = false;
            rbtnGym2.Checked = false;
            rbtnFunctionhall1.Checked = false;
            rbtnFunctionhall2.Checked = false;
            txtGym.Text = "";
            txtParkinginfo.Text = "";
            txtLiftinfo.Text = "";
            txtCCTV.Text = "";
            txtIntercominfo.Text = "";
            txtSecurity.Text = "";
            txtGensetinfo.Text = "";
            txtFunctionhall.Text = "";
            txtSwimmingpool.Text = "";
            txtChairs.Text = "";
            txtTable.Text = "";
            txtMusicsystem.Text = "";
            drpBuildingid.SelectedValue = "";
            
        }

       

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            
                if (AminityId == 0)
                {
                    objAminityEntity.AminityId = 0;
                }
                else
                {
                    Session["_AminityId"] = AminityId.ToString();
                    objAminityEntity.AminityId = Convert.ToInt32(Session["_AminityId"]);
                }
                objAminityEntity.BuildingId = Convert.ToInt32(drpBuildingid.SelectedValue);

                if (rbtnGym1.Checked == true)
                {

                    objAminityEntity.Gymnasium = 1;
                    objAminityEntity.GymDesc = txtGym.Text;
                }
                else
                {
                    objAminityEntity.Gymnasium = 0;
                    txtGym.Text = "";
                }

                if (rbtnParking1.Checked == true)
                {
                    objAminityEntity.Parking = 1;
                    objAminityEntity.ParkingDesc = txtParkinginfo.Text;
                }
                else
                {
                    objAminityEntity.Parking = 0;
                    txtParkinginfo.Text = "";
                }

                if (rbtnLift1.Checked == true)
                {
                    objAminityEntity.Lift = 1;
                    objAminityEntity.LiftDesc = txtLiftinfo.Text;
                }
                else
                {
                    objAminityEntity.Lift = 0;
                    txtLiftinfo.Text = "";
                }

                if (rbtnCCTV1.Checked == true)
                {
                    objAminityEntity.CCTV = 1;
                    objAminityEntity.CCTVDesc = txtCCTV.Text;

                }
                else
                {
                    objAminityEntity.CCTV = 0;
                    txtCCTV.Text = "";

                }


                if (rbtnInter1.Checked == true)
                {
                    objAminityEntity.InterCom = 1;
                    objAminityEntity.IntercomDesc = txtIntercominfo.Text;
                }
                else
                {
                    objAminityEntity.InterCom = 0;
                    txtIntercominfo.Text = "";

                }

                if (rbtnSecurityinfo1.Checked == true)
                {
                    objAminityEntity.Security = 1;
                    objAminityEntity.SecurityDesc = txtSecurity.Text;
                }
                else
                {
                    objAminityEntity.Security = 0;
                    txtSecurity.Text = "";
                }
                if (rbtnGenset1.Checked == true)
                {
                    objAminityEntity.GeneratorBkp = 1;
                    objAminityEntity.GeneratorDesc = txtGensetinfo.Text;
                }
                else
                {
                    objAminityEntity.GeneratorBkp = 0;
                    txtGensetinfo.Text = "";
                }
                if (rbtnFunctionhall1.Checked == true)
                {
                    objAminityEntity.CommunityHall = 1;
                    objAminityEntity.CommunityDesc = txtFunctionhall.Text;
                }
                else
                {
                    objAminityEntity.CommunityHall = 0;
                    txtFunctionhall.Text = "";
                }

                if (rbtnSwimming1.Checked == true)
                {
                    objAminityEntity.SwimmingPool = 1;
                    objAminityEntity.SwimmingDesc = txtSwimmingpool.Text;

                }
                else
                {
                    objAminityEntity.SwimmingPool = 0;
                    txtSwimmingpool.Text = "";

                }

                if (rbtnChairs1.Checked == true)
                {
                    objAminityEntity.Chairs = 1;
                    objAminityEntity.ChairsDesc = txtChairs.Text;
                }
                else
                {
                    objAminityEntity.Chairs = 0;
                    txtChairs.Text = "";

                }

                if (rbtnTable1.Checked == true)
                {
                    objAminityEntity.Tables = 1;
                    objAminityEntity.TablesDesc = txtTable.Text;
                }
                else
                {
                    objAminityEntity.Tables = 0;
                    txtTable.Text = "";
                }

                if (rbtnMusicsystem1.Checked == true)
                {

                    objAminityEntity.MusicSystem = 1;

                    objAminityEntity.MusicSysDesc = txtMusicsystem.Text;
                }
                else
                {
                    objAminityEntity.MusicSystem = 0;
                    txtMusicsystem.Text = "";
                }

                objAminityEntity.CreatedBy = Session["LoginId"].ToString();
                // objEmpinfo.CreatedBy = Session["UserName"].ToString();
                output = objAminityDal.InsertAminityInformation(objAminityEntity);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + output + "');</script>", false);
                clearall();
            }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Session["_AminityId"] = null;
            
            Response.Redirect("AmenityMasterView.aspx");
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clearall();

        }
        }

    }
