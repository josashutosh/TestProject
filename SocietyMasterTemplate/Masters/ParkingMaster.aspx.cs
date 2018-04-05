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
using System.Web.Services;
using Newtonsoft.Json;
namespace EsquareMasterTemplate.Masters
{
    public partial class ParkingMaster : System.Web.UI.Page
    {
        clsParkingMasterDal obj = new clsParkingMasterDal();
        clsOwnerMasterDal objownerdal = new clsOwnerMasterDal();
        clsOwnerInfo objownerinfo = new clsOwnerInfo();
        clsFlatEntity objflatinfo = new clsFlatEntity();
        clsFlatMasterDal objflatdal = new clsFlatMasterDal();
        clsParkingMasterDal obparkingDal = new clsParkingMasterDal();
        clsCommonDAL objCommonDAL = new clsCommonDAL();
        clsParkingMasterDal objParkingDal = new clsParkingMasterDal();
        string parkingtype, IsparkAvailable, Parking1Type, Parking2Type, Parking3Type;
        int PrkID, noparking, ParentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Cache.SetExpires(DateTime.Now);
            //Response.Cache.SetNoServerCaching();
            //Response.Cache.SetNoStore();
            CallBack();
            PrkID = Convert.ToInt32(Request.QueryString["ParkingId"]);
            ParentId = Convert.ToInt32(Request.QueryString["PId"]);
            if (!IsPostBack)
            {
                //if (Convert.ToString(Session["Roomno"]) == "")
                //{
                //    Response.Redirect("login.aspx");
                //}

                // Bindownerinfo();
                ValidateUserPermissions();               
                isparkavailable();
                FillPageDropDowns();
                drpFlatID.Items.Insert(0, new ListItem("--Select Flat Number--", ""));
                drpFlatID.SelectedIndex = 0;
                UpdateParkingMaster();
                
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
        protected void UpdateParkingMaster()
        {
            //HttpResponse.RemoveOutputCacheItem("ParkingMaster.aspx");
            if (PrkID != 0)
            {
                DataSet ds = new DataSet();

                int parkingID = PrkID;

                ds = (DataSet)obparkingDal.GetAllParkingdata(parkingID, Convert.ToString(Session["LoginId"]));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    drpFlatID.SelectedValue = ds.Tables[0].Rows[0]["FlatId"].ToString();
                    objflatinfo.FlatId = Convert.ToInt32(drpFlatID.SelectedValue);
                    drpFlatID.SelectedItem.Text = Convert.ToString(ds.Tables[0].Rows[0]["FlatNumber"]);
                    objParkingDal.FillDropDown(DrpOwnerID, ((DataSet)objownerdal.getownerinfobyflatid(drpFlatID.SelectedValue, Convert.ToString(Session["LoginId"]))).Tables[0], "OwnerName1", "OwnerId");

                    DrpOwnerID.SelectedValue = ds.Tables[0].Rows[0]["OwnerId"].ToString();

                    // populate value for isavailable chkbox  

                    if (ds.Tables[0].Rows[0]["IsParkingAvailable"].ToString() != null)
                    {
                        if (ds.Tables[0].Rows[0]["IsParkingAvailable"].ToString() == "Yes")
                        {
                            ParkingtypeAvail.Attributes["style"] = "display:block";
                            ParkingtypeAvail.Attributes["style"] = "margin-left:0px";
                            chkIsparkAvailable.Checked = true;
                        }
                        else
                        {
                            chkIsparkAvailable.Checked = false;
                            drpnumparking.SelectedValue = Convert.ToString(0);
                            ParkingtypeAvail.Attributes["style"] = "display:block";
                        }

                    }

                    //End populate value for isavailable chkbox 

                    // drpFlatID.SelectedItem.Text =Convert.ToString(ds.Tables[0].Rows[0]["FlatNumber"]);
                    drpnumparking.SelectedValue = ds.Tables[0].Rows[0]["NumberOfParking"].ToString();

                    if (ds.Tables[0].Rows[0]["ParkingType"].ToString() != "")
                    {
                        string updateparktype = ds.Tables[0].Rows[0]["ParkingType"].ToString();

                        if (updateparktype != "")
                        {
                            if (updateparktype == "Open")
                            {
                                chkOpen.Checked = true;
                            }

                            if (updateparktype == "Stilt")
                            {
                                chkStilt.Checked = true;
                            }

                            if (updateparktype == "Open,Stilt")
                            {
                                string[] updateparktype1 = updateparktype.Split(',');
                                if (updateparktype1[0] == "Open" && updateparktype1[1] == "Stilt")
                                {
                                    chkOpen.Checked = true;
                                    chkStilt.Checked = true;
                                }
                            }
                        }
                        else
                        {
                            chkOpen.Checked = false;
                            chkStilt.Checked = false;
                        }
                    }


                    if (ds.Tables[0].Rows[0]["Parking1Type"].ToString() != "")
                    {
                        string updateparktype11 = ds.Tables[0].Rows[0]["Parking1Type"].ToString();

                        if (updateparktype11 != "")
                        {
                            if (updateparktype11 == "Open")
                            {
                                chkOpen11.Checked = true;
                            }

                            if (updateparktype11 == "Stilt")
                            {
                                chkStilt11.Checked = true;
                            }

                            if (updateparktype11 == "Open,Stilt")
                            {
                                string[] updateparktype111 = updateparktype11.Split(',');
                                if (updateparktype111[0] == "Open" && updateparktype111[1] == "Stilt")
                                {
                                    chkOpen11.Checked = true;
                                    chkStilt11.Checked = true;
                                }
                            }
                        }
                        else
                        {
                            chkOpen11.Checked = false;
                            chkStilt11.Checked = false;
                        }
                    }


                    if (ds.Tables[0].Rows[0]["Parking2Type"].ToString() != "")
                    {
                        string updateparktype21 = ds.Tables[0].Rows[0]["Parking2Type"].ToString();

                        if (updateparktype21 != "")
                        {
                            if (updateparktype21 == "Open")
                            {
                                chkOpen21.Checked = true;
                            }

                            if (updateparktype21 == "Stilt")
                            {
                                chkStilt21.Checked = true;
                            }

                            if (updateparktype21 == "Open,Stilt")
                            {
                                string[] updateparktype211 = updateparktype21.Split(',');
                                if (updateparktype211[0] == "Open" && updateparktype211[1] == "Stilt")
                                {
                                    chkOpen21.Checked = true;
                                    chkStilt21.Checked = true;
                                }
                            }
                        }
                        else
                        {
                            chkOpen21.Checked = false;
                            chkStilt21.Checked = false;
                        }
                    }

                    if (ds.Tables[0].Rows[0]["Parking3Type"].ToString() != null)
                    {
                        string updateparktype31 = ds.Tables[0].Rows[0]["Parking3Type"].ToString();

                        if (updateparktype31 != "")
                        {
                            if (updateparktype31 == "Open")
                            {
                                chkOpen21.Checked = true;
                            }

                            if (updateparktype31 == "Stilt")
                            {
                                chkStilt21.Checked = true;
                            }

                            if (updateparktype31 == "Open,Stilt")
                            {
                                string[] updateparktype311 = updateparktype31.Split(',');
                                if (updateparktype311[0] == "Open" && updateparktype311[1] == "Stilt")
                                {
                                    chkOpen21.Checked = true;
                                    chkStilt21.Checked = true;
                                }
                            }
                        }
                        else
                        {
                            chkOpen31.Checked = false;
                            chkStilt31.Checked = false;
                        }
                    }

                    

                    txtparkingcount1.Text = ds.Tables[0].Rows[0]["Parking1"].ToString();
                    txtparkingcount2.Text = ds.Tables[0].Rows[0]["Parking2"].ToString();
                    txtparkingcount2.Text = ds.Tables[0].Rows[0]["Parking3"].ToString();


                    if (Convert.ToInt32(drpnumparking.SelectedValue) == 1)
                    {
                        txtparkingcount11.Attributes["style"] = "display:block;";
                        txtparkingcount1.Attributes["style"] = "margin:3px 0px 3px 0px;";
                        txtparkingcount1.Text = ds.Tables[0].Rows[0]["Parking1"].ToString();
                        txtparkingcount2.Text = "";
                        txtparkingcount3.Text = "";
                        //txtparkingcount1.Visible = true;

                    }
                    else if (Convert.ToInt32(drpnumparking.SelectedValue) == 2)
                    {
                        txtparkingcount11.Attributes["style"] = "display:block;";
                        txtparkingcount1.Attributes["style"] = "margin:3px 0px 3px 0px;";

                        txtparkingcount21.Attributes["style"] = "display:block;";
                        txtparkingcount2.Attributes["style"] = "margin:3px 0px 3px 0px;";

                        txtparkingcount1.Text = ds.Tables[0].Rows[0]["Parking1"].ToString();
                        txtparkingcount2.Text = ds.Tables[0].Rows[0]["Parking2"].ToString();
                        txtparkingcount3.Text = "";

                        // txtparkingcount1.Visible = true;
                        // txtparkingcount2.Visible = true;
                    }
                    else if (Convert.ToInt32(drpnumparking.SelectedValue) == 3)
                    {
                        txtparkingcount11.Attributes["style"] = "display:block;";
                        txtparkingcount1.Attributes["style"] = "margin:3px 0px 3px 0px;";

                        txtparkingcount21.Attributes["style"] = "display:block;";
                        txtparkingcount2.Attributes["style"] = "margin:3px 0px 3px 0px;";

                        txtparkingcount31.Attributes["style"] = "display:block;";
                        txtparkingcount3.Attributes["style"] = "margin:3px 0px 3px 0px;";

                        txtparkingcount1.Text = ds.Tables[0].Rows[0]["Parking1"].ToString();
                        txtparkingcount2.Text = ds.Tables[0].Rows[0]["Parking2"].ToString();
                        txtparkingcount3.Text = ds.Tables[0].Rows[0]["Parking3"].ToString();

                        // txtparkingcount1.Visible = true;
                        // txtparkingcount2.Visible = true;
                        // txtparkingcount3.Visible = true;
                    }

                    Session["PrkID"] = PrkID.ToString();
                    btnsubmit.Text = "Update";

                }

            }
            else
            {
                btnsubmit.Text = "Submit";
            }
        }

         
        [WebMethod(EnableSession = true)]
        public static string GetOwnerInfobyFlatId(string FlatId)
        {
            clsMaintenanceCollectionEntity objMainCollEntity = new clsMaintenanceCollectionEntity();
            clsMaintenanceCollectionDal objMainCollDAL = new clsMaintenanceCollectionDal();
            clsOwnerMasterDal objownerdal = new clsOwnerMasterDal();
            List<string> result = new List<string>();
            DataSet ds = new DataSet();
            objMainCollEntity.Flag = "FillDrpFlatNoByPropertyType";
            objMainCollEntity.PropertyType = FlatId;
            ds = objownerdal.getownerinfobyflatid(FlatId, Convert.ToString(HttpContext.Current.Session["LoginId"]));
            List<SetOwnerInfo> M = new List<SetOwnerInfo>();
            if (ds.Tables.Count > 0)
            {
                //M.Clear();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    SetOwnerInfo MF = new SetOwnerInfo();
                    MF.OwnerId = Convert.ToInt32(ds.Tables[0].Rows[i]["OwnerId"].ToString());
                    MF.Ownername = ds.Tables[0].Rows[i]["OwnerName1"].ToString();
                    M.Add(MF);
                }
            }
            else
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>toastr.warning('" + dslock + "'); </script>", false);
            }

