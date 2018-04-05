using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
  public  class clsFlatEntity
    {
      #region Variable
      private int _FlatId;
      private string _FlatNumber;
     private int _CarpetArea;
     private int _TotalArea;
     private string _FlatType;
     private int _IsShareCertificateGiven;
     private int _IsRented;
     private int _BuildingId;
     private int _OwnerId;
      private string _CreatedBy;
      private string _PropertyType;
      private string _LicenseNo;
      private string _ShopDescription;
      private string _businesstype;
      private string _flag;
        #endregion

      public int FlatId
      {
          get { return _FlatId; }
          set { _FlatId = value; }
      }

      public string PropertyType
      {
          get { return _PropertyType; }
          set { _PropertyType = value; }
      }

      public string LicenseNo
      {
          get { return _LicenseNo; }
          set { _LicenseNo = value; }
      }

      public string ShopDescription
      {
          get { return _ShopDescription; }
          set { _ShopDescription = value; }
      }
      public string businesstype
      {
          get { return _businesstype; }
          set { _businesstype = value; }
      }
      
      public string FlatNumber
      {
          get { return _FlatNumber; }
          set { _FlatNumber = value; }
      }
      public int CarpetArea
      {
          get { return _CarpetArea; }
          set { _CarpetArea = value; }
      }

      public int TotalArea
      {
          get { return _TotalArea; }
          set { _TotalArea = value; }
      }

      public string FlatType
      {
          get { return _FlatType; }
          set { _FlatType = value; }
      }

      public int IsShareCertificateGiven
      {
          get { return _IsShareCertificateGiven; }
          set { _IsShareCertificateGiven = value; }
      }

      public int IsRented
      {
          get { return _IsRented; }
          set { _IsRented = value; }
      }
      public int BuildingId
      {
          get { return _BuildingId; }
          set { _BuildingId = value; }
      }

      public int OwnerId
      {
          get { return _OwnerId; }
          set { _OwnerId = value; }
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

      public string ShareCertificateNumber { get; set; }

      private string _SocietyId;

      public string SocietyId
      {
          get { return _SocietyId; }
          set { _SocietyId = value; }
      }
        

    }
}
