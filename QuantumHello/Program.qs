namespace QuantumHello{

    @EntryPoint()
    operation sayHello(): Unit{
        Microsoft.Quantum.Intrinsic.Message("Hello Quantum World!");
    }
}