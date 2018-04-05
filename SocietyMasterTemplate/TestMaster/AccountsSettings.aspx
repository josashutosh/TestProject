<%@ Page Title="" Language="C#" MasterPageFile="~/Profile/ProfileMaster.Master" AutoEventWireup="true"
    CodeBehind="AccountsSettings.aspx.cs" Inherits="EsquareMasterTemplate.Profile.AccountsSettings"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal.css"
        rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css"
        rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $('#basic-info-profile').on('click', function () {
            GetBasicinfo()
        });
        function GetBasicinfo() {
            $.ajax({
                type: 'POST',
                url: "Profile/ProfileExtra/BasicInformation.aspx/CheckBasicInfoCount",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 0) {
                        // toastr.warning("Update Basic Info Record.");

                        $("#btnSubmit").attr('value', 'Insert');
                    }
                    else {
                        //toastr.warning("Insert Basic Info Record.");
                        $("#btnSubmit").attr('value', 'Update');
                    }
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }

        function preview() 
        {
            var Apreview = document.querySelector('#<%=imgAvatar.ClientID %>');
            var Avater = document.querySelector('#<%=FuAvatar.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;

            }


            reader.onloadend = function () { Apreview.src = reader.result; }

            if (Avater) {
                reader.readAsDataURL(Avater);
            } else {
                Apreview.src = "";
            }

        }


   
    </script>
    <style type="text/css">
        #dvPreview
        {

            min-height: 150px;
            min-width: 150px;
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageheadeRight" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ProfileSidebarcustom" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PROFILE CONTENT -->
    <div class="profile-content">
        <div class="row">
            <div class="col-md-12">
                <div class="portlet light">
                    <div class="portlet-title tabbable-line">
                        <div class="caption caption-md">
                            <i class="icon-globe theme-font hide"></i><span class="caption-subject font-blue-madison bold uppercase">
                                Profile Account</span>
                        </div>
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1_1" data-toggle="tab">Personal Info</a> </li>
                            <li><a href="#tab_1_2" data-toggle="tab">Change Avatar</a> </li>
                            <li><a href="#tab_1_3" data-toggle="tab">Change Password</a> </li>
                            <li><a href="#tab_1_4" data-toggle="tab">Privacy Settings</a> </li>
                        </ul>
                    </div>
                    <div class="portlet-body">
                        <div class="tab-content">
                            <!-- PERSONAL INFO TAB -->
                            <div class="tab-pane active" id="tab_1_1">
                                <div>
                                    <!--Profile Content-->
                                    <div class="row" style="background-color: #f1f3fa;">
                                        <!-- Start Basic profile Info -->
                                        <div class="col-md-6">
                                            <!-- BEGIN PORTLET -->
                                            <div class="portlet light ">
                                                <!--Start Tab Title-->
                                                <div class="portlet-title">
                                                    <div class="caption caption-md">
                                                        <i class="icon-bar-chart theme-font hide"></i><span class="caption-subject font-blue-madison bold uppercase">
                                                            Basic Information</span> <span class="caption-helper hide">Oo...</span>
                                                    </div>
                                                    <div class="actions">
                                                        <div class="btn-group btn-group-devided" data-toggle="buttons">
                                                            
                                                                <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                    <a style="color:#FFF;" id="basic-info-profile" data-toggle="modal">View Demo </a>
                                                                </label>
                                                                <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                    <a href="#" class=""></a>Refresh</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--End Tab Title-->
                                                <div class="portlet-body">
                                                    <!-- Scroller Start -->
                                                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="0"
                                                        data-handle-color="#D7DCE2">
                                                        <div class="table-responsive table-scrollable table-scrollable-borderless">
                                                        </div>
                                                        <asp:ListView ID="BasicInformation" runat="server">
                                                            <LayoutTemplate>
                                                                <table class="table table-hover table-light" id="BasicInfo">
                                                                    <thead>
                                                                        <tr class="uppercase">
                                                                            <th class="col-md-6">
                                                                            </th>
                                                                            <th class="col-md-6">
                                                                                Basic Information
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tr>
                                                                        <td class="col-md-6">
                                                                            <a href="#" class="primary-link">Tom</a>
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label ID="Lblname" runat="server" Text="Label"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tbody>
                                                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <img id="btndelete" style="cursor: pointer;" alt="Edit" src="../img/delete.png" onclick="deletebook(this);" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <span id="id">
                                                                            <%# Eval("ProductId")%></span>
                                                                        <asp:HiddenField ID="hndid" runat="server" Value='<%#Eval("ProductId")%>' />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                    <!-- Scroller End -->
                                                </div>
                                            </div>
                                            <!-- End Basic profile Info -->
                                        </div>
                                        <!-- Column 2 Started-->
                                        <div class="col-md-6">
                                            <!-- BEGIN PORTLET -->
                                            <div class="portlet light ">
                                                <!--Start Tab Title-->
                                                <div class="portlet-title">
                                                    <div class="caption caption-md">
                                                        <i class="icon-bar-chart theme-font hide"></i><span class="caption-subject font-blue-madison bold uppercase">
                                                            Contact Information</span> <span class="caption-helper hide">Oo...</span>
                                                    </div>
                                                    <div class="actions">
                                                        <div class="btn-group btn-group-devided" data-toggle="buttons">
                                                            <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                <a href="#" class=""></a>Edit - Basic Information</label>
                                                            <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                <a href="#" class=""></a>Refresh</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--End Tab Title-->
                                                <div class="portlet-body">
                                                    <!-- Scroller Start -->
                                                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="0"
                                                        data-handle-color="#D7DCE2">
                                                        <div class="table-responsive table-scrollable table-scrollable-borderless">
                                                        </div>
                                                        <asp:ListView ID="LvcontactInfo" runat="server">
                                                            <LayoutTemplate>
                                                                <table class="table table-hover table-light" id="ContactInfo">
                                                                    <thead>
                                                                        <tr class="uppercase">
                                                                            <th class="col-md-6">
                                                                            </th>
                                                                            <th class="col-md-6">
                                                                                Basic Information
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tr>
                                                                        <td class="col-md-6">
                                                                            <a href="#" class="primary-link">Tom</a>
                                                                        </td>
                                                                        <td class="col-md-6">
                                                                            <asp:Label ID="Lblname" runat="server" Text="Label"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tbody>
                                                                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <img id="btndelete" style="cursor: pointer;" alt="Edit" src="../img/delete.png" onclick="deletebook(this);" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <span id="id">
                                                                            <%# Eval("ProductId")%></span>
                                                                        <asp:HiddenField ID="hndid" runat="server" Value='<%#Eval("ProductId")%>' />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                    <!-- Scroller End -->
                                                </div>
                                            </div>
                                            <!-- End Basic profile Info -->
                                        </div>
                                        <!--Column 2 End-->
                                    </div>
                                    <!--Start1 new Row-->
                                    <!-- End 2 Row-->
                                    <!--End profile Content-->
                                </div>
                            </div>
                            <!-- END PERSONAL INFO TAB -->
                            <!-- CHANGE AVATAR TAB -->
                            <div class="tab-pane" id="tab_1_2">
                                <p>
                                    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson
                                    ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food
                                    truck quinoa nesciunt laborum eiusmod.
                                </p>
                                <div>
                                    <div class="form-group">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="dvPreview" style="width: 200px; height: 150px;">
                                                <asp:Image ID="imgAvatar" Style="width: 200px; height: 150px;" class="form-control fileinput-new thumbnail"
                                                    onerror="this.onload = null;  this.src='../Styles/img/no-image.gif';" runat="server" />
                                            </div>
                                            <div>
                                                <asp:FileUpload ID="FuAvatar" class="form-control small" onchange="preview()" runat="server" />
                                            </div>
                                        </div>
                                        <div class="clearfix margin-top-10">
                                            <span class="label label-danger">NOTE! </span><span>Attached image thumbnail is supported
                                                in Latest Firefox, Chrome, Opera, Safari and Internet Explorer 10 only </span>
                                        </div>
                                    </div>
                                    <div class="margin-top-10">
                                        <asp:Button ID="btnUpload" class="btn green-haze" runat="server" Text="Save Changes " />
                                        <asp:Button ID="btncancelUpload" class="btn default" runat="server" Text="Cancel" />
                                    </div>
                                </div>
                            </div>
                            <!-- END CHANGE AVATAR TAB -->
                            <!-- CHANGE PASSWORD TAB -->
                            <div class="tab-pane" id="tab_1_3">
                                <form action="#">
                                <div class="form-group">
                                    <label class="control-label">
                                        Current Password</label>
                                    <asp:TextBox class="form-control" ID="txtoldPassword" TextMode="Password" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        New Password</label>
                                    <asp:TextBox class="form-control" ID="txtNewPassword" TextMode="Password" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">
                                        Re-type New Password</label>
                                    <asp:TextBox class="form-control" ID="txtReNewPassword" TextMode="Password" runat="server"></asp:TextBox>


                                </div>
                                <div class="margin-top-10">
                                    <a href="#" class="btn green-haze">Change Password </a><a href="#" class="btn default">
                                        Cancel </a>
                                </div>
                                </form>
                            </div>
                            <!-- END CHANGE PASSWORD TAB -->
                            <!-- PRIVACY SETTINGS TAB -->
                            <div class="tab-pane" id="tab_1_4">
                                <div>
                                    <table class="table table-light table-hover">
                                        <tr>
                                            <td>
                                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus..
                                            </td>
                                            <td>
                                                <label class="uniform-inline">
                                                    <input type="radio" name="optionsRadios1" value="option1" />
                                                    Yes
                                                </label>
                                                <label class="uniform-inline">
                                                    <input type="radio" name="optionsRadios1" value="option2" checked />
                                                    No
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Enim eiusmod high life accusamus terry richardson ad squid wolf moon
                                            </td>
                                            <td>
                                                <label class="uniform-inline">
                                                    <input type="checkbox" value="" />
                                                    Yes
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Enim eiusmod high life accusamus terry richardson ad squid wolf moon
                                            </td>
                                            <td>
                                                <label class="uniform-inline">
                                                    <input type="checkbox" value="" />
                                                    Yes
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Enim eiusmod high life accusamus terry richardson ad squid wolf moon
                                            </td>
                                            <td>
                                                <label class="uniform-inline">
                                                    <input type="checkbox" value="" />
                                                    Yes
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <!--end profile-settings-->
                                    <div class="margin-top-10">
                                        <asp:Button ID="btnsave" class="btn green-haze" runat="server" Text="Save Changes " />
                                        <asp:Button ID="btnCancel" class="btn default" runat="server" Text="Cancel" />
                                    </div>
                                </div>
                            </div>
                            <!-- END PRIVACY SETTINGS TAB -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END PROFILE CONTENT -->
    <div id="new content">
        <!-- ajax -->
        
        <div id="ajax-basic-info-modal" class="modal fade" data-width="760" tabindex="-1">
        </div>
        <!-- static -->
    </div>
    </label>
</asp:Content>
