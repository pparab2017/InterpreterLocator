using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
    public enum EmplpyeeType
        {
        PCE =1 ,INTERPRETER =2,INTERPRETERMANAGER =3

    };

    public class Employee
    {
        private string _lastName;
        private string _firstName;
        private EmplpyeeType _employeeType;
        private int _employeId;
        private string _userName;
        private int _roomID;

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

        public EmplpyeeType EmployeeType
        {
            get
            {
                return _employeeType;
            }

            set
            {
                _employeeType = value;
            }
        }

        public string FullName
        {
            get
            {
                return _firstName + ", " +_lastName;
            }
        }

        public int EmployeId
        {
            get
            {
                return _employeId;
            }

            set
            {
                _employeId = value;
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

        public int RoomID
        {
            get
            {
                return _roomID;
            }

            set
            {
                _roomID = value;
            }
        }
    }
}
