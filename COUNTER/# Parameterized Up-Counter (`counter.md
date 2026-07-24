# Parameterized Up-Counter (`counter.v`)

## Overview

A simple $N$-bit up-counter with reset, parallel load, and enable control signals.

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `5` | Bit width of the counter and data lines |

---

## Signals

| Signal | Type | Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1 bit | System clock signal |
| `rst` | Input | 1 bit | Active-high reset signal |
| `load` | Input | 1 bit | Synchronous load enable |
| `en` | Input | 1 bit | Count enable signal |
| `count_in` | Input | `WIDTH` | Value to load into counter |
| `count_out` | Output | `WIDTH` | Current counter output |

---

## Priority Logic

1. **Reset (`rst`):** Resets `count_out` to `0`.
2. **Load (`load`):** Loads `count_in` directly into `count_out`.
3. **Enable (`en`):** Increments `count_out` by `1` on each clock edge.