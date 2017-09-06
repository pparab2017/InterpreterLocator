using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;

namespace Business
{
    static public class EmployeeController
    {

        public static Employee GetEmployeeByUsername(string userName)
        {
            return DataAccess.EmmployeeDB.GetEmployeeByUsername(userName);
        }

         public static void selectRoom(int employeeId, int roomId)
        {
            DataAccess.EmmployeeDB.SelectRoom(employeeId, roomId);
        }

        public static void logout(int employeeId)
        {
            DataAccess.EmmployeeDB.logout(employeeId);
        }
    }
}
