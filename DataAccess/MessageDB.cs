using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace DataAccess
{
    public static class MessageDB
    {

        public static List<Message> GetMessages(int userID)
        {
            List<Message> toReturn = new List<Message>();
            try
            {
                //@ID
                SqlParameter[] parms = new SqlParameter[]
      {
                new SqlParameter("@ID", SqlDbType.Int),

      };
                parms[0].Value = userID;
                

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "msg_getMessage_for_me", parms))
                {
                    while (rdr.Read())
                    {
                        Message toAdd = new Message();
                        toAdd.MessageID = rdr.GetInt32(0);
                        toAdd.Time = rdr.GetDateTime(1);
                        toAdd.MessageText = rdr.GetString(2);
                        toAdd.SourceID = rdr.GetInt32(3);
                        toAdd.DestinationId = rdr.GetInt32(4);

                        toAdd.FromFirstName = rdr.GetString(7);
                        toAdd.FromLastName = rdr.GetString(8);
                        toAdd.FromRoomID = rdr.GetInt32(9);

                        toReturn.Add(toAdd);
                    }
                }
            }
            catch
            {
                throw;
            }
            return toReturn;
        }

        public static int  SendReplayToPCE(Message toSend, int oldmessageId)
        {
            int toReturn = 0;
            SqlParameter[] parms = new SqlParameter[]
      {
            new SqlParameter("@message", SqlDbType.VarChar, 255),
            new SqlParameter("@timeStamp", SqlDbType.DateTime),
            new SqlParameter("@sourceID", SqlDbType.Int),
            new SqlParameter("@destinationID", SqlDbType.Int),
            new SqlParameter("@OldMessageID", SqlDbType.Int)

      };
            parms[0].Value = toSend.MessageText;
            parms[1].Value = toSend.Time;
            parms[2].Value = toSend.SourceID;
            parms[3].Value = toSend.DestinationId;
            parms[4].Value = oldmessageId;


            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Send_Reply_to_PCE", parms))
                {
                    while (rdr.Read())
                    {
                        decimal t = rdr.GetDecimal(0);
                        toReturn = Int32.Parse(t.ToString());
                    }
                }
            }
            catch
            {
                throw;
            }
            return toReturn;



        }


        public static List<Message> GetResponseMessage(int oldMsgID)
        {
            List<Message> toReturn = new List<Message>();
            try
            {
                //@ID
                SqlParameter[] parms = new SqlParameter[]
                {
                new SqlParameter("@oldID", SqlDbType.Int),

                };
                parms[0].Value = oldMsgID;


                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "msg_getReply_for_me", parms))
                {
                    while (rdr.Read())
                    {
                        Message toAdd = new Message();
                        toAdd.MessageID = rdr.GetInt32(0);
                        toAdd.Time = rdr.GetDateTime(1);
                        toAdd.MessageText = rdr.GetString(2);
                        toAdd.SourceID = rdr.GetInt32(3);
                        toAdd.DestinationId = rdr.GetInt32(4);

                        toAdd.FromFirstName = rdr.GetString(5);
                        toAdd.FromLastName = rdr.GetString(6);
                        toAdd.FromRoomID = rdr.GetInt32(7);

                        toReturn.Add(toAdd);
                    }
                }
            }
            catch
            {
                throw;
            }
            return toReturn;

        }


        //[msg_cancel]

        public static void CancelMessage(int msgID)
        {
            SqlParameter[] parms = new SqlParameter[]
           {
            new SqlParameter("@messageid", SqlDbType.Int),
           };
            parms[0].Value = msgID;
            try
            {
                SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "msg_cancel", parms);
            }
            catch(Exception ex)
            {
                throw ex;
            }

            }

        public static bool GetCancelResponse(int msgID)
        {
            bool toReturn = false;
            SqlParameter[] parms = new SqlParameter[]
            {
            new SqlParameter("@messageid", SqlDbType.Int),
            };
            parms[0].Value = msgID;

            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "msg_cancel_check", parms))
                {
                    while (rdr.Read())
                    {
                        int cmp  = Convert.ToInt32(rdr.GetInt32(0));
                        if(cmp == 1)
                        {
                            toReturn = true;
                        }
                    }
                }
            }
            catch
            {
                throw;
            }
            return toReturn;
            
        }

        public static int SendMessageToInterpreter(Message toSend)
        {
            //[Sent_Message_to_Interpreter]
            int toReturn = 0;
            SqlParameter[] parms = new SqlParameter[]
        {
            new SqlParameter("@message", SqlDbType.VarChar, 255),
            new SqlParameter("@timeStamp", SqlDbType.DateTime),
            new SqlParameter("@sourceID", SqlDbType.Int),
            new SqlParameter("@destinationID", SqlDbType.Int)

        };
            parms[0].Value = toSend.MessageText;
            parms[1].Value = toSend.Time;
            parms[2].Value = toSend.SourceID;
            parms[3].Value = toSend.DestinationId;
            


            try
            {

            using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Sent_Message_to_Interpreter", parms))
            {
                while (rdr.Read())
                {
                    decimal t = rdr.GetDecimal(0);
                        toReturn = Int32.Parse(t.ToString());
                }
            }
        }
            catch
            {
                throw;
            }
            return toReturn;

        
    }

    }
}
