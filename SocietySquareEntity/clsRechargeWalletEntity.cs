using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
 public class clsRechargeWalletEntity
    {
         private string _MaintenanceId;

         public string MaintenanceId
        {
            get { return _MaintenanceId; }
            set { _MaintenanceId = value; }
        }

           private string _proptype;

           public string proptype
           {
               get { return _proptype; }
               set { _proptype = value; }
           }
           

        private string _name;

        public string name
        {
            get { return _name; }
            set { _name = value; }
        }

        private string _Email;

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

        private long _ContactNumber;

        public long ContactNumber
        {
            get { return _ContactNumber; }
            set { _ContactNumber = value; }
        }

        private int _zipcode;

        public int zipcode
        {
            get { return _zipcode; }
            set { _zipcode = value; }
        }



        private string _mainInfo;

        public string maininfo
        {
            get { return _mainInfo; }
            set { _mainInfo = value; }
        }

        private float _amount;

        public float amount
        {
            get { return _amount; }
            set { _amount = value; }
        }

        private string _paymenttype;

        public string paymenttype
        {
            get { return _paymenttype; }
            set { _paymenttype = value; }
        }

        private string _createdby;

        public string createdby
        {
            get { return _createdby; }
            set { _createdby = value; }
        }

        private string _flag;

        public string flag
        {
            get { return _flag; }
            set { _flag = value; }
        }


        private int _countryId;

        public int countryId
        {
            get { return _countryId; }
            set { _countryId = value; }
        }

        private int _cityId;

        public int cityId
        {
            get { return _cityId; }
            set { _cityId = value; }
        }


        private int _stateId;

        public int stateId
        {
            get { return _stateId; }
            set { _stateId = value; }
        }


        private string _address;

        public string address
        {
            get { return _address; }
            set { _address = value; }
        }

        private string _Id;

        public string Id
        {
            get { return _Id; }
            set { _Id = value; }
        }
    }
}
