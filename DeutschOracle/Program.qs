namespace DeutschOracle {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    
    operation OracleConstantZero(q: Qubit) : Unit{
    }

    operation OracleIdentity(q: Qubit) : Unit{
        Z(q);
    }

    operation RunBlackBox(oracle : ((Qubit) => Unit)) : (Result) {
        using (q = Qubit()){
            H(q);
            oracle(q);
            H(q);
            
            return M(q);
        }
    }

    @EntryPoint()
    operation Main() : (Unit) {
        Message($"OracleConstantZero = {RunBlackBox(OracleConstantZero)}");
        Message($"OracleIdentity = {RunBlackBox(OracleIdentity)}");

        DumpMachine();
    }
    
}