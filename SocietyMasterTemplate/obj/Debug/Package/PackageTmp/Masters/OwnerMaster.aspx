<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    EnableEventValidation="false" ValidateRequest="false" CodeBehind="OwnerMaster.aspx.cs"
    Inherits="EsquareMasterTemplate.Masters.OwnerMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            //$(".form-control").popover({
            //    placement: 'top',
            //    trigger: 'focus'
            //});

            $(".owner_yes label,.owner_yes ins").click(function () {
                val = $('#<%=chkconfirm.ClientID%>').val();

                if ((document.getElementById('<%=chkconfirm.ClientID%>').checked) === true) {
                    $('#<%=tempaddress.ClientID%>').hide('slow');
                }
                else {
                    $('#<%=tempaddress.ClientID%>').show('slow');
                }

            });

            $(".owner_yes label,.owner_yes ins").click(function () {
                val = $('#<%=chkCommitemem.ClientID%>').val();

                if ((document.getElementById('<%=chkCommitemem.ClientID%>').checked) === true) {
                    $('#<%=designation.ClientID%>').show('slow');
                    $('#<%=effectivefrom.ClientID%>').show('slow');

                }
                else {
                    $('#<%=designation.ClientID%>').hide('slow');
                    $('#<%=effectivefrom.ClientID%>').hide('slow');
                }

            });
        });
        function hideparknginfo() {

            val = $('#<%=chkconfirm.ClientID%>').val();


            if ((document.getElementById('<%=chkconfirm.ClientID%>').checked) === true) {
                $('#<%=tempaddress.ClientID%>').hide('slow');
            }
            else {
                $('#<%=tempaddress.ClientID%>').show('slow');
            }


            val2 = $('#<%=chkCommitemem.ClientID%>').val();
            if ((document.getElementById('<%=chkCommitemem.ClientID%>').checked) === true) {
                $('#<%=designation.ClientID%>').show('slow');
                $('#<%=effectivefrom.ClientID%>').show('slow');
            }
            else {
                $('#<%=designation.ClientID%>').hide('slow');
                $('#<%=effectivefrom.ClientID%>').hide('slow');
            }
        }
    </script>
    <script type="text/javascript" language="javascript">

        function OwnerValidation() {
            var ownrname = document.getElementById('<%=txtOwnername.ClientID%>').value;
            var contctnum = document.getElementById('<%=txtcontactno.ClientID%>').value;
            var occupatn = document.getElementById('<%=txtOccupatn.ClientID%>').value;

            var officenum = document.getElementById('<%=txtOfficeno.ClientID%>').value;
            var pan = document.getElementById('<%=txtPanno.ClientID%>').value;
            var adharno = document.getElementById('<%=txtAdharno.ClientID%>').value;
            var residingfrm = document.getElementById('<%=txtresidence.ClientID%>').value;
            var dob = document.getElementById('<%=txtDOB.ClientID%>').value;
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
            var PancardPattern = /^[A-Za-z]{5}\d{4}[A-Za-z]{1}$/;
            var landlinenopattrn = /^([0-9]{3}[0-9]{5,8})$/;

            if (ownrname == "") {
                bootbox.alert("Enter Owner name");
                return false;
            }

            if (contctnum == "")
             {
                bootbox.alert("Enter Contact number");
                return false;
            }

          
           if (occupatn == "") {
               bootbox.alert("Enter Occupation");
               return false;
           }

//            if (officenum != "") {

//                if ((!landlinenopattrn.test(officenum)) && (!Mobilepattern.test(officenum))) {
//                    bootbox.alert("Your Office Contact Number is Wrong");
//                    return false;
//                }
//            }

           if (pan == "") {
               bootbox.alert("Enter PAN");
               return false;
           }

            if (pan.length != 10 || (!PancardPattern.test(pan))) {
                bootbox.alert("Your Pancard number is not valid");
                return false;
            }
            if (adharno == "") {
                bootbox.alert("Enter Adhaarcard number");
                return false;
            }
            if (adharno.length != 12) {
                bootbox.alert("your Adhaarcard number is not valid");
                return false;
            }
            if (residingfrm == "") {
                bootbox.alert("Enter Residing From");
                return false;
            }
            if (dob == "") {
                bootbox.alert("Enter Date of Birth");
                return false;
            }
            chkSelectAll();
            return true;
        }

     
        function FillFlatList()
         {
            var societyId = document.getElementById('<%=ddlSocietyName.ClientID %>').value;
               
            if (societyId != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "OwnerMaster.aspx/GetFlatList",
                    data: "{'societyId':'" + societyId + "'}",
                    dataType: "json",
                    success: AjaxSucceeded,
                    error: AjaxFailed
                });
            }
            else {
            }
        }

          function AjaxSucceeded(response) 
          {
            BindCheckBoxList(response);
           // bindFlatId(response);
        }

        function bindFlatId(response)
        {

           
                 var Result = JSON.parse(response.d);

                  $('#<%=drpDesignation.ClientID %>').empty();

                  if (Result.length > 0) 
                  {
                      var data = [];
                      var group="";
                      for (var i = 0; i < Result.length; i++) {
                        // group=  group+"{label: "+"" +Result[i].Name+""+", value: "+""+Result[i].FlatId+""+"},";
                       
                        group=group+ "{label: '"+Result[i].Name+"', value: '"+Result[i].FlatId+"'}";
                        // $('#<%=drpDesignation.ClientID %>').append("<option value=" + Result[i].FlatId + ">" +
                         // Result[i].Name + "</option>");
                      }

                      data.push(group);
                        $('#<%=drpDesignation.ClientID %>').multiselect('dataprovider', data);
                  }
                  $('#<%=drpDesignation.ClientID %>').multiselect('rebuild');
                  $('#<%=drpDesignation.ClientID %>').prepend("<option value='' selected='selected'>--Select Owner Name--</option>");
        
        }

        function AjaxFailed(result) {
            alert('Failed to load checkbox list');
        }
        function BindCheckBoxList(result) {
            var hdnFlatCnt = document.getElementById('<%=hdnFlatCnt.ClientID %>');
            var items = JSON.parse(result.d);
            hdnFlatCnt.value = items.length;
            if(items.length > 0 )
            {CreateCheckBoxList(items);}
            else {alert('Owner Information For all The Flat in This Society is Completed');}
        }
        function CreateCheckBoxList(checkboxlistItems) {
            $('#FlatNumberlist').empty();
            var table = $('<table></table>');
            var counter = 0;
            $(checkboxlistItems).each(function () {
                table.append($('<tr></tr>').append($('<td></td>').append($('<input>').attr({
                    type: 'checkbox', name: 'chklistitem', value: this.FlatId, id: 'chklistitem' + counter
                })).append(
                $('<label>').attr({
                    for: 'chklistitem' + counter++
                }).text(this.Name))));
            });
 
            $('#FlatNumberlist').append(table);
        }

        function chkSelectAll() 
        {
            var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
            var hdnFlatCnt = document.getElementById('<%=hdnFlatCnt.ClientID %>');
          
            for (var i = 0; i < hdnFlatCnt.value; i++) {
                var chkselect = document.getElementById('chklistitem' + i );
                var hdnID = document.getElementById('chklistitem' + i).value;
          
                if (chkselect.checked == true) {
                    chkselect.checked = true;
                    hdnAllID.value = hdnAllID.value + hdnID + ',';
          
                }
                else
                {
                   chkselect.checked = false;
                }
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
            <li><a href="../Masters/OwnerMasterView.aspx">Owner Information</a> </li>
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
                                            Owner Information</span>
                                    </div>
                                    <div class="actions">
                                        <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                                        </i></a>--%>
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <!-- BEGIN FORM-->
                                    <div class="form-horizontal form-row-stripped form-label-stripped">
                                        <div class="form-body">
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Enter Flat Owner Name
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtOwnername" class="form-control input-large" rel="popover" data-content="Enter Flat Owner Name"
                                                                runat="server" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Office Contact Number
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtOfficeno" class="form-control input-large" rel="popover" data-content="Enter office contact number"
                                                                MaxLength="12" runat="server" onkeypress="return isNumberspecialcharKey(event)"
                                                                autocomplete="off"></asp:TextBox>
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
                                                        <label class="control-label col-md-3">
                                                            Contact Number</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtcontactno" class="form-control input-large" rel="popover" data-content="Enter Mobile Number"
                                                                MaxLength="10" onkeypress="return isNumberKey(event)" runat="server" autocomplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            PAN Number</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtPanno" class="form-control input-large" rel="popover" data-content="Enter Pan Nmber"
                                                                MaxLength="10" runat="server" AutoComplete="off"></asp:TextBox>
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
                                                        <label class="control-label col-md-3">
                                                            Occupation</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtOccupatn" class="form-control input-large" rel="popover" data-content="Enter occupation"
                                                                runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Aadhar Card
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtAdharno" class="form-control input-large" rel="popover" data-content="Enter Adhaar card Number"
                                                                onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" AutoComplete="off"></asp:TextBox>
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
                                                        <label class="control-label col-md-3">
                                                            Permanent Address
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtperAddress" class="form-control input-large" rel="popover" data-content="Enter Permanent Address"
                                                                runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Is Committee Member</label>
                                                        <div class="col-md-9">
                                                            <asp:CheckBox ID="chkCommitemem" Checked="true" class="icheck" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group" runat="server" id="designation">
                                                        <label class="control-label col-md-3">
                                                            Designation</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="drpDesignation" runat="server" class="select2 form-control input-large">
                                                                <asp:ListItem Value="0">--Select Designation--</asp:ListItem>
                                                                <asp:ListItem Value="Chairman">Chairman / President</asp:ListItem>
                                                                <asp:ListItem Value="Secretary">Secretary</asp:ListItem>
                                                                <asp:ListItem Value="JoinSecretary">Join Secretary</asp:ListItem>
                                                                <asp:ListItem Value="Treasurer">Treasurer</asp:ListItem>
                                                                <asp:ListItem Value="JoinTreasurer">JoinTreasurer</asp:ListItem>
                                                                <asp:ListItem Value="Member">Member</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" runat="server" id="effectivefrom">
                                                        <label class="control-label col-md-3">
                                                            Effective From</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtEffectvfrm" class="form-control datepicker input-large" runat="server"
                                                                AutoComplete="off" rel="popover" data-content="Enter Effective From"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            As Above Permanant Addrress
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:CheckBox ID="chkconfirm" class="icheck owner_yes" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Residing From
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtresidence" class="form-control datepicker input-large" rel="popover"
                                                                data-content="Enter Date" runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--row-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group" runat="server" id="tempaddress">
                                                        <label class="control-label col-md-3">
                                                            Temporary Address
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txttempaddress" class="form-control input-large" rel="popover" data-content="Enter Temporary Address"
                                                                runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Date Of Birth</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtDOB" class="form-control datepicker input-large" rel="popover"
                                                                data-content="Enter Date Of Birth" runat="server" AutoComplete="off"></asp:TextBox>
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
                                                        <label class="control-label col-md-3">
                                                            Office Address</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtOffaddr" class="form-control input-large" rel="popover" data-content="Enter Office Address"
                                                                runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                        </label>
                                                        <div class="col-md-9">
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <div class="caption">
                                                <span class="caption-subject font-blue-hoki bold uppercase">Flat Information</span>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Society Name</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="ddlSocietyName" AutoComplete="off" class="form-control input-large"
                                                                runat="server" rel="popover" data-content="Please Select Society Name" onchange="FillFlatList();">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                                <%--  <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">Wing Name
                                                        </label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="DrpFlatID" class="select2 form-control input-large" onchange="FillFlatList();" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <!--/span-->
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Flat Number</label>
                                                        <div class="col-md-9">
                                                            <div id="FlatNumberlist" class="scroller" style="height: 305px;" data-always-visible="1"
                                                                data-rail-visible1="1">
                                                            </div>
                                                            <asp:Label ID="lblFlatnumber" Visible="false" runat="server"></asp:Label>
                                                        </div>
                                                        <!--/span-->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="control-label col-md-3">
                                                                </label>
                                                                <div class="col-md-9">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--/span-->
                                                    </div>
                                                </div>
                                                <div class="form-actions">
                                                    <div class="row">
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                                                OnClientClick="return OwnerValidation()" />
                                                            <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" OnClick="btnClear_Click" />
                                                            <asp:Button ID="btnCancel" class="btn btn-success" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input id="hdnFlatCnt" type="hidden" runat="server" />
                                            <input id="hdnAllID" type="hidden" runat="server" />
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
