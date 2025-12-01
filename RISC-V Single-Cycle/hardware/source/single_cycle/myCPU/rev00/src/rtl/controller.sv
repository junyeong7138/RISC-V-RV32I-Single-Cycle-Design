module controller(
    Z_flag, N_flag, C_flag, V_flag,
    opcode,
    funct3,
    funct7,
    PCSrc,
    ResultSrc,
    MemWrite,
    ALUSrcA,
    ALUSrc,
    ImmSrc,
    RegWrite,
    ALUControl,
    Jump,
    Branch
);
    // input
    input Z_flag, N_flag, C_flag, V_flag;
    input [6:0] opcode;
    input [2:0] funct3;
    input funct7;
    // output
    output [1:0] PCSrc;
    output MemWrite, ALUSrc, RegWrite, Jump;
    output [1:0] ResultSrc, ALUSrcA;
    output [2:0] ImmSrc;
    output [4:0] ALUControl;
    output Branch;

    wire [1:0] ALUop;
    wire Btaken;


    maindec mdec(
        .opcode(opcode),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ALUSrcA(ALUSrcA),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ALUop(ALUop),
        .Branch(Branch),
        .Btaken(Btaken)
    );

    branch_logic u_branch_logic(
        .Branch(Branch),
        .funct3(funct3),
        .N_flag(N_flag),
        .Z_flag(Z_flag),
        .C_flag(C_flag),
        .V_flag(V_flag),
        .Btaken(Btaken)
    );
    
    aludec adec(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUop(ALUop),
        .ALUControl(ALUControl)
    );

endmodule
