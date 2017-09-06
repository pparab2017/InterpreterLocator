using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess;
using Entities;

namespace Business
{
   public static class InterpreterController
    {
        public static List<Employee> GetInterpreterList()
        {
            return EmmployeeDB.GetInterpreterList();
        }
    }
}
