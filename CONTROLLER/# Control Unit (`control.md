# Control Unit (`control.v`)

## Overview

The `control` module is a multi-cycle FSM control unit designed for a simple accumulator-based CPU architecture. It decodes a 3-bit instruction **opcode** across an 8-step execution **phase** sequence (`3'b000` to `3'b111`) to generate control signals for memory, registers, the Program Counter (PC), and the ALU.

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System Clock signal. |
| `rst` | 1 bit | Active-high synchronous Reset signal. |
| `zero` | 1 bit | ALU zero flag (active when accumulator equals zero). |
| `phase` | 3 bits | Current cycle/phase of execution (`0` to `7`). |
| `opcode` | 3 bits | Instruction opcode (`0` to `7`). |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `sel` | 1 bit | Selects address source for memory (PC vs IR). |
| `rd` | 1 bit | Read enable signal for memory. |
| `ld_ir` | 1 bit | Load enable for the Instruction Register (IR). |
| `halt` | 1 bit | Halts the CPU execution. |
| `inc_pc` | 1 bit | Increments the Program Counter (PC). |
| `ld_ac` | 1 bit | Load enable for the Accumulator (AC). |
| `ld_pc` | 1 bit | Load enable for the Program Counter (PC jump). |
| `wr` | 1 bit | Write enable signal for memory. |
| `data_e` | 1 bit | Enables data driver onto the bus. |

---

## Opcode Table

| Opcode (`opcode`) | Mnemonic | Category | Description |
| :--- | :--- | :--- | :--- |
| `3'b000` | **HLT** | Control | Stops processor execution. |
| `3'b001` | **SKZ** | Control | Skips the next instruction if `zero == 1`. |
| `3'b010` | **ADD** | ALU | Adds memory content to Accumulator. |
| `3'b011` | **AND** | ALU | Bitwise ANDs memory content with Accumulator. |
| `3'b100` | **XOR** | ALU | Bitwise XORs memory content with Accumulator. |
| `3'b101` | **LDA** | ALU | Loads memory content into Accumulator. |
| `3'b110` | **STO** | Memory | Stores Accumulator content to memory. |
| `3'b111` | **JMP** | Control | Unconditional jump to target address. |

---

## Execution Phases (`phase`)

1. **Phases 0–3 (Fetch Phase):**
   * `3'b000`: Address MUX set (`sel = 1`).
   * `3'b001`: Read memory (`sel = 1`, `rd = 1`).
   * `3'b010` – `3'b011`: Fetch instruction into Instruction Register (`sel = 1`, `rd = 1`, `ld_ir = 1`).

2. **Phase 4 (Decode / Increment PC):**
   * Increment Program Counter (`inc_pc = 1`).
   * If `opcode == HLT`, trigger `halt = 1`.

3. **Phases 5–7 (Execute Phase):**
   * **ALU Operations (`ADD`, `AND`, `XOR`, `LDA`):** Asserts `rd` in phases 5–7 and `ld_ac` in phase 7.
   * **`SKZ`:** Increments PC in phase 6 if `zero == 1`.
   * **`STO`:** Enables data output (`data_e = 1`) in phase 6, writes to memory (`wr = 1`, `data_e = 1`) in phase 7.
   * **`JMP`:** Loads new PC address (`ld_pc = 1`) during phases 6 and 7.