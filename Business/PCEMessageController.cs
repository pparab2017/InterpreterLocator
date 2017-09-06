using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;

namespace Business
{
   public static class PCEMessageController
    {
        public static int  SendMessageToInterpreter(Message toSend)
        {
           return MessageDB.SendMessageToInterpreter(toSend);
        }
        
        public static void CancelMessage(int id)
        {
            MessageDB.CancelMessage(id);
        }

        public static List<Message> GetReplyForMe(int oldID)
        {
            return MessageDB.GetResponseMessage(oldID);
        }
    }
}
