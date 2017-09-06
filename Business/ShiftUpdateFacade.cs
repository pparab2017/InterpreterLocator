using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;

namespace Business
{
   public static class ShiftUpdateFacade
    {
      public static void UpdateShifts(shift toUpdate, Log toAppend)
        {
            ShiftController.UpdateShift(toUpdate);
            LogController.LogInsert(toAppend);
        } 
    }
}
