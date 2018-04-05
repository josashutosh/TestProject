<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="SocietyMaintenanceInfo.aspx.cs" Inherits="EsquareMasterTemplate.Masters.SocietyMaintenanceInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    function validate() {

        var powerbill = document.getElementById('<%=txtPowerbill.ClientID%>').value;
        var watercharge = document.getElementById('<%=txtWaterCharges.ClientID%>').value;
        var securitycharge = document.getElementById('<%=txtSecuritycharge.ClientID%>').value;
        var housekeeping = document.getElementById('<%=txtHousekeepingsal.ClientID%>').value;
        var managersal = document.getElementById('<%=txtManagersalary.ClientID%>').value;
        var stationary = document.getElementById('<%=txtStationary.ClientID%>').value;
        var dgsetexpense = document.getElementById('<%=txtDgsetexpense.ClientID%>').value;
        var instructor = document.getElementById('<%=txtgyminspector.ClientID%>').value;
        var communityhall = document.getElementById('<%=txtCommunityhall.ClientID%>').value;

        var repayment = document.getElementById('<%=txtRepayment.ClientID%>').value;
        var othercharges = document.getElementById('<%=txtOtherCharges.ClientID%>').value;
        var supervisor = document.getElementById('<%=txtSupervisor.ClientID%>').value;


        if(powerbill =="")
        {
        bootbox.alert("Please Enter Power bill");
            return false;
        }
        if (watercharge == "") {
            bootbox.alert("Please Enter Water Charges");
            return false;
        }
        if (housekeeping == "") {
            bootbox.alert("Please Enter Housekeeping Charges");
            return false;
        }

        if (managersal == "") {
            bootbox.alert("Please Enter Manager Salary");
            return false;
        }
        if (stationary == "") {
            bootbox.alert("Please Enter Stationary Charges");
            return false;
        }
        if (dgsetexpense == "") {
            bootbox.alert("Please Enter DG Set Expenses");
            return false;
        }

        if (supervisor == "") {
            bootbox.alert("Please Enter Supervisor Salary");
                return false;
        }
        return true;
    }
</script>
<script type="text/javascript">

  
    $( document ).ready(function() {
        function focus() {
            document.getElementById('MainContent_txtTotal').focus;
        }
});

</script>


<script type="text/javascript">

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

        function totalsum(r) {
            document.getElementById('<%=txtSecuritycharge.ClientID %>').focus;
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
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Finance/SocietyMaintenanceInfo.aspx">Society Monthly Expenses</a> </li>
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
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Society Monthly Expenses</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash"></i></a>--%>
                        </div>
                    </div>
                   
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-row-stripped form-label-stripped">
                           
                            <%--//********************************************************************************************************************************//--%>
                            <div class="form-body" runat="server" id="FlatMonthlyFee">
                                <h3 class="form-section"></h3>
                                <!--row1-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Power Charges</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtPowerbill" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtWaterCharges" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                Security guards salary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtSecuritycharge" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                    class="form-control" AutoComplete="off" rel="popover" data-content="Housekeeping salary"
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
                                                <asp:TextBox ID="txtManagersalary" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Manager Salary" runat="server" onblur="totalsum(this.value);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Stationary</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtStationary" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtDgsetexpense" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtgyminspector" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtCommunityhall" class="form-control" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtRepayment" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                Miscellaneous</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtOtherCharges" class="form-control" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtSupervisor" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
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
                                                <asp:TextBox ID="txtTotal" class="form-control" AutoComplete="off" 
                                                    runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/row10-->
                        </div>
                    
                    <!---********************************************************************************************************************************/-->
                    <div class="form-horizontal form-bordered form-row-stripped" runat="server" id="SumTotal"
                        style="display: none;">
                        <div class="form-body">
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Total Number of Flats</label>
                                <div class="col-md-9">
                                    <label id="txtTotalNoFlat" class="form-control" runat="server">
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Maintenance / Month</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtMainpermoth" class="form-control" AutoComplete="off" rel="popover"
                                        data-content="Maintenance / Month" runat="server"></asp:TextBox>
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
                                        <asp:TextBox ID="txtPerSquareFeetRate" class="form-control" AutoComplete="off" rel="popover"
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
                    
                    <!---********************************************************************************************************************************/-->
                    
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="date">
                        <!--row1-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        From Date</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtEffectiveFromDateM" class="date1 form-control" AutoComplete="off"
                                            rel="popover" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                            <div class="col-md-6" runat="server" id="EffectiveDatespan" >
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        To Date</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="EffectiveToDate" class="date2 form-control" AutoComplete="off" rel="popover"
                                            runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row1-->
                    </div>
                    <br>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-9">
                                <asp:Button ID="btnmensubmit" runat="server" Text="Submit" OnClientClick="javascript:return validate();"
                                    class="btn btn-success" onclick="btnmensubmit_Click"/>
                                <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" />
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
