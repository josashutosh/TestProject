using System;
using System.Configuration;
using System.Net.Mail;


/// <summary>
/// Summary description for Mail.
/// </summary>
namespace SocietyDAL
{

public class Mail
{
    private string m_To;
    private string m_From;
    private string m_Cc;
    private string m_Bcc;
    private string m_Subject;
    private string m_Body;
    private string m_MailServer;
    private string m_Format;
    private string m_Priority;
    private string m_ImageURL;
    private AlternateView m_alternateView;
    private LinkedResource m_LinkedResource;
    private AlternateView m_alter1;
    //private MailMessage objMail;
    private MailMessage mMailMessage;
    public Mail()
    {
        //MailMessage  
        // System.Net.Mail.MailMessage();    
        //objMail= new MailMessage();
        //mMailMessage = new MailMessage();
        m_Format = "Text";
        m_Priority = "High";
        m_Body = "";
    }
    public Mail(string l_fromAddress, string l_toAddress, string l_bcc, string l_cc, string l_subject, string l_content)
    {
        From = l_fromAddress;
        To = l_toAddress;
        Bcc = l_bcc;
        Cc = l_cc;
        Subject = l_subject;
        Body = l_content;

    }
    public AlternateView HtmlView
    {
        get { return m_alternateView; }
        set { m_alternateView = value; }
    }
    public AlternateView HtmlViewForImage
    {
        get { return m_alter1; }
        set { m_alter1 = value; }
    }
    public LinkedResource imagelink
    {
        get
        {
            return m_LinkedResource;
        }
        set
        {
            m_LinkedResource = value;
        }
    }
    public string To
    {
        get
        {
            return m_To;
        }
        set
        {
            m_To = value;
        }
    }

    public string From
    {
        get
        {
            return m_From;
        }
        set
        {
            m_From = value;
        }
    }
    public string ImageURL
    {
        get
        {
            return m_ImageURL;
        }
        set
        {
            m_ImageURL = value;
        }
    }
    public string Cc
    {
        get
        {
            return m_Cc;
        }
        set
        {
            m_Cc = value;
        }
    }
    public string Bcc
    {
        get
        {
            return m_Bcc;
        }
        set
        {
            m_Bcc = value;
        }
    }
    public string Subject
    {
        get
        {
            return m_Subject;
        }
        set
        {
            m_Subject = value;
        }
    }
    public string Body
    {
        get
        {
            return m_Body;
        }
        set
        {
            m_Body = value;
        }
    }
    public string MailServer
    {
        get
        {
            return m_MailServer;
        }
        set
        {
            m_MailServer = value;
        }
    }
    /// <summary>
    /// "Text"(Default) or "Html"
    /// </summary>
    public string Format
    {
        get
        {
            return m_Format;
        }
        set
        {
            m_Format = value;
        }
    }
    /// <summary>
    /// "High"(Default) or "Normal" or "Low"
    /// </summary>
    public string Priority
    {
        get
        {
            return m_Priority;
        }
        set
        {
            m_Priority = value;
        }
    }



    public void Attachment(string Attachments)
    {
        //mMailMessage.Attachments.Add(Attachment);
    }

