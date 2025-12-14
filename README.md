# Automatic Washing Machine Controller – Verilog

This project implements an **automatic washing machine control system**
using **Verilog HDL** based on a **Finite State Machine (FSM)**.

## Project Description
The controller manages the complete washing cycle including:
- Door safety check
- Water filling
- Detergent addition
- Washing operation
- Water draining
- Spin cycle

The system ensures proper sequencing of operations and safe locking
of the door during operation.

## FSM States
- Check Door
- Fill Water
- Add Detergent
- Wash
- Drain
- Spin

## Inputs
- clk
- rst
- start
- door_close
- filled
- detergent_added
- cycle_timeout
- drained
- spin_timeout

## Outputs
- door_lock
- motor_on
- fill_valve_on
- drain_valve_on
- done

## Tools Used
- Verilog HDL
- Visual Studio Code
- GitHub

## Author
- Your Name
