<h1 align="center">🚦 FPGA Design Flow with Traffic Light Controller</h1>

<p align="center">
  <img src="https://img.shields.io/badge/HDL-Verilog-blue.svg" />
  <img src="https://img.shields.io/badge/EDA-Xilinx%20Vivado-brightgreen.svg" />
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  <img src="https://img.shields.io/badge/Status-Completed-success.svg" />
</p>


## 📌 Overview  

This project implements a **Finite State Machine (FSM)-based Traffic Light Controller** for a **4-way intersection with right-turn handling**.  
The controller cycles through **8 distinct traffic states**, ensuring smooth, time-efficient, and conflict-free vehicle movement in all directions.  

👉 Designed as part of my FPGA learning journey, it demonstrates **RTL design, verification, and real hardware testing** using a Boolean FPGA board.  

---

## ✨ Key Features  

- 🟢 **8-State FSM** – handles straight & right-turn flows.  
- ⚡ **Fully synchronous design** – implemented in Verilog HDL.  
- 🔄 **Complete FPGA Design Flow** – RTL → Simulation → Synthesis → Implementation → Bitstream.  
- 🛠️ **Real-time Hardware Testing** – validated on **Boolean FPGA Board**.  
- 📊 Ideal for **traffic simulations, embedded systems, and FPGA training projects**.  

---

## 🏗️ Design Details  

### 🔹 Timing Description  
<img width="800" alt="FSM Diagram" src="https://github.com/user-attachments/assets/96254f8f-7682-4b9b-9e31-c1b9b7f72ab3" />  

### 🔹 Block Diagram  
<img width="800" alt="Block Diagram" src="https://github.com/user-attachments/assets/fddd13b0-c79f-4c64-9683-acee73e6f283" />  

---

## 📂 Project Structure  
```
├── rtl/ # Verilog modules (FSM + Top-level)
├── constraints/ # XDC file for FPGA pin mapping
├── simulation/ # Testbenches + Waveform outputs
├── assets/ # Docs + Images
├── README.md # Project documentation
```


---

## 🛠️ Tools & Technologies  

- **Language**: Verilog HDL  
- **EDA Tool**: Xilinx Vivado Design Suite  
- **Hardware**: Boolean FPGA Board  
- **Methodology**: FSM-based synchronous design  

---

## 🚀 Demo & Results  

✅ Simulated in Vivado with proper state transitions.  
✅ Successfully synthesized & implemented.  
✅ Deployed on **Boolean FPGA Board** for hardware verification.  

*(Insert GIF/screenshot of simulation waveform or FPGA output if available)*  

---

## 📜 License  

This project is licensed under the **MIT License** – free to use and modify.  

---

## 🙌 Contributing  

Feel free to **fork this repo**, suggest improvements, or open issues.  
If you’d like to add new features, contributions are welcome!  

---

🔥 With this project, I showcased how **FPGAs can bring real-world embedded applications to life** using **efficient FSM-based RTL design**.  
