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
  static public class RoomDB
    {



        public static List<Room> GetAllRooms()
        {
            List<Room> toReturn = new List<Room>();
            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Room_Get_All"))
                {
                    while (rdr.Read())
                    {
                        Room toAdd = new Room();
                        toAdd.RoomId = rdr.GetInt32(0);
                        toAdd.RoomNumber = rdr.GetString(1);
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

    }
}
