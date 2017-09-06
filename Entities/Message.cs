using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
   public class Message
    {
        private int _messageID;
        private string _messageText;
        private DateTime _time;
        private int _sourceID;
        private int _destinationId;

        private string _FromFirstName;
        private string _FromLastName;
        private int _FromRoomID;
       
        public string FromFullName
        {
            get
            {
                return _FromFirstName + " " + _FromLastName;
            }
        }

        public int MessageID
        {
            get
            {
                return _messageID;
            }

            set
            {
                _messageID = value;
            }
        }

        public string MessageText
        {
            get
            {
                return _messageText;
            }

            set
            {
                _messageText = value;
            }
        }

        public DateTime Time
        {
            get
            {
                return _time;
            }

            set
            {
                _time = value;
            }
        }

        public int SourceID
        {
            get
            {
                return _sourceID;
            }

            set
            {
                _sourceID = value;
            }
        }

        public int DestinationId
        {
            get
            {
                return _destinationId;
            }

            set
            {
                _destinationId = value;
            }
        }

        public string FromFirstName
        {
            get
            {
                return _FromFirstName;
            }

            set
            {
                _FromFirstName = value;
            }
        }

        public string FromLastName
        {
            get
            {
                return _FromLastName;
            }

            set
            {
                _FromLastName = value;
            }
        }

        public int FromRoomID
        {
            get
            {
                return _FromRoomID;
            }

            set
            {
                _FromRoomID = value;
            }
        }
    }
}
