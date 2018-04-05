using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class SecuritySalaryEntity
    {
        #region Variable

        private int _SecurityId;
        private int _NoOfSecurityGuards;
        private int _GuardSalary;
        private int _Totalguardsal;
        private int _NoOfSupervisor;
        private int _SupervisorSalary;
        private string _CompanyName;
        private int _TotalSalary;
       
        private string _createdBy;

        #endregion

        public int SecurityId
        {
            get { return _SecurityId; }
            set { _SecurityId = value; }
        }
        public int NoOfSecurityGuards
        {
            get { return _NoOfSecurityGuards; }
            set { _NoOfSecurityGuards = value; }
        }
        public int GuardSalary
        {
            get { return _GuardSalary; }
            set { _GuardSalary = value; }
        }
        public int Totalguardsal
        {
            get { return _Totalguardsal; }
            set { _Totalguardsal = value; }
        }
        
        public int NoOfSupervisor
        {
            get { return _NoOfSupervisor; }
            set { _NoOfSupervisor = value; }
        }
        public int SupervisorSalary
        {
            get { return _SupervisorSalary; }
            set { _SupervisorSalary = value; }
        }
        public int TotalSalary
        {
            get { return _TotalSalary; }
            set { _TotalSalary = value; }
        }
        public string CompanyName
        {
            get { return _CompanyName; }
            set { _CompanyName = value; }
        }
        public string createdBy
        {
            get { return _createdBy; }
            set { _createdBy = value; }
        }


    }
}