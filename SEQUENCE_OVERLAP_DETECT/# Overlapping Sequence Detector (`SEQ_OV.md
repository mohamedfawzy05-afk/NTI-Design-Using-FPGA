# Overlapping Sequence Detector (`SEQ_OVERLAP_DETECT.v`)

## Overview

The `SEQ_OVERLAP_DETECT` module is a Moore Finite State Machine (FSM) designed to continuously scan a serial bit stream (`serial_in`) and detect the 6-bit pattern **`110101`**. It supports overlapping sequence detection and asserts the `sequence_detected` flag when the complete sequence is matched.

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `reset` | 1 bit | Active-high asynchronous reset signal |
| `serial_in` | 1 bit | Serial input data stream |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `sequence_detected` | 1 bit | High whenever the FSM is in state `S6` (pattern `110101` detected) |

---

## FSM States & Sequence Tracking

| State | Binary | Tracked Prefix | `sequence_detected` | Description |
| :--- | :---: | :---: | :---: | :--- |
| `S0` | `3'b000` | None | `0` | Reset / Initial state |
| `S1` | `3'b001` | `1` | `0` | First `1` detected |
| `S2` | `3'b010` | `11` | `0` | Second `1` detected |
| `S3` | `3'b011` | `110` | `0` | `0` detected after `11` |
| `S4` | `3'b100` | `1101` | `0` | `1` detected after `110` |
| `S5` | `3'b101` | `11010` | `0` | `0` detected after `1101` |
| `S6` | `3'b110` | `110101` | `1` | Full pattern matched |

---

## State Transition Logic

| Current State | Input (`serial_in = 0`) | Input (`serial_in = 1`) |
| :---: | :---: | :---: |
| **`S0`** | `S0` | `S1` |
| **`S1`** | `S0` | `S2` |
| **`S2`** | `S3` | `S2` |
| **`S3`** | `S0` | `S4` |
| **`S4`** | `S5` | `S2` |
| **`S5`** | `S0` | `S6` |
| **`S6`** | `S0` | `S2` |

---

## Key Characteristics

* **Target Sequence:** `110101`
* **Moore Architecture:** Output `sequence_detected` depends strictly on the current state (`S6`), preventing combinational output glitches.
* **Overlapping Support:** Upon reaching state `S6` (`110101`), if a `1` is received, the FSM transitions directly to state `S2` (`11`), reusing the trailing `1` from the matched sequence to start detecting the next sequence immediately.