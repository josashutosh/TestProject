using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
  public class clsReportParameterEntity
    {
   #region Variable
      private string _Login_Type;
      private int _flatNumber;

      private string _ReportDate;
   #endregion  
      
      
      public string Login_Type
      {
          get { return _Login_Type; }
          set { _Login_Type = value; }
      }
      public string ReportDate
      {
          get { return _ReportDate; }
          set { _ReportDate = value; }
      }
      public int flatNumber
      {
          get { return _flatNumber; }
          set { _flatNumber = value; }
      }

      private string _PropertyType;

      public string PropertyType
      {
          get { return _PropertyType; }
          set { _PropertyType = value; }
      }

      private string _FlatmaintenanceId;

      public string FlatmaintenanceId
      {
          get { return _FlatmaintenanceId; }
          set { _FlatmaintenanceId = value; }
      }
        
        

    }
}
