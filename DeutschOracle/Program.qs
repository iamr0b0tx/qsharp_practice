namespace DeutschOracle {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    
    operation OracleConstantZero(q: Qubit) : Unit{
    }

    operation OracleConstantOne(q: Qubit) : Unit{
        X(q);
    }

    operation OracleIdentity(q: Qubit) : Unit{
        Z(q);
    }

    operation OracleNegation(q: Qubit) : Unit{
        Z(q);
        X(q);
    }

    operation RunBlackBox(oracle : ((Qubit) => Unit)) : (Result) {
        using (q = Qubit()){
            DumpMachine();

            H(q);
            DumpMachine();
            
            oracle(q);
            DumpMachine();
            
            H(q);
            DumpMachine();

            return M(q);
        }
    }

    @EntryPoint()
    operation Main() : (Unit) {
        Message($"\nNot Constant Operations");
        Message($"OracleIdentity = {RunBlackBox(OracleIdentity)}\n");
        Message($"OracleNegation = {RunBlackBox(OracleNegation)}\n");

        Message($"\nConstant Operations");
        Message($"OracleConstantZero = {RunBlackBox(OracleConstantZero)}\n");
        Message($"OracleConstantOne = {RunBlackBox(OracleConstantOne)}\n");

    }
    
}