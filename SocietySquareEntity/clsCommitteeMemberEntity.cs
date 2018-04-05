using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsCommitteeMemberEntity
   {
       #region Variable
        private int _CommiteeMemberId;
        private int _OwnerId;
        private string _Ownername;
        private string _FlatNo;
        private int _FlatId;
        private string _Designation;
        private string _EffectiveFrom;
        private string _CreatedBy;
        private string _flag;
       #endregion

        public int CommiteeMemberId
        {
            get { return _CommiteeMemberId; }
            set { _CommiteeMemberId = value; }

        }


        public int OwnerId
        {
            get { return _OwnerId; }
            set { _OwnerId = value; }

        }
        public int FlatId
        {
            get { return _FlatId; }
            set { _FlatId = value; }

        }
        public string FlatNo
        {
            get { return _FlatNo; }
            set { _FlatNo = value; }

        }
        public string Ownername
        {
            get { return _Ownername; }
            set { _Ownername = value; }

        }
        public string Designation
        {
            get { return _Designation; }
            set { _Designation = value; }

        }

        public string EffectiveFrom
        {
            get { return _EffectiveFrom; }
            set { _EffectiveFrom = value; }

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


   }
}
