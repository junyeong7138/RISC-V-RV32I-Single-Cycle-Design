
`timescale 1ns/1ns

module Addr_Decoder (
    input [31:0] Addr,
    output reg CS_DMEM_N,
    output reg CS_TBMAN_N
);


    always @(*) begin
        // 기본값: 모두 비활성화
        CS_DMEM_N  = 1'b1;
        CS_TBMAN_N = 1'b1;

        // Memory (0x1000_0000 ~ 0x1FFF_FFFF)
        if (Addr[31:28] == 4'h1) begin
            CS_DMEM_N  = 1'b0;  // Memory 선택
            CS_TBMAN_N = 1'b1;
        end

        // TBMAN (0x8000_F000)
        else if (Addr[31:12] == 20'h8000F) begin
            CS_DMEM_N  = 1'b1;
            CS_TBMAN_N = 1'b0;  // TBMAN 선택
        end

        // 나머지 주소: 모두 비활성화 상태 유지
        else begin
            CS_DMEM_N  = 1'b1;
            CS_TBMAN_N = 1'b1;
        end
    end

endmodule