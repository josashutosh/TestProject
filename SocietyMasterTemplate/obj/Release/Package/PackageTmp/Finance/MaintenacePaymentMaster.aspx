<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="MaintenacePaymentMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.MaintenacePaymentMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">


//        var clockTimeoutID, TriggerFrom;
//        //Global Variables
//        var XmlHttp_Emp;
//        //Creating object of XMLHTTP For AJAX Method
//        function CreateXmlHttpObject() {
//            var XmlHttpObject;
//            try { XmlHttpObject = new ActiveXObject("Msxml2.XMLHTTP"); }
//            catch (e) {
//                try { XmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP"); }
//                catch (oc) { XmlHttpObject = null; }
//            }
//            if (!XmlHttpObject && typeof XMLHttpRequest != "undefined") { XmlHttpObject = new XMLHttpRequest(); }
//            return XmlHttpObject;
//        }
//        function Fill_List_Text_Control(ctl, ds, TextField, ValueField) {
//            var listItem;
//            if (ctl.type && ctl.type != "text") {
//                         ctl.length = 0; 
//                    ctl.options[ctl.length] = listItem;
//            }
//           else {
//               if (ctl.value) ctl.value = ""; else ctl.innerText = "";
//            }
//            if (ds != null) {
//                var TextFieldList = ds.getElementsByTagName(TextField);
//                var ValueFieldList = ds.getElementsByTagName(ValueField);
//                for (var count = 0; count < TextFieldList.length; count++) {
//                    var text = (TextFieldList[count].textContent || TextFieldList[count].innerText || TextFieldList[count].text);
//                    var value = ValueFieldList != null ? (ValueFieldList[count].textContent || ValueFieldList[count].innerText || ValueFieldList[count].text) : text;
//                    if (ctl.type && ctl.type != "text") {
//                        listItem = new Option(text, TextField == ValueField ? text : value, false, false);
//                        ctl.options[ctl.length] = listItem;
//                    }
//                    else {
//                        if (ctl.value) {
//                            ctl.value = text;
//                        }
//                        else ctl.innerText = text;
//                    }
//                }
//            }
//        }
//        function GetSubcat(value) 
//        {

//            var XmlHttpObject = CreateXmlHttpObject();
//            document.body.style.cursor = "progress";
//            //document.getElementById('imgsCity').style.display = '';

//            var postpara = "&opt=1&id1=" + value;
//            var _location = String(document.location);
//            var requestUrl = _location + _location.indexOf('?') == -1 ? "&" : "?" + new Date().getTime();

//            if (XmlHttpObject) {
//                XmlHttpObject.onreadystatechange = function () { Subcatresponse(XmlHttpObject) }
//                XmlHttpObject.open("POST", requestUrl, true);
//                XmlHttpObject.setRequestHeader("IsAjax", "true");
//                XmlHttpObject.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
//                XmlHttpObject.setRequestHeader('Content-length', postpara.length);
//                XmlHttpObject.send(postpara);
//            }
//        }
//        function Subcatresponse(XmlHttpObject)
//         {
//            if (XmlHttpObject.readyState == 4) {
//                if (XmlHttpObject.status == 200) {
//                    document.body.style.cursor = "auto"; ///ctl00$MainContent$ddl_City
//                    Fill_List_Text_Control(document.getElementById('MainContent_DrpOwnerID'), XmlHttpObject.responseXML.documentElement, "OwnerName1", "OwnerId");
//                    //Fill_List_Text_Control(document.getElementById('ctl00$MainContent$ddl_City'), XmlHttpObject.responseXML.documentElement, "PC_CITY_DESC", "PC_CITY_ID");

