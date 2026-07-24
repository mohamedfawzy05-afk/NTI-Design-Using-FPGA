# 1-Bit Full Adder (`full_adder.v`)

## Overview

The `full_adder` module implements a standard 1-bit full adder using combinational dataflow logic. It computes the sum and carry-out for two binary operand inputs (`a` and `b`) along with an incoming carry signal (`cin`).

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `a` | 1 bit | First binary operand input |
| `b` | 1 bit | Second binary operand input |
| `cin` | 1 bit | Carry-in signal from previous stage |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `sum` | 1 bit | Resulting sum output |
| `cout` | 1 bit | Resulting carry-out output |

---

## Boolean Logic Equations

* **Sum:** $Sum = a \oplus b \oplus cin$
* **Carry Out:** $C_{out} = (a \cdot b) + (cin \cdot (a \oplus b))$

---

## Truth Table

| `a` | `b` | `cin` | `sum` | `cout` |
| :---: | :---: | :---: | :---: | :---: |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |
