<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopMenu.ascx.cs" Inherits="EsquareMasterTemplate.UserControls.TopMenu" %>
<!-- DOC: Remove "hor-menu-light" class to have a horizontal menu with theme background instead of white background -->
		<!-- DOC: This is desktop version of the horizontal menu. The mobile version is defined(duplicated) in the responsive menu below along with sidebar menu. So the horizontal menu has 2 seperate versions -->
		<div class="hor-menu hor-menu-light hidden-sm hidden-xs" id="HorrizontalsideMenu" runat="server">
            <%--<ul class="nav navbar-nav">
                <!-- DOC: Add data-hover="dropdown", data-close-others="true" and data-toggle="dropdown" attributes for the below "dropdown-toggle" links to enable hover dropdowns -->
                <li class="classic-menu-dropdown active"><a href="index.html">Dashboard <span class="selected">
                </span></a></li>
                <li class="mega-menu-dropdown"><a data-toggle="dropdown" href="lavascript:;" class="dropdown-toggle">
                    Mega <i class="fa fa-angle-down"></i></a>
                    <ul class="dropdown-menu" style="min-width: 700px;">
                        <li>
                            <!-- Content container to add padding -->
                            <div class="mega-menu-content">
                                <div class="row">
                                    <div class="col-md-4">
                                        <ul class="mega-menu-submenu">
                                            <li>
                                                <h3>
                                                    Layouts</h3>
                                            </li>
                                            <li><a href="index_horizontal_menu.html">Dashboard & Mega Menu </a></li>
                                            <li><a href="layout_horizontal_sidebar_menu.html">Horizontal & Sidebar Menu </a>
                                            </li>
                                            <li><a href="layout_glyphicons.html">Layout with Glyphicon <span class="badge badge-roundless badge-danger">
                                                new </span></a></li>
                                            <li><a href="layout_horizontal_menu1.html">Horizontal Mega Menu 1 </a></li>
                                            <li><a href="layout_horizontal_menu2.html">Horizontal Mega Menu 2 </a></li>
                                            <li><a href="layout_search_on_header1.html">Search Box On Header 1 </a></li>
                                        </ul>
                                    </div>
                                    <div class="col-md-4">
                                        <ul class="mega-menu-submenu">
                                            <li>
                                                <h3>
                                                    More Layouts</h3>
                                            </li>
                                            <li><a href="layout_search_on_header2.html">Search Box On Header 2 </a></li>
                                            <li><a href="layout_sidebar_search_option1.html">Sidebar Search Option 1 </a></li>
                                            <li><a href="layout_sidebar_search_option2.html">Sidebar Search Option 2 </a></li>
                                            <li><a href="layout_sidebar_reversed.html">Right Sidebar Page </a></li>
                                            <li><a href="layout_sidebar_fixed.html">Sidebar Fixed Page </a></li>
                                            <li><a href="layout_sidebar_closed.html">Sidebar Closed Page </a></li>
                                        </ul>
                                    </div>
                                    <div class="col-md-4">
                                        <ul class="mega-menu-submenu">
                                            <li>
                                                <h3>
                                                    Even More!</h3>
                                            </li>
                                            <li><a href="layout_ajax.html">Content Loading via Ajax </a></li>
                                            <li><a href="layout_disabled_menu.html">Disabled Menu Links </a></li>
                                            <li><a href="layout_blank_page.html">Blank Page </a></li>
                                            <li><a href="layout_boxed_page.html">Boxed Page </a></li>
                                            <li><a href="layout_language_bar.html">Language Switch Bar </a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
                <li class="mega-menu-dropdown mega-menu-full"><a data-toggle="dropdown" href="javascript:;"
                    class="dropdown-toggle">Full Mega <i class="fa fa-angle-down"></i></a>
                    <ul class="dropdown-menu">
                        <li>
                            <!-- Content container to add padding -->
                            <div class="mega-menu-content ">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>
                                                            Layouts</h3>
                                                    </li>
                                                    <li><a href="index_horizontal_menu.html"><i class="fa fa-angle-right"></i>Dashboard
                                                        & Mega Menu </a></li>
                                                    <li><a href="layout_horizontal_sidebar_menu.html"><i class="fa fa-angle-right"></i>Horizontal
                                                        & Sidebar Menu </a></li>
                                                    <li><a href="layout_glyphicons.html"><i class="fa fa-angle-right"></i>Layout with Glyphicon
                                                        <span class="badge badge-roundless badge-danger">new </span></a></li>
                                                    <li><a href="layout_horizontal_menu1.html"><i class="fa fa-angle-right"></i>Horizontal
                                                        Mega Menu 1 </a></li>
                                                    <li><a href="layout_horizontal_menu2.html"><i class="fa fa-angle-right"></i>Horizontal
                                                        Mega Menu 2 </a></li>
                                                    <li><a href="layout_search_on_header1.html"><i class="fa fa-angle-right"></i>Search
                                                        Box On Header 1 </a></li>
                                                </ul>
                                            </div>
                                            <div class="col-md-4">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>
                                                            More Layouts</h3>
                                                    </li>
                                                    <li><a href="layout_search_on_header2.html"><i class="fa fa-angle-right"></i>Search
                                                        Box On Header 2 </a></li>
                                                    <li><a href="layout_sidebar_search_option1.html"><i class="fa fa-angle-right"></i>Sidebar
                                                        Search Option 1 </a></li>
                                                    <li><a href="layout_sidebar_search_option2.html"><i class="fa fa-angle-right"></i>Sidebar
                                                        Search Option 2 </a></li>
                                                    <li><a href="layout_sidebar_reversed.html"><i class="fa fa-angle-right"></i>Right Sidebar
                                                        Page </a></li>
                                                    <li><a href="layout_sidebar_fixed.html"><i class="fa fa-angle-right"></i>Sidebar Fixed
                                                        Page </a></li>
                                                    <li><a href="layout_sidebar_closed.html"><i class="fa fa-angle-right"></i>Sidebar Closed
                                                        Page </a></li>
                                                </ul>
                                            </div>
                                            <div class="col-md-4">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>
                                                            Even More!</h3>
                                                    </li>
                                                    <li><a href="layout_disabled_menu.html"><i class="fa fa-angle-right"></i>Disabled Menu
                                                        Links </a></li>
                                                    <li><a href="layout_blank_page.html"><i class="fa fa-angle-right"></i>Blank Page </a>
                                                    </li>
                                                    <li><a href="layout_boxed_page.html"><i class="fa fa-angle-right"></i>Boxed Page </a>
                                                    </li>
                                                    <li><a href="layout_language_bar.html"><i class="fa fa-angle-right"></i>Language Switch
                                                        Bar </a></li>
                                                    <li><a href="layout_ajax.html"><i class="fa fa-angle-right"></i>Content Loading via
                                                        Ajax </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="accordion" class="panel-group">
                                            <div class="panel panel-success">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">
                                                            Mega Menu Info #1 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseOne" class="panel-collapse in">
                                                    <div class="panel-body">
                                                        Metronic Mega Menu Works for fixed and responsive layout and has the facility to
                                                        include (almost) any Bootstrap elements.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel panel-danger">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">
                                                            Mega Menu Info #2 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseTwo" class="panel-collapse collapse">
                                                    <div class="panel-body">
                                                        Metronic Mega Menu Works for fixed and responsive layout and has the facility to
                                                        include (almost) any Bootstrap elements.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">Mega Menu Info
                                                            #3 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseThree" class="panel-collapse collapse">
                                                    <div class="panel-body">
                                                        Metronic Mega Menu Works for fixed and responsive layout and has the facility to
                                                        include (almost) any Bootstrap elements.
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
                <li class="classic-menu-dropdown"><a data-toggle="dropdown" href="javascript:;">Classic
                    <i class="fa fa-angle-down"></i></a>
                    <ul class="dropdown-menu pull-left">
                        <li><a href="#"><i class="fa fa-user"></i>Section 1 </a></li>
                        <li><a href="#"><i class="fa fa-rocket"></i>Section 2 </a></li>
                        <li><a href="#"><i class="fa fa-check"></i>Section 3 </a></li>
                        <li><a href="#"><i class="fa fa-image"></i>Section 4 </a></li>
                        <li><a href="#"><i class="fa fa-microphone"></i>Section 5 </a></li>
                        <li class="dropdown-submenu"><a href="javascript:;"><i class="fa fa-send-o"></i>More
                            options </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Second level link </a></li>
                                <li class="dropdown-submenu"><a href="javascript:;">More options </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="index.html">Third level link </a></li>
                                        <li><a href="index.html">Third level link </a></li>
                                        <li><a href="index.html">Third level link </a></li>
                                        <li><a href="index.html">Third level link </a></li>
                                        <li><a href="index.html">Third level link </a></li>
                                    </ul>
                                </li>
                                <li><a href="index.html">Second level link </a></li>
                                <li><a href="index.html">Second level link </a></li>
                                <li><a href="index.html">Second level link </a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>--%>
		</div>