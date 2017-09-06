using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess;
using Entities;

namespace Business
{
    public static class ShiftController
    {
        public static void InsertShifts(List<shift> toInsert)
        {
            ShiftDB.InsertShifts(toInsert);
        }

        public static void UpdateShift(shift toUpdate)
        {
            ShiftDB.UpdateShiftById(toUpdate);
        }

        public static List<shift> getAllShifts()
        {
            return ShiftDB.getAllShift();
        }

        public static List<shift> getShiftByUserName(int id)
        {
            return ShiftDB.getShiftbyID(id);
        }
    }
}
