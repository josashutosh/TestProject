using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for DBHelper
/// </summary>
public class DBHelper
{
	public DBHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// extracts the connection string from web config
    /// </summary>
    /// <returns>Connection string</returns>
    public string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["society"].ToString();
    }

    public static string ConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["society"].ToString();
    }
}
