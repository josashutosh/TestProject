<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="FlatMemberMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.FlatMemberMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function hideparknginfo()
         {
         }
        
        $(document).ready(function () {
            $("#drpFlatNo").select2({
                placeholder: "Enter a Flat Name",
                allowClear: true,
                maximumSelectionSize: 1
            });

            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
        });
    </script>
    <script type="text/javascript" language="javascript">
        function Tenantmembervalidtn() {
            var flatno = document.getElementById('<%=drpFlatID.ClientID%>').value;
            var tenantname = document.getElementById('<%=txttenantName.ClientID%>').value;
            var residingfrm = document.getElementById('<%=txtresidingfrom.ClientID%>').value;
            var residingto = document.getElementById('<%=txtresidingto.ClientID%>').value;
            var rent = document.getElementById('<%=txtrent.ClientID%>').value;
            var pan = document.getElementById('<%=txtpan.ClientID%>').value;
            var adharno = document.getElementById('<%=txtaadhar.ClientID%>').value;
            var permanantaddr = document.getElementById('<%=txtpermanantaddress.ClientID%>').value;
            var contactno = document.getElementById('<%=txtcontactno1.ClientID%>').value;
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
            var PancardPattern = /^[A-Z]{5}\d{4}[A-Z]{1}$/;

            if (flatno === "0" || flatno === 0) {
                bootbox.alert("Select Flat no");
                return false;
            }
            if (tenantname == "") {
                bootbox.alert("Enter Tenant Name");
                return false;
            }
            if (residingfrm == "") {
                bootbox.alert("Enter Date Residing From");
                return false;
            }
            if (residingto == "") {
                bootbox.alert("Enter Date Residing To");
                return false;
            }
            if (rent == "") {
                bootbox.alert("Enter Rent");
                return false;
            }
            if (pan == "") {
                bootbox.alert("Enter Pancard Number");
                return false;
            }
            if (pan.length != 10 ) {
                bootbox.alert("Pancard Number is not valid");
                return false;
            }
            if (!PancardPattern.test(pan)) {
                bootbox.alert("Pancard Number is not valid");
                return false;
            }


            if (adharno == "") {
                bootbox.alert("Enter Adhaarcard Number");
                return false;
            }
            if (permanantaddr == "") {
                bootbox.alert(" Enetr Address");
                return false;
            }
            if (contactno == "") {
                bootbox.alert("Enter Contact Number ");
                return false;
            }
            if (contactno.length != 10 || (!Mobilepattern.test(contactno))) {
                bootbox.alert("Enter Valid Mobile Number");
                return false;
            }
            return true;
        }
    </script>

    <script language="javascript" type="text/javascript">


        function validateFlatmember() {
            var flatid = document.getElementById('<%=drpFlatID.ClientID%>').value;
            var name = document.getElementById('<%=txtFlatMemberName.ClientID%>').value;
            var residingfm = document.getElementById('<%=txtFlatMemberResfrom.ClientID%>').value;
            var contactno = document.getElementById('<%=txtFlatMemberConNo.ClientID%>').value;
            var pan = document.getElementById('<%=txtFlatMemberPan.ClientID%>').value;
            var adharno = document.getElementById('<%=txtFlatMemberAdhaar.ClientID%>').value;
            var relation = document.getElementById('<%=drpFlatMemberRelation.ClientID%>').value;
            var dob = document.getElementById('<%=txtFlatMemberDob.ClientID%>').value;
            var permenataddr = document.getElementById('<%=txtFlatMemberAddress.ClientID%>').value;
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
            var PancardPattern = /^[A-Z]{5}\d{4}[A-Z]{1}$/;

            if (flatid === "0" || flatid === 0) {
                bootbox.alert("Select Flat no");
                return false;
            }
            if (name == "") {
                bootbox.alert("Enter Family member Name");
                return false;
            }
            if (residingfm == "") {
                bootbox.alert("Enter date Residing From");
                return false;
            }

            if (pan == "") {
                bootbox.alert("Enter Pancard number");
                return false;
            }

            if (!PancardPattern.test(pan)) {
                bootbox.alert("Pancard Number is not valid");
                return false;
            }

            if (adharno == "") {
                bootbox.alert("Enter Aadharcard number");
                return false;
            }
            if (relation === "None") {
                bootbox.alert("Select Relation");
                return false;
            }
            if (dob == "") {
                bootbox.alert("Enter Date Of Birth");
                return false;
            }
            if (permenataddr == "") {
                bootbox.alert("Enter Permanent Address");
                return false;
            }
            if (contactno == "") {
                bootbox.alert("Enter Contact number");
                return false;
            }
            if (!Mobilepattern.test(contactno)) {
                bootbox.alert("Enter valid Contact Number");
                return false;
            }
            return true;
        }

    </script>
    <script type="text/javascript">
        function showdiv() {
            drpnumparking = document.getElementById('<%=drpFamilyinfo.ClientID %>').value;
            if (drpnumparking == "Tenent") {
                document.getElementById('<%=TenantMstr.ClientID %>').style.display = "block";
                document.getElementById('<%=FamilyinfoMstr.ClientID %>').style.display = "none";

            }

            if (drpnumparking == "FamilyInfo") {
                document.getElementById('<%=TenantMstr.ClientID %>').style.display = "none";
                document.getElementById('<%=FamilyinfoMstr.ClientID %>').style.display = "block";


            }

            if (drpnumparking == "zero") {
                document.getElementById('<%=TenantMstr.ClientID %>').style.display = "none";
                document.getElementById('<%=FamilyinfoMstr.ClientID %>').style.display = "none";

            }
        }


        function showrelation() {
            drprel = document.getElementById('<%=drpFlatMemberRelation.ClientID %>').value;
            if (drprel == "Other") {
                document.getElementById('<%=txtotherrelation.ClientID %>').style.display = "block";

            } else {
                document.getElementById('<%=txtotherrelation.ClientID %>').style.display = "none";
            }



            if (drprel == "none") {
                document.getElementById('<%=txtotherrelation.ClientID %>').style.display = "none";

            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/FlatMemberMaster.aspx">Flat Member Information</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                  <!--End button-->
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="Div2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Flat Member Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                           <%-- <a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!--Begin portlet-body-->
                        <!--Row1-->
                        <div class="row" id="rowAdmindisplay" style="display:none" runat="server">
                            <div class="col-md-12">
                                <div class="tab-pane" id="tab_2">
                                    <div class="col-lg-6 col-lg-offset-3 text-center">
                                        <!-- BEGIN FORM-->
                                        <div class="form-horizontal form-row-stripped form-label-stripped">
                                            <div class="form-body">
                                                <!--row1-->
                                                <div class="row" id="selectMemberType" runat="server">
                                                    <div class="col-md-6">
                                                        <div class="form-group" >
                                                            <label class="control-label col-md-3" >
                                                                Select Type</label>
                                                            <div class="col-md-9">
                                                                <asp:DropDownList class="form-control" ID="drpFamilyinfo" onchange="showdiv()" runat="server">
                                                                    <asp:ListItem Selected="True" Value="zero">--select--</asp:ListItem>
                                                                    <asp:ListItem Value="Tenent">Add Tenant Info</asp:ListItem>
                                                                    <asp:ListItem Value="FamilyInfo">Owner Family Info</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <span class="help-block"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                                <!--/row1-->
                                                <!--row2-->
                                                <div class="row" id="flatnumberID" runat="server">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">
                                                                Flat Number</label>
                                                            <div class="col-md-9">
                                                                <asp:DropDownList ID="drpFlatID" class="select2 form-control input-large" AutoPostBack="True"
                    onselectedindexchanged="Flatnumber_SelectedIndexChanged" runat="server">
                                                                </asp:DropDownList>
                                                                <span class="help-block">Select your Flat Number</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                                <!--/row2-->
                                            </div>
                                        </div>
                                        <!-- END FORM-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--/Row1-->
                        <div class="clearfix">
                        </div>
                        <!--Row2 Tenant Master-->
                        <div class="row" runat="server" id="TenantMstr" style="display: none">
                            <div class="col-md-12">
                                <div class="tab-pane" id="Div1">
                                    <div class="portlet light bordered form-fit">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                                    Tenant Member Master</span> <span class="caption-helper">..</span>
                                            </div>
                                        </div>
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <div class="form-horizontal form-row-stripped form-label-stripped">
                                                <div class="form-body">
                                                    <!--row1-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Tenant Name</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txttenantName" class="form-control input-large" rel="popover" data-content="Enter Tenant Name " AutoComplete="off" runat="server"></asp:TextBox>
                                                                    <span class="help-block"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Residing From</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtresidingfrom" class="form-control datepicker input-large" rel="popover" data-content="Residing From Eg:10/5/2014" AutoComplete="off"
                                                                         runat="server"></asp:TextBox>
                                                                   
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
                                                                    Residing To</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtresidingto" class="form-control datepicker input-large" rel="popover" data-content="Select Residing To Eg:10/5/2014" runat="server"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Rent(Rs.)</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtrent" class="form-control input-large" rel="popover" data-content="Enter Rent Eg:5000" AutoComplete="off" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                                                                  
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row2-->
                                                    <!--row3-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    PAN Card Number</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtpan" AutoComplete="off"  class="form-control input-large" rel="popover" data-content="Enter PAN Card Number Eg:AQWER4754D" runat="server" MaxLength="10"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Aadhaar Card Number</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtaadhar" AutoComplete="off"
                                                                        class="form-control input-large" rel="popover" data-content="Enter 12 Digit Aadhar card Number" onkeypress="return isNumberKey(event)" runat="server" MaxLength="12"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row3-->
                                                    <!--row4-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Permanant Address</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtpermanantaddress" AutoComplete="off" class="form-control input-large" rel="popover" data-content="Enter Permanant Address" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                                  
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Contact No: +91</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtcontactno1" AutoComplete="off"
                                                                        class="form-control input-large" rel="popover" data-content="Enter Contact No. Eg:9026845574" onkeypress="return isNumberKey(event)" runat="server" MaxLength="10"></asp:TextBox>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row4-->
                                                    <!--row5-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Alternative Contact Number: +91</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtcontactno2" class="form-control input-large" rel="popover" data-content="Enter Alternative Contact Number" onkeypress="return isNumberKey(event)"
                                                                        runat="server" MaxLength="10"></asp:TextBox>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Dob</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txttenantDob" class="form-control datepicker input-large" rel="popover" data-content="Select date of Birth. Eg:11/05/1988" AutoComplete="off"
                                                                         runat="server"></asp:TextBox>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row5-->
                                                    <!--row6-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Gender</label>
                                                                <div class="col-md-9">
                                                                    <div class="testicheck">
                                                                        <asp:RadioButton ID="rbtngendertM" runat="server" Text="Male" GroupName="Tainenet" value="M"
                                                                            class="t_yes" />
                                                                        <asp:RadioButton ID="rbtngendertF" runat="server" Text="Female" GroupName="Tainenet" value="F"
                                                                            class="t_yes" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row6-->


                                                </div>
                                               <%if (Convert.ToInt32(Request.QueryString["PageID"]) == 0)
                                                 { %>
                                                <div class="form-actions">
                                                    <div class="row">
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <asp:Button ID="btnTenantsubmit" runat="server" class="btn btn-success" Text="Add Tenant Info"
                                                                OnClick="btnTenantsubmit_Click1" OnClientClick="return Tenantmembervalidtn();" />
                                                            <asp:Button ID="btnclear" runat="server" class="btn Default" Text="Clear" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <%} %>
                                                <!--Begin Add Tanent Member Table-->
                                                <div class="row" runat="server" id="TenantGrid" style="display: none;">
                                                    <div class="col-md-12">
                                                        <div class="tab-pane" id="Div4">
                                                            <div class="portlet light bordered form-fit">
                                                                <div class="portlet-title">
                                                                    <div class="caption">
                                                                        <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                                                            Tenant Master Member</span> <span class="caption-helper"></span>
                                                                    </div>
                                                                </div>
                                                                <div class="portlet-body form">
                                                                    <!-- BEGIN FORM-->
                                                                    <div class="form-horizontal" id="temptenanttable" runat="server">
                                                                        <div class="form-body">
                                                                            <!--row-->
                                                                            <div class="row">
                                                                                <div class="col-md-12">
                                                                                    <div class="table-responsive">
                                                                                        <asp:DataGrid ID="dgTenant" runat="server" class="table table-striped table-bordered table-hover"
                                                                                            AutoGenerateColumns="false" OnDeleteCommand="dgTenant_DeleteCommand" OnEditCommand="dgTenant_EditCommand"
                                                                                            ItemStyle-CssClass="GridDataLeft">
                                                                                            <HeaderStyle CssClass="GridHeadCenter"></HeaderStyle>
                                                                                            <Columns>
                                                                                                <asp:BoundColumn DataField="FlatId" HeaderText="Flat Id"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="TenantName" HeaderText="Tenant Name"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ResidingFrom" SortExpression="ResidingFrom" DataFormatString ="{0:d}" HeaderText="Residing From"  ></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ResidingTo" SortExpression="ResidingTo" HeaderText="Residing To" DataFormatString ="{0:d}"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Rent" HeaderText="Rent"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="PAN" HeaderText="PAN"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="AadhaarCard" HeaderText="Aadhaar Card"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="PermanantAddress" HeaderText="Permanant Address"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ContactNo1" HeaderText="Contact No1"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ContactNo2" HeaderText="Contact No2"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="DOB" SortExpression="DOB" HeaderText="DOB" DataFormatString ="{0:d}"></asp:BoundColumn>
                                                                                                 <asp:BoundColumn DataField="Gender" HeaderText="Gender"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Active" HeaderText="Active"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="CreatedBy" HeaderText="CreatedBy"></asp:BoundColumn>
                                                                                                <asp:TemplateColumn>
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Button ID="Delete_Button" runat="server" CssClass="btn green small" CommandName="Edit"
                                                                                                            Text="Edit"></asp:Button>
                                                                                                        <asp:Button ID="Remove_Button" runat="server" CssClass="btn red small" CommandName="Delete"
                                                                                                            Text="Remove"></asp:Button>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateColumn>
                                                                                            </Columns>
                                                                                        </asp:DataGrid>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!--/row-->
                                                                        </div>
                                                                          <%if (Convert.ToInt32(Request.QueryString["PageID"]) == 0)
                                                                            { %>
                                                                        <div class="form-actions">
                                                                            <div class="row">
                                                                                <div class="col-md-offset-3 col-md-9">
                                                                                    <asp:Button ID="btnInsertTenant" runat="server" class="btn btn-success" Text="Insert Tenant Info"
                                                                                        Style="display: none;" OnClick="btnInsertTenant_Click" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <%} %>
                                                                    </div>
                                                                    <!-- END FORM-->
                                                                </div>
                                                            </div>
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
                        <!--/Row2-->
                        <div class="clearfix">
                        </div>
                        <!--Row3 Family master-->
                        <div class="row" runat="server" id="FamilyinfoMstr" style="display: none">
                            <div class="col-md-12">
                                <div class="tab-pane" id="Div5">
                                    <div class="portlet light bordered form-fit">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                                    Family Member Master</span> <span class="caption-helper"></span>
                                            </div>
                                        </div>
                                        <div class="portlet-body form">
                                            <!-- BEGIN FORM-->
                                            <div class="form-horizontal form-row-stripped form-label-stripped">
                                                <div class="form-body">
                                                    <!--row1-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Name</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberName" class="form-control input-large" rel="popover" data-content="Enter Full Name" AutoComplete="off"
                                                                        runat="server"></asp:TextBox>
                                                                 
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Residing From</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberResfrom" class="form-control datepicker input-large" rel="popover" data-content="Residing From Eg:10/05/2014" AutoComplete="off" runat="server"></asp:TextBox>
                                                                  
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row1-->
                                                    <!--row2-->
                                                    <!--/row2-->
                                                    <!--row3-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    PAN Card Number</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberPan" AutoComplete="off" class="form-control input-large" rel="popover" data-content="Enter PAN Card Number Eg:AQWER4754D " runat="server" MaxLength="10" ></asp:TextBox>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Aadhaar Card Number</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberAdhaar" AutoComplete="off" 
                                                                        class="form-control input-large" rel="popover" data-content="Enter 12 Digit Aadhar card Number" onkeypress="return isNumberKey(event)" runat="server" MaxLength="12"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row3-->
                                                    <!--row4-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Relation</label>
                                                                <div class="col-md-9">
                                                                    <asp:DropDownList ID="drpFlatMemberRelation" class="select2 form-control input-large" runat="server"
                                                                        onchange="showrelation()">
                                                                        <asp:ListItem Value="None">--Select-</asp:ListItem>
                                                                        <asp:ListItem>Father</asp:ListItem>
                                                                        <asp:ListItem>Mother</asp:ListItem>
                                                                        <asp:ListItem>Daughter</asp:ListItem>
                                                                        <asp:ListItem>Son</asp:ListItem>
                                                                        <asp:ListItem>Other</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:TextBox ID="txtotherrelation" Style="display: none;" AutoComplete="off"
                                                                        class="form-control input-large" rel="popover" data-content="Enter Other Relation" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Dob</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberDob" class="form-control datepicker input-large" rel="popover" data-content="Enter Date Of Birth" AutoComplete="off" runat="server"></asp:TextBox>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row4-->
                                                    <!--row5-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Permanant Address</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberAddress" AutoComplete="off" 
                                                                        class="form-control input-large" rel="popover" data-content="Enter Permanant Address" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                                  
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Contact No: +91</label>
                                                                <div class="col-md-9">
                                                                    <asp:TextBox ID="txtFlatMemberConNo" AutoComplete="off"
                                                                        class="form-control input-large" rel="popover" data-content="Enter Contact No. Eg:9026845574" onkeypress="return isNumberKey(event)" runat="server" MaxLength="10"></asp:TextBox>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/Row5-->

                                                      <!--row6-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                    Gender</label>
                                                                <div class="col-md-9">
                                                                    <div class="testicheck">
                                                                        <asp:RadioButton ID="rbtnGenderfm" runat="server" Text="Male" GroupName="Family" value="M"
                                                                            class="Family_yes" />
                                                                        <asp:RadioButton ID="rbtnGenderff" runat="server" Text="Female" GroupName="Family" value="F"
                                                                            class="Family_yes" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                    <!--/row6-->

                                                </div>
                                         <%if (Convert.ToInt32(Request.QueryString["PageID"]) == 0)
                                           { %>
                                                <div class="form-actions">
                                                    <div class="row">
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <asp:Button ID="btnFamilyMemAdd" runat="server" class="btn btn-success" Text="Add Owner Info"
                                                                OnClick="btnFamilyMemAdd_Click" OnClientClick="return validateFlatmember();" />
                                                            <asp:Button ID="btnClearFamily" runat="server" class="btn Default" Text="Clear" />
                                                        </div>
                                                    </div>
                                                </div>
                                         <%} %>
                                                <!--begin Add Family member Table-->
                                                <div class="row" id="FamilyGrid" runat="server" style="display: none;">
                                                    <div class="col-md-12">
                                                        <div class="tab-pane" id="Div6">
                                                            <div class="portlet light bordered form-fit">
                                                                <div class="portlet-title">
                                                                    <div class="caption">
                                                                        <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                                                            Family Master Member</span> <span class="caption-helper"></span>
                                                                    </div>
                                                                </div>
                                                                <div class="portlet-body form">
                                                                    <!-- BEGIN FORM-->
                                                                    <div class="form-horizontal" id="tempFamilytable" runat="server">
                                                                        <div class="form-body">
                                                                            <!--row-->
                                                                            <div class="row">
                                                                                <div class="col-md-12">
                                                                                    <div class="table-responsive">
                                                                                        <asp:DataGrid ID="dgFamilyMember" class="table table-striped table-bordered table-hover"
                                                                                            runat="server" AutoGenerateColumns="false" OnDeleteCommand="dgFamilyMember_DeleteCommand"
                                                                                            OnEditCommand="dgFamilyMember_EditCommand" ItemStyle-CssClass="GridDataLeft">
                                                                                            <HeaderStyle CssClass="GridHeadCenter"></HeaderStyle>
                                                                                            <Columns>
                                                                                                <asp:BoundColumn DataField="FlatId" HeaderText="Flat Id"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Name" HeaderText="Family Member Name"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ResidingFrom" SortExpression="ResidingFrom" DataFormatString ="{0:d}" HeaderText="Residing From" ></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="ContactNo" HeaderText="Contact No"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="PAN" HeaderText="PAN"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="AadhaarCard" HeaderText="AadhaarCard"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Relation" HeaderText="Relation"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="DOB" DataFormatString ="{0:d}" SortExpression="DOB" HeaderText="DOB"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Address" HeaderText="Address"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="OtherRelation" HeaderText="Other Relation"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Gender" HeaderText="Gender"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="Active"  HeaderText="Active"></asp:BoundColumn>
                                                                                                <asp:BoundColumn DataField="CreatedBy" HeaderText="CreatedBy"></asp:BoundColumn>
                                                                                                <asp:TemplateColumn>
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Button ID="Delete_Button" runat="server" class="btn green small" CommandName="Edit"
                                                                                                            Text="Edit"></asp:Button>
                                                                                                        <asp:Button ID="Remove_Button" runat="server" class="btn red small" CommandName="Delete"
                                                                                                            Text="Remove"></asp:Button>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateColumn>
                                                                                            </Columns>
                                                                                        </asp:DataGrid>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!--/row-->
                                                                        </div>
                                                                    <%if (Convert.ToInt32(Request.QueryString["PageID"]) == 0)
                                                                      { %>
                                                                        <div class="form-actions">
                                                                            <div class="row">
                                                                                <div class="col-md-offset-3 col-md-9">
                                                                                    <asp:Button ID="btnInsertFamilymember" runat="server" class="btn btn-success" Text="Insert Family Member Info"
                                                                                        Style="display: none;" OnClick="btnInsertFamilymember_Click" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <%} %>
                                                                    </div>
                                                                    <!-- END FORM-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                         
                                            </div>
                                            </div>
                                        <!-- END FORM-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%if (Convert.ToInt32(Request.QueryString["PageID"]) != 0)
                          {%>
                        <div class="row" runat="server" id="Div3">
                            <div class="col-md-12">
                                <asp:Button ID="btnUpdate" class="btn btn-success" runat="server" OnClick="btnUpdate_Click" Text="Update" />
                                <asp:Button ID="btnCancelupdate" class="btn default" runat="server" OnClick="btnCancelupdate_Click" Text="Cancel" />
                            </div>
                        </div>
                        <%}%>

                    </div>
                    <!--/Row3-->
                </div>
                <!--END portlet-body-->
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
