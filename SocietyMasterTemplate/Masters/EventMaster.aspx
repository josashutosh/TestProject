<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="EventMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.EventMaster" ValidateRequest = "false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=txtdesc.ClientID%>').attr({
            maxlength: "300"
            });

            $('.timepicker').timepicker({
                minuteStep: 1
            });

            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});
            
    });
    </script>
    <script language="javascript" type="text/javascript">
        
        function download()
        {
            var path = document.getElementById('<%=Txtpath.ClientID%>').value;
            window.open(
            "Images/" + path + "",
            "_blank" // <- This is what makes it open in a new window.
            );
        
        }

        function EventMasterValidate() 
        {

            //var input = $('#<%=txteventname.ClientID %>').val();
            //val = Metronic.getActualVal(input); 
            // get the actual value 

        var Event = document.getElementById('<%=txteventname.ClientID %>').value;
       // var disc = document.getElementById('<%=txtdesc.ClientID %>').value;
        var eventon = document.getElementById('<%=txteventon.ClientID %>').value;
        var contactperson = document.getElementById('<%=txtContactperson.ClientID %>').value;
        var mobilenumber = document.getElementById('<%=txtMobileNumber.ClientID %>').value;
        var contri = document.getElementById('<%=txtcontribution.ClientID %>').value;
        var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;

        PancardPattern = /^[A-Z]{5}\d{4}[A-Z]{1}$/;



        if (Event == "")
         {
            bootbox.alert("Please Enter Event Name");
            document.getElementById('<%=txteventname.ClientID %>').focus();
            return false;
        }
       
      
        if (eventon == "") {
            bootbox.alert("Please Enter Event On");
            document.getElementById('<%=txteventon.ClientID %>').focus();
            return false;
        }

        if (contactperson == "") {
            bootbox.alert("Please Enter Contact Person Name");
            document.getElementById('<%=txtContactperson.ClientID %>').focus();
            return false;
        }

        if (mobilenumber == "") {
            bootbox.alert("Please Enter Contact Number");
            document.getElementById('<%=txtMobileNumber.ClientID %>').value;
            return false;
        }
        if (mobilenumber.length != 10 || !Mobilepattern.test(mobilenumber)) {
            bootbox.alert("Please Enter Contact Number");
            document.getElementById('<%=txtMobileNumber.ClientID %>').focus();
            return false;
        }

        if (contri == "") {
            bootbox.alert("Please Enter Contribution..");
            document.getElementById('<%=txtcontribution.ClientID %>').focus();
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
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/EventMaster.aspx">Event Information</a> </li>
        </ul>
        <div class="page-toolbar">
           <div class="btn-group pull-right">
      
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="portlet light bordered form-fit">
        <div class="portlet-title">
            <div class="caption">
                <i class="icon-user font-blue-hoki"></i>
                <span class="caption-subject font-blue-hoki bold uppercase">Event Information</span>
                <span class="caption-helper"></span>
            </div>
            <%--<div class="actions">
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-cloud-upload"></i>
											</a>
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-wrench"></i>
											</a>
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-trash"></i>
											</a>
										</div>--%>
        </div>
        <div class="portlet-body form">
            <!-- BEGIN FORM-->
            <div  class="form-horizontal form-bordered form-row-stripped">
                <div class="form-body">
                    <div class="form-group">
                        <label class="control-label col-md-3">Event</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txteventname" class="form-control input-large" rel="popover" data-content="Enter Event Name" AutoComplete="Off" runat="server"></asp:TextBox>
                           
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-md-3">Event On</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txteventon" class="form-control datepicker input-large" rel="popover" data-content="Select Event date" paceholder="Select Date" AutoComplete="Off" runat="server"></asp:TextBox>
                         
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-md-3">Event Time</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtEventTime" class="form-control timepicker input-large" rel="popover" data-content="Select Event Date" AutoComplete="Off" runat="server"></asp:TextBox>
                         
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-md-3">Contact Person Name</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtContactperson" class="form-control input-large" rel="popover" data-content="Enter Contact person Name" AutoComplete="Off" runat="server"></asp:TextBox>
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">Contact Number:+91</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtMobileNumber" class="form-control input-large" rel="popover" data-content="Enter Enter Mobile number" AutoComplete="Off" MaxLength="10" onkeypress="return isNumberKey(event)"
                                runat="server"></asp:TextBox>
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">Description</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtdesc" TextMode="MultiLine" class="html-editor maxlentgth form-control input-large" rel="popover" data-content="Enter Description" AutoComplete="Off" runat="server"></asp:TextBox>
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">File Upload</label>
                        <div class="col-md-9">
                            <table class="table table-advance">
                                <tr id="Path_T" runat="server">
                                    <td style="width: 15%;" class="Label">&nbsp; Additional File</td>
                                    <td class="Label" style="width: 85%">
                                        <asp:TextBox runat="server" ID="Txtpath" CssClass="TextBox"></asp:TextBox>
                                        <asp:Label runat="server" ID="lblFile" CssClass="Lable" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="Button_T" runat="server">
                                    <td style="width: 15%;" class="Label">&nbsp; 
                                    </td>
                                    <td class="Label" style="width: 70%">
                                        <asp:Button ID="btnView" runat="server" Text="View" CssClass="SaveButton"
                                            OnClientClick="javascript:return download()"  />
                                        <asp:Button ID="AddFile" runat="server" Text="Edit" CssClass="SaveButton" OnClick="AddFile_Click1" />
                                        <asp:Button ID="AddCancel" runat="server" Text="Cancel" CssClass="SaveButton" OnClick="AddCancel_Click1" />
                                    </td>
                                </tr>
                                <tr id="Upload_T" runat="server">
                                    <td style="width: 15%;" class="Label">&nbsp; Additional File</td>
                                    <td class="Label" style="width: 70%">
                                        <asp:FileUpload ID="FileUpload" runat="server" CssClass="DropDown" Width="290px" Style="cursor: pointer;" onkeypress="return false;" />
                                        &nbsp;&nbsp;<img alt="" id="imgUpload" style="display: none; height: 16px;"
                                            src="../Images/loader.gif" />
                                    </td>
                                </tr>
                            </table>
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">Contribution (In Rs.)</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtcontribution" class="form-control input-large" rel="popover" data-content="Enter Contribution" onkeypress="return restrict(this.value, event)"
                                runat="server"></asp:TextBox>
                          
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:Button ID="btnsubmit" runat="server" class="btn btn-success" Text="Submit" OnClientClick ="return EventMasterValidate();"
                                OnClick="btnsubmit_Click" />
                            <asp:Button ID="btnClear" runat="server" class="btn btn-success" Text="Clear" OnClick="btnClear_Click" />
                            <asp:Button ID="btnBack" runat="server" class="btn btn-success" Text="Back"
                                OnClick="btnBack_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- END FORM-->

        </div>
    </div>









</asp:Content>
