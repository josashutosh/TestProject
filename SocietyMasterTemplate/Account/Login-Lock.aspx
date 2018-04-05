<%@ Page Title="" Language="C#" MasterPageFile="~/Account/NoHeadFoot.Master" AutoEventWireup="true" CodeBehind="Login-Lock.aspx.cs" Inherits="EsquareMasterTemplate.Login_Lock1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="ThemeAssets/admin/pages/css/lock.css" rel="stylesheet" type="text/css" />
 <script src="ThemeAssets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<div class="lock-head">
			 Locked
		</div>
		<div class="lock-body">
			<div class="pull-left lock-avatar-block">
				<img src="ThemeAssets/admin/pages/media/profile/photo3.jpg" class="lock-avatar" alt="" />
			</div>
			<div class="lock-form pull-left" >
				<h4>Amanda Smith</h4>
				<div class="form-group">
					<asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtloginPassword" placeholder="Password" TextMode="Password" runat="server"></asp:TextBox>
				</div>
				<div class="form-actions">
					<button type="submit" class="btn btn-success uppercase">Login</button>
				</div>
			</div>
		</div>
		<div class="lock-bottom">
			<a href="">Not Amanda Smith?</a>
		</div>
	
</asp:Content>
