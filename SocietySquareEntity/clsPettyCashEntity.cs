using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocietyEntity
{
   public class clsPettyCashEntity
    {
  private int _PettyCashId;

	public int PettyCashId
	{
		get { return _PettyCashId;}
		set { _PettyCashId = value;}
	}
	
       private float _PettyCashBalance;

	public float PettyCashBalance
	{
		get { return _PettyCashBalance;}
		set { _PettyCashBalance = value;}
	}
	
        
        private string _ExpenseDecription;

	public string ExpenseDecription
	{
		get { return _ExpenseDecription;}
		set { _ExpenseDecription = value;}
	}
	
        private float _Amount;

	public float Amount
	{
		get { return _Amount;}
		set { _Amount = value;}
	}

    private string _CreatedBy;

    public string CreatedBy
    {
        get { return _CreatedBy; }
        set { _CreatedBy = value; }
    }

    private string _Flag;

    public string Flag
    {
        get { return Flag; }
        set { Flag = value; }
    }

       private int _SocietyId;

	public int SocietyId
	{
		get { return _SocietyId;}
		set { _SocietyId = value;}
	}

    private string _TransctionType;

    public string TransctionType
    {
        get { return _TransctionType; }
        set { _TransctionType = value; }
    }
        
	

    }
}
