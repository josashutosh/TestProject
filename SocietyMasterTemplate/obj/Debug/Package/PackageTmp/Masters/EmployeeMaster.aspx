<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="EmployeeMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.EmployeeMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">
          $(document).ready(function () {

              //$(".form-control").popover({
              //    placement: 'top',
              //    trigger: 'focus'
              //});
          });

    </script>
    <script type="text/ecmascript">
        function getFormControlvalue() {
            var Name = document.getElementById('<%=txtname.ClientID%>').value;
            var EmpNo = $('#<%=txtEmpNo.ClientID%>').val();
            var Jobdescription = $('#<%=txtJobdescription.ClientID%>').val();
            var ContactNo = $('#<%=txtContactNo.ClientID%>').val();
            var Address = $('#<%=txtAddress.ClientID%>').val();
            var Pan = $('#<%=txtPan.ClientID%>').val();
            var Aadhaarcard = $('#<%=txtAadhaarcard.ClientID%>').val();
            var Salary = $('#<%=txtSalary.ClientID%>').val();
            var Designation = $('#<%=txtDesignation.ClientID%>').val();
            var DOJ = $('#<%=txtDOJ.ClientID%>').val();
            var DOL = $('#<%=txtDOL.ClientID%>').val();


            var EmailPattern = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
            var PancardPattern = /^[A-Z]{5}\d{4}[A-Z]{1}$/;
            var IFFCPattern = /[A-Z|a-z]{4}[0][\d]{6}$/;
            var number = /^[0-9]*$/;


            if (Name == "") {
                bootbox.alert("Please Enter Full Name");
                return false;
            }
            if (EmpNo == "") {
                bootbox.alert("Please Enter Employee");
                return false;
            }

            if (ContactNo == "") {
                bootbox.alert("Please Enter Mobile Number");
                return false;
            }
            if (ContactNo.length != 10 || (!Mobilepattern.test(ContactNo))) {
                bootbox.alert("Please Enter Proper Mobile");
                return false;
            }
            if (Address == "") {
                bootbox.alert("Please Enter Address");
                return false;
            }
            if (Pan == "") {
                bootbox.alert("Please Enter your Pan no");
                return false;
            }
            if (!PancardPattern.test(Pan) || Pan.length != 10) {
                bootbox.alert("Please Enter valid Pan no");
                return false;
            }

            if (Aadhaarcard == "") {
                bootbox.alert("Please Enter 12 Digit Aadhaar Card Number");
                return false;
            }
            if (Aadhaarcard.length != 12) {
                bootbox.alert("Please Enter 12 Digit Aadhaar Card Number");
                return false;
            }

            if (Designation == "") {
                bootbox.alert("Please Enter Your Designation");
                return false;
            }
            if (DOJ == "") {
                bootbox.alert("Please Enter Date Of Joining");
                return false;
            }
            return true;
        }

        function clear() {
            $('#<%=txtname.ClientID%>').val("");
            $('#<%=txtEmpNo.ClientID%>').val("");
            $('#<%=txtJobdescription.ClientID%>').val("");
            $('#<%=txtContactNo.ClientID%>').val("");
            $('#<%=txtAddress.ClientID%>').val("");
            $('#<%=txtPan.ClientID%>').val("");
            $('#<%=txtAadhaarcard.ClientID%>').val("");
            $('#<%=txtSalary.ClientID%>').val("");
            $('#<%=txtDesignation.ClientID%>').val("");
            $('#<%=txtDOJ.ClientID%>').val("");
            $('#<%=txtDOL.ClientID%>').val("");

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
            <li><a href="../Masters/EmployeeMaster.aspx">Staff cum Vendor Information</a> </li>
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
            <div class="tab-pane" id="Div1">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Staff cum Vendor Information</span> <span class="caption-helper"></span>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-row-stripped form-label-stripped">
                            <div class="form-body">
                                <%-- <h3 class="form-section">
                                                Person Info</h3>--%>
                                <!--row1-->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Name</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtname"  AutoComplete="Off" class="form-control input-large"
                                                    runat="server"  rel="popover" data-content="Enter Full Name Eg:Name Fathername Surname" ></asp:TextBox>
                                                <span class="help-block"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Employee Number</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtEmpNo" rel="popover" data-content="Enter Employee Number Eg:SB001" AutoComplete="Off" class="form-control input-large"
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
                                                Job Description</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtJobdescription" rel="popover" data-content="Enter Job Description " AutoComplete="Off"
                                                    class="form-control input-large" runat="server"></asp:TextBox>
                                              
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Contact Number: +91</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtContactNo" class="form-control input-large" rel="popover" data-content="Enter Contact Number Eg:9025487765 " AutoComplete="Off" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server"></asp:TextBox>
                                                
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
                                                Address</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtAddress" class="form-control input-large" rel="popover" data-content="Enter Address Eg:Area name,street name,sec-22,pincode,District,state." AutoComplete="Off"
                                                    runat="server" TextMode="MultiLine"></asp:TextBox>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Pan Number</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtPan" class="form-control input-large" rel="popover" data-content="Enter Pan Number Eg:AQSPT4534D" AutoComplete="Off" MaxLength="10" runat="server"></asp:TextBox>
                                                
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
                                                Aadhaar Card</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtAadhaarcard" class="form-control input-large" rel="popover" data-content="Enter Aadhaar Card Eg:564565456481" AutoComplete="Off" MaxLength="12" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Salary (In Rs.)</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtSalary" class="form-control input-large" rel="popover" data-content="Enter Salary Eg:5000.50/5000"
                                                    AutoComplete="Off" onkeypress="return restrict(this.value, event)" runat="server"
                                                    MaxLength="10"></asp:TextBox>
                                              
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
                                                Designation</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtDesignation" rel="popover" data-content="Enter Designation Eg:Car washer" AutoComplete="Off"
                                                    class="form-control input-large" runat="server"></asp:TextBox>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="control-label col-md-3">
                                                Date Of Joining</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtDOJ" rel="popover" data-content="Enter Date Of Joining Eg:10/11/2014" AutoComplete="Off"
                                                    class="datepicker form-control input-large" runat="server"></asp:TextBox>
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
                                                Date Of Leaving</label>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="txtDOL" rel="popover" data-content="Enter Date Of Leaving Eg:10/11/2014"
                                                    class="datepicker form-control input-large" runat="server"></asp:TextBox>
                                               
                                            </div>
                                        </div>
                                    </div>
                                    <!--/span-->
                                    <!--/span-->
                                </div>
                                <!--/row6-->
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                        <asp:Button ID="btnInsertEmployee" runat="server" Text="Submit" class="btn btn-success"
                                            OnClick="btnInsertEmployee_Click" OnClientClick="return getFormControlvalue()" />
                                        <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn default" OnClientClick="clear()"/>
                                        <asp:Button ID="BtnBack" class="btn btn-success" runat="server" Text="Cancel" OnClick="BtnBack_Click" />
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
