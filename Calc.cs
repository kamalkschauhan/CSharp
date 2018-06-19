using System;
using System.Threading;
using System.Collections;
using System.ComponentModel;
using System.Data;

public struct MyData {
    public double pi;
    public int iters;
}
public class Calc {
    private double _pi;
    private int _iters;

    private readonly int TotalIters;
    public Calc(int it) {
        _iters = 1;
        _pi = 0;
        TotalIters = it;
    }
    public MyData PI {
        get {
            MyData pi = new MyData();
            lock (this) {
                pi.pi = _pi;
                pi.iters = _iters;
            }
            return pi;
        }
    }
    public Thread MakeThread() {
        return new Thread(new ThreadStart(this.ThreadStarter));
    }
    private void calculate() {
        double series = 0;
        do {
            series ++;
            lock (this) {
                _iters += 4;
                _pi = series * 4;
            }
        } while (_iters < TotalIters);
    }
    private void ThreadStarter() {
        try {
            calculate();
        } catch (ThreadAbortException e) {
            Console.WriteLine("ThreadAbortException");
        }
    }
}
