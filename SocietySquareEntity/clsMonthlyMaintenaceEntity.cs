using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsMonthlyMaintenaceEntity
    {
        #region Varible

       private int _MonthlyMaintenaceId;
        private string _PropertyType;
        private string _CalculationMethod;
        private float _OwnerMonthlyMaintenance;
        private float _TenantMonthlyMaintenance;
        private float _TotalMonthlyMaintenace;
        private float _PerSquareFeetRate;
        private string _EffectiveFromDate;
        private string _EffectiveToDate;
        private string _Createdby;
        private string _flag;


        #endregion

        public int MonthlyMaintenaceId
        {
            get { return _MonthlyMaintenaceId; }
            set { _MonthlyMaintenaceId = value; }
        }

        public string PropertyType
        {
            get { return _PropertyType; }
            set { _PropertyType = value; }
        }

        public string CalculationMethod
        {
            get { return _CalculationMethod; }
            set { _CalculationMethod = value; }
        }


        public float OwnerMonthlyMaintenance
        {
            get { return _OwnerMonthlyMaintenance; }
            set { _OwnerMonthlyMaintenance = value; }
        }

        public float TenantMonthlyMaintenance
        {
            get { return _TenantMonthlyMaintenance; }
            set { _TenantMonthlyMaintenance = value; }
        }

        public float TotalMonthlyMaintenace
        {
            get { return _TotalMonthlyMaintenace; }
            set { _TotalMonthlyMaintenace = value; }
        }
        public float PerSquareFeetRate
        {
            get { return _PerSquareFeetRate; }
            set { _PerSquareFeetRate = value; }
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
    }
}
