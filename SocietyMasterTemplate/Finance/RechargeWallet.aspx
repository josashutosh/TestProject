<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="RechargeWallet.aspx.cs" Inherits="EsquareMasterTemplate.Finance.RechargeWallet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script language="javascript" type="text/javascript">

       $(document).ready(function () {

           $(".lblCurrentBal label").click(function () 
           {
          checkCurrentBal();
      });

      $(".lblCurrentBalOutStanding label").click(function () 
           {
          checkOtherClient();
      });

      $(".lblOther label").click(function () 
           {
              checkOtherClient();
         });
       });

  function hideparknginfo() {
      checkCurrentBal();
      checkOutStanding();
      checkOtherClient();

  }

  function validate()
        {
           var name = document.getElementById('<%=txtName.ClientID %>').value;
           var address = document.getElementById('<%=txtAddres.ClientID %>').value;
           var Email = document.getElementById('<%=txtEmail.ClientID %>').value;
           var phone = document.getElementById('<%=txtphone.ClientID %>').value;
           var MaintenanceInfo = document.getElementById('<%=CurrentMaintenanceInfo.ClientID %>').value;
           var CurrentBal = document.getElementById('<%=rbtnCurrentBal.ClientID %>').checked;
           var OutStanding = document.getElementById('<%=rbtnOutStanding.ClientID %>').checked;
           var Other = document.getElementById('<%=rbtnOther.ClientID %>').checked;
           var Amount = document.getElementById('<%=txtAmount.ClientID %>').value;
           var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
           var Emailpattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;
           if (name == "") {
               bootbox.alert("Please Enter Name");
               return false;
           }

           if (address == "") {
               bootbox.alert("Please Enter Address ");
               return false;
           }

           if (Email == "") {
               bootbox.alert("Please Enter Email Id ");
               return false;
           }

           if (!Emailpattern.test(Email)) {
               bootbox.alert("Your Email Id is Wrong");
               return false;
           }

           if (phone == "") {
               bootbox.alert("Please Enter Phone Number");
               return false;
           }
//           if (!Mobilepattern.test(phone)) {
//               bootbox.alert("Your Contact number is Wrong");
//               return false;
//           }

           if (MaintenanceInfo == "") {
               bootbox.alert("Please Enter Maintenance Information");
               return false;
           }
           
           if (CurrentBal == true) {
               return true;
           }
           else if (OutStanding == true) {
               return true;
           }
//           else if (Other == true) {

//               if (Amount == "") {
//                   bootbox.alert("Please Enter Amount");
//                   return false;
//               }

//               return true;
//           }
           return true;
       }

       function ValidateForm() 
       {
           var identifier = validate();
           if (identifier == true ) {
               return confirm('Are you sure you want to pay your mainteanance?');
           }
           else {
               return false;
           }

       }

       function ReturnFunction(identifier) {

       }

       function checkCurrentBal()
       {
              if ((document.getElementById('<%=rbtnCurrentBal.ClientID %>').checked) === true) {
               $('#<%=CurrentAmount.ClientID%>').show('fast');
               $('#<%=CurrentMaintenanceInfo.ClientID%>').show('fast');
               $('#<%=OutstandingMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=OtherMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=Amount.ClientID%>').hide('fast');
               $('#<%=OutstandingAmount.ClientID%>').hide('fast');
               $('#<%=divBalanceWallAmount.ClientID%>').hide('fast');
           }
       }

          function checkOutStanding()
       {
               if ((document.getElementById('<%=rbtnOutStanding.ClientID %>').checked) === true) {
               $('#<%=CurrentAmount.ClientID%>').show('fast');
               $('#<%=OutstandingMaintenanceInfo.ClientID%>').show('fast');
               $('#<%=CurrentMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=OtherMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=Amount.ClientID%>').hide('fast');
               $('#<%=CurrentAmount.ClientID%>').hide('fast');
               $('#<%=OutstandingAmount.ClientID%>').show('fast');
               $('#<%=divBalanceWallAmount.ClientID%>').hide('fast');
           }
       }

            function checkOtherClient()
       {
          if ((document.getElementById('<%=rbtnOther.ClientID %>').checked) === true) 
          {
               $('#<%=CurrentAmount.ClientID%>').show('fast');
               $('#<%=OtherMaintenanceInfo.ClientID%>').show('fast');
               $('#<%=Amount.ClientID%>').show('fast');
               $('#<%=CurrentAmount.ClientID%>').show('fast');
               $('#<%=CurrentMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=OutstandingMaintenanceInfo.ClientID%>').hide('fast');
               $('#<%=OutstandingAmount.ClientID%>').hide('fast');
               $('#<%=divBalanceWallAmount.ClientID%>').hide('fast');
           }
       }

     
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/FlatMemberMaster.aspx">Recharge Wallet</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                <!--End button-->
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <div class="portlet-body form">
        <!-- BEGIN FORM-->
        <div class="form-horizontal form-row-stripped form-label-stripped">
            <div class="form-body">
                <div id ="frmError" runat="server">
                <span style="color:red">Please fill all mandatory fields.</span>
                <br/>
                <br/>
                </div>
                <!--row1-->
                <h3>
                    <b>Profile Detail :</b></h3>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">
                                Name</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtName" class="form-control input-large" rel="popover" data-content="Enter  Name "
                                    AutoComplete="off" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <!--/span-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">
                                Address</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAddres" TextMode="MultiLine" class="form-control input-large"
                                    rel="popover" data-content="Address " AutoComplete="off" runat="server"></asp:TextBox>
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
                                Email</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtEmail" class="form-control  input-large" rel="popover" data-content="Enter Email Id"
                                    runat="server"></asp:TextBox>
                            </div>
                            <span style="color:Red; text-align:right">We will send
                             <span style="color:Red; text-align:right">payment details on this </span>email id/s.</span></div>
                    </div>
                    <!--/span-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-md-3">
                                Contact No: +91</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtphone" class="form-control input-large" rel="popover" data-content="Enter Phone number e.g:9029584458"
                                    AutoComplete="off" runat="server"></asp:TextBox>
                            </div>
                             <span style="color:Red; text-align:right">We will send
                             <span style="color:Red; text-align:right">payment details</span> on this mobile number/s. </span>&nbsp;</div>
                    </div>
                    <!--/span-->
                </div>
                <!--/span-->
            </div>
            <!--/row6-->
        </div>
        <!--Begin Add Tanent Member Table-->
    </div>
    <!-- END FORM-->
    <!-- Second Form-->
    <h3><b>Maintenance Payment Detail :</b></h3>
    <div class="portlet-body form">
        <!-- BEGIN FORM-->
        <div class="form-horizontal form-bordered form-row-stripped">
            <div class="form-body">
                 <div class="form-group" id="Div1" runat="server" clientidmode="Static">
                    <label class="control-label col-md-3">
                        My Wallet Balance:
                    </label>
                    <div class="col-md-9">
                        <asp:Label ID="lblWalletAmount" class="form-control input-large" runat="server" color="Red"></asp:Label>
                    </div>
                </div>
                <div class="form-group" id="MaintenancePaymentOpt" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                        Maintenance Payment Option</label>
                    <div class="col-md-9">
                        <asp:RadioButton ID="rbtnCurrentBal" runat="server" Checked="false" Text="Current Month Maintenance"
                            GroupName="A" class="icheck intercom_yes lblCurrentBal" />
                        <asp:RadioButton ID="rbtnOutStanding" Checked="false" runat="server" Text="Total OutStanding Maintenance"
                            GroupName="A" class="icheck intercom_yes lblCurrentBalOutStanding" />
                        <asp:RadioButton ID="rbtnOther" runat="server" Text="Other" Checked="false" GroupName="A" class="icheck intercom_yes lblOther"
                            />
                    </div>
                </div>
                <div class="form-group" id="CurrentMaintenanceInfo" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                       Current Maintenance Info</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtCurrentMaintenanceInfo" AutoComplete="off" class="form-control input-large" TextMode="MultiLine"
                            runat="server" rel="popover" data-content="MaintenanceInfo"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group" id="OutstandingMaintenanceInfo" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                       Outstanding Maintenance Info</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtOutstandingMaintenanceInfo" AutoComplete="off" class="form-control input-large" TextMode="MultiLine"
                            runat="server" rel="popover" data-content="MaintenanceInfo"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group" id="OtherMaintenanceInfo" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                        Remarks</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtotherremark" AutoComplete="off" class="form-control input-large" TextMode="MultiLine"
                            runat="server" rel="popover" data-content="MaintenanceInfo"></asp:TextBox>
                    </div>
                </div>
           
                <div class="form-group" id="CurrentAmount" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                        Current Month Maintenance:
                    </label>
                    <div class="col-md-9">
                        <asp:Label ID="lblCurrentAmount" class="form-control input-large" runat="server"
                            ></asp:Label>
                    </div>
                </div>
                <div class="form-group" id="OutstandingAmount" runat="server" clientidmode="Static"
                    style="display: none;">
                    <label class="control-label col-md-3">
                        OutStanding Maintenance:
                    </label>
                    <div class="col-md-9">
                        <asp:Label ID="lblOutStanding" class="form-control input-large" runat="server"></asp:Label>
                    </div>
                </div>
                 <div class="form-group" id="divBalanceWallAmount" runat="server" clientidmode="Static"
                    style="display: none;">
                    <label class="control-label col-md-3">
                        Balance Wallet Amount:</label>
                    <div class="col-md-9">
                        <asp:Label ID="lblBalanceWallAmount" runat="server" Text="Label"></asp:Label>
                    </div>
                </div>
                <div class="form-group" id="Amount" runat="server" clientidmode="Static" style="display: none;">
                    <label class="control-label col-md-3">
                        Amount:</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txtAmount" AutoComplete="off" class="form-control input-large" runat="server"
                            rel="popover" data-content="Enter Amount"></asp:TextBox>
                    </div>
                </div>
               
            </div>
            <div class="form-actions">
                <div class="row">
                    <div class="col-md-offset-3 col-md-9">
                        <asp:Button ID="btnMakePayment" runat="server" Text="Make Payment" OnClientClick="javascript:return ValidateForm();"
                            class="btn btn-success" onclick="btnMakePayment_Click"/>
                        <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                        <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" />
                    </div>
                </div>
            </div>

            <input type="hidden" runat="server" id="key" name="key" />
            <input type="hidden" runat="server" id="hash" name="hash"  />
            <input type="hidden" runat="server" id="txnid" name="txnid" />
            <input type="hidden" runat="server" id="enforce_paymethod" name="enforce_paymethod" />
        </div>
        <!-- END FORM-->
    </div>
</asp:Content>
