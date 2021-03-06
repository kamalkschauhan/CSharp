﻿using DecoratorPattern;
using Microsoft.CSharp;
using Newtonsoft.Json;
using System;
using System.CodeDom.Compiler;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using CSharp.RepositoryPattern;
using System.Threading.Tasks;

// testing once more 

namespace CSharp
{
    //S – Single Responsibility Principle : It says that There should never be more than one reason for a class to change.
    //O – Open/Closed Principle : It says that Classes should be open for extension, but closed for modification.
    //L – Liskov’s Substitution Principle : Derived types must be completely substitutable for their base types.
    //I – Interface Segregation Principle :  Client should not be forced to implement interfaces they don’t use.
    //D – Dependency Inversion Principle : It says that
    //    High-level modules should not depend on low-level modules. Both should depend on abstractions.
    //    Abstractions should not depend on details. Details should depend on abstractions.



    //Enums

    //1.The enum keyword is used to declare an enumeration 
    //2.Enum represents a set of Named constants, hence we can't change the values associated with enums.
    //3.Enum will be having an underlying type as Integral Type. (Except Char)
    //4.The default underlying type of the enumeration elements is int.
    //5.By default, the first enumerator has the value 0, and the value of each successive enumerator is increased by 1
    //6.Enums are value types
    //7.Enumerations(enums) make your code much more readable and understandable.
    //8.We can declare Enum either in a class or outside of a class as well.
    //9.Enum cannot inherit from other Enum.

    //Note:Double and Float are not Integral types but they are Floatingpoint types I hope this points are enough for understanding Enums. 

    //Structs

    //0.Struct is just like class but is light weight and faster.
    //1.Within a struct declaration, fields cannot be initialized unless they are declared as const or static. 
    //2.A struct cannot declare a default constructor(a constructor without parameters) or a destructor, since copies of structs are created and destroyed automatically by the JIT compiler.Struct can contain only parameterized Constructors.
    //3.Structs are value types and classes are reference types.
    //4.All structs inherit directly from System.ValueType, which inherits from System.Object.
    //5.We can directly intialize the const or static fields in the Struct.
    //6.we can implement interfaces in structs but we cannot inherit a struct from other struct or class.
    //7.Structs are By Default sealed. 
    //8.Value types are faster than ref types.
    //9.Most of the Primitive types in .NET are Structs.
    //10.Better to declare a struct instead of a class when the Total size of all fields is less
    //    than 16 bytes(this is not a rule ). 

    interface IBird
    {
        void PositionIt();
        void SetLocation(double longitude, double latitude);
    };

    interface IFlightfulBird : IBird
    {
        void SetAltitude(double altitude);
    };

    public class Cockatoo : IFlightfulBird 
    {
        public void PositionIt() { }
        public void SetLocation(double longitude, double latitude) { }
        public void SetAltitude(double altitude) { }
    }

    public class Penguin : IBird
    {
        public void PositionIt() { }
        public void SetLocation(double longitude, double latitude) { }
    }

    public interface ILogger { void Log(); }
    public class DBLogger : ILogger
    {
        public void Log() { }
    }
    public class XMLLogger : ILogger
    {
        public void Log() { }
    }
    public class TextLogger : ILogger
    {
        public void Log() { }
    }
    public class OCP
    {
        ILogger _logger;
        public OCP(ILogger logger)
        {
            this._logger = logger;
        }
        public void LogErrors()
        {
            _logger.Log();
        }
    }

    interface IOrganization
    {
        void HireMembers();
        void GetProjects();
        void ExecuteProjects();
    }
    interface IHRFunctions { void HireMembers(); }
    interface IBDFunctions { void GetProjects(); }
    interface IDevelopmentFunctions { void ExecuteProjects(); }

    public class HRTeam : IHRFunctions //IOrganization
    {
        public void HireMembers() { }
        //public void GetProjects() { }
        //public void ExecuteProjects() { }
    }

    public class BusinessDevelopment : IBDFunctions //IOrganization
    {
        //public void HireMembers() { }
        public void GetProjects() { }
        //public void ExecuteProjects() { }
    }

    public class DevelopmentTeam : IDevelopmentFunctions //IOrganization
    {
        //public void HireMembers() { }
        //public void GetProjects() { }
        public void ExecuteProjects() { }
    }
    //SRP
    public class SRPViolation
    {
        public void SaveUser(object objUser) { }
        public void SendEmail(object objEmail) { }
    }
    public class ManageUser
    {
        public void SaveUser(object objUser) { }
    }
    public class EmailService
    {
        public void SendEmail(object objEmail) { }
    }


    interface ICommon
    {
        //Interfaces cannot contain fields
        //int i;

        //The modifier 'public' is not valid for this item
        //public int getCommon();

        //The modifier 'static' is not valid for this item
        //static int getCommon();

        int GetCommon();
        int Target { get; set; }
    }
    interface ICommonImplement : ICommon { }

    struct MyData : ICommon
    {
        internal double pi;
        internal int iters;

        //public MyData(int i) {}
        //public MyData() {} //Structs cannot contain explicit parameterless constructors.

        public int GetCommon()
        {
            return 1;
        }

        public int Target { get; set; }
    }

    public class PrivateInterface
    {
        private interface InnerInterface
        {
            void f();
        }

        public class InnerClass1 : InnerInterface
        {
            public void f()
            {
                Console.WriteLine("From InnerClass1");
            }
        }

        public class InnerClass2 : InnerInterface
        {
            public void f()
            {
                Console.WriteLine("From InnerClass2");
            }
        }

    }

