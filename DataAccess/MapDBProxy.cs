using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;

namespace DataAccess
{
    public class MapDBProxy : AbstractMapDB
    {
        MapDB RealObj;
        String path;

        public override List<Map> GetAllMap()
        {
            if(RealObj == null)
            {
                RealObj = new MapDB();
               return RealObj.GetAllMap();
            }
            else
            {
                return new List<Map>();
            }
        }

        public override string getPathbySrcAndDestination(int src, int des)
        {
           if(path == null)
            {
                RealObj = new MapDB();
                return RealObj.getPathbySrcAndDestination(src, des);
            }
            else
            {
                return "";
            }
        }
    }
}
