	<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavigationTopMenu.ascx.cs" Inherits="EsquareMasterTemplate.UserControls.NavigationTopMenu" %>
    <div class="top-menu">
    <div style="margin-right:10px;float:left;" >
      <asp:Label ID="lblFlatnumber" runat="server" Text=""  style="margin: auto 0px; padding: 14px 6px 12px 8px; color: red; float: left; background-color: rgb(255, 255, 255);"></asp:Label>
    </div>
			<ul class="nav navbar-nav pull-right">
       
             
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-user">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<%--<img alt="" class="img-circle" src="../../assets/admin/layout/img/avatar3_small.jpg"/>--%>
					<span class="username username-hide-on-mobile" id="SpanUsername" runat="server"></span>
					<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-default">
					<li id="myprofile" runat="server">
							<a href="../Profile/AccountsSettings.aspx">
							<i class="icon-user"></i> My Profile </a>
						</li>
						<li>
							<a href="../error-page/Success-page.aspx?method=Logout">
							<i class="icon-key"></i> Log Out </a>
						</li>
					</ul>
				</li>
				<!-- END USER LOGIN DROPDOWN -->
				<!-- BEGIN QUICK SIDEBAR TOGGLER -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				
				<!-- END QUICK SIDEBAR TOGGLER -->
			</ul>
		</div>