using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;

namespace DataAccess
{
    public abstract  class AbstractMapDB
    {
        public  abstract string getPathbySrcAndDestination(int src, int des);
        public  abstract List<Map> GetAllMap();
    }
}
