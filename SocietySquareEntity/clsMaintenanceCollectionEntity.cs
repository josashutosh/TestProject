using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsMaintenanceCollectionEntity
    {
        #region Variable
        
            private int _ID;
            private int _MaintenanceID;           
            private double _PaidAmount;
            private int _ModePayment;
            private long _InstrumentNumber;
            private string _InstrumentDate;
            private string _CreatedBy;
            private string _Flag;
            private string _PropertyType;
            private double _MaintenanceWalletAmount;
        #endregion
            private int _BuildingId;

            public int BuildingId
            {
                get { return _BuildingId; }
                set { _BuildingId = value; }
            }
            private int _FlatId;

            public int FlatId
            {
                get { return _FlatId; }
                set { _FlatId = value; }
            }

            private string _FlatIds;

            public string FlatIds
            {
                get { return _FlatIds; }
                set { _FlatIds = value; }
            }
            

            private string  _CollectionIds;

            public string  CollectionIds
            {
                get { return _CollectionIds; }
                set { _CollectionIds = value; }
            }
            

            private string _Fromyear;

            public string Fromyear
            {
                get { return _Fromyear; }
                set { _Fromyear = value; }
            }

            private string _FromMonth;

            public string FromMonth
            {
                get { return _FromMonth; }
                set { _FromMonth = value; }
            }


            private string _ToYear;

            public string ToYear
            {
                get { return _ToYear; }
                set { _ToYear = value; }
            }

            private string _ToMonth;

            public string ToMonth
            {
                get { return _ToMonth; }
                set { _ToMonth = value; }
            }
            
            

            private string _To;

            public string To
            {
                get { return _To; }
                set { _To = value; }
            }

            private int _SocietyId;

            public int SocietyId
            {
                get { return _SocietyId; }
                set { _SocietyId = value; }
            }
            
            
            
            
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

            public double PaidAmount
            {
                get { return _PaidAmount; }
                set { _PaidAmount = value; }
            }

            public int ModePayment
            {
                get { return _ModePayment; }
                set { _ModePayment = value; }
            }

            public long InstrumentNumber
            {
                get { return _InstrumentNumber; }
                set { _InstrumentNumber = value; }
            }

            public string InstrumentDate
            {
                get { return _InstrumentDate; }
                set { _InstrumentDate = value; }
            }

            public string CreatedBy
            {
                get { return _CreatedBy; }
                set { _CreatedBy = value; }
            }

            public string Flag
            {
                get { return _Flag; }
                set { _Flag = value; }
            }

            public double MaintenanceWalletAmount
            {
                get { return _MaintenanceWalletAmount; }
                set { _MaintenanceWalletAmount = value; }
            }

            private string _LoginId;

            public string LoginId
            {
                get { return _LoginId; }
                set { _LoginId = value; }
            }

            private string _Remark;

            public string Remark
            {
                get { return _Remark; }
                set { _Remark = value; }
            }
        
    }
}