    class Token
    {
        public int GetI { get; set; }
        public virtual string Display() { return "Token"; }
    }
    class IdentifierToken : Token
    {
        public new string Display()
        {
            return "IdentifierToken";
        }
    }
    class SingleToken : Token
    {
        public override string Display()
        {
            return "SingleToken";
        }
        public int Display1(int i)
        {
            return 0;
        }
        public string Display1(string i)
        {
            return "0";
        }
        public string Join(string s, int i) { return string.Empty; }
        public string Join(int i, string s) { return string.Empty; }
        //'CSharp.SingleToken' already defines a member called 'Join' with the same parameter types
        //public int Join(int i, string s) { return 0; }
    }
    class MultipleToken : Token
    {
        private static int iObjCounter = 0;
        static MultipleToken()
        {
            iObjCounter++;
            Console.WriteLine(iObjCounter.ToString() + " - static constructor of MultipleToken called.");
        }
        public static string Display()
        {
            return "MultipleToken";
        }
        //public override string Display()
        //{
        //    return "MultipleToken";
        //}
    }

    class ABC : ICommonImplement
    {
        int j;
        static int i;
        const int s = 15;
        static readonly int t = 15;

        static ABC()
        {
            Console.WriteLine("static constructor called. i = " + i);

            //Console.WriteLine("Static constructor called. j = " + j); 
            //Can't access non-static member from static
        }
        public ABC()
        {
            Console.WriteLine("public constructor called. i = " + i);

            //Console.WriteLine("Static constructor called. j = " + j); 
            //Can't access non-static member from static
        }
        public ABC(string strMessage)
        {
            Console.WriteLine("instance constructor called. strMessage = " + strMessage);
        }
        public int Target { get; set; }
        public static void TimePass() {}
        public int GetCommon()
        {
            //static int j; // Can't have static fields defined in method scope
            //int j;        // Can't use 'j' if it is declared in method scope but not initialized
            // If 'j' is not referenced at all in the method, the program compiles 
            // without any error.

            Console.WriteLine("getCommon(). i = " + i);
            Console.WriteLine("getCommon(). j = " + j / 10);

            CultureInfo ci = System.Threading.Thread.CurrentThread.CurrentCulture;
            Console.WriteLine("CultureInfo = " + ci);

            Type t = typeof(int);
            Console.Out.WriteLine("Type t = typeof(int); = " + t.ToString());
            Console.Out.WriteLine("sizeof(int).ToString() = " + sizeof(int).ToString() + " bytes");
            //Console.In.Read();

            return i;
        }
    }
    public class myReverserClass : IComparer
    {
        // Calls CaseInsensitiveComparer.Compare with the parameters reversed.
        int IComparer.Compare(Object x, Object y)
        {
            return ((new CaseInsensitiveComparer()).Compare(y, x));
        }
    }

    class ThreadingExperiment
    {
        static BackgroundWorker bw;

        public ThreadingExperiment()
        {
            bw = new BackgroundWorker();
            bw.WorkerReportsProgress = true;
            bw.WorkerSupportsCancellation = true;
            bw.DoWork += bw_DoWork;
            bw.ProgressChanged += bw_ProgressChanged;
            bw.RunWorkerCompleted += bw_RunWorkerCompleted;

            bw.RunWorkerAsync("Hello to worker");
            Console.WriteLine("Press Enter in the next 5 seconds to cancel");
            Console.ReadLine();
            if (bw.IsBusy)
                bw.CancelAsync();
            //Console.ReadLine();
        }

        static void bw_DoWork(object sender, DoWorkEventArgs e)
        {
            Console.WriteLine(e.Argument);
            for (int i = 0; i <= 100; i += 20)
            {
                if (bw.CancellationPending)
                {
                    e.Cancel = true;
                    return;
                }
                bw.ReportProgress(i);
                Thread.Sleep(1000);
            }
            e.Result = 123;    // This gets passed to RunWorkerCompleted
        }

        static void bw_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if (e.Cancelled)
                Console.WriteLine("You cancelled!");
            else if (e.Error != null)
                Console.WriteLine("Worker exception: " + e.Error.ToString());
            else
                Console.WriteLine("Complete - " + e.Result);      // from DoWork
        }

