library ai.grakn;

enum GraknTxType {
    READ,  //Read only transaction where mutations to the graph are prohibited
    WRITE, //Write transaction where the graph can be mutated
    BATCH //Batch transaction which enables faster writes by switching off some consitency checks
}