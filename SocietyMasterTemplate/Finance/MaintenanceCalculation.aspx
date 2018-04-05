<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="MaintenanceCalculation.aspx.cs" EnableEventValidation="false" Inherits="EsquareMasterTemplate.Finance.MaintenanaceCalculation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="../ThemeAssets/global/plugins/bootstrap-summernote/summernote.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function ()
        {
            $(".datepickeryear").datepicker({
                format: "yyyy",
                viewMode: "years",
                minViewMode: "years",
                autoclose: true,
                //keyboardNavigation:true,
                todayBtn: true,
                todayHighlight: true,
                clearBtn: true
            });

            $('.html-editor').summernote({
                height: 300,                 // set editor height
                minHeight: 300,             // set minimum height of editor
                maxHeight: 500,
                focus: true,                // set focus to editable area after initializing summernote
                airPopover: [
            ['color', ['color']],
            ['font', ['bold', 'underline', 'clear']],
            ['para', ['ul', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture']]
                ]
            });

            $(".datepickermonth").datepicker({
                format: "mm",
                viewMode: "months",
                minViewMode: "months",
                autoclose: true,
                //keyboardNavigation:true,
                todayBtn: true,
                todayHighlight: true,
                clearBtn: true
            });
            $('.SelectBox').multiselect({
                enableFiltering: false,
                includeSelectAllOption: true,
                maxHeight: 400,
                dropUp: true,
                buttonWidth: '400px',
                onDropdownHide: function (event) {
                    GetFlatIds("pdf");
                }
            });
            $('.SelectBox1').multiselect({
                enableFiltering: false,
                includeSelectAllOption: true,
                maxHeight: 400,
                dropUp: true,
                buttonWidth: '400px',
                onDropdownHide: function (event) {
                    GetFlatIds("smsemail");
                }
            });



            $("#<%=drpPropertyTypesendsmsemail.ClientID %>").on("change", function ()
            {
                showdiv();
                $('#<%=hdnFlatidsEmailSms.ClientID %>,#<%=txtEmailDescription.ClientID %>,#<%=txtsmsmessage.ClientID %>,#<%=txttosmsemail.ClientID %>,#<%=txtsubjectsmsemail.ClientID %>').val('');


                $("#<%=hdnFlatidsEmailSms.ClientID %>,#<%=hdnFlatids.ClientID %>").val('');
             

                $('#<%=drpflatNumbersmsemail.ClientID %> option').remove();
                $("#<%=drpflatNumbersmsemail.ClientID %>").multiselect('rebuild');
                getFlatNoByPropertyType();
                HideDiv();
            });


            $("#<%=DrpSelectCriteria.ClientID %>").on("change", function () {

                var SelectCriteria = document.getElementById('<%=DrpSelectCriteria.ClientID %>');
                SelectCriteria = SelectCriteria.options[SelectCriteria.selectedIndex].value;

                if (SelectCriteria == "SMS") {
                    $(".sendsmsemails").show("slow");
                    $(".sendsms").show("slow");
                    $(".sendemails").hide("slow");
                    clear();

                }

                else if (SelectCriteria == "EMAIL") {
                    $(".sendsmsemails").show("slow");
                    $(".sendsms").hide("slow");
                    $(".sendemails").show("slow");
                    clear();
                }

                else if (SelectCriteria == "0")
                {
                    $(".sendsmsemails").hide("slow");
                    $(".sendsms").hide("slow");
                    $(".sendemails").hide("slow");
                    clear();
                }
            });

        });


        function clear() {
            $('#<%=hdnFlatidsEmailSms.ClientID %>,#<%=txtEmailDescription.ClientID %>,#<%=txtsmsmessage.ClientID %>,#<%=txttosmsemail.ClientID %>,#<%=txtsubjectsmsemail.ClientID %>').val('');
            $("#<%=drpPropertyTypesendsmsemail.ClientID %>").val(0);

            $("#<%=hdnFlatidsEmailSms.ClientID %>,#<%=hdnFlatids.ClientID %>").val('');

            $('#<%=drpflatNumbersmsemail.ClientID %> option').remove();
            $("#<%=drpflatNumbersmsemail.ClientID %>").multiselect('rebuild');
        }


        function getFlatNoByPropertyType() {
            var f = document.getElementById('<%=drpPropertyTypesendsmsemail.ClientID %>');
            PropertyType = f.options[f.selectedIndex].value;
            if (PropertyType != "0") {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MaintenanceCalculation.aspx/getFlatNoByPropertyType",
                    data: "{'PropertyType':'" + PropertyType + "'}",
                    dataType: "json",
                    success: function (response) {

                        var items;

                        $('#<%=drpflatNumbersmsemail.ClientID %> option').remove();
                        $("#<%=drpflatNumbersmsemail.ClientID %>").multiselect('rebuild');
                        var Result = jQuery.parseJSON(response.d);
                        if (Result.length > 0) {
                            $.each(Result, function (key, val) {
                                $("#<%=drpflatNumbersmsemail.ClientID %>").append('<option value="' + val.FlatId + '">' + val.FlatNumber + '</option>');
                            });
                            $("#<%=drpflatNumbersmsemail.ClientID %>").multiselect('rebuild');
                        }
                        else {
                            alert("No record Found");
                            HideDiv();
                        }
                    },
                    error: function (Result) {
                        alert("Error");
                        HideDiv();
                    }
                });
            }

        }


        function GetFlatIds(identifier) {

            if (identifier == "pdf") {
                $('#<%=hdnFlatids.ClientID %>').val('');
                var Flat_ID = [];
                $('#<%=drpFlatIdPdf.ClientID %> option:selected').each(function () {
                    Flat_ID.push(this.value);
                });

                var FlatID = Flat_ID.toString();
                if (FlatID.charAt(0) == ",") {
                    FlatID = MainID.substr(1);
                }

                $('#<%=hdnFlatids.ClientID %>').val(FlatID);
            }
            else if (identifier == "smsemail") {

                $('#<%=hdnFlatidsEmailSms.ClientID %>').val('');
                var Flat_ID = [];
                $('#<%=drpflatNumbersmsemail.ClientID %> option:selected').each(function () {
                    Flat_ID.push(this.value);
                });

                var FlatID = Flat_ID.toString();
                if (FlatID.charAt(0) == ",") {
                    FlatID = MainID.substr(1);
                }

                if (FlatID != "") {
                    InsertTomailsms(identifier, FlatID);
                }
                else {
                    bootbox.alert("Please select Flats");
                }
                $('#<%=hdnFlatidsEmailSms.ClientID %>').val(FlatID);
            }
        }

        function InsertTomailsms(identifier, FlatID) {

            var Action = document.getElementById('<%=DrpSelectCriteria.ClientID %>');
            Action = Action.options[Action.selectedIndex].value;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCalculation.aspx/GetSmsEmils",
                data: "{'Action':'" + Action + "','FlatIDs':'" + FlatID + "'}",
                dataType: "json",
                success: function (response) {
                    $('#<%=txttosmsemail.ClientID %>').val('');
                    $('#<%=hdnSendername.ClientID %>').val('');
                    if (response.d != "") {
                        var Result = jQuery.parseJSON(response.d);
                        if (Result.Table[0].Opt == "EMAIL") {
                            $('#<%=txttosmsemail.ClientID %>').val(Result.Table[0].EmailIds);
                        }
                        else if (Result.Table[0].Opt == "SMS") {
                            $('#<%=txttosmsemail.ClientID %>').val(Result.Table[0].MobileNos);
                        }

                        $('#<%=hdnSendername.ClientID %>').val(Result.Table[0].SenderName);
                    }
                    else {
                        bootbox.alert("No Record Found");
                    }

                },
                error: function (Result) {
                    alert("Error");
                }
            });

        }

        function FillFlatList() {
            var BuildingId = document.getElementById('<%=DrpBuildingID.ClientID %>').value;

            if (BuildingId != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "MaintenanceCalculation.aspx/GetFlatList",
                    data: "{'BuildingId':'" + BuildingId + "'}",
                    dataType: "json",
                    success: AjaxSucceeded,
                    error: function (Result) {
                        alert("Error");
                    }
                });
            }

        }

        function AjaxSucceeded(response) {
            var items;

            $('#<%=drpFlatIdPdf.ClientID %> option').remove();
            $("#<%=drpFlatIdPdf.ClientID %>").multiselect('rebuild');
            var Result = jQuery.parseJSON(response.d);
            if (Result.length > 0) {
                $.each(Result, function (key, val) {
                    $("#<%=drpFlatIdPdf.ClientID %>").append('<option value="' + val.FlatId + '">' + val.Name + '</option>');
                });
                $("#<%=drpFlatIdPdf.ClientID %>").multiselect('rebuild');
            }
            else {
                alert("No record Found");
            }

        }

        function ValidateGeneratePdf() {

            var propertyTypepdf = document.getElementById('<%=drppropertyTypepdf.ClientID %>');
            propertyTypepdf = propertyTypepdf.options[propertyTypepdf.selectedIndex].value;

            var BuildingID = document.getElementById('<%=DrpBuildingID.ClientID %>');
            BuildingID = BuildingID.options[BuildingID.selectedIndex].value;
            var FlatIdPdf = document.getElementById('<%=hdnFlatids.ClientID %>').value;
            var frommonth = document.getElementById('<%=txtfrommonth.ClientID %>').value;
            var fromyear = document.getElementById('<%=txtfromyear.ClientID %>').value;

            if (propertyTypepdf == "") {
                bootbox.alert("Please Select Property Type");
                return false;
            }
            else if (BuildingID == "") {
                bootbox.alert("Please Select Building Name");
                return false;
            }
            else if (FlatIdPdf == "") {
                bootbox.alert("Please Select Flat");
                return false;
            }
            else if (frommonth == "") {
                bootbox.alert("Please Select Month");
                return false;
            }
            else if (fromyear == "") {
                bootbox.alert("Please Select Year");
                return false;
            }
            return true;
        }


        function ValidateSmSEmails(identifier)
        {
            var PropertyTypesendsmsemail = document.getElementById('<%=drpPropertyTypesendsmsemail.ClientID %>');
            PropertyTypesendsmsemail = PropertyTypesendsmsemail.options[PropertyTypesendsmsemail.selectedIndex].value;

            var tosmsemail = document.getElementById('<%=txttosmsemail.ClientID %>').value;

            var hdnFlatids = document.getElementById('<%=hdnFlatids.ClientID %>').value;
            if (PropertyTypesendsmsemail == "0") {
                bootbox.alert("Please Select Property Type");
                return false;
            }



            if (identifier == "SMS") {

                var smsmessage = document.getElementById('<%=txtsmsmessage.ClientID %>').value;
                if (hdnFlatids == "" && tosmsemail == "") {
                    bootbox.alert("Please Select Flat Number");
                    return false;
                }

                
                else if (smsmessage == "") {
                    bootbox.alert("Please Enter Sms  Message");
                    return false;
                }

            }
            else if (identifier == "EMAIL") {

                var subjectsmsemail = document.getElementById('<%=txtsubjectsmsemail.ClientID %>').value;
                var EmailDescription = document.getElementById('<%=txtEmailDescription.ClientID %>').value;
                if (hdnFlatids == "" && tosmsemail == "")
                 {
                    bootbox.alert("Please Select Flat Number");
                    return false;
                }

                else if (tosmsemail == "") {
                    bootbox.alert("Please Enter Email Address");
                    return false;
                }

                if (subjectsmsemail == "") {
                    bootbox.alert("Please Enter EmailID");
                    return false;
                }
                else if (EmailDescription == "") {
                    bootbox.alert("Please Enter Email Description");
                    return false;
                }
            }
            return true;
        }

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
                target: '.Main_Collection',
                boxed: true,
                message: 'Processing...'
            });


        }

        function HideDiv() {
            window.setTimeout(function () {
                Society.unblockUI('.Main_Collection');
            }, 1000);
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
    <!-- BEGIN PAGE HEADER-->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Finance</a> <i class="fa fa-angle-right"></i></li>
            <li>Maintenance Calculation </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                <!--End button-->
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="portlet light bg-inverse">
          
                    <!-- BEGIN FORM-->
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject font-blue-hoki bold uppercase">Maintenance Collection</span>
                            <span class="caption-helper"></span>
                        </div>
                    </div>
                    <div class="clearfix" style="padding-bottom: 10px;">
                    </div>
                    <div style="" class="portlet-body form">
                        <div class="form-horizontal">
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
                            <div class="form-group Maincollection">
                                <label class="control-label  col-md-3">
                                </label>
                                <div class="col-md-9">
                                    <asp:Button ID="btnMaintenanceCalculation" class="btn red small" runat="server" Text="Calculate Maintenance"
                                        OnClick="btnMaintenanceCalculation_Click" />
                                
                                </div>
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="lblStatus" runat="server" Visible="false" ForeColor="Red"></asp:Label></div>
                    </div>
            
            </div>
        </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="portlet light bg-inverse">
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject font-blue-hoki bold uppercase">PDF Generate Monthly
                            </span><span class="caption-helper"></span>
                        </div>
                    </div>
                    <div class="clearfix" style="padding-bottom: 10px;">
                    </div>
                    <!-- BEGIN FORM-->
                    <div style="" class="portlet-body form">
                        <div class="form-horizontal">
                            <div class="form-group ">
                                <label class="control-label  col-md-3">
                                    Property Type</label>
                                <div class="col-md-9">
                                    <asp:DropDownList class="form-control input-large" ID="drppropertyTypepdf" runat="server">
                                        <asp:ListItem Selected="True" Value="0" Text="--Select--"></asp:ListItem>
                                        <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                        <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Building Name
                                </label>
                                <div class="col-md-9">
                                    <asp:DropDownList ID="DrpBuildingID" class="select2 form-control input-large" onchange="FillFlatList();"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Flat Number</label>
                                <div class="col-md-9">
                                    <asp:ListBox ID="drpFlatIdPdf" class="SelectBox form-control input-large" SelectionMode="Multiple"
                                        runat="server"></asp:ListBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label  col-md-3">
                                   SelectMonth/ Year  </label>
                                <div class="col-md-9">
                                <span Style=" margin:0px 9px; padding-right:10px; float:left">Month</span> 
                                    <asp:TextBox ID="txtfrommonth" class="datepickermonth form-control input-small float"
                                        Style="width: 80px !important;  margin:0px 15px; padding-right:10px; float:left" placeholder="Month" runat="server"></asp:TextBox>
                                       <span Style="margin:0px 9px; padding-right:10px; float:left">Year</span> 
                                        <asp:TextBox ID="txtfromyear" class="datepickeryear form-control input-small float"
                                        Style="width: 80px !important; margin:0px 15px; float:left" placeholder="Year" runat="server"></asp:TextBox>
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <div class="Maincollection">
                                    <label class="control-label  col-md-3">
                                    </label>
                                    <asp:Button ID="btnGeneratePdf" class="btn red small" runat="server" Text="Generate Pdf"
                                        OnClientClick="javascript:return ValidateGeneratePdf();" OnClick="btnGeneratePdf_Click" />
                                </div>
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red"></asp:Label></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="portlet light bg-inverse">
                    <div class="portlet-title">
                        <div class="caption">
                            <span class="caption-subject font-blue-hoki bold uppercase">Send Email / Send Sms
                            </span><span class="caption-helper"></span>
                        </div>
                    </div>
                    <div class="clearfix" style="padding-bottom: 10px;">
                    </div>
                    <!-- BEGIN FORM-->
                    <div style="" class="portlet-body form">
                        <div class="form-horizontal">
                            <div class="form-group ">
                                <label class="control-label  col-md-3">
                                    Select
                                </label>
                                <div class="col-md-9">
                                    <asp:DropDownList class="form-control input-large" ID="DrpSelectCriteria" runat="server">
                                        <asp:ListItem Selected="True" Value="0" Text="--Select--"></asp:ListItem>
                                        <asp:ListItem Value="SMS" Text="Send Sms"></asp:ListItem>
                                        <asp:ListItem Value="EMAIL" Text="Send Email"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="form-horizontal sendsmsemails Main_Collection" style="display: none">
                            <div class="form-group ">
                                <label class="control-label  col-md-3">
                                    Property Type</label>
                                <div class="col-md-9">
                                    <asp:DropDownList class="form-control input-large" ID="drpPropertyTypesendsmsemail"
                                        runat="server">
                                        <asp:ListItem Selected="True" Value="0" Text="--Select--"></asp:ListItem>
                                        <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                        <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Flat Number</label>
                                <div class="col-md-9">
                                    <asp:ListBox ID="drpflatNumbersmsemail" class="SelectBox1 form-control input-large"
                                        SelectionMode="Multiple" runat="server"></asp:ListBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Send To</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txttosmsemail" class="form-control" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-horizontal sendsms" style="display: none">
                            <div class="form-group ">
                                <label class="control-label  col-md-3">
                                    Enter Sms Text</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtsmsmessage" Rows="5" class="form-control" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="Maincollection">
                                    <label class="control-label  col-md-3">
                                    </label>
                                    <asp:Button ID="btnSendSms" class="btn red small" runat="server" Text="SendSms" OnClientClick="javascript:return ValidateSmSEmails('SMS')"
                                        OnClick="btnSendSms_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="form-horizontal sendemails" style="display: none">
                            <div class="form-group ">
                                <label class="control-label  col-md-3">
                                    Subject</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtsubjectsmsemail" class="form-control" Rows="2" TextMode="MultiLine"
                                        runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-horizontal sendemails" style="display: none">
                                <div class="form-group ">
                                    <label class="control-label  col-md-3">
                                        Email Description</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtEmailDescription" class="form-control html-editor" Rows="7" TextMode="MultiLine"
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="Maincollection">
                                        <label class="control-label  col-md-3">
                                        </label>
                                        <asp:Button ID="btnsendEmail" class="btn red small" runat="server" Text="Send Email"
                                            OnClick="btnsendEmail_Click" OnClientClick="javascript:return ValidateSmSEmails('EMAIL')" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hdnFlatids" Value="" runat="server" />
            <asp:HiddenField ID="hdnFlatidsEmailSms" Value="" runat="server" />
            <asp:HiddenField ID="hdnSendername" Value="" runat="server" />
</asp:Content>
