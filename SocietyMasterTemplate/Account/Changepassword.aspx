<%@ Page Title="" Language="C#" MasterPageFile="~/Account/NoHeadFoot.Master" AutoEventWireup="true" CodeBehind="Changepassword.aspx.cs" Inherits="EsquareMasterTemplate.Account.Changepassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../ThemeAssets/global/plugins/bootstrap-toastr/toastr.js" type="text/javascript"></script>

    <script src="../ThemeAssets/global/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function changepasswrdvalidation() {
            var oldpassword = document.getElementById('<%=txtoldpasswrd.ClientID%>').value;
            var newpassword = document.getElementById('<%=txtnewpasswrd.ClientID%>').value;
            var confirmpassword = document.getElementById('<%=txtcnfpasswrd.ClientID%>').value;

            if (oldpassword == "") {
                toastr.warning("Please Enter Old Password");
                return false;
            }
            if (newpassword == "") {
                toastr.warning("Please Enter New Password");
                return false;
            }
            if (confirmpassword == "") {
                toastr.warning("Please Enter Confirm Password");
                return false;
            }
            if (confirmpassword != newpassword) {
                toastr.warning(" Your Confirm Password is not match");
                return false;
            }
            return true;
        }
    
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <!-- BEGIN LOGIN FORM -->
        <div class="login-form">
            <h3 class="form-title">Change Password</h3>
            <div class="alert alert-danger display-hide">
                <button class="close" data-close="alert">
                </button>
                <span>Enter any username and password. </span>
            </div>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label">
                    Old Password</label>
                <asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtoldpasswrd" rel="
                    " data-content="Enter Old Password" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label">
                    New Password</label>
                <asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtnewpasswrd" TextMode="Password" rel="popover" data-content="Enter New Password" runat="server"></asp:TextBox>
            </div>
             <div class="form-group">
                <label class="control-label">
                    Confirm Password</label>
                <asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtcnfpasswrd" TextMode="Password" rel="popover" data-content="Enter Confirm Password" runat="server"></asp:TextBox>
            </div>

             <div class="form-actions">
                <asp:Button ID="btnSubmit" class="btn btn-success uppercase" runat="server" 
                     Text="Submit" onclick="btnSubmit_Click" OnClientClick="return changepasswrdvalidation();"/>
                
            </div>
           
            
            
        </div>
        <!-- END LOGIN FORM -->
      
        
    </div>
</asp:Content>
