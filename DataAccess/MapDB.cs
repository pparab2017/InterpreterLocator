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
   public class MapDB : AbstractMapDB
    {

        

        public override string getPathbySrcAndDestination(int src, int des)
        {
            string toReturn = "";

            SqlParameter[] parms = new SqlParameter[]
      {
                new SqlParameter("@src", SqlDbType.Int),
                new SqlParameter("@des", SqlDbType.Int)

      };
            parms[0].Value = src;
            parms[1].Value = des;
            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Get_Map", parms))
                {
                    while (rdr.Read())
                    {
                        toReturn = rdr.GetString(0);
                    }
                }
            }
            catch
            {
                throw;
            }
            return toReturn;
        }

        public override List<Map> GetAllMap()
        {
            List<Map> toReturn = new List<Map>();
            try
            {

                using (SqlDataReader rdr = SqlHelper.ExecuteReader(ConfigurationManager.ConnectionStrings["interpreterLocator"].ConnectionString, CommandType.StoredProcedure, "Map_get_all_map"))
                {
                    while (rdr.Read())
                    {
                        Map toAdd = new Map();
                        toAdd.MapID = rdr.GetInt32(0);
                        toAdd.SrcID = rdr.GetInt32(1);
                        toAdd.DscID = rdr.GetInt32(2);
                        toAdd.Path = rdr.GetString(3);
                        toAdd.SrcName = rdr.GetString(4);
                        toAdd.DscName = rdr.GetString(5);

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
