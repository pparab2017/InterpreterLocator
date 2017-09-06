using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
   public class Room
    {
        int _roomId;
        string _roomNumber;

        public int RoomId
        {
            get
            {
                return _roomId;
            }

            set
            {
                _roomId = value;
            }
        }

        public string RoomNumber
        {
            get
            {
                return _roomNumber;
            }

            set
            {
                _roomNumber = value;
            }
        }
    }
}
