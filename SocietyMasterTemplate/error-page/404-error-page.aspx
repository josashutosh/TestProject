<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="404-error-page.aspx.cs" Inherits="EsquareMasterTemplate.error_page._404_error_page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <meta charset="utf-8" />
    <title>Login Lock </title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
   <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
    <link href="../ThemeAssets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
        type="text/css" />
    <link href="../ThemeAssets/global/plugins/simple-line-icons/simple-line-icons.min.css"
        rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"
        type="text/css" />
    <link href="../ThemeAssets/global/plugins/uniform/css/uniform.default.min.css" rel="stylesheet"
        type="text/css" />

<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
 
    <link href="../ThemeAssets/admin/pages/css/error.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME STYLES -->
   
    <link href="../ThemeAssets/global/css/components.css" rel="stylesheet" type="text/css" />
     <link href="../ThemeAssets/global/css/plugins.css" rel="stylesheet" type="text/css" />
     <link href="../ThemeAssets/admin/layout/css/layout.css" rel="stylesheet" type="text/css" />
   
    <link href="../ThemeAssets/admin/layout/css/themes/default.css" rel="stylesheet" id="style_color" type="text/css" />
     <link href="../ThemeAssets/admin/layout/css/custom.css" rel="stylesheet" type="text/css" />
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>
</head>
<body class="page-404-full-page">
    <form id="form1" runat="server">
   <div class="row">
	<div class="col-md-12 page-404">
		<div class="number">
			 404
		</div>
		<div class="details">
			<h3>Oops! You're lost.</h3>
			<p>
				 We can not find the page you're looking for.<br/>
				<a href="index.html">
				Return home </a>
				or try the search bar below.
			</p>
			<div action="#">
				<div class="input-group input-medium">
					<input type="text" class="form-control" placeholder="keyword..." />
					<span class="input-group-btn">
					<button type="submit" class="btn blue"><i class="fa fa-search"></i></button>
					</span>
				</div>
				<!-- /input-group -->
			</div>
		</div>
	</div>
</div>
    </form>
</body>
</html>
