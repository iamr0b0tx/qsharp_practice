namespace DeutschOracle {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation OracleConstantZero(input: Qubit, output: Qubit) : Unit{
    }

    operation OracleConstantOne(input: Qubit, output: Qubit) : Unit{
        X(output);
    }

    operation OracleIdentity(input: Qubit, output: Qubit) : Unit{
        CNOT(input, output);
    }

    operation OracleNegation(input: Qubit, output: Qubit) : Unit{
        CNOT(input, output);
        X(output);
    }

    operation RunBlackBox(oracle : ((Qubit, Qubit) => Unit)) : (Result, Result) {
        using (qbits = Qubit[2]){

            let input = qbits[0];
            let output = qbits[1];

            H(input);
            H(output);

            CNOT(input, output);
            X(output);

            H(input);
            H(output);

            return (MResetZ(input), MResetZ(output));
        }
    }

    @EntryPoint()
    operation Main() : (Unit) {
        Message($"{RunBlackBox(OracleConstantZero)}");
        Message($"{RunBlackBox(OracleConstantOne)}");
        Message($"{RunBlackBox(OracleIdentity)}");
        Message($"{RunBlackBox(OracleNegation)}");
        Message($"Hellor");

    }
    
}