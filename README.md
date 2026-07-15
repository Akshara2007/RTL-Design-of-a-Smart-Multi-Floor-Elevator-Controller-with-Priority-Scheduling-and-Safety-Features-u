# 🚀 4-Floor Elevator Controller using Verilog HDL

## 📌 Project Overview

This project implements a **4-Floor Elevator Controller** using **Verilog Hardware Description Language (HDL)**.

The design follows a **modular RTL design approach** where the elevator system is divided into multiple functional blocks such as request management, scheduling, movement control, and FSM-based door control.

The project demonstrates the design and verification of a digital control system similar to a real-world elevator controller.

---

# ✨ Features

✅ Supports **4 Floors (Floor 0 to Floor 3)**  
✅ User floor request handling  
✅ Automatic request storage and clearing  
✅ Target floor scheduling logic  
✅ Elevator upward and downward movement control  
✅ FSM-based automatic door controller  
✅ Synchronous design using clock and reset  
✅ Modular RTL architecture  
✅ Testbench verification  
✅ Simulation waveform analysis using EPWave  

---

# 🏗️ System Architecture

The elevator controller consists of the following modules:
```text
                User Request
                     |
                     ▼
          ┌─────────────────┐
          │ Request Manager │
          └─────────────────┘
                     |
                     ▼
          ┌─────────────────┐
          │   Scheduler     │
          └─────────────────┘
                     |
                     ▼
        ┌─────────────────────┐
        │ Elevator Controller │
        └─────────────────────┘
                     |
          ┌──────────┴──────────┐
          ▼                     ▼
  ┌───────────────┐     ┌────────────────┐
  │ Current Floor │     │ Door Controller│
  └───────────────┘     │     (FSM)      │
                        └────────────────┘
                                  |
                                  ▼
                          ┌────────────┐
                          │ Door Open  │
                          └────────────┘
```
---

# 📂 Project Modules

| Module | Description |
|--------|-------------|
| `request_manager.v` | Stores incoming floor requests and clears completed requests |
| `scheduler.v` | Determines the next target floor based on pending requests |
| `elevator_controller.v` | Controls elevator movement, floor tracking, and request completion |
| `door_controller.v` | FSM-based door opening and closing control |
| `elevator_top.v` | Top-level module integrating all sub-modules |
| `elevator_tb.v` | Testbench for functional verification |

---

# 🧠 Topics Covered

### 🔹 Digital Design Concepts
- Sequential Logic Design
- Combinational Logic Design
- Registers and Flip-Flops
- Clock and Reset Handling

### 🔹 Verilog HDL
- Module Design
- Input and Output Ports
- Always Blocks
- Blocking and Non-blocking Assignments
- Parameter Declaration

### 🔹 RTL Design
- Register Transfer Level Modeling
- Hardware Modularization
- Control Logic Design
- FSM Implementation

### 🔹 Verification
- Testbench Development
- Simulation
- Waveform Generation
- Signal Analysis using EPWave

---

# 🔄 Working Principle

1️⃣ User selects a floor using the request input.

2️⃣ The **Request Manager** stores the floor request.

3️⃣ The **Scheduler** checks pending requests and selects the destination floor.

4️⃣ The **Elevator Controller** compares the current floor with the target floor and moves the elevator accordingly.

5️⃣ Once the destination is reached, the request is cleared and a door opening signal is generated.

6️⃣ The **Door Controller FSM** opens the door, keeps it open for a fixed duration, and automatically closes it.

---

# 🧩 FSM Door Controller

The door controller is designed using a Finite State Machine.

States:
CLOSED → OPEN → WAIT → CLOSED

### State Description:

🔒 **CLOSED**  
Door remains closed while the elevator is moving.

🚪 **OPEN**  
Door opens when the elevator reaches the requested floor.

⏳ **WAIT**  
Door remains open for a defined time period.

🔒 **CLOSED**  
Door closes after the waiting period.

---

# 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Verilog HDL | Hardware Description Language |
| Icarus Verilog | Simulation |
| EDA Playground | Online HDL Development Platform |
| EPWave | Waveform Visualization |

---


# 📊 Simulation Result

The elevator controller was verified using a Verilog testbench.
The simulation waveform demonstrates the functional behavior of the design.

The waveform shows:

✅ Clock and reset operation  
✅ Floor request generation  
✅ Target floor selection  
✅ Elevator floor transition  
✅ Door opening and closing sequence  

## Simulation Waveform

<img width="1898" height="918" alt="Screenshot 2026-07-15 200925" src="https://github.com/user-attachments/assets/838d1155-2d5d-42a6-a7dc-e7e5b1c70c6c" />
<img width="1884" height="630" alt="Screenshot 2026-07-15 201017" src="https://github.com/user-attachments/assets/bbe63a30-f37f-48fa-bd27-031dcdcc6800" />




# 📁 Repository Structure

```text
4-Floor-Elevator-Controller-Verilog
│
├── src
│   ├── request_manager.v
│   ├── scheduler.v
│   ├── elevator_controller.v
│   ├── door_controller.v
│   ├── elevator_top.v
│   └── elevator_tb.v
│
├── waveform
│   └── elevator_waveform.png
│
└── README.md
```<img width="1898" height="918" alt="Screenshot 2026-07-15 200925" src="https://github.com/user-attachments/assets/282061ef-3289-4589-ad2d-610ab615308e" />

# 🎯 Learning Outcomes

Through this project, the following concepts were implemented:

⭐ RTL design methodology  
⭐ FSM based control logic  
⭐ Sequential and combinational logic design  
⭐ Modular Verilog HDL development  
⭐ Simulation and waveform analysis

