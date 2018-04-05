<%@ Page Title="" Language="C#" MasterPageFile="~/TestMaster/FormControlH.Master"
    AutoEventWireup="true" CodeBehind="FormControlHor.aspx.cs" Inherits="EsquareMasterTemplate.TestMaster.FormControlHor" %>
     <%@ Register Src="~/UserControls/ImageUpload.ascx" TagName="ImageUpload" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <h3 class="page-title">
        Form Layouts <small>form layouts</small>
    </h3>
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right">
            </i></li>
            <li><a href="#">Form Stuff</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Form Layouts</a> </li>
        </ul>
        <div class="page-toolbar">
            <div class="btn-group pull-right">
        
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- ------------------------------------------------------------BEGIN PAGE CONTENT-------------------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-12">
            <div class="tab-pane" id="tab_2">
                <div class="portlet box yellow">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-gift"></i>Form Sample
                        </div>
                        <div class="tools">
                            
                                <div class="btn-group">
                                    <button id="sample_editable_1_new" class="btn green">
                                        Back <i class="fa"></i>
                                    </button>
                                </div>
                                <a class="fullscreen"
                                        href="#">
                                 </a><a href="javascript:;" class="remove"></a>
                                <a href="javascript:;" class="collapse"></a>
                                <a href="#portlet-config" data-toggle="modal"
                                    class="config"></a><a href="javascript:;" class="reload"></a>
                                 
                           
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM form-bordered -->
                        <div action="#" class="form-horizontal form-row-stripped form-label-stripped">
                        <div class="form-body">
                            <h3 class="form-section">
                                Person Info</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Html text Editor</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txttexteditor" class="html-editor form-control" runat="server"></asp:TextBox> 
                                            <span class="help-block">This is inline help </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Last Name</label>
                                        <div class="col-md-9">
                                            <select name="foo" class="select2me form-control">
                                                <option value="1">Abc</option>
                                                <option value="1">Abc</option>
                                                <option value="1">This is a really long value that breaks the fluid design for a select2</option>
                                            </select>
                                            <span class="help-block">This field has error. </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Gender</label>
                                        <div class="col-md-9">
                                            <select class="form-control">
                                                <option value="">Male</option>
                                                <option value="">Female</option>
                                            </select>
                                            <span class="help-block">Select your gender. </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Date of Birth</label>
                                        <div class="col-md-9">
                                        <uc:ImageUpload runat="server" />
                                            <input type="text" class="form-control" placeholder="dd/mm/yyyy">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Category</label>
                                        <div class="col-md-9">
                                            <select class="select2_category form-control" data-placeholder="Choose a Category"
                                                tabindex="1">
                                                <option value="Category 1">Category 1</option>
                                                <option value="Category 2">Category 2</option>
                                                <option value="Category 3">Category 5</option>
                                                <option value="Category 4">Category 4</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Membership</label>
                                        <div class="col-md-9">
                                            <div class="radio-list">
                                                <label class="radio-inline">
                                                    <input type="radio" name="optionsRadios2" value="option1" />
                                                    Free
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="optionsRadios2" value="option2" checked />
                                                    Professional
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <h3 class="form-section">
                                Address</h3>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Address 1</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Address 2</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            City</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            State</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Post Code</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Country</label>
                                        <div class="col-md-9">
                                            <select class="form-control">
                                                <option>Country 1</option>
                                                <option>Country 2</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <button type="submit" onclick="toaster()" class="btn green">
                                                Submit</button>
                                            <button type="button" class="btn default">
                                                Cancel</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                </div>
                            </div>
                        </div>
                        </div>
                        <!-- END FORM-->
                    </div>
                </div>
                <div class="portlet light bordered form-fit">
									<div class="portlet-title">
										<div class="caption">
											<i class="icon-user font-blue-hoki"></i>
											<span class="caption-subject font-blue-hoki bold uppercase">Form Sample</span>
											<span class="caption-helper">demo form...</span>
										</div>
										<div class="actions">
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-cloud-upload"></i>
											</a>
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-wrench"></i>
											</a>
											<a class="btn btn-circle btn-icon-only btn-default" href="#">
											<i class="icon-trash"></i>
											</a>
										</div>
									</div>
									<div class="portlet-body form">
										<!-- BEGIN FORM-->
										<div action="#" class="form-horizontal form-bordered form-row-stripped">
											<div class="form-body">
												<div class="form-group">
													<label class="control-label col-md-3">First Name</label>
													<div class="col-md-9">
														<input type="text" placeholder="small" class="form-control"/>
														<span class="help-block">
														This is inline help </span>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Last Name</label>
													<div class="col-md-9">
                                                        <asp:CheckBox ID="CheckBox1" runat="server" />
														<span class="help-block">
														This is inline help </span>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Gender</label>
													<div class="col-md-9">
														<select class="form-control">
															<option value="">Male</option>
															<option value="">Female</option>
														</select>
														<span class="help-block">
														Select your gender. </span>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Date of Birth</label>
													<div class="col-md-9">
														<input type="text" class="form-control" placeholder="dd/mm/yyyy">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Input mask phone</label>
													<div class="col-md-9">
													<input type="text" id="mask_phone" class="landline form-control">	
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Multi-Value Select</label>
													<div class="col-md-9">
														<select class="form-control select2_sample1" multiple>
															<optgroup label="NFC EAST">
															<option>Dallas Cowboys</option>
															<option>New York Giants</option>
															<option>Philadelphia Eagles</option>
															<option>Washington Redskins</option>
															</optgroup>
															<optgroup label="NFC NORTH">
															<option>Chicago Bears</option>
															<option>Detroit Lions</option>
															<option>Green Bay Packers</option>
															<option>Minnesota Vikings</option>
															</optgroup>
															<optgroup label="NFC SOUTH">
															<option>Atlanta Falcons</option>
															<option>Carolina Panthers</option>
															<option>New Orleans Saints</option>
															<option>Tampa Bay Buccaneers</option>
															</optgroup>
															<optgroup label="NFC WEST">
															<option>Arizona Cardinals</option>
															<option>St. Louis Rams</option>
															<option>San Francisco 49ers</option>
															<option>Seattle Seahawks</option>
															</optgroup>
															<optgroup label="AFC EAST">
															<option>Buffalo Bills</option>
															<option>Miami Dolphins</option>
															<option>New England Patriots</option>
															<option>New York Jets</option>
															</optgroup>
															<optgroup label="AFC NORTH">
															<option>Baltimore Ravens</option>
															<option>Cincinnati Bengals</option>
															<option>Cleveland Browns</option>
															<option>Pittsburgh Steelers</option>
															</optgroup>
															<optgroup label="AFC SOUTH">
															<option>Houston Texans</option>
															<option>Indianapolis Colts</option>
															<option>Jacksonville Jaguars</option>
															<option>Tennessee Titans</option>
															</optgroup>
															<optgroup label="AFC WEST">
															<option>Denver Broncos</option>
															<option>Kansas City Chiefs</option>
															<option>Oakland Raiders</option>
															<option>San Diego Chargers</option>
															</optgroup>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Loading Data</label>
													<div class="col-md-9">
														<input type="hidden" class="form-control select2_sample2">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Tags Support List</label>
													<div class="col-md-9">
														<input type="hidden" class="form-control select2_sample3" value="red, blue">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Membership</label>
													<div class="col-md-9">
														<div class="radio-list">
															<label>
															<input type="radio" name="optionsRadios2" value="option1"/>
															Free </label>
															<label>
															<input type="radio" name="optionsRadios2" value="option2" checked/>
															Professional </label>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Tag Input</label>
													<div class="col-md-9">
                                                        <asp:TextBox ID="TextBox1" class="tags form-control" runat="server"></asp:TextBox>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">City</label>
													<div class="col-md-9">
														<input type="text" class="form-control">
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Datepicker Only date</label>
													<div class="col-md-9">
														<asp:TextBox ID="TextBox7" class="date form-control" runat="server"></asp:TextBox>
                                                        <asp:TextBox ID="TextBox8" class="year form-control" runat="server"></asp:TextBox>
													</div>
												</div>
												<div class="form-group">
													<label class="control-label col-md-3">Datepicker Only Time</label>
													<div class="col-md-9">
														<asp:TextBox ID="TextBox6" class="time form-control" runat="server"></asp:TextBox>
													</div>
												</div>
												<div class="form-group last">
													<label class="control-label col-md-3">Datepicker Both</label>
													<div class="col-md-9">
														
                                                            <asp:TextBox ID="TextBox5" class="datetime form-control" runat="server"></asp:TextBox>
														
													</div>
												</div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">
                                                    Touch    Spinner 1</label>
                                                    <div class="col-md-9">
                                                        <div class="input-inline input-medium">
                                                            <asp:TextBox ID="TextBox3" value="55" class="touchspin1 form-control" runat="server"></asp:TextBox>
                                                        </div>
                                                        <span class="help-block">basic example </span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">
                                                        Spinner 2</label>
                                                    <div class="col-md-9">
                                                        <div class="input-inline input-medium">
                                                          
                                                              <asp:TextBox ID="TextBox4" value="55" class="touchspin2 form-control" runat="server"></asp:TextBox>
                                                        </div>
                                                        <span class="help-block">example with decimal steps </span>
                                                    </div>
									</div>
											</div>
											<div class="form-actions">
												<div class="row">
													<div class="col-md-offset-3 col-md-9">
														<button type="submit" class="btn green"><i class="fa fa-check"></i> Submit</button>
														<button type="button" class="btn default">Cancel</button>
													</div>
												</div>
											</div>
										</div>
										<!-- END FORM-->
									</div>
								</div>


                <div class="portlet light bg-inverse">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-equalizer font-green-haze"></i><span class="caption-subject font-green-haze bold uppercase">
                                Form Sample</span> <span class="caption-helper">some info...</span>
                        </div>
                        <div class="tools">
                            <a href="" class="collapse"></a><a href="#portlet-config" data-toggle="modal" class="config">
                            </a><a href="" class="reload"></a><a href="" class="remove"></a>
                        </div>
                    </div>
                    <div class="portlet-body form">
                        <!-- BEGIN FORM-->
                        <div action="#" class="form-horizontal">
                        <div class="form-body">
                            <h3 class="form-section">
                                Person Info</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            First Name</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="">
                                            <span class="help-block">This is inline help </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group has-error">
                                        <label class="control-label col-md-3">
                                            Last Name</label>
                                        <div class="col-md-9">
                                            <select name="foo" class="select2me form-control">
                                                <option value="1">Abc</option>
                                                <option value="1">Abc</option>
                                                <option value="1">This is a really long value that breaks the fluid design for a select2</option>
                                            </select>
                                            <span class="help-block">This field has error. </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Gender</label>
                                        <div class="col-md-9">
                                            <select class="form-control">
                                                <option value="">Male</option>
                                                <option value="">Female</option>
                                            </select>
                                            <span class="help-block">Select your gender. </span>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Date of Birth</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="dd/mm/yyyy">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Category</label>
                                        <div class="col-md-9">
                                            <select class="select2_category form-control" data-placeholder="Choose a Category"
                                                tabindex="1">
                                                <option value="Category 1">Category 1</option>
                                                <option value="Category 2">Category 2</option>
                                                <option value="Category 3">Category 5</option>
                                                <option value="Category 4">Category 4</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Membership</label>
                                        <div class="col-md-9">
                                            <div class="radio-list">
                                                <%--<label class="radio-inline">
                                                 
                                                    <asp:RadioButton ID="RadioButton1" class="icheck"
                                                        runat="server" />
                                                    Free
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="optionsRadios2" class="icheck" value="option2" checked />
                                                    Professional
                                                </label>--%>
                                                <div class="testicheck">
                                    <asp:RadioButton ID="rbtnInter1" runat="server" text="Yes" GroupName="A"     
                                        class="icheck intercom_yes" value="1"/>
                                    <asp:RadioButton ID="rbtnInter2" runat="server" text="No" GroupName="A" class="icheck intercom_yes" value="0"/>
                                    </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <h3 class="form-section">
                                Address</h3>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            maxchar count</label>
                                        <div class="col-md-9">
                                           
                                           <asp:TextBox
                                               ID="TextBox2" maxlength="40" class="maxlentgth form-control" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Address 2</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            City</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            State</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Post Code</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="control-label col-md-3">
                                            Country</label>
                                        <div class="col-md-9"> 
                                            <asp:DropDownList ID="DropDownList1" class="select2 form-control" runat="server">
                                            <asp:ListItem Text="a" Selected="True" Value="a"></asp:ListItem>
                                             <asp:ListItem Text="b" Value="b"></asp:ListItem>
                                              <asp:ListItem Text="c" Value="c"></asp:ListItem>
                                            </asp:DropDownList>
                                           
                                        </div>
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <!--/row-->
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <asp:Button ID="Button1" class="btn green" OnClientClick="alert()" runat="server" Text="Submit" />
                                            
                                            <button type="button" class="btn default">
                                                Cancel</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                </div>
                            </div>
                        </div>
                        </div>
                        <!-- END FORM-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------------END BEGIN PAGE CONTENT-------------------------------------------------------------------------------->

</asp:Content>
