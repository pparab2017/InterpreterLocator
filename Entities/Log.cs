using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
  public  class Log
    {
        private int _managerID;
        private string userName;
        string _oldRecord;
        string _newRecord;
        string _type;
        string _logID;

        public int ManagerID
        {
            get
            {
                return _managerID;
            }

            set
            {
                _managerID = value;
            }
        }

       

        public string OldRecord
        {
            get
            {
                return _oldRecord;
            }

            set
            {
                _oldRecord = value;
            }
        }

        public string NewRecord
        {
            get
            {
                return _newRecord;
            }

            set
            {
                _newRecord = value;
            }
        }

        public string Type
        {
            get
            {
                return _type;
            }

            set
            {
                _type = value;
            }
        }

        public string LogID
        {
            get
            {
                return _logID;
            }

            set
            {
                _logID = value;
            }
        }

        public string UserName
        {
            get
            {
                return userName;
            }

            set
            {
                userName = value;
            }
        }
    }
}
