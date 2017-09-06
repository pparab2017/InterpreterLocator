using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
   public class shift
    {
        int _shiftID;
        String _ShiftName;
        DateTime _from;
        DateTime _to;

        string _dayName;
        bool _night;
        int _employeeID;
        String _userName;
        string _firstName;
        string _lastName;

        public int ShiftID
        {
            get
            {
                return _shiftID;
            }

            set
            {
                _shiftID = value;
            }
        }

        public string ShiftName
        {
            get
            {
                return _ShiftName;
            }

            set
            {
                _ShiftName = value;
            }
        }

        public DateTime From
        {
            get
            {
                return _from;
            }

            set
            {
                _from = value;
            }
        }

        public DateTime To
        {
            get
            {
                return _to;
            }

            set
            {
                _to = value;
            }
        }

        public string DayName
        {
            get
            {
                return _dayName;
            }

            set
            {
                _dayName = value;
            }
        }

        public bool Night
        {
            get
            {
                return _night;
            }

            set
            {
                _night = value;
            }
        }

        public int EmployeeID
        {
            get
            {
                return _employeeID;
            }

            set
            {
                _employeeID = value;
            }
        }

        public string UserName
        {
            get
            {
                return _userName;
            }

            set
            {
                _userName = value;
            }
        }

        public string FirstName
        {
            get
            {
                return _firstName;
            }

            set
            {
                _firstName = value;
            }
        }

        public string LastName
        {
            get
            {
                return _lastName;
            }

            set
            {
                _lastName = value;
            }
        }
    }
}
