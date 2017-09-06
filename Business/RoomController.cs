using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;

namespace Business
{
    public static class RoomController
    {
        public static List<Room> GetAllRooms()
        {
            return DataAccess.RoomDB.GetAllRooms();
        }
    }
}
