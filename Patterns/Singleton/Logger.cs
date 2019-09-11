using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharp.Patterns.Singleton.ForMVCProject
{
    public class Logger
    {
        private static System.IO.StreamWriter _Output = null;
        private static Logger _Logger = null;
        private static Object _classLock = typeof(Logger);
        public static string _LogFile = @"C:\Users\Debendra\documents\visual studio 2015\Projects\SingleTon\SingleTon\LogDetails.log";
        public static int _LogLevel = 1;

        private Logger() {}

        public static Logger getInstance()
        {
            //lock object to make it thread safe  
            lock (_classLock)
            {
                if (_Logger == null)
                {
                    _Logger = new Logger();
                }
            }
            return _Logger;
        }

        public void logError(string s, int severity)
        {
            try
            {
                if (severity <= _LogLevel)
                {
                    if (_Output == null)
                    {
                        _Output = new System.IO.StreamWriter(_LogFile, true, System.Text.UnicodeEncoding.Default);
                    }

                    _Output.WriteLine(System.DateTime.Now + " | " + severity + " | " + s, new object[0]);

                    if (_Output != null)
                    {
                        _Output.Close();
                        _Output = null;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message, new object[0]);
            }
        }

        public static void closeLog()
        {
            try
            {
                if (_Output != null)
                {
                    _Output.Close();
                    _Output = null;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message, new object[0]);
            }
        }
    }

    public class Connection
    {
        SqlCommand cmd;
        DataSet ds;
        DataTable dt;
        SqlDataAdapter da;
        private static Connection obj = null;
        private static readonly object mylockobject = new object();
        public static Connection getInstance()
        {
            lock (mylockobject)
            {
                if (obj == null)
                {
                    obj = new Connection();
                }
            }
            return obj;
        }

        private Connection() { }
        public static SqlConnection connect()
        {
            string s = ConfigurationManager.ConnectionStrings["Connect"].ConnectionString;
            SqlConnection con = new SqlConnection(s);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            else
            {
                con.Close();
            }
            return con;
        }
        public DataTable Selectall(string query)
        {
            da = new SqlDataAdapter(query, Connection.connect());
            dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
        public bool DML(string query)
        {
            cmd = new SqlCommand(query, Connection.connect());
            int x = cmd.ExecuteNonQuery();
            if (x == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    public class Employee
    {
        public string Name { get; set; }
        public int RollNo { get; set; }
        public bool SaveData(Employee emp)
        {
            bool res = false;
            try
            {
                Connection obj = Connection.getInstance();

                res = obj.DML("insert into employee(Name,RollNo)values('" + emp.Name + "','" + emp.RollNo + "')");
                if (res == true)
                {
                    Console.WriteLine("Save Successfully.");
                }
                else
                {
                    Console.WriteLine("Data not saved please try again.");
                }
            }
            catch (Exception ex)
            {
                Logger obj = Logger.getInstance();
                obj.logError(ex.Message, 1);
            }
            return res;
        }
    }
}

