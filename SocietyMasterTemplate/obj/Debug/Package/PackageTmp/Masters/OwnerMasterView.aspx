<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Masterview.Master" AutoEventWireup="true" CodeBehind="OwnerMasterView.aspx.cs" Inherits="EsquareMasterTemplate.Masters.OwnerMasterView" EnableEventValidation="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript" language="javascript">
    //       $(document).ready(function () {
    //           // $("table span > span").find("span").css({ "color": "red", "border": "2px solid red" });
    //           $("table span > span").addClass("btn btn-success");
    //       });

    $(document).ready(function () {

        //$(".form-control").popover({
        //    placement: 'top',
        //    trigger: 'focus'
        //});
        $(".display-popup").click(function () {
            $("#UploadOwnerInfo").modal('show');
            $('#DuplicateRecordTable').append("");
            $('#<%=hdnDate.ClientID %>').val("");
            $('#<%=hdnOwnersId.ClientID %>').val("");
            $('#<%=hdnUniqueKey.ClientID %>').val("");
            $('#<%=HdnSocityId.ClientID %>').val("");
        });

        $("#btnExcelUpload").click(function (evt) {
            var fileUpload = $('#<%=fupload.ClientID %>').get(0);
            var files = fileUpload.files;
            showdiv();
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
                data.append("FilePath", "Owner");
            }

            $.ajax({
                url: "../Common/Handler/UploadFile.ashx",
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (response) {
                    // alert(result);
                    var Result = response;
                    if (Result != "") {
                        InsertExcelData(Result);
                    }

                },
                error: function (err) {
                    alert(err.statusText)
                    HideDiv();
                }
            });

            evt.preventDefault();
        });

    });

 

        function InsertExcelData(Response) 
        {
            var Filepath = Response;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "OwnerMasterView.aspx/InsertExcelDataToTempFlatmster",
                data: "{'Filepath':'" + Filepath + "'}",
                dataType: "json",
                success: function (response) {
                    var result = response.d;
                    result = JSON.parse(response.d);
                    if (result.ByOwnerMaster.length > 0) {

                        var table = "";
                        table += '<table class="table table-striped table-hover">';
                        table += '<table class="table table-striped table-hover">';
                        table += '<thead><tr><th> #</th><th> BuildingName </th><th> Flat Number </th><th>Is Rented</th><th>Flat Type</th><th>PropertyType</th></tr></thead><tbody>';

                        for (i = 0; i < result.ByOwnerMaster.length; i++) {
                            table += '<tr><td>/td>';
                            table += '<td>' + result.ByOwnerMaster[i].OwnerName + '</td>';
                            table += '<td>' + result.ByOwnerMaster[i].Occupation + '</td>';
                            table += '<td>' + result.ByOwnerMaster[i].IsCommiteeMember + '</td>';
                            table += '<td>' + result.ByOwnerMaster[i].ResidingFrom + '</td></tr>';
                        }

                        table += '</tbody></table><div id="UploadButton"></div>';


                        $('#DuplicateRecordTable').empty();
                        $('#DuplicateRecordTable').append(table);

                        //hdnOwnersId

                        $('#<%=hdnDate.ClientID %>').val(result.ByOwnerMaster[0].Date);
                        $('#<%=HdnSocityId.ClientID %>').val(result.ByOwnerMaster[0].SocietyId);
                        $('#<%=hdnUniqueKey.ClientID %>').val(result.ByOwnerMaster[0].UniqueId);

                        HideDiv();
                    }
                    else 
                    {
                        toastr.warning("");
                    }
                    HideDiv();

                },
                error: function (Result) 
                {
                    alert("Error");
                    HideDiv();
                }
            });

        }


        function GetOwnerId(identifier) 
        {
            var FlatId = "";
            var array;

            array = $('#<%=hdnOwnersId.ClientID %>').val().split(',');

            FlatId = document.getElementById(identifier).value;
            if (document.getElementById(identifier).checked == true) 
            {

                array.push(FlatId);
                if (array.length > 1) 
                {
                    $('#<%=hdnOwnersId.ClientID %>').val(array.join(','));
                }

            }
            else
             {
                var index = array.indexOf(FlatId);
                if (index > -1)
                 {
                    array.splice(index, 1);
                    $('#<%=hdnOwnersId.ClientID %>').val(array.join(','));
                 }
            }

        }


        function UpdateDuplicateRecords() {

            if ($('#<%=HdnSocityId.ClientID %>').val() != "") {
                var OwnerId = $('#<%=hdnOwnersId.ClientID %>').val().substring(1);
                var date = $('#<%=hdnDate.ClientID %>').val();
                var uniqueKey = $('#<%=hdnUniqueKey.ClientID %>').val()
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "OwnerMasterView.aspx/UpdateDuplicateFlatinfo",
                    data: "{'OwnerIds':'" + OwnerId + "','Date':'" + date + "','UniqueKey':'" + uniqueKey + "'}",
                    dataType: "json",
                    success: function (response) {
                        if (response.d != "") {
                            toastr.warning(response.d);
                            $('#DuplicateRecordTable').empty();
                        }
                        HideDiv();
                    },
                    error: function (response) {
                        alert("Error");
                        HideDiv();
                    }
                });
            }
        }

    function ValidateDel() 
    {
        var res = confirm('are you sure you want to delete ?');
        if (res == false) 
        {
            return false;
        }
        return true;
    }

    function chkSelectAll()
     {
        var hdnAllID = document.getElementById('<%=hdnAllID.ClientID %>');
        var rowscount = document.getElementById('Main_lvowner').rows.length;

        for (var i = 0; i <= rowscount - 3; i++) {
            var chkselect = document.getElementById('MainContent_lvowner_ctrl' + i + '_chkselect_' + i);
            var chkAll = document.getElementById('MainContent_lvowner_chkAll');
            var hdnID = document.getElementById('MainContent_lvowner_ctrl' + i + '_hdnownerID_' + i);

            if (chkAll.checked == true) 
            {
                $('#<%=btnDelete.ClientID %>').fadeIn('slow');
                chkselect.checked = true;
                hdnAllID.value = hdnAllID.value + hdnID.value + ',';
            }
            else 
            {
                $('#<%=btnDelete.ClientID %>').fadeOut('slow');
                chkselect.checked = false;
                hdnAllID.value = '';
            }
        }

    }

    function CheckSelect(ID) {
        var chkAll = document.getElementById('MainContent_lvowner_chkAll');
        var hdnID = document.getElementById(ID.replace('chkselect', 'hdnownerID'));
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

    function ValidateMultiDelete() {
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

    function HideDiv() {
        window.setTimeout(function () {
            Society.unblockUI('#UploadOwnerInfo');
        }, 1000);
    }
    function showdiv() {
        Society.blockUI({
            centerX: true,
            centerY: true,
            css: {
                height: 'auto',
                cursor: 'null',
                left: "15%",
                top: "34%",
                width: "23%",
                border: 'none',
                textalign: 'center',
                backgroundColor: 'auto'
            },
            target: '#UploadOwnerInfo',
            boxed: true,
            message: 'Processing...'
        });


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
            <li><a href="../Masters/OwnerMasterView.aspx">Owner Information View</a> </li>
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
                                       <asp:TextBox ID="txtsearch"  style="display:inline !important;" AutoComplete="off" rel="popover" data-content="Enter Owner Name" class="form-control input-large" runat="server"></asp:TextBox>
                                    <asp:Button class="btn btn-success btn-sm" style="display:inline !important;"  ID="btnSearch" runat="server" Text="Search" 
                                        onclick="btnSearch_Click"  />
                                        <asp:Button ID="btnAdd" style="display:inline !important;" 
                                            class="btn btn-success btn-sm" runat="server" Text="Add" 
                                            onclick="btnAdd_Click" />
                                        <asp:Button ID="btncancel" style="display:inline !important;"
                                            runat="server" class="btn btn-success btn-sm" Text="Cancel" 
                                            onclick="btncancel_Click" />
                                        <span class="help-block"> <p><span style="Font-Size:14px; color:Red">Note:
                                    </span>Enter Owner Name</p> </span>

                                      
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
                                Owner Information View</span> <span class="caption-helper"></span>
                        </div>
                   


                        <div class="actions">
								<div class="btn-group">
                                <input type="button" ID="btnBulkupload" class="btn btn-group-sm btn-badge-warning display-popup" value="BulkUpload" />
									   <asp:ImageButton ID="imgExport" runat="server" Style=" width: 40px;height: 32px; padding: 0px;margin: 0px;" ImageUrl="~/Images/excel.png" 
                        onclick="imgExport_Click" Visible="true"/>
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
                                           <span class="caption-helper" style="display:inline !important; padding:9px"></span>
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
                            <asp:ListView ID="lvowner" class="table-responsive" runat="server" GroupPlaceholderID="groupPlaceHolder1"
                        ItemPlaceholderID="itemPlaceHolder1" 
                                OnPagePropertiesChanging="OnPagePropertiesChanging">
                        <LayoutTemplate>
                            <table id="Main_lvowner" class="table table-striped table-bordered table-hover">
                             <thead>
                                 <tr>
                                     <th class="table-checkbox">
                                         <asp:CheckBox ID="chkAll" class="group-checkable" onclick="javascript:chkSelectAll();" runat="server" />
                                     </th>
                                    
                                     <th>
                                          Owner Name
                                     </th>
                                     <th>
                                         Contact Number
                                     </th>
                                     <th>
                                         PAN
                                     </th>
                                     <th>
                                         Action
                                     </th>
                                     
                                 </tr>
                                </thead>
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                <tr>
                                    <td colspan="4">
                                        <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvowner" QueryStringField="page" PageSize="20">
                                            <Fields>
                                         
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                    ShowNextPageButton="false" ButtonCssClass="btn btn-xs red" />

                                                <asp:NumericPagerField ButtonType="Link" NumericButtonCssClass="btn default" />
                                                <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false"
                                                    ShowPreviousPageButton="false" ButtonCssClass="btn btn-xs green" />

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
                            <asp:HiddenField ID="hdnownerID" Value='<%#Eval("OwnerId") %>' runat="server" />
                                <%# Eval("OwnerName")%>
                            </td>
                            <td>
                                <%# Eval("ContactNumber")%>
                            </td>
                            <td>
                                <%# Eval("PAN")%>
                            </td>

                            <td>
                                <asp:HyperLink ID="HyperLink1" class="btn green btn-sm" NavigateUrl='<%#"~/Masters/OwnerMaster.aspx?PId=3&amp;OwnerId=" + Eval("[OwnerId]").ToString() %>' runat="server">Edit</asp:HyperLink>
                           
                          <%--      <asp:LinkButton runat="server" OnClick="Content_Load" class="btn" ID="deletelinkbutton">Delete</asp:LinkButton>--%>

                               <%-- <asp:Button ID="btndelete" class="btn red small" OnClick="btndelete_Click" OnClientClick="javascript:return ValidateDel();" runat="server" Text="Delete" />--%>
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
   
   
   <div class="modal fade" id="UploadOwnerInfo" tabindex="-1" data-backdrop="static" data-keyboard="false"
            data-width="760" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Upload Excel</h4>
      </div>
      <div class="modal-body">
      <!--button type="button" class="btn btn-default" onclick="DownloadFlatPattern();" >Download Pattern</button-->
          <asp:Button class="btn btn-default" ID="btnDownloadPattern"  runat="server" Text="Download Pattern" />
          
           <hr />
          <table class="table responsive-toggle">
              <tr>
                  <td>
                      <asp:FileUpload ID="fupload" runat="server" onchange="" />
                  </td>
              </tr>
              <tr>
                  <td>
                      <input id="btnExcelUpload" class="btn btn-default btn-warning" type="button" value="Upload Selected File" />


                  </td>
              </tr>
          </table>
          <div id="DuplicateRecordTable" class="scroller" style="height: 305px;"></div>

      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        
      </div>
    </div>
  </div>
</div>
    <asp:HiddenField ID="hdnOwnersId" Value="" runat="server" />
    <asp:HiddenField ID="hdnUniqueKey"  Value="" runat="server" />
    <asp:HiddenField ID="hdnDate" Value=""  runat="server" />
    <asp:HiddenField ID="HdnSocityId" Value="" runat="server" />
</asp:Content>
