using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyDAL
{
  public  class clsEmployeeEntity
    {
        #region Variable

        private int _EmployeeId;
        private string _Name;
        private string _EmployeeNo;
        private string _JobDescription;
        private long _ContactNo;
        private string _Address;
        private string _PAN;
        private string _AadhaarCard;
        private float _Salary;
        private string _Designation;
        private string _DOJ;
        private string _DOL;
        private string _CreatedBy;
        private string _ModifiedBy;
        #endregion

        public int EmployeeId
        {
            get { return _EmployeeId; }
            set { _EmployeeId = value; }
        }
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public string EmployeeNo
        {
            get { return _EmployeeNo; }
            set { _EmployeeNo = value; }
        }
        public string JobDescription
        {
            get { return _JobDescription; }
            set { _JobDescription = value; }
        }

        public long ContactNo
        {
            get { return _ContactNo; }
            set { _ContactNo = value; }
        }

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }
        public string PAN
        {
            get { return _PAN; }
            set { _PAN = value; }
        }
        public string AadhaarCard
        {
            get { return _AadhaarCard; }
            set { _AadhaarCard = value; }
        }

        public float Salary
        {
            get { return _Salary; }
            set { _Salary = value; }
        }

        public string Designation
        {
            get { return _Designation; }
            set { _Designation = value; }
        }

        public string DOJ
        {
            get { return _DOJ; }
            set { _DOJ = value; }
        }

        public string DOL
        {
            get { return _DOL; }
            set { _DOL = value; }
        }
        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }

        public string ModifiedBy
        {
            get { return _ModifiedBy; }
            set { _ModifiedBy = value; }
        }


        public string SocietyId { get; set; }
    }
}
