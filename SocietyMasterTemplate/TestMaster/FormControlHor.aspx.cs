using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EsquareMasterTemplate.Common;

namespace EsquareMasterTemplate.TestMaster
{
    public partial class FormControlHor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CommonHelper abc=new CommonHelper();
              string username = "8655096955";
                        string password = "rampandu17";
                        string Message = "4 and message";
                        string number = "9029150847";//Formultiple Number seprated by comma
                        string SenderName = "TESTTO";
                        string MessageType = "ndnd";

                     //abc.SendSms( username, password, SenderName, MessageType, number, Message);
           
        }
    }
}