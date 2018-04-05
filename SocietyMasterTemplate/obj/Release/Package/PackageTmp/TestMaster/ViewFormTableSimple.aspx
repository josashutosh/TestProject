<%@ Page Title="" Language="C#" MasterPageFile="~/TestMaster/FormControlH.Master"
    AutoEventWireup="true" CodeBehind="ViewFormTableSimple.aspx.cs" Inherits="EsquareMasterTemplate.TestMaster.ViewFormTableSimple" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link href="../ThemeAssets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"
        rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"
        rel="stylesheet" type="text/css" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <h3 class="page-title">
        Form Layouts <small>Table</small>
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
    <!-- ------------------------------------------------------------END PAGE HEADER----------------------------------------------------------------------------------->
    <!-- BEGIN PAGE CONTENT-->
    <div class="row">
        <div class="col-md-12">
            <div class="note note-success">
                <p>
                    Please try to re-size your browser window in order to see the tables in responsive
                    mode.
                </p>
            </div>
            <!-- BEGIN SAMPLE TABLE PORTLET-->
            <div class="portlet box green">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-cogs"></i>Responsive Flip Scroll Tables
                    </div>
                    <div class="tools">
                        <a href="javascript:;" class="collapse"></a><a href="#portlet-config" data-toggle="modal"
                            class="config"></a><a href="javascript:;" class="reload"></a><a href="javascript:;"
                                class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body flip-scroll">
                    <table class="table table-bordered table-striped table-condensed flip-content">
                        <thead class="flip-content">
                            <tr>
                                <th width="20%">
                                    Code
                                </th>
                                <th>
                                    Company
                                </th>
                                <th class="numeric">
                                    Price
                                </th>
                                <th class="numeric">
                                    Change
                                </th>
                                <th class="numeric">
                                    Change %
                                </th>
                                <th class="numeric">
                                    Open
                                </th>
                                <th class="numeric">
                                    High
                                </th>
                                <th class="numeric">
                                    Low
                                </th>
                                <th class="numeric">
                                    Volume
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    AAC
                                </td>
                                <td>
                                    AUSTRALIAN AGRICULTURAL COMPANY LIMITED.
                                </td>
                                <td class="numeric">
                                    &nbsp;
                                </td>
                                <td class="numeric">
                                    -0.01
                                </td>
                                <td class="numeric">
                                    -0.36%
                                </td>
                                <td class="numeric">
                                    $1.39
                                </td>
                                <td class="numeric">
                                    $1.39
                                </td>
                                <td class="numeric">
                                    &nbsp;
                                </td>
                                <td class="numeric">
                                    9,395
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    AAD
                                </td>
                                <td>
                                    ARDENT LEISURE GROUP
                                </td>
                                <td class="numeric">
                                    $1.15
                                </td>
                                <td class="numeric">
                                    +0.02
                                </td>
                                <td class="numeric">
                                    1.32%
                                </td>
                                <td class="numeric">
                                    $1.14
                                </td>
                                <td class="numeric">
                                    $1.15
                                </td>
                                <td class="numeric">
                                    $1.13
                                </td>
                                <td class="numeric">
                                    56,431
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    AAX
                                </td>
                                <td>
                                    AUSENCO LIMITED
                                </td>
                                <td class="numeric">
                                    $4.00
                                </td>
                                <td class="numeric">
                                    -0.04
                                </td>
                                <td class="numeric">
                                    -0.99%
                                </td>
                                <td class="numeric">
                                    $4.01
                                </td>
                                <td class="numeric">
                                    $4.05
                                </td>
                                <td class="numeric">
                                    $4.00
                                </td>
                                <td class="numeric">
                                    90,641
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ABC
                                </td>
                                <td>
                                    ADELAIDE BRIGHTON LIMITED
                                </td>
                                <td class="numeric">
                                    $3.00
                                </td>
                                <td class="numeric">
                                    +0.06
                                </td>
                                <td class="numeric">
                                    2.04%
                                </td>
                                <td class="numeric">
                                    $2.98
                                </td>
                                <td class="numeric">
                                    $3.00
                                </td>
                                <td class="numeric">
                                    $2.96
                                </td>
                                <td class="numeric">
                                    862,518
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ABP
                                </td>
                                <td>
                                    ABACUS PROPERTY GROUP
                                </td>
                                <td class="numeric">
                                    $1.91
                                </td>
                                <td class="numeric">
                                    0.00
                                </td>
                                <td class="numeric">
                                    0.00%
                                </td>
                                <td class="numeric">
                                    $1.92
                                </td>
                                <td class="numeric">
                                    $1.93
                                </td>
                                <td class="numeric">
                                    $1.90
                                </td>
                                <td class="numeric">
                                    595,701
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ABY
                                </td>
                                <td>
                                    ADITYA BIRLA MINERALS LIMITED
                                </td>
                                <td class="numeric">
                                    $0.77
                                </td>
                                <td class="numeric">
                                    +0.02
                                </td>
                                <td class="numeric">
                                    2.00%
                                </td>
                                <td class="numeric">
                                    $0.76
                                </td>
                                <td class="numeric">
                                    $0.77
                                </td>
                                <td class="numeric">
                                    $0.76
                                </td>
                                <td class="numeric">
                                    54,567
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ACR
                                </td>
                                <td>
                                    ACRUX LIMITED
                                </td>
                                <td class="numeric">
                                    $3.71
                                </td>
                                <td class="numeric">
                                    +0.01
                                </td>
                                <td class="numeric">
                                    0.14%
                                </td>
                                <td class="numeric">
                                    $3.70
                                </td>
                                <td class="numeric">
                                    $3.72
                                </td>
                                <td class="numeric">
                                    $3.68
                                </td>
                                <td class="numeric">
                                    191,373
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ADU
                                </td>
                                <td>
                                    ADAMUS RESOURCES LIMITED
                                </td>
                                <td class="numeric">
                                    $0.72
                                </td>
                                <td class="numeric">
                                    0.00
                                </td>
                                <td class="numeric">
                                    0.00%
                                </td>
                                <td class="numeric">
                                    $0.73
                                </td>
                                <td class="numeric">
                                    $0.74
                                </td>
                                <td class="numeric">
                                    $0.72
                                </td>
                                <td class="numeric">
                                    8,602,291
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    AGG
                                </td>
                                <td>
                                    ANGLOGOLD ASHANTI LIMITED
                                </td>
                                <td class="numeric">
                                    $7.81
                                </td>
                                <td class="numeric">
                                    -0.22
                                </td>
                                <td class="numeric">
                                    -2.74%
                                </td>
                                <td class="numeric">
                                    $7.82
                                </td>
                                <td class="numeric">
                                    $7.82
                                </td>
                                <td class="numeric">
                                    $7.81
                                </td>
                                <td class="numeric">
                                    148
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    AGK
                                </td>
                                <td>
                                    AGL ENERGY LIMITED
                                </td>
                                <td class="numeric">
                                    $13.82
                                </td>
                                <td class="numeric">
                                    +0.02
                                </td>
                                <td class="numeric">
                                    0.14%
                                </td>
                                <td class="numeric">
                                    $13.83
                                </td>
                                <td class="numeric">
                                    $13.83
                                </td>
                                <td class="numeric">
                                    $13.67
                                </td>
                                <td class="numeric">
                                    846,403
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    AGO
                                </td>
                                <td>
                                    ATLAS IRON LIMITED
                                </td>
                                <td class="numeric">
                                    $3.17
                                </td>
                                <td class="numeric">
                                    -0.02
                                </td>
                                <td class="numeric">
                                    -0.47%
                                </td>
                                <td class="numeric">
                                    $3.11
                                </td>
                                <td class="numeric">
                                    $3.22
                                </td>
                                <td class="numeric">
                                    $3.10
                                </td>
                                <td class="numeric">
                                    5,416,303
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- END SAMPLE TABLE PORTLET-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row">
                <div class="col-md-12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet box grey-cascade">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-globe"></i>Managed Table
                            </div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a><a href="#portlet-config" data-toggle="modal"
                                    class="config"></a><a href="javascript:;" class="reload"></a><a href="javascript:;"
                                        class="remove"></a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="table-toolbar">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="btn-group">
                                            <button id="sample_editable_1_new" class="btn green">
                                                Add New <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="btn-group pull-right">
                                            <button class="btn dropdown-toggle" data-toggle="dropdown">
                                                Tools <i class="fa fa-angle-down"></i>
                                            </button>
                                            <ul class="dropdown-menu pull-right">
                                                <li><a href="#">Print </a></li>
                                                <li><a href="#">Save as PDF </a></li>
                                                <li><a href="#">Export to Excel </a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-striped table-bordered table-hover" id="sample_1">
                                <thead>
                                    <tr>
                                        <th class="table-checkbox">
                                            <input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" />
                                        </th>
                                        <th>
                                            Username
                                        </th>
                                        <th>
                                            Email
                                        </th>
                                        <th>
                                            Points
                                        </th>
                                        <th>
                                            Joined
                                        </th>
                                        <th>
                                            Status
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            shuxer
                                        </td>
                                        <td>
                                            <a href="mailto:shuxer@gmail.com">shuxer@gmail.com </a>
                                        </td>
                                        <td>
                                          <button type="button" class="btn btn-circle green-haze btn-sm">Follow</button>
                                        </td>
                                        <td class="center">
                                           <button type="button" class="btn btn-circle btn-danger btn-sm">Message</button>
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            looper
                                        </td>
                                        <td>
                                            <a href="mailto:looper90@gmail.com">looper90@gmail.com </a>
                                        </td>
                                        <td>
                                            120
                                        </td>
                                        <td class="center">
                                            12.12.2011
                                        </td>
                                        <td>
                                            <span class="label label-sm label-warning">Suspended </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            userwow
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@yahoo.com">userwow@yahoo.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            user1wow
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">userwow@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-default">Blocked </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            restest
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">test@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            foopl
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            weep
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            coop
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            pppol
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            test
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            userwow
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">userwow@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-default">Blocked </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            test
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">test@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            goop
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            weep
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            15.11.2011
                                        </td>
                                        <td>
                                            <span class="label label-sm label-default">Blocked </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            toopl
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            16.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            userwow
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">userwow@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            9.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-default">Blocked </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            tes21t
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">test@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            14.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            fop
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            13.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-warning">Suspended </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            kop
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            17.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            vopl
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.11.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            userwow
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">userwow@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-default">Blocked </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            wap
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">test@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            12.12.2012
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            test
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            19.12.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            toop
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            17.12.2010
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                    <tr class="odd gradeX">
                                        <td>
                                            <input type="checkbox" class="checkboxes" value="1" />
                                        </td>
                                        <td>
                                            weep
                                        </td>
                                        <td>
                                            <a href="mailto:userwow@gmail.com">good@gmail.com </a>
                                        </td>
                                        <td>
                                            20
                                        </td>
                                        <td class="center">
                                            15.11.2011
                                        </td>
                                        <td>
                                            <span class="label label-sm label-success">Approved </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->

                    <!-- BEGIN scroll  EXAMPLE TABLE PORTLET-->
					<div class="portlet box green-haze">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-globe"></i>Scroller
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse">
								</a>
								<a href="#portlet-config" data-toggle="modal" class="config">
								</a>
								<a href="javascript:;" class="reload">
								</a>
								<a href="javascript:;" class="remove">
								</a>
							</div>
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-hover" id="sample_5">
							<thead>
							<tr>
								<th>
									 Rendering engine
								</th>
								<th>
									 Browser
								</th>
								<th class="hidden-xs">
									 Platform(s)
								</th>
								<th class="hidden-xs">
									 Engine version
								</th>
								<th class="hidden-xs">
									 CSS grade
								</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 4.0
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 4
								</td>
								<td>
									 X
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 5.0
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 5
								</td>
								<td>
									 C
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 5.5
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 5.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 6
								</td>
								<td>
									 Win 98+
								</td>
								<td>
									 6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 7
								</td>
								<td>
									 Win XP SP2+
								</td>
								<td>
									 7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 AOL browser (AOL desktop)
								</td>
								<td>
									 Win XP
								</td>
								<td>
									 6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 1.0
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 1.5
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 2.0
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 3.0
								</td>
								<td>
									 Win 2k+ / OSX.3+
								</td>
								<td>
									 1.9
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Camino 1.0
								</td>
								<td>
									 OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Camino 1.5
								</td>
								<td>
									 OSX.3+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape 7.2
								</td>
								<td>
									 Win 95+ / Mac OS 8.6-9.2
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape Browser 8
								</td>
								<td>
									 Win 98SE+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape Navigator 9
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.0
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.1
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.2
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.2
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.3
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.3
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.4
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.4
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.5
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.6
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.7
								</td>
								<td>
									 Win 98+ / OSX.1+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.8
								</td>
								<td>
									 Win 98+ / OSX.1+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Seamonkey 1.1
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Epiphany 2.20
								</td>
								<td>
									 Gnome
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 1.2
								</td>
								<td>
									 OSX.3
								</td>
								<td>
									 125.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 1.3
								</td>
								<td>
									 OSX.3
								</td>
								<td>
									 312.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 2.0
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 419.3
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 3.0
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 522.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 OmniWeb 5.5
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 420
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 iPod Touch / iPhone
								</td>
								<td>
									 iPod
								</td>
								<td>
									 420.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 S60
								</td>
								<td>
									 S60
								</td>
								<td>
									 413
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 7.0
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 7.5
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 8.0
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 8.5
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.0
								</td>
								<td>
									 Win 95+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.2
								</td>
								<td>
									 Win 88+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.5
								</td>
								<td>
									 Win 88+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera for Wii
								</td>
								<td>
									 Wii
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Nokia N800
								</td>
								<td>
									 N800
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Nintendo DS browser
								</td>
								<td>
									 Nintendo DS
								</td>
								<td>
									 8.5
								</td>
								<td>
									 C/A<sup>1</sup>
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
					<!-- END scroll EXAMPLE TABLE PORTLET-->
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					<div class="portlet box blue-madison">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-globe"></i>Responsive Table With Expandable details
							</div>
							<div class="tools">
								<a href="javascript:;" class="reload">
								</a>
								<a href="javascript:;" class="remove">
								</a>
							</div>
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-bordered table-hover" id="sample_3">
							<thead>
							<tr>
								<th>
									 Rendering engine
								</th>
								<th>
									 Browser
								</th>
								<th>
									 Platform(s)
								</th>
								<th>
									 Engine version
								</th>
								<th>
									 CSS grade
								</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 4.0
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 4
								</td>
								<td>
									 X
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 5.0
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 5
								</td>
								<td>
									 C
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 5.5
								</td>
								<td>
									 Win 95+
								</td>
								<td>
									 5.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 6
								</td>
								<td>
									 Win 98+
								</td>
								<td>
									 6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 Internet Explorer 7
								</td>
								<td>
									 Win XP SP2+
								</td>
								<td>
									 7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Trident
								</td>
								<td>
									 AOL browser (AOL desktop)
								</td>
								<td>
									 Win XP
								</td>
								<td>
									 6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 1.0
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 1.5
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 2.0
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Firefox 3.0
								</td>
								<td>
									 Win 2k+ / OSX.3+
								</td>
								<td>
									 1.9
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Camino 1.0
								</td>
								<td>
									 OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Camino 1.5
								</td>
								<td>
									 OSX.3+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape 7.2
								</td>
								<td>
									 Win 95+ / Mac OS 8.6-9.2
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape Browser 8
								</td>
								<td>
									 Win 98SE+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Netscape Navigator 9
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.0
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.1
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.2
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.2
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.3
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.3
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.4
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.4
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.5
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.6
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 1.6
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.7
								</td>
								<td>
									 Win 98+ / OSX.1+
								</td>
								<td>
									 1.7
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Mozilla 1.8
								</td>
								<td>
									 Win 98+ / OSX.1+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Seamonkey 1.1
								</td>
								<td>
									 Win 98+ / OSX.2+
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Gecko
								</td>
								<td>
									 Epiphany 2.20
								</td>
								<td>
									 Gnome
								</td>
								<td>
									 1.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 1.2
								</td>
								<td>
									 OSX.3
								</td>
								<td>
									 125.5
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 1.3
								</td>
								<td>
									 OSX.3
								</td>
								<td>
									 312.8
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 2.0
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 419.3
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 Safari 3.0
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 522.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 OmniWeb 5.5
								</td>
								<td>
									 OSX.4+
								</td>
								<td>
									 420
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 iPod Touch / iPhone
								</td>
								<td>
									 iPod
								</td>
								<td>
									 420.1
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Webkit
								</td>
								<td>
									 S60
								</td>
								<td>
									 S60
								</td>
								<td>
									 413
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 7.0
								</td>
								<td>
									 Win 95+ / OSX.1+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 7.5
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 8.0
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 8.5
								</td>
								<td>
									 Win 95+ / OSX.2+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.0
								</td>
								<td>
									 Win 95+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.2
								</td>
								<td>
									 Win 88+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera 9.5
								</td>
								<td>
									 Win 88+ / OSX.3+
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Opera for Wii
								</td>
								<td>
									 Wii
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Nokia N800
								</td>
								<td>
									 N800
								</td>
								<td>
									 -
								</td>
								<td>
									 A
								</td>
							</tr>
							<tr>
								<td>
									 Presto
								</td>
								<td>
									 Nintendo DS browser
								</td>
								<td>
									 Nintendo DS
								</td>
								<td>
									 8.5
								</td>
								<td>
									 C/A<sup>1</sup>
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->


                </div>
            </div>
        </div>
</div>
</asp:Content>
