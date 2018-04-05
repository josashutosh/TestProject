<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="BuildingMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.BuildingMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <script type="text/javascript">
     $(document).ready(function () {
      
          //$(".form-control").popover({
          //    placement: 'top',
          //    trigger: 'focus'
          //});
      });

    </script>


<script language="javascript" type="text/javascript">
 

   
    function buildingvalidation() {



// var input = $('#<%=txtBuildingname.ClientID %>').val();
// val = Society.getActualVal(input); 
        var buildingname = document.getElementById('<%=txtBuildingname.ClientID%>').value;
        var floor = document.getElementById('<%=txtFloors.ClientID%>').value;
        var flats = document.getElementById('<%=txtFlats.ClientID%>').value;
        var totalarea = document.getElementById('<%=txtArea.ClientID%>').value;

        if (buildingname == "") {
            bootbox.alert("Enter Building name");
            return false;
        }
        if (flats == "") {
            bootbox.alert("Enter Number of Flats");
            return false;
        }
        if (floor == "") {
            bootbox.alert("Enter Number of Floors");
            return false;
        }
        
        if (totalarea == "") {
            bootbox.alert("Enter Total Area");
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
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/BuildingMasterView.aspx">Building/Wings Information</a> </li>
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
            <div class="tab-pane" id="tab_2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Building/Wings Information</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                           <%-- <a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle"></i></a>
                            <a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-cloud-upload">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-wrench">
                            </i></a><a class="btn btn-circle btn-icon-only btn-default" href="#"><i class="icon-trash">
                            </i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div  class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group" id="societynameddl" runat="server" visible="false">
                                    <label class="control-label col-md-3">
                                        Society Name</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="ddlSocietyName" AutoComplete="off" class="form-control input-large" runat="server" rel="popover" data-content="Please Select Society Name"></asp:DropDownList>
                                    </div>
                                </div>
                              <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Wing Name</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtBuildingname" AutoComplete="off" class="form-control input-large" runat="server" rel="popover" data-content="Enter Wing Name"></asp:TextBox>
                                        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Number of Flats</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtFlats" AutoComplete="off" class="form-control input-large"
                                            onkeypress="return isNumberKey(event)" runat="server" rel="popover" data-content="Enter Number of Flats e.g:10"  ></asp:TextBox>
                                      
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Number of Floors</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtFloors" class="form-control input-large" AutoComplete="off" 
                                            onkeypress="return isNumberKey(event)" runat="server" rel="popover" data-content="Enter Number Of Floors. Eg:15" ></asp:TextBox>
                                       
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Total Area(In Sqft)</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtArea" class="form-control input-large"  onkeypress="return isNumberKey(event)" runat="server" rel="popover" data-content="Enter Total Area Eg:5000"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                    
                                        <asp:Button ID="btnBuildingSubmit" runat="server" Text="Submit" class="btn btn-success"
                                            OnClick="btnBuildingSubmit_Click" OnClientClick="return buildingvalidation()" />
                                            <asp:Button ID="btnClear"  class="btn default" runat="server" Text="Clear" 
                                            onclick="btnClear_Click"  />
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
    <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
</asp:Content>
