<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="ReportsHome.aspx.cs" Inherits="EsquareMasterTemplate.Reports.ReportsHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!-- BEGIN PAGE HEADER-->
    <h3 class="page-title">
       Monthly Paid Amount Receipt<small></small>
    </h3>
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
    <%--        <li><a href="#">Form Stuff</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Form Layouts</a> </li>--%>
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
					<div class="col-xs-6">
				        &nbsp;</div>
					  <asp:Button ID="Generatepdf" class="btn btn-sm green hidden-accordion margin-bottom-5" runat="server" Text="Pdf Generate" onclick="Generatepdf_Click" />
					<%--asp:Button ID="Button1" class="btn btn-sm green hidden-accordion margin-bottom-5" runat="server" Text="Send Sms" onclick="Button1_Click" /--%>
                <asp:Button ID="PrintPdf" class="btn btn-sm green hidden-accordion margin-bottom-5" 
                        runat="server" Text="Print Pdf" onclick="PrintPdf_Click" />
				</div>
           
            <div class="invoice" runat="server" id="invoice"  runat="server" style="width:690px; margin:0px auto;background:#FFF;background-color:#FFF;">
				
			</div>
  
            </div>
        </div>
    </div>
     <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
