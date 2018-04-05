<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="FlatMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.FlatMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


<%--//var text = email.textContent || email.innerText;--%>
  <script type="text/javascript">
     
      $(document).ready(function ()
       {
          $('#<%=txtDescription.ClientID%>').attr({
              maxlength: "200"
          });

          //$(".form-control").popover({
          //    placement: 'top',
          //    trigger: 'focus'
          //});
          $("#basic-info").change(function () {
              InsertBasicinfo();

          });


          $("#showdiv").change(function ()
           {
              showdiv();
          });
      });
  </script>
    <script type="text/javascript" language="javascript">
        function hideparknginfo()
        {

        }

        function showdiv()
        {
            //lblTotalArea, SpanArea, lblCarpetArea, SpanCarpetArea, lblFlatType, SpanFlatType, SpanFlatArea, lblFlatRented, lblFlatNo, SpanFlatNo
            drpnumparking = document.getElementById('<%=drpPropertytype.ClientID %>').value;
            if (drpnumparking == "Commercial")
            {
                document.getElementById('<%=Commercial.ClientID %>').style.display = "block";
                document.getElementById('<%=lblTotalArea.ClientID %>').innerHTML = "Shop Area";


                document.getElementById('<%=lblFlatNo.ClientID %>').innerHTML = "Shop Number";


                document.getElementById('<%=lblFlatRented.ClientID %>').innerHTML = "Shop Rented Information";

                document.getElementById('<%=lblFlatType.ClientID %>').innerHTML = "Shop Type";

            


                document.getElementById('<%=drpFlattype.ClientID %>').style.display = "none";
                document.getElementById('<%=DivFlattype.ClientID %>').style.display = "none";
                document.getElementById('<%=divCarpetarea.ClientID %>').style.display = "none";
               
                 
            }
            
            if (drpnumparking == "Residential") {
                document.getElementById('<%=DivFlattype.ClientID %>').style.display = "block";
                document.getElementById('<%=divCarpetarea.ClientID %>').style.display = "block";
                document.getElementById('<%=Commercial.ClientID %>').style.display = "none";
                document.getElementById('<%=lblTotalArea.ClientID %>').innerHTML = "Flat Area";


                document.getElementById('<%=lblFlatNo.ClientID %>').innerHTML = "Flat Number";


                document.getElementById('<%=lblFlatRented.ClientID %>').innerHTML = "Flat Rented Information";

                document.getElementById('<%=lblFlatType.ClientID %>').innerHTML = "Flat Type";
               
                
            }
        }



       function validate()
        {
            var Propertytype=document.getElementById('<%=drpPropertytype.ClientID%>').value;
            var FlatNumber = document.getElementById('<%=txtFlatNumber.ClientID%>').value;
            var Flattype = document.getElementById('<%=drpFlattype.ClientID%>').value;
            var BuildingID = document.getElementById('<%=drpBuildingID.ClientID%>').value;
            var carpetArea = document.getElementById('<%=txtCarpetarea.ClientID%>').value;
            var TotalArea = document.getElementById('<%=txtTotalArea.ClientID%>').value;
            var IScertificate = document.getElementById('<%=chkcertificate.ClientID%>');
           var businesstype = document.getElementById('<%=txtbusinesstype.ClientID%>').value;
            
           if (Propertytype == "" || Propertytype == 0)
           {
               bootbox.alert("Please Select Property Type");
               return false;
           }

           if (BuildingID == "") {
               bootbox.alert("Please Select Building Name");
               return false;
           }

           if (Propertytype == "Commercial")
            {
                if (FlatNumber == "")
                {
                   bootbox.alert("Please Enter Shop Number");
                   return false;
                }
            
               if (TotalArea == "") {
                   bootbox.alert("Please Enter Shop Area");
                   return false;
               }
              
               if (businesstype == "") 
               {
                   bootbox.alert("Please Select Business Type");
                   return false;
               }
           }
           else if (Propertytype == "Residential")
            {
                if (FlatNumber == "") 
                   {
                       bootbox.alert("Please Enter Flat Number");
                       return false;
                   }

                   if (Flattype == "") 
                   {
                       bootbox.alert("Please Select Flat Type");
                       return false;
                   }
                   if (TotalArea == "")
                    {
                       bootbox.alert("Please Enter Flaat Area");
                       return false;
                   }
           }

           return true;
       }
   
            function InsertBasicinfo() {

                var buildingid = $('#<%=drpBuildingID.ClientID %>').find('option:selected').text();
                var FlatNumber = document.getElementById('<%=txtFlatNumber.ClientID%>').value;
                $('#<%=txtnumber.ClientID %>').val(buildingid + " - " + FlatNumber);
            }
            
    </script>
    <style type="text/css">
        .center-block {  
  display: block;  
  margin-right: auto;  
  margin-left: auto;  
}  
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
 
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
                                            <div class="row">

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            Wing Name</label>
                                                        <div class="col-md-9">
                                                            <asp:DropDownList ID="drpBuildingID" class="select2 form-control input-large" onchange="InsertBasicinfo();"
                                                                runat="server">
                                                                
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                              
                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="lblFlatRented" runat="server">
                                                            Flat Rented Information</label>
                                                        <div class="col-md-9">
                                                            <asp:RadioButton ID="rbtnRented1" runat="server" Text="Yes" GroupName="A" class="rented_yes"
                                                                value="1" />
                                                            <asp:RadioButton ID="rbtnRented2" Checked="true" runat="server" Text="No" GroupName="A" class="rented_yes"
                                                                value="0" />
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
                                                        <label class="control-label col-md-3" id="lblFlatNo" runat="server">
                                                            Flat Number</label>
                                                        <div class="col-md-9">
                                                            
                                                            <asp:TextBox ID="txtFlatNumber" runat="server" onblur="InsertBasicinfo()" class="form-control input-large" rel="popover"  AutoComplete="Off"></asp:TextBox>
                                                            <asp:TextBox ID="txtnumber" runat="server" class="form-control input-large" rel="popover" AutoComplete="Off"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                </div>

                                               
                                              
                                                <!--/span-->
                                                <div class="col-md-6" id="divCarpetarea" runat="server">
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
                                                           </label>
                                                        <div class="col-md-9">
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
                                             

                                                  <div class="col-md-6" id="DivFlattype" runat="server">
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
                                                            share Certificate Issued?</label>
                                                        <div class="col-md-9">
                                                            <asp:CheckBox ID="chkcertificate" runat="server" class="icheck" 
                                                                oncheckedchanged="chkcertificate_CheckedChanged"/>
                                                         <label id="lblcertificateNo" style="display:none;">Certificate Number </label>  <asp:TextBox ID="Txtsharecertificateno" runat="server" Visible="false"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            <!--/ commercial Row-->
                                            <div id="Commercial" runat="server">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3">
                                                               License Number</label>
                                                            <div class="col-md-9">
                                                                <asp:TextBox ID="txtLicenseNo" runat="server" class="form-control input-large" 
                                                                    rel="popover" data-content="Enter License Number"
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
                                                    <asp:Button ID="btnSubmit" class="btn btn-success" OnClientClick="javascript:return validate();" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                                         />
                                                    <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear" />
                                                    <asp:Button ID="btnCancel" class="btn btn-success" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
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
