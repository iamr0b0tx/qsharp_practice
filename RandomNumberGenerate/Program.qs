namespace RandomNumberGenerate {

    // open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateRandomBit() : Result {
        using (qbit = Qubit()) {
            
            H(qbit); // put qbit in superposition

            return MResetZ(qbit); // Measure the bit
        }
    }

    operation SampleNumberInRange(min: Int, max: Int) : Int{
        mutable output = 0;
        repeat {
            mutable bits = new Result[0];
            for (idxBit in BitSizeI(min)..BitSizeI(max)){
                set bits += [GenerateRandomBit()];
            }

            // set output bits
            set output = ResultArrayAsInt(bits);
        
        }until((output >= min) and (output <= max));
        
        return output;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int{
        let min = 10;
        let max = 50;

        Message($"Sampling a random number between {min} and {max}: ");
        return SampleNumberInRange(min, max);
    }
}

