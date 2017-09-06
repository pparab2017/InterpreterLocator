using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;

namespace Business
{
    public static class InterpreterMessageController
    {
        public static List<Message> GetMessages(int userID)
        {
            return MessageDB.GetMessages(userID);
        }

        public static int  SendMessage(Message msg, int oldId)
        {
           return MessageDB.SendReplayToPCE(msg, oldId);

        }

        public static bool CancelMessageResponse(int msgID)
        {
            return MessageDB.GetCancelResponse(msgID);
        }
    }
}
