<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="MonthlyMaintenanceMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.MonthlyMaintenanceMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


<script type="text/javascript">
    var total; var Charges, totalperflat, numberFlat;
    $(document).ready(function () {
        var date;
        $("#drpFlatID").select2({ maximumSelectionSize: 1 });
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

                if (date.getDate = 1) {
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

    function totalsum(r)
     {
        total = document.getElementById('<%=txtMainpermonth.ClientID %>').value;
       
        if (total == "" || total == 0) {
            total = 0;
        }
        if (r == "") {
            r = parseFloat(0);
        }
        Charges = r;

        total = parseFloat(total) + parseFloat(Charges);
        document.getElementById('<%=txtMainpermonth.ClientID %>').value = parseFloat(total.toFixed(2));

    }



    function validate() {
        var propertytype, Residential, fromdate, ownermaintenance, tenantmaintenace;
        propertytype = document.getElementById('<%=drpPropertytype.ClientID %>').value;
        Residential = document.getElementById('<%=drpCalcMethod.ClientID %>').value;
        ownermaintenance = document.getElementById('<%=txtOwnerMaintenance.ClientID %>').value;
        tenantmaintenace = document.getElementById('<%=txtTenantMaintenance.ClientID %>').value;
        fromdate = document.getElementById('<%=txtEffectiveFromDateM.ClientID %>').value;
        if (propertytype == "") {
            bootbox.alert("please select property Type");
            return false;
        }

        if (Residential == 0) {
            bootbox.alert("please select Residential calculate Method");
            return false;
     }
         if (fromdate == "") {
            bootbox.alert("please Enter From Date");
            return false;
        }
        return true;

    }




    function showdiv() {
        drpnumparking = document.getElementById('<%=drpCalcMethod.ClientID %>').value;
        if (drpnumparking == 0) {
            document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
            document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
            document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
            document.getElementById('<%=date.ClientID %>').style.display = "none";
        }
        if (drpnumparking == "FlatMonthlyFee") {
            document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "block";
            document.getElementById('<%=SumTotal.ClientID %>').style.display = "block";
            document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "none";
            document.getElementById('<%=date.ClientID %>').style.display = "block";
        }

        if (drpnumparking == "PerSquareFeetRate") {
            document.getElementById('<%=FlatMonthlyFee.ClientID %>').style.display = "none";
            document.getElementById('<%=SumTotal.ClientID %>').style.display = "none";
            document.getElementById('<%=PerSquarefeetrate.ClientID %>').style.display = "block";
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


<div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Finance/MonthlyMaintenanceMaster.aspx">Monthly Maintenance Information</a> </li>
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
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Monthly Maintenance Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench"></i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash"></i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-row-stripped form-label-stripped">
                            <div class="form-body">
                                <h3 class="form-section"></h3>
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
                                                Residential Type</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList class="form-control input-medium" ID="drpCalcMethod" onchange="showdiv();" runat="server">
                                                <asp:ListItem Selected="true" Value="0" Text="--Select--"></asp:ListItem>
                                                    <asp:ListItem Value="FlatMonthlyFee" Text="Flat Monthly Fee"></asp:ListItem>
                                                    <asp:ListItem Value="PerSquareFeetRate" Text="Per Square Feet Rate"></asp:ListItem>
                                                </asp:DropDownList>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <!--/row1-->
                            </div>
                           
                            <%--//********************************************************************************************************************************//--%>
                            <div class="form-body" runat="server" id="FlatMonthlyFee" style="display: none;">
                                
                                <!--row1-->
                                <div class="form-horizontal form-bordered form-row-stripped" runat="server" id="Div3">
                        <div class="form-body">
                            
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                   Owner Monthly Maintenance amount</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtOwnerMaintenance" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                           rel="popover" onblur="totalsum(this.value);" data-content="Enter amount" Width="400px" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-horizontal form-bordered form-row-stripped" runat="server" id="Div2">
                        <div class="form-body">
                            
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                   Tenant Monthly Maintenance amount</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtTenantMaintenance" class="form-control" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                   rel="popover" onblur="totalsum(this.value);" data-content="Enter amount" Width="400px" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                                <!--/row1-->
                                
                                <!--row10-->
                                
                            </div>
                            <!--/row10-->
                        </div>


                        <div class="form-horizontal form-bordered form-row-stripped" runat="server" id="SumTotal">
                        <div class="form-body">
                            
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                   Monthly Maintenance</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtMainpermonth" class="form-control" AutoComplete="off" rel="popover"
                                        data-content="Monthly Maintenance" Width="400px" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                   



                    
                    <!---********************************************************************************************************************************/-->
                    
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
                                        
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <!--/row1-->
                    </div>
                 
                    <!---********************************************************************************************************************************/-->
                    
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="MixedApproach" style="display: none;">
                        <h3 class="form-section">Mixed approach</h3>
                    </div>
                    
                    <!---********************************************************************************************************************************/-->
                    <div class="form-body" runat="server" id="date" style="margin-top: 10px">
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
                    </div>
                    <!---********************************************************************************************************************************/-->
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-9">
                                <asp:Button ID="btnmensubmit" runat="server" OnClientClick="javascript:return validate()"
                                    Text="Submit" class="btn btn-success" onclick="btnmensubmit_Click"/>
                                <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END FORM-->
            </div>
  

</asp:Content>
