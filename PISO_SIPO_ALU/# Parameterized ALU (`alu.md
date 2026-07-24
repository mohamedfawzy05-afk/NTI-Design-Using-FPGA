# Parameterized ALU (`alu.v`)

## Overview

The `alu` module implements a parameterized $W$-bit Arithmetic Logic Unit (ALU). It performs basic arithmetic, logic, and pass-through operations on two inputs (`in_a` and `in_b`) controlled by a 3-bit operation select line (`opsel`) and an enable signal (`alu_en`). Additionally, it includes a dedicated zero-detection output flag for input `in_a`.

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `W` | `8` | Bit width of operands `in_a`, `in_b`, and output `alu_out` |

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `in_a` | `W` | Operand A input |
| `in_b` | `W` | Operand B input |
| `opsel` | 3 bits | Operation selection code |
| `alu_en` | 1 bit | ALU output enable control |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `a_zero` | 1 bit | Flag indicating whether `in_a` equals zero (`1` if zero, `0` otherwise) |
| `alu_out` | `W` | Resulting output of the specified operation |

---

## Operation Table (`opsel`)

When `alu_en = 1`, the operation executed is determined by `opsel`:

| `opsel` | Operation | Name | Description |
| :---: | :---: | :---: | :--- |
| `3'b000` | `in_a + in_b` | **ADD** | Bitwise addition |
| `3'b001` | `in_a - in_b` | **SUB** | Bitwise subtraction |
| `3'b010` | `in_a & in_b` | **AND** | Bitwise AND logic |
| `3'b011` | `in_a ^ in_b` | **XOR** | Bitwise XOR logic |
| `3'b100` | `in_a \| in_b` | **OR** | Bitwise OR logic |
| `3'b101` | `in_a` | **PASSTHROUGH** | Passes operand `in_a` directly to output |
| `default` | `'b0` | **CLEAR** | Sets output to zero |

> **Note:** If `alu_en = 0`, `alu_out` is forced to `0` regardless of `opsel`.  
> The `a_zero` flag operates independently of `alu_en` and evaluates continuously based on `in_a`.