<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="PettyCashEntry.aspx.cs" Inherits="EsquareMasterTemplate.Finance.PityCashentry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function Vlidate() {
            var Amount, ExpDescription, AmountPattern, TransType;
            Amount = document.getElementById('<%=txtAmount.ClientID %>').value;
        ExpDescription = document.getElementById('<%=txtExpDescription.ClientID%>').value;
        TransType = document.getElementById('<%=ddlTransType.ClientID%>').value;

        AmountPattern = /^[-+]?[0-9]+([\.][0-9]+)?$/;


        if (ExpDescription == "") {
            toastr.warning("Please Enter Description ");
            return false;
        }

        if (TransType == "0") {
            toastr.warning("Please Select Transaction Type ");
            return false;
        }

        if (Amount == "") {
            toastr.warning("Please Enter Amount");
            return false;
        }
        if (!AmountPattern.test(Amount)) {
            toastr.warning(" Enter valid Amount");
            return false;
        }



        return true;
    }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i>
            </li>
            <li><a href="#">Finance</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="PettyCashEntry.aspx">Pity Cash Entry</a> </li>
        </ul>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">Petty Cash Entry </span><span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash">
                            </i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form" id="basic">
                        <!-- BEGIN FORM-->
                        <div id="Main_Collection" class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Petty Cash Balance</label>
                                    <div class="col-md-9">
                                        <asp:Label ID="lblbalance" runat="server" Style="font: 14px; text-align: left" class="control-label col-md-3"></asp:Label>
                                        <asp:Label ID="lblAlert" runat="server" Style="color: Red; font: 14px; text-align: left" class="control-label col-md-6"></asp:Label>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Transaction Type</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="ddlTransType" class="form-control input-large" runat="server">
                                            <asp:ListItem Enabled="true" Text="--Select Transaction Type--" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Credit" Value="Credit"></asp:ListItem>
                                            <asp:ListItem Text="Debit" Value="Debit"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Expense Decription</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtExpDescription" runat="server" AutoComplete="Off" TextMode="MultiLine"
                                            rel="popover" data-content="Enter Expense Description" class="form-control input-large"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Amount</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtAmount" Style="text-align: right;" AutoComplete="Off" rel="popover"
                                            data-content="Enter Amount" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript:return Vlidate()" class="btn btn-success"
                                                OnClick="btnSubmit_Click" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-success"
                                                OnClick="btnCancel_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
