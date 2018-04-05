<%@ Page Title="" Language="C#" MasterPageFile="~/Profile/ProfileMaster.Master" AutoEventWireup="true"
    CodeBehind="AccountsSettings.aspx.cs" Inherits="EsquareMasterTemplate.Profile.AccountsSettings" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
            <script src="../ThemeAssets/global/plugins/bootstrap-summernote/summernote.min.js"></script>
      <script src="../ThemeAssets/global/plugins/jquery-tags-input/jquery.tagsinput.min.js"
        type="text/javascript"></script>
        rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            //            $("#foo").on("click", function () {
            //                alert($(this).text());
            //            });
            //            $("#foo").trigger("click");
            $("#basic-info").click(function () {
                showdiv();
                GetBasicinfo();
                HideDiv();
            });
            $("#Insertbasicinfo").click(function () {

                if (BasicInfovalidation() == false) {
                    return false;
                }
                else {
                    showdiv();
                    InsertBasicinfo();
                    HideDiv();
                }
               
            });


            $("#Other-Info").click(function () {
                showdiv();
                Getotherinfo();
                HideDiv();
            });
            $("#BtnotherInfo").click(function () {
                if (validatesocialinfo() == false) {
                    return false;
                }
                else {
                    showdiv();
                    InsertOtherinfo();
                    HideDiv();
                }
            });

        });
        
