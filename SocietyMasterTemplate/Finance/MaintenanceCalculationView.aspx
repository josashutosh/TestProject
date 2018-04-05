<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masterview.Master" AutoEventWireup="true"
    CodeBehind="MaintenanceCalculationView.aspx.cs"  EnableEventValidation="false" Inherits="EsquareMasterTemplate.Finance.MaintenanceCalculationView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});

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



            $('#<%=drpBuildingid.ClientID%>').change(function () {
                showdiv();
                getFlatsbyBuildname();
                HideDiv();
            });

        });


        function getFlatsbyBuildname() {

            var B = document.getElementById('<%=drpBuildingid.ClientID %>');
            var BuildingId = B.options[B.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollectionView.aspx/getFlatsbyBuildName",
                data: "{'BuildingId':'" + B.options[B.selectedIndex].value + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);


                    $('#<%=drpFlatID.ClientID %>').empty();
                    if (Result.length > 0) {
                        for (var i = 0; i < Result.length; i++) {
                            // $('#<%=drpFlatID.ClientID %>').options[i] = null;
                            $('#<%=drpFlatID.ClientID %>').append("<option value=" + Result[i].FlatId + ">" +
                          Result[i].FlatNumber + "</option>");
                        }
                    }
                    $('#<%=drpFlatID.ClientID %>').prepend("<option value='' selected='selected'>-Select Flat Number--</option>");


                },
                error: function (Result) {
                    alert("Error");
                }
            });

        }

        function GetCollectionId(eve) {

            var hdnMaintenanceId = $('#' + eve).parents('tr').find('input[name$=hdnMaintenanceId]').val();
            var hdnResidentialCollID = $('#' + eve).parents('tr').find('input[name$=hdnResidentialCollID]').val();
            var hdnpropertyType = $('#' + eve).parents('tr').find('input[name$=hdnpropertyType]').val()
            var hdnTo = $('#' + eve).parents('tr').find('input[name$=hdnTo]').val()
            var hdnFrom = $('#' + eve).parents('tr').find('input[name$=hdnFrom]').val()

            $('#<%=hidnMaintenanceId.ClientID %>').val(hdnMaintenanceId);
            $('#<%=hidnResidentialCollID.ClientID %>').val(hdnResidentialCollID);
            $('#<%=hidnpropertyType.ClientID %>').val(hdnpropertyType);

            $('#DeleteMaintenanceCollection').modal('show');
            $('#headMaintenanaceColFromTo').html(hdnFrom + " To " + hdnTo);


            return false;
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
                target: '.Maincollection',
                boxed: true,
                message: 'Processing...'
            });


        }

        function HideDiv() {
            window.setTimeout(function () {
                Society.unblockUI('.Maincollection');
            }, 1000);
        }
    </script>
    <script type="text/javascript" language="javascript">

        function ValidateDel() {
            var res = confirm('are you sure you want to delete ?');
            if (res == false) {
                return false;
            }
            return true;
        }

        function ValidateMultiDelete() {
            // var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
            var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
            if (hdnAllID.value === "") {
                alert('No items were selected!');
                return false;
            }
            else {
                var res = confirm('Are you sure you want to delete?');
                if (res === false) {
                    return false;
                }
                else {
                    return true;
                }
            }
        }


    </script>
    <style>
        .datepicker table td span
        {
            display: block !important;
        }
        .float
        {
            float: left !important;
            padding: 4px !important;
        }
        .datepicker-years, .datepicker-month
        {
            height: 200px;
            overflow: scroll;
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
            <li><a href="../Masters/MaintenanceCalculationView.aspx">Maintenance View</a> </li>
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
            <div class="portlet light bg-inverse">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-equalizer font-red-sunglo"></i><span class="caption-subject font-red-sunglo bold uppercase">
                            Search</span>
                    </div>
                    <div class="tools">
                        <asp:Button ID="btnCollmaster" class="btn red small" runat="server" Text="Add" OnClick="btnAddCollmaster_Click" />
                        <a title="" data-original-title="" href="" class="collapse"></a></a> <%--<a title=""
                            data-original-title="" href="" class="remove"></a>--%>
                    </div>
                </div>
                <div style="" class="portlet-body form">
                    <!-- BEGIN FORM-->
                    <div class="Maincollection">
                        <div class="form-body">
                            <div class="form-group float input-medium">
                                <label class="control-label">
                                    Property Type</label>
                                <asp:DropDownList class="form-control" placeholder="" ID="drpPropertytype"
                                    runat="server">
                                    <asp:ListItem Selected="True" Value="" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                    <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group float input-medium">
                                <label class="control-label" style="width: 200px !important">
                                    building Name</label>
                                <asp:DropDownList ID="drpBuildingid" class="select2 form-control" runat="server">
                                </asp:DropDownList>
                            </div>
                            <!--/span-->
                            <div class="form-group float input-medium" style="width: 200px !important">
                                <label class="control-label">
                                    Flat Number</label>
                                <asp:DropDownList ID="drpFlatID" class="select2 form-control" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group float input-medium" style="width: 200px !important">
                                <label class="control-label">
                                    Maintenanace From</label></br>
                                <asp:TextBox ID="txtfrommonth" class="datepickermonth form-control input-small float"
                                    Style="width: 80px !important;" placeholder="Month" runat="server"></asp:TextBox>
                                <asp:TextBox ID="txtfromyear" class="datepickeryear form-control input-small float"
                                    Style="width: 80px !important; margin-right: 4px;" placeholder="Year" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group float input-medium" style="width: 200px !important">
                                <label class="control-label">
                                    Maintenanace To</label></br>
                                <asp:TextBox ID="txtTomonth" class="datepickermonth form-control input-small float"
                                    Style="width: 80px !important;" placeholder="Month" runat="server"></asp:TextBox>
                                <asp:TextBox ID="txtToyear" class="datepickeryear form-control input-small float"
                                    Style="width: 80px !important; margin-right: 4px;" placeholder="Year" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group float input-small" style="width: 200px !important">
                                <label class="control-label" style="display: block">
                                </label>
                                </br>
                                <asp:Button ID="btnCancel" class="btn btn-sm red" runat="server" Text="Cancel" />
                                <asp:Button ID="btnSearch" class="btn btn-sm green" runat="server" Text="Search"
                                    OnClick="btnSearch_Click" />
                            </div>
                            <!--/row-->
                        </div>
                    </div>
                    <!-- END FORM-->
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="Div2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Maintenance View</span> <span class="caption-helper"></span>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- Begin Toolbar-->
                        <div class="table-toolbar">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="btn-group">
                                        <%--<asp:Button ID="btnDelete" style="display:none !important;" 
                                                class="btn btn-sm red" OnClientClick="javascript:return ValidateMultiDelete();" runat="server" Text="Delete" onclick="btnDelete_Click1" />--%>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="btn-group pull-right">
                                        <!--End button-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End ToolBar-->
                        <!-- BEGIN list View-->
                        <div class="table-responsive">
                            <asp:ListView ID="lvMstr" class="table-responsive" runat="server" GroupPlaceholderID="groupPlaceHolder1"
                                ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="OnPagePropertiesChanging">
                                <LayoutTemplate>
                                    <table id="Main_lvMstr" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>
                                                    Flat Number
                                                </th>
                                                <th>
                                                    PropertyType
                                                </th>
                                                <th>
                                                    Paid Amount
                                                </th>
                                                <th>
                                                    Paid Type
                                                </th>
                                                <th>
                                                    From
                                                </th>
                                                <th>
                                                    TO
                                                </th>
                                                <th>
                                                    Action
                                                </th>
                                            </tr>
                                        </thead>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        <tr>
                                            <td colspan="4">
                                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvMstr" QueryStringField="page"
                                                    PageSize="20">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                            ShowNextPageButton="false" ButtonCssClass="btn btn-xs red" />
                                                        <asp:NumericPagerField ButtonType="Link" NumericButtonCssClass="btn default" />
                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false"
                                                            ShowPreviousPageButton="false" ButtonCssClass="btn btn-xs green" />
                                                    </Fields>
                                                </asp:DataPager>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <GroupTemplate>
                                    <tr>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                    </tr>
                                </GroupTemplate>
                                <ItemTemplate>
                                    <td>
                                        <div id="wrapperDivHidden" class="wrapperDivHidden">
                                            <asp:HiddenField ID="hdnMaintenanceId" Value='<%#Eval("MaintenanceId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnResidentialCollID" Value='<%#Eval("CollectionId") %>' runat="server" />
                                            <asp:HiddenField ID="hdnpropertyType" Value='<%#Eval("PropertyType") %>' runat="server" />
                                            <asp:HiddenField ID="hdnFrom" Value='<%# Eval("EffectiveFrom" , "{0:d}")%>' runat="server" />
                                            <asp:HiddenField ID="hdnTo" Value='<%# Eval("EffectiveTo" , "{0:d}")%>' runat="server" />
                                        </div>
                                        <%# Eval("FlatNumber")%>
                                    </td>
                                    <td>
                                        <%# Eval("PropertyType")%>
                                    </td>
                                    <td>
                                        <%# Eval("PaidAmount")%>
                                    </td>
                                    <td>
                                        <%# Eval("PaymentType")%>
                                    </td>
                                    <td>
                                        <%# Eval("EffectiveFrom" , "{0:d}")%>
                                    </td>
                                    <td>
                                        <%# Eval("EffectiveTo" , "{0:d}")%>
                                    </td>
                                    <td>
                                      <%--  <asp:HyperLink ID="HyperLink1" class="btn green btn-sm" NavigateUrl='<%#"~/Finance/MaintenanceCollection.aspx?PId=14&amp;Ptype="+ Eval("[PropertyType]").ToString()+"&amp;ColId=" + Eval("[CollectionId]").ToString()%>'
                                            runat="server">Edit</asp:HyperLink>--%>
                                        <%--      <asp:LinkButton runat="server" OnClick="Content_Load" class="btn" ID="deletelinkbutton">Delete</asp:LinkButton>--%>
                                        <asp:Button ID="btnMaintenanceDelete" class="btn red small" OnClientClick="javascript:return GetCollectionId(this.id)"
                                            runat="server" Text="Delete" />
                                        <%-- <asp:Button ID="Button1" runat="server" OnClientClick="ValidateDel(); return false;" Text="delete Delete" />--%>
                                    </td>
                                </ItemTemplate>
                            </asp:ListView>
                            <input id="hdnAllID" type="hidden" runat="server" />
                        </div>
                        <!-- END list View-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="DeleteMaintenanceCollection" class="modal fade" data-backdrop="static" data-keyboard="false"
        tabindex="-1" data-width="760">
        <div class="modal-dialog">
            <div class="modal-content">
                <div id="Div1" class="Main_Collection_Socity">
                    <div class="modal-header" id="Div3" runat="server" clientidmode="Static" style="height: 50px !important">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        </button>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <h4 class="modal-title">
                                    Delete Maintenance Collection
                                </h4>
                            </div>
                            <div class="col-md-6">
                                <h4 id="headMaintenanaceColFromTo" class="modal-title">
                                </h4>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="modal-body">
                        <div class="portlet-body form" id="basic">
                            <!-- BEGIN FORM-->
                            <div id="Main_Collection" class="form-horizontal form-bordered form-row-stripped">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Remark</label>
                                        <div class="col-md-9">
                                            <asp:HiddenField ID="hidnMaintenanceId" Value='' runat="server" />
                                            <asp:HiddenField ID="hidnResidentialCollID" Value='' runat="server" />
                                            <asp:HiddenField ID="hidnpropertyType" Value='' runat="server" />
                                            <asp:TextBox ID="txtRemark" TextMode="MultiLine" Rows="15" Columns="50" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-actions">
                                        <div class="row">
                                            <div class="col-md-offset-3 col-md-9">
                                                <a href="#" class="btn" data-dismiss="modal">Close</a>
                                                <asp:Button ID="btndelete" class="btn red small" OnClick="btndelete_Click" OnClientClick="javascript:return ValidateDel();"
                                                    runat="server" Text="Delete" />
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
    </div>
</asp:Content>
