<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="SecuritySalaryMaster.aspx.cs" Inherits="EsquareMasterTemplate.Masters.SecuritySalaryMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


<script type="text/javascript">

    function totalsum() {


        var salary = parseInt(document.getElementById('<%=txtSalary.ClientID%>').value);
        var noofguard = parseInt(document.getElementById('<%=drpnumparking.ClientID%>').value);
        var noofsupervisor = parseInt(document.getElementById('<%=txtNumberofSupervisor.ClientID%>').value);
        var salaryofsupervisor = parseInt(document.getElementById('<%=txtSupervisorsalary.ClientID%>').value);
        

        var securitysal = (salary * noofguard);
       

        document.getElementById('<%=txtSecuritysalary.ClientID%>').value = securitysal;

        var total1 = ((salary * noofguard) + (noofsupervisor * salaryofsupervisor));
        document.getElementById('<%=txttotal.ClientID%>').value = total1;
        
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
            <li><a href="../Masters/SecuritySalaryMaster.aspx">Security Salary Information</a> </li>
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
                                Security Salary Information</span><span class="caption-helper"></span>
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
                                            Number of Security guards</label>
                                        <div class="col-md-9">
                                            <asp:DropDownList ID="drpnumparking" Width="330px" class="select2 form-control" placeholder="Select Number of Parking" runat="server"
                                                onchange="totalsum(); ">
                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="6">6</asp:ListItem>
                                                <asp:ListItem Value="7">7</asp:ListItem>
                                                <asp:ListItem Value="8">8</asp:ListItem>
                                                <asp:ListItem Value="9">9</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>

                                            </asp:DropDownList>


                                   
                                    </div>
                                </div>
                              
                               
                                <div id="ParkingtypeAvail" class="col-md-12" runat="server">
                                    
                                    <div class="form-group">
                                         <label class="control-label col-md-3">
                                        Salary Of Security Guards</label>
                                    <div class="col-md-9">
                                        
                                       <asp:TextBox ID="txtSalary" value="0" onkeypress="return restrict(this.value, event)" onblur="totalsum()" class="form-control input-large" rel="popover" data-content="Salary" autocomplete="off" runat="server" ></asp:TextBox>
                                            </div>
                                         </div>

                                         <div class="form-group">
                                         <label class="control-label col-md-3">
                                       Total Salary Amount</label>
                                    <div class="col-md-9">
                                        
                                       <asp:TextBox ID="txtSecuritysalary" value="0" onkeypress="return restrict(this.value, event)" onblur="totalsum()" class="form-control input-large" rel="popover" data-content="Salary" autocomplete="off" runat="server" ></asp:TextBox>
                                            </div>
                                            </div>
                                         <div class="form-group">
                                         <label class="control-label col-md-3">
                                        Company Name</label>
                                    <div class="col-md-9">
                                        
                                       <asp:TextBox ID="txtcompanyname" class="form-control input-large" rel="popover" data-content="Salary" autocomplete="off" runat="server" ></asp:TextBox>
                                            </div>
                                            </div>


                                            <div class="form-group">
                                         <label class="control-label col-md-3">
                                        Number of Supervisor </label>
                                    <div class="col-md-9">
                                        
                                       <asp:TextBox ID="txtNumberofSupervisor" value="0" class="form-control  input-large" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    runat="server" rel="popover" data-content="Enter Number of Supervisor" 
                                                    onblur="totalsum()" ></asp:TextBox>
                                            </div>
                                            </div>
                                            <div class="form-group">
                                         <label class="control-label col-md-3">
                                      Supervisor Salary</label>
                                    <div class="col-md-9">
                                        
                                       <asp:TextBox ID="txtSupervisorsalary" value="0" class="form-control  input-large" AutoComplete="off" onkeypress="return restrict(this.value, event)"
                                                    rel="popover" data-content="Enter Salary" onblur="totalsum()"
                                                     runat="server"></asp:TextBox>
                                            </div>
                                            </div>

                                         <br />
                                                   
                                          
                                            </div>
                                            
                                            <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Total</label>
                                        <div class="col-md-9">
                                        <asp:TextBox ID="txttotal" onblur="totalsum()" class="form-control input-large" rel="popover" data-content="Salary" autocomplete="off" runat="server" ></asp:TextBox>
                                        </div>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <div class="row">
                                    <div class="col-md-offset-3 col-md-9">
                                       

                               <asp:Button ID="btnsubmit" runat="server" Text="Submit"
                                class="btn btn-success" OnClientClick="return parkingValidation()"
                                            onclick="btnsubmit_Click" />
                                 <asp:Button ID="btnClear"  class="btn default" runat="server" Text="Clear"  />
                            <asp:Button ID="btnback"  class="btn btn-success" runat="server" Text="Cancel" />

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
