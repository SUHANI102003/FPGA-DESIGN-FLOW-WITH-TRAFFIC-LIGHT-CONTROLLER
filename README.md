# FPGA-DESIGN-FLOW-WITH-TRAFFIC-LIGHT-CONTROLLER-USING-XILINX-BOOLEAN-BOARD

## Overview

This project implements a Finite State Machine (FSM)-based traffic light controller designed to manage a 4-way road intersection. The system cycles through **8 traffic states with right-turn handling**, ensuring an organized and time-efficient control of vehicle movement in all directions. It is ideal for use in traffic simulation and embedded system applications.

## Features

- **8-state FSM** for controlling signals in all four directions.
- Fully synchronous design using Verilog HDL.
- Complete FPGA design flow:
  - RTL Design & Analysis
  - Synthesis
  - Implementation
  - Bitstream Generation
- Real-time hardware testing on a **Boolean FPGA board**.

## Tools & Technologies

- **Xilinx Vivado Design Suite** – for the full FPGA development flow.
- **Verilog HDL** – for FSM implementation.
- **Boolean FPGA Board** – for hardware verification and real-time testing.

## Design Details
### BLOCK DIAGRAM
![](https://github.com/SUHANI102003/FPGA-DESIGN-FLOW-WITH-TRAFFIC-LIGHT-CONTROLLER/blob/main/assets/images/Screenshot%202025-08-03%20052922.png)



## Project Structure
```
├── rtl/ # Verilog files for FSM and top-level module
├── constraints/ # XDC constraints file for FPGA board pin mapping
├── simulation/ # Testbenches and waveform outputs
├── assets / # Documents and images
├── README.md # Project documentation
```

## License

This project is licensed under the MIT License.

---

Feel free to fork this repo, contribute improvements, or suggest features!


