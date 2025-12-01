module branch_logic(
    Branch,
    funct3,
    N_flag,
    Z_flag,
    C_flag,
    V_flag,
    Btaken
);

    input Branch, N_flag, Z_flag, C_flag, V_flag;
    input [2:0]funct3;

    output reg Btaken;

    reg temp_branch;

    // 분기 판단
    always @(*) begin
        if (Branch) begin
            case (funct3)
                3'b000: temp_branch =  Z_flag;                          // BEQ
                3'b001: temp_branch = ~Z_flag;                          // BNE
                3'b100: temp_branch = (N_flag ^ V_flag);                // BLT
                3'b101: temp_branch = ~(N_flag ^ V_flag);               // BGE
                3'b110: temp_branch = (C_flag == 1'b0)? 1'b1 : 1'b0;    // BLTU
                3'b111: temp_branch = (C_flag == 1'b1)? 1'b1 : 1'b0;    // BGEU
                default: temp_branch = 1'b0;
            endcase
        end
    end

    assign Btaken = (Branch & temp_branch);

endmodule