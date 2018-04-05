<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="SocietyInformation.aspx.cs" Inherits="EsquareMasterTemplate.Masters.SociteyInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
        });
    </script>
    <script>
        function validateSocityInfo()
        {
            var txtSocietyName = document.getElementById('<%=txtSocietyName.ClientID%>').value;
            var txtSocietyAddress = document.getElementById('<%=TxtSocietyAddress.ClientID%>').value;
            if (txtSocietyName == "") {
                bootbox.alert("Please enter society name");
                txtSocietyName.focus();
                return false;
            }
            if (txtSocietyAddress == "") {
                bootbox.alert("Please enter society address");
                TxtSocietyAddress.focus();
                return false;
            }
            return true;
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
            <li><a href="../Masters/SocietyInformation.aspx"></a>Society Information</li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                <!--End button-->
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Society Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Society Full Name</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtSocietyName" AutoComplete="off" rel="popover" data-content="Enter Society Full Name"
                                            class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Society Address</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="TxtSocietyAddress" rel="popover" data-content="Enter Society Address"
                                            TextMode="MultiLine" AutoComplete="off" class="form-control input-large" runat="server" style="height:200px;width:450px !important"></asp:TextBox>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Sender Name(Sms GetWay)</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtSenderName" rel="popover" data-content="Enter Sender Name"
                                            TextMode="MultiLine" AutoComplete="off" class="form-control input-large" runat="server" style="height:200px;width:450px !important"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Total Building</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="TxtBuildingCnt" rel="popover" onkeypress="javascript:return checkDigits_(event)" data-content="Enter Building Count"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Total Flats</label>
                                    <div class="col-md-9"> 
                                        <asp:TextBox ID="TxtFlatsCnt" rel="popover" onkeypress="javascript:return checkDigits_(event)" data-content="Enter Flats Count" AutoComplete="off"
                                            class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Society Registration Number</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="TxtRegistrationNumber" rel="popover" data-content="Enter Society Registration Number"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Account Number</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtbankAccount" rel="popover" data-content="Enter Bank Account Number"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Bank Name</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBankName" rel="popover" data-content="Enter Bank Name"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Branch</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBranch" rel="popover" data-content="Enter Bank Branch"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                   <div class="form-group">
                                    <label class="control-label col-md-3">
                                       Bank IFSC Code</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtIFSC" rel="popover" data-content="Enter IfscCode"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Receipt Note</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtreceiptnotes" rel="popover" data-content="Enter Society Receipt notes"
                                            TextMode="MultiLine" AutoComplete="off" class="form-control input-large" runat="server" style="height:300px;width:450px !important"></asp:TextBox>
                                    </div>
                                </div>
                                   <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Intrest Rate</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtintrestrate" rel="popover" onkeypress="javascript:return checkDigitDot(event)" data-content="Enter Intrest Rates i.e 10"
                                            AutoComplete="off" class="form-control input-large" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Logo</label>
                                    <div class="col-md-9">
                                        <asp:FileUpload ID="FuLogo" class="form-control input-large" runat="server" />
                                        <asp:Label ID="lbllogo" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Society Stamp</label>
                                    <div class="col-md-9">
                                        <asp:FileUpload ID="fustamp" class="form-control input-large" runat="server" />
                                        <asp:Label ID="lblstamp" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Secretory Sign</label>
                                    <div class="col-md-9">
                                        <asp:FileUpload ID="fuSign" class="form-control input-large" runat="server" />
                                        <asp:Label ID="lblSign" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <asp:Button ID="btnBuildingSubmit" runat="server" Text="Submit" class="btn btn-success"
                                            OnClick="btnBuildingSubmit_Click" OnClientClick="javascript:return validateSocityInfo()" />
                                        <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                        <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Cancel" OnClick="btnBack_Click" />
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
</asp:Content>
