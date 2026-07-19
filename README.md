# 1️⃣ RISC-V RV32I Single-Cycle CPU

RV32I(37개 명령어) **싱글사이클 CPU**를 SystemVerilog로 설계하고
RISC-V ISA 테스트 스위트로 Synopsys VCS에서 검증한 프로젝트입니다.
3부작 CPU 설계 시리즈의 첫 단계로, 이후 5단 파이프라인 → RV32IM으로 발전합니다.

| 항목 | 내용 |
|---|---|
| ISA | RV32I 37개 명령어, 싱글사이클 실행 |
| 구조 | Harris & Harris식 **datapath / controller 분리** (`maindec` + `aludec`) |
| 검증 | 통합 테스트 + ISA 테스트 38종 + C 테스트 + TBMAN 테스트 |
| CSR | `tohost`(0x51e) — 테스트벤치 패스/페일 채널 (rev01+) |
| 주변장치 | TBMAN(테스트벤치 매니저), 메모리맵 I/O(`0x8000_xxxx`) (rev02+) |

시리즈: **1️⃣ Single-Cycle (현재)** →
[2️⃣ RV32I Pipeline](https://github.com/junyeong7138/RISC-V-RV32I-Pipeline-Design) →
[3️⃣ RV32IM Pipeline](https://github.com/junyeong7138/RISC-V-RV32IM-Pipeline-Design)

## 📂 Contents

1. [👨‍💻 Who Made?](#-who-made)
2. [🌳 개발환경](#-개발환경)
3. [🔧 개발과정](#-개발과정)
4. [🧮 HW Architecture](#-hw-architecture)
5. [✅ Verification](#-verification)
6. [📁 Repository Guide](#-repository-guide)

## 👨‍💻 Who Made?

박준영 (JuNyeong Park) — 상명대학교 3학년, CPU 설계 (2025-2) 중간 프로젝트

[@junyeong7138](https://github.com/junyeong7138)

## 🌳 개발환경

| 설계 언어 | Simulation | Waveform | SW 툴체인 | 참고 교재 |
|---|---|---|---|---|
| SystemVerilog / Verilog | Synopsys VCS | Verdi (FSDB) | riscv64-unknown-elf-gcc | Harris & Harris, *DDCA RISC-V Edition* |

## 🔧 개발과정

| Rev | 추가된 것 | 검증 환경 |
|---|---|---|
| rev00 | RV32I 싱글사이클 CPU (37 명령어) | 01–03 |
| rev01 | + CSR (`tohost`) | 10, 11, 21 |
| rev02 | + TBMAN 주변장치 | 31 |

## 🧮 HW Architecture

Harris & Harris 교재의 표준 분해를 따릅니다:

- **`datapath`** — PC 로직, 레지스터 파일, 즉시값 확장기(`extend`), ALU, 결과 선택 MUX
- **`controller`** — `maindec`(opcode → RegWrite·MemWrite·ImmSrc·Branch·ALUop …) +
  `aludec`(ALUop + funct3/funct7 → ALUControl)
- **`SMU_RV32I_System`** — CPU + IMEM/DMEM + 메모리맵 I/O + TBMAN을 묶는 최상위
- 모든 명령이 **한 클럭에 IF→WB를 완주** — 임계경로는 lw (IMEM→RF→ALU→DMEM→RF)

> 파이프라인 버전과의 구조 비교(블록 다이어그램 포함)는
> [RV32I Pipeline 저장소](https://github.com/junyeong7138/RISC-V-RV32I-Pipeline-Design)를 참고하세요.

## ✅ Verification

`hardware/` 아래 번호가 붙은 폴더 하나하나가 독립된 테스트 환경입니다.

| 환경 | 내용 |
|---|---|
| `01`–`03` | 통합 테스트 — 수작업 명령어 시퀀스를 IMEM에 로드해 전 명령 검증 |
| `10` | 통합 테스트 + CSR |
| `11` | RISC-V ISA 테스트 스위트 38종 (`addi` … `xor`, `fence_i` 제외) |
| `21` | C 테스트 (RISC-V GNU 툴체인 빌드) |
| `31` | TBMAN 주변장치 테스트 (printf) |

패스/페일은 **`tohost` CSR(0x51e)** 로 보고됩니다 — `tohost == 1`이면 pass,
그 외 값은 실패한 서브테스트 번호입니다.

### 실행 방법 (Synopsys VCS + Verdi + riscv64-unknown-elf 필요)

```sh
cd software/riscv-isa-tests && make          # 테스트 프로그램 빌드

cd hardware/11.RV32I_isa_tests/sim/func_sim
make run test=all                            # 전체 38종 (단일: make run test=addi)
make verdi                                   # FSDB 파형 열기
```

## 📁 Repository Guide

```
├── hardware/
│   ├── source/                 # ★ RTL (rev00–rev02 점진 스냅샷)
│   │   └── revNN/{model, src/rtl}
│   │       └── src/rtl/{SMU_RV32I_System.v, datapath.sv, controller.sv,
│   │                    maindec.sv, aludec.sv, alu.sv, building_blocks/…}
│   ├── 01~03.*/                # 통합 테스트 환경
│   ├── 10.*/ 11.*/ 21.*/ 31.*/ # CSR·ISA·C·TBMAN 테스트 환경
│   └── (각 환경) testbench/ + sim/func_sim/{Makefile, run.f, sim_define.v, mem_path.vh}
└── software/
    ├── riscv-isa-tests/        # ISA 테스트 38종 (.mif 포함)
    ├── c_tests/, tbman_tests/
    ├── 151_library/            # 지원 라이브러리 (uart, string, memory_map.h)
    └── Makefrag                # 공용 빌드 규칙
```

## 🙏 Acknowledgements

- 과목 프레임워크는 UC Berkeley **EECS151/251A** FPGA 프로젝트를 일부 기반으로 합니다
- 참고 교재: Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition*