            return JsonConvert.SerializeObject(M);
        }


        private void CallBack()
        {
            if (Request.Headers["IsAjax"] != null && Convert.ToString(Request.Headers["IsAjax"]) == "true")
            {
                string ID1 = Request.Form["id1"] ?? string.Empty, Opt = Request.Form["opt"] ?? string.Empty,
                       ID2 = Request.Form["id2"] ?? string.Empty, ID3 = Request.Form["id3"] ?? string.Empty,
                       ID4 = Request.Form["id4"] ?? string.Empty;
                Response.Clear();
                Response.ContentType = "Text/xml";
                switch (Opt)
                {
                    case "1": Response.Write(objownerdal.getownerinfobyflatid(ID1.Trim(), Convert.ToString(Session["LoginId"])).GetXml()); break;
                    default: Response.Write(""); break;
                }
                Response.End();
            }
        }


        protected void btnsubmit_Click(object sender, EventArgs e)
        {

            if (PrkID == 0)
            {
                PrkID = 0;
            }
            else
            {
                Session["PrkID"] = PrkID.ToString();
                PrkID = Convert.ToInt32(Session["PrkID"]);
            }

            int flatID = Convert.ToInt32(drpFlatID.SelectedValue);
            int ownerid = Convert.ToInt32(Request.Form[DrpOwnerID.UniqueID]);

            if (chkIsparkAvailable.Checked == true)
            {
                IsparkAvailable = "Yes";
            }
            else
            {
                IsparkAvailable = "No";
                chkOpen.Checked = false;
                parkingtype = "";
                Parking1Type = "";
                Parking2Type = "";
                Parking3Type = "";
                noparking = Convert.ToInt32(0);
            }


           
            if (chkOpen.Checked == true && chkStilt.Checked == true)
            {
                parkingtype = chkOpen.Text + "," + chkStilt.Text;
            }
            else if (chkOpen.Checked == true)
            {
                parkingtype = chkOpen.Text;
            }

            else if (chkStilt.Checked == true)
            {
                parkingtype = chkStilt.Text;
            }

          if (chkOpen11.Checked == true)
            {
                Parking1Type = chkOpen11.Text;
            }

            else if (chkStilt11.Checked == true)
            {
                Parking1Type = chkStilt11.Text;
            }
            else { Parking1Type = ""; }

           
            if (chkOpen21.Checked == true)
            {
                Parking2Type = chkOpen21.Text;
            }
            else if (chkStilt21.Checked == true)
            {
                Parking2Type = chkStilt21.Text;
            }
            else
            { 
                Parking2Type = "";
            }


            if (chkOpen31.Checked == true)
            {
                Parking3Type = chkOpen31.Text;
            }
            else if (chkStilt31.Checked == true)
            {
                Parking3Type = chkStilt31.Text;
            }
            else {Parking3Type = "";}

            noparking = Convert.ToInt32(drpnumparking.SelectedValue);
            string parlkingcount1 = Convert.ToString(txtparkingcount1.Text);
            string parlkingcount2 = Convert.ToString(txtparkingcount2.Text);
            string parlkingcount3 = Convert.ToString(txtparkingcount3.Text);
            string result = obj.Insertparking(PrkID, flatID, ownerid, IsparkAvailable, parkingtype, noparking, parlkingcount1, parlkingcount2, parlkingcount3, Convert.ToString(Session["Flatno"]), Parking1Type, Parking2Type, Parking3Type);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<script type='text/javascript' language='javascript'>bootbox.alert('" + result + "');</script>", false);

            clearall();
            if (PrkID != 0)
            {
                Session["PrkID"] = null;
                FillPageDropDowns();
                drpFlatID.Items.Insert(0, new ListItem("--Select Flat Number--", ""));
                drpFlatID.SelectedIndex = 0;
            }

            btnsubmit.Text = "Submit";
        
        }

        

        private void FillPageDropDowns()
        {
            objParkingDal.FillDropDown(drpFlatID, ((DataSet)objflatdal.GetflatInfo(objflatinfo, Convert.ToString(Session["LoginId"]))).Tables[0], "FlatNumber", "FlatId");
        }


        public void Bindownerinfo()
        {
            DataSet ds = new DataSet();
            ds = (DataSet)objownerdal.GetownerInfo(objownerinfo, Convert.ToString(Session["LoginId"]));
            DrpOwnerID.DataSource = ds;
            DrpOwnerID.DataTextField = "OwnerName1";
            DrpOwnerID.DataValueField = "OwnerId";
            DrpOwnerID.DataBind();

            ListItem objLI = new ListItem("--Select owner name--", "0");
            DrpOwnerID.Items.Insert(1, objLI);

        }
         //objParkingDal.FillDropDown(DrpOwnerID, ((DataSet)objownerdal.getownerinfobyflatid(drpFlatID.SelectedValue)).Tables[0], "OwnerName1", "OwnerId");
        private void clearall()
        {
           
            chkIsparkAvailable.Checked = false;
            chkOpen.Checked = true;
            chkStilt.Checked = false;
            drpnumparking.SelectedValue = "0";
            txtparkingcount1.Text = "";
            txtparkingcount2.Text = "";
            txtparkingcount3.Text = "";
            isparkavailable();
        }

        public void isparkavailable()
        {
            if (chkIsparkAvailable.Checked == true)
            {
                ParkingtypeAvail.Attributes["style"] = "display:block";
                ParkingtypeAvail.Attributes["style"] = "margin-left:0px";
            }
            else
            {
                ParkingtypeAvail.Attributes["style"] = "display:none";
            }
        }

        private string StrDate(string Date)
        {
            if (Date != "")
            {
                string[] Date1 = Date.Split('/');
                Date = Date1[1] + "/" + Date1[0] + "/" + Date1[2];
                return (Date);
            }
            else
            {
                return null;
            }
        }

        protected void btnback_Click(object sender, EventArgs e)
        {
           // Session.Clear();
            Session["PrkID"] = null;
            Response.Redirect("ParkingMasterView.aspx");
        }
    }
}