# Rising Edge Detector - Mealy FSM (`rising_edge_mealy.sv`)

## Overview

The `rising_edge_mealy` module implements a SystemVerilog Mealy Finite State Machine (FSM) designed to detect rising edges ($0 \rightarrow 1$ transitions) on an input signal (`level`). Because it is implemented as a **Mealy machine**, the output (`tick`) responds asynchronously to input transitions, driving `tick` high as soon as `level` goes high while in state `zero`.

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
| `tick` | 1 bit | Pulse signal asserted high upon detecting a rising edge |

---

## FSM States

| State | Encoding | Description |
| :--- | :---: | :--- |
| `zero` | `1'b0` | Idle state; waiting for `level` to transition high |
| `one` | `1'b1` | Active state; indicates `level` is currently high |

---

## State Transition & Output Logic

### State `zero`:
* **If `level == 1`**: 
  * `next_state = one`
  * `tick = 1` *(Immediate combinational output assertion)*
* **If `level == 0`**: 
  * `next_state = zero`
  * `tick = 0`

### State `one`:
* **If `level == 1`**: 
  * `next_state = one`
  * `tick = 0` *(Suppresses repeated ticks while level remains high)*
* **If `level == 0`**: 
  * `next_state = zero`
  * `tick = 0`

---

## Key Characteristics

* **Mealy Output:** `tick` is dependent on both `present_state` and the immediate value of `level`, offering zero clock cycle latency on edge detection.
* **Single-Pulse Output:** Ensures `tick` is only asserted once per rising edge, remaining low even if `level` stays high across multiple clock cycles.