        static void bw_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            Console.WriteLine("Reached " + e.ProgressPercentage + "%");
        }
    }

    class ThreadingExperiment2
    {
        private AutoResetEvent[] arEvent;

        public void StartExecution()
        {
            WaitCallback wcTakeYourTime = new WaitCallback(TakeYourTime);
            arEvent = new AutoResetEvent[1];
            arEvent[0] = new AutoResetEvent(false); //non-signalled/reset state/closed door
            string strMessage = " from StartExecution()";
            ThreadPool.QueueUserWorkItem(wcTakeYourTime, ((object)strMessage));

            WaitHandle.WaitAll(arEvent, 15000, true);
        }

        private void TakeYourTime(object strMessage)
        {
            Console.WriteLine("Hello : " + (string)strMessage);

            for (int i = 0; i <= 200; i += 20)
            {
                Console.WriteLine("Reached : " + i.ToString() + "% complete");
                Thread.Sleep(1000);
            }
            arEvent[0].Set();
        }
    }

    class Foo
    {
        public Foo(string s)
        {
            Console.WriteLine("Foo constructor: {0}", s);
        }
        public void Bar() {}
    }
    class Base
    {
        readonly Foo baseFoo = new Foo("Base initializer");
        public Base()
        {
            Console.WriteLine("Base constructor");
        }
    }
    class Derived : Base
    {
        readonly Foo derivedFoo = new Foo("Derived initializer");
        static int i;
        static DateTime dt;
        static string str;

        public Derived()
        {
            Console.WriteLine("Derived constructor");
            Console.WriteLine("");
            Console.WriteLine("");
            Console.WriteLine("/// Start : undefined static fields test");
            Console.WriteLine("static int i : " + i);
            Console.WriteLine("static DateTime dt : " + dt);
            Console.WriteLine("static string str : " + str);
            Console.WriteLine("/// End   : undefined static fields test");
            Console.WriteLine("");
            Console.WriteLine("");
        }
    }

    abstract class AbstractTest
    {

    }

    abstract class Foo2
    {
        static bool bYay = false;
        
        public abstract bool Yay();
        static bool Boo()
        {
            Console.WriteLine("Derived constructor");
            Console.WriteLine("");
            return bYay;
        }
    }
    class Bar : Foo2
    {
        public override bool Yay()
        {
            return true;
        }
    }

    //System.Core.dll required for implementing Extension methods. 
    //it needs to be added in the reference 
    //all helper methods in MVC and the Linq operations are extension methods.

    public static class MyExtensions
    {
        public static int WordCount(this String str)
        {
            Console.WriteLine("Inside extension methods:");
            return str.Split(new char[] { ' ', '.', '?' },
                             StringSplitOptions.RemoveEmptyEntries).Length;
        }
    }

    /// <summary>
    //  class InheritFromStatic : MyExtensions {}
    // 1. static class 'MyExtensions' is Sealed and cannot be inherited from but can be instantiated.
    //  static class MyExtensions : ICommonImplements1
    // 2. cannot inherit from any class/interface except Object
    // 3. Contains only static members.
    // 4. Cannot be instantiated hence cannot contain Instance Constructors.
    // 5. may or may not have static constructor
    // 6. static class examples .. System.Math 
    /// </summary>

    class GenericsTest
    {
        public T Test<T>(T t)
        {
            return t;
        }
    }

    /// <summary>
    /// START : private constructor in a class
    /// </summary>
    class MyClass
    {
        private MyClass() { }
        public static MyClass GetInstance() { return new MyClass(); }
    }
    class Counter
    {
        private Counter() { }
        public static int currentCount;
        public static int IncrementCount()
        {
            return ++currentCount;
        }
    }
    /// <summary>
    /// END : private constructor in a class
    /// </summary>

    class SimpleDummyClass
    {
        public SimpleDummyClass()
        {
            Console.WriteLine("/// Start : Inside SimpleDummyClass via Generics");
        }
    }

    class Program
    {
        static int i;
        public static int result;
        public static volatile bool finished;

        static void Thread2()
        {
            result = 143;
            finished = true;
        }

        public static IEnumerable Power(int number, int exponent)
        {
            int counter = 0;
            int result = 1;
            while (counter++ < exponent)
            {
                result = result * number;
                //use of yield keyword
                yield return result;
            }
        }

        public static void PrintIndexAndValues(IEnumerable myList)
        {
            //When you write :
            //foreach (Foo bar in baz) {}
            //it's functionally equivalent to writing:
            //IEnumerator bat = baz.GetEnumerator();
            //while (bat.MoveNext())
            //{
            //    bar = (Foo)bat.Current
            //    ...
            //}
            //By "functionally equivalent," I mean that's actually what the compiler turns the code into. 
            //You can't use foreach on baz in this example unless baz implements IEnumerable. IEnumerable 
            //means that baz implements the method
            //IEnumerator GetEnumerator()
            //The IEnumerator object that this method returns must implement the methods
            //bool MoveNext(), void Reset() and object Current()

            int i = 0;
            System.Collections.IEnumerator myEnumerator = myList.GetEnumerator();
            while (myEnumerator.MoveNext())
                Console.WriteLine("\t[{0}]:\t{1}", i++, myEnumerator.Current);
            Console.WriteLine();
        }

        class ColorChoice
        {
            public static readonly Color MyColor;
            string str = "non-static string.";
            static string str2 = "static string2.";

            //1. executed only once, unlike the normal constructor executing with each object creation
            //2. only 1 Static Constructor can exist
            //3. it can't take any parameters.
            //4. static methods can be overloaded but not overridden, as they belong to the class, 
            //   and not to any instance of the class
            //5. field cannot be declared as "static const" as "const" is essentially static 
            //6. static variables within a method scope are not supported.
            static ColorChoice()
            {
                DateTime currentDate = DateTime.Now;

                if (currentDate.DayOfWeek == DayOfWeek.Saturday || currentDate.DayOfWeek == DayOfWeek.Sunday)
                    MyColor = Color.Blue;
                else
                    MyColor = Color.Black;
            }

            public ColorChoice() { }

            static void Drive() {
                Console.WriteLine("static method \"Drive();\" ");
            }

            void PickUp() { 
                Console.WriteLine("non static method \"PickUp();\" ");
            }

            public static void DriveFast()
            {
                Console.WriteLine("calling non statics members from static");
                (new ColorChoice()).PickUp();
                Console.WriteLine((new ColorChoice()).str);
            }

            public void PickUpLate()
            {
                Console.WriteLine("calling static method from non static");
                Console.WriteLine(str2);
                Drive();
            }
        }

        class SecondColorChoice : ColorChoice
        {
            public static readonly Color MySecondColor;
            static SecondColorChoice()
            {
                DateTime currentDate = DateTime.Now;

                if (currentDate.DayOfWeek == DayOfWeek.Friday)
                    MySecondColor = Color.Yellow;
                else
                    MySecondColor = Color.Red;
            }
        }

        public static void UseParams(params int[] list)
        {
            Console.WriteLine("Use of \"params\" keyword");
            for (int i = 0; i < list.Length; i++)
            {
                Console.WriteLine(list[i]);
            }
        }

        public static string ReverseString(string s)
        {
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }

        //cannot derive from sealed type 'string' or 'StringBuilder'
        //public class testabc : String 
        //{ public testabc() {} }
        //Extension methods enable you to "add" methods to existing types without 
        //creating a new derived type
        //refer MyExtensions

        static string CaesarEncrypt(string value, int shift)
        {
            char[] buffer = value.ToCharArray();
            for (int i = 0; i < buffer.Length; i++)
            {
                // Letter.
                char letter = buffer[i];
                // Add shift to all.
                letter = (char)(letter + shift);
                // Subtract 26 on overflow.
                if (letter > 'z')
                {
                    letter = (char)(letter - 26);
                }
                // Add 26 on underflow.
                else if (letter < 'a')
                {
                    letter = (char)(letter + 26);
                }
                // Store.
                buffer[i] = letter;
            }
            return new string(buffer);
        }

        private static void PrintProductDetails(BakeryComponent product)
        {
            Console.WriteLine(); // some whitespace for readability
            Console.WriteLine("Item: {0}, Price: {1}", product.GetName(), product.GetPrice());
        }

        static void ExecuteDecorator()
        {
            // Let us create a Simple Cake Base first
            CakeBase cBase = new CakeBase();
            PrintProductDetails(cBase);

            // Lets add cream to the cake
            CreamDecorator creamCake = new CreamDecorator(cBase);
            PrintProductDetails(creamCake);

            // Let now add a Cherry on it
            CherryDecorator cherryCake = new CherryDecorator(creamCake);
            PrintProductDetails(cherryCake);

            // Lets now add Scent to it
            ArtificialScentDecorator scentedCake = new ArtificialScentDecorator(cherryCake);
            PrintProductDetails(scentedCake);

            // Finally add a Name card on the cake
            NameCardDecorator nameCardOnCake = new NameCardDecorator(scentedCake);
            PrintProductDetails(nameCardOnCake);

            // Lets now create a simple Pastry
            PastryBase pastry = new PastryBase();
            PrintProductDetails(pastry);

            // Lets just add cream and cherry only on the pastry 
            CreamDecorator creamPastry = new CreamDecorator(pastry);
            CherryDecorator cherryPastry = new CherryDecorator(creamPastry);
            PrintProductDetails(cherryPastry);
        }

        public delegate void MathOperations(int x, int y);

        public static void Add(int x, int y)
        {
            Console.WriteLine("Executed by Delegate:{0,4:N0}", x + y);
        }

        public static void Subtract(int x, int y)
        {
            Console.WriteLine("Executed by Delegate:{0,2:N0}", x - y);
        }

        public static void Multiply(int x, int y)
        {
            Console.WriteLine("Executed by Delegate:{0,2:N0}", x * y);
        }

        public static void Divide(int x, int y)
        {
            Console.WriteLine("Executed by Delegate:{0,3:N0}", x / y);
        }

        public static List<T> GetListFromDataTable<T>(
            ArrayList arrayList, 
            string tableName, 
            string columnName
            //,string jsonData
            )
        {
            //// Find out how many rows are in your table and create an aray of that length
            List<T> values = new List<T>();
            
            // Loop through the table and row and add them into the array
            foreach (object obj in arrayList)
            {
                values.Add((T)obj);
            }

            //var job = JsonConvert.DeserializeObject<T>(jsonData);
            //foreach (var item in job.Value)
            //{
            //    values.Add((T)item);
            //        //lstjob.Add(item);
            //}

            return values;
        }

        public async Task MyMethodAsync()
        {
            Task<int> longRunningTask = LongRunningOperationAsync();
            // independent work which doesn't need the result of LongRunningOperationAsync can be done here

            //and now we call await on the task 
            int result = await longRunningTask;
            //use the result 
            Console.WriteLine(result);
        }

        public async Task<int> LongRunningOperationAsync() // assume we return an int from this long running operation 
        {
            await Task.Delay(1000); // 1 second delay
            return 1;
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            // Call the method that runs asynchronously.
            string result = await WaitAsynchronouslyAsync();

            // Call the method that runs synchronously.
            //string result = await WaitSynchronously ();

            // Display the result.
            result += result;
        }

        // The following method runs asynchronously. The UI thread is not
        // blocked during the delay. You can move or resize the Form1 window 
        // while Task.Delay is running.
        public async Task<string> WaitAsynchronouslyAsync()
        {
            await Task.Delay(10000);
            return "Finished";
        }

        // The following method runs synchronously, despite the use of async.
        // You cannot move or resize the Form1 window while Thread.Sleep
        // is running because the UI thread is blocked.
        public async Task<string> WaitSynchronously()
        {
            // Add a using directive for System.Threading.
            Thread.Sleep(10000);
            return "Finished";
        }

        public int Solution(int[] A)
        {

            Console.WriteLine(string.Join(",", A));
            Console.WriteLine("");
            Console.WriteLine(string.Join(",", A.Where(i => i >= 1).ToArray()));
            Console.WriteLine("");
            //return 6;
            // write your code in C# 6.0 with .NET 4.5 (Mono)
            int[] nonNegative = A.Where(i => i >= 1).ToArray();
            if (nonNegative.Length == 0)
                return 1;
            Array.Sort(nonNegative);

            //foreach (int i in nonNegative)
            //{
            //    Console.Write(i + ", ");
            //}
            Console.WriteLine(string.Join(",", nonNegative));

            //Console.WriteLine(string.Join(",", A));
            Console.WriteLine("");
            
            int firstInt = ++nonNegative[0];
            for (int w = 0; w < nonNegative.Length; w++, firstInt++)
            {
                //Console.Write(firstInt + ", ");
                //Console.WriteLine("");
                //Console.Write("A.Contains(firstInt) : " + nonNegative.Contains(firstInt));
                //Console.WriteLine("");
                if (!nonNegative.Contains(firstInt))
                {
                    break;
                }
            }

            return firstInt;
            //return 6;
        }

        public int ReportingSoldiersCount(int[] ranks)
        {
            int _iLength = ranks.Length;
            Array.Sort(ranks);
            int _reportingSoldiers = 0;
            int i = 0;

            //int next_superior_reporting = 0;
            foreach (int rank in ranks)
            {
                int upper = rank + 1;
                if (ranks.Contains(upper))
                {
                    if (i <= _iLength)
                    {
                        _reportingSoldiers = _reportingSoldiers + 1;
                    }
                }
                i++;
            }
            return _reportingSoldiers;
        }

        [STAThread]
        public static void Main()
        {
            ///
            /// Start : Generics test
            /// 

            GenericsTest c1 = new GenericsTest();
            string ret1 = c1.Test<string>("mastan");
            int ret2 = c1.Test<int>(10);
            SimpleDummyClass myc = c1.Test<SimpleDummyClass>(new SimpleDummyClass());
            List<GenericsTest> Lmyc = c1.Test<List<GenericsTest>>(new List<GenericsTest>());
            string jsonString = @"{
              'Email': 'james@example.com',
              'Active': true,
              'CreatedDate': '2013-01-20T00:00:00Z',
              'Roles': [
                'User',
                'Admin'
              ]
            }";

            //var objDynamic = (List<GenericsTest>)JsonConvert.DeserializeObject<object>(jsonString);
            //"Unable to cast object of type 'Newtonsoft.Json.Linq.JObject' to type 'System.Collections.Generic.List`1[CSharp.GenericsTest]'.";

            ArrayList arrayList = new ArrayList();
            arrayList.Add(new object());
            //List<string> lstName = GetListFromDataTable<string>(arrayList, "Products", "ProductName");
            //List<string> lstCategory = GetListFromDataTable<string>(arrayList, "Products", "Category");
            //List<int> lstCost = GetListFromDataTable<int>(arrayList, "Products", "Cost");
            //List<Guid> lstId = GetListFromDataTable<Guid>(arrayList, "Products", "Id");
            //List<GenericsTest> lstIds = GetListFromDataTable<GenericsTest>(arrayList, "Products", "Id");

            Console.WriteLine("");

            ///
            /// End : Generics test
            ///

            ///
            /// Start : int array test
            ///
            Console.WriteLine("/// Start : int array test");
            Console.WriteLine("");
            Program objProgram2 = new Program();
            Console.WriteLine("missing int : " + objProgram2.Solution(new int[] { -32, 11, -14, 23, 28, 19, -5, 6, 8, 10 }));
            Console.WriteLine("");
            Console.WriteLine("missing int : " + objProgram2.Solution(new int[] { 9, 0, 1, 2, 5, 4, 5, 6, 8, 10 }));
            Console.WriteLine("");
            Console.WriteLine("missing int : " + objProgram2.Solution(new int[] { 12, 1, 1, 2, 3, 4, 5, 6, -8, 9 }));
            Console.WriteLine("");
            Console.WriteLine("missing int : " + objProgram2.Solution(new int[] { -1, -3, -1, -3, -1, -3, -1, -3, -1, -3}));
            Console.WriteLine("");
            Console.WriteLine("missing int : " + objProgram2.Solution(new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }));
            Console.WriteLine("");
            Console.WriteLine("/// End   : int array test");
            Console.WriteLine("");
            Console.WriteLine("");

            Console.WriteLine("Reporting soldiers : "
                + objProgram2.ReportingSoldiersCount(new int[] { 3, 4, 3, 0, 2, 2, 3, 0, 0 }));
            Console.WriteLine("Reporting soldiers : "
                + objProgram2.ReportingSoldiersCount(new int[] { 11, 10, 10, 10, 10, 8, 8, 7, 6, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 1, 0 }));
            Console.WriteLine("Reporting soldiers : "
                + objProgram2.ReportingSoldiersCount(new int[] { 4, 3, 1, 0, 0, 0 }));

            Console.WriteLine("Reporting soldiers : "
                + objProgram2.ReportingSoldiersCount(new int[] { 4, 2, 0 }));

            Console.WriteLine("Reporting soldiers : "
                + objProgram2.ReportingSoldiersCount(new int[] { -2, -8, -3 }));

            Console.WriteLine("");
            Console.WriteLine("");
            Console.ReadLine();
            //return;
            ///
            /// End : int array test
            ///

            ///
            /// Start : asyn & wait testing
            ///
            Console.WriteLine("");
            Console.WriteLine("/// Start : asyn & wait testing");
            Program objProgram = new Program();
            objProgram.MyMethodAsync().Wait();
            Console.WriteLine("/// End   : asyn & wait testing");
            Console.WriteLine("");
            ///
            /// End : asyn & wait testing
            ///


            ///
            /// Start : Execute Decorator Pattern
            ///

            Console.WriteLine("/// Start : Execute Decorator Pattern");
            Console.WriteLine("");
            ExecuteDecorator();
            Console.WriteLine("");
            Console.WriteLine("/// End   : Execute Decorator Pattern");
            Console.WriteLine("");

            ///
            /// End   : Execute Decorator Pattern
            ///

            Derived objDerived = new Derived();
            Console.WriteLine("");
            UseParams(4, 88);
            Console.WriteLine("");
            ABC objABC = new ABC();

            //factory with dependency injection
            OCP objOCP = new OCP(new TextLogger());
            objOCP.LogErrors();

            Console.WriteLine("Hello Extension Methods : " + "Hello Extension Methods".WordCount().ToString());
            Console.WriteLine("");
            Console.WriteLine("test reverse : " + ReverseString("test reverse"));
            Console.WriteLine("");

            string strDecr = "quick"; //"nrfzh"

            Console.WriteLine("\"quick\".Split(new char[] {}).Length : " + strDecr.Split(default(string[]), StringSplitOptions.None).Length);
            Console.WriteLine("\"quick\".Split(new char[] {}).Length : " + strDecr.Split(new char[] { }).Length);
            //to be demystified.....as it was working in earlier framework
            //Console.WriteLine("\"quick\".Select(x => x.ToString()).ToArray().Length : " + strDecr.Select(x => x.ToString()).ToArray().Length);
            Console.WriteLine("Regex.Split(\"quick\", string.Empty).Length : " + Regex.Split(strDecr, string.Empty).Length);

            Console.WriteLine("");
            Console.WriteLine("CaesarEncrypt(\"quick\", -3) : " + CaesarEncrypt(strDecr, -3)); 
            //               -3,-2,-1, 0
            //"nrfzh" as in ..n, o, p, q
            Console.WriteLine("CaesarEncrypt(\"nrfzh\", 3) : " + CaesarEncrypt(CaesarEncrypt(strDecr, -3), 3));

            Console.WriteLine("");
            Console.WriteLine("(\"a\" + 3) : " + ("a" + 3));
            Console.WriteLine("('a') : " + ('a'));
            Console.WriteLine("(int)'a' : " + (int)'a');
            Console.WriteLine("Encoding.ASCII.GetBytes(\"a\") : " + Encoding.ASCII.GetBytes("a")[0]);
            Console.WriteLine("('a' + 3) : " + ('a' + 3));
            Console.WriteLine("(char)('a' + 3) : " + (char)('a' + 3));
            Console.WriteLine("");

            Console.WriteLine("");

            ABC objABC2 = new ABC("Hello");
            ABC.TimePass();
            objABC.GetCommon();
            
            //1. Hashtable threadsafe but Dictionary not.
            //2. Dictionary strongly typed hence fast but Hashtable weakly typed (needs boxing and unboxing), hence slow.
            //3. dictionary throws 'KeyNotFoundException' on missing key retrieval but Hashtable returns null value.
            //4. hashtable maintains No order of entries but dictionary maintains the order.
            //5. Dictionary relies on chaining whereas Hashtable relies on rehashing.
            Hashtable numbers = new Hashtable();
            numbers.Add(1, "one");
            numbers.Add(2, "two");
            numbers.Add(3, "three");
            numbers.Add(4, "four");
            numbers.Add(5, "five");

            Console.WriteLine("Hello Extension Methods : " + "Hello Extension Methods".WordCount().ToString());
            Console.WriteLine("");
            Console.WriteLine("Hashtable : ");
            foreach (DictionaryEntry num in numbers)
            {
                Console.WriteLine(num.Key + "   -   " + num.Value);
            }
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(1, "one");
            dictionary.Add(2, "two");
            dictionary.Add(3, "three");
            dictionary.Add(4, "four");
            dictionary.Add(5, "five");

            StringBuilder sb1 = new StringBuilder("Asp.Net");
            StringBuilder sb2 = new StringBuilder("Asp.Net");

            int a = 10;
            int b = 10;

            Console.WriteLine("int a = 10;");
            Console.WriteLine("int b = 10;");
            Console.WriteLine("StringBuilder sb1 = new StringBuilder(\"Asp.Net\");");
            Console.WriteLine("StringBuilder sb2 = new StringBuilder(\"Asp.Net\");");
            
            Console.WriteLine("a == b : " + (a == b));
            Console.WriteLine("a.Equals(b) : " + (a.Equals(b)));

            Console.WriteLine("sb1 == sb2 : " + (sb1 == sb2));
            Console.WriteLine("sb1.Equals(sb2) : " + (sb1.Equals(sb2)));

            String str0 = "hello";
            String str2 = str0;
            String str3 = "hello";
            Console.WriteLine("str0 : " + str0);
            Console.WriteLine("str2 = str0 : " + str2);
            Console.WriteLine("str3 : " + str3);
            Console.WriteLine("str0 == str3 : " + (str0 == str3));
            Console.WriteLine("str0.Equals(str3) : " + str0.Equals(str3));
            Console.WriteLine("str0 == str2 : " + (str0 == str2));
            Console.WriteLine("str0.Equals(str2) : " + str0.Equals(str2));

            Console.WriteLine("Dictionary : ");
            foreach (KeyValuePair<int, string> pair in dictionary)
            {
                Console.WriteLine(pair.Key + "   -   " + pair.Value);
            }
            //t = t + 1;
            //k = k + 6;
            int t = 10;
            int k = t++;
            // value types are always copied by value.

            Console.WriteLine("");
            Console.WriteLine("t : " + t); //11
            Console.WriteLine("k : " + k); //10
            int r = ++k; //r = 11 
            //int r = k++; //r = 10 
            Console.WriteLine("k : " + k); //10
            Console.WriteLine("r : " + r); //10
            Console.WriteLine("");
            Console.WriteLine("r = " + r); //11
            Console.WriteLine("r++ : r : ++r = " + r++ + " : " + r + " : " + ++r); //11 : 12 : 13
            Console.WriteLine("r++ + ++r = " + (r++ + ++r)); //13 + 15
            Console.WriteLine("r = " + r); //15
            //ICommon igt = new ICommon();//Cannot create an instance of the abstract class or interface
            ICommon igt = new MyData();
            Bar bar = new Bar();
            //Console.Beep(5000, 2000);
            IdentifierToken objIdentifierToken = new IdentifierToken();
            Console.WriteLine();
            ThreadingExperiment objThreadingExperiment = new ThreadingExperiment();

            Console.WriteLine("use of yield keyword");
            foreach (int j in Power(2, 8))
            {
                Console.Write("{0} ", j);
            }
            Console.WriteLine();
            // Calling the Static Constructor of the Class
            //and Show the Result in the Console Window  
            Console.WriteLine("My Color Choice is:" + ColorChoice.MyColor.ToString());
            ColorChoice.DriveFast();
            ColorChoice cc = new ColorChoice();
            cc.PickUpLate();
            Console.ReadKey();


            //var vs dynamic
            /*
             * 1. var is a statically typed and results in a strongly typed when inferred at compile time 
             * / dynamic are dynamically typed and the type is inferred at run-time.
             * 2. var: to be initialized at declaration / dynamic: need not.
             * 3. var: the variable type cannot be changed after it is assigned / dynamic: can
             * 4. var: Intellisense help is available / dynamic: not
             * 5. 
             */

            //Accessing code behind variable/property in javascript.
            //That variable doesn't exist in JavaScript because it is running on a different machine than 
            //the C# code. C# is running on the server and JavaScript is running on the client's browser.

            //Have your page write the property out either to a dynamically generated javascript var or to 
            //an HTML hidden field.

            //var _vInit; //Implicitly - typed variables must be initialized

            var _vSolar = "testing system";
            //_vSolar = 999; //Cannot implicitly convert type 'int' to 'string'

            string strVarTest = null;
            var _varTest = strVarTest;
            //_vSolar = 999; //Cannot implicitly convert type 'int' to 'string'

            int varLength = _vSolar.Length;

            dynamic _dSolar = "easterm road";
            _dSolar = 999;


            //int.TryParse("Hello", out objABC.Target);//A property or indexer may not be passed as an out or ref parameter

            //SQL POINT - If you rename a procedure in "Object Explorer" at 
            //"Databases-<db_name>-Programmability-Stored Procedures-<sp_name>",
            //it is renamed within the procedure script also. 
            
            //nested transactions
            //A COMMIT statement in the Outer transaction will commit all the open inner transactions.
            //A Commit statement in the Outer transaction will not commit the changes rolled back by the inner transactions.
            //A Rollback statement in the Outer transaction will rollover all the inner transaction, 
            //irrespective of the Commit/ Rollback fired in the inner transaction(s).

             //WEB SERVICES POINT - A parametric WebMethod will provide option for inputting parameters'
             //values, only if the parameters are of field/primitive types (e.g. int, string etc)

             //IdentifierToken objIdentifierToken1 = new Token();
             //Compile time error - Cannot implicitly convert type 'CSharp.Token' to 'CSharp.IdentifierToken'. 
             //An explicit conversion exists (are you missing a cast?)

             //IdentifierToken objIdentifierToken2 = ((IdentifierToken)(new Token()));
             //Runtime error - InvalidCastException was unhandled
             //"Unable to cast object of type 'CSharp.Token' to type 'CSharp.IdentifierToken'."

             finished = false;
            // Run Thread2() in a new thread
            new Thread(new ThreadStart(Thread2)).Start();
            // Wait for Thread2 to signal that it has a result by setting
            // finished to true.
            for (;;)
            {
                if (finished)
                {
                    Console.WriteLine("result = {0}", result);
                    //Console.ReadLine();
                    break;
                }
            }

            Token objToken = null;
            PrivateInterface pi = new PrivateInterface();

            //pi.new InnerClass1().f();
            //pi.new InnerClass2().f();

            objToken = new IdentifierToken();
            Console.WriteLine(objToken.Display());
            objToken = new SingleToken();
            Console.WriteLine(objToken.Display());
            objToken = new MultipleToken();
            Console.WriteLine("Token objToken = new MultipleToken(); objToken.Display(); - " + objToken.Display());
            Console.WriteLine("MultipleToken.Display(); - " + MultipleToken.Display());
            MultipleToken objgg = new MultipleToken();
            Console.WriteLine();
            Console.WriteLine(objIdentifierToken.Display());
            int i = 2147483647;
            string str = "0004559347291:Multiple";
            Console.WriteLine(str.Substring(0, str.IndexOf(":")));

            string str1 = "Z XZ3/JMK JEAN MARC KERVELLA                 05NOV1414 ---";

            Console.WriteLine("STD Name : " + str1.Substring(6, str1.IndexOf(" ", 6) - 6).Trim());

            MatchCollection match = Regex.Matches(str1, @"([\d]{2}[\w]{3})", RegexOptions.IgnoreCase);
            if (match.Count > 0)
                Console.WriteLine("User Name : " + str1.Substring(str1.IndexOf(" ", 6),
                    str1.IndexOf(match[0].Value) - str1.IndexOf(" ", 6)).Trim());

            //50@282.70
            //6968
            //TA-947911
            //DA-27089085

            // Creates and initializes a new ArrayList.
            ArrayList myAL = new ArrayList();
            myAL.Add("The");
            myAL.Add("QUICK");
            myAL.Add("BROWN");
            myAL.Add("FOX");
            myAL.Add("jumped");
            myAL.Add("over");
            myAL.Add("the");
            myAL.Add("lazy");
            myAL.Add("dog");

            // Displays the values of the ArrayList.
            Console.WriteLine("The ArrayList initially contains the following values:");
            PrintIndexAndValues(myAL);

            // Sorts the values of the ArrayList using the default comparer.
            myAL.Sort(0, 9, null);
            Console.WriteLine("After sorting from index 1 to index 3 with the default comparer:");
            PrintIndexAndValues(myAL);

            // Sorts the values of the ArrayList using the reverse case-insensitive comparer.
            IComparer myComparer = new myReverserClass();
            myAL.Sort(0, 9, myComparer);
            Console.WriteLine("After sorting from index 1 to index 3 with the reverse case-insensitive comparer:");
            PrintIndexAndValues(myAL);
            Console.WriteLine(myAL.IndexOf("jumped"));
            //Main();

            Token[] obj = new Token[5];
            obj[0] = new Token();
            obj[1] = new Token();
            obj[2] = new Token();
            obj[3] = new Token();
            obj[4] = new Token();
            obj[0].GetI = 1;
            obj[1].GetI = 4;
            obj[2].GetI = 8;
            obj[3].GetI = 12;
            obj[4].GetI = 89;
            Console.WriteLine(obj[0].GetI.ToString());
            Console.WriteLine(obj[1].GetI.ToString());
            Console.WriteLine(obj[2].GetI.ToString());
            Console.WriteLine(obj[3].GetI.ToString());
            Console.WriteLine(obj[4].GetI.ToString());
            Console.WriteLine();

            string queryString = "select * from [Sales].[ShoppingCartItem]"
                + " select* from [Person].[PhoneNumberType]"
                + " select* from [HumanResources].[Shift]";

            //SqlConnection connection = new SqlConnection("Data Source=10.220.141.147\\TPSQLEXPRESS;Initial Catalog=EntLibQuickStarts;User ID=sa;Password=1234;");
            SqlConnection connection = new SqlConnection("Data Source=DPCD-4VWWLV1;Initial Catalog=AdventureWorks2016;Integrated Security=SSPI;Persist Security Info=False;");

            SqlCommand command = new SqlCommand(queryString, connection);

            try
            {
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                // Call Read before accessing data.
                Console.WriteLine("AdventureWorks2016 DB");
                Console.WriteLine();
                do
                {
                    while (reader.Read())
                    {
                        Console.WriteLine(String.Format("{0}, {1}, {2}", reader[0], reader[1], reader[2]));
                    }
                    Console.WriteLine();
                } while (reader.NextResult());
                // Call Close when done reading.
                reader.Close();
                Console.WriteLine();
                int g = 1;
                int h = 0;
                g = g / h;
                if (g > h)
                {
                    throw new Exception("g can not be greater than h");
                }
            }
            catch (DivideByZeroException ex)
            {
                Console.WriteLine("DivideByZeroException ex : " + ex.Message);
                try
                {
                    StreamReader s = File.OpenText("Mytext.txt");
                }
                catch
                {
                    //throw; //FileNotFoundException was unhandled
                }
            }
            catch (FileNotFoundException ex)
            {
                Console.WriteLine("FileNotFoundException ex : " + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception ex : " + ex.Message);
            }
            finally
            {
                Console.WriteLine();
                Console.WriteLine("finally called.");
                try
                {
                    StreamReader s = File.OpenText("Mytext.txt");
                }
                catch
                {
                }
                Console.WriteLine();
            }

            //using (TransactionScope txScope = new TransactionScope())
            //{
            //    //asdasd
            //    //asdfas
            //    //asdasd
            //    txScope.Complete();
            //}
            // Print delegate points to PrintNumber
            MathOperations delMathOperation = null;

            delMathOperation = Add;
            delMathOperation.Invoke(10, 2);
            delMathOperation = Subtract;
            delMathOperation.Invoke(10, 2);
            delMathOperation = Multiply;
            delMathOperation.Invoke(10, 2);
            delMathOperation = Divide;
            delMathOperation.Invoke(10, 2);

            //printDel(100000);
            //printDel(200);

            //// Print delegate points to PrintMoney
            //printDel = PrintMoney;

            //printDel(10000);
            //printDel(200);

            int iCount = 0;
            string[] entries = null;
            try
            {
                entries = Directory.GetFileSystemEntries("\\windows\\system32\\config");
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            if (entries != null)
            {
                foreach (string name in entries)
                {
                    if (name.Contains(".evt") || name.Contains(".Evt"))
                        iCount++;
                }
            }
            Console.WriteLine("No of Event Log files found = " + iCount.ToString());

            //throw new DivideByZeroException("testing divide by zero exception using throw keyword.");
            CompileAndRun(code);


            Console.ReadLine();

            /******************************/
            // Convert Number to Words
            /******************************/
            string isNegative = "";
            try
            {
                int number;
                Console.Write("Input something and press enter:");

                while (true)
                {
                    var userInput = Console.ReadLine();
                    userInput = Convert.ToDouble(userInput).ToString();

                    if (!int.TryParse(userInput, out number))
                        Console.WriteLine("I only accept int");
                    else
                    {
                        if (userInput.Contains("-"))
                        {
                            isNegative = "Minus ";
                            userInput = userInput.Substring(1, userInput.Length - 1);
                        }
                        Console.WriteLine("The number in currency fomat is \n{0}", isNegative + NumberToWords.ConvertToWords(userInput));
                    }
                    Console.Write("Input something and press enter:");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            /******************************/
            /******************************/
        }
        static string[] code = {
            "using System;"+
            "namespace DynaCore"+
            "{"+
            "   public class DynaCore"+
            "   {"+
            "       static public int Main(string str)"+
            "       {"+
            "           return str.Length;"+
            "       }"+
            "   }"+
            "}"};

        static void CompileAndRun(string[] code)
        {
            CompilerParameters objCompilerParams = new CompilerParameters();
            //string outputDirectory = Directory.GetCurrentDirectory();

            objCompilerParams.GenerateInMemory = true;
            objCompilerParams.TreatWarningsAsErrors = false;
            objCompilerParams.GenerateExecutable = false;
            objCompilerParams.CompilerOptions = "/optimize";

            string[] references = { "System.dll" };
            objCompilerParams.ReferencedAssemblies.AddRange(references);

            CSharpCodeProvider provider = new CSharpCodeProvider();
            //code is compiled in below statement
            CompilerResults compile = provider.CompileAssemblyFromSource(objCompilerParams, code);

            if (compile.Errors.HasErrors)
            {
                string text = "Compile error: ";
                foreach (CompilerError ce in compile.Errors)
                {
                    text += "rn" + ce.ToString();
                }
                throw new Exception(text);
            }
            //ExpoloreAssembly(compile.CompiledAssembly);
            Module module = compile.CompiledAssembly.GetModules()[0];
            Type mt = null;
            MethodInfo methInfo = null;

            if (module != null)
                mt = module.GetType("DynaCore.DynaCore");
            if (mt != null)
                methInfo = mt.GetMethod("Main");
            if (methInfo != null)
                Console.WriteLine("Final: " + methInfo.Invoke(null, new object[] { "here in dyna code" }));
        }

        static void ExpoloreAssembly(Assembly assembly)
        {
            Console.WriteLine("Modules in the assembly:");
            foreach (Module m in assembly.GetModules())
            {
                Console.WriteLine("{0}", m);
                foreach (Type t in m.GetTypes())
                {
                    Console.WriteLine("t{0}", t.Name);
                    foreach (MethodInfo mi in t.GetMethods())
                        Console.WriteLine("tt{0}", mi.Name);
                }
            }
        }
    }
}

