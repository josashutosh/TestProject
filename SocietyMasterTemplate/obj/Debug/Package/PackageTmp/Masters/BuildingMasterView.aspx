﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masterview.Master" AutoEventWireup="true" CodeBehind="BuildingMasterView.aspx.cs" Inherits="EsquareMasterTemplate.Masters.BuildingMasterView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
         $(document).ready(function () {

             //$(".form-control").popover({
             //    placement: 'top',
             //    trigger: 'focus'
             //});
         });

    </script>
   <script type="text/javascript" language="javascript">
//       $(document).ready(function () {
//           // $("table span > span").find("span").css({ "color": "red", "border": "2px solid red" });
//           $("table span > span").addClass("btn btn-success");
       //       });

       function ValidateDel() {
           var res = confirm('are you sure you want to delete ?');
           if (res == false) {
               return false;
           }
           return true;
       }

       function chkSelectAll()
        {
           var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
           var rowscount = document.getElementById('Main_lvBuildMstr').rows.length;

           for (var i = 0; i <= rowscount - 3; i++) {
               var chkselect = document.getElementById('MainContent_lvBuildMstr_ctrl'+ i +'_chkselect_' + i);
               var chkAll = document.getElementById('MainContent_lvBuildMstr_chkAll');
               var hdnID = document.getElementById('MainContent_lvBuildMstr_ctrl'+ i +'_hdnbuildingID_' + i);

               if (chkAll.checked == true) {
                   $('#<%=btnDelete.ClientID %>').fadeIn('slow');
                   chkselect.checked = true;
                   hdnAllID.value = hdnAllID.value + hdnID.value + ',';
               }
               else {
                   $('#<%=btnDelete.ClientID %>').fadeOut('slow');
                   chkselect.checked = false;
                   hdnAllID.value = '';
               }
           }

       }

       function CheckSelect(ID) 
       {
           var chkAll = document.getElementById('MainContent_lvBuildMstr_chkAll');
           var hdnID = document.getElementById(ID.replace('chkselect', 'hdnbuildingID'));
           var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
           var chkIndi = document.getElementById(ID);

           if (chkIndi.checked) {
               $('#<%=btnDelete.ClientID %>').fadeIn('slow');
               hdnAllID.value = hdnAllID.value + hdnID.value + ',';
           }
           else {
               hdnAllID.value = hdnAllID.value.replace(hdnID.value + ',', '');
               if (hdnAllID.value.length == 0) {
                   $('#<%=btnDelete.ClientID %>').fadeOut('slow');
               }
           }

           chkAll.checked = false;
       }

       function ValidateMultiDelete() 
       {
           // var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
           var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
           if (hdnAllID.value === "") {
               alert('No items were selected!');
               return false;
           }
           else {
               var res = confirm('Are you sure you want to delete?');
               if (res === false) {
                   return false;
               }
               else {
                   return true;
               }
           }
       }

       function rtnaddzero(a) {
           var a1 = "";
           if (a > 0 && a <= 9) {
               a1 = "0" + a;
               return a1;
           }
           else if (a > 9 || a == 0) {
               a1 = a;
               return a1;
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
            <li><a href="../Masters/BuildingMasterView.aspx">Building/Wings Information View</a> </li>
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
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div  class="form-horizontal">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Search</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="txtsearch" style="display:inline !important;" AutoComplete="off" class="form-control input-large" runat="server" rel="popover" data-content="Enter Building Name"></asp:TextBox>
                                        &nbsp;
                                    <asp:Button class="btn btn-success btn-sm" style="display:inline !important;"  ID="btnSearch" runat="server" Text="Search" 
                                        onclick="btnSearch_Click"  />
                                        <asp:Button ID="btnAdd" style="display:inline !important;" 
                                            class="btn btn-success btn-sm" runat="server" Text="Add" 
                                            onclick="btnAdd_Click" />
                                        <asp:Button ID="btncancel" style="display:inline !important;"
                                            runat="server" class="btn btn-success btn-sm" Text="Cancel" 
                                            onclick="btncancel_Click" />
                                                                         
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

     <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="Div2">
                <div class="portlet light bordered form-fit">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-user font-blue-hoki"></i><span class="caption-subject font-blue-hoki bold uppercase">
                                Building/Wings Information View</span> <span class="caption-helper"></span>
                        </div>
                        <div class="actions">
								<div class="btn-group">
									   <asp:ImageButton ID="imgExport" runat="server" Style=" width: 40px;height: 32px; padding: 0px;margin: 0px;" ImageUrl="~/Images/excel.png" onclick="imgExport_Click" Visible="true"/>
								</div>
							</div>
                        
                    </div>
                    <div class="portlet-body form">
                        <!-- Begin Toolbar-->
                         <div class="table-toolbar">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="btn-group">
                                           <asp:Button ID="btnDelete" style="display:none !important;" 
                                                class="btn btn-sm red" OnClientClick="javascript:return ValidateMultiDelete();" runat="server" Text="Delete" onclick="btnDelete_Click1" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="btn-group pull-right">
                                              <!--End button-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <!--End ToolBar-->
                        <!-- BEGIN list View-->
                        <div class="table-responsive">
                            <asp:ListView ID="lvBuildMstr" class="table-responsive" runat="server" GroupPlaceholderID="groupPlaceHolder1"
                        ItemPlaceholderID="itemPlaceHolder1" 
                                OnPagePropertiesChanging="OnPagePropertiesChanging"  >
                        <LayoutTemplate>
                            <table id="Main_lvBuildMstr" class="table table-striped table-bordered table-hover">
                             <thead>
                                 <tr>
                                     <th class="table-checkbox">
                                      
                                         <asp:CheckBox ID="chkAll" class="group-checkable" onclick="javascript:chkSelectAll();" runat="server" />
                                        </th>
                                     <th>
                                         Society Name
                                     </th>
                                     <th>
                                         Building Name
                                     </th>
                                     <th>
                                         Number of Floors
                                     </th>
                                     <th>
                                         Number of Flats
                                     </th>
                                     <th>
                                         Action
                                     </th>
                                     
                                 </tr>
                                </thead>
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                <tr>
                                    <td colspan="6">
                                        <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvBuildMstr" QueryStringField="page" PageSize="20">
                                            <Fields>
                                         
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                    ShowNextPageButton="false" ButtonCssClass="btn btn-xs red" />

                                                <asp:NumericPagerField ButtonType="Link" NumericButtonCssClass="btn default" />
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false"
                                                    ShowPreviousPageButton="false"  ButtonCssClass="btn btn-xs green" />

                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <tr>
                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                               
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                           <td>
                             
                                <asp:CheckBox ID="chkselect" class="group-checkable" onclick="javascript:CheckSelect(this.id);" runat="server" />
                           </td>
                            <td>
                                <%# Eval("SocietyName")%>
                            </td>
                            <td>
                            <asp:HiddenField ID="hdnbuildingID" Value='<%#Eval("BuildingId") %>' runat="server" />
                                <%# Eval("Name")%>
                            </td>
                            <td>
                                <%# Eval("Floors")%>
                            </td>
                            <td>
                                <%# Eval("Flats")%>
                            </td>
                            <td>
                                <asp:HyperLink ID="HyperLink1" class="btn green btn-sm" NavigateUrl='<%#"~/Masters/BuildingMaster.aspx?PId=4&amp;BuildingId=" + Eval("[BuildingId]").ToString()%>' runat="server">Edit</asp:HyperLink>
                           
                          <%--      <asp:LinkButton runat="server" OnClick="Content_Load" class="btn" ID="deletelinkbutton">Delete</asp:LinkButton>--%>

                                <%--<asp:Button ID="btndelete" class="btn red small" OnClick="btndelete_Click" OnClientClick="javascript:return ValidateDel();" runat="server" Text="Delete" />--%>
                               <%-- <asp:Button ID="Button1" runat="server" OnClientClick="ValidateDel(); return false;" Text="delete Delete" />--%>
                            </td>
                        </ItemTemplate>
                    </asp:ListView>

                     <input id="hdnAllID" type="hidden" runat="server" />
                        </div>
                        <!-- END list View-->
                    </div>
                </div>
            </div>
        </div>
    </div>
     <!-- ------------------------------------------------------------END PAGE CONTENT-------------------------------------------------------------------------------->
   
</asp:Content>
