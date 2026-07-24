# ADC Controller (`adc_controller.v`)

## Overview

The `adc_controller` module manages the interface and control flow for an external Analog-to-Digital Converter (ADC). It utilizes a 4-state Finite State Machine (FSM) to issue a conversion trigger, wait for the End of Conversion (`eoc`) signal, latch the raw sample data, and pulse a `data_valid` flag.

---

## Parameters

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `ADC_DATA_WIDTH` | `12` | Bit width of the ADC input data and latched output data |

---

## Signal Description

### Inputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `clk` | 1 bit | System clock signal |
| `rst_n` | 1 bit | Active-low asynchronous reset signal |
| `start_conversion` | 1 bit | Command trigger input to start an ADC reading |
| `adc_data_in` | `ADC_DATA_WIDTH` | Raw digital sample data from ADC pins |
| `eoc` | 1 bit | End-of-Conversion flag signal from the ADC |

### Outputs

| Signal | Width | Description |
| :--- | :--- | :--- |
| `adc_trigger` | 1 bit | Single-cycle trigger pulse sent to start ADC conversion |
| `data_out` | `ADC_DATA_WIDTH` | Latched ADC sample output data |
| `data_valid` | 1 bit | Single-cycle high flag indicating output data is ready |

---

## FSM State Machine

| State | Encoded Value | Description |
| :--- | :--- | :--- |
| `S_IDLE` | `2'b00` | Idle state; waits for `start_conversion` signal |
| `S_TRIGGER` | `2'b01` | Asserts `adc_trigger = 1` for 1 clock cycle |
| `S_WAIT_EOC` | `2'b10` | Waits for `eoc` to go high; latches `adc_data_in` |
| `S_VALID` | `2'b11` | Asserts `data_valid = 1` for 1 clock cycle |

---

## Operation Sequence

1. **Idle State (`S_IDLE`):** Module remains in idle until `start_conversion` is asserted high.
2. **Triggering ADC (`S_TRIGGER`):** Sends a 1-cycle `adc_trigger` pulse to initiate sampling on the hardware ADC.
3. **Waiting for Conversion (`S_WAIT_EOC`):** Waits until the ADC signals completion via `eoc`. Once `eoc` goes high, raw input `adc_data_in` is latched into `data_out`.
4. **Data Ready (`S_VALID`):** Drives `data_valid` high for 1 clock cycle to signal downstream logic that new data is available, then returns to `S_IDLE`.