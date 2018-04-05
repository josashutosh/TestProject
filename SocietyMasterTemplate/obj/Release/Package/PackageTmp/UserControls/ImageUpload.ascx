<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImageUpload.ascx.cs"
    Inherits="EsquareMasterTemplate.UserControls.ImageUpload" %>
<%--<script src="../ThemeAssets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"
    type="text/javascript"></script>
<link href="../ThemeAssets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css"
    rel="stylesheet" type="text/css" />--%>
<%--<script type="text/javascript" src="<%= ResolveUrl("../ThemeAssets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js") %>"></script>
<link href="<%= ResolveUrl("../ThemeAssets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css") %>"
    rel="stylesheet" type="text/css" />--%>
<div class="fileinput fileinput-new" data-provides="fileinput">
    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
        <asp:Image src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" ID="imguplod" runat="server" />
    </div>
    <asp:FileUpload ID="FileUpload1" class="" style="max-width: 200px;
        max-height: 150px;" runat="server" />
    <div  >
    </div>
   
</div>
