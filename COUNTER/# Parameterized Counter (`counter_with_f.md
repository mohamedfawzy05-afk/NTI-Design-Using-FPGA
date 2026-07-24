# Parameterized Counter (`counter_with_function.v`)

## Overview

The `counter_with_function` module is a parameterized up-counter that evaluates state transitions using an internal function (`get_next_count`). It supports an asynchronous active-high reset, a synchronous parallel load, and a count enable signal.

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `5` | Bit width of the counter and input/output data lines |

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `rst` | 1 bit | Asynchronous active-high reset signal |
| `load` | 1 bit | Synchronous load enable signal |
| `en` | 1 bit | Count enable signal |
| `count_in` | `WIDTH` | Parallel input data value to load into the counter |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `count_out` | `WIDTH` | Current counter output value |

---

## Operation & Priority Logic

The internal `get_next_count` function evaluates the next state according to the following priority order:

1. **Reset (`rst`):** Asynchronously resets `count_out` to `0`.
2. **Load (`load`):** Synchronously sets `count_out` to `count_in`.
3. **Enable (`en`):** Synchronously increments `count_out` by `1`.
4. **Hold:** If neither `load` nor `en` is active, the counter holds its current value.