    #region SendEmailDummy
    public int SendMailDummyMethod()
    {
        int Err;
        mMailMessage = new MailMessage();
        // Instantiate a new instance of MailMessage
        ////// MailMessage mMailMessage = new MailMessage();****

        // Set the sender address of the mail message
        mMailMessage.From = new MailAddress(From);
        // Set the recepient address of the mail message
        mMailMessage.To.Add(new MailAddress(To));

        // Check if the bcc value is null or an empty string
        if ((m_Bcc != null) && (m_Bcc != string.Empty))
        {
            // Set the Bcc address of the mail message
            mMailMessage.Bcc.Add(new MailAddress(Bcc));
        }

        // Check if the cc value is null or an empty value
        if ((m_Cc != null) && (m_Cc != string.Empty))
        {
            // Set the CC address of the mail message
            mMailMessage.CC.Add(new MailAddress(Cc));
        }

        // Set the subject of the mail message
        mMailMessage.Subject = Subject;
        // Set the body of the mail message
        //mMailMessage.Body = Body;


        // Set the format of the mail message body as HTML
        mMailMessage.IsBodyHtml = true;
        // Set the priority of the mail message to normal
        mMailMessage.Priority = MailPriority.Normal;

        //string EmailBody = "<b>Welcome to popfly!!</b><br><img alt=\"\" hspace=0 src=\"cid:imageId\" align=baseline border=0 >";
        //AlternateView htmlView = AlternateView.CreateAlternateViewFromString(Body);
        //LinkedResource imagelink = new LinkedResource(ImageURL,"image/jpeg");
        //imagelink.ContentId = "imageId";
        //imagelink.TransferEncoding = System.Net.Mime.TransferEncoding.Base64;
        //htmlView.LinkedResources.Add(imagelink);
        mMailMessage.Body = Body;
        //mMailMessage.AlternateViews.Add(HtmlView);
        //mMailMessage.AlternateViews.Add(HtmlViewForImage);
        //mMailMessage.Body = EmailBody;
        // mMailMessage.Body = Body;

        SmtpClient mSmtpClient = new SmtpClient();


        //mSmtpClient.Host = strSMTPServer;

        // mSmtpClient.Host  = "";

        //// mSmtpClient.Host = "smtpout.secureserver.net";

        // mSmtpClient.UseDefaultCredentials = true;

        // System.Net.NetworkCredential UserDetails = new System.Net.NetworkCredential();
        // UserDetails.UserName = "";
        // UserDetails.Password = "";

        // mSmtpClient.Credentials = UserDetails;

        // Send the mail message
        try
        {
            mSmtpClient.Send(mMailMessage);
            Err = 0;
            return Err;
        }
        catch (Exception Ex)
        {
            Err = 1;
            return Err;
            Ex.Message.ToString();

        }


    }
    #endregion

    public int SendMail()
    {
        int Err;
        mMailMessage = new MailMessage();
        // Instantiate a new instance of MailMessage
        ////// MailMessage mMailMessage = new MailMessage();****

        // Set the sender address of the mail message
        mMailMessage.From = new MailAddress(From);
        // Set the recepient address of the mail message
        mMailMessage.To.Add(new MailAddress(To));

        // Check if the bcc value is null or an empty string
        if ((m_Bcc != null) && (m_Bcc != string.Empty))
        {
            // Set the Bcc address of the mail message
            mMailMessage.Bcc.Add(new MailAddress(Bcc));
        }

        // Check if the cc value is null or an empty value
        if ((m_Cc != null) && (m_Cc != string.Empty))
        {
            // Set the CC address of the mail message
            mMailMessage.CC.Add(new MailAddress(Cc));
        }

        // Set the subject of the mail message
        mMailMessage.Subject = Subject;
        // Set the body of the mail message
        mMailMessage.Body = Body;


        // Set the format of the mail message body as HTML
        mMailMessage.IsBodyHtml = true;
        // Set the priority of the mail message to normal
        mMailMessage.Priority = MailPriority.Normal;

        // Instantiate a new instance of SmtpClient

        //string strSMTPServer = ConfigurationSettings.AppSettings["smtpservername"];

        SmtpClient mSmtpClient = new SmtpClient();


        //mSmtpClient.Host = strSMTPServer;

        // mSmtpClient.Host  = "";

        //// mSmtpClient.Host = "smtpout.secureserver.net";

        // mSmtpClient.UseDefaultCredentials = true;

        // System.Net.NetworkCredential UserDetails = new System.Net.NetworkCredential();
        // UserDetails.UserName = "";
        // UserDetails.Password = "";

        // mSmtpClient.Credentials = UserDetails;

        // Send the mail message
        try
        {
            mSmtpClient.Send(mMailMessage);
            Err = 0;
            return Err;
        }
        catch (Exception ex)
        {
            Err = 1;
            return Err;
            ex.Message.ToString();

        }


    }

}

}