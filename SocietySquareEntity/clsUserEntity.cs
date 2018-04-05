using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsUserEntity
   {      
       #region Variable

       private int _OwnerId;//ID
       private int _UID;
       private string _mobileno;
       private string _LoginType;
       private string _username;//login_id
       private string _password;
       private string _EmailID;
       private string _Expiry_Date;
       private int _Lock; 
       private int _RoleID; 
       private int _Subscription;   
       private string _City;      
       private string _Country; 
       private string _DOE;        
       private string _fullname; 
       private string _wings;
       private string _flatno;
       private string _CreatedBy;

         #endregion

       public int UID
       {
           get { return _UID; }
           set { _UID = value; }
       }

       public int OwnerId
       {
           get { return _OwnerId; }
           set { _OwnerId = value; }
       }

       public string LoginType
       {
           get { return _LoginType; }
           set { _LoginType = value; }
       }

       public string username
       {
           get { return _username; }
           set { _username = value; }
       }

       public string password
       {
           get { return _password; }
           set { _password = value; }
       }

       public string EmailID
       {
           get { return _EmailID; }
           set { _EmailID = value; }
       }

       public string Expiry_Date
       {
           get { return _Expiry_Date; }
           set { _Expiry_Date = value; }
       }

       public int Lock
       {
           get { return _Lock; }
           set { _Lock = value; }
       }

       public int RoleID
       {
           get { return _RoleID; }
           set { _RoleID = value; }
       }

       public int Subscription
       {
           get { return _Subscription; }
           set { _Subscription = value; }
       }

       public string City
       {
           get { return _City; }
           set { _City = value; }
       }


       public string Country
       {
           get { return _Country; }
           set { _Country = value; }
       }
       public string DOE
       {
           get { return _DOE; }
           set { _DOE = value; }
       }

       public string mobileno
       {
           get { return _mobileno; }
           set { _mobileno = value; }
       }
       
       public string fullname
       {
           get { return _fullname; }
           set { _fullname = value; }
       }
    
       
       public string wings
       {
           get { return _wings; }
           set { _wings = value; }
       }
       public string flatno
       {
           get { return _flatno; }
           set { _flatno = value; }
       }
       public string CreatedBy
       {
           get { return _CreatedBy; }
           set { _CreatedBy = value; }
       }
       
     
   }
}
