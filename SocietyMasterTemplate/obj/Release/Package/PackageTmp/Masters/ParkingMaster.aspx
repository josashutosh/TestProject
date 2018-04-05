 <%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="ParkingMaster.aspx.cs" EnableEventValidation="false" Inherits="EsquareMasterTemplate.Masters.ParkingMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



  <script type="text/javascript">

      $(document).ready(function () {

          //$(".form-control").popover({
          //    placement: 'top',
          //    trigger: 'focus'
          //});
      });


      function hideparknginfo()
       {
          val = $('#<%=chkIsparkAvailable.ClientID%>').val();

          if ((document.getElementById('<%=chkIsparkAvailable.ClientID%>').checked) === true) {
              $('#<%=ParkingtypeAvail.ClientID%>').show('slow');
          }
          else { $('#<%=ParkingtypeAvail.ClientID%>').hide('slow'); }
      }
      $(document).ready(function () 
      {
         // $("#DrpOwnerID").attr("disabled", "disabled"); 



          $("#drpFlatID").select2({ maximumSelectionSize: 1 });
         // $("#DrpOwnerID").select2({ maximumSelectionSize: 1 });

          $('.parkavail_yes').find('label,icheckbox_flat-green label,icheckbox_flat-green ins').click(function () {
            
             });


      });


      function getOwnerInfo()
      {
          var f = document.getElementById('<%=drpFlatID.ClientID %>');
         var FlatId = f.options[f.selectedIndex].value;
          
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "ParkingMaster.aspx/GetOwnerInfobyFlatId",
              data: "{'FlatId':'" + FlatId + "'}",
              dataType: "json",
              success: function (response) {
                  var Result = JSON.parse(response.d);

                  //                     $.each(Result, function (key, value) {
                  ////                         $('<%=DrpOwnerID.ClientID %>').append($("<option></option>").val
                  ////                (value.CountryId).html(value.CountryName));
                  //                     });
                  // Another way of writing
                  $('#<%=DrpOwnerID.ClientID %>').empty();

                  if (Result.length > 0) 
                  {
                      for (var i = 0; i < Result.length; i++) {
                          // $('#<%=DrpOwnerID.ClientID %>').options[i] = null;
                          $('#<%=DrpOwnerID.ClientID %>').append("<option value=" + Result[i].OwnerId + ">" +
                          Result[i].Ownername + "</option>");
                      }
                  }
                  $('#<%=DrpOwnerID.ClientID %>').prepend("<option value='' selected='selected'>-Select Owner Name--</option>");

                  // One more way of writing
                  // for (var i in Result) {
                  //  $("#DrpOwnerID").append($("<option></option>").val(Result[i].ID).
                  //   text(Result[i].Name));
                  //  }

              },
              error: function (Result) {
                  alert("Error");
              }
          });

      }



    </script>

    <script type="text/javascript">

        var clockTimeoutID, TriggerFrom;
        //Global Variables
        var XmlHttp_Emp;
        //Creating object of XMLHTTP For AJAX Method
        function CreateXmlHttpObject() {
            var XmlHttpObject;
            try { XmlHttpObject = new ActiveXObject("Msxml2.XMLHTTP"); }
            catch (e) {
                try { XmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP"); }
                catch (oc) { XmlHttpObject = null; }
            }
            if (!XmlHttpObject && typeof XMLHttpRequest != "undefined") { XmlHttpObject = new XMLHttpRequest(); }
            return XmlHttpObject;
        }
        function Fill_List_Text_Control(ctl, ds, TextField, ValueField) {
            var listItem;
            if (ctl.type && ctl.type != "text") {
                         ctl.length = 0; 
                    ctl.options[ctl.length] = listItem;
            }
           else {
               if (ctl.value) ctl.value = ""; else ctl.innerText = "";
            }
            if (ds != null) {
                var TextFieldList = ds.getElementsByTagName(TextField);
                var ValueFieldList = ds.getElementsByTagName(ValueField);
                for (var count = 0; count < TextFieldList.length; count++) {
                    var text = (TextFieldList[count].textContent || TextFieldList[count].innerText || TextFieldList[count].text);
                    var value = ValueFieldList != null ? (ValueFieldList[count].textContent || ValueFieldList[count].innerText || ValueFieldList[count].text) : text;
                    if (ctl.type && ctl.type != "text") {
                        listItem = new Option(text, TextField == ValueField ? text : value, false, false);
                        ctl.options[ctl.length] = listItem;
                    }
                    else {
                        if (ctl.value) {
                            ctl.value = text;
                        }
                        else ctl.innerText = text;
                    }
                }
            }
        }
        function GetSubcat(value) 
        {

            var XmlHttpObject = CreateXmlHttpObject();
            document.body.style.cursor = "progress";
            //document.getElementById('imgsCity').style.display = '';

            var postpara = "&opt=1&id1=" + value;
            var _location = String(document.location);
            var requestUrl = _location + _location.indexOf('?') == -1 ? "&" : "?" + new Date().getTime();

            if (XmlHttpObject) {
                XmlHttpObject.onreadystatechange = function () { Subcatresponse(XmlHttpObject) }
                XmlHttpObject.open("POST", requestUrl, true);
                XmlHttpObject.setRequestHeader("IsAjax", "true");
                XmlHttpObject.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                XmlHttpObject.setRequestHeader('Content-length', postpara.length);
                XmlHttpObject.send(postpara);
            }
        }
        function Subcatresponse(XmlHttpObject)
         {
            if (XmlHttpObject.readyState == 4) {
                if (XmlHttpObject.status == 200) {
                    document.body.style.cursor = "auto"; ///ctl00$MainContent$ddl_City
                    Fill_List_Text_Control(document.getElementById('<%=DrpOwnerID.ClientID %>'), XmlHttpObject.responseXML.documentElement, "OwnerName1", "OwnerId");
                    //Fill_List_Text_Control(document.getElementById('ctl00$MainContent$ddl_City'), XmlHttpObject.responseXML.documentElement, "PC_CITY_DESC", "PC_CITY_ID");

                    //document.getElementById('imgsCity').style.display = 'none';
                }
                else {
                    alert("Server is not ready..");
                    document.body.style.cursor = "auto";
                    //document.getElementById('imgsCity').style.display = 'none';
                }
            }
        }

        function parkingValidation() 
        {
            var ownerid  = document.getElementById('<%=DrpOwnerID.ClientID%>').value;
            var flatid = document.getElementById('<%=drpFlatID.ClientID%>').value;
            var isparkavailable = document.getElementById('<%=chkIsparkAvailable.ClientID%>').value;
            var numofparking = document.getElementById('<%=drpnumparking.ClientID%>').value;
            var txtpark1 = document.getElementById('<%=txtparkingcount1.ClientID %>').value;
            var txtpark2 = document.getElementById('<%=txtparkingcount2.ClientID %>').value;
            var txtpark3 = document.getElementById('<%=txtparkingcount3.ClientID %>').value;
            var vehiclenopattrn = /^[A-Z]{2}[ \-][0-9]{2}[ \-][A-Z]{2}[ \-][0-9]{4}$/;
           //-- /^[A-Za-z]{2}[-].[A-Za-z0-9\s]*$/--
            if (flatid == "" || flatid==0) {
                bootbox.alert("Enter Flat Number");
                return false;
            }
            if (ownerid == 0 || flatid == "") {
                bootbox.alert(" Enter Owner Name");
                return false;
            }

            if ((document.getElementById('<%=chkIsparkAvailable.ClientID%>').checked) === true) {
                if (numofparking == 0) {
                    bootbox.alert("Enter number of Parking");
                    return false;
                }
            }

            if (numofparking == "1") {
                if (txtpark1 == "") {
                    bootbox.alert("Enter Vehicle Number");
                    return false;
                }
                if (!vehiclenopattrn.test(txtpark1)) {
                    bootbox.alert("Vehicle number is not valid ");
                    return false;
                }
            }
            if (numofparking == "2") {
                if (txtpark1 == "") {
                    bootbox.alert("Enter first Vehicle Number");
                    return false;
                }
                if (!vehiclenopattrn.test(txtpark1)) {
                    bootbox.alert("first Vehicle number is not valid ");
                    return false;
                }
                if (txtpark2 == "") {
                    bootbox.alert("Enter second Vehicle Number");
                    return false;
                }
                if (!vehiclenopattrn.test(txtpark2)) {
                    bootbox.alert("second Vehicle number is not valid ");
                    return false;
                }

            }
            if (numofparking == "3") {
                if (txtpark1 == "") {
                    bootbox.alert("Enter first Vehicle Number");
                    return false;
                }
                if (!vehiclenopattrn.test(txtpark1)) {
                    bootbox.alert("first Vehicle number is not valid ");
                    return false;
                }
                if (txtpark2 == "") {
                    bootbox.alert("Enter second Vehicle Number");
                    return false;
                }
                if (!vehiclenopattrn.test(txtpark2)) {
                    bootbox.alert("second Vehicle number is not valid ");
                    return false;
                }

                if (txtpark3 == "") {
                    bootbox.alert("Enter Third Vehicle Number");
                    return false;
                }

                if (!vehiclenopattrn.test(txtpark3)) 
                {
                    bootbox.alert("Third Vehicle number is not valid ");
                    return false;
                }

            }

            return true;
        }

        function showtxt() {
            drpnumparking = document.getElementById('<%=drpnumparking.ClientID %>').value;
            if (drpnumparking == "1") {
                document.getElementById('<%=txtparkingcount11.ClientID %>').style.display = "";
                document.getElementById('<%=txtparkingcount21.ClientID %>').style.display = "none";
                document.getElementById('<%=txtparkingcount31.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "2") {
                document.getElementById('<%=txtparkingcount11.ClientID %>').style.display = "";
                document.getElementById('<%=txtparkingcount21.ClientID %>').style.display = "";
                document.getElementById('<%=txtparkingcount31.ClientID %>').style.display = "none";
            }
            if (drpnumparking == "3") {
                document.getElementById('<%=txtparkingcount11.ClientID %>').style.display = "";
                document.getElementById('<%=txtparkingcount21.ClientID %>').style.display = "";
                document.getElementById('<%=txtparkingcount31.ClientID %>').style.display = "";
            }
            if (drpnumparking == "0") {
                document.getElementById('<%=txtparkingcount11.ClientID %>').style.display = "none";
                document.getElementById('<%=txtparkingcount21.ClientID %>').style.display = "none";
                document.getElementById('<%=txtparkingcount31.ClientID %>').style.display = "none";
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
            <li><a href="../Masters/ParkingMaster.aspx">Parking Information</a> </li>
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
                                Parking Information</span><span class="caption-helper"></span>
                        </div>
                        <div class="actions">
                            <%--<a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a>--%>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div class="form-horizontal form-bordered form-row-stripped">
                            <div class="form-body">
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Flat Number</label>
                                    <div class="col-md-9">
                                        <asp:DropDownList ID="drpFlatID" placeholder="Flat Name" class="select2 form-control input-large"
                                           onchange="getOwnerInfo();" runat="server">
                                        </asp:DropDownList> <%--onchange="javascript:GetSubcat(this.value);"--%>
                                       
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Owner Name</label>
                                    <div class="col-md-9"> 
                                        <asp:DropDownList ID="DrpOwnerID" placeholder="Owner Name"  class="form-control input-large"
                                            runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-md-3">
                                        Is parking Available?</label>
                                    <div class="col-md-9">
                                        <asp:CheckBox ID="chkIsparkAvailable" class="icheck parkavail_yes" Text="Is parking Available"
                                            runat="server" />
                                    </div>
                                </div>
                                <div id="ParkingtypeAvail" class="col-md-12" runat="server" style="display: none;">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Parking Type</label>
                                        <div class="col-md-9">
                                            <asp:CheckBox ID="chkOpen" Checked="true" class="icheck" Text="Open" runat="server" />
                                            <asp:CheckBox ID="chkStilt" class="icheck" Text="Stilt" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Number of Parking</label>
                                        <div class="col-md-9">
                                         <span class="help-block">Select Number of Parking </span>
                                            <asp:DropDownList ID="drpnumparking" class="select2 form-control" placeholder="Select Number of Parking" runat="server"
                                                onchange="showtxt()">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                            </asp:DropDownList>
                                           
                                            <div class="controls">
                                                <div id="txtparkingcount11" runat="server" Style="display: none;">
                                                     <asp:TextBox ID="txtparkingcount1" class="form-control input-large" rel="popover" data-content="Vehicle number" autocomplete="off" runat="server" ></asp:TextBox>
                                                    <div class="testicheck">
                                                        <asp:RadioButton ID="chkOpen11" runat="server" Text="Open" GroupName="A" class="icheck intercom_yes"
                                                            value="Open" />
                                                        <asp:RadioButton ID="chkStilt11" runat="server" Text="Stilt" GroupName="A" class="icheck intercom_yes"
                                                            value="Stilt" />
                                                    </div>
                                                    

                                                </div><br />
                                                <div id="txtparkingcount21" runat="server" Style="display: none;">
                                                    <asp:TextBox ID="txtparkingcount2" class="form-control input-large" rel="popover" data-content="Vehicle number" autocomplete="off" runat="server" ></asp:TextBox>
                                                    <div class="testicheck">
                                                        <asp:RadioButton ID="chkOpen21" runat="server" Text="Open" GroupName="B" class="icheck intercom_yes"
                                                            value="Open" />
                                                        <asp:RadioButton ID="chkStilt21" runat="server" Text="Stilt" GroupName="B" class="icheck intercom_yes"
                                                            value="Stilt" />
                                                    </div>
                                                </div><br />
                                            <div id="txtparkingcount31" Style="display: none;" runat="server">
                                                 <asp:TextBox ID="txtparkingcount3" class="form-control input-large" rel="popover" data-content="Vehicle number" autocomplete="off" runat="server" ></asp:TextBox>
                                                <div class="testicheck">
                                                        <asp:RadioButton ID="chkOpen31" runat="server" Text="Open" GroupName="C" class="icheck intercom_yes"
                                                            value="Open" />
                                                        <asp:RadioButton ID="chkStilt31" runat="server" Text="Stilt" GroupName="C" class="icheck intercom_yes"
                                                            value="Stilt" />
                                                    </div>
                                               
                                            </div><br />
                                               
                                                
                                               
                                                <span class="help-block">Enter Vehicle Number:Eg. MH-20-AB-1254 </span>
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                       

                               <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click"
                                class="btn btn-success" OnClientClick="return parkingValidation()" />
                                 <asp:Button ID="btnClear"  class="btn default" runat="server" Text="Clear"  />
                            <asp:Button ID="btnback"  class="btn btn-success" runat="server" Text="Cancel" onclick="btnback_Click" 
                                              />

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
