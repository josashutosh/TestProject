<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="MaintenanceCollection.aspx.cs" Inherits="EsquareMasterTemplate.Masters.MaintenanceCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var FlatID, PropertyType, MaintenanceperiodID, MainID;



        $(document).ready(function () {


            $('.SelectBox').multiselect({
                enableFiltering: false,
                includeSelectAllOption: true,
                maxHeight: 400,
                dropUp: true,
                buttonWidth: '400px',
                onDropdownHide: function (event) {

                    showdiv();
                    GetMaintenanceAmount();


                    HideDiv();

                }
            });
            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});

            $('#<%=drpModeofPayment.ClientID %>').change(function ()
            {
                var selectedText = $(this).find("option:selected").text();
                var selectedvalue = $(this).find("option:selected").val();

                if (selectedText == "Cheque" || selectedText=="DD")
                {
                    $('#<%=divInstrumentnumber.ClientID %>').show();
                }
                else
                {
                    $('#<%=divInstrumentnumber.ClientID %>').hide();
                }

                if (selectedvalue == "")
                {
                    $('#<%=divInstrumentDate.ClientID %>').hide();
                }
                else
                {
                    $('#<%=divInstrumentDate.ClientID %>').show();
                }

                if (selectedText == "Cheque")
                {
                    $('#lblInstrumentnumber,#lblInstrumentDate').html('Cheque');
                }
                else if (selectedText == "DD")
                {
                    $('#lblInstrumentnumber,#lblInstrumentDate').html('DD');
                }
                else if (selectedText=="Cash") {
                    $('#lblInstrumentDate').html('Cash');
                }      
                else if (selectedText=="ECS") {
                    $('#lblInstrumentDate').html('ECS');
                }     
                
             


            });

            $('#<%=drpPropertytype.ClientID%>').change(function () {
                showdiv();
                getFlatNo();
                HideDiv();

            });
            $('#<%=drpFlatnumber.ClientID%>').change(function () {
                showdiv();
                getmaintenancePeriod();
                HideDiv();
            });

            //            $('#<%=drpMaintenancePeriod.ClientID %>').change(function ()
            //             {
            //                showdiv();
            //               
            //                HideDiv();
            //            });

        });

        function showdiv() {
            Society.blockUI({
                centerX: true,
                centerY: true,
                css: {
                    height: 'auto',
                    cursor: 'null',
                    left: "15%",
                    top: "34%",
                    width: "23%",
                    border: 'none',
                    textalign: 'center',
                    backgroundColor: 'auto'
                },
                target: '#Main_Collection',
                boxed: true,
                message: 'Processing...'
            });


        }

        function HideDiv() {
            window.setTimeout(function () {
                Society.unblockUI('#Main_Collection');
            }, 1000);
        }

        function validate() {
            var propertyType, flatNumber, modeofpayment, paidAmount, Instrumentnumber, MaintenancePeriod,MaintenanceAmount;

            propertyType = document.getElementById('<%=drpPropertytype.ClientID %>').value;

            flatNumber = document.getElementById('<%=drpFlatnumber.ClientID %>').value;

            modeofpayment = document.getElementById('<%=drpModeofPayment.ClientID %>').value;

            paidAmount = document.getElementById('<%=txtPaidAmount.ClientID %>').value;
            MaintenanceAmount = $('#<%=txtMaintenanceAmount.ClientID %>').val();
            MaintenancePeriod =  $('#<%=hdnmaintenanceid.ClientID %>').val();
            Instrumentnumber = document.getElementById('<%=txtInstrumentnumber.ClientID %>').value;
           
            if (propertyType == '' || propertyType == 0) {
                bootbox.alert("please Select Property type");
                return false;
            }

            if (flatNumber == '' || flatNumber == 0)
            {
                bootbox.alert("please Select Flat number");
                return false;
            }

            if (MaintenancePeriod == '')
            {
                bootbox.alert("please Select Maintenance Period");
                return false;
            }

            //if (paidAmount != MaintenanceAmount)
            //{
            //    bootbox.alert("Maintenance amount and paid amount are not equal");
            //    return false;
            //}

            if (modeofpayment == '' || modeofpayment == 0) {
                bootbox.alert("please Select Payment mode");
                return false;
            }

            if (paidAmount == '') {
                bootbox.alert("please Enter Payment Amount");
                return false;
            }

            if (Instrumentnumber == '') {
                bootbox.alert("please Enter Instrument number");
                return false;
            }

            return true;
        }

        function getFlatNo() {
            var f = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = f.options[f.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollection.aspx/GetFlatNumber",
                data: "{'PropertyType':'" + PropertyType + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);


                    $('#<%=drpFlatnumber.ClientID %>').empty();
                    if (Result.length > 0) {
                        for (var i = 0; i < Result.length; i++) {
                            // $('#<%=drpFlatnumber.ClientID %>').options[i] = null;
                            $('#<%=drpFlatnumber.ClientID %>').append("<option value=" + Result[i].FlatId + ">" +
                          Result[i].FlatNumber + "</option>");
                        }
                    }
                    $('#<%=drpFlatnumber.ClientID %>').prepend("<option value='' selected='selected'>-Select Flat Number--</option>");

                    // One more way of writing
                    // for (var i in Result) {
                    //  $("#ddlcountry").append($("<option></option>").val(Result[i].ID).
                    //   text(Result[i].Name));
                    //  }

                },
                error: function (Result) {
                    alert("Error");
                }
            });

        }

        function getmaintenancePeriod() {

            var f = document.getElementById('<%=drpFlatnumber.ClientID %>');
            FlatID = f.options[f.selectedIndex].value;

            var p = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = p.options[p.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollection.aspx/GetMaintenanceperiod",
                data: "{'FlatID':'" + FlatID + "','PropertyType':'" + PropertyType + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);
                    var items;
                    $('#<%=drpMaintenancePeriod.ClientID %>').empty();
                    //$("#<%=drpMaintenancePeriod.ClientID %>").multiselect('rebuild');

                    if (Result.length > 0)
                    {
                        $.each(Result, function (key, val) {
                            //items += "<option value='" + val.ID + "'>" + val.MaintenancePeriod + "</option>";
                            $("#<%=drpMaintenancePeriod.ClientID %>").append('<option value="' + val.ID + '">' + val.MaintenancePeriod + '</option>');
                        });
                        $("#<%=drpMaintenancePeriod.ClientID %>").multiselect('rebuild');

                        for (var i = 0; i < Result.length; i++) {
                            // $('#<%=drpMaintenancePeriod.ClientID %>').options[i] = null;
                            //$('#<%=drpMaintenancePeriod.ClientID %>').append(items);
                        }
                    }
                   // $('#<%=drpMaintenancePeriod.ClientID %>').prepend("<option value='' selected='selected'>-Select Maintenance Period--</option>");


                },
                error: function (Result) {
                    alert("Error");
                    HideDiv();
                }
            });

        }

        function GetMaintenanceAmount() {
            var f = document.getElementById('<%=drpFlatnumber.ClientID %>');
            FlatID = f.options[f.selectedIndex].value;

            var p = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = p.options[p.selectedIndex].value;

            // var mp = document.getElementById('<%=drpMaintenancePeriod.ClientID %>');
            // MainID = mp.options[mp.selectedIndex].value;
            var Main_ID = [];
            $('#<%=drpMaintenancePeriod.ClientID %> option:selected').each(function () {

                // MainID = MainID + "," + this.value;
                Main_ID.push(this.value);

            });

            MainID = Main_ID.toString();
            if (MainID.charAt(0) == ",") {
                MainID = MainID.substr(1);
            }
              $('#<%=hdnmaintenanceid.ClientID %>').val(""); 
            if (MainID == "")
            {
                $('#<%=txtMaintenanceAmount.ClientID %>').val('');
                $('#<%=txtPaidAmount.ClientID %>').val('');
                $('#<%=txtMaintenanceWalletAmt.ClientID %>').attr('readonly', true);
            }
            else
            {
                    $('#<%=hdnmaintenanceid.ClientID %>').val(MainID);  

                       $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MaintenanceCollection.aspx/GetMaintenancAmounts",
                    data: "{'MainID':'" + MainID + "','PropertyType':'" + PropertyType + "'}",
                    dataType: "json",
                    success: function (response) {
                        var Result = JSON.parse(response.d);

                        if (Result.length > 0)
                        {
                            $('#<%=txtMaintenanceAmount.ClientID %>').val(Result[0].Amount);
                            $('#<%=txtPaidAmount.ClientID %>').val(Result[0].Amount);
                            $('#<%=txtMaintenanceWalletAmt.ClientID %>').val(Result[0].MaintenanceWalletAmount);
                            $('#<%=txtMaintenanceAmount.ClientID %>').attr('readonly', true);
                            $('#<%=txtMaintenanceWalletAmt.ClientID %>').attr('readonly', true);
                        }
                    },
                    error: function (Result) {
                        alert("Error");
                        HideDiv();
                    }
                });
            }
          
        }  
    </script>
    <style>
        .SelectBox
        {
            width: 320px !important;
        }
        .SelectBox .multiselect-container ul, .SelectBox ul
        {
            min-width: 250px !important;
            padding-left: 15px !important;
        }
        .multiselect-item, .multiselect-container li
        {
            min-width: 250px !important;
            padding-left: 15px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        
                                      


    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Finance</a> <i class="fa fa-angle-right"></i></li>
            <li>Maintenance Collection</li>
        </ul>
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
                                Maintenance Collection </span><span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash">
                            </i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form" id="basic">
                        <!-- BEGIN FORM-->
                        <div id="Main_Collection" class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Property Type</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList class="form-control input-large" ID="drpPropertytype" runat="server">
                                            <asp:ListItem Selected="True" Value="" Text="--Select--"></asp:ListItem>
                                            <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                            <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Flat Number</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpFlatnumber" class="form-control input-large" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Maintenance Period</label>
                                    <div class="col-md-9">
                                        <%--   <asp:DropDownList ID="drpMaintenancePeriod" class="form-control input-large" runat="server">
                                        </asp:DropDownList>--%>
                                        <asp:ListBox ID="drpMaintenancePeriod" class="SelectBox input-large" SelectionMode="Multiple"
                                            runat="server"></asp:ListBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Maintenance Amount</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtMaintenanceAmount" AutoComplete="Off" rel="popover" data-content="Enter Maintenance Amount"
                                            class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Paid Amount</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtPaidAmount" AutoComplete="Off" rel="popover" data-content="Enter Amount"
                                            class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Maintenance Wallet Balance Amount</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtMaintenanceWalletAmt" AutoComplete="Off" rel="popover" data-content="Enter Amount"
                                            class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Mode Of Payment</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpModeofPayment" class="form-control input-large" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group" id="divInstrumentnumber" runat="server" clientidmode="Static"
                                    style="display: none">
                                    <label class="control-label col-md-3">
                                        <span runat="server" clientidmode="Static" id="lblInstrumentnumber"></span> Number</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtInstrumentnumber" rel="popover" data-content="Enter Instrument Number"
                                            AutoComplete="Off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div> 
                                <div class="form-group"  id="divInstrumentDate" runat="server" clientidmode="Static"
                                    style="display: none">
                                    <label class="control-label col-md-3">
                                        <span runat="server" clientidmode="Static" id="lblInstrumentDate"></span> Issue Date
                                    </label>
                                    <div class="col-md-9" >
                                        <asp:TextBox ID="txtInstrumentDate" placeholder="Instrument Date" rel="popover" data-content="Enter Instrument Date"
                                            AutoComplete="Off input-large" class="date form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <asp:Button ID="btnBuildingSubmit" runat="server" Text="Submit" class="btn btn-success"
                                            OnClick="btnBuildingSubmit_Click" OnClientClick="javascript:return validate();" />
                                        <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                        <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" OnClick="btnBack_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END FORM-->
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnmaintenanceid" runat="server" value=""/>
    </div>
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
