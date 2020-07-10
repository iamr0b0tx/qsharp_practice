namespace RandomBitGenerator {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    

    @EntryPoint()
    operation GenerateRandomBit() : Result {
        
        using (q = Qubit()) { // allocate a bit

            H(q); // place qubit in superposition

            return MResetZ(q); // the measured bit may be 0 or 1 with a 50% chance 
        }

    }
}

