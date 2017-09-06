using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
   public class Map
    {

        private int _mapID;
        private int _srcID;
        private int _dscID;
        private string _srcName;
        private string _dscName;
        private string _path;

        public int MapID
        {
            get
            {
                return _mapID;
            }

            set
            {
                _mapID = value;
            }
        }

        public int SrcID
        {
            get
            {
                return _srcID;
            }

            set
            {
                _srcID = value;
            }
        }

        public int DscID
        {
            get
            {
                return _dscID;
            }

            set
            {
                _dscID = value;
            }
        }

        public string SrcName
        {
            get
            {
                return _srcName;
            }

            set
            {
                _srcName = value;
            }
        }

        public string DscName
        {
            get
            {
                return _dscName;
            }

            set
            {
                _dscName = value;
            }
        }

        public string Path
        {
            get
            {
                return _path;
            }

            set
            {
                _path = value;
            }
        }
    }
}
