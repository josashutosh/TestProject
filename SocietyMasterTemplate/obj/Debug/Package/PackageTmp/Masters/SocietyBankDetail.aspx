<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="SocietyBankDetail.aspx.cs" Inherits="EsquareMasterTemplate.Masters.SocietyBankDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    var PancardPattern, IFFCPattern, number, Name, BankName, BranchAccountLocation, Baranchnumber, AccountType, AccountNumkber, Exta;
    function InsertBankInfo() {
        getBankInfo();
        Validate();
        return false;
    }
    function getBankInfo() {
        Name = $('#<%=txtName.ClientID%>').val();
        BankName = $('#<%=txtBankName.ClientID%>').val();
        BranchAccountLocation = $('#<%=txtBranchAccountLocation.ClientID%>').val();
        Baranchnumber = $('#<%=txtBaranchnumber.ClientID%>').val();
        AccountType = $('#<%=drpAccountType.ClientID%>').val();
        AccountNumkber = $('#<%=txtAccountNumber.ClientID%>').val();
        Exta = $('#<%=txtExtra.ClientID%>').val();
        PancardPattern = /^[A-Z]{5}\d{4}[A-Z]{1}$/;
        IFSCPattern = /^[[A-Z|a-z]{4}[0][\d]{6}]$/;
        number = /^[0-9]*$/;
    }

    function Validate() 
    {
        if (Name == "") {
            bootbox.alert("Please Enter Bank accountName");
            return false;
        }

        if (BankName == "") {
            bootbox.alert("Please Enter Bank Name");
            return false;
        }

        if (BranchAccountLocation == "") {
            bootbox.alert("Please Enter Branch Account Location");
            return false;
        }

        if (Baranchnumber == "") {
            bootbox.alert("Please Enter valid Branch Number");
            return false;
        }

        if (AccountType == "0") {
            bootbox.alert("Please Select bank Account Type");
            return false;
        }
        if (AccountNumkber == "" || (!number.test(AccountNumkber))) {
            bootbox.alert("Please Enter Proper bank Account Number");
            return false;
        }

    }
    </script>










</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<!-- BEGIN PAGE HEADER-->
   
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Form Stuff</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Form Layouts</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                 <!--End button-->>
            
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
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Society Bank Detail Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle"></i></a>
                            <a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash">
                            </i></a--%>>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div  class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Name (building society or credit union)</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtName" class="form-control input-large" runat="server" AutoComplete="Off" Placeholder="Enter Name"></asp:TextBox>
                                        <span class="help-block">Enter Name</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Bank Name</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBankName" class="form-control input-large" runat="server" AutoComplete="Off" Placeholder="Enter Bank Name"></asp:TextBox>
                                        <span class="help-block">Enter Bank Name</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Branch where your account is held</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBranchAccountLocation" class="form-control input-large" runat="server"></asp:TextBox>
                                        <span class="help-block">Enter Branch Address</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Branch Number</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBaranchnumber" class="form-control input-large" runat="server"></asp:TextBox><br />
                                        <span class="help-block">Enter Branch Number Example: CITI0344444</span>
                                    </div>
                                </div>
                                        <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Account Type</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpAccountType" runat="server" class="select2me form-control">
                                        <asp:ListItem Selected="True" Value="0">--Select Type--</asp:ListItem>
                                        <asp:ListItem Value="1">Saving</asp:ListItem>
                                        <asp:ListItem Value="2">Current</asp:ListItem>
                                    </asp:DropDownList><br />
                                        
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Bank Account Number</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtAccountNumber" onkeypress="return isNumberKey(event)" class="form-control input-large" runat="server"></asp:TextBox>
                                        <span class="help-block">Enter Bank Account Number</span>
                                    </div>
                                </div>

                                 <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Extra  Info</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtExtra" TextMode="MultiLine" class="form-control input-large" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                    
                                        <asp:Button ID="btnBuildingSubmit" runat="server" Text="Submit" class="btn btn-success"
                                           OnClientClick="return getBankInfo()" />
                                            <asp:Button ID="btnClear"  class="btn default" runat="server" Text="Clear" 
                                            />
                                        <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" />
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
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->

















</asp:Content>
