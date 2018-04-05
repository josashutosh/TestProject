<%@ Page Title="" Language="C#" MasterPageFile="~/Profile/ProfileMaster.Master" AutoEventWireup="true"
    CodeBehind="test1.aspx.cs" Inherits="EsquareMasterTemplate.Profile.test" validateRequest="false" enableViewStateMac="false" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal.css"
        rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css"
        rel="stylesheet" type="text/css" />
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageheadeRight" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ProfileSidebarcustom" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
          	<!-- BEGIN PORTLET-->
					<div class="portlet box yellow">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-gift"></i>Extended Modals Example
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								<a href="javascript:;" class="reload">
								</a>
							</div>
						</div>
						<div id="abc" class="portlet-body">
							<table class="table table-hover table-striped table-bordered">
							<tr>
								<td>
									 Responsive
								</td>
								<td>
									<a class="btn default" data-toggle="modal" href="#responsive">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Stackable
								</td>
								<td>
									<a class="btn default" data-target="#stack1" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Ajax
								</td>
								<td>
									<a class="btn default" id="ajax-demo" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Static Background
								</td>
								<td>
									<a class="btn default" data-target="#static2" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Static Background with Animation
								</td>
								<td>
									<a class="btn default" data-target="#static" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Full Width
								</td>
								<td>
									<a class="btn default" data-target="#full-width" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							<tr>
								<td>
									 Long Modals
								</td>
								<td>
									<a class="btn default" data-target="#long" data-toggle="modal">
									View Demo </a>
								</td>
							</tr>
							</table>
							<!-- responsive -->
							<div id="responsive" class="modal fade" tabindex="-1" data-width="760">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">Responsive</h4>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-md-6">
											<h4>Some Input</h4>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
										</div>
										<div class="col-md-6">
											<h4>Some More Input</h4>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
											<p>
												<input class="form-control" type="text">
											</p>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
									<button type="button" class="btn blue">Save changes</button>
								</div>
							</div>
							<!-- stackable -->
							<div id="stack1" class="modal fade" tabindex="-1" data-focus-on="input:first">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">Stack One</h4>
								</div>
								<div class="modal-body">
									<p>
										 One fine body…
									</p>
									<p>
										 One fine body…
									</p>
									<p>
										 One fine body…
									</p>
									<div class="form-group">
										<input class="form-control" type="text" data-tabindex="1">
									</div>
									<div class="form-group">
										<input class="form-control" type="text" data-tabindex="2">
									</div>
									<button class="btn blue" data-toggle="modal" href="#stack2">Launch modal</button>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
									<button type="button" class="btn btn-primary">Ok</button>
								</div>
							</div>
							<div id="stack2" class="modal fade" tabindex="-1" data-focus-on="input:first">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">Stack Two</h4>
								</div>
								<div class="modal-body">
									<p>
										 One fine body…
									</p>
									<p>
										 One fine body…
									</p>
									<div class="form-group">
										<input class="form-control" type="text" data-tabindex="1">
									</div>
									<div class="form-group">
										<input class="form-control" type="text" data-tabindex="2">
									</div>
									<button class="btn blue" data-toggle="modal" href="#stack3">Launch modal</button>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
									<button type="button" class="btn red">Ok</button>
								</div>
							</div>
							<div id="stack3" class="modal fade" tabindex="-1" data-focus-on="input:first">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">Stack Three</h4>
								</div>
								<div class="modal-body">
									<p>
										 One fine body…
									</p>
									<input class="form-control" type="text" data-tabindex="1">
									<input class="form-control" type="text" data-tabindex="2">
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
									<button type="button" class="btn green">Ok</button>
								</div>
							</div>
							<!-- ajax -->
							<div id="ajax-modal" class="modal fade" tabindex="-1">
							</div>
							<!-- static -->
							<div id="static" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
								<div class="modal-body">
									<p>
										 Would you like to continue with some arbitrary task?
									</p>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Cancel</button>
									<button type="button" data-dismiss="modal" class="btn blue">Continue Task</button>
								</div>
							</div>
							<div id="static2" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false" data-attention-animation="false">
								<div class="modal-body">
									<p>
										 Would you like to continue with some arbitrary task?
									</p>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Cancel</button>
									<button type="button" data-dismiss="modal" class="btn blue">Continue Task</button>
								</div>
							</div>
							<!-- full width -->
							<div id="full-width" class="modal container fade" tabindex="-1">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">Full Width</h4>
								</div>
								<div class="modal-body">
									<p>
										 This modal will resize itself to the same dimensions as the container class.
									</p>
									<p>
										 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sollicitudin ipsum ac ante fermentum suscipit. In ac augue non purus accumsan lobortis id sed nibh. Nunc egestas hendrerit ipsum, et porttitor augue volutpat non. Aliquam erat volutpat. Vestibulum scelerisque lobortis pulvinar. Aenean hendrerit risus neque, eget tincidunt leo. Vestibulum est tortor, commodo nec cursus nec, vestibulum vel nibh. Morbi elit magna, ornare placerat euismod semper, dignissim vel odio. Phasellus elementum quam eu ipsum euismod pretium.
									</p>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
									<button type="button" class="btn blue">Save changes</button>
								</div>
							</div>
							<!-- long modals -->
							<div id="long" class="modal fade modal-scroll" tabindex="-1" data-replace="true">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									<h4 class="modal-title">A Fairly Long Modal</h4>
								</div>
								<div class="modal-body">
									<img style="height: 800px" src="http://i.imgur.com/KwPYo.jpg">
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- END PORTLET-->
            </div>
        <asp:Button ID="Button1" class="Button1 btn green" OnClientClick="abc()" runat="server" Text="Button" />
       </div>
       <script>

           function abc() {
               Metronic.blockUI({
                   target: '#abc',
                   boxed: true
               });

               window.setTimeout(function () {
                   Metronic.unblockUI('#abc');
               }, 2000);
           }
            
      </script>

</asp:Content>
