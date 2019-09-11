using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharp.Patterns.Singleton
{
    class Toyota
    {
        private Toyota() {}
        public static Toyota obj;
        private static readonly object mylockobject = new object();
        public static Toyota GetInstance()
        {
            lock (mylockobject)
            {
                if (obj == null)
                {
                    obj = new Toyota();
                }
            }
            return obj;
        }
        public string getDetails()
        {
            return "India";
        }

        static void Test()
        {
            Toyota toy = Toyota.GetInstance();
            Toyota toy1 = Toyota.GetInstance();
            string x = toy.getDetails();
            Console.WriteLine(x);
            Console.ReadLine();
        }
    }
}