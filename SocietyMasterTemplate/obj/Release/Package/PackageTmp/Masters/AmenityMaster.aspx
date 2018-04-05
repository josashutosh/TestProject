<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="AmenityMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.AmenityMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
    <script language="javascript" type="text/javascript">

        function hideparknginfo() {

            var intercom_var1, intercom_var2, parking_var1, parking_var2, genset_var1, genset_var2, Lift_var1, Lift_var2, cctv_var1, cctv_var2, security_var1, security_var2, musicsys_var1, musicsys_var2, Chairs_var1, Chairs_var2, func_var1, func_var2, Table_var1, Table_var2, gym_var1, gym_var2;
            $(".intercom_yes label,.intercom_yes ins").click(function () {
                val = $('#<%=rbtnInter1.ClientID%>').val();
                val2 = $('#<%=rbtnInter2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnInter1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtIntercominfo.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtIntercominfo.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnInter2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtIntercominfo.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtIntercominfo.ClientID%>').show('fast');
                    }
                }
            });

            $(".parking_yes label,.parking_yes ins.iCheck-helper,:input,#MainContent_rbtnChairs1,.iradio_square-green").click(function () {
                val = $('#<%=rbtnParking1.ClientID%>').val();
                val2 = $('#<%=rbtnParking2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnParking1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtParkinginfo.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtParkinginfo.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnParking2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtParkinginfo.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtParkinginfo.ClientID%>').show('fast');
                    }
                }
            });


            $(".Genset_yes label,.Genset_yes ins").click(function () {
                val = $('#<%=rbtnGenset1.ClientID%>').val();
                val2 = $('#<%=rbtnGenset2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnGenset1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtGensetinfo.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtGensetinfo.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnGenset2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtGensetinfo.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtGensetinfo.ClientID%>').show('fast');
                    }
                }
            });


            $(".Lift_yes label,.Lift_yes ins").click(function () {
                val = $('#<%=rbtnLift1.ClientID%>').val();
                val2 = $('#<%=rbtnLift2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnLift1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtLiftinfo.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtLiftinfo.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnLift2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtLiftinfo.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtLiftinfo.ClientID%>').show('fast');
                    }
                }
            });


            $(".cctv_yes label,.cctv_yes ins").click(function () {
                val = $('#<%=rbtnCCTV1.ClientID%>').val();
                val2 = $('#<%=rbtnCCTV2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnCCTV1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtCCTV.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtCCTV.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnCCTV2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtCCTV.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtCCTV.ClientID%>').show('fast');
                    }
                }
            });


            $(".security_yes label,.security_yes ins").click(function () {
                val = $('#<%=rbtnSecurityinfo1.ClientID%>').val();
                val2 = $('#<%=rbtnSecurityinfo2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnSecurityinfo1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtSecurity.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtSecurity.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnSecurityinfo2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtSecurity.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtSecurity.ClientID%>').show('fast');
                    }
                }
            });




            $(".music_yes label,.music_yes ins").click(function () {
                val = $('#<%=rbtnMusicsystem1.ClientID%>').val();
                val2 = $('#<%=rbtnMusicsystem2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnMusicsystem1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtMusicsystem.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtMusicsystem.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnMusicsystem2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtMusicsystem.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtMusicsystem.ClientID%>').show('fast');
                    }
                }
            });




            $(".Chairs_yes label,.Chairs_yes ins").click(function () {
                val = $('#<%=rbtnChairs1.ClientID%>').val();
                val2 = $('#<%=rbtnChairs2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnChairs1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtChairs.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtChairs.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnChairs2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtChairs.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtChairs.ClientID%>').show('fast');
                    }
                }
            });






            $(".swimmimg_yes label,.swimmimg_yes ins").click(function () {
                val = $('#<%=rbtnSwimming1.ClientID%>').val();
                val2 = $('#<%=rbtnSwimming2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnSwimming1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtSwimmingpool.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtSwimmingpool.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnSwimming2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtSwimmingpool.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtSwimmingpool.ClientID%>').show('fast');
                    }
                }
            });






            $(".Table_yes label,.Table_yes ins").click(function () {
                val = $('#<%=rbtnTable1.ClientID%>').val();
                val2 = $('#<%=rbtnTable2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnTable1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtTable.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtTable.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnTable2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtTable.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtTable.ClientID%>').show('fast');
                    }
                }
            });






            $(".gym_yes label,.gym_yes ins").click(function () {
                val = $('#<%=rbtnGym1.ClientID%>').val();
                val2 = $('#<%=rbtnGym2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnGym1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtGym.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtGym.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnGym2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtGym.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtGym.ClientID%>').show('fast');
                    }
                }
            });





            $(".function_yes label,.function_yes ins").click(function () {
                val = $('#<%=rbtnFunctionhall1.ClientID%>').val();
                val2 = $('#<%=rbtnFunctionhall2.ClientID%>').val();
                if ((document.getElementById('MainContent_rbtnFunctionhall1').checked) === true) {
                    if (val === "1") {
                        $('#<%=txtFunctionhall.ClientID%>').show('fast');
                    }
                    else {
                        $('#<%=txtFunctionhall.ClientID%>').hide('fast');
                    }
                }
                if ((document.getElementById('MainContent_rbtnFunctionhall2').checked) === true) {
                    if (val2 === "0") {
                        $('#<%=txtFunctionhall.ClientID%>').hide('fast');
                    }
                    else {
                        $('#<%=txtFunctionhall.ClientID%>').show('fast');
                    }
                }
            });

        }



        $(document).ready(function () {
            $("#drpBuildingid").select2({ maximumSelectionSize: 1 });
        });


    </script>
    <script language="javascript" type="text/javascript">

        function aminityValidation() {
            var Buildingid = document.getElementById('<%=drpBuildingid.ClientID%>').value;
            if (Buildingid == "") {
                bootbox.alert("Enter Building Name");
                return false;
            }
            if (document.getElementById('<%=rbtnInter1.ClientID%>').checked == false && document.getElementById('<%=rbtnInter2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Intercom ");
                return false;
            }
            if (document.getElementById('<%=rbtnInter1.ClientID%>').checked == true && document.getElementById('<%=txtIntercominfo.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Intercom ");
                return false;
            }
            if (document.getElementById('<%=rbtnParking1.ClientID%>').checked == false && document.getElementById('<%=rbtnParking2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Parking ");
                return false;
            }
            if (document.getElementById('<%=rbtnParking1.ClientID%>').checked == true && document.getElementById('<%=txtParkinginfo.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Parking ");
                return false;
            }
            if (document.getElementById('<%=rbtnGenset1.ClientID%>').checked == false && document.getElementById('<%=rbtnGenset2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Genset");
                return false;
            }
            if (document.getElementById('<%=rbtnGenset1.ClientID%>').checked == true && document.getElementById('<%=txtGensetinfo.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Genset");
                return false;
            }
            if (document.getElementById('<%=rbtnLift1.ClientID%>').checked == false && document.getElementById('<%=rbtnLift2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Lift");
                return false;
            }
            if (document.getElementById('<%=rbtnLift1.ClientID%>').checked == true && document.getElementById('<%=txtLiftinfo.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Lift");
                return false;
            }
            if (document.getElementById('<%=rbtnCCTV1.ClientID%>').checked == false && document.getElementById('<%=rbtnCCTV2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to CCTV ");
                return false;
            }
            if (document.getElementById('<%=rbtnCCTV1.ClientID%>').checked == true && document.getElementById('<%=txtCCTV.ClientID%>').value == "") {

                bootbox.alert("Edit details related CCTV ");
                return false;
            }
            if (document.getElementById('<%=rbtnSecurityinfo1.ClientID%>').checked == false && document.getElementById('<%=rbtnSecurityinfo2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Security");
                return false;
            }
            if (document.getElementById('<%=rbtnSecurityinfo1.ClientID%>').checked == true && document.getElementById('<%=txtSecurity.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Security");
                return false;
            }

            if (document.getElementById('<%=rbtnMusicsystem1.ClientID%>').checked == false && document.getElementById('<%=rbtnMusicsystem2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Music and other instruments");
                return false;
            }
            if (document.getElementById('<%=rbtnMusicsystem1.ClientID%>').checked == true && document.getElementById('<%=txtMusicsystem.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Music and other instruments");
                return false;
            }
            if (document.getElementById('<%=rbtnChairs1.ClientID%>').checked == false && document.getElementById('<%=rbtnChairs2.ClientID%>').checked == false) {

                bootbox.alert("Add Chairs Details ");
                return false;
            }
            if (document.getElementById('<%=rbtnChairs1.ClientID%>').checked == true && document.getElementById('<%=txtChairs.ClientID%>').value == "") {

                bootbox.alert("Edit Chairs Details ");
                return false;
            }

            if (document.getElementById('<%=rbtnTable1.ClientID%>').checked == false && document.getElementById('<%=rbtnTable2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Tables ");
                return false;
            }
            if (document.getElementById('<%=rbtnTable1.ClientID%>').checked == true && document.getElementById('<%=txtTable.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Table ");
                return false;
            }
            if (document.getElementById('<%=rbtnSwimming1.ClientID%>').checked == false && document.getElementById('<%=rbtnSwimming2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Swimming Pool");
                return false;
            }
            if (document.getElementById('<%=rbtnSwimming1.ClientID%>').checked == true && document.getElementById('<%=txtSwimmingpool.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Swimming Pool");
                return false;
            }
            if (document.getElementById('<%=rbtnGym1.ClientID%>').checked == false && document.getElementById('<%=rbtnGym2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to GYM");
                return false;
            }
            if (document.getElementById('<%=rbtnGym1.ClientID%>').checked == true && document.getElementById('<%=txtGym.ClientID%>').value == "") {

                bootbox.alert("Edit details related to GYM");
                return false;
            }
            if (document.getElementById('<%=rbtnFunctionhall1.ClientID%>').checked == false && document.getElementById('<%=rbtnFunctionhall2.ClientID%>').checked == false) {

                bootbox.alert("Add details related to Function Hall");
                return false;
            }
            if (document.getElementById('<%=rbtnFunctionhall1.ClientID%>').checked == true && document.getElementById('<%=txtFunctionhall.ClientID%>').value == "") {

                bootbox.alert("Edit details related to Function Hall");
                return false;
            }



            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
   
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/Amenitymaster.aspx">Amenities Information</a> </li>
        </ul>
        <div class="page-toolbar">
            
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tab-pane" id="Div1">
                            <div class="portlet light bordered form-fit">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                            Amenities Information</span> <span class="caption-helper"></span>
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <!-- BEGIN FORM-->
                                    <div class="form-horizontal form-row-stripped form-label-stripped">
                                        <div class="form-body">
                                            <%--<h3 class="form-section">
                                                Amenity Info</h3>--%>
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Wing Name</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="drpBuildingid" class="select2me form-control"
                                                                runat="server">
                                                            </asp:DropDownList>
                                                            <span class="help-block">Select Wing Name</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Intercom Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnInter1" runat="server" Text="Yes" GroupName="A" class="icheck intercom_yes"
                                                                        value="1" />
                                                                    <asp:RadioButton ID="rbtnInter2" runat="server" Text="No" GroupName="A" class="icheck intercom_yes"
                                                                        value="0" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtIntercominfo" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--2ndrow-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Parking Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnParking1" runat="server" Text="Yes" GroupName="B" value="1"
                                                                        class="parking_yes" />
                                                                    <asp:RadioButton ID="rbtnParking2" runat="server" Text="No" GroupName="B" value="0"
                                                                        class="parking_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtParkinginfo" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Generator Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnGenset1" runat="server" Text="Yes" GroupName="C" value="1"
                                                                        class="Genset_yes" />
                                                                    <asp:RadioButton ID="rbtnGenset2" runat="server" Text="No" GroupName="C" class="Genset_yes"
                                                                        value="0" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtGensetinfo" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/close 2nd row-->
                                            <!--3rdrow-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Lift Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnLift1" runat="server" Text="Yes" GroupName="D" class="Lift_yes"
                                                                        value="1" />
                                                                    <asp:RadioButton ID="rbtnLift2" runat="server" Text="No" GroupName="D" class="Lift_yes"
                                                                        value="0" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtLiftinfo" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            CCTV Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnCCTV1" runat="server" Text="Yes" GroupName="E" value="1"
                                                                        class="cctv_yes" />
                                                                    <asp:RadioButton ID="rbtnCCTV2" runat="server" Text="No" GroupName="E" value="0"
                                                                        class="cctv_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtCCTV" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/close 3rd row-->
                                            <!--4rthrow-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Security Info</label>
                                                        <div class="col-md-9">
                                                            <div class="testicheck">
                                                                <asp:RadioButton ID="rbtnSecurityinfo1" runat="server" Text="Yes" GroupName="F" value="1"
                                                                    class="security_yes" />
                                                                <asp:RadioButton ID="rbtnSecurityinfo2" runat="server" Text="No" GroupName="F" value="0"
                                                                    class="security_yes" />
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtSecurity" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Music Info</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnMusicsystem1" runat="server" Text="Yes" GroupName="G" value="1"
                                                                        class="music_yes" />
                                                                    <asp:RadioButton ID="rbtnMusicsystem2" runat="server" Text="No" GroupName="G" value="0"
                                                                        class="music_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtMusicsystem" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/close 4rth row-->
                                            <!--5throw-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Chairs</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnChairs1" runat="server" Text="Yes" GroupName="H" value="1"
                                                                        class="Chairs_yes" />
                                                                    <asp:RadioButton ID="rbtnChairs2" runat="server" Text="No" GroupName="H" value="0"
                                                                        class="Chairs_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtChairs" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Tables</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnTable1" runat="server" Text="Yes" GroupName="J" value="1"
                                                                        class="Table_yes" />
                                                                    <asp:RadioButton ID="rbtnTable2" runat="server" Text="No" GroupName="J" value="0"
                                                                        class="Table_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtTable" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/close 5th row-->
                                            <!--6throw-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Swimmimg Pool</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnSwimming1" runat="server" Text="Yes" GroupName="I" value="1"
                                                                        class="swimmimg_yes" />
                                                                    <asp:RadioButton ID="rbtnSwimming2" runat="server" Text="No" GroupName="I" value="0"
                                                                        class="swimmimg_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtSwimmingpool" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            GYM</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnGym1" runat="server" Text="Yes" GroupName="K" value="1"
                                                                        class="gym_yes" />
                                                                    <asp:RadioButton ID="rbtnGym2" runat="server" Text="No" GroupName="K" value="0" class="gym_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtGym" class="form-control" TextMode="MultiLine" rows="3" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/close 6th row-->
                                            <!--7throw-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Community Hall</label>
                                                        <div class="col-md-9">
                                                            <div class="radio-list">
                                                                <div class="testicheck">
                                                                    <asp:RadioButton ID="rbtnFunctionhall1" runat="server" Text="Yes" GroupName="L" value="1"
                                                                        class="function_yes" />
                                                                    <asp:RadioButton ID="rbtnFunctionhall2" runat="server" Text="No" GroupName="L" value="0"
                                                                        class="function_yes" />
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtFunctionhall" TextMode="MultiLine" rows="3" class="form-control" runat="server" Style="display: none;"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/close 7th row-->
                                        </div>
                                        <!--/span-->
                                    </div>
                                    <!--/row-->
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClientClick="return aminityValidation()"
                                            OnClick="btnSubmit_Click" />
                                        <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" OnClick="btnClear_Click" />
                                        <asp:Button ID="BtnBack" class="btn btn-success" runat="server" Text="Cancel" OnClick="BtnBack_Click" />
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
   
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->


</asp:Content>
