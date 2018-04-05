<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="VehicleMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.VehicleMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#drpFlatNo").select2({ maximumSelectionSize: 1 });
            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
        });

    </script>
    <script language="javascript" type="text/javascript">
        function vehiclevalidtn() {
            var flatname = document.getElementById('<%=drpFlatNo.ClientID%>').value;
            var numberofvehicle = document.getElementById('<%=drpNoOfvehicle.ClientID%>').value;


            var vehtype1 = document.getElementById('<%=drpVehtype1.ClientID%>').value;
            var vehtypetxt1 = document.getElementById('<%=txtvehno1.ClientID%>').value;
            var vehtype2 = document.getElementById('<%=drpVehtype2.ClientID%>').value;
            var vehtypetxt2 = document.getElementById('<%=txtvehno2.ClientID%>').value
            var vehtype3 = document.getElementById('<%=drpVehtype3.ClientID%>').value;
            var vehtypetxt3 = document.getElementById('<%=txtvehno3.ClientID%>').value;
            var vehtype4 = document.getElementById('<%=drpVehtype4.ClientID%>').value;
            var vehtypetxt4 = document.getElementById('<%=txtvehno4.ClientID%>').value;
            var txtextraveh = document.getElementById('<%=txtExtravehinfo.ClientID%>').value;
            //var vehiclenopattrn = /^[A-Za-z]{2}[-].[A-Za-z0-9]*$/;

            var vehiclenopattrn = /^[A-Z]{2}[ \-][0-9]{2}[ \-][A-Z]{2}[ \-][0-9]{4}$/;
            //-- /^[A-Za-z]{2}[-].[A-Za-z0-9\s]*$/--            
            if (flatname == "") {
                bootbox.alert("Enter Flat Number");
                return false;
            }
            if (numberofvehicle == "0") {
                bootbox.alert("Enter Number Of Vehicle");
                return false;
            }

            if (numberofvehicle == "one") {
                if (vehtype1 == "0") {
                    bootbox.alert("Enter Type of vehicle");
                    return false;
                }
                if (vehtypetxt1 == "") {
                    bootbox.alert("Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt1.toUpperCase())) {
                    bootbox.alert("Vehicle number Pattarn not match");
                    return false;
                }
            }
            if (numberofvehicle == "Two") {
                if (vehtype1 == "0") {
                    bootbox.alert("Enter Type of vehicle For first record");
                    return false;
                }
                if (vehtypetxt1 == "") {
                    bootbox.alert("Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt1.toUpperCase())) {
                    bootbox.alert("Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype2 == "0") {
                    bootbox.alert("Enter Type of vehicle for second record");
                    return false;
                }
                if (vehtypetxt2 == "") {
                    bootbox.alert("Second Vehicle number field is empty ");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt2.toUpperCase())) {
                    bootbox.alert(" Second Vehicle number Pattarn not match");
                    return false;

                }
            }
            if (numberofvehicle == "Three") {
                if (vehtype1 == "0") {
                    bootbox.alert("Enter Type of vehicle For first record");
                    return false;
                }
                if (vehtypetxt1 == "") {
                    bootbox.alert("first Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt1.toUpperCase())) {
                    bootbox.alert("first Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype2 == "0") {
                    bootbox.alert("Enter Type of vehicle for second record");
                    return false;
                }
                if (vehtypetxt2 == "") {
                    bootbox.alert("Second Vehicle number field is empty ");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt2.toUpperCase())) {
                    bootbox.alert(" Second Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype3 == "0") {
                    bootbox.alert("Enter Type of vehicle for Third record");
                    return false;
                }
                if (vehtypetxt3 == "") {
                    bootbox.alert("Third Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt3.toUpperCase())) {
                    bootbox.alert(" Third Vehicle number Pattarn not match");
                    return false;

                }
            }
            if (numberofvehicle == "Four") {
                if (vehtype1 == "0") {
                    bootbox.alert("Enter Type of vehicle For first record");
                    return false;
                }
                if (vehtypetxt1 == "") {
                    bootbox.alert("first Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt1.toUpperCase())) {
                    bootbox.alert("first Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype2 == "0") {
                    bootbox.alert("Enter Type of vehicle for second record");
                    return false;
                }
                if (vehtypetxt2 == "") {
                    bootbox.alert("Second Vehicle number field is empty ");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt2.toUpperCase())) {
                    bootbox.alert(" Second Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype3 == "0") {
                    bootbox.alert("Enter Type of vehicle for Third record");
                    return false;
                }
                if (vehtypetxt3 == "") {
                    bootbox.alert("Third Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt3.toUpperCase())) {
                    bootbox.alert(" Third Vehicle number Pattarn not match");
                    return false;

                }

                if (vehtype4 == "0") {
                    bootbox.alert("Enter Type of vehicle for Forth record");
                    return false;
                }
                if (vehtypetxt4 == "") {
                    bootbox.alert("Forth Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt4.toUpperCase())) {
                    bootbox.alert(" Forth Vehicle number Pattarn not match");
                    return false;

                }

            }
            if (numberofvehicle == "FourPlus") {
                if (vehtype1 == "0") {
                    bootbox.alert("Enter Type of vehicle For first record");
                    return false;
                }
                if (vehtypetxt1 == "") {
                    bootbox.alert("first Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt1.toUpperCase())) {
                    bootbox.alert("first Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype2 == "0") {
                    bootbox.alert("Enter Type of vehicle for second record");
                    return false;
                }
                if (vehtypetxt2 == "") {
                    bootbox.alert("Second Vehicle number field is empty ");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt2.toUpperCase())) {
                    bootbox.alert(" Second Vehicle number Pattarn not match");
                    return false;

                }
                if (vehtype3 == "0") {
                    bootbox.alert("Enter Type of vehicle for Third record");
                    return false;
                }
                if (vehtypetxt3 == "") {
                    bootbox.alert("Third Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt3.toUpperCase())) {
                    bootbox.alert(" Third Vehicle number Pattarn not match");
                    return false;

                }

                if (vehtype4 == "0") {
                    bootbox.alert("Enter Type of vehicle for Forth record");
                    return false;
                }
                if (vehtypetxt4 == "") {
                    bootbox.alert("Forth Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(vehtypetxt4.toUpperCase())) {
                    bootbox.alert(" Forth Vehicle number Pattarn not match");
                    return false;

                } if (txtextraveh == "") {
                    bootbox.alert("Last Vehicle number field is empty");
                    return false;
                }
                if (!vehiclenopattrn.test(txtextraveh)) {
                    bootbox.alert("Last Vehicle number Pattarn not match");
                    return false;

                }

            }

            return true;
        }


    </script>
    <script language="javascript" type="text/javascript">
        function hideparknginfo()
        {

        }
        function showvehicle() {
            drpnumparking = document.getElementById('<%=drpNoOfvehicle.ClientID %>').value;
            if (drpnumparking == "FourPlus") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "";

            }
            if (drpnumparking == "Four") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "Three") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "Two") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "one") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "0") {
                document.getElementById('<%=vehicle1.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle2.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle3.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle4.ClientID %>').style.display = "none";
                document.getElementById('<%=vehicle5.ClientID %>').style.display = "none";
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/VehicleMaster.aspx">Vehicle Information</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                  <!--End button-->
              
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Vehicle Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a>--%>
                       
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Flat Number</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpFlatNo" class="select2 form-control input-large" placeholder="Flat Number"
                                            runat="server">
                                        </asp:DropDownList>
                                       
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Number of Vehicle</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpNoOfvehicle" class="form-control input-large" runat="server" onchange="showvehicle()">
                                            <asp:ListItem Value="0" Selected="True">--Select--</asp:ListItem>
                                            <asp:ListItem Value="one">one</asp:ListItem>
                                            <asp:ListItem Value="Two">Two</asp:ListItem>
                                            <asp:ListItem Value="Three">Three</asp:ListItem>
                                            <asp:ListItem Value="Four">Four</asp:ListItem>
                                            <asp:ListItem Value="FourPlus">More Than Four</asp:ListItem>
                                        </asp:DropDownList>
                                       
                                </div>
                                <div class="form-group" runat="server">
                                    <div class="form-horizontal">
                                        <div class="form-body">
                                            <h4 class="caption-subject font-blue-hoki bold">
                                                Vehicle Description</h4>
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-3" id="vehicle1" runat="server" style="display: none">
                                                    <div class="form-group">
                                                        <div class="form">
                                                            <fieldset>
                                                                <label>
                                                                   Vehicle 1 / Vehicle Type</label>
                                                                <asp:DropDownList ID="drpVehtype1" class="form-control input-large" runat="server">
                                                                    <asp:ListItem Value="0">--select--</asp:ListItem>
                                                                    <asp:ListItem Value="2-Wheeler">2 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="3-Wheeler">3 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="4-Wheeler">4 Wheeler</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <label>
                                                                    Vehicle Number</label>
                                                                <asp:TextBox ID="txtvehno1" class="form-control input-large" runat="server"></asp:TextBox><asp:Label Text="e.g. MH-20-AB-1254" style="color:Red" runat="server"></asp:Label>
                                                                <label>
                                                                    IS Sticker Given</label>
                                                                <div class="control-group">
                                                                    <asp:CheckBox ID="chkisstickerveh1" class="icheck" runat="server" />
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-3" id="vehicle2" runat="server" style="display: none">
                                                    <div class="form-group">
                                                        <div class="form">
                                                            <fieldset>
                                                                <label>
                                                                    Vehicle 2 /Vehicle Type</label>
                                                                <asp:DropDownList ID="drpVehtype2" class="form-control input-large" runat="server">
                                                                    <asp:ListItem Value="0">--select--</asp:ListItem>
                                                                    <asp:ListItem Value="2-Wheeler">2 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="3-Wheeler">3 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="4-Wheeler">4 Wheeler</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <label>
                                                                    Vehicle Number</label>
                                                                <asp:TextBox ID="txtvehno2" class="form-control input-large" runat="server"></asp:TextBox>
                                                                <label>
                                                                    IS Sticker Given</label>
                                                                <div class="control-group">
                                                                    <asp:CheckBox ID="chkisstickerveh2" class="icheck" runat="server" />
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3" id="vehicle3" runat="server" style="display: none">
                                                    <div class="form-group">
                                                        <div class="form">
                                                            <fieldset>
                                                                <label>
                                                                    Vehicle 3/Vehicle Type</label>
                                                                <asp:DropDownList ID="drpVehtype3" class="form-control input-large" runat="server">
                                                                    <asp:ListItem Value="0">--select--</asp:ListItem>
                                                                    <asp:ListItem Value="2-Wheeler">2 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="3-Wheeler">3 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="4-Wheeler">4 Wheeler</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <label>
                                                                    Vehicle Number</label>
                                                                <asp:TextBox ID="txtvehno3" class="form-control input-large" runat="server"></asp:TextBox>
                                                                <label>
                                                                    IS Sticker Given</label>
                                                                <div class="control-group">
                                                                    <asp:CheckBox ID="chkisstickerveh3" class="icheck" runat="server" />
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3" id="vehicle4" runat="server" style="display: none">
                                                    <div class="form-group">
                                                        <div class="form">
                                                            <fieldset>
                                                                <label>
                                                                   Vehicle4/ Vehicle Type</label>
                                                                <asp:DropDownList ID="drpVehtype4" class="form-control input-large" runat="server">
                                                                    <asp:ListItem Value="0">--select--</asp:ListItem>
                                                                    <asp:ListItem Value="2-Wheeler">2 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="3-Wheeler">3 Wheeler</asp:ListItem>
                                                                    <asp:ListItem Value="4-Wheeler">4 Wheeler</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <label>
                                                                    Vehicle Number</label>
                                                                <asp:TextBox ID="txtvehno4" class="form-control input-large" runat="server"></asp:TextBox>
                                                                <label>
                                                                    IS Sticker Given</label>
                                                                <div class="control-group">
                                                                    <asp:CheckBox ID="chkisstickerveh4" class="icheck" runat="server" />
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                        </div>
                                    </div>
                                    <div class="form-group" id="vehicle5" runat="server" style="display: none">
                                        <div class="col-md-12">
                                            <label>
                                                Extra info</label>
                                            <asp:TextBox ID="txtExtravehinfo" class="form-control" TextMode="MultiLine" Height="250"
                                                runat="server"  rel="popover" data-content="Type More Info"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            

                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSubmit_Click"  OnClientClick="return vehiclevalidtn();"/>
                                                <asp:Button type="btnCancel" runat="server" Text="Clear" class="btn default"/>
                                             
                                                <asp:Button type="btnBack" runat="server" Text="Cancel" class="btn btn-success" 
                                                    onclick="btnBack_Click"/>
                                              
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- END FORM-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
