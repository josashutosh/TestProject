<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masterview.Master" AutoEventWireup="true" CodeBehind="MaintenanceMasterView.aspx.cs" Inherits="EsquareMasterTemplate.Masters.MaintenanceMasterView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" language="javascript">
        //       $(document).ready(function () {
        //           // $("table span > span").find("span").css({ "color": "red", "border": "2px solid red" });
        //           $("table span > span").addClass("btn btn-success");
        //       });

        $(document).ready(function () {
            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
        });
        function ValidateDel() {
            var res = confirm('are you sure you want to delete ?');
            if (res == false) {
                return false;
            }
            return true;
        }

        function chkSelectAll() {
            var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
        var rowscount = document.getElementById('Main_lvMainMstr').rows.length;

        for (var i = 0; i <= rowscount - 3; i++) {
            var chkselect = document.getElementById('MainContent_lvMainMstr_ctrl' + i + '_chkselect_' + i);
            var chkAll = document.getElementById('MainContent_lvMainMstr_chkAll');
            var hdnID = document.getElementById('MainContent_lvMainMstr_ctrl' + i + '_hdnmainmstrID_' + i);

            if (chkAll.checked == true) {
                $('#<%=btnDelete.ClientID %>').fadeIn('slow');
                chkselect.checked = true;
                hdnAllID.value = hdnAllID.value + hdnID.value + ',';
            }
            else {
                $('#<%=btnDelete.ClientID %>').fadeOut('slow');
                chkselect.checked = false;
                hdnAllID.value = '';
            }
        }

    }

    function CheckSelect(ID) {
        var chkAll = document.getElementById('MainContent_lvMainMstr_chkAll');
        var hdnID = document.getElementById(ID.replace('chkselect', 'hdnmainmstrID'));
        var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
        var chkIndi = document.getElementById(ID);

        if (chkIndi.checked) {
            $('#<%=btnDelete.ClientID %>').fadeIn('slow');
            hdnAllID.value = hdnAllID.value + hdnID.value + ',';
        }
        else {
            hdnAllID.value = hdnAllID.value.replace(hdnID.value + ',', '');
            if (hdnAllID.value.length == 0) {
                $('#<%=btnDelete.ClientID %>').fadeOut('slow');
            }
        }

        chkAll.checked = false;
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

    function rtnaddzero(a) {
        var a1 = "";
        if (a > 0 && a <= 9) {
            a1 = "0" + a;
            return a1;
        }
        else if (a > 9 || a == 0) {
            a1 = a;
            return a1;
        }
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- BEGIN PAGE HEADER-->

    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/MaintenanceMasterView.aspx">Maintenance Information View</a> </li>
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
            <div class="tab-pane" id="Div1">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Search</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList class="form-control input-small" Style="display: inline !important;" ID="drpPropertytype" runat="server">
                                            <asp:ListItem Value="" Selected="True" Text="--Select--"></asp:ListItem>
                                            <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                            <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:DropDownList class="form-control input-small" Style="display: inline !important;" ID="drpCalcMethod" runat="server">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtEffectivefromDate"  rel="popover" data-content="From Date" Style="display: inline !important;" AutoComplete="off" class="date form-control input-small" runat="server"></asp:TextBox>
                                        <asp:TextBox ID="txtEffectiveToDate" rel="popover" data-content="End Date" Style="display: inline !important;" AutoComplete="off" class="date form-control input-small" runat="server"></asp:TextBox>

                                        <asp:Button class="btn btn-success btn-sm" Style="display: inline !important;" ID="btnSearch" runat="server" Text="Search"
                                            OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnAdd" Style="display: inline !important;"
                                            class="btn btn-success btn-sm" runat="server" Text="Add"
                                            OnClick="btnAdd_Click" />
                                        <asp:Button ID="btncancel" Style="display: inline !important;"
                                            runat="server" class="btn btn-success btn-sm" Text="Cancel"
                                            OnClick="btncancel_Click" />
                                        <span class="help-block">
                                            <p>
                                                <span style="font-size: 14px; color: Red">
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






    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="Div2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Maintenance Information View</span> <span class="caption-helper"></span>
                        </div>

                    </div>
                    <div class="portlet-body form">
                        <!-- Begin Toolbar-->
                        <div class="table-toolbar">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="btn-group">
                                        <asp:Button ID="btnDelete" Style="display: none !important;"
                                            class="btn small red" OnClientClick="javascript:return ValidateMultiDelete();" runat="server" Text="Delete" OnClick="btnDelete_Click1" />
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
                            <asp:ListView ID="lvMainMstr" class="table-responsive" runat="server" GroupPlaceholderID="groupPlaceHolder1"
                                ItemPlaceholderID="itemPlaceHolder1"
                                OnPagePropertiesChanging="OnPagePropertiesChanging">
                                <LayoutTemplate>
                                    <table id="Main_lvMainMstr" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="table-checkbox">

                                                    <asp:CheckBox ID="chkAll" class="group-checkable" onclick="javascript:chkSelectAll();" runat="server" />
                                                </th>

                                                <th>Sr No
                                                </th>
                                                <th>Property Type
                                                </th>
                                                <th>Calculation Method
                                                </th>

                                                <th>Effective From Date
                                                </th>
                                                <th>Effective To Date
                                                </th>
                                                <th>Action
                                                </th>

                                            </tr>
                                        </thead>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        <tr>
                                            <td colspan="4">
                                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvMainMstr" QueryStringField="page" PageSize="20">
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

                                        <asp:CheckBox ID="chkselect" class="group-checkable" onclick="javascript:CheckSelect(this.id);" runat="server" />
                                    </td>

                                    <td>
                                        <asp:HiddenField ID="hdnmainmstrID" Value='<%#Eval("MaintenanceID") %>' runat="server" />
                                        <%# Eval("rownumber")%>
                                    </td>
                                    <td>
                                        <%# Eval("PropertyType")%>
                                    </td>
                                    <td>
                                        <%# Eval("CalculationMethodName")%>
                                    </td>
                                    <td>
                                        <%# Eval("EffectiveFromDate", "{0:d}")%>
                                    </td>
                                    <td>
                                        <%# Eval("EffectiveToDate", "{0:d}")%>
                                    </td>

                                    <td>
                                        <asp:HyperLink ID="HyperLink1" class="btn green btn-sm" NavigateUrl='<%#"~/Finance/MaintenanceMaster.aspx?PId=18&amp;mntnid=" + Eval("[MaintenanceID]").ToString()%>' runat="server">Edit</asp:HyperLink>

                                        <%-- <asp:LinkButton runat="server" OnClick="Content_Load" class="btn" ID="deletelinkbutton">Delete</asp:LinkButton>--%>

                                        <%-- <asp:Button ID="btndelete" class="btn red small" OnClick="btndelete_Click" OnClientClick="javascript:return ValidateDel();" runat="server" Text="Delete" />--%>
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
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->







    </span></span>







</asp:Content>
