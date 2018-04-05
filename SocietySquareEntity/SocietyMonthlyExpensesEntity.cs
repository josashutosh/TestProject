using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class SocietyMonthlyExpensesEntity
    {

        #region Varible
        private int _MonthlyExpenseId;
        private int _SecurityId;
        
        private float _SecurityGuardsSalary;


        private float _PowerCharges;
        private float _WaterCharges;
        private float _SecuritySalary;
        private float _HousekeepingSalary;
        private float _ManagerSalary;
        private float _Stationary;
        private float _DgSet;
        private float _GymInstructor;
        private float _CommunityHall;
        private float _InsurancePremium;
        private float _Miscellaneous;
        private float _SupervisorSalary;
        private float _SumTotal;

        private string _FromDate;
        private string _ToDate;
        private string _CreatedBy;
       
        #endregion



        public int MonthlyExpenseId
        {
            get { return _MonthlyExpenseId; }
            set { _MonthlyExpenseId = value; }
        }

        public int SecurityId
        {
            get { return _SecurityId; }
            set { _SecurityId = value; }
        }

        public float SecurityGuardsSalary
        {
            get { return _SecurityGuardsSalary; }
            set { _SecurityGuardsSalary = value; }
        }

        public float PowerCharges
        {
            get { return _PowerCharges; }
            set { _PowerCharges = value; }
        }
        public float WaterCharges
        {
            get { return _WaterCharges; }
            set { _WaterCharges = value; }
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

        public float InsurancePremium
        {
            get { return _InsurancePremium; }
            set { _InsurancePremium = value; }
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
        public float SumTotal
        {
            get { return _SumTotal; }
            set { _SumTotal = value; }
        }
        public string FromDate
        {
            get { return _FromDate; }
            set { _FromDate = value; }
        }
        public string ToDate
        {
            get { return _ToDate; }
            set { _ToDate = value; }
        }
        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }
    }
}
