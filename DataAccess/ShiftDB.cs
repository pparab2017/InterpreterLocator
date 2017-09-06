using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using System.Data;
using System.Configuration;

namespace DataAccess
{
   public  class ShiftDB
    {
       

        public static List<shift> getShiftbyID(int empID)
        {
            SqlParameter[] parms = new SqlParameter[]
  {
             new SqlParameter("@employeeID", SqlDbType.VarChar, 223)
          
            
     

  };
            parms[0].Value = empID;

            List<shift> toReturn = new List<shift>();
            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Shift_Get_by_ID", parms))
                {
                    while (rdr.Read())
                    {
                        shift toAdd = new shift();
                        toAdd.ShiftID = rdr.GetInt32(0);
                        toAdd.ShiftName = rdr.GetString(1);
                        toAdd.From = rdr.GetDateTime(2);
                        toAdd.To = rdr.GetDateTime(3);
                        toAdd.DayName = rdr.GetString(4);
                        toAdd.Night = rdr.GetBoolean(5);
                        toAdd.FirstName = rdr.GetString(6);
                        toAdd.LastName = rdr.GetString(7);

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


        public static  List<shift> getAllShift()
        {
            List<shift> toReturn = new List<shift>();
            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Shift_Get_All"))
                {
                    while (rdr.Read())
                    {
                        shift toAdd = new shift();
                        toAdd.ShiftID = rdr.GetInt32(0);
                        toAdd.ShiftName = rdr.GetString(1);
                        toAdd.From = rdr.GetDateTime(2);
                        toAdd.To = rdr.GetDateTime(3);
                        toAdd.DayName = rdr.GetString(4);
                        toAdd.Night = rdr.GetBoolean(5);
                        toAdd.FirstName = rdr.GetString(6);
                        toAdd.LastName = rdr.GetString(7);

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

        public static void UpdateShiftById(shift toUpdate)
        {
            SqlParameter[] parms = new SqlParameter[]
  {
             new SqlParameter("@ShiftID", SqlDbType.VarChar, 223),
            new SqlParameter("@ShiftName", SqlDbType.VarChar, 223),
            new SqlParameter("@startTime", SqlDbType.DateTime),
            new SqlParameter("@endTime", SqlDbType.DateTime),
            new SqlParameter("@DayOfWeek", SqlDbType.VarChar, 23),
            
      //@userName

  };
            parms[0].Value = toUpdate.ShiftID;
            parms[1].Value = toUpdate.ShiftName;
            parms[2].Value = toUpdate.From;
            parms[3].Value = toUpdate.To;
            parms[4].Value = toUpdate.DayName;


            try
            {

                SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Shift_update_byShiftID", parms);

            }
            catch
            {
                throw;
            }
        }

        public static void InsertShifts(List<shift> toInsert)
        {
           for( int i = 0; i < toInsert.Count; i ++)
            {
                shift toAdd = toInsert[i];

                SqlParameter[] parms = new SqlParameter[]
     {
            new SqlParameter("@ShiftName", SqlDbType.VarChar, 223),
            new SqlParameter("@startTime", SqlDbType.DateTime),
            new SqlParameter("@endTime", SqlDbType.DateTime),
            new SqlParameter("@DayOfWeek", SqlDbType.VarChar, 23),
            new SqlParameter("@night", SqlDbType.Bit),
              new SqlParameter("@userName", SqlDbType.VarChar, 20)
            //@userName

     };
                parms[0].Value = toAdd.ShiftName;
                parms[1].Value = toAdd.From;
                parms[2].Value = toAdd.To;
                parms[3].Value = toAdd.DayName;
                parms[4].Value = toAdd.Night;
                parms[5].Value = toAdd.UserName;


                try
                {

                    SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Shift_Insert", parms);
                  
                }
                catch
                {
                    throw;
                }


            }
           
            
        }
    }
}
