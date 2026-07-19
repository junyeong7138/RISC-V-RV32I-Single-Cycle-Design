# RISC-V RV32I Single-Cycle CPU

A single-cycle RV32I CPU written in SystemVerilog, designed and verified for the CPU Design
course at Sangmyung University (2025 Fall) with Synopsys VCS. This is the first step of a
three-part project that grows into a pipelined RV32IM CPU.

Related repositories:
[5-Stage Pipeline version](https://github.com/junyeong7138/RISC-V-RV32I-Pipeline-Design) ·
[RV32IM version (M extension)](https://github.com/junyeong7138/RISC-V-RV32IM-Pipeline-Design)

## Features

- **RV32I base ISA** (37 instructions), single-cycle datapath
- Datapath/controller decomposition following Harris & Harris,
  *Digital Design and Computer Architecture: RISC-V Edition* — `datapath` +
  `controller` (`maindec`/`aludec`), register file, immediate extender, ALU,
  and small building blocks (muxes, flops)
- **CSR** with a `tohost` register (0x51e) used as the pass/fail channel for testbenches (rev01+)
- **TBMAN** testbench-manager peripheral for printf-style output from C programs (rev02)
- **Memory-mapped I/O** at `0x8000_xxxx` (cycle/instruction counters, GPIO, UART)

## Verification

Each numbered directory under `hardware/` is a self-contained test environment
(testbench + VCS simulation setup):

| Series | Contents |
|---|---|
| `01`–`03` | Integrated tests (hand-written instruction sequences loaded into IMEM) |
| `10` | Integrated tests with CSR |
| `11` | Full RISC-V ISA test suite — 38 tests (`addi` … `xor`, excluding `fence_i`) |
| `21` | C tests built with the RISC-V GNU toolchain |
| `31` | TBMAN peripheral tests |

### Running (Synopsys VCS + Verdi + riscv64-unknown-elf toolchain required)

```sh
cd software/riscv-isa-tests && make          # build test programs

cd hardware/11.RV32I_isa_tests/sim/func_sim
make run test=all                            # full ISA suite
make verdi                                   # inspect waveforms (FSDB)
```

`run.f` in each `sim/func_sim/` pins which RTL revision the environment compiles.

## RTL revisions

| Rev | Adds | Verified by |
|---|---|---|
| rev00 | RV32I single-cycle CPU (37 instructions) | 01–03 |
| rev01 | + CSR (`tohost`) | 10, 11, 21 |
| rev02 | + TBMAN peripheral | 31 |

## Acknowledgements

- Course framework based in part on UC Berkeley's EECS151/251A FPGA project
- Reference: Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition*
