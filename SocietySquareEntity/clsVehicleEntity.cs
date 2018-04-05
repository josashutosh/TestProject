using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyDAL
{
    public class clsVehicleEntity
    {
           #region Variable
      private int _FlatId;
      private string _FlatNumber;

      private int _vehicleid;

      private string _flag;
      private string _noOfvehicle;
      private string _VehicleTypeVeh1;
      private string _VehicleNumberVeh1;
      private int _ISstickerGivenVeh1;

      private string _VehicleTypeVeh2;
      private string _VehicleNumberVeh2;
      private int _ISstickerGivenVeh2;

      private string _VehicleTypeVeh3;
      private string _VehicleNumberVeh3;
      private int _ISstickerGivenVeh3;


      private string _VehicleTypeVeh4;
      private string _VehicleNumberVeh4;
      private int _ISstickerGivenVeh4;

      private string _txtExtravehinfo;
      private string _createdBy;

        #endregion

      public int FlatId
      {
          get { return _FlatId; }
          set { _FlatId = value; }
      }
      public int vehicleid
      {
          get { return _vehicleid; }
          set { _vehicleid = value; }
      }
      public string flag
      {
          get { return _flag; }
          set { _flag = value; }
      }

      public string FlatNumber
      {
          get { return _FlatNumber; }
          set { _FlatNumber = value; }
      }
      public string noOfvehicle
      {
          get { return _noOfvehicle; }
          set { _noOfvehicle = value; }
      }


      public string VehicleTypeVeh1
      {
          get { return _VehicleTypeVeh1; }
          set { _VehicleTypeVeh1 = value; }
      }

      public string VehicleNumberVeh1
      {
          get { return _VehicleNumberVeh1; }
          set { _VehicleNumberVeh1 = value; }
      }
      public int ISstickerGivenVeh1
      {
          get { return _ISstickerGivenVeh1; }
          set { _ISstickerGivenVeh1 = value; }
      }



      public string VehicleTypeVeh2
      {
          get { return _VehicleTypeVeh2; }
          set { _VehicleTypeVeh2 = value; }
      }

      public string VehicleNumberVeh2
      {
          get { return _VehicleNumberVeh2; }
          set { _VehicleNumberVeh2 = value; }
      }
      public int ISstickerGivenVeh2
      {
          get { return _ISstickerGivenVeh2; }
          set { _ISstickerGivenVeh2 = value; }
      }

      public string VehicleTypeVeh3
      {
          get { return _VehicleTypeVeh3; }
          set { _VehicleTypeVeh3 = value; }
      }

      public string VehicleNumberVeh3
      {
          get { return _VehicleNumberVeh3; }
          set { _VehicleNumberVeh3 = value; }
      }
      public int ISstickerGivenVeh3
      {
          get { return _ISstickerGivenVeh3; }
          set { _ISstickerGivenVeh3 = value; }
      }

      public string VehicleTypeVeh4
      {
          get { return _VehicleTypeVeh4; }
          set { _VehicleTypeVeh4 = value; }
      }

      public string VehicleNumberVeh4
      {
          get { return _VehicleNumberVeh4; }
          set { _VehicleNumberVeh4 = value; }
      }
      public int ISstickerGivenVeh4
      {
          get { return _ISstickerGivenVeh4; }
          set { _ISstickerGivenVeh4 = value; }
      }

      public string Extravehinfo
      {
          get { return _txtExtravehinfo; }
          set { _txtExtravehinfo = value; }
      }
      public string createdBy
      {
          get { return _createdBy; }
          set { _createdBy = value; }
      }


    }
    }
