./sim_define.v

// ../../src/rtl/refCPU/rev00_protect/ASYNC_RAM_DP_WBE.v
// ../../src/rtl/refCPU/rev00_protect/reg_file_async.v
// ../../src/rtl/refCPU/rev00_protect/rv32i_single_cycle_cpu_protected.vp
// ../../src/rtl/refCPU/rev00_protect/RV32I_System.v

//memory
../../../source/single_cycle/myCPU/rev00/model/ASYNC_RAM_DP_WBE.v


// Register File
../../../source/single_cycle/myCPU/rev00/src/rtl/reg_file_async.v


//block
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/adder.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/extend.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/flopenr.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/flopr.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/be_logic.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/mux2.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/building_blocks/mux3.sv

../../../source/single_cycle/myCPU/rev00/src/rtl/alu.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/aludec.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/maindec.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/branch_logic.sv

../../../source/single_cycle/myCPU/rev00/src/rtl/controller.sv
../../../source/single_cycle/myCPU/rev00/src/rtl/datapath.sv

../../../source/single_cycle/myCPU/rev00/src/rtl/riscvsingle.sv

../../../source/single_cycle/myCPU/rev00/src/rtl/SMU_RV32I_System.v

//testbench
../../testbench/cpu_tb.v
