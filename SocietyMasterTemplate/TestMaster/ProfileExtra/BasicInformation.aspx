<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BasicInformation.aspx.cs" Inherits="EsquareMasterTemplate.Profile.ProfileExtra.test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../ThemeAssets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">

       // window.onload = GetBasicinfo;
        function GetBasicinfo() 
        {
            $.ajax({
                type: 'POST',
                url: "Profile/ProfileExtra/BasicInformation.aspx/CheckBasicInfoCount",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) 
                {
                    if (data.d == 0) 
                    {
                       // toastr.warning("Update Basic Info Record.");

                        $("#btnSubmit").attr('value', 'Insert');
                    }
                    else 
                    {
                       //toastr.warning("Insert Basic Info Record.");
                       $("#btnSubmit").attr('value', 'Update');
                    }
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }

       

        $(document).ready(function ()
         {
            //   $(".select2").select2({ maximumSelectionSize: 3 });
            //  });

          

//            $('.date').datepicker({
//                format: 'mm/dd/yyyy',
//                autoclose: true,
//                //keyboardNavigation:true,
//                todayBtn: true,
//                todayHighlight: true,
//                clearBtn: true
//                //startDate: '-3d'
             //            });


        });

       

       function abc() {
           GetBasicinfo();
            toastr.warning("Please Enter Event On");
            return false;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
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
                        First Name</label>
                        <asp:TextBox ID="txtFirstName" AutoComplete="Off" placeholder="First Name" class="form-control" runat="server"></asp:TextBox>
                  
                </div>
                <div class="form-group">
                    <label class="control-label">
                        Last Name</label>
                     <asp:TextBox ID="txtLastName" AutoComplete="Off" placeholder="Last Name" class="form-control" runat="server"></asp:TextBox>
                </div>
                 <div class="form-group">
                    <label class="control-label">
                        Maiden  Name</label>
                    <asp:TextBox ID="txtMaidenName" AutoComplete="Off" placeholder="Maiden  Name" class="form-control" runat="server"></asp:TextBox>
                </div>
                    <div class="form-group">
                    <label class="control-label">
                        Gender</label>
                        <asp:DropDownList ID="drpGender" class="form-control" runat="server">
                        <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                        </asp:DropDownList>
                  
                </div>
                  <div class="form-group">
                    <label class="control-label">
                        Birthday</label>
                    <asp:TextBox ID="txtBirthday" AutoComplete="Off" placeholder="Birthday" class="date form-control" runat="server"></asp:TextBox>
                </div>
                 <div class="form-group">
                    <label class="control-label">
                        Relationship</label>
                     <asp:DropDownList ID="DropDownList1" class="form-control" runat="server">
                        <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                        <asp:ListItem Text="Single" Value="Single"></asp:ListItem>
                        <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                        <asp:ListItem Text="Complicated" Value="Complicated"></asp:ListItem>
                        </asp:DropDownList>
                </div>
                 <div class="form-group">
                    <label class="control-label">
                        Other Name</label>
                    <asp:TextBox ID="txtOtherName" AutoComplete="Off" placeholder="Other Name" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="control-label">
                        Interests</label>
                    <asp:TextBox ID="txtInterests" AutoComplete="Off" placeholder="Interests" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="control-label">
                        Occupation</label>
                     <asp:TextBox ID="txtOccupation" AutoComplete="Off" placeholder="Occupation" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="control-label">
                       Tagline</label>
                    <asp:TextBox ID="txtTagline" AutoComplete="Off" placeholder="Tagline" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="control-label">
                       Introduction/About Us</label>
                     <asp:TextBox ID="txtAboutUs" AutoComplete="Off" placeholder="About Us" class="form-control" runat="server"></asp:TextBox>
                </div>
                
            </div>
        </div>
    </div>
  
    <div class="modal-footer">
   
        <asp:Button ID="btnSubmit" ClientIDMode="Static" OnClientClick="return abc()" class="btn blue" runat="server"
            Text="Submit" />
       <asp:Button ID="btnClose" type="btnClose" runat="server" class="btn default" data-dismiss="modal" />
    </div>
    </form>
       <script src="../../ThemeAssets/global/plugins/jquery.min.js" type="text/javascript"></script>
</body>
</html>
