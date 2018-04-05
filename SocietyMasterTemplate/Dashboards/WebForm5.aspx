<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboards/Dashboard.Master" AutoEventWireup="true" CodeBehind="WebForm5.aspx.cs" Inherits="EsquareMasterTemplate.Dashboards.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">


     $(document).ready(function () {
         $('#Button2').click(function () {
             Society.blockUI({
                 target: '#abc',
                  boxed: true,
                  message: 'Processing...'
             });
         });

     });

     $('#<%=Button1.ClientID %>').click(function () {
         Society.unblockUI('#abc');
     });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div id="abc">
   adaadadada daddada dadada
   dada<br />

   ada<br />
    <input id="Button2" type="button" value="Block" />

</div>
    <asp:Button ID="Button1" runat="server" Text="Unblock" />
</asp:Content>
