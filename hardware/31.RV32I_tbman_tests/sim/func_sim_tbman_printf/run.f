./sim_define.v

//memory
../../../source/rev02/model/ASYNC_RAM_DP_WBE.v


// Register File
../../../source/rev02/src/rtl/reg_file_async.v


//block
../../../source/rev02/src/rtl/building_blocks/adder.sv
../../../source/rev02/src/rtl/building_blocks/extend.sv
../../../source/rev02/src/rtl/building_blocks/flopenr.sv
../../../source/rev02/src/rtl/building_blocks/flopr.sv
../../../source/rev02/src/rtl/building_blocks/be_logic.sv
../../../source/rev02/src/rtl/building_blocks/mux2.sv
../../../source/rev02/src/rtl/building_blocks/mux3.sv

../../../source/rev02/src/rtl/alu.sv
../../../source/rev02/src/rtl/aludec.sv
../../../source/rev02/src/rtl/maindec.sv
../../../source/rev02/src/rtl/branch_logic.sv

../../../source/rev02/src/rtl/controller.sv
../../../source/rev02/src/rtl/datapath.sv

../../../source/rev02/src/rtl/riscvsingle.sv

../../../source/rev02/src/rtl/SMU_RV32I_System.v

../../../source/rev02/src/rtl/10peripheral_tbman/Addr_Decoder.v
../../../source/rev02/src/rtl/10peripheral_tbman/data_mux.v

../../../source/rev02/src/rtl/10peripheral_tbman/01.tbman/tbman_apbs.v
../../../source/rev02/src/rtl/10peripheral_tbman/01.tbman/tbman_regs.v
../../../source/rev02/src/rtl/10peripheral_tbman/01.tbman/tbman_wrap.v



../../testbench/c_tests_tb.v
