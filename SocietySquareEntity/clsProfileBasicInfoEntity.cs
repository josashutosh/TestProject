using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyDAL
{
   public class clsProfileBasicInfoEntity
    {
        #region BasicInfo Variable
       private int _BasicinfoID;
       private int _ID;
       private string _FirstName;
       private string _LastName;
       private string _MaidenName;
       private string _Gender;
       private string _Birthday;
       private string _Relationship;
       private string _OtherName;
       private string _Interests;
       private string _Occupation;
       private string _AboutUs;
       private string _WorkSkills;
       private string _WebsiteUrl;
       private string _Facebook;
       private string _Twitter;
       private string _GooglePlus;
       private string _LinkedIn;
       private string _Pincode;
       private string _Place;
       private string _Latitude;
       private string _Longitude;
       private string _Tagline;
       private string _Login_Type;
       private string _CreatedBy;
       private string _CreatedOn;
       private string _flag;
        #endregion

       public int BasicinfoID
       {
           get { return _BasicinfoID; }
           set { _BasicinfoID = value; }
       }
       public int ID
       {
           get { return _ID; }
           set { _ID = value; }
       }

       public string FirstName
       {
           get { return _FirstName; }
           set { _FirstName = value; }
       }

       public string LastName
       {
           get { return _LastName; }
           set { _LastName = value; }
       }

       public String MaidenName
       {
           get { return _MaidenName; }
           set { _MaidenName = value; }
       }

       public string Gender
       {
           get { return _Gender; }
           set { _Gender = value; }
       }

       public string Birthday
       {
           get { return _Birthday; }
           set { _Birthday = value; }
       }

       public string Relationship
       {
           get { return _Relationship; }
           set { _Relationship = value; }

       }
       public string OtherName
       {
           get { return _OtherName; }
           set { _OtherName = value; }

       }

       public string Interests
       {
           get { return _Interests; }
           set { _Interests = value; }

       }

       public string Occupation
       {
           get { return _Occupation; }
           set { _Occupation = value; }

       }

       public string AboutUs
       {
           get { return _AboutUs; }
           set { _AboutUs = value; }

       }

       public string WorkSkills
       {
           get { return _WorkSkills; }
           set { _WorkSkills = value; }

       }

       public string WebsiteUrl
       {
           get { return _WebsiteUrl; }
           set { _WebsiteUrl = value; }

       }

       public string Facebook
       {
           get { return _Facebook; }
           set { _Facebook = value; }

       }

       public string Twitter
       {
           get { return _Twitter; }
           set { _Twitter = value; }

       }

       public string GooglePlus
       {
           get { return _GooglePlus; }
           set { _GooglePlus = value; }

       }

       public string Login_Type
       {
           get { return _Login_Type; }
           set { _Login_Type = value; }

       }

       public string LinkedIn
       {
           get { return _LinkedIn; }
           set { _LinkedIn = value; }

       }

       public string Pincode
       {
           get { return _Pincode; }
           set { _Pincode = value; }

       }

       public string Place
       {
           get { return _Place; }
           set { _Place = value; }

       }


       public string Latitude
       {
           get { return _Latitude; }
           set { _Latitude = value; }

       }


       public string Longitude
       {
           get { return _Longitude; }
           set { _Longitude = value; }

       }
       public string Tagline
       {
           get { return _Tagline; }
           set { _Tagline = value; }

       }

       
       public string CreatedBy
       {
           get { return _CreatedBy; }
           set { _CreatedBy = value; }

       }


       public string CreatedOn
       {
           get { return _CreatedOn; }
           set { _CreatedOn = value; }

       }


       public string flag
       {
           get { return _flag; }
           set { _flag = value; }

       }

       private string _LoginId;

       public string LoginId
       {
           get { return _LoginId; }
           set { _LoginId = value; }
       }

       private int _flatId;

       public int flatId
       {
           get { return _flatId; }
           set { _flatId = value; }
       }
        
       private string _Name;

	public string Name
	{
		get { return _Name;}
		set { _Name = value;}
	}
	private string _PersonalContact;

	public string PersonalContact
	{
		get { return _PersonalContact;}
		set { _PersonalContact = value;}
	}

	    
	
  private string _OfficeContact;

	public string OfficeContact
	{
		get { return _OfficeContact;}
		set { _OfficeContact = value;}
	}
	
private string _Email;

	public string Email
	{
		get { return _Email;}
		set { _Email = value;}
	}
	
    }

   public class objBasicinfo
   {
   }
}
