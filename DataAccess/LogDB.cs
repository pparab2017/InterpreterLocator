using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace DataAccess
{
    public static class LogDB
    {
        public static void AppendLog(Log toInsert)
        {
            //Log_Insert

            SqlParameter[] parms = new SqlParameter[]
 {
            new SqlParameter("@oldRecord", SqlDbType.VarChar, 255),
            new SqlParameter("@newRecord", SqlDbType.VarChar, 255),
            new SqlParameter("@operationType", SqlDbType.VarChar, 30),
            new SqlParameter("@ManagerId", SqlDbType.Int),
            new SqlParameter("@userName", SqlDbType.VarChar,50)
     //@userName

 };
            parms[0].Value = toInsert.OldRecord;
            parms[1].Value = toInsert.NewRecord;
            parms[2].Value = toInsert.Type;
            parms[3].Value = toInsert.ManagerID;
            parms[4].Value = toInsert.UserName;


            try
            {

                SqlHelper.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Log_Insert", parms);

            }
            catch
            {
                throw;
            }

        }

    }
}