//                    //document.getElementById('imgsCity').style.display = 'none';
//                }
//                else {
//                    alert("Server is not ready..");
//                    document.body.style.cursor = "auto";
//                    //document.getElementById('imgsCity').style.display = 'none';
//                }
//            }
//        }


        function getFlatNo() {
            var f = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = f.options[f.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollection.aspx/GetFlatNumber",
                data: "{'PropertyType':'" + PropertyType + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);

                    //                     $.each(Result, function (key, value) {
                    ////                         $('<%=drpMaintenancePeriod.ClientID %>').append($("<option></option>").val
                    ////                (value.CountryId).html(value.CountryName));
                    //                     });
                    // Another way of writing
                    $('#<%=drpFlatnumber.ClientID %>').empty();
                    if (Result.length > 0) {
                        for (var i = 0; i < Result.length; i++) {
                            // $('#<%=drpFlatnumber.ClientID %>').options[i] = null;
                            $('#<%=drpFlatnumber.ClientID %>').append("<option value=" + Result[i].FlatId + ">" +
                          Result[i].FlatNumber + "</option>");
                        }
                    }
                    $('#<%=drpFlatnumber.ClientID %>').prepend("<option value='' selected='selected'>-Select flat number--</option>");

                    // One more way of writing
                    // for (var i in Result) {
                    //  $("#ddlcountry").append($("<option></option>").val(Result[i].ID).
                    //   text(Result[i].Name));
                    //  }

                },
                error: function (Result) {
                    alert("Error");
                }
            });

        }

        function getmaintenancePeriod() {

            var f = document.getElementById('<%=drpFlatnumber.ClientID %>');
            FlatID = f.options[f.selectedIndex].value;

            var p = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = p.options[p.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollection.aspx/GetMaintenanceperiod",
                data: "{'FlatID':'" + FlatID + "','PropertyType':'" + PropertyType + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);

                    $('#<%=drpMaintenancePeriod.ClientID %>').empty();

                    if (Result.length > 0) {
                        for (var i = 0; i < Result.length; i++) {
                            // $('#<%=drpMaintenancePeriod.ClientID %>').options[i] = null;

                            $('#<%=drpMaintenancePeriod.ClientID %>').append("<option value=" + Result[i].ID + ">" +
                          Result[i].MaintenancePeriod + "</option>");
                        }
                    }
                    $('#<%=drpMaintenancePeriod.ClientID %>').prepend("<option value='' selected='selected'>-Select Maintenance Period--</option>");
                    // Another way of writing
                    //  for (var i = 0; i < Result.length; i++) {
                    // $("#ddlcountry").append("<option value=" + Result[i].ID + ">" + 
                    //     Result[i].Name + "</option>");
                    //  }

                    // One more way of writing
                    // for (var i in Result) {
                    //  $("#ddlcountry").append($("<option></option>").val(Result[i].ID).
                    //   text(Result[i].Name));
                    //  }

                },
                error: function (Result) {
                    alert("Error");
                }
            });

        }

        function GetMaintenanceAmount() {
            var f = document.getElementById('<%=drpFlatnumber.ClientID %>');
            FlatID = f.options[f.selectedIndex].value;

            var p = document.getElementById('<%=drpPropertytype.ClientID %>');
            PropertyType = p.options[p.selectedIndex].value;

            var mp = document.getElementById('<%=drpMaintenancePeriod.ClientID %>');
            MainID = mp.options[mp.selectedIndex].value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MaintenanceCollection.aspx/GetMaintenancAmounts",
                data: "{'MainID':'" + MainID + "','PropertyType':'" + PropertyType + "'}",
                dataType: "json",
                success: function (response) {
                    var Result = JSON.parse(response.d);

                    if (Result.length > 0) {

                        $('#<%=txtMaintenanceAmount.ClientID %>').val(Result[0].Amount);
                    }
                },
                error: function (Result) {
                    alert("Error");
                }
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
            <li><a href="../Masters/FlatMaster.aspx">Maintenace Payment Information</a> </li>
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
                                                        <label class="control-label col-md-3" id="lblFlatNo" runat="server">
                                                            Flat Number</label>
                                                        <div class="col-md-9">
                                                             <asp:DropDownList ID="drpFlatID" placeholder="Flat Name" class="select2 form-control input-large"
                                           onchange="javascript:GetSubcat(this.value);" runat="server">
                                        </asp:DropDownList>
                                                                
                                                           
                                                            
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
                                                 
                                               <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" >
                                                            Owner Name</label>
                                                              <div class="col-md-9">
                                                        <asp:DropDownList ID="DrpOwnerID" placeholder="Owner Name" class="form-control input-large"
                                            runat="server">
                                        </asp:DropDownList>
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
                                                            Maintenace Amount</label>
                                                        <div class="col-md-9">
                                                             <asp:TextBox ID="txtMaintenance" class="form-control input-large" rel="popover" runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" >
                                                            Date</label>
                                                        <div class="col-md-9">
                                                             <asp:TextBox ID="txtDate" class="form-control input-large" rel="popover" runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                            
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
                                                        <label class="control-label col-md-3" id="lblFlatType" runat="server">
                                                            Paid in Cash / By Cheque No.</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtPayment" class="form-control input-large" rel="popover" data-content="Enter Built Up Area " runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            On Bank</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtBankName" class="form-control input-large" rel="popover" data-content="Enter Built Up Area " runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="Label1" runat="server">
                                                            Amount</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtAmount" class="form-control input-large" rel="popover" data-content="Enter Built Up Area " runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <!--/span-->
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            To</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtTo" class="form-control input-large" rel="popover" data-content="Enter " runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>


                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3" id="Label2" runat="server">
                                                            Being</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="txtBeing" class="form-control input-large" rel="popover" data-content="Enter " runat="server" AutoComplete="off" onkeypress ="javascript:return isNumberKey(event)"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <!--/span-->
                                               <%-- <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="control-label col-md-3">
                                                            To</label>
                                                        <div class="col-md-9">
                                                            <asp:TextBox ID="TextBox3" class="form-control input-large" rel="popover" data-content="Enter Built Up Area " runat="server" AutoComplete="off"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>--%>
                                                <!--/span-->
                                            </div>
                                            <!--/ commercial Row-->
                                            
                                            <!--/End commercial Row-->
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Submit"/>
                                                    <asp:Button ID="btnClear" class="btn default" runat="server" Text="Clear"/>
                                                    <asp:Button ID="btnCancel" class="btn btn-success" runat="server" Text="Cancel" />
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
