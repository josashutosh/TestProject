<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/ReportMaintenance.Master"
    AutoEventWireup="true" CodeBehind="MothlyMaintenance.aspx.cs" Inherits="EsquareMasterTemplate.Reports.MothlyMaintenance" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Syncfusion.EJ.Web, Version=12.4400.0.24, Culture=neutral, PublicKeyToken=3d67ed1f87d44c89"
    Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
       <style type="text/css">
    #MonthlyReport {
        width: 780px;
        height:650px;
    }
    

</style>
    <script type="text/javascript">

        $(function () {

            $('.date1').datepicker({
                format: "dd/mm/yyyy",
                weekStart: 1,
                todayBtn: true,
                orientation: "top right",
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


     function validateInfo()
        {
       //  var drpFlatID = document.getElementById('<%=drpFlatID.ClientID%>').value;
         var txtdate = document.getElementById('<%=txtdate.ClientID%>').value;
           

         //if (drpFlatID == 0) {
         //       bootbox.alert("Please Select Flat Mame");
         //       return false;
         //   }
         if (txtdate == "") {
                bootbox.alert("please Enter Date");
                return false;
            }
            
            return true;
        }

    </script>
<%--    <link href="../Scripts/Scripts/CSS/ej.theme.min.css" rel="stylesheet" />
    <link href="../Scripts/Scripts/CSS/ej.widget.bootstrap-theme.min.css" rel="stylesheet" />
    <link href="../Scripts/Scripts/CSS/ej.widgets.core.min.css" rel="stylesheet" />
    <script src="../Scripts/Scripts/jsrender.min.js"></script>
    <script src="../Scripts/Scripts/ej/jquery.globalize.min.js"></script>
    <script type="text/javascript" src="../Scripts/Scripts/jquery.easing-1.3.min.js"></script>
    <script src="../Scripts/Scripts/ej/ej.core.min.js"></script>
    <script src="../Scripts/Scripts/ej/ej.widget.all.min.js"></script>  
    <script type="text/javascript" src="../Scripts/Scripts/ej/ej.web.all.min.js"></script> --%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="Reports/MothlyMaintenance.aspx">Monthly Maintenanace Report</a> </li>
        </ul>
        <div class="page-toolbar">
              <!--End button-->
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
                                        <asp:DropDownList ID="drpFlatID" class="select2 form-control input-large" runat="server">
                                                                </asp:DropDownList>
                                        <asp:TextBox ID="txtdate" Style="display: inline !important;" AutoComplete="off" class="datepicker date form-control input-large date1" runat="server"></asp:TextBox>
                                        <asp:Button class="btn btn-success small" Style="display: inline !important;" ID="btnSearch" runat="server" Text="Search"
                                            OnClick="btnSearch_Click" OnClientClick="javascript: return validateInfo()" />
                                       
                                       
                                        <span class="help-block">
                                            <p>
                                                <span style="font-size: 14px; color: Red">
                                                </span>
                                            </p>
                                        </span>


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


    <div class="row" id="ReportM" runat="server">
        <div class="col-md-12">
            <div class="portlet light bordered form-fit">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Monthly Maintenanace Monthly Report</span> <span class="caption-helper"></span>
                        <%--<ej:ReportViewer ID="MonthlyReport" ReportPath="MonthlyMaintenance.rdlc" ProcessingMode="Local"  runat="server">
                </ej:ReportViewer>--%>

                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <%--
                        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="773px">
                            <LocalReport ReportPath="Reports\Rdlc\MonthlyMaintenance.rdlc">
                                <DataSources>
                                    <rsweb:ReportDataSource DataSourceId="MaintenanceReport" 
                                        Name="MonthReport" />
                                </DataSources>
                            </LocalReport>
                        </rsweb:ReportViewer>
                   
                       
                        <asp:SqlDataSource ID="MaintenanceReport" runat="server" ConnectionString="<%$ ConnectionStrings:Report %>" SelectCommand="MonthlyMaintenance" SelectCommandType="StoredProcedure">
                            
                            <SelectParameters>
                                <asp:SessionParameter  DefaultValue="" Name="Login_Type" SessionField="Login_Type" Type="String" />
                                <asp:SessionParameter  DefaultValue="0" Name="flatNumber" SessionField="flatnumber" Type="Int32" />
                                <asp:SessionParameter  DefaultValue="" Name="ReportDate" SessionField="ReportDate" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>--%>

                         <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="96%">
                           
                        </rsweb:ReportViewer>
                   
                       
                    </div>
                </div>
                <div class="portlet-body form">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
