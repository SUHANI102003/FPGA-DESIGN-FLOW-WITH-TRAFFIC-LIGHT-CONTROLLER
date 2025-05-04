# FPGA-DESIGN-FLOW-WITH-TRAFFIC-LIGHT-CONTROLLER-USING-XILINX-BOOLEAN-BOARD

## Overview

This project implements a Finite State Machine (FSM)-based traffic light controller designed to manage a 4-way road intersection. The system cycles through **8 traffic states**, ensuring an organized and time-efficient control of vehicle movement in all directions. It is ideal for use in traffic simulation and embedded system applications.

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

- Each state represents a specific traffic flow combination (e.g., North-South green, East-West red, etc.).
- State transitions are governed by a timing counter.
- LED outputs used on the FPGA board to represent traffic lights for each direction.

## Project Structure
├── rtl/ # Verilog files for FSM and top-level module

├── constraints/ # XDC constraints file for FPGA board pin mapping

├── simulation/ # Testbenches and waveform outputs

├── bitstream/ # Generated bitstream file

├── README.md # Project documentation



## How to Use

1. Clone the repository and open the project in **Vivado**.
2. Add the Verilog source and constraints files to a new project.
3. Run **synthesis**, **implementation**, and **bitstream generation**.
4. Upload the bitstream to the **Boolean FPGA board**.
5. Observe traffic light behavior through onboard LEDs.

## License

This project is licensed under the MIT License.

---

Feel free to fork this repo, contribute improvements, or suggest features!


