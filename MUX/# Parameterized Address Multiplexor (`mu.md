# Parameterized Address Multiplexor (`multiplexor.v`)

## Overview

The `multiplexor` module is a parameterized 2-to-1 data multiplexor[cite: 1]. It selects between input `in0` and input `in1` based on the single-bit selection line `sel`[cite: 1].

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `5` | Bit width of inputs `in0`, `in1`, and output `mux_out` |

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `sel` | 1 bit | Multiplexor select signal |
| `in0` | `WIDTH` | Data input 0 |
| `in1` | `WIDTH` | Data input 1 |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `mux_out` | `WIDTH` | Multiplexed data output |

---

## Selection Logic

| `sel` | Output (`mux_out`) |
| :---: | :---: |
| `0` | `in0` |
| `1` | `in1` |