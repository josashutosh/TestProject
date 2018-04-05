<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboards/Dashboard.Master" AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs" Inherits="EsquareMasterTemplate.Dashboards.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../ThemeAssets/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript">
        // Global variable to hold data
        // Load the Visualization API and the piechart package.
        google.load('visualization', '1', { packages: ['corechart'] });
    </script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'AdminDashboard.aspx/GetExpenseChart',
                data: '{}',
                success: function (response) {
                    drawchart(response.d); // calling method
                },

                error: function () {
                    alert("Error loading data...........");
                }
            });
        });

        function drawchart(dataValues) {
            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            var data = new google.visualization.DataTable();

            data.addColumn('string', 'PlanName');
            data.addColumn('number', 'PaymentAmount');
            // Use custom HTML content for the domain tooltip.
            data.addColumn({ 'type': 'string', 'role': 'tooltip', 'p': { 'html': true} });

            for (var i = 0; i < dataValues.length; i++) {
                data.addRow([dataValues[i].PlanName, dataValues[i].PaymentAmount, dataValues[i].HtmlContent]);
            }
            // Instantiate and draw our chart, passing in some options
            var chart = new google.visualization.PieChart(document.getElementById('ExpenseChart'));

            var option = {
                title: "Pie Chart of Google Chart in Asp.net",
                //   is3D: true,
                pieHole: 0.2,
                position: "top",
                fontsize: "10px",
                chartArea: { width: '100%' },
                width: '100%',
                height: 350,
                legend: { position: 'bottpm', textStyle: { color: 'blue', fontSize: 10} },
                pieSliceText: 'labeled-and-percentage',
                tooltip: { isHtml: true }
                //legend: { position: 'labeled' }

            };
            chart.draw(data, option);

            ////register callbacks
            // google.visualization.events.addListener(chart, 'onmouseover', showDetails);
            //google.visualization.events.addListener(chart, 'onmouseout', hideDetails);

            // Create and draw the visualization.
            //  new google.visualization.ColumnChart(document.getElementById('custom_html_content_div')).draw(data, options);
        }





        function showDetails(e) {
            switch (e['row']) {
                case 0: document.getElementById('details0').style.visibility = 'visible';
                    break;
                case 1: document.getElementById('details1').style.visibility = 'visible';
                    break;
                case 2: document.getElementById('details2').style.visibility = 'visible';
                    break;
                case 3: document.getElementById('details3').style.visibility = 'visible';
                    break;
            }
        }

        function hideDetails(e) {
            switch (e['row']) {
                case 0: document.getElementById('details0').style.visibility = 'hidden';
                    break;
                case 1: document.getElementById('details1').style.visibility = 'hidden';
                    break;
                case 2: document.getElementById('details2').style.visibility = 'hidden';
                    break;
                case 3: document.getElementById('details3').style.visibility = 'hidden';
                    break;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Dashboard</a> </li>
        </ul>
        <div class="page-toolbar">
        
        </div>
    </div>
    <h3 class="page-title">
        Admin Dashboard <small>reports & statistics</small>
    </h3>
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
                        <asp:Label ID="lblMonthlyIncome" runat="server"></asp:Label>
                    </div>
                    <div class="desc">
                        Monthly Income
                    </div>
                </div>
                <a class="more" id="popCurentmaintenanaceInfo" data-toggle="modal" href="#PopCurrentMaintenance">
                    View more <i class="m-icon-swapright m-icon-white"></i></a>
                <%-- <a class="more" data-target="#PopCurrentMaintenance" data-toggle="modal">View more <i
                    class="m-icon-swapright m-icon-white"></i></a>--%>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat red-intense">
                <div class="visual">
                    <i class="fa fa-bar-chart-o"></i>
                </div>
                <div class="details">
                    <div class="number">
                        <%--RS.--%>
                        <asp:Label ID="lblMonthlyExpense" runat="server"></asp:Label>
                    </div>
                    <div class="desc">
                        Monthly Expense
                    </div>
                </div>
                <a class="more" data-toggle="modal" href="#IsRentedpop">View more <i class="m-icon-swapright m-icon-white">
                </i></a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat green-haze">
                <div class="visual">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <div class="details">
                    <div class="number">
                        <asp:Label ID="ddd" runat="server">
                        </asp:Label>
                    </div>
                    <div class="desc">
                        By Laws
                    </div>
                </div>
                <a class="more" id="" data-toggle="modal" href="#SocAccDetailpop">View more <i class="m-icon-swapright m-icon-white">
                </i></a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat purple-plum">
                <div class="visual">
                    <i class="fa fa-globe"></i>
                </div>
                <div class="details">
                    <div class="number">
                        <asp:Label ID="lblHelpDesk" runat="server">
                        </asp:Label>
                    </div>
                    <div class="desc">
                        Downloads
                    </div>
                </div>
                <a class="more" data-toggle="modal" href="#HelpDeskpop">View more <i class="m-icon-swapright m-icon-white">
                </i></a>
            </div>
        </div>
    </div>
    <!-- END DASHBOARD STATS -->
    <div class="clearfix">
    </div>
    <div class="row">
        <!-------------------------------------Start Maintenance History------------------------------------->
        <!-------------------------------------Start Profile------------------------------------>
        <div class="col-md-6 col-sm-6">
            <div class="portlet light ">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-equalizer font-blue-steel hide"></i><span class="caption-subject font-blue-steel bold uppercase">
                            Expense Chart </span><span class="caption-helper"></span>
                    </div>
                    <div class="tools">
                        <a href="" class="collapse"></a><a href="" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                        <!-- Load Content  -->
                        <div class="row">
                            <div class="col-md-12 col-sm-12" id="ExpenseChart">
                            </div>
                        </div>
                        <!-- End Load Content-->
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------End Profile------------------------------------->
        <div class="col-md-6 col-sm-6">
            <div class="portlet light ">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-equalizer font-purple-plum hide"></i><span class="caption-subject font-purple-plum bold uppercase">
                            Pending Maintenance</span> <span class="caption-helper"></span>
                    </div>
                    <div class="tools">
                        <a href="" class="collapse"></a><a href="" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                        <!-- Load Content  -->
                        <div class="table table-responsive table-scrollable table-scrollable-borderless">
                        </div>
                        <!-- End Load Content-->
                    </div>
                </div>
            </div>
            <!-------------------------------------End Maintenance History ------------------------------------->
        </div>
        <div class="clearfix">
        </div>
        <div class="row">
            <!------------------------------------- Event Master------------------------------------->
            <div class="col-md-6 col-sm-6">
                <div class="portlet light ">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-equalizer font-green-sharp hide"></i><span class="caption-subject font-green-sharp bold uppercase">
                                -----</span> <span class="caption-helper"></span>
                        </div>
                        <div class="tools">
                            <a href="" class="collapse"></a><a href="" class="remove"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                            <!-- Load Content  -->
                            <div class="table-responsive">
                            </div>
                            <!-- End Load Content-->
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------------------- End Event master--------------------------------->
            <!------------------------------------- Buy /Rent / Sell------------------------------------->
            <div class="col-md-6 col-sm-6">
                <div class="portlet light ">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-equalizer font-purple-intense hide"></i><span class="caption-subject font-purple-intense bold uppercase">
                                ----- </span><span class="caption-helper"></span>
                        </div>
                        <div class="tools">
                            <a href="" class="collapse"></a><a href="" class="remove"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                            <!-- Load Content  -->
                            <!-- End Load Content-->
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------------------- End Event master--------------------------------->
        </div>
    </div>
</asp:Content>
