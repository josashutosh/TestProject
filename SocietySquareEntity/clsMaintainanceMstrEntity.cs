using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class clsMaintenanceMstrEntity
    {
        #region Varible

        private int _ID;
        private int _MaintenanceID;
        private string _PropertyType;
        private float _CalculationMethod;
        private int _CalcMasterID;
        private string _CalculationMethodName;
        private float _PropertyTaxes;
        private float _WaterCharges;
        private float _ElectricityCharges;
        private float _RepairsMaintenanceFund;
        private float _LiftCharges;
        private float _SinkingFund;
        private float _ServiceCharges;
        private float _CarParkingCharges;
        private float _InterestonDefaultedCharges;
        private float _RepaymentInstmntLoanInterest;
        private float _NonOccupancyCharges;
        private float _InsuranceCharges;
        private float _LeaseRent;
        private float _NonAgriculturalTax;
        private float _OtherCharges;

        private float _SecuritySalary;
        private float _HousekeepingSalary;
        private float _ManagerSalary;
        private float _Stationary;
        private float _DgSet;
        private float _GymInstructor;
        private float _CommunityHall;
        private float _Miscellaneous;
        private float _SupervisorSalary;
        private float _TenantMaintenance;

        private float _TotalMaintenanceSum;
        private float _MaintenancePerFlat;
        private float _PerSquareFeetRate;
        private int _FixedSqft;
        private float _FixedRate;
        private int _AdditionalSqft;
        private float _AdditionalSqftRate;
        private string _EffectiveFromDate;
        private string _EffectiveToDate;
        private string _Createdby;
        private string _flag;

        #endregion

        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }

        public int MaintenanceID
        {
            get { return _MaintenanceID; }
            set { _MaintenanceID = value; }
        }

        public string PropertyType
        {
            get { return _PropertyType; }
            set { _PropertyType = value; }
        }

        public int CalcMasterID
        {
            get { return _CalcMasterID; }
            set { _CalcMasterID = value; }
        }

        public string CalculationMethodName
        {
            get { return _CalculationMethodName; }
            set { _CalculationMethodName = value; }
        }


        public float PropertyTaxes
        {
            get { return _PropertyTaxes; }
            set { _PropertyTaxes = value; }
        }

        public float WaterCharges
        {
            get { return _WaterCharges; }
            set { _WaterCharges = value; }
        }


        public float ElectricityCharges
        {
            get { return _ElectricityCharges; }
            set { _ElectricityCharges = value; }
        }

        public float RepairsMaintenanceFund
        {
            get { return _RepairsMaintenanceFund; }
            set { _RepairsMaintenanceFund = value; }
        }

        public float LiftCharges
        {
            get { return _LiftCharges; }
            set { _LiftCharges = value; }
        }

        public float SinkingFund
        {
            get { return _SinkingFund; }
            set { _SinkingFund = value; }
        }

        public float ServiceCharges
        {
            get { return _ServiceCharges; }
            set { _ServiceCharges = value; }
        }

        public float CarParkingCharges
        {
            get { return _CarParkingCharges; }
            set { _CarParkingCharges = value; }
        }

        public float InterestonDefaultedCharges
        {
            get { return _InterestonDefaultedCharges; }
            set { _InterestonDefaultedCharges = value; }
        }

        public float RepaymentInstmntLoanInterest
        {
            get { return _RepaymentInstmntLoanInterest; }
            set { _RepaymentInstmntLoanInterest = value; }
        }

        public float NonAgriculturalTax
        {
            get { return _NonAgriculturalTax; }
            set { _NonAgriculturalTax = value; }
        }

        public float NonOccupancyCharges
        {
            get { return _NonOccupancyCharges; }
            set { _NonOccupancyCharges = value; }
        }

        public float OtherCharges
        {
            get { return _OtherCharges; }
            set { _OtherCharges = value; }
        }

        public float TotalMaintenanceSum
        {
            get { return _TotalMaintenanceSum; }
            set { _TotalMaintenanceSum = value; }
        }

        public float MaintenancePerFlat
        {
            get { return _MaintenancePerFlat; }
            set { _MaintenancePerFlat = value; }
        }

        public float PerSquareFeetRate
        {
            get { return _PerSquareFeetRate; }
            set { _PerSquareFeetRate = value; }
        }

        public int FixedSqft
        {
            get { return _FixedSqft; }
            set { _FixedSqft = value; }
        }

        public float FixedRate
        {
            get { return _FixedRate; }
            set { _FixedRate = value; }
        }



        public int AdditionalSqft
        {
            get { return _AdditionalSqft; }
            set { _AdditionalSqft = value; }
        }


        public float AdditionalSqftRate
        {
            get { return _AdditionalSqftRate; }
            set { _AdditionalSqftRate = value; }
        }

        public string EffectiveFromDate
        {
            get { return _EffectiveFromDate; }
            set { _EffectiveFromDate = value; }
        }

        public string EffectiveToDate
        {
            get { return _EffectiveToDate; }
            set { _EffectiveToDate = value; }
        }

        public string flag
        {
            get { return _flag; }
            set { _flag = value; }
        }

        public string Createdby
        {
            get { return _Createdby; }
            set { _Createdby = value; }
        }

        public float leaserent
        {
            get { return _LeaseRent; }
            set { _LeaseRent = value; }
        }

        public float InsuranceCharges
        {
            get { return _InsuranceCharges; }
            set { _InsuranceCharges = value; }
        }

        public float SecuritySalary
        {
            get { return _SecuritySalary; }
            set { _SecuritySalary = value; }
        }

        public float HousekeepingSalary
        {
            get { return _HousekeepingSalary; }
            set { _HousekeepingSalary = value; }
        }

        public float ManagerSalary
        {
            get { return _ManagerSalary; }
            set { _ManagerSalary = value; }
        }
        
        public float Stationary
        {
            get { return _Stationary; }
            set { _Stationary = value; }
        }
        
        public float DgSet
        {
            get { return _DgSet; }
            set { _DgSet = value; }
        }
       
         public float GymInstructor
        {
            get { return _GymInstructor; }
            set { _GymInstructor = value; }
        }
       
         public float CommunityHall
        {
            get { return _CommunityHall; }
            set { _CommunityHall = value; }
        }
         
            public float Miscellaneous
        {
            get { return _Miscellaneous; }
            set { _Miscellaneous = value; }
        }
            public float SupervisorSalary
        {
            get { return _SupervisorSalary; }
            set { _SupervisorSalary = value; }
        }

        public float TenantMaintenance
        {
            get { return _TenantMaintenance; }
            set { _TenantMaintenance = value; }
        }



        private int _SocietyId;

        public int SocietyId
        {
            get { return _SocietyId; }
            set { _SocietyId = value; }
        }

        private string _LoginId;

        public string LoginId
        {
            get { return _LoginId; }
            set { _LoginId = value; }
        }
        


    }
}
