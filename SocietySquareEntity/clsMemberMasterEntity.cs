using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsMemberMasterEntity
    {
        #region Variable
        private int _Id;
        private int _OwnerId;
        private string _Ownername;
        private string _FlatNo;
        private string _LoginType;
        private int _FlatId;
        private int _PageIndex;
        private string _Designation;
        private string _EffectiveFrom;
        private string _ResidingFrom;
        private string _ResidingTO;
        private string _CreatedBy;
        private string _flag;
        private int _IsRented;

        private string _Name;
        private double _Rent;
        private string _PAN;
        private long _AadhaarCard;
        private string _PermanantAddress;
        private long _ContactNo1;
        private long _ContactNo2;
        private string _DOB;
        private string _Gender;
        private int _OwnerFamilyId;
        private string _Relation;
        private string _OtherRelation;
    

        #endregion


        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public double Rent
        {
            get { return _Rent; }
            set { _Rent = value; }
        }

        public string PAN
        {
            get { return _PAN; }
            set { _PAN = value; }
        }
        public string ResidingTO
        {
            get { return _ResidingTO; }
            set { _ResidingTO = value; }
        }

        public string ResidingFrom
        {
            get { return _ResidingFrom; }
            set { _ResidingFrom = value; }
        }

        public long AadhaarCard
        {
            get { return _AadhaarCard; }
            set { _AadhaarCard = value; }
        }

        public string PermanantAddress
        {
            get { return _PermanantAddress; }
            set { _PermanantAddress = value; }
        }

        public long ContactNo1
        {
            get { return _ContactNo1; }
            set { _ContactNo1 = value; }
        }

        public long ContactNo2
        {
            get { return _ContactNo2; }
            set { _ContactNo2 = value; }
        }

        public string DOB
        {
            get { return _DOB; }
            set { _DOB = value; }
        }

        public string Gender
        {
            get { return _Gender; }
            set { _Gender = value; }
        }

        public int OwnerFamilyId
        {
            get { return _OwnerFamilyId; }
            set { _OwnerFamilyId = value; }
        }

        public string Relation
        {
            get { return _Relation; }
            set { _Relation = value; }
        }

        public string OtherRelation
        {
            get { return _OtherRelation; }
            set { _OtherRelation = value; }
        }
            
         public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }

         public string flag
        {
            get { return _flag; }
            set { _flag = value; }
        }

         public int IsRented
        {
            get { return _IsRented; }
            set { _IsRented = value; }
        }
       

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public int OwnerId
        {
            get { return _PageIndex; }
            set { _PageIndex = value; }
        }

        public int FlatId
        {
            get { return _FlatId; }
            set { _FlatId = value; }
        }

        public string LoginType
        {
            get { return _LoginType; }
            set { _LoginType = value; }
        }

        public int PageIndex
        {
            get { return _PageIndex; }
            set { _PageIndex = value; }
        }

     
    }
}
