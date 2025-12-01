module datapath(
    clk,
    n_rst,
    Instr,         // from imem
    ReadData,      // from dmem
    PCSrc,         // from controller ......
    ResultSrc,
    ALUControl,
    ALUSrc,
    ALUSrcA,
    ImmSrc,
    RegWrite,
    PC,            // for imem  
    ALUResult,     // for dmem ..
    WriteData,      
    Z_flag,         // for controller
    N_flag,         // for controller
    C_flag,         // for controller
    V_flag,          // for controller
    Csr,
    ByteEnable
);

    parameter   RESET_PC = 32'h1000_0000;

    //input
    input clk, n_rst, ALUSrc, RegWrite;
    input [31:0] Instr, ReadData;
    input [1:0] ResultSrc, PCSrc, ALUSrcA;
    input [2:0] ImmSrc;
    input [4:0] ALUControl;
    input Csr;
    //output
    output [31:0] PC, ALUResult;
    output [31:0] WriteData;
    output Z_flag, N_flag, C_flag, V_flag;
    output [3:0] ByteEnable;

    wire [31:0] PC_next, PC_target, PC_plus4;
    wire [31:0] ImmExt;                       
    wire [31:0] bef_SrcA, bef_SrcB;
    wire [31:0] SrcA, SrcB;
    wire [31:0] Result;
    wire [31:0] BE_WD, BE_RD;

    assign WriteData = BE_WD;

    // assign WriteData = bef_SrcB;

    // // ========= ALU로 들어가는 SrcA를 선택하는 sel 변수======================
    // wire [1:0] selSrcA;
    // assign selSrcA = (opcode == 7'b001_0111) ? 2'b01 :
    //                  (opcode == 7'b011_0111) ? 2'b10 : 2'b00;
    // //=================================================================

    mux3 u_pc_mux2(
        .in0(PC_plus4),
        .in1(PC_target),
        .in2(ALUResult),
        .sel(PCSrc),
        .out(PC_next)
    );
    
    flopr # (
        .RESET_VALUE (RESET_PC)
    ) u_pc_register(
        .clk(clk),
        .n_rst(n_rst),
        .d(PC_next),
        .q(PC)
    );


    adder u_pc_plus4(
        .a(PC), 
        .b(32'h4), 
        .ci(1'b0), 
        .sum(PC_plus4),
        .N(),
        .Z(),
        .C(),
        .V()
    );

    extend u_Extend(
        .ImmSrc(ImmSrc),
        .in(Instr[31:7]),
        .out(ImmExt)
    );

    adder u_pc_target(
        .a(PC), 
        .b(ImmExt), 
        .ci(1'b0), 
        .sum(PC_target),
        .N(),
        .Z(),
        .C(),
        .V()
    );
    
    reg_file_async rf (
        .clk        (clk),
        .clkb       (clk),
        .we         (RegWrite),
        .ra1        (Instr[19:15]),
        .ra2        (Instr[24:20]),
        .wa         (Instr[11:7]),
        .wd         (Result),
        .rd1        (bef_SrcA),
        .rd2        (bef_SrcB)
    );


    mux2 u_alu_mux2(
        .in0(bef_SrcB),
        .in1(ImmExt),
        .sel(ALUSrc),
        .out(SrcB)
    );

    mux3 u_result_mux3(
        .in0(bef_SrcA),
        .in1(PC),
        .in2(32'b0),
        .sel(ALUSrcA),
        .out(SrcA)
    );


    alu u_ALU(
        .a_in(SrcA),
        .b_in(SrcB),
        .ALUControl(ALUControl),
        .result(ALUResult),
        .aN(N_flag),
        .aZ(Z_flag),
        .aC(C_flag),
        .aV(V_flag)

    );

    be_logic u_be_logic (
        .AddrLast2(ALUResult[1:0]),
        .funct3(Instr[14:12]),
        .WD(bef_SrcB),
        .RD(ReadData),
        .BE_WD(BE_WD),
        .BE_RD(BE_RD),
        .ByteEnable(ByteEnable)
    );

    mux3 u_result_mux4(
        .in0(ALUResult),
        .in1(BE_RD),
        .in2(PC_plus4),
        .sel(ResultSrc),
        .out(Result)
    );

    reg [31:0] tohost_csr;

    always @(*) begin
        if (Csr == 1'b1) begin
            case(Instr[14:12])
                3'b001: tohost_csr = bef_SrcA;
                3'b101: tohost_csr = ImmExt;
                default : tohost_csr = 32'h0;
            endcase
        end
        else tohost_csr = 32'h0;
    end

endmodule
