# Rising Edge Detector - Moore FSM (`rising_edge_moore.sv`)

## Overview

The `rising_edge_moore` module implements a SystemVerilog Moore Finite State Machine (FSM) designed to detect rising edges ($0 \rightarrow 1$ transitions) on an input signal (`level`). Because it is implemented as a **Moore machine**, the output (`tick`) depends purely on the `present_state`, producing a clean, glitch-free, 1-clock-cycle pulse when transitioning into the edge detection state.

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `reset` | 1 bit | Active-high asynchronous reset signal |
| `level` | 1 bit | Input logic signal monitored for rising edges |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `tick` | 1 bit | Single-cycle pulse output asserted high upon detecting a rising edge |

---

## FSM States

| State | Encoding | Output (`tick`) | Description |
| :--- | :---: | :---: | :--- |
| `zero` | `2'b00` | `0` | Idle state; waiting for `level` to go high |
| `edg` | `2'b01` | `1` | Edge detected state; outputs a 1-cycle `tick` |
| `one` | `2'b10` | `0` | Active state; holds output low while `level` remains high |

---

## State Transition & Output Logic

### State `zero` (`tick = 0`):
* **If `level == 1`**: `next_state = edg`
* **If `level == 0`**: `next_state = zero`

### State `edg` (`tick = 1`):
* **If `level == 1`**: `next_state = one`
* **If `level == 0`**: `next_state = zero`

### State `one` (`tick = 0`):
* **If `level == 1`**: `next_state = one`
* **If `level == 0`**: `next_state = zero`

---

## Key Characteristics

* **Moore Output:** `tick` is purely driven by `present_state` (specifically state `edg`), making it immune to combinational input glitches on `level`.
* **1-Clock Latency:** Asserts `tick` on the clock edge *after* `level` goes high, holding it active for exactly one clock period before transitioning to state `one`.