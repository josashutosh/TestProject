<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboards/Dashboard.Master" AutoEventWireup="true" CodeBehind="FlatSelector.aspx.cs" Inherits="EsquareMasterTemplate.Dashboards.FlatSelector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div class="container-fluid">
    <div class="row-fluid">
    <div class="col-lg-10 col-md-10 col-lg-offset-1 col-md-offset-1" style="box-shadow: 0px 0px 16px 1px rgba(138,138,138,1);padding:40px;background-color:#eceef1;margin-top:100px; vertical-align:middle;" align="center">
            <div class="col-lg-12 col-md-12">
            
            <h4>We observed that you are owner of more than one unit in society
             <asp:Label ID="lblSocietyName" runat="server" style="font-weight:bold;color:dimgrey"></asp:Label>
              </h4>
           </div>
          <div class="clearfix" style="margin-top:10px;"></div>
            <h4>please select any one unit to proceed</h4>
              <div class="clearfix" style="margin-top:20px;"></div>
            <div class="col-lg-3 col-md-3 col-lg-offset-4" align="center">
          <asp:DropDownList ID="ddlUnitId" runat="server" CssClass="form-control">
          </asp:DropDownList>
          </div>
           <div class="clearfix" style="margin-top:50px;"></div>
          <div class="col-lg-3 col-md-3 col-lg-offset-4" align="center">
        <asp:Button ID="btnContinue" runat="server" Text="Continue" 
                  CssClass="btn btn-lg btn-success" onclick="btnContinue_Click" />
          </div>
        </div>
        </div>
</asp:Content>
