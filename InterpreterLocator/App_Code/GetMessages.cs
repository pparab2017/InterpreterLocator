using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Entities;
using Business;

/// <summary>
/// Summary description for GetMessages
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class GetMessages : System.Web.Services.WebService
{

    public GetMessages()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<Message> GetMessagesByUserID(int srcID)
    {
        return InterpreterMessageController.GetMessages(srcID);
    }

    [WebMethod]
    public List<Message> GetResponseForMe(int oldID)
    {
        return PCEMessageController.GetReplyForMe(oldID);
    }

    [WebMethod]
    public bool CancelMessageResponse(int oldID)
    {
       return InterpreterMessageController.CancelMessageResponse(oldID);
    }


    [WebMethod]
    public void CancelMessage(int oldID)
    {
        PCEMessageController.CancelMessage(oldID);
    }

    [WebMethod]
    public int sendMessage(int srcID, int dstID, string message, int oldmsgID)
    {
        Message msg = new Message();
        msg.MessageText = message;
        msg.SourceID = srcID;
        msg.DestinationId = dstID;
        msg.Time = DateTime.Now;
        return InterpreterMessageController.SendMessage(msg, oldmsgID);
    }

}
