
`timescale 1ns/1ps

module data_mux (
    // DATA MEM
    input           cs_dmem_n,
    input    [31:0]	read_data_dmem,

    // TBMAN
    input           cs_tbman_n,
    input    [31:0] read_data_tbman,

    output reg [31:0] read_data 
);

    always @(*) begin
        if (!cs_dmem_n) begin
            // DMEM 선택
            read_data = read_data_dmem;
        end
        else if (!cs_tbman_n) begin
            // TBMAN 선택
            read_data = read_data_tbman;
        end
        else begin
            // 어떤 것도 선택되지 않은 경우
            read_data = 32'd0;
        end
    end

endmodule