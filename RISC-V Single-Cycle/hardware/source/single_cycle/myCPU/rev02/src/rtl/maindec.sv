module maindec(
    opcode,
    PCSrc,
    ResultSrc,
    MemWrite,
    ALUSrcA,
    ALUSrc,
    ImmSrc,
    RegWrite,
    Jump,
    ALUop,
    Branch,
    Btaken,
    Csr
);
    // input
    input  Btaken;
    input [6:0] opcode;
    // output
    output reg [1:0] PCSrc;
    output reg MemWrite, ALUSrc, RegWrite, Jump;
    output reg [1:0] ResultSrc, ALUSrcA;
    output reg [2:0] ImmSrc;
    output reg [1:0] ALUop;
    output reg Branch, Csr;

    always@ (*) begin
        if (Btaken == 1'b1)              PCSrc = 2'b01;
        else if (Jump == 1'b1)           PCSrc = 2'b01;
        else if (opcode == 7'b110_0111)  PCSrc = 2'b10;
        else                             PCSrc = 2'b00;
    end

    always@(*) begin    // main decoder
        case(opcode)
            7'b011_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_xxx_00_0_0_00_0_10_0_0;     // R-type
            7'b001_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_000_00_1_0_00_0_10_0_0;     // I-type ALU
            7'b000_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_000_00_1_0_01_0_00_0_0;     // I-type Load
            7'b010_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b0_001_00_1_1_xx_0_00_0_0;     // S-type
            7'b110_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b0_010_00_0_0_00_1_01_0_0;     // Branch
            7'b110_1111 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_011_00_0_0_10_0_00_1_0;     // jal
            7'b110_0111 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_000_00_1_0_10_0_10_0_0;     // jalr
            7'b011_0111 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_100_10_1_0_00_0_00_0_0;     // lui(U-type)
            7'b001_0111 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_100_01_1_0_00_0_00_0_0;     // auipc
            7'b111_0011 : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'b1_101_00_1_0_00_0_xx_0_1;     // csrrw, csrrwi
            default : {RegWrite, ImmSrc, ALUSrcA, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, Jump, Csr} = 15'hx;
        endcase
    end

endmodule