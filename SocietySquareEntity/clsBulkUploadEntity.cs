using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class clsBulkUploadEntity
    {

        private int _SocietyId;

        public int SocietyId
        {
            get { return _SocietyId; }
            set { _SocietyId = value; }
        }

        private string _UniqueId;

        public string UniqueId
        {
            get { return _UniqueId; }
            set { _UniqueId = value; }
        }

        private string _Date;

        public string Date
        {
            get { return _Date; }
            set { _Date = value; }
        }

        private string _Flag;

        public string Flag
        {
            get { return _Flag; }
            set { _Flag = value; }
        }

        private string _CreatedBy;

        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }

        private string _FlatIds;

        public string FlatIds
        {
            get { return _FlatIds; }
            set { _FlatIds = value; }
        }


        private int _FlatId;

        public int FlatId
        {
            get { return _FlatId; }
            set { _FlatId = value; }
        }



    }



}
