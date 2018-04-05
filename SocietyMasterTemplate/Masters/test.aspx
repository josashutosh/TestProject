<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="EsquareMasterTemplate.Masters.test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <!-- BEGIN PAGE HEADER-->
    <h3 class="page-title">
        Form Layouts <small>form layouts</small>
    </h3>
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Form Stuff</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Form Layouts</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                            
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">

            <div class="invoice" id="invoice"  runat="server" style="width:590px; margin:0px auto;background:#FFF;background-color:#FFF;">
				<div class="row invoice-logo">
					<div class="col-xs-6 invoice-logo-space">
						<img src="http://localhost:19921/Images/logo.png" class="img-responsive" alt="">
					</div>
					<div class="col-xs-6">
						<p>
							 #5652256 / 28 Feb 2013 <span class="muted">
							Consectetuer adipiscing elit </span>
						</p>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-xs-4">
						<h3>Client:</h3>
						<ul class="list-unstyled">
							<li>
								 John Doe
							</li>
							<li>
								 Mr Nilson Otto
							</li>
							<li>
								 FoodMaster Ltd
							</li>
							<li>
								 Madrid
							</li>
							<li>
								 Spain
							</li>
							<li>
								 1982 OOP
							</li>
						</ul>
					</div>
					<div class="col-xs-4">
						<h3>About:</h3>
						<ul class="list-unstyled">
							<li>
								 Drem psum dolor sit amet
							</li>
							<li>
								 Laoreet dolore magna
							</li>
							<li>
								 Consectetuer adipiscing elit
							</li>
							<li>
								 Magna aliquam tincidunt erat volutpat
							</li>
							<li>
								 Olor sit amet adipiscing eli
							</li>
							<li>
								 Laoreet dolore magna
							</li>
						</ul>
					</div>
					<div class="col-xs-4 invoice-payment">
						<h3>Payment Details:</h3>
						<ul class="list-unstyled">
							<li>
								<strong>V.A.T Reg #:</strong> 542554(DEMO)78
							</li>
							<li>
								<strong>Account Name:</strong> FoodMaster Ltd
							</li>
							<li>
								<strong>SWIFT code:</strong> 45454DEMO545DEMO
							</li>
							<li>
								<strong>V.A.T Reg #:</strong> 542554(DEMO)78
							</li>
							<li>
								<strong>Account Name:</strong> FoodMaster Ltd
							</li>
							<li>
								<strong>SWIFT code:</strong> 45454DEMO545DEMO
							</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<table class="table table-striped table-hover">
						<thead>
						<tr>
							<th>
								 #
							</th>
							<th>
								 Item
							</th>
							<th class="hidden-480">
								 Description
							</th>
							<th class="hidden-480">
								 Quantity
							</th>
							<th class="hidden-480">
								 Unit Cost
							</th>
							<th>
								 Total
							</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>
								 1
							</td>
							<td>
								 Hardware
							</td>
							<td class="hidden-480">
								 Server hardware purchase
							</td>
							<td class="hidden-480">
								 32
							</td>
							<td class="hidden-480">
								 $75
							</td>
							<td>
								 $2152
							</td>
						</tr>
						<tr>
							<td>
								 2
							</td>
							<td>
								 Furniture
							</td>
							<td class="hidden-480">
								 Office furniture purchase
							</td>
							<td class="hidden-480">
								 15
							</td>
							<td class="hidden-480">
								 $169
							</td>
							<td>
								 $4169
							</td>
						</tr>
						<tr>
							<td>
								 3
							</td>
							<td>
								 Foods
							</td>
							<td class="hidden-480">
								 Company Anual Dinner Catering
							</td>
							<td class="hidden-480">
								 69
							</td>
							<td class="hidden-480">
								 $49
							</td>
							<td>
								 $1260
							</td>
						</tr>
						<tr>
							<td>
								 3
							</td>
							<td>
								 Software
							</td>
							<td class="hidden-480">
								 Payment for Jan 2013
							</td>
							<td class="hidden-480">
								 149
							</td>
							<td class="hidden-480">
								 $12
							</td>
							<td>
								 $866
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-4">
						<div class="well">
							<address>
							<strong>Loop, Inc.</strong><br>
							795 Park Ave, Suite 120<br>
							San Francisco, CA 94107<br>
							<abbr title="Phone">P:</abbr> (234) 145-1810 </address>
							<address>
							<strong>Full Name</strong><br>
							<a href="mailto:#">
							first.last@email.com </a>
							</address>
						</div>
					</div>
					<div class="col-xs-8 invoice-block">
						<ul class="list-unstyled amounts">
							<li>
								<strong>Sub - Total amount:</strong> $9265
							</li>
							<li>
								<strong>Discount:</strong> 12.9%
							</li>
							<li>
								<strong>VAT:</strong> -----
							</li>
							<li>
								<strong>Grand Total:</strong> $12489
							</li>
						</ul>
						<br>
						<a class="btn btn-lg blue hidden-print margin-bottom-5" onclick="javascript:window.print();">
						Print <i class="fa fa-print"></i>
						</a>

                        <asp:Button ID="Generatepdf" class="btn btn-lg green hidden-accordion margin-bottom-5" runat="server" Text="Pdf Generate" onclick="Generatepdf_Click" />
						
                        <asp:Button ID="Button1" class="btn btn-lg green hidden-accordion margin-bottom-5" runat="server" Text="SenSms" onclick="Button1_Click" />
					</div>
				</div>
			</div>



                
            </div>
        </div>
    </div>
     <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
