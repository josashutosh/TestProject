<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboards/Dashboard.Master" AutoEventWireup="true"
    CodeBehind="SocietyMemberDashboard.aspx.cs" Inherits="EsquareMasterTemplate.Dashboards.SocietyMemberDashboard" EnableEventValidation="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../ThemeAssets/admin/pages/css/profile.css" rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css"
        rel="stylesheet" type="text/css" />
    <link href="../ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal.css"
        rel="stylesheet" type="text/css" />
    <style>
        #PopCurrentMaintenance:hover, #PopCurrentMaintenance table :hover, #PopCurrentMaintenance a:hover, #Div2 .accordion-toggle:hover {
            cursor: default !important;
            text-decoration: none !important;
        }
       
        .portlet > .portlet-title > .tools > a {
            height:0px !important;
            color:#FFFFFF;
        }
           .portlet > .portlet-title > .tools > a:hover {
            height:0px !important;
            color:#FFFFFF !important;
        }
         .portlet > .portlet-title > .tools > a {
            height:0px !important;
            color:#FFFFFF !important;
        }



    </style>
    <script type="text/javascript">
        var MaintenanceID, PropertyType, CalculationMethodId, PropertyTaxes, WaterCharges, ElectricityCharges, RepairsMaintenanceFund, LiftCharges, SinkingFund, ServiceCharges, CarParkingCharges;
        var SecuritySalary, HousekeepingSalary, ManagerSalary, Stationary, DgSet, GymInstructor, CommunityHall, InsuranceCharges, SupervisorSalary, TenantMaintenance;
        var InterestonDefaulted, RepaymentInstmntLoanInterest, NonOccupancyCharges, InsuranceCharges, LeaseRent, NonAgriculturalTax, OtherCharges, TotalMaintenanceSum, MaintenancePerFlat;
        var PerSquareFeetRate, FixedSqft, FixedRate, AdditionalSqft, AdditionalSqftRate, EffectiveFromDate, EffectiveToDate, TotalArea, FlatCount, CalculationMethod;

        $(document).ready(function () {
            $("#popCurentmaintenanaceInfo").click(function () {
                hidecontrol();
                var imageprofile = document.getElementById('<%=imgProfile.ClientID%>').dataSrc;
                var ss = document.getElementById('<%=imgProfile.ClientID%>').value;
                if (imageprofile == "") {
                    $('#<%=imgProfile.ClientID%>').attr({ alt: "profile", src: "../Images/Profile/No-Image.png", width: "150px", height: "150px" });
                }
                showdiv();
                //GetMaintenanceInfoCurrentMonth();
                // HideDiv();
            });

            $('.confirmation').on('click', function () {
                return confirm('Are you sure you want to pay your mainteanance?');
            });

            $("#popMemberMasterInfo").click(function () {
                //$('.member-info').empty();
                showdiv();
                GetMemberinfo(1);
                HideDiv();
            });

            $("#SocAccDetailpops").click(function () {
                if ($('#SocietyAccountDtl').is(':empty') == true) {
                    showdiv();
                    GetsocietyInfobyID();
                    HideDiv();
                }
            });

            $("#TotalPendingExpenseLink").click(function () {

                showdiv();
                GetTotalOutStandingMaintenance();
                HideDiv();

            });





            $('#MemberInfopagination').bootpag().on('page', function (event, num) {
                showdiv();
                GetMemberinfo(num);
                HideDiv();
            });

            $("#Helpdesk_popup").click(function () {

                showdiv();
                HideDiv();
            });
        });
        function showdiv() {
            Society.blockUI({
                centerX: false,
                centerY: false,
                target: '.Main_Collection_Socity',
                boxed: true,
                message: 'Processing...'
            });

        }

        function HideDiv() {
            window.setTimeout(function () {
                Society.unblockUI('.Main_Collection_Socity');
            }, 1000);

        }

        function GetMemberinfo(PageID) {
            $.ajax({
                type: 'POST',
                url: "SocietyMemberDashboard.aspx/GetMemberInfobyID",
                data: '{"PageIndex":"' + PageID + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: GetMemberinfoSuccess,
                error: GetMemberinfoError
            });
        }

        function GetsocietyInfobyID() {
            $.ajax({
                type: 'POST',
                url: "SocietyMemberDashboard.aspx/GetsocietyInfobyID",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    if (response.d == "N") {

                        //  $('#SocietyAccountDtl').html('');

                        $('#SocietyAccountDtl').append("No Record Available").fadeIn();

                    }
                    else {

                        var Result = JSON.parse(response.d);

                        var sname = Result.Table[0].SocietyName == null ? "-" : Result.Table[0].SocietyName;
                        var accnumber = Result.Table[0].AccountNumber == null ? "-" : Result.Table[0].AccountNumber;
                        var BankName = Result.Table[0].BankName == null ? "-" : Result.Table[0].BankName;
                        var Branch = Result.Table[0].Bankbranch == null ? "-" : Result.Table[0].Bankbranch;
                        var ifscCode = Result.Table[0].IfscCode == null ? "-" : Result.Table[0].IfscCode;
                        var str = '<table ID="tblmemberInfo" class="table table-striped table-bordered table-hover">';
                        str += '<tr><td><b>Society Name </b></td><td>' + sname + '</td></tr>';
                        str += '<tr><td><b>Account number </b></td><td>' + accnumber + '</td></tr>';
                        str += '<tr><td><b>Bank Name </b></td><td>' + BankName + '</td></tr>';
                        str += '<tr><td><b>Branch </b></td><td>' + Branch + '</td></tr>';
                        str += '<tr><td><b>Ifsc Code </b></td><td>' + ifscCode + '</td></tr>';
                        str += '</table>';
                        $('#SocietyAccountDtl').append(str).fadeIn();
                    }

                },
                error: function (response) {
                    HideDiv();
                }
            });
        }

        function GetMemberinfoSuccess(response) {
            if (response.d != "[]") {
                var Result = JSON.parse(response.d);

                var isRented = '<%=Session["isrented"].ToString() %>'
                 var count = parseInt(Result.length - 1);
                 var total = Result[count].total;
                 var page = Result[count].rowcount;
                 var RecordCount = Result[count].rowcount;
                 //$('#SoMemDashMemberinfo').html('');

                 if (Result.length > 0) {


                     $('#tblmemberInfo tr th').html('');
                     $('#tblmemberInfo tr').html('');
                     var str = '<table ID="tblmemberInfo" class="table table-striped table-bordered table-hover">';

                     if (isRented == "True") {
                         str += '<thead><tr>';
                         str += '<th>Name</th><th>Rent</th><th>Pan</th><th>Aadhar Card</th><th>Mobile No</th><th>Office contact</th><th>DOB</th><th>Gender</th><th>Residing From</th>';
                         str += '</thead></tr>';

                         for (var i = 0; i < Result.length - 1; i++) {
                             str += '<tr>';
                             str += '<td>' + Result[i].Name + '</td>';
                             str += '<td>' + Result[i].Rent + '</td>';
                             str += '<td>' + Result[i].PAN + '</td>';
                             str += '<td>' + Result[i].AadhaarCard + '</td>';
                             str += '<td>' + Result[i].ContactNo + '</td>';
                             str += '<td>' + Result[i].ContactNo2 + '</td>';
                             str += '<td>' + Result[i].DOB + '</td>';
                             str += '<td>' + Result[i].Gender + '</td>';
                             str += '<td>' + Result[i].ResidingFrom + '</td>';
                             str += '</tr>';
                         }

                     }

                     if (isRented == "False") {
                         str += '<thead><tr>';
                         str += '<th>Name</th><th>Pan</th><th>Aadhar Card</th><th>Relation</th> <th>Mobile No</th><th>DOB</th><th>Gender</th><th>Residing From</th>';
                         str += '</thead></tr>';
                         for (var i = 0; i < Result.length - 1; i++) {

                             str += '<tr>';
                             str += '<td>' + Result[i].Name + '</td>';
                             str += '<td>' + Result[i].PAN + '</td>';
                             str += '<td>' + Result[i].AadhaarCard + '</td>';
                             str += '<td>' + Result[i].Relation + '</td>';
                             str += '<td>' + Result[i].ContactNo + '</td>';
                             str += '<td>' + Result[i].DOB + '</td>';
                             str += '<td>' + Result[i].Gender + '</td>';
                             str += '<td>' + Result[i].ResidingFrom + '</td>';
                             str += '</tr>';
                         }
                     }

                     str += '</table>';
                     $('#MemberInfo').append(str).fadeIn();

                     $('#MemberInfopagination').bootpag({
                         total: total,
                         page: page
                     });


                 }
                 else {


                     $('#tblmemberInfo tr th').html('');
                     $('#tblmemberInfo tr').html('');
                     document.getElementById('MemberInfo').innerHTML = "No Record Found";
                     //document.getElementById('SoMemDashMemberinfo').innerText = "No Record Found";
                 }

             }
             else {
                 document.getElementById('MemberInfo').innerHTML = "<p style=\"text-align:center; background-color:red;color:#FFF;font-size:15px\"> No Record Found</p>";
                 document.getElementById('MemberInfopagination').innerHTML = "";
                 //  document.getElementById('SoMemDashMemberinfo').innerText = "No Record Found";
             }
         }

         function GetMemberinfoError(response) {

             document.getElementById('#MemberInfo').style.display = "block";
             document.getElementById('#MemberInfo').innerHTML = "No Record Found";
             HideDiv();
         }

         //////////////////////////////////////////////////////////////////////////////////////////////////////////
         function GetMaintenanceInfoCurrentMonth(identifier) {

             $('#PopCurrentMaintenance').modal('show');
             $.ajax(
            {
                type: 'POST',
                url: "SocietyMemberDashboard.aspx/GetCurrentmaintenanceInfo",
                data: '{"Id":"' + identifier + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: GetCurrentmaintenanceInfoSuccess,
                error: GetCurrentmaintenanceInfoError
            });
             HideDiv();
         }

         function GetTotalOutStandingMaintenance() {
             $.ajax(
             {
                 type: 'POST',
                 url: "SocietyMemberDashboard.aspx/GetTotalOutStandingMaintenance",
                 data: '{}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 async: false,
                 success: function (response) {

                     var result = response.d;
                     $('#TotalExpense').empty();
                     if (result == "N") {
                         toastr.warning("No Record Found");
                         $('#TotalExpenseDangerP1').append("No Record Found").show();
                         $('#<%=TotalExpenseDangers.ClientID %>').show();

                   }
                   else {
                       result = JSON.parse(response.d);
                       var Totalamount = 0;
                       var fineamount = 0;

                       var table = "";
                       table += '<table class="table table-striped table-bordered table-hover">';
                       table += '<table class="table table-striped table-bordered table-hover">';
                       table += '<thead><tr><th>Date</th><th>Calculation Method</th><th>Total Amount</th><th >Balance Total Amount</th><th >Fine Amount</th></tr></thead>';
                       table += '<tbody>';
                       for (var i = 0; i < result.length - 1; i++) {
                           if (i < result.length - 2) {
                               Totalamount = parseFloat(parseFloat(Totalamount) + parseFloat(result[i].TMonthAmount)).toFixed(2);
                               fineamount = parseFloat(parseFloat(fineamount) + parseFloat(result[i].FineAmount)).toFixed(2);
                           }

                           table += '<tr>';
                           table += '<td>' + result[i].EffectiveFrom + '</td>';
                           table += '<td> <a href="#" style="color:red" onclick="GetMaintenanceInfoCurrentMonth(' + result[i].MaintenanceId + ')" >' + result[i].CalculationMethod + '</a></td>';



                           if (i < result.length - 2) {
                               table += '<td>' + result[i].TMonthAmount + '</td>';

                           }
                           else if (i == result.length - 2) {
                               table += '<td>' + Totalamount + '</td>';

                           }
                           table += '<td>' + result[i].AmountBalance + '</td>'

                           if (i < result.length - 2) {
                               table += '<td>' + result[i].FineAmount + '</td></tr>';

                           }
                           else if (i == result.length - 2) {

                               table += '<td>' + fineamount + '</td></tr>';
                           }


                       }
                       table += '</tbody></table>';


                       $('#TotalExpense').append(table).fadeIn();
                       $('#TotalExpenseDangerP1').hide();
                       $('#<%=TotalExpenseDangers.ClientID %>').hide();

                       $('#TotalPropertyTotalExpense').append(result[result.length - 1].CalculationMethod).fadeIn();

                       var url = "../finance/Rechargewallet.aspx?Opt=O&Mid=" + result[result.length - 1].EffectiveFrom + "&Ptype=" + result[result.length - 1].CalculationMethod;
                       $('#PayTotalExpense').attr("href", url);
                   }

               },
               error: function (response) {
                   HideDiv();
                   toastr.warning("Error");

               }
           });
       }


       function hidecontrol() {
           document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "none";
            document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
            document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
            document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
            document.getElementById('<%=TotalFMF.ClientID %>').style.display = "none";
            document.getElementById('<%=TotalSF.ClientID %>').style.display = "none";
            document.getElementById('<%=TotalPFR.ClientID %>').style.display = "none";
            document.getElementById('<%=TotalMA.ClientID %>').style.display = "none";
        }


        function GetCurrentmaintenanceInfoSuccess(response) {
            if (response.d != "[]") {
                // if (response.d != 0 || response.d != null ||  response.d != "[]") 
                var result = JSON.parse(response.d);
                document.getElementById('<%=PopErrorMaintenanceDisplayError.ClientID %>').innerHTML = "";
                document.getElementById('<%=PopErrorMaintenanceDisplayError.ClientID %>').innerHTML = "";
                SoMemDashHeader
                MaintenanceID = result[0].MaintenanceID;
                PropertyType = result[0].PropertyType;
                CalculationMethodId = result[0].CalculationMethodId;
                PropertyTaxes = result[0].PropertyTaxes; WaterCharges = result[0].WaterCharges;
                ElectricityCharges = result[0].ElectricityCharges;


                SecuritySalary = result[0].SecuritySalary;
                HousekeepingSalary = result[0].HousekeepingSalary;
                ManagerSalary = result[0].ManagerSalary;
                Stationary = result[0].Stationary;
                DgSet = result[0].DgSet;
                GymInstructor = result[0].GymInstructor;
                CommunityHall = result[0].CommunityHall;
                InsuranceCharges = result[0].InsuranceCharges;
                SupervisorSalary = result[0].SupervisorSalary;

                RepairsMaintenanceFund = result[0].RepairsMaintenanceFund; LiftCharges = result[0].LiftCharges;
                SinkingFund = result[0].SinkingFund; ServiceCharges = result[0].SinkingFund;
                CarParkingCharges = result[0].CarParkingCharges;
                InterestonDefaulted = result[0].InterestonDefaultedCharges;
                RepaymentInstmntLoanInterest = result[0].RepaymentInstmntLoanInterest;
                NonOccupancyCharges = result[0].NonOccupancyCharges; InsuranceCharges = result[0].InsuranceCharges;
                LeaseRent = result[0].LeaseRent; NonAgriculturalTax = result[0].NonAgriculturalTax; OtherCharges = result[0].OtherCharges;
                TotalMaintenanceSum = result[0].TotalMaintenanceSum;
                MaintenancePerFlat = result[0].MaintenancePerFlat;
                TenantMaintenance = result[0].TenantMaintenance;
                PerSquareFeetRate = result[0].PerSquareFeetRate;
                FixedSqft = result[0].FixedSqft; FixedRate = result[0].FixedRate;
                AdditionalSqft = result[0].AdditionalSqft;
                AdditionalSqftRate = result[0].AdditionalSqftRate;
                EffectiveFromDate = result[0].EffectiveFromDate;
                EffectiveToDate = result[0].EffectiveToDate; TotalArea = result[0].TotalArea; FlatCount = result[0].FlatCount;
                CalculationMethod = result[0].CalculationMethod;
                var url = "../finance/Rechargewallet.aspx?Opt=O&Mid=" + MaintenanceID + "&Ptype=" + PropertyType;

                if (CalculationMethodId == 1) {


                    $('#<%=lblDate.ClientID %>').text(" " + EffectiveFromDate + ' TO ' + EffectiveToDate);
                    $('#<%=hdnMaintenanceID.ClientID %>').val(MaintenanceID);
                    $('#<%=lblPropertyType.ClientID %>').text(PropertyType);
                    $('#<%=lblCalculationMethodId.ClientID %>').text(CalculationMethod);
                    $('#<%=lblProperty.ClientID %>').text(PropertyTaxes);
                    $('#<%=lblWaterCharges.ClientID %>').text(WaterCharges);
                    $('#<%=lblElectricityCharges.ClientID %>').text(ElectricityCharges);
                    $('#<%=lblSecuritySalary.ClientID %>').text(SecuritySalary);
                    $('#<%=lblHousekeepingSalary.ClientID %>').text(HousekeepingSalary);
                    $('#<%=lblManagerSalary.ClientID %>').text(ManagerSalary);
                    $('#<%=lblStationary.ClientID %>').text(Stationary);
                    $('#<%=lblDgSet.ClientID %>').text(DgSet);
                    $('#<%=lblGymInstructor.ClientID %>').text(GymInstructor);
                    $('#<%=lblCommunityHall.ClientID %>').text(CommunityHall);
                    $('#<%=lblInsuranceCharges.ClientID %>').text(SupervisorSalary);
                    $('#<%=lblOtherCharges.ClientID %>').text(OtherCharges);
                    $('#<%=lblSumTotal.ClientID %>').text(TotalMaintenanceSum);
                    $('#<%=lblTotalMPF.ClientID %>').text(MaintenancePerFlat);
                    $('#<%=lblFlatCount.ClientID %>').text(FlatCount);
                    $('#<%=lblTenantMaintenance.ClientID %>').text(TenantMaintenance);

                    document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "block";
                    document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalFMF.ClientID %>').style.display = "block";
                    document.getElementById('<%=TotalSF.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalPFR.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalMA.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "none";
                }

                if (CalculationMethodId == 2) {
                    $('#<%=lblDate.ClientID %>').text(" " + EffectiveFromDate + ' TO ' + EffectiveToDate);
                    $('#<%=lblCalculationMethodId.ClientID %>').text(CalculationMethod);
                    $('#<%=hdnMaintenanceID.ClientID %>').val(MaintenanceID);
                    $('#<%=lblPropertyType.ClientID %>').text(PropertyType);

                    $('#<%=lblPerSquareFeetRate.ClientID %>').text(PerSquareFeetRate);
                    $('#<%=lblTotalArea.ClientID %>').text(TotalArea);

                    var SquarfeetTotal = (parseFloat(PerSquareFeetRate * PerSquareFeetRate));
                    $('#<%=lblTotalSF.ClientID %>').text(parseFloat(SquarfeetTotal));
                    document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "block";
                    document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalFMF.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalSF.ClientID %>').style.display = "block";
                    document.getElementById('<%=TotalPFR.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalMA.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "none";
                }

                if (CalculationMethodId == 3) {
                    $('#<%=lblDate.ClientID %>').text(" " + EffectiveFromDate + ' TO ' + EffectiveToDate);
                    $('#<%=hdnMaintenanceID.ClientID %>').val(MaintenanceID);
                    $('#<%=lblCalculationMethodId.ClientID %>').text(CalculationMethod);
                    $('#<%=lblPropertyType.ClientID %>').text(PropertyType);
                    $('#<%=lblFixedSqft.ClientID %>').text(FixedSqft);
                    $('#<%=lblFixedrate.ClientID %>').text(PerSquareFeetRate);
                    $('#<%=lblAdditionalsqft.ClientID %>').text(AdditionalSqft);
                    $('#<%=lblAdditionalsqftRate.ClientID %>').text(AdditionalSqftRate);
                    //$('#<%=lblTotalPFR.ClientID %>').val(AdditionalSqftRate);
                    document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "block";
                    document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalFMF.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalSF.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalPFR.ClientID %>').style.display = "block";
                    document.getElementById('<%=TotalMA.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "none";

                }

                if (CalculationMethodId == 4) {

                    $('#<%=lblDate.ClientID %>').val(" " + EffectiveFromDate + ' TO ' + EffectiveToDate);
                    $('#<%=hdnMaintenanceID.ClientID %>').val(MaintenanceID);
                    $('#<%=lblCalculationMethodId.ClientID %>').text(CalculationMethod);
                    $('#<%=lblPropertyType.ClientID %>').val(PropertyType);
                    //$('#<%=lblTotalMA.ClientID %>').val(AdditionalSqftRate);
                    document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
                    document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "block";
                    document.getElementById('<%=TotalFMF.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalSF.ClientID %>').style.display = "block";
                    document.getElementById('<%=TotalPFR.ClientID %>').style.display = "none";
                    document.getElementById('<%=TotalMA.ClientID %>').style.display = "block";
                    document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "none";
                    document.getElementById('<%=SoMemDashHeader.ClientID %>').style.display = "block";
                    document.getElementById('CurrentMonthpayment').style.display = "block";

                }
                if (CalculationMethodId == 5) {

                    $('#<%=lblDate.ClientID %>').text(" " + EffectiveFromDate + '  TO  ' + EffectiveToDate);
                      $('#<%=hdnMaintenanceID.ClientID %>').val(MaintenanceID);
                      $('#<%=lblPropertyType.ClientID %>').text(PropertyType);
                      $('#<%=lblCalculationMethodId.ClientID %>').text(CalculationMethod);
                      $('#<%=lblProperty.ClientID %>').text(PropertyTaxes);
                      $('#<%=lblWaterCharges.ClientID %>').text(WaterCharges);
                      $('#<%=lblElectricityCharges.ClientID %>').text(ElectricityCharges);
                      $('#<%=lblSecuritySalary.ClientID %>').text(SecuritySalary);
                      $('#<%=lblHousekeepingSalary.ClientID %>').text(HousekeepingSalary);
                      $('#<%=lblManagerSalary.ClientID %>').text(ManagerSalary);
                      $('#<%=lblStationary.ClientID %>').text(Stationary);
                      $('#<%=lblDgSet.ClientID %>').text(DgSet);
                      $('#<%=lblGymInstructor.ClientID %>').text(GymInstructor);
                      $('#<%=lblCommunityHall.ClientID %>').text(CommunityHall);
                      $('#<%=lblInsuranceCharges.ClientID %>').text(SupervisorSalary);
                      $('#<%=lblOtherCharges.ClientID %>').text(OtherCharges);
                      $('#<%=lblSumTotal.ClientID %>').text(TotalMaintenanceSum);
                      $('#<%=lblTotalMPF.ClientID %>').text(MaintenancePerFlat);
                      $('#<%=lblFlatCount.ClientID %>').text(FlatCount);

                      $('#<%=lblTenantMaintenance.ClientID %>').text(TenantMaintenance);
                      document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "block";
                      document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
                      document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
                      document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
                      document.getElementById('<%=TotalFMF.ClientID %>').style.display = "block";
                      document.getElementById('<%=TotalSF.ClientID %>').style.display = "none";
                      document.getElementById('<%=TotalPFR.ClientID %>').style.display = "none";
                      document.getElementById('<%=TotalMA.ClientID %>').style.display = "none";
                      document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "none";
                      $('#<%=tdSumTotal.ClientID %>').hide();
                  }


                  $('#CurrentMonthpayment').attr("href", url);
              }
              else {
                  document.getElementById('CurrentMonthpayment').style.display = "none";

                  document.getElementById('<%=PopFlatMonthlyFee.ClientID %>').style.display = "none";
              document.getElementById('<%=PopSquareFeetRate.ClientID %>').style.display = "none";
                document.getElementById('<%=PopPartialflatRate.ClientID %>').style.display = "none";
                document.getElementById('<%=PopMixapproch.ClientID %>').style.display = "none";
                document.getElementById('<%=Total.ClientID %>').style.display = "none";
                document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "block";
                document.getElementById('<%=PopErrorMaintenanceDisplayError.ClientID %>').innerHTML = "Maintenance Of Current Month is Not Available.";
                document.getElementById('<%=SoMemDashHeader.ClientID %>').style.display = "none";
            }

        }

        function GetCurrentmaintenanceInfoError(response) {
            HideDiv();
            document.getElementById('<%=PopErrorMaintenanceDetail.ClientID %>').style.display = "block";
            document.getElementById('<%=PopErrorMaintenanceDisplayError.ClientID %>').innerHTML = "UnExcepted Error:Server Timeout";
        }

        function GetEventDetail(identifier) {
            var EventId = $(identifier).parents('tr').find("input[id*='hdnEventId']").val();

            $.ajax(
    {
        type: 'POST',
        url: "SocietyMemberDashboard.aspx/GetEventDetail",
        data: '{"EventId":"' + EventId + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (response) {
            if (response.d == "N") {
                $('#Event').modal('show');
                $("#EventDetail").empty();
                $("#EventDetail").html("<p>No Record Found</p>");

            }
            else {
                $('#Event').modal('show');
                var result = response.d;
                result = jQuery.parseJSON(result);

                $("#EventDetail").html(result[0].Detail);
            }

        },
        error: function ($xhr) {
            var data = $xhr.responseJSON;
            console.log(data);
        }
    });

            return false;
        }



    </script>
    <style type="text/css">
        .profile-image {
            width: 149px;
            height: 149px;
        }

        .news-blocks {
            padding: 10px;
            margin-bottom: 10px;
            background: #FAF6EA none repeat scroll 0% 0%;
            border-top: 2px solid #FAF6EA;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BEGIN PAGE HEADER-->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li><i class="fa fa-home"></i><a href="index.html">Home</a> <i class="fa fa-angle-right"></i></li>
            <li><a href="#">Dashboard</a> </li>
        </ul>
        <div class="page-toolbar">
        </div>
    </div>
    <h3 class="page-title">Dashboard <small>reports & statistics</small>
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
                        <asp:Label ID="lblCurrentMaintenance" runat="server" Text="Label"></asp:Label>
                    </div>
                    <div class="desc">
                        Total OutStanding Maintenance
                    </div>
                </div>
                <a class="more" id="TotalPendingExpenseLink" data-toggle="modal" href="#TotalPendingExpense">View More<i class="m-icon-swapright m-icon-white"></i></a>
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
                        <asp:Label ID="lblIsRented" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="desc">
                        Is Rented
                    </div>
                </div>
                <a class="more" id="popMemberMasterInfo" data-toggle="modal" href="#IsRentedpop">View
                    more <i class="m-icon-swapright m-icon-white"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="dashboard-stat green-haze">
                <div class="visual">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <div class="details">
                    <div class="number">
                        <asp:Label ID="lblAccountDetail" runat="server">
                        </asp:Label>
                    </div>
                    <div class="desc">
                        Society Account Detail
                    </div>
                </div>
                <a class="more" id="SocAccDetailpops" data-toggle="modal" href="#SocAccDetailpop">View more <i class="m-icon-swapright m-icon-white"></i></a>
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
                        Society HelpDesk
                    </div>
                </div>
                <a class="more" id="#Helpdesk_popup" data-toggle="modal" href="#HelpDeskpop">View more
                    <i class="m-icon-swapright m-icon-white"></i></a>
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
                        <i class="icon-equalizer font-blue-steel hide"></i><span class="caption-subject font-blue-steel bold uppercase">Profile </span><span class="caption-helper"></span>
                    </div>
                    <div class="tools">
                        <a href="" class="collapse"></a><a href="" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                        <!-- Load Content  -->
                        <div class="row">
                            <div class="col-md-5 col-sm-5">
                                <div class="portlet light profile-sidebar-portlet">
                                    <!-- SIDEBAR USERPIC -->
                                    <div class="profile-userpic" style="text-align: center;">
                                        <asp:Image ID="imgProfile" class="profile-image" runat="server" />
                                    </div>
                                    <!-- END SIDEBAR USERPIC -->
                                    <!-- SIDEBAR USER TITLE -->
                                    <div class="profile-usertitle">
                                        <div class="profile-usertitle-name">
                                            <asp:Label ID="lblFullName" runat="server" Style="text-transform: capitalize !important;"></asp:Label>
                                        </div>
                                        <div class="profile-usertitle-job">
                                            <asp:Label ID="lblLoginType" Style="text-transform: capitalize !important;" runat="server"></asp:Label>
                                        </div>
                                        <div class="profile-usertitle-job">
                                            Flat No :
                                            <asp:Label ID="lblFlatNumber" Style="text-transform: capitalize !important;" runat="server"></asp:Label>
                                        </div>
                                        <div class="profile-usertitle-job">
                                            Building No:
                                            <asp:Label ID="lblBuildingNumber" Style="text-transform: capitalize !important;"
                                                runat="server"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7 col-sm-7">
                                <div class="table-responsive table-scrollable table-scrollable-borderless">
                                    <asp:Repeater ID="ProfileView" runat="server" OnItemDataBound="ProfileView_ItemDataBound">
                                        <HeaderTemplate>
                                            <div class="scroller" style="height: 280px;" data-always-visible="1" data-rail-visible1="1">
                                                <table class="table table-striped table-bordered table-hover">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>Flat Number
                                                </td>
                                                <td style="color: Red; font-weight: bold">
                                                    <%# Eval("FlatNumber")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Property Type
                                                </td>
                                                <td>
                                                    <%# Eval("PropertyType")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Flat Type
                                                </td>
                                                <td>
                                                    <%# Eval("FlatType")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Total Area
                                                </td>
                                                <td>
                                                    <%# Eval("TotalArea")%>
                                                    Sq.ft
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Parking Available
                                                </td>
                                                <td>
                                                    <%# Eval("IsParkingAvailable")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email
                                                </td>
                                                <td>
                                                    <%# Eval("EmailID")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Mobile
                                                </td>
                                                <td>
                                                    <%# Eval("ContactNumber")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>PAN
                                                </td>
                                                <td>
                                                    <%# Eval("PAN")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Residing From
                                                </td>
                                                <td>
                                                    <%# Eval("ResidingFrom", "{0:d}")%>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table> </div>
                                            <div class="alert alert-block alert-danger fade in" visible="false" runat="server"
                                                id="FooterProfileView">
                                                <button type="button" class="close" data-dismiss="alert">
                                                </button>
                                                <p>
                                                    No Record Found
                                                </p>
                                            </div>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
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
                        <i class="icon-equalizer font-purple-plum hide"></i><span class="caption-subject font-purple-plum bold uppercase">Maintenance History</span> <span class="caption-helper">monthly stats...</span>
                    </div>
                    <div class="tools">
                        
                        <a href="../Finance/MaintenanceCollectionView.aspx" class="btn btn-sm red" style="height:25px">+ View More</a>
                        <a title="" data-original-title="" class="btn btn-circle btn-icon-only btn-default fullscreen" href="javascript:;"></a>
                        <a href="" class="collapse"></a><a href="" class="remove"></a>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                        <!-- Load Content  -->
                        <div class="table table-responsive table-scrollable table-scrollable-borderless">
                            <asp:Repeater ID="MaintenanceView" runat="server" OnItemDataBound="MaintenanceView_ItemDataBound">
                                <HeaderTemplate>
                                    <table class="table table-striped table-bordered table-hover">
                                        <tr>
                                            <th>View Bill</th>
                                            <th>Action</th>
                                            <th>Month 
                                            </th>
                                            <th>Amount
                                            </th>
                                            <th>Status
                                            </th>
                                            <th>Paid Amount
                                            </th>
                                            <th>Balance Amount
                                            </th>

                                            <%--<th>
                                                Pay Bill
                                            </th>--%>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnMainIdhistory" Value='<%# Eval("MaintenanceIDHistory")%>' runat="server" />
                                            <asp:HiddenField ID="hdmMainId" Value='<%# Eval("MaintenanceId")%>' runat="server" />
                                            <asp:HiddenField ID="hdnPropertyType" Value='<%# Eval("PropertyType")%>' runat="server" />
                                            <asp:Button ID="hyHistoryViewbill" class="btn btn-sm green hidden-accordion margin-bottom-5" OnClick="hyHistoryViewbill" runat="server" Text="View Bill" />
                                             
                                        </td>
                                        <td>
                                            
                                            
                                            <asp:Button ID="hyHistoryPaynow" class="btn btn-sm red hidden-accordion margin-bottom-5" OnClick="hyHistoryPaynow" runat="server" Text="Button" />
                                        

                                        </td>
                                        <td>
                                            <%# Eval("Month")%> 
                                        </td>
                                        <td>
                                            <%# Eval("Amount")%>
                                        </td>
                                        <td>
                                            <%# Eval("Status")%>
                                        </td>
                                        <td>
                                            <%# Eval("PaidAmount")%>
                                        </td>
                                        <td>
                                            <%# Eval("BalanceAmount")%>  
                                        </td>

                                       
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                    <div class="alert alert-block alert-danger fade in" visible="false" runat="server"
                                        id="FooterMaintenanceHistory">
                                        <button type="button" class="close" data-dismiss="alert">
                                        </button>
                                        <p>
                                            No Record Found
                                        </p>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
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
                            <i class="icon-equalizer font-green-sharp hide"></i><span class="caption-subject font-green-sharp bold uppercase">Upcoming Events </span><span class="caption-helper"></span>
                        </div>
                        <div class="tools">
                            <a href="" class="collapse"></a><a href="" class="remove"></a>

                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="1">
                            <!-- Load Content  -->
                            <div class="table-responsive">
                                <asp:Repeater ID="EventMaster" runat="server" OnItemDataBound="EventMaster_ItemDataBound">
                                    <HeaderTemplate>
                                        <table class="table table-striped table-bordered table-hover">
                                            <tr>
                                                <th>Event Name
                                                </th>
                                                <th>Event On
                                                </th>
                                                <th>Event Time
                                                </th>
                                                <th>Contact Detail
                                                </th>
                                                <th>Contribution
                                                </th>
                                                <th>Attachment
                                                </th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%# Eval("EventName")%>
                                            </td>
                                            <td>
                                                <%# Eval("EventOn", "{0:d}")%>
                                            </td>
                                            <td>
                                                <%# Eval("EventTime")%>
                                            </td>
                                            <td>
                                                <%# Eval("[CntctDetails]")%>
                                            </td>
                                            <td>
                                                <%# Eval("[Contribution]")%>
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hdnEventId" Value='<%# Eval("[EventId]")  %>' runat="server" />
                                                <a href='<%#"../Images/Event/" + Eval("[FileName]").ToString()%>' target='_blank'>Download</a>
                                                <asp:Button ID="btnevtDetail" class="btn btn-success" OnClientClick="javascript:return GetEventDetail(this);"
                                                    runat="server" Text="View Detail" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                        <div class="alert alert-block alert-danger fade in" visible="false" runat="server"
                                            id="FooterEventMaster">
                                            <button type="button" class="close" data-dismiss="alert">
                                            </button>
                                            <p>
                                                No Record Found
                                            </p>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
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
                            <i class="icon-equalizer font-purple-intense hide"></i><span class="caption-subject font-purple-intense bold uppercase">Buy / Rent / Sell</span> <span class="caption-helper"></span>
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
        <!-------------------------- Modal popup Curent Maintenanace---------------------------------->
        <div id="PopCurrentMaintenance" class="modal fade" data-backdrop="static" data-keyboard="false"
            tabindex="-1" data-width="760">
            <div id="PopCurrent_Maintenance" class="Main_Collection_Socity">
                <div class="modal-header" id="SoMemDashHeader" runat="server" clientidmode="Static"
                    style="height: 50px !important">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    </button>
                    <div class="col-md-12">
                        <div class="col-md-6">
                            <h4 class="modal-title">Total OutStanding Maintenance Detail
                            </h4>
                        </div>
                        <div class="col-md-6">
                            <span class="modal-title">Property Type:
                                <h4 id="lblPropertyType" style="display: inline !important;" runat="server"></h4>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="clearfix">
                </div>
                <div id="PopErrorMaintenanceDetail" runat="server" class="alert alert-block alert-danger fade in">
                    <button type="button" class="close" data-dismiss="alert">
                    </button>
                    <p id="PopErrorMaintenanceDisplayError" runat="server">
                    </p>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="PopFlatMonthlyFee" runat="server">
                            <asp:HiddenField ID="hdnMaintenanceID" runat="server" />
                            <div class="col-md-12" style="margin: 10px 0px;">
                                <div class="col-md-6">
                                    Calculation Method
                                    <asp:Label ID="lblCalculationMethodId" runat="server" class="label label-success"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    Date:
                                    <asp:Label ID="lblDate" runat="server" class="label label-success"></asp:Label>
                                </div>
                            </div>
                            <div class="clearfix">
                            </div>
                            <div class="col-md-6">
                                <p class="form-control">
                                    Property Taxes : (Rs.)
                                    <asp:Label ID="lblProperty" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Electricity Charges : (Rs.)
                                    <asp:Label ID="lblElectricityCharges" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    SecuritySalary : (Rs.)
                                    <asp:Label ID="lblSecuritySalary" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Housekeeping Salary : (Rs.)
                                    <asp:Label ID="lblHousekeepingSalary" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    ManagerSalary : (Rs.)
                                    <asp:Label ID="lblManagerSalary" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Stationary: (Rs.)
                                    <asp:Label ID="lblStationary" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    DgSet: (Rs.)
                                    <asp:Label ID="lblDgSet" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Other Charges: (Rs.)
                                    <asp:Label ID="lblOtherCharges" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p class="form-control">
                                    Water Charges : (Rs.)
                                    <asp:Label ID="lblWaterCharges" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Gym Instructor : (Rs.)
                                    <asp:Label ID="lblGymInstructor" runat="server"></asp:Label>
                                </p>

                                <p class="form-control">
                                    Community Hall : (Rs.)
                                    <asp:Label ID="lblCommunityHall" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Insurance Charges : (Rs.)
                                    <asp:Label ID="lblInsuranceCharges" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Supervisor Salary: (Rs.)
                                    <asp:Label ID="lblSupervisorSalary" runat="server"></asp:Label>
                                </p>


                                <!--p class="form-control">
                                    Non-agricultural tax : (Rs.)
                                    <asp:Label ID="lblNonagriculturaltax" runat="server"></asp:Label>
                                </p-->
                                <p class="form-control">
                                    Total Flat Count :
                                    <asp:Label ID="lblFlatCount" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="clearfix">
                            </div>
                            <div class="col-md-12">
                                <p class="form-control">
                                    Non Occupancy Charges : (Rs.)
                                    <asp:Label ID="lblTenantMaintenance" runat="server"></asp:Label>
                                </p>
                            </div>

                            <div class="col-md-12" id="tdSumTotal" runat="server">
                                <p class="form-control">
                                    Sum Total : (Rs.)
                                    <asp:Label ID="lblSumTotal" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div id="PopSquareFeetRate" runat="server">
                            <div class="col-md-12">
                                <p class="form-control">
                                    Total Area :
                                    <asp:Label ID="lblTotalArea" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Per Square FeetRate : (Rs.)
                                    <asp:Label ID="lblPerSquareFeetRate" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div id="PopPartialflatRate" runat="server">
                            <div class="col-md-12">
                                <p class="form-control">
                                    Fixe Sqft : (Rs.)
                                    <asp:Label ID="lblFixedSqft" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Fixed rate :
                                    <asp:Label ID="lblFixedrate" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    Additional sqft : (Rs.)
                                    <asp:Label ID="lblAdditionalsqft" runat="server"></asp:Label>
                                </p>
                                <p class="form-control">
                                    AdditionalsqftRate : (Rs.)
                                    <asp:Label ID="lblAdditionalsqftRate" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div id="PopMixapproch" runat="server">
                        </div>
                        <div id="Total" runat="server">
                            <div class="col-md-12">
                                <div id="TotalFMF" runat="server">
                                    <p class="form-control">
                                        Total Maintenance: (Rs.)
                                        <asp:Label ID="lblTotalMPF" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="TotalSF" runat="server">
                                    <p class="form-control">
                                        Sum Total(Total Area * Squarefeet Rate) :
                                        <asp:Label ID="lblTotalSF" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="TotalPFR" runat="server">
                                    <p class="form-control">
                                        Sum Total() :
                                        <asp:Label ID="lblTotalPFR" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="TotalMA" runat="server">
                                    <p class="form-control">
                                        Sum Total() :
                                        <asp:Label ID="lblTotalMA" runat="server"></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" data-dismiss="modal" class="btn btn-default">
                        Close</button>
                </div>
            </div>
        </div>
        <!-------------------------- Modal popup Curent Maintenanace---------------------------------->
        <!-------------------------- Modal popup IsRented---------------------------------->
        <div id="IsRentedpop" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false"
            data-width="760">
            <div id="IsRente_dpop">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    </button>
                    <h4 class="modal-title">Member Info</h4>
                </div>
                <div class="modal-body Main_Collection_Socity">
                    <div class="row">
                        <div class="table-responsive">
                            <div class="scroller member-info" id="SoMemDashMemberinfo" runat="server" clientidmode="Static"
                                style="height: 440px;" data-always-visible="1" data-rail-visible1="1">
                                <div id="MemberInfo">
                                </div>
                                <div id="MemberInfopagination">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn btn-default">
                            Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------- Modal popup IsRented/FamilyInfo---------------------------------->
        <!-------------------------- Modal popup Society Account Detail---------------------------------->
        <div id="SocAccDetailpop" class="modal fade" tabindex="-1" data-width="760">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title">Society Account Detail</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12" id="SocietyAccountDtl"></div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-default">
                    Close</button>

            </div>
        </div>
        <!-------------------------- Modal popup Society Account detail---------------------------------->
        <div id="Event" class="modal fade" tabindex="-1" data-width="760">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title">Event Detail
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="scroller" style="height: 405px;" data-always-visible="1" data-rail-visible1="1">
                        <div class="col-md-12">
                            <p id="EventDetail">
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-default">
                    Close</button>

            </div>
        </div>
        <!-------------------------- Modal popup HelpDesk---------------------------------->
        <div id="HelpDeskpop" class="Main_Collection_Socity modal fade" tabindex="-1" data-width="760">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title">Help Desk</h4>
            </div>
            <div class="modal-body">
                <div class="scroller" style="height: 500px;" data-always-visible="1" data-rail-visible1="1">
                    <div class="row">
                        <div class="col-md-3">
                            <ul class="ver-inline-menu tabbable margin-bottom-10">
                                <li class="active"><a data-toggle="tab" href="#tab_1"><i class="fa fa-briefcase"></i>
                                    Question Answer </a><span class="after"></span></li>
                                <li><a data-toggle="tab" href="#tab_1"><i class="fa fa-group"></i>Faq
                                </a></li>
                                <li><a data-toggle="tab" href="#tab_2"><i class="fa fa-leaf"></i>committee members </a></li>
                                <li><a data-toggle="tab" href="#tab_3"><i class="fa fa-leaf"></i>Bye Law Rules </a></li>
                                <li><a data-toggle="tab" href="#tab_4"><i class="fa fa-info-circle"></i>License Terms
                                </a></li>
                                <li><a data-toggle="tab" href="#tab_5"><i class="fa fa-tint"></i>Payment Rules </a>
                                </li>
                                <li><a data-toggle="tab" href="#tab_6"><i class="fa fa-plus"></i>Ask Questions /Compalint  </a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-9">
                            <div class="tab-content">
                                <div id="tab_1" class="tab-pane active">
                                    <div id="accordion1" class="panel-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#accordion1_1">1. Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry ?
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="accordion1_1" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson
                                                    ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div id="tab_2" class="tab-pane">
                                    <div id="accordion2" class="panel-group">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_1">Committee Members
                                                </h4>
                                            </div>
                                            <div id="accordion2_1" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:Repeater ID="committeeMaster" runat="server" OnItemDataBound="committeeMaster_ItemDataBound">
                                                            <HeaderTemplate>
                                                                <table class="table table-striped table-bordered table-hover">
                                                                    <tr>
                                                                        <th>Name
                                                                        </th>
                                                                        <th>Designation
                                                                        </th>
                                                                        <th>Phone Number
                                                                        </th>

                                                                        <th>Flat Number
                                                                        </th>
                                                                        <th>Effective From
                                                                        </th>

                                                                        <%--<th>
                                                    Contribution
                                                </th>
                                                <th>
                                                    Attachment
                                                </th>--%>
                                                                    </tr>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <%# Eval("OwnerName1")%>
                                                                    </td>
                                                                    <td>
                                                                        <%# Eval("Designation")%>
                                                                    </td>
                                                                    <td>
                                                                        <%# Eval("ContactNumber")%>
                                                                    </td>

                                                                    <td>
                                                                        <%# Eval("FlatNumber")%>
                                                                    </td>
                                                                    <td>
                                                                        <%# Eval("EffectiveFrom")%>
                                                                    </td>
                                                                    <%-- <td>
                                                <%# Eval("[Contribution]")%>
                                            </td>--%>
                                                                    <%--<td>
                                                <a href='<%#"../Images/Event/" + Eval("[FileName]").ToString()%>' target='_blank'>Download</a>
                                            </td>--%>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                </table>
                                                                <div class="alert alert-block alert-danger fade in" visible="false" runat="server"
                                                                    id="FootercommitteeMaster">
                                                                    <button type="button" class="close" data-dismiss="alert">
                                                                    </button>
                                                                    <p>
                                                                        No Record Found
                                                                    </p>
                                                                </div>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab_3" class="tab-pane">
                                    <div id="accordion3" class="panel-group">
                                        <div class="panel panel-danger">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion3" href="#accordion3_1">Download Book - Model Bye Laws Of Cooperative housing Society </a>
                                                </h4>
                                            </div>
                                            <div id="accordion3_1" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    <p>
                                                        <a href="../Images/Document/info_download.pdf" target="_blank">Download Book - Click
                                                            Here </a>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab_4" class="tab-pane">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_1">License Terms
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab_5" class="tab-pane">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_1">Payment Rules 
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab_6" class="tab-pane">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#accordion2_1">Ask Questions
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-------------------------- Modal popup HelpDesk---------------------------------->


            <%-- Total Expance Pending--%>

            <div id="TotalPendingExpense" class="modal fade" data-backdrop="static" data-keyboard="false"
                tabindex="-1" data-width="760">
                <div id="Div2" class="Main_Collection_Socity">
                    <div class="modal-header" id="Div3" runat="server" clientidmode="Static"
                        style="height: 50px !important">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        </button>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <h4 class="modal-title">Total OutStanding Maintenance Detail
                                </h4>
                            </div>
                            <div class="col-md-6">
                                <h4 id="TotalPropertyTotalExpense" class="modal-title"></h4>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div id="TotalExpenseDangers" runat="server" class="alert alert-block alert-danger fade in">
                        <button type="button" class="close" data-dismiss="alert">
                        </button>
                        <p id="TotalExpenseDangerP1" runat="server">
                        </p>
                    </div>
                    <div class="modal-body">
                        <div id="TotalExpense" class="scroller" style="height: 500px !important;" data-always-visible="1" data-rail-visible1="1"></div>
                    </div>

                    <div class="modal-footer">
                        <a id="PayTotalExpense" href="#" class="btn btn-default confirmation">Pay Now</a>
                        <button type="button" data-dismiss="modal" class="btn btn-default">
                            Close</button>
                    </div>
                </div>
            </div>

            <%--      EndTotalExpensePending--%>
</asp:Content>
