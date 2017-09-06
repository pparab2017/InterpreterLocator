using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Entities;
using Business;
/// <summary>
/// Summary description for GetInterpreter
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class GetInterpreter : System.Web.Services.WebService
{

    public GetInterpreter()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public  List<Employee> GetInterpreterList()
    {
        return InterpreterController.GetInterpreterList();
    }

    [WebMethod]
    public int sendMessage(int srcID,int dstID, string message)
    {
        Message msg = new Message();
        msg.MessageText = message;
        msg.SourceID = srcID;
        msg.DestinationId = dstID;
        msg.Time = DateTime.Now;
        return PCEMessageController.SendMessageToInterpreter(msg);
    }

    [WebMethod]
    public string getMap( int src, int des)
    {
        return MapController.GetMap(src, des);
    }
}
