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
    
    </form>
       <script src="../../ThemeAssets/global/plugins/jquery.min.js" type="text/javascript"></script>
</body>
</html>
