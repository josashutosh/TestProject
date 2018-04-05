using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
  public class clsOwnerInfo
    {
        #region Variable
        private int _ownerId;
        private string _ownername;
        private string _ContactNumber;
        private string _Occupation;
        private string _OfficeAddress;
        private string _perAddress;
        private string _TempAddress;
        private long _OfficeContactNo;
        private string _PAN;
        private string _AdhaarCard;
        private int _IsCommiteeMember;
        private string _Photo;
        private string _ResidingFrom;
        private string _DOB;
        private string _CreatedBy;
        private string _Designation;
        private string _Effectivefrom;
        private string _flatid;

        #endregion
        public int ownerId
        {
            get { return _ownerId; }
            set { _ownerId = value; }
        }
        public string ownername
        {
            get { return _ownername; }
            set { _ownername = value; }
        }

        public string ContactNumber
        {
            get { return _ContactNumber; }
            set { _ContactNumber = value; }
        }
        public string Occupation
        {
            get { return _Occupation; }
            set { _Occupation = value; }
        }


        public string perAddress
        {
            get { return _perAddress; }
            set { _perAddress = value; }
        }

        public string TempAddress
        {
            get { return _TempAddress; }
            set { _TempAddress = value; }
        }

        public string OfficeAddress
        {
            get { return _OfficeAddress; }
            set { _OfficeAddress = value; }
        }

        public long OfficeContactNo
        {
            get { return _OfficeContactNo; }
            set { _OfficeContactNo = value; }
        }
        public string PAN
        {
            get { return _PAN; }
            set { _PAN = value;}
        }
        public string AdhaarCard
        {
            get { return _AdhaarCard; }
            set { _AdhaarCard = value; }
        }

        public int IsCommiteeMember
        {
            get { return _IsCommiteeMember; }
            set { _IsCommiteeMember = value; }
        }

        public string Photo
        {
            get { return _Photo; }
            set { _Photo = value; }
        }

        public string ResidingFrom
        {
            get { return _ResidingFrom; }
            set { _ResidingFrom = value; }
        }

        public string DOB
        {
            get { return _DOB; }
            set { _DOB = value; }
        }

        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }

        public string Effectivefrom
        {
            get { return _Effectivefrom; }
            set { _Effectivefrom = value; }
        }
        public string Designation
        {
            get { return _Designation; }
            set { _Designation = value; }
        }
        public string Flatid
        {
            get { return _flatid; }
            set { _flatid = value; }
        }
    }

  public class SetOwnerInfo 
  {
      public int OwnerId { get; set; }
      public string Ownername { get; set; }

  }

    
}
