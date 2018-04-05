<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true"
    CodeBehind="BuildingCommittee.aspx.cs" EnableEventValidation="false" Inherits="EsquareMasterTemplate.Masters.BuildingCommitte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        $("#drpFlatID").select2({ maximumSelectionSize: 1 });
        $("#DrpOwnerID").select2({ maximumSelectionSize: 1 });
        //$(".form-control").popover({
        //    placement: 'top',
        //    trigger: 'focus'
        //});
    });

    </script>
<script language="javascript" type="text/javascript">


    function buildingComityvalidtn() {

        var flatid = document.getElementById('<%=drpFlatID.ClientID%>').value;
        var ownerid = document.getElementById('<%=DrpOwnerID.ClientID%>').value;
        var designatn = document.getElementById('<%=drpDesignation.ClientID%>').value;
        var effectvfrm = document.getElementById('<%=txtEffectivefrom.ClientID%>').value;

        if (flatid === "") {
            bootbox.alert("Select Flat Number");
            return false;
        }

        if (ownerid == "" || ownerid== 0) {
            bootbox.alert("Enter Owner Name");
            return false;
        }
        if (designatn == "0") {
            bootbox.alert("Enter Designation");
            return false;
        }
        if (effectvfrm == "") {
            bootbox.alert("Enter Effective From");
            return false;
        }
        return true;
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
            ctl.length = 0; listItem = new Option("--Select--", 0, false, false); ctl.options[ctl.length] = listItem;
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
    function GetSubcat(value) {

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
    function Subcatresponse(XmlHttpObject) {
        if (XmlHttpObject.readyState == 4) {
            if (XmlHttpObject.status == 200) {
                document.body.style.cursor = "auto"; ///ctl00$MainContent$ddl_City
                Fill_List_Text_Control(document.getElementById('MainContent_DrpOwnerID'), XmlHttpObject.responseXML.documentElement, "OwnerName1", "OwnerId");
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
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
     <h3 class="page-title">
        Building Committee</h3>
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="#">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Masters</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="../Masters/BuildingCommittee.aspx">Building Committee</a> </li>
        </ul>
       
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
                                Building Committee Information</span>
                        </div>
                        <div class="actions">
                            <a class="fullscreen btn btn-circle btn-icon-only btn-default" href="#"><i class="btn-circle">
                            </i></a>
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
                                        <div class="controls">
                                            <asp:DropDownList ID="drpFlatID" class="select2 form-control" 
                                                onchange="javascript:GetSubcat(this.value);" runat="server"  placeholder="Select Flat Number" >
                                            </asp:DropDownList>
                                            <br />
                                        </div>
                                        <span class="help-block">Select Flat Number</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Owner Name</label>
                                <div class="col-md-9">
                                    <div class="controls">

                                      <asp:DropDownList ID="DrpOwnerID" class="form-control" placeholder="Select Owner Name" ViewStateMode="Enabled" runat="server">
                                    </asp:DropDownList>                                        
                                       
                                    </div>
                                    <span class="help-block">Select Owner Name</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Designation</label>
                                <div class="col-md-9">
                                    <div class="controls">
                                         <asp:DropDownList ID="drpDesignation" runat="server" class="select2 form-control" >
                                        <asp:ListItem Value="0">--Select Designation--</asp:ListItem>
                                        <asp:ListItem>Chairman / President</asp:ListItem>
                                        <asp:ListItem>Secretary</asp:ListItem>
                                        <asp:ListItem>Treasurer</asp:ListItem>
                                        <asp:ListItem>Member</asp:ListItem>
                                    </asp:DropDownList>
                                       
                                    </div>
                                    <span class="help-block">Select Designation</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">
                                    Effective From</label>
                                <div class="col-md-9">
                                    <div class="controls">
                                       <asp:TextBox ID="txtEffectivefrom" class="form-control datepicker" runat="server"  placeholder="Select Effective From Date" AutoComplete="Off"></asp:TextBox>
                                        <br />
                                    </div>
                                    <span class="help-block">Select Effective From Date</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <asp:Button ID="btnmemsubmit"  class="btn btn-success" 
                                         runat="server" Text="Submit" onclick="btnmemsubmit_Click" OnClientClick="return buildingComityvalidtn();"/>
                                        <asp:Button ID="btnClear"  class="btn default" runat="server" Text="Clear"  />
                                         <asp:Button ID="btnbck" class="btn btn-success btn-medium"
                runat="server" Text="Cancel" onclick="btnbck_Click" />
                

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END FORM-->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
