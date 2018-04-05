<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="MaintenanceMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.MaintenanceMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var total; var Charges, totalperflat, numberFlat;
        $(document).ready(function () {
            var date;
            $(".select2").select2({ maximumSelectionSize: 1 });
            showdiv();
            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
            //$('.date1').datepicker({
            //    format: 'dd/mm/yyyy',
            //    autoclose: true,
            //    //keyboardNavigation:true,
            //    todayBtn: true,
            //    todayHighlight: true,
            //    clearBtn: true,
            //    beforeShowDay: function (date) {
            //        var day = date.getDay();
            //        return [(day != 1 && day != 2)];
            //    }
            //});
                         
            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});

        });

        $(function () {
           
            $('.date1').datepicker({
                format: "dd/mm/yyyy",
                weekStart: 1,
                todayBtn: true,
                orientation: "bottom right",
                calendarWeeks: true,
                autoclose: true,
                todayHighlight: true,
                beforeShowDay: function (date) {

                    if (date.getDate() != 1) {
                       
                        return false;
                    }

                    if (date.getDate = 1)
                    {
                        return {
                            tooltip: 'Example tooltip',
                            classes: 'active'
                        };
                    }
                }
            });

            
            $('.date2').datepicker({
                format: "dd/mm/yyyy",
                weekStart: 1,
                todayBtn: true,
                orientation: "bottom right",
                calendarWeeks: true,
                autoclose: true,
                todayHighlight: true,
                beforeShowDay: function (date) {

                    if (date.getDate() != 31) {

                        return false;
                    }

                    if (date.getDate = 31) {
                        return {
                            tooltip: 'Example tooltip',
                            classes: 'active'
                        };
                    }
                }
            });
            
        });



        //decimal number (200.36)
        //onkeypress = "return restrict(this.value, event)" 
        function restrict(val, e) {
            var keyChar;
            if (window.event)
                keyChar = String.fromCharCode(window.event.keyCode);
            else if (e)
                keyChar = String.fromCharCode(e.which);
            else
                return true;
            var number = parseFloat(val + keyChar);
            if (number != val + keyChar)
                return false;
            else
                return true;
        }

        function validate() {
            var propertytype, CalcType, fromdate;
            propertytype = document.getElementById('<%=drpPropertytype.ClientID %>').value;
            CalcType = document.getElementById('<%=drpCalcMethod.ClientID %>').value;
            fromdate = document.getElementById('<%=txtEffectiveFromDateM.ClientID %>').value;
            if (propertytype == "") {
                bootbox.alert("please select property Type..!");
                return false;
            }

            if (CalcType == 0) {
                bootbox.alert("please select maintenance calculation Method..!");
                return false;
            }

            if (fromdate == "") {
                bootbox.alert("please Enter From Date..!");
                return false;
            }

            if (CalcType == 1) {
                var powerbill = document.getElementById('<%=txtPowerbill.ClientID%>').value;
                var watercharge = document.getElementById('<%=txtWaterCharges.ClientID%>').value;
                var housekeeping = document.getElementById('<%=txtHousekeepingsal.ClientID%>').value;
                var total = document.getElementById('<%= txtTotal.ClientID%>').value;
                var totalflat = document.getElementById('<%=txtTotalNoFlat.ClientID%>').Value;
                
                if (powerbill == "0" || powerbill == "")
                {
                    bootbox.alert("Please Enter Power bill..!");
                    return false;
                }
                if (watercharge == "0" || watercharge == "") {
                    bootbox.alert("Please Enter Water Charges..!");
                    return false;
                }
                if (housekeeping == "0" || housekeeping == "") {
                    bootbox.alert("Please Enter Housekeeping Charges..!");
                    return false;
                }

                if (total == "0" || total == "") {
                    bootbox.alert("Please Check total sum of amount..!");
                    return false;
                }
                if (totalflat == "0" || totalflat == "") {
                    bootbox.alert("Please Enter total number of flats..!");
                    return false;
                }
            }
            return true;
        }


        function totalsum(r) {
            total = document.getElementById('<%=txtTotal.ClientID %>').value;
            numberFlat = document.getElementById('<%=txtTotalNoFlat.ClientID %>').innerHTML;
            if (total == "" || total == 0) {
                total = 0;
            }
            if (r == "") {
                r = parseFloat(0);
            }
            Charges = r;

            total = parseFloat(total) + parseFloat(Charges);
            document.getElementById('<%=txtTotal.ClientID %>').value = parseFloat(total.toFixed(2));

            totalperflat = (parseFloat(total)) / (parseFloat(numberFlat));

            document.getElementById('<%=txtMainpermoth.ClientID %>').value = parseFloat(totalperflat.toFixed(2));

        }

        function showdiv() 
        {
            drpnumparking = document.getElementById('<%=drpCalcMethod.ClientID %>').value;
            if (drpnumparking == 0) 
            {
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "none";
                document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "none";
                document.getElementById('<%=date.ClientID %>').style.display = "none";
            }
            if (drpnumparking == 1) 
            {
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "block";
                document.getElementById('<%=SumTotal.ClientID %>').style.display = "block";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "none";
                document.getElementById('<%=date.ClientID %>').style.display = "block";
            }

            if (drpnumparking == 2) 
            {
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
                document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "block";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "none";
                document.getElementById('<%=date.ClientID %>').style.display = "block";
            }

            if (drpnumparking == 3) 
            {
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
                document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "block";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "none";
                document.getElementById('<%=date.ClientID %>').style.display = "block";
            }

            if (drpnumparking == 4) 
            {
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
                document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "block";
                document.getElementById('<%=date.ClientID %>').style.display = "block";
            }

            if (drpnumparking == 5) 
            {
                document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
                document.getElementById('<%=FlatMonthlyLumpsumFee.ClientID %>').style.display = "block";
                document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
                document.getElementById('<%=PartialFlatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=MixedApproach.ClientID %>').style.display = "none";
                document.getElementById('<%=date.ClientID %>').style.display = "block";
            }
        }


    </script>
    <style type="text/css">
        .popover {
            width: 600px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
  
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Finance/MaintenanceMasterView.aspx">Maintenance Information</a> </li>
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
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Maintenance Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash"></i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-row-stripped form-label-stripped">
                            <div class="form-body">
                                <h3 class="form-section">Property Type</h3>
                                <!--row1-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Property Type</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList class="form-control input-medium" ID="drpPropertytype" runat="server">
                                                    <asp:ListItem Selected="True" Value="" Text="--Select--"></asp:ListItem>
                                                    <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                                    <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                                </asp:DropDownList>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Maintenance Calculation Type</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList class="form-control input-medium" ID="drpCalcMethod" onchange="showdiv();" runat="server">
                                                </asp:DropDownList>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row1-->
                            </div>
                           
                              <%--//********************************************************************************************************************************//--%>
                            <div class="form-body" runat="server" id="FlatMonthlyLumpsumFee">
                                <h3 class="form-section"> Flat Monthly Lumpsum Fee </h3>      
                                 <div class="row">
                                     <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Owner Monthly Maintenance Amount</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpOwnerMonthlyAmount" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Owner's Flat Monthly Charges"
                                                    onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                 Tenant Monthly Maintenance Extra Amount</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpTenantExtraMonthlyAmount" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                rel="popover" data-content="Enter Tenant's Extra Monthly Charges" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                 </div>
                                 <h4 class="form-section">Monthly Expense Details</h4>  
                                  <div class="row">
                                        <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Power Charges</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpPowerCharges" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Power Charges"
                                                    onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Water Charges</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpWaterCharges" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Enter Water Charges" 
                                                    runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                  <div class="row">
                                   <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Security Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpSecuritySalary" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Security gard"
                                                    onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Housekeeping Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpHouseKeepingSalary" onkeypress="return restrict(this.value, event)"
                                                    class="form-control input-medium" AutoComplete="off" rel="popover" data-content="Housekeeping salary"
                                                     runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                               
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                   <div class="row">
                                     <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Manager Salary
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpManagerSalary" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Manager Salary" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Stationary Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpStationaryExpense" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Contribution to the sinking fund" data-original-title="Sinking Fund"
                                                    runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                  <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                DG Set Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpDGSet" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="DG Set Expense" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Gym Instructor Salary
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpGymInstructor" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Gym Instructor Charges" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Community Hall
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpCommunityHall" class="form-control input-medium" onkeypress="return restrict(this.value, event)"
                                                    AutoComplete="off" rel="popover"  data-content="Interest" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Insurance Premium</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpInsurancePremium" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Repayment of the installment of the loan and interest"
                                                    data-original-title="Repayment installment" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <div class="row">
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Miscellaneous Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpMiscellaneousExpenses" class="form-control input-medium" onkeypress="return restrict(this.value, event)"
                                                    AutoComplete="off" onblur="totalsum(this.value);" rel="popover" data-content="Other Charges"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Supervisor Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="Txt_LmpsupervisorSalary" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Repayment of the installment of the loan and interest"
                                                    data-original-title="Repayment installment" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 
                            </div>
                            <div class="form-body" runat="server" id="FlatMonthlyFee">
                                <h3 class="form-section"> Flat Monthly Fee </h3>
                                <!--row1-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Power Charges</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtPowerbill" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Power Charges"
                                                    onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Water Charges</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtWaterCharges" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Enter Water Charges" 
                                                    runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row1-->
                                <!--row2-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Security Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtSecuritycharge" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Security gard"
                                                    onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Housekeeping Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtHousekeepingsal" onkeypress="return restrict(this.value, event)"
                                                    class="form-control input-medium" AutoComplete="off" rel="popover" data-content="Housekeeping salary"
                                                     runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row2-->
                                <!--row3-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Manager Salary
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtManagersalary" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Manager Salary" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Stationary Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtStationary" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Contribution to the sinking fund" data-original-title="Sinking Fund"
                                                    runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row3-->
                                <!--row4-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                DG Set Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtDgsetexpense" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="DG Set Expense" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Gym Instructor Salary
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtgyminspector" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Gym Instructor Charges" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row4-->
                                <!--/row6-->
                                <!--row7-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Community Hall
                                            </label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtCommunityhall" class="form-control input-medium" onkeypress="return restrict(this.value, event)"
                                                    AutoComplete="off" rel="popover"  data-content="Interest" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Insurance Premium</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtRepayment" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Repayment of the installment of the loan and interest"
                                                    data-original-title="Repayment installment" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row7-->
                              
                                <div class="row">
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Miscellaneous Expenses</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtOtherCharges" class="form-control input-medium" onkeypress="return restrict(this.value, event)"
                                                    AutoComplete="off" onblur="totalsum(this.value);" rel="popover" data-content="Other Charges"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Supervisor Salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtSupervisor" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Repayment of the installment of the loan and interest"
                                                    data-original-title="Repayment installment" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->

                                <!--/row9-->
                                <!--row10-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Sum Total</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtTotal" class="form-control input-medium" AutoComplete="off" 
                                                    runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Tenant Monthly Maintenance amount</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtTenantMaintenance" class="form-control input-medium" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                rel="popover" data-content="Enter amount" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/row10-->
                        </div>
                    </div>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-horizontal form-bordered form-row-stripped" runat="server" id="SumTotal"
                        style="display: none;">
                        <div class="form-body">
                             <div class="row">
                                  <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Total Number of Flats</label>
                                <div class="col-md-9">
                                    <label id="txtTotalNoFlat" class="form-control input-medium" runat="server">
                                    </label>
                                </div>
                            </div>
                            </div>
                             <div class="col-md-6">
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Maintenance / Month</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtMainpermoth" class="form-control input-medium" AutoComplete="off"  rel="popover"
                                        data-content="Maintenance / Month" runat="server"></asp:TextBox>

                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    <!--/******************************************************************************************************************************/---->
                    <div class="form-body" runat="server" id="PerSquarefeetrate" style="display: none;">
                        <h3 class="form-section">Per Square feet rate</h3>
                        <!--row1-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Per Square feet rate</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtPerSquareFeetRate" class="form-control input-medium" AutoComplete="off" rel="popover"
                                            data-content="Per Square Feet Rate" runat="server"></asp:TextBox>
                                        <span class="help-block">Per Square feet rate</span>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row1-->
                    </div>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="PartialFlatRate" style="display: none;">
                        <h3 class="form-section">Partial flat rate</h3>
                        <!--row1-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Fixed Sqft</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtFixedSqft" class="form-control input-medium" AutoComplete="off" rel="popover"
                                            data-content="Fixed Sqft" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Fixed rate</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtFixedrate" class="form-control input-medium" AutoComplete="off" rel="popover"
                                            data-content="Fixed Rate" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row1-->
                        <!--row2-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Additional sqft</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtAdditionalsqft" class="form-control input-medium" AutoComplete="off" rel="popover"
                                            data-content="Additional sqft" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Additional sqft Rate</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtAdditionalsqftRate" class="form-control input-medium" rel="popover" data-content="Additional Sqft Rate"
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row2-->
                    </div>
                   
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="MixedApproach" style="display: none;">
                        <h3 class="form-section">Mixed approach</h3>
                    </div>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="date">
                        <!--row1-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        From Date</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtEffectiveFromDateM" class="date1 form-control input-medium" AutoComplete="off"
                                            rel="popover"
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                            <div class="col-md-6" runat="server" id="EffectiveDatespan" style="display: none;">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        To Date</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="EffectiveToDate" class="date2 form-control input-medium" AutoComplete="off" rel="popover"
                                            
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row1-->
                    </div>
                     <br/>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-9">
                                <asp:Button ID="btnmensubmit" runat="server" OnClientClick="javascript:return validate()"
                                    Text="Submit" class="btn btn-success" OnClick="btnmensubmit_Click1" />
                                <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" OnClick="btnBack_Click1" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END FORM-->
            </div>
        </div>
    </div>

    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
