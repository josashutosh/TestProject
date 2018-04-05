<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="OwnerRequestMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.OwnerRequestMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


<script type="text/javascript">



    $(document).ready(function () {
        $('#<%=txtDescription.ClientID%>').attr({
            maxlength: "200"
        });

        //$(".form-control").popover({
        //    placement: 'top',
        //    trigger: 'focus'
        //});
        $("#basic-info").change(function () {
           

        });


        $("#showdiv").change(function () {
            showdiv();

        });
    });

    function showdiv() {
        //lblTotalArea, SpanArea, lblCarpetArea, SpanCarpetArea, lblFlatType, SpanFlatType, SpanFlatArea, lblFlatRented, lblFlatNo, SpanFlatNo
        drpnumparking = document.getElementById('<%=drpPropertytype.ClientID %>').value;
        if (drpnumparking == "Commercial") {
            document.getElementById('<%=Commercial.ClientID %>').style.display = "block";
            document.getElementById('<%=lblTotalArea.ClientID %>').innerHTML = "Shop Area";


            document.getElementById('<%=lblFlatNo.ClientID %>').innerHTML = "Shop Number";

            document.getElementById('<%=lblFlatType.ClientID %>').innerHTML = "Shop Type";

        }

        if (drpnumparking == "Residential") {
            document.getElementById('<%=Commercial.ClientID %>').style.display = "none";
            document.getElementById('<%=lblTotalArea.ClientID %>').innerHTML = "Flat Area";

            document.getElementById('<%=lblFlatNo.ClientID %>').innerHTML = "Flat Number";

            document.getElementById('<%=lblFlatType.ClientID %>').innerHTML = "Flat Type";

        }
    }


    function flatvalidation() {
        
        $("#drpOwner").select2({ maximumSelectionSize: 1 });
    }

    
    function validate() {
        var Propertytype = document.getElementById('<%=drpPropertytype.ClientID%>').value;
        var FlatNumber = document.getElementById('<%=txtFlatNumber.ClientID%>').value;
        var Flattype = document.getElementById('<%=drpFlattype.ClientID%>').value;
        var TotalArea = document.getElementById('<%=txtTotalArea.ClientID%>').value;
        var Owner = document.getElementById('<%=drpOwner.ClientID%>').value;
        var businesstype = document.getElementById('<%=txtbusinesstype.ClientID%>').value;

        if (Propertytype == "" || Propertytype == 0) {
            bootbox.alert("Please Select Property Type");
            return false;
        }

        if (FlatNumber == "") {
            bootbox.alert("Please Enter Flat Number");
            return false;
        }

        if (Flattype == "") {
            bootbox.alert("Please Select Flat Type");
            return false;
        }

        if (TotalArea == "") {
            bootbox.alert("Please Enter Total Area");
            return false;
        }

        if (Owner == "" || Owner == 0) {
            bootbox.alert("Please Select Owner Name");
            return false;
        }

        if (Propertytype == "Commercial") {
            if (businesstype == "") {
                bootbox.alert("Please Select Business Type");
                return false;
            }
        }
        return true;
    }
        </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/FlatMaster.aspx">Flat Information</a> </li>
        </ul>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tab-pane" id="Div1">
                            <div class="portlet light bordered form-fit">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                            Flat Information</span>
                                    </div>
                                    <div class="actions">
                                       <%-- <a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                                        </i></a>--%>
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <!-- BEGIN FORM-->
                                    <div class="form-horizontal form-row-stripped form-label-stripped">
                                        <div class="form-body">
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-12 center-block">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Property Type</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList class="form-control input-medium"  onchange="showdiv();" ID="drpPropertytype" runat="server">
                                                                <asp:ListItem Selected="True" Value="" Text="--Select--"></asp:ListItem>
                                                                <asp:ListItem Value="Residential" Text="Residential"></asp:ListItem>
                                                                <asp:ListItem Value="Commercial" Text="Commercial"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                             </div>
                                            
                                            <!--row-->
                                            <div class="row">

                                                  <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="lblFlatNo" runat="server">
                                                            Flat Number</label>
                                                        <div class="col-md-9">
                                                            
                                                            <asp:TextBox ID="txtFlatNumber" runat="server" onblur="InsertBasicinfo()" class="form-control input-large" rel="popover"  AutoComplete="Off"></asp:TextBox>
                                                            <%--<asp:TextBox ID="txtnumber" runat="server" class="form-control input-large" rel="popover" AutoComplete="Off"></asp:TextBox>--%>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                              
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="lblCarpetArea" runat="server">
                                                            Flat Carpet Area</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtCarpetarea" class="form-control input-large" rel="popover" data-content="Enter Carpet Area"
                                                                runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                               
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--row-->
                                            <div class="row">
                                               <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" >
                                                            Owner Name</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="drpOwner" class="select2 form-control input-large" rel="popover" data-content="Enter Owner Name" runat="server">
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="lblTotalArea" runat="server">
                                                            Built Up Area</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtTotalArea" class="form-control input-large" rel="popover" data-content="Enter Built Up Area " runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                                
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--row-->
                                            <div class="row">
                                             

                                                  <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="lblFlatType" runat="server">
                                                            Flat Type</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="drpFlattype"  class="select2 form-control input-large"
                                                                runat="server">
                                                                <asp:ListItem Value="">--Select Flat Type--</asp:ListItem>
                                                                <asp:ListItem Value="1RK">1RK </asp:ListItem>
                                                                <asp:ListItem Value="1BHK">1BHK </asp:ListItem>
                                                                <asp:ListItem Value="1.5BHK">1.5BHK </asp:ListItem>
                                                                <asp:ListItem Value="2BHK">2BHK</asp:ListItem>
                                                                 <asp:ListItem Value="2.5BHK">2.5BHK</asp:ListItem>
                                                                <asp:ListItem Value="3BHK">3BHK</asp:ListItem>
                                                                <asp:ListItem Value="3.5BHK">3.5BHK</asp:ListItem>
                                                                <asp:ListItem Value="4BHK">4BHK</asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Is Parking Available</label>
                                                        <div class="col-md-9">
                                                           <div class="testicheck">
                                                        <asp:RadioButton ID="chkOpen11" runat="server" Text="yes" GroupName="A" class="icheck intercom_yes"
                                                            value="Open" />
                                                        <asp:RadioButton ID="chkStilt11" runat="server" Text="no" GroupName="A" class="icheck intercom_yes"
                                                            value="Stilt" />
                                                    </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>

                                            <!--/row-->
                                            <div class="row">
                                             <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="Label1" runat="server">
                                                            Rent Amount</label>
                                                        <div class="col-md-9">
                                                            
                                                            <asp:TextBox ID="txtRent" class="form-control input-large" rel="popover" data-content="Enter Rent " runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>


                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Security Deposite</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtSecuritydeposit" class="form-control input-large" rel="popover" data-content="Enter Security Deposite" runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/ commercial Row-->
                                            <div id="Commercial" runat="server">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">
                                                               License Number</label>
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtLicenseNo" runat="server" class="form-control input-large" rel="popover" data-content="Enter License Number"
                                                                    AutoComplete="Off"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">
                                                                Business type</label>
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtbusinesstype"  runat="server" class="form-control input-large" rel="popover" data-content="Enter Business type" AutoComplete="Off"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">
                                                                Description</label>
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtDescription" class="maxlentgth form-control input-large" rel="popover" data-content="Enter Description" TextMode="MultiLine" runat="server" 
                                                                   ></asp:TextBox>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                    
                                                </div>
                                            </div>
                                            <!--/End commercial Row-->
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <asp:Button ID="btnSubmit" class="btn btn-success" OnClientClick="javascript:return validate();" runat="server" Text="Submit"
                                                         />
                                                    <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                                    <asp:Button ID="btnCancel" class="btn btn-success" runat="server" Text="Cancel" />
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
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->


</asp:Content>
