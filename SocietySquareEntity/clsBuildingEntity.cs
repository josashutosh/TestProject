using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class clsBuildingEntity
    {
        #region Variable
        private int _BuildingId;
        private string _Name;
        private int _SocietyId;
        private int _Floors;
        private int _Flats;
        private int _TotalArea;
        private string _CreatedBy;
        private string _ModifiedBy;
        #endregion



        public int BuildingId
        {
            get { return _BuildingId; }
            set { _BuildingId = value; }
        }
        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public int Floors
        {
            get { return _Floors; }
            set { _Floors = value; }
        }

        public int SocietyId
        {
            get { return _SocietyId; }
            set { _SocietyId = value; }
        }

        public int Flats
        {
            get { return _Flats; }
            set { _Flats = value; }
        }

        public int TotalArea
        {
            get { return _TotalArea; }
            set { _TotalArea = value; }
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
        private string _varSocietyId;

        public string SocietyIdvar
        {
            get { return _varSocietyId; }
            set { _varSocietyId = value; }
        }

    }
}
