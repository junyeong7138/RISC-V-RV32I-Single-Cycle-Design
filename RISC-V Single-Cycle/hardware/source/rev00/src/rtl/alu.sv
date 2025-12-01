module alu(
    a_in,
    b_in,
    ALUControl,
    result,
    aZ,
    aN,
    aC,
    aV
);
    input [31:0] a_in, b_in;
    input [4:0] ALUControl;
    output reg [31:0] result; 
    output reg aZ, aN, aC, aV;

    wire N, Z, C, V;
    wire [31:0] add_sub_b;
    wire [31:0] adder_result, and_result, or_result, xor_result, SLT_result, SLL_result, SRL_result, SRA_result, SLTU_result;

    // 33-bit 확장으로 a - b의 carry_out 직접 계산
    wire [32:0] sub_ext   = {1'b0, a_in} + {1'b0, ~b_in} + 33'd1;
    wire        cout_sub  = sub_ext[32];

    assign add_sub_b = (ALUControl == 5'b00001 ||  // Branch(BEQ, BNE, BLT, BGE), SUB
                        ALUControl == 5'b00101 ||  // SLT
                        ALUControl == 5'b01001 ||
                        ALUControl == 5'b01010) ?  // Brnach(BLTU, BGEU)
                                                    ~b_in + 32'h1 : 
                                                    b_in;

    adder u_add_32bit_add(
        .a(a_in),
        .b(add_sub_b),
        .ci(1'b0),
        .sum(adder_result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
    );    
    
    always@(*)begin
        if (ALUControl == 5'b00000 || ALUControl == 5'b00001 || ALUControl == 5'b00101 || ALUControl == 5'b01001) begin
            {aN, aZ, aC, aV} = {N, Z, C, V};
        end
        else if (ALUControl == 5'b00010) begin    //and
            aN = and_result[31];
            aZ = (and_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b00011) begin    //or
            aN = or_result[31];
            aZ = (or_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b00100) begin    //xor
            aN = xor_result[31];
            aZ = (xor_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b00110) begin    //sll
            aN = SLL_result[31];
            aZ = (SLL_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b00111) begin    //srl
            aN = SRL_result[31];
            aZ = (SRL_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b01000) begin    //sra
            aN = SRA_result[31];
            aZ = (SRA_result == 32'h0) ? 1'b1 : 1'b0;
            aC = 1'b0;
            aV = 1'b0;
        end
        else if (ALUControl == 5'b01010) begin    // BLTU/BGEU
            aN = N; 
            aZ = Z; 
            aV = V; 
            aC = cout_sub;
        end
        else if (ALUControl == 5'b01001) begin // SLTU(unsigned)
            aN = 1'b0; 
            aZ = (SLTU_result == 32'h0); 
            aV = 1'b0; 
            aC = cout_sub;
        end
        else begin
            {aN, aZ, aC, aV} = 4'h0;	
        end
    end
    
    assign and_result = a_in & b_in;
    assign or_result = a_in | b_in;
    assign xor_result = a_in ^ b_in;
    assign SLT_result = aN ^ aV;
    assign SLL_result = a_in << b_in[4:0];
    assign SRL_result = a_in >> b_in[4:0];
    assign SRA_result = $signed(a_in) >>> b_in[4:0];
    // SLTU: unsigned a<b ⇔ borrow 발생 ⇔ cout_sub==0
    assign SLTU_result = (cout_sub == 1'b0) ? 32'd1 : 32'd0;

    always@(*) begin
        case(ALUControl)
            5'b00000 : result = adder_result;        // add, lui, lw, sw, lbu
            5'b00001 : result = adder_result;        // sub, beq, bne, blt, bge
            5'b00010 : result = and_result;          // and
            5'b00011 : result = or_result;           // or
            5'b00100 : result = xor_result;          // xor
            5'b00101 : result = SLT_result;          // slt
            5'b00110 : result = SLL_result;          // sll, slli
            5'b00111 : result = SRL_result;          // srl
            5'b01000 : result = SRA_result;          // sra, srai
            5'b01001 : result = SLTU_result;         // sltu
            default : result = 32'hx;
        endcase
    end

endmodule
