<%@ Page Title="" Language="C#" MasterPageFile="~/TestMaster/Index3.Master" AutoEventWireup="true"
    CodeBehind="Index3.aspx.cs" Inherits="EsquareMasterTemplate.TestMaster.Index31" %>
    <script>

        //                    $('#<%=lblRepairsandMaintenance.ClientID %>').text(RepairsMaintenanceFund);
        //                    $('#<%=lblMaintenancelift.ClientID %>').text(LiftCharges);
        //                    $('#<%=lblSinkingfund.ClientID %>').text(SinkingFund);
        //                    $('#<%=lblServiceCharges.ClientID %>').text(ServiceCharges);
        //                    $('#<%=lblCarParking.ClientID %>').text(CarParkingCharges);
        //                    $('#<%=lblInterestdefaulted.ClientID %>').text(InterestonDefaulted);
        //                    $('#<%=lblRepaymentinstallment.ClientID %>').text(RepaymentInstmntLoanInterest);
        //                    $('#<%=lblNonoccupancy.ClientID %>').text(NonOccupancyCharges);
        //                    $('#<%=lblInsuranceCharges.ClientID %>').text(InsuranceCharges);
        //                    $('#<%=lblLeaseRent.ClientID %>').text(LeaseRent);
        //                    $('#<%=lblNonagriculturaltax.ClientID %>').text(NonAgriculturalTax);
    </script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <h3 class="page-title">
        Layout with Fontawesome Icons <small>fontawesome icons support in sidebar, header menus,
            portlets & more</small>
    </h3>
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Page Layouts</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Layout with Fontawesome Icons</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
                <button type="button" class="btn btn-fit-height grey-salt dropdown-toggle" data-toggle="dropdown"
                    data-hover="dropdown" data-delay="1000" data-close-others="true">
                    Actions <i class="fa fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu pull-right" role="menu">
                    <li><a href="#">Action</a> </li>
                    <li><a href="#">Another action</a> </li>
                    <li><a href="#">Something else here</a> </li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a> </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- END PAGE HEADER-->
    <!-- BEGIN DASHBOARD STATS -->
    <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat blue-madison">
                <div class="visual">
                    <i class="fa fa-comments"></i>
                </div>
                <div class="details">
                    <div class="number">
                        1349
                    </div>
                    <div class="desc">
                        New Feedbacks
                    </div>
                </div>
                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat red-intense">
                <div class="visual">
                    <i class="fa fa-bar-chart-o"></i>
                </div>
                <div class="details">
                    <div class="number">
                        12,5M$
                    </div>
                    <div class="desc">
                        Total Profit
                    </div>
                </div>
                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat green-haze">
                <div class="visual">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <div class="details">
                    <div class="number">
                        549
                    </div>
                    <div class="desc">
                        New Orders
                    </div>
                </div>
                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat purple-plum">
                <div class="visual">
                    <i class="fa fa-globe"></i>
                </div>
                <div class="details">
                    <div class="number">
                        +89%
                    </div>
                    <div class="desc">
                        Brand Popularity
                    </div>
                </div>
                <a class="more" href="#">View more <i class="m-icon-swapright m-icon-white"></i>
                </a>
            </div>
        </div>
    </div>
    <!-- END DASHBOARD STATS -->
    <div class="clearfix">
    </div>
    <!-- END DASHBOARD STATS -->
</asp:Content>
