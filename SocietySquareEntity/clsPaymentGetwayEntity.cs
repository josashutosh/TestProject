using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public  class clsPaymentGetwayEntity
    {
        private long _PaymentDetailId;

        public long PaymentDetailId
        {
            get { return _PaymentDetailId; }
            set { _PaymentDetailId = value; }
        }

        private string _PgType;

        public string PgType
        {
            get { return _PgType; }
            set { _PgType = value; }
        }

        private string _BankRefNumber;

        public string BankRefNumber
        {
            get { return _BankRefNumber; }
            set { _BankRefNumber = value; }
        }

        private string _BankCode;

        public string BankCode
        {
            get { return _BankCode; }
            set { _BankCode = value; }
        }


        private string _Error;

        public string Error
        {
            get { return _Error; }
            set { _Error = value; }
        }

        private string _Status;

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        private string _ErrorMessage;

        public string ErrorMessage
        {
            get { return _ErrorMessage; }
            set { _ErrorMessage = value; }
        }

        private string _NameOnCard;

        public string NameOnCard
        {
            get { return _NameOnCard; }
            set { _NameOnCard = value; }
        }


        private string _CardNumber;

        public string CardNumber
        {
            get { return _CardNumber; }
            set { _CardNumber = value; }
        }

        private string  _PayuMoneyId;

        public string  PayuMoneyId
        {
            get { return _PayuMoneyId; }
            set { _PayuMoneyId = value; }
        }

        private string _NetAmount;

        public string NetAmount
        {
            get { return _NetAmount; }
            set { _NetAmount = value; }
        }

        private string _Mode;

        public string Mode
        {
            get { return _Mode; }
            set { _Mode = value; }
        }

        private string _addedon;

        public string addedon
        {
            get { return _addedon; }
            set { _addedon = value; }
        }

        private string _unmappedstatus;

        public string unmappedstatus
        {
            get { return _unmappedstatus; }
            set { _unmappedstatus = value; }
        }
        

        private string _Createdon;

        public string Createdon
        {
            get { return _Createdon; }
            set { _Createdon = value; }
        }

        private string _flag;

        public string flag
        {
            get { return _flag; }
            set { _flag = value; }
        }
        
        
        
        


        
        
        
        
        
        
        
        
    }

    public class MaintenanceInfo
    {
        public string InfoMaintenanceID { get; set; }
        public string InfoPropertyType { get; set; }
        public string InfoMessage { get; set; }
        public char flag { get; set; }
        public double Amount { get; set; }
        public double PaidAmount { get; set; }
        public long SocietyId { get; set; }
     
    }

    public class ProductInfo
    {
        public List<MaintenanceInfo> paymentParts { get; set; }
    }

}
