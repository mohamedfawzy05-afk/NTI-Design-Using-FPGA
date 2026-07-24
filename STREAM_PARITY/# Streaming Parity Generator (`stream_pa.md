# Streaming Parity Generator (`stream_parity_gen.v`)

## Overview

The `stream_parity_gen` module maintains an 8-bit sliding window of serial input data (`serial_in`) using an internal shift register and continuously calculates the even parity across the window using an embedded function (`calc_parity`).

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `reset` | 1 bit | Synchronous active-high reset signal |
| `serial_in` | 1 bit | Serial data input stream shifted in LSB-first |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `parity_out` | 1 bit | Continuous parity bit calculated over the current 8-bit window |

---

## Architecture & Operation

### 1. Sliding Window Shift Register (`shift_reg`)
* On every active edge of `clk`:
  * If `reset` is active high, `shift_reg` clears to `8'b0`.
  * Otherwise, incoming `serial_in` bits shift in from the right: `{shift_reg[6:0], serial_in}`.

### 2. Parity Calculation (`calc_parity`)
* Uses bitwise reduction XOR (`^data_window`) across the 8-bit register.
* **Even Parity Rule:**
  * `parity_out = 1` if the 8-bit window contains an **odd** number of `1`s.
  * `parity_out = 0` if the 8-bit window contains an **even** number of `1`s.