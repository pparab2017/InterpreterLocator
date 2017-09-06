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
   static public class EmmployeeDB
    {


        public static List<Employee> GetInterpreterList()
        {
            List<Employee> toReturn = new List<Employee>();
            try
            {
               
                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Employee_Get_Online_Interpreter"))
                {
                    while (rdr.Read())
                    {
                        Employee toAdd = new Employee();
                        toAdd.EmployeId = rdr.GetInt32(0);
                        toAdd.UserName = rdr.GetString(1);
                        toAdd.FirstName = rdr.GetString(2);
                        toAdd.LastName = rdr.GetString(3);
                        toAdd.RoomID = rdr.GetInt32(5);
                        toAdd.EmployeeType = (EmplpyeeType)rdr.GetInt32(4);
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

        public static void logout(int employeeid)
        {
            SqlParameter[] parms = new SqlParameter[]
       {
                new SqlParameter("@EmployeeID", SqlDbType.Int)
             

       };
            parms[0].Value = employeeid;
         
            try
            {

                SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Employee_Update_status_Offline", parms);

            }
            catch
            {
                throw;
            }

        }


        public static void SelectRoom(int employeeid, int roomId)
        {
            SqlParameter[] parms = new SqlParameter[]
       {
                new SqlParameter("@EmployeeID", SqlDbType.Int),
                new SqlParameter("@RoomID", SqlDbType.Int),

       };
            parms[0].Value = employeeid;
            parms[1].Value = roomId;

            try
            {

                SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Employee_Update_status_Online", parms);
                
            }
            catch
            {
                throw;
            }

        }

        public static Employee GetEmployeeByUsername(string userName)
        {
            SqlParameter[] parms = new SqlParameter[]
       {
                new SqlParameter("@userName", SqlDbType.VarChar, 255),

       };
            parms[0].Value = userName;
            Employee toAuth = new Employee();


            try
            {
 
                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Employee_Get_ByUserName", parms))
                {
                    while (rdr.Read())
                    {

                        toAuth.EmployeId = rdr.GetInt32(0);
                        toAuth.UserName = rdr.GetString(1);
                        toAuth.FirstName = rdr.GetString(2);
                        toAuth.LastName = rdr.GetString(3);
                        toAuth.EmployeeType = (EmplpyeeType)rdr.GetInt32(4);

                    }
                }

            }
            catch
            {
                throw;
            }

            return toAuth;
        }
    }
}
