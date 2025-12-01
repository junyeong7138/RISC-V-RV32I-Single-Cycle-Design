./sim_define.v

//memory
../../../source/rev00/model/ASYNC_RAM_DP_WBE.v


// Register File
../../../source/rev00/src/rtl/reg_file_async.v


//block
../../../source/rev00/src/rtl/building_blocks/adder.sv
../../../source/rev00/src/rtl/building_blocks/extend.sv
../../../source/rev00/src/rtl/building_blocks/flopenr.sv
../../../source/rev00/src/rtl/building_blocks/flopr.sv
../../../source/rev00/src/rtl/building_blocks/be_logic.sv
../../../source/rev00/src/rtl/building_blocks/mux2.sv
../../../source/rev00/src/rtl/building_blocks/mux3.sv

../../../source/rev00/src/rtl/alu.sv
../../../source/rev00/src/rtl/aludec.sv
../../../source/rev00/src/rtl/maindec.sv
../../../source/rev00/src/rtl/branch_logic.sv

../../../source/rev00/src/rtl/controller.sv
../../../source/rev00/src/rtl/datapath.sv

../../../source/rev00/src/rtl/riscvsingle.sv

../../../source/rev00/src/rtl/SMU_RV32I_System.v

//testbench
../../testbench/cpu_tb.v
