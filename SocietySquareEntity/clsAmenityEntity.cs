using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
    public class clsAmenityEntity
    {
        #region Aminity Variables
        private int _AminityId;
        private int _BuildingId;
        private int _Gymnasium;
        private string _GymDesc;
        private int _Parking;
        private string _ParkingDesc;
        private int _Lift;
        private string _LiftDesc;
        private int _CCTV;
        private string _CCTVDesc;
        private int _InterCom;
        private string _IntercomDesc;
        private int _Security;
        private string _SecurityDesc;
        private int _GeneratorBkp;
        private string _GeneratorDesc;
        private int _CommunityHall;
        private string _CommunityDesc;
        private int _SwimmingPool;
        private string _SwimmingDesc;
        private int _Chairs;
        private string _ChairsDesc;
        private int _Tables;
        private string _TablesDesc;
        private int _MusicSystem;
        private string _MusicSysDesc;
        private string _CreatedBy;
        #endregion


        #region Aminity Properties
        public int AminityId
        {
            get { return _AminityId; }
            set { _AminityId = value; }
        }
        public int BuildingId
        {
            get { return _BuildingId; }
            set { _BuildingId = value; }
        }

        public int Gymnasium
        {
            get { return _Gymnasium; }
            set { _Gymnasium = value; }
        }

        public string GymDesc
        {
            get { return _GymDesc; }
            set { _GymDesc = value; }
        }
        public int Parking
        {
            get { return _Parking; }
            set { _Parking = value; }
        }

        public string ParkingDesc
        {
            get { return _ParkingDesc; }
            set { _ParkingDesc = value; }
        }
        public int Lift
        {
            get { return _Lift; }
            set { _Lift = value; }
        }

        public string LiftDesc
        {
            get { return _LiftDesc; }
            set { _LiftDesc = value; }
        }

        public int CCTV
        {
            get { return _CCTV; }
            set { _CCTV = value; }
        }

        public string CCTVDesc
        {
            get { return _CCTVDesc; }
            set { _CCTVDesc = value; }
        }
        public int InterCom
        {
            get { return _InterCom; }
            set { _InterCom = value; }
        }

        public string IntercomDesc
        {
            get { return _IntercomDesc; }
            set { _IntercomDesc = value; }
        }
        public int Security
        {
            get { return _Security; }
            set { _Security = value; }
        }

        public string SecurityDesc
        {
            get { return _SecurityDesc; }
            set { _SecurityDesc = value; }
        }
        public int GeneratorBkp
        {
            get { return _GeneratorBkp; }
            set { _GeneratorBkp = value; }
        }

        public string GeneratorDesc
        {
            get { return _GeneratorDesc; }
            set { _GeneratorDesc = value; }
        }
        public int CommunityHall
        {
            get { return _CommunityHall; }
            set { _CommunityHall = value; }
        }

        public string CommunityDesc
        {
            get { return _CommunityDesc; }
            set { _CommunityDesc = value; }
        }
        public int SwimmingPool
        {
            get { return _SwimmingPool; }
            set { _SwimmingPool = value; }
        }

        public string SwimmingDesc
        {
            get { return _SwimmingDesc; }
            set { _SwimmingDesc = value; }
        }

        public int Chairs
        {
            get { return _Chairs; }
            set { _Chairs = value; }
        }

        public string ChairsDesc
        {
            get { return _ChairsDesc; }
            set { _ChairsDesc = value; }
        }
        public int Tables
        {
            get { return _Tables; }
            set { _Tables = value; }
        }

        public string TablesDesc
        {
            get { return _TablesDesc; }
            set { _TablesDesc = value; }
        }
        public int MusicSystem
        {
            get { return _MusicSystem; }
            set { _MusicSystem = value; }
        }

        public string MusicSysDesc
        {
            get { return _MusicSysDesc; }
            set { _MusicSysDesc = value; }
        }
        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }
        #endregion

        private string _SocietyId;

        public string SocietyId
        {
            get { return _SocietyId; }
            set { _SocietyId = value; }
        }

        private string _LoginType;

        public string LoginType
        {
            get { return _LoginType; }
            set { _LoginType = value; }
        }
        
        
    }
}