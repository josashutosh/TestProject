using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsSocietyInformationEntity
    {

        #region societyName
        private int _Id;
        private string _SocietyAddress;
        private string _societyName;
        private string _RegistrationNumber;
        private int _BuildingCount;
        private int _FlatCount;
        private string _FuLogo;
        private string _fustamp;
        private string _fuSign;
        private string _CreatedBy;
        private string _ModifiedBy;
        private string _flag;
        #endregion

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }
        public string SocietyAddress
        {
            get { return _SocietyAddress; }
            set { _SocietyAddress = value; }

        }
        public string societyName
        {
            get { return _societyName; }
            set { _societyName = value; }
        }
        public string RegistrationNumber
        {
            get { return _RegistrationNumber; }
            set { _RegistrationNumber = value; }
        }
        public int BuildingCount
        {
            get { return _BuildingCount; }
            set { _BuildingCount = value; }
        }
        public int FlatCount
        {
            get { return _FlatCount; }
            set { _FlatCount = value; }
        }

        private string _SenderName;

        public string SenderName
        {
            get { return _SenderName; }
            set { _SenderName = value; }
        }
        
        public string FuLogo
        {
            get { return _FuLogo; }
            set { _FuLogo = value; }
        }
        public string fustamp
        {
            get { return _fustamp; }
            set { _fustamp = value; }
        }
        public string fuSign
        {
            get { return _fuSign; }
            set { _fuSign = value; }
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
        public string ModifiedBy
        {
            get { return _ModifiedBy; }
            set { _ModifiedBy = value; }
        }


        private float _IntrestRate;

        public float IntrestRate
        {
            get { return _IntrestRate; }
            set { _IntrestRate = value; }
        }

        private string _ReceiptNotes;

        public string ReceiptNotes
        {
            get { return _ReceiptNotes; }
            set { _ReceiptNotes = value; }
        }

        private string _accountNumber;

        public string accountNumber
        {
            get { return _accountNumber; }
            set { _accountNumber = value; }
        }

        private string _bankName;

        public string bankName
        {
            get { return _bankName; }
            set { _bankName = value; }
        }

        private string _Branch;

        public string branch
        {
            get { return _Branch; }
            set { _Branch = value; }
        }

        private string _Ifsc;

        public string Ifsc
        {
            get { return _Ifsc; }
            set { _Ifsc = value; }
        }

        private int _FlatID;

        public int FlatID
        {
            get { return _FlatID; }
            set { _FlatID = value; }
        }
        
        
    }
}
