using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;

namespace Business
{
    public static class MapController
    {

        public static List<Map> GetAllMap()
        {
            MapDBProxy toCall = new MapDBProxy();


            return toCall.GetAllMap();
        }
        
        public static string GetMap(int src, int des)
        {
            MapDBProxy toCall = new MapDBProxy();
            return toCall.getPathbySrcAndDestination(src, des);
        }
    }
}
