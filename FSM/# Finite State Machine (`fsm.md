# Finite State Machine (`fsm.v`)

## Overview

The `fsm` module implements a 3-state Finite State Machine (FSM) with an active-low asynchronous reset. It transitions through states based on control inputs `a` and `b` and generates two output signals, `y0` and `y1`.

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `reset` | 1 bit | Active-low asynchronous reset signal |
| `a` | 1 bit | Control input signal |
| `b` | 1 bit | Control input signal |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `y0` | 1 bit | Combinational output signal |
| `y1` | 1 bit | State-dependent output signal |

---

## States

| State | Encoded Value | Description |
| :--- | :--- | :--- |
| `S0` | `2'b00` | Initial / Idle state |
| `S1` | `2'b01` | Intermediate state |
| `S2` | `2'b10` | Terminal / Active output state |

---

## State Transition & Output Logic

### Outputs Default
* `y0` defaults to `0`
* `y1` defaults to `1`

### State Behaviors

1. **State `S0`**:
   * **Output:** `y0 = a & b`, `y1 = 1`
   * **Next State:**
     * If `!a` $\rightarrow$ remain in `S0`
     * Else if `b` $\rightarrow$ go to `S2`
     * Else $\rightarrow$ go to `S1`

2. **State `S1`**:
   * **Output:** `y0 = 0`, `y1 = 1`
   * **Next State:**
     * If `a` $\rightarrow$ go to `S0`
     * Else $\rightarrow$ remain in `S1`

3. **State `S2`**:
   * **Output:** `y0 = 0`, `y1 = 0`
   * **Next State:** Unconditionally returns to `S0`