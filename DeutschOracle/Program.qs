namespace DeutschOracle {

    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation ConstantZero(input: Qubit, output: Qubit) : Unit{
    }

    operation ConstantOne(input: Qubit, output: Qubit) : Unit{
        X(output);
    }

    operation Identity(input: Qubit, output: Qubit) : Unit{
        CNOT(input, output);
    }

    operation Negation(input: Qubit, output: Qubit) : Unit{
        CNOT(input, output);
        X(output);
    }

    @EntryPoint()
    operation Main() : Unit {
        Message("Hello quantum world!");
    }
    
    operation IsBlackBoxConstant(blackBox: ((Qubit, Qubit) => ()) : (Bool){
        // the output lines
        mutable inputResult = Zero;
        mutable outputResult = Zero;

        // allocate two bits
        using (qbits = Qubit[2]){
            // label the input and output qbits
            let input = qbits[0];
            let output = qbits[1];

            // set qbits to zero in prep
            Clear(input, output);

            // pre process
            X(input);
            X(output);

            H(input);
            H(output);

            // send through black-box
            blackBox(input, output);

            //post processing
            H(input);
            H(output);

            // measure the qbits
            set inputResult = M(input);
            set outputResult = M(output);

            //clear the qbits before release
            Clear(input, output);

            // if input qbit is 1 then black box is constant if 0 then is variable
            return One == inputResult;
        }
    }

    operation IsConstantZeroConstant() : (Bool){
        body{
            return IsBlackBoxConstant(ConstantZero);
        }
    }
}

