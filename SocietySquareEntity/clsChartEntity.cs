using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsChartEntity
    {
        private long _socityId;

        public long SocietyId
        {
            get { return _socityId; }
            set { _socityId = value; }
        }


        private string _flag;

        public string Flag
        {
            get { return _flag; }
            set { _flag = value; }
        }
        


        
    }

   public class GetExpenseChart
        {
            public string PlanName { get; set; }
            public int PaymentAmount { get; set; }
            public string HtmlContent { get; set; }
        }
}
