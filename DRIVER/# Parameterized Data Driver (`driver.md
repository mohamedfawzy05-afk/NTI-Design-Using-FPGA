# Parameterized Data Driver (`driver.v`)

## Overview

The `driver` module is a parameterized tri-state bus driver[cite: 3]. When enable signal `data_en` is high, the output `data_out` reflects input `data_in`[cite: 3]. When disabled, `data_out` is placed in a high-impedance state (`Z`)[cite: 3].

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `WIDTH` | `8` | Bit width of `data_in` and `data_out`[cite: 3] |

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `data_en` | 1 bit | Active-high driver enable signal[cite: 3] |
| `data_in` | `WIDTH` | Input data bus[cite: 3] |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `data_out` | `WIDTH` | Tri-state output data bus[cite: 3] |

---

## Behavior Logic

| `data_en` | Output (`data_out`) | Description |
| :---: | :---: | :--- |
| `1` | `data_in` | Data passed directly to output[cite: 3] |
| `0` | High-Impedance (`'bz`) | Output disconnected/tri-stated[cite: 3] |