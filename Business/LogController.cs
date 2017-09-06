using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using DataAccess;
namespace Business
{
   public class LogController
    {
        public static void LogInsert(Log toInsert)
        {
            LogDB.AppendLog( toInsert);
        }
    }
}
