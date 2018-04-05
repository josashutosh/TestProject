<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Master.Master" AutoEventWireup="true" CodeBehind="GenerateReceipt.aspx.cs" Inherits="EsquareMasterTemplate.Reports.GenerateReceipt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
    $(document).ready(function () {
          

            $('#sidebar-wrapper').hide();
    });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <h1 class="page-title">
        <small><b>Generate Receipt</b></small>
    </h1>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">

                <div class="row">
                    <div class="fa-align-center">
                        &nbsp;
                    </div>
                    <%--<asp:Button ID="Generatepdf" class="btn btn-sm green hidden-accordion margin-bottom-5" runat="server" Text="Pdf Generate" onclick="Generatepdf_Click" />--%>
                    <%--asp:Button ID="Button1" class="btn btn-sm green hidden-accordion margin-bottom-5" runat="server" Text="Send Sms" onclick="Button1_Click" /--%>
                    <%--<asp:Button ID="PrintPdf" class="btn btn-sm green hidden-accordion margin-bottom-5" 
                        runat="server" Text="Print Pdf" onclick="PrintPdf_Click" />--%>
                    <center style="margin:10px 0px">
                        <asp:Button ID="btnGeneratePdf" class="btn btn-sm green" runat="server" Text="Generate Pdf" OnClick="btnGeneratePdf_Click" />
                    
                    </center>
                </div>
                <div id="message" runat="server"></div>
                <div class="invoice" runat="server" id="invoice"  style="width: 590px; margin: 0px auto; background: #FFF; ">
                
                </div>



        <%--        <div id="SendMail" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Modal Header</h4>
                            </div>
                            <div class="modal-body">
                                Email Address:<br />
                                <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="Button1" class="btn btn-sm green" runat="server" Text="Send Mail" OnClientClick="javascript:return ValidateSendMail();" OnClick="btnSendmail_Click" />
                                <button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
                            </div>
                        </div>

                    </div>
                </div>--%>

                <asp:HiddenField ID="hdnEmail" runat="server" />
                <asp:HiddenField ID="hdninfo" runat="server" />

            </div>
        </div>
    </div>
</asp:Content>