////////////////////////////////////////////////// Basic Info ///////////////////////////////////////////////
        function GetBasicinfo() 
        {
            $.ajax({
                type: 'POST',
                url: "AccountsSettings.aspx/CheckBasicInfoCount",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: OnSuccessBasicinfo,
                error: function (result)
                 {
                    alert("Error");
                }
            });
        }

        function Getotherinfo() {
            $.ajax({
                type: 'POST',
                url: "AccountsSettings.aspx/CheckotherInfoCount",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: OnSuccessOtherinfo,
                error: function (result) {
                    alert("Error");
                }
            });
        }

        function OnSuccessOtherinfo(response) {
            var result = response.d;
            if (result == 0) {
                toastr.warning("Please Insert Basic Info Record.");

                $("#BtnotherInfo").attr('value', 'Insert');
            }
            else {


                BasicinfoID = result[0];
                ID = result[1];
                if (ID == "") {
                    ID = "NULL";
                } else {
                    ID = result[1];
                }
                 
                WebUrl = result[2];
                if (WebUrl == "") {
                    WebUrl = "";
                } else {
                    WebUrl = result[2];
                }

                Facebook = result[3];
                if (Facebook == "") {
                    Facebook = "";
                } else {
                    Facebook = result[3];
                }

                Twitter = result[4];
                if (Twitter == "") {
                    Twitter = "";
                } else {
                    Twitter = result[4];
                }

                GooglePlus = result[5];
                if (GooglePlus == "") {
                    GooglePlus = "";
                } else {
                    GooglePlus = result[5];
                }

                LinkedIn = result[6];
                if (LinkedIn == "") {
                    LinkedIn = "";
                } else {
                    LinkedIn = result[6];
                }

                updateOtherInfo();
                toastr.warning("Please Update Other Info Record.");
                $("#BtnotherInfo").attr('value', 'Update');
            }


        }

        function updateOtherInfo() 
        {
            $('#<%=txtwebUrl.ClientID %>').val(WebUrl);
            $('#<%=Txtfacebook.ClientID %>').val(Facebook);
            $('#<%=txtTwitter.ClientID %>').val(Twitter);
            $('#<%=txtgoogleplus.ClientID %>').val(GooglePlus);
            $('#<%=txtlinkedin.ClientID %>').val(LinkedIn);
        }


        function InsertOtherinfo() {
            if (BasicinfoID == 0) 
            {
                BasicinfoID = 0;
                ID = '<%=Session["ID"].ToString() %>'
            }

            WebUrl = $('#<%=txtwebUrl.ClientID %>').val();
            Facebook = $('#<%=Txtfacebook.ClientID %>').val();
            Twitter = $('#<%=txtTwitter.ClientID %>').val();
            GooglePlus = $('#<%=txtgoogleplus.ClientID %>').val();
            LinkedIn = $('#<%=txtlinkedin.ClientID %>').val();

            OtherInfoCall();
            //return false; 
        }

        function OtherInfoCall() {
            $.ajax({
                type: 'POST',
                url: "AccountsSettings.aspx/InsertOtherinfo",
                data: '{"BasicinfoID":"' + BasicinfoID + '","ID":"' + ID + '","WebUrl":"' + WebUrl + '","Facebook":"' + Facebook + '","Twitter":"' + Twitter + '","GooglePlus":"' + GooglePlus + '","LinkedIn":"' + LinkedIn + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        //GetALLbookDetail();
                        toastr.success('Records Update Succesfully');
                        // clear text here after save complete
                    }
                    // window.location.reload();
                },
                error: function () {
                    alert("Error1");
                }
            });
        }


        function OnSuccessBasicinfo(response)
         {
            var result = response.d;
            if (result == 0) {
                toastr.warning("Please Insert Basic Info Record.");

                $("#Insertbasicinfo").attr('value', 'Insert');
            }
            else
             {

                BasicinfoID = result[0];
                ID = result[1];
                if (ID == "") {
                    ID = "NULL";
                } else {
                    ID = result[1];
                }

                Name = result[2];
                if (Name == "") {
                    Name = "NULL";
                } else {
                   Name = result[2];
                }

               PersonalContact = result[3];
                if (PersonalContact == "") {
                    PersonalContact = "NULL";
                } else {
                    PersonalContact = result[3];
                }

                OfficeContact = result[4];
                if (OfficeContact == "") {
                    OfficeContact = "NULL";
                } else {
                    OfficeContact = result[4];
                }

                Gender = result[5];
                if (Gender == "") {
                    Gender = "";
                } else {
                    Gender = result[5];
                }

                Birthday = result[6];
                if (Birthday == "") {
                    Birthday = "";
                } else {
                    Birthday = result[6];
                }

                Relationship = result[7];
                if (Relationship == "") {
                    Relationship = "";
                } else {
                    Relationship = result[7];
                }

                OtherName = result[8];
                if (OtherName == "") {
                    OtherName = "";
                } else {
                    OtherName = result[8];
                }

                Interests = result[9];
                if (Interests == "") {
                    Interests = "";
                } else {
                    Interests = result[9];
                }

                Occupation = result[10];
                if (Occupation == "") {
                    Occupation = "";
                } else {
                    Occupation = result[10];
                }

                Tagline = result[11];
                if (Tagline == "") {
                    Tagline = "";
                } else {
                    Tagline = result[11];
                }

                AboutUs = result[12];
                if (AboutUs == "") {
                    AboutUs = "";
                } else {
                    AboutUs = result[12];
                }

                Email = result[13];
                if (Email == "") {
                    Email = "";
                } else {
                    Email = result[13];
                }

                
                updateBasicInfo();
                toastr.warning("Please Update Basic Info Record.");
                $("#Insertbasicinfo").attr('value', 'Update');
            }


        }

        var BasicinfoID, ID, Name, PersonalContact, OfficeContact,Email, Gender, Birthday, Relationship, OtherName, Interests, Occupation, ImagePath, Tagline, AboutUs, WorkSkills, WebsiteUrl, Facebook, Twitter, GooglePlus, LinkedIn, Pincode, Place, Latitude, Longitude, CreatedBy, WebUrl, Facebook, Twitter, GooglePlus, LinkedIn;
     
        function InsertBasicinfo() 
        {
            if (BasicinfoID == 0) 
            {
                BasicinfoID = 0;
                ID = '<%=Session["ID"].ToString() %>'
            }

            if ($('#<%=txtName.ClientID %>').val() != "")
             {
                Name = $('#<%=txtName.ClientID %>').val();
            }
            else 
            {
                Name = "";
            }

            if ($('#<%=txtPersonalContact.ClientID %>').val() != "")
             {
                PersonalContact = $('#<%=txtPersonalContact.ClientID %>').val();
            }
            else
             {
                 PersonalContact = "";
             }

             if ($('#<%=txtOfficeContact.ClientID %>') != "") 
             {
                 OfficeContact = $('#<%=txtOfficeContact.ClientID %>').val();
             }
             else {
                 OfficeContact = "0000000000";
             }

             if ($('#<%=TextEmail.ClientID %>').val() != "") 
             {
                  Email = $('#<%=TextEmail.ClientID %>').val();
             }
             else {
                 Email = "";
             }

             if ($('#<%=drpGender.ClientID %>').find('option:selected').val() != "") 
              {
                  Gender = $('#<%=drpGender.ClientID %>').find('option:selected').val();
             }
             else {
                 Gender = "Male";
             }

             if ($('#<%=txtBirthday.ClientID %>').val() != "") 
             {
                  Birthday = $('#<%=txtBirthday.ClientID %>').val();
             }
             else {
                 Birthday = "01/01/2015";
             }



             if ($('#<%=DrpRelationship.ClientID %>').find('option:selected').val() != "") 
             {
                  Relationship = $('#<%=DrpRelationship.ClientID %>').find('option:selected').val();
             }
             else {
                 Relationship = "Single";
             }
             if ($('#<%=txtOtherName.ClientID %>').val() != "")
              {
                    OtherName = $('#<%=txtOtherName.ClientID %>').val();
             }
                else 
             {
                 OtherName = "-";
             }
             if ($('#<%=txtInterests.ClientID %>').val() != "") 
               {
                  Interests = $('#<%=txtInterests.ClientID %>').val();
               }
             else {
                 Interests = "-";
             }

             if ($('#<%=txtOccupation.ClientID %>').val() != "") 
             {
                  Occupation = $('#<%=txtOccupation.ClientID %>').val();
             }
              else 
             {
                 Occupation = "-";
             }



             if ($('#<%=txtTagline.ClientID %>').val() != "")
              {
                 Tagline = $('#<%=txtTagline.ClientID %>').val();
             }
             else {
                 Tagline = "-";
             }



             if ($('#<%=txtAboutUs.ClientID %>').code() != "") 
             {
                  AboutUs = $('#<%=txtAboutUs.ClientID %>').code();
             }
             else {
                 AboutUs = "-";
             }

            BasicInfoCall();
            //return false; 
        }

        function updateBasicInfo()
         {

            $('#<%=txtName.ClientID %>').val(Name);
            $('#<%=txtPersonalContact.ClientID %>').val(PersonalContact);
            $('#<%=txtOfficeContact.ClientID %>').val(OfficeContact);
               $('#<%=TextEmail.ClientID %>').val(Email);
            $('#<%=drpGender.ClientID %>').val(Gender);
            $('#<%=txtBirthday.ClientID %>').val(Birthday);
            $('#<%=DrpRelationship.ClientID %>').val(Relationship);

            $('#<%=txtOtherName.ClientID %>').val(OtherName);
            $('#<%=txtInterests.ClientID %>').importTags(Interests);
           
            $('#<%=txtOccupation.ClientID %>').val(Occupation);
            $('#<%=txtTagline.ClientID %>').val(Tagline);
            $('#<%=txtAboutUs.ClientID %>').code(AboutUs);

        }

     

     function BasicInfoCall()
        {
            $.ajax({
                type: 'POST',
                url: "AccountsSettings.aspx/InsertBasicinfo",
                data: '{"BasicinfoID":"' + BasicinfoID + '","ID":"' + ID + '","Name":"' + Name + '","PersonalContact":"' + PersonalContact + '","OfficeContact":"' + OfficeContact + '","Gender":"' + Gender + '","Birthday":"' + Birthday + '","Relationship":"' + Relationship + '","OtherName":"' + OtherName + '","Interests":"' + Interests + '","Occupation":"' + Occupation + '","Tagline":"' + Tagline + '","AboutUs":"' + AboutUs + '","Email":"' + Email + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "Record Updated Successfully..!!") {

                        //GetALLbookDetail();
                        toastr.success('Record Update Succesfully');
                        // clear text here after save complete
                    }
                    else
                     {
                         toastr.success(data.d);
                     }
                    // window.location.reload();
                },
                error: function () {
                    alert("Error1");
                }
            });
        }

        function BasicInfovalidation() 
        {

            Name = $('#<%=txtName.ClientID %>').val();
            PersonalContact = $('#<%=txtPersonalContact.ClientID %>').val();
            OfficeContact = $('#<%=txtOfficeContact.ClientID %>').val();
            Email = $('#<%=TextEmail.ClientID %>').val();
            Gender = $('#<%=drpGender.ClientID %>').find('option:selected').val();
            Birthday = $('#<%=txtBirthday.ClientID %>').val();
            Relationship = $('#<%=DrpRelationship.ClientID %>').find('option:selected').val();
            OtherName = $('#<%=txtOtherName.ClientID %>').val();
            Interests = $('#<%=txtInterests.ClientID %>').val();
            Occupation = $('#<%=txtOccupation.ClientID %>').val();
            Tagline = $('#<%=txtTagline.ClientID %>').val();
            AboutUs = $('#<%=txtAboutUs.ClientID %>').code();
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;
            var PancardPattern = /^[A-Za-z]{5}\d{4}[A-Za-z]{1}$/;
            var landlinenopattrn = /^([0-9]{3}[0-9]{5,8})$/;
            var emailpattern = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;

            if (Name == "") {
                toastr.warning("please Select Name");
                return false;
            }
            if (Email == "") 
             {
                toastr.warning("please Enter Email");
                return false;
             }
            if (!emailpattern.test(Email)) {
                toastr.warning("please Enter Valid Email Address");
                return false;
            }

            if (PersonalContact == "")
             {
                toastr.warning("please Enter Personal Contact");
                return false;
            }

            if (PersonalContact.length != 10 && !Mobilepattern.test(PersonalContact))
            {
                toastr.warning("please Enter 10 Digit Valid Number");
                return false;
            }

            return true;
        }

        ////////////////////////////////////////////////// End Basic Info ///////////////////////////////////////////////



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
       
        <script type="text/javascript" language="javascript">
            function changepasswrdvalidation() 
            {
                var oldpassword = document.getElementById('<%=txtoldPassword.ClientID%>').value;
                var newpassword = document.getElementById('<%=txtNewPassword.ClientID%>').value;
                var confirmpassword = document.getElementById('<%=txtReNewPassword.ClientID%>').value;

                if (oldpassword == "") {
                    toastr.warning("Please Enter Current Password");
                    return false;
                }
                if (newpassword == "") {
                    toastr.warning("Please Enter New Password");
                    return false;
                }
                if (confirmpassword == "") {
                    toastr.warning("Please Enter Confirm Password");
                    return false;
                }
                if (confirmpassword != newpassword) {
                    toastr.warning(" Your Confirm Password is not match");
                    return false;
                }
                return true;
            }


            function validatesocialinfo() {
                var url = document.getElementById('<%=txtwebUrl.ClientID %>').value;
                var facebookurl = document.getElementById('<%=Txtfacebook.ClientID %>').value;
                var twitterurl = document.getElementById('<%=txtTwitter.ClientID %>').value;
                var googleurl = document.getElementById('<%=txtgoogleplus.ClientID %>').value;
                var linkdinurl = document.getElementById('<%=txtlinkedin.ClientID %>').value;
                var urlpattrn = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;

                if (url != "") 
                {
                    if (!urlpattrn.test(url)) {
                        bootbox.alert("Web Url is not valid ");
                        return false;
                    }
                }


                if (facebookurl != "") {
                    if (!urlpattrn.test(facebookurl)) {
                        bootbox.alert("Facebook Url is not valid ");
                        return false;
                    }
                }


                if (twitterurl != "") {
                    if (!urlpattrn.test(twitterurl)) {
                        bootbox.alert("Twitter Url is not valid ");
                        return false;
                    }
                }


                if (googleurl != "") {
                    if (!urlpattrn.test(googleurl)) {
                        bootbox.alert("Google Url is not valid ");
                        return false;
                    }
                }


                if (linkdinurl != "") {
                    if (!urlpattrn.test(linkdinurl)) {
                        bootbox.alert("Linkedin Url is not valid ");
                        return false;
                    }
                }

                return true;
                
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
                            <%--<li><a href="#tab_1_4" data-toggle="tab">Privacy Settings</a> </li>--%>
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
                                        <div class="col-md-12">
                                            <!-- BEGIN PORTLET -->
                                            <div class="portlet light" style="margin-top:8px;">
                                                <!--Start Tab Title-->
                                                <div class="portlet-title">
                                                    <div class="caption caption-md">
                                                        <i class="icon-bar-chart theme-font hide"></i><span class="caption-subject font-blue-madison bold uppercase">
                                                            Basic Information</span> <span class="caption-helper hide">Oo...</span>
                                                    </div>
                                                    <div class="actions">
                                                        <div class="btn-group btn-group-devided" >
                                                            <asp:HyperLink class="btn btn-circle green-haze btn-sm" ID="HyperLink1" NavigateUrl="~/Profile/AccountsSettings.aspx"  runat="server">Refresh</asp:HyperLink>

                                                           
                                                         
                                                            <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                <a style="color: #FFF;" id="basic-info" data-target="#basic-info-profile" data-toggle="modal"> Edit Basic Info
                                                                </a>
                                                            </label>
                                                           <label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
                                                                <a style="color: #FFF;" id="Other-Info" data-target="#Other-Info-profile" data-toggle="modal"> Edit Social Info 
                                                                </a>
                                                            </label>
                                                           
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--End Tab Title-->
                                                <div class="portlet-body">
                                                    <!-- Scroller Start -->
                                                    <div class="scroller" style="height: 400px;" data-always-visible="1" data-rail-visible1="0"
                                                        data-handle-color="#D7DCE2">
                                                         <div class="table-responsive table-scrollable table-scrollable-borderless">
                                                             <asp:Repeater ID="ProfileView" runat="server" OnItemDataBound="ProfileView_ItemDataBound">
                                                                 <HeaderTemplate>
                                                                     <div class="scroller" style="height: 280px;" data-always-visible="1" data-rail-visible1="1">
                                                                         <table class="table table-striped table-bordered table-hover">
                                                                 </HeaderTemplate>
                                                                 <ItemTemplate>
                                                                     <tr>
                                                                         <td >
                                                                             Name
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Name")%> 
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td>
                                                                            Gender
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Gender")%>
                                                                         </td>
                                                                     </tr>
                                                                       <tr>
                                                                         <td>
                                                                            Contact Number
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("PersonalContact")%>
                                                                         </td>
                                                                     </tr>
                                                                     
                                                                     <tr>
                                                                         <td>
                                                                             Birthday
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Birthday", "{0:d}")%>
                                                                         
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td>
                                                                            Relationship
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Relationship")%>
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td>
                                                                             Interests
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Interests")%>
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td>
                                                                             Tagline
                                                                         </td>
                                                                         <td>
                                                                             <%# Eval("Tagline")%>
                                                                         </td>
                                                                     </tr>
                                                                    
                                                                 </ItemTemplate>
                                                                 <FooterTemplate>
                                                                     </table> </div>
                                                                     <div class="alert alert-block alert-danger fade in" visible="false" runat="server"
                                                                         id="FooterProfileView">
                                                                         <button type="button" class="close" data-dismiss="alert">
                                                                         </button>
                                                                         <p>
                                                                             No Record Found
                                                                         </p>
                                                                     </div>
                                                                 </FooterTemplate>
                                                             </asp:Repeater>
                                                         </div>
                                                    </div>
                                                    <!-- Scroller End -->
                                                </div>
                                            </div>
                                            <!-- End Basic profile Info -->
                                        </div>
                                        <!-- Column 2 Started-->
                                        
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
                                    Note:<br />
                                    <strong>Image Size</strong> : Less Tan 500KB<br />
                                    <strong>Image Width/Height</strong>: 300 x 300;<br />
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
                                        <asp:Button ID="btnUpload" class="btn green-haze" runat="server" Text="Change Avatar" OnClick="btnUpload_Click" />
                                        <%--<asp:Button ID="btncancelUpload" class="btn default" runat="server" Text="Cancel" />--%>
                                    </div>
                                </div>
                            </div>
                            <!-- END CHANGE AVATAR TAB -->
                            <!-- CHANGE PASSWORD TAB -->
                            <div class="tab-pane" id="tab_1_3">
                               
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
                                    <asp:Button ID="BtnChnagePassword" class="btn green-haze" runat="server" OnClientClick="javascript:return changepasswrdvalidation()" OnClick="BtnChnagePassword_click" Text="Change Password" /> 
                                </div>
                               
                            </div>
                            <!-- END CHANGE PASSWORD TAB -->
                            <!-- PRIVACY SETTINGS TAB -->
                            <div class="tab-pane" id="tab_1_4">
                                <div>
                                    
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
        <!----------------------------------------------- Basic info profile----------------------------------------------------------->
        <div id="basic-info-profile" class="Profile_Info modal fade" data-width="760" tabindex="-1">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title">
                    Basic Info Form</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Full Name</label>
                            <asp:TextBox ID="txtName" AutoComplete="Off" placeholder="Enter Name" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                         <div class="form-group">
                            <label class="control-label">
                                Email Address</label>
                            <asp:TextBox ID="TextEmail" AutoComplete="Off" placeholder="Enter Email Address" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group"> 
                            <label class="control-label">
                                Contact Number</label>
                            <asp:TextBox ID="txtPersonalContact" AutoComplete="Off" placeholder="Enter Personal Contact" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="control-label">
                                Office Contact</label>
                            <asp:TextBox ID="txtOfficeContact" AutoComplete="Off" placeholder="Enter Office Contact" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Gender</label>
                            <asp:DropDownList ID="drpGender" Selected="True" class="form-control input-large" runat="server">
                                <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Birthday</label>
                            <asp:TextBox ID="txtBirthday" AutoComplete="Off" placeholder="Birthday" class="date form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Relationship</label>
                            <asp:DropDownList ID="DrpRelationship" class="form-control input-large" runat="server">
                                <asp:ListItem Text="--Select--" Selected="True" Value=""></asp:ListItem>
                                <asp:ListItem Text="Single" Value="Single"></asp:ListItem>
                                <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                                <asp:ListItem Text="Complicated" Value="Complicated"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Other Name</label>
                            <asp:TextBox ID="txtOtherName" AutoComplete="Off" placeholder="Other Name" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Interests</label>
                            <asp:TextBox ID="txtInterests" AutoComplete="Off" placeholder="Interests" style="width:100% !important" class="tags  form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Occupation</label>
                            <asp:TextBox ID="txtOccupation" AutoComplete="Off" placeholder="Occupation" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Tagline</label>
                            <asp:TextBox ID="txtTagline" AutoComplete="Off" placeholder="Tagline" class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="control-label">
                                Introduction/About Us</label>
                            <asp:TextBox ID="txtAboutUs" AutoComplete="Off" placeholder="About Us" class="html-editor form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="Insertbasicinfo"  ClientIDMode="Static"  class="btn blue"
                    runat="server" Text="Submit" />
                <asp:Button ID="btnClose" type="btnClose" runat="server" class="btn default" Text="Cancel" data-dismiss="modal" />
            </div>
        </div>
        <!-----------------------------------------------End Basic info profile----------------------------------------------------------->


         <!----------------------------------------------- Contact info profile----------------------------------------------------------->
   
          <div id="Other-Info-profile" class="Profile_Info modal fade" data-width="760" tabindex="-1" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title">
                    Social Info </h4>
            </div>

             <div class="modal-body">
                <div class="row">
               <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Note:URl Format: www.yoursite.com or http://www.yoursite.com</label>
                          
                        </div>
                      </div>
                    
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Web URL</label>
                            <asp:TextBox ID="txtwebUrl" AutoComplete="Off"  class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Facebook URL</label>
                            <asp:TextBox ID="Txtfacebook" AutoComplete="Off"  class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                      </div>

                       <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Twitter URL</label>
                            <asp:TextBox ID="txtTwitter" AutoComplete="Off"  class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Google Plus URL</label>
                            <asp:TextBox ID="txtgoogleplus" AutoComplete="Off"  class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                      </div>

                      <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">
                                Linkedin URL</label>
                            <asp:TextBox ID="txtlinkedin" AutoComplete="Off"  class="form-control input-large"
                                runat="server"></asp:TextBox>
                        </div>
                      </div>

                      

                 </div>
              </div>

           <div class="modal-footer">
                <asp:Button ID="BtnotherInfo"  ClientIDMode="Static" class="btn blue"
                    runat="server" Text="Submit" />
               <asp:Button ID="Button2" type="btnClose" runat="server" class="btn default" Text="Cancel" data-dismiss="modal" />
            </div>
        </div>
          <!-----------------------------------------------End Contact info profile----------------------------------------------------------->

    </div>
</asp:Content>
