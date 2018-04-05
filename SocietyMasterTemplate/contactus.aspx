<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="EsquareMasterTemplate.contactus" %>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all"
        rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/global/plugins/font-awesome/css/font-awesome.min.css"
        rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/global/plugins/simple-line-icons/simple-line-icons.min.css"
        rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"
        type="text/css" />
    <link href="ThemeAssets/global/plugins/bootstrap-datepicker/css/datepicker3.css"
        rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"
        rel="stylesheet" type="text/css" />

    <link href="ThemeAssets/global/plugins/uniform/css/uniform.default.min.css" rel="stylesheet"
        type="text/css" />

    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->

        <link href="ThemeAssets/global/css/plugins.css" rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/global/css/components.css" rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/admin/layout/css/themes/darkblue.css" rel="stylesheet"
        type="text/css" />
    <link href="ThemeAssets/admin/layout/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="ThemeAssets/admin/layout/css/custom.css" rel="stylesheet" type="text/css" />




</head>
<body class="page-header-fixed login">
    <form id="form1" runat="server">
    <div class="page-container">
	<!-- BEGIN SIDEBAR -->
	
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
							<h4 class="modal-title">Modal title</h4>
						</div>
						<div class="modal-body">
							 Widget settings form goes here
						</div>
						<div class="modal-footer">
							<button type="button" class="btn blue">Save changes</button>
							<button type="button" class="btn default" data-dismiss="modal">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN STYLE CUSTOMIZER -->
			<div class="theme-panel hidden-xs hidden-sm">
				<div class="toggler">
				</div>
				<div class="toggler-close">
				</div>
				<div class="theme-options">
					<div class="theme-option theme-colors clearfix">
						<span>
						THEME COLOR </span>
						<ul>
							<li class="color-default current tooltips" data-style="default" data-container="body" data-original-title="Default">
							</li>
							<li class="color-darkblue tooltips" data-style="darkblue" data-container="body" data-original-title="Dark Blue">
							</li>
							<li class="color-blue tooltips" data-style="blue" data-container="body" data-original-title="Blue">
							</li>
							<li class="color-grey tooltips" data-style="grey" data-container="body" data-original-title="Grey">
							</li>
							<li class="color-light tooltips" data-style="light" data-container="body" data-original-title="Light">
							</li>
							<li class="color-light2 tooltips" data-style="light2" data-container="body" data-html="true" data-original-title="Light 2">
							</li>
						</ul>
					</div>
					<div class="theme-option">
						<span>
						Layout </span>
						<select class="layout-option form-control input-sm">
							<option value="fluid" selected="selected">Fluid</option>
							<option value="boxed">Boxed</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Header </span>
						<select class="page-header-option form-control input-sm">
							<option value="fixed" selected="selected">Fixed</option>
							<option value="default">Default</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Top Menu Dropdown</span>
						<select class="page-header-top-dropdown-style-option form-control input-sm">
							<option value="light" selected="selected">Light</option>
							<option value="dark">Dark</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Sidebar Mode</span>
						<select class="sidebar-option form-control input-sm">
							<option value="fixed">Fixed</option>
							<option value="default" selected="selected">Default</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Sidebar Menu </span>
						<select class="sidebar-menu-option form-control input-sm">
							<option value="accordion" selected="selected">Accordion</option>
							<option value="hover">Hover</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Sidebar Style </span>
						<select class="sidebar-style-option form-control input-sm">
							<option value="default" selected="selected">Default</option>
							<option value="light">Light</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Sidebar Position </span>
						<select class="sidebar-pos-option form-control input-sm">
							<option value="left" selected="selected">Left</option>
							<option value="right">Right</option>
						</select>
					</div>
					<div class="theme-option">
						<span>
						Footer </span>
						<select class="page-footer-option form-control input-sm">
							<option value="fixed">Fixed</option>
							<option value="default" selected="selected">Default</option>
						</select>
					</div>
				</div>
			</div>
			<!-- END STYLE CUSTOMIZER -->
			<!-- BEGIN PAGE HEADER-->
			<h3 class="page-title">
			Contact Us <small>contact us page</small>
			</h3>
			<div class="page-bar">
				<ul class="page-breadcrumb">
					<li>
						<i class="fa fa-home"></i>
						<a href="index.html">Home</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">Extra</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">Contact Us</a>
					</li>
				</ul>
				<div class="page-toolbar">
					<div class="btn-group pull-right">
						
					</div>
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<!-- BEGIN PAGE CONTENT-->
			<div class="row">
				<div class="col-md-12">
					<!-- Google Map -->
					<div class="row">
						<div id="map" class="gmaps margin-bottom-40" style="height:400px;">
						</div>
					</div>
					<div class="row margin-bottom-20">
						<div class="col-md-6">
							<div class="space20">
							</div>
							<h3 class="form-section">Contacts</h3>
							<p>
								 Lorem ipsum dolor sit amet, Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat consectetuer adipiscing elit.
							</p>
							<div class="well">
								<h4>Address</h4>
								<address>
								<strong>Loop, Inc.</strong><br>
								 795 Park Ave, Suite 120</br>
								 San Francisco, CA 94107</br>
								<abbr title="Phone">P:</abbr> (234) 145-1810 </address>
								<address>
								<strong>Email</strong><br/>
								<a href="mailto:#">
								first.last@email.com </a>
								</address>
								<ul class="social-icons margin-bottom-10">
									<li>
										<a href="#" data-original-title="facebook" class="facebook">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="github" class="github">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="Goole Plus" class="googleplus">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="linkedin" class="linkedin">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="rss" class="rss">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="skype" class="skype">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="twitter" class="twitter">
										</a>
									</li>
									<li>
										<a href="#" data-original-title="youtube" class="youtube">
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-6">
							<div class="space20">
							</div>
							<!-- BEGIN FORM-->
							<form action="#">
								<h3 class="form-section">Feedback</h3>
								<p>
									 Lorem ipsum dolor sit amet, Ut wisi enim ad minim veniam, quis nostrud exerci. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat consectetuer
								</p>
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-check"></i>
										<input type="text" class="form-control" placeholder="Subject" />
									</div>
								</div>
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i>
										<input type="text" class="form-control" placeholder="Name"/>
									</div>
								</div>
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-envelope"></i>
										<input type="password" class="form-control" placeholder="Email"/>
									</div>
								</div>
								<div class="form-group">
									<textarea class="form-control" rows="3=6" placeholder="Feedback"></textarea>
								</div>
								<button type="submit" class="btn green">Submit</button>
							</form>
							<!-- END FORM-->
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTENT-->
		</div>
	</div>
	<!-- END CONTENT -->
	
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer">
	<div class="page-footer-inner">
		 2014 &copy; Metronic by keenthemes.
	</div>
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
</div>
    </form>
</body>
</html>
