using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyDAL
{
   public class clsSocietyMemberDashboardEntity
    {
        #region Variable
           private string _LoginType;
           private int _FlatID;
           private int _OwnerID;
        #endregion

           public string LoginType
        {
            get { return _LoginType; }
            set { _LoginType = value; }
        }

           public int FlatID
        {
            get { return _FlatID; }
            set { _FlatID = value; }
        }

        public int OwnerID
        {
            get { return _OwnerID; }
            set { _OwnerID = value; }
        }

        private string _LoginId;

        public string LoginId
        {
            get { return _LoginId; }
            set { _LoginId = value; }
        }

        private int _SocietyId;

        public int SocietyId
        {
            get { return _SocietyId; }
            set { _SocietyId = value; }
        }

        private string _flag;

        public string flag
        {
            get { return _flag; }
            set { _flag = value; }
        }


        private int _MaintenanceId;

        public int MaintenanceId
        {
            get { return _MaintenanceId; }
            set { _MaintenanceId = value; }
        }
        
    }
}
