# Digital Clock, Stopwatch & Timer using Verilog HDL

## 📌 Project Overview
This project is a **Verilog HDL-based RTL design** that implements a multifunction digital system combining a **Digital Clock, Stopwatch, and Countdown Timer**. It demonstrates core concepts of digital design such as **synchronous counters, finite state machines (FSM), and sequential logic design**.

The design is suitable for FPGA implementation and simulation-based verification.

---

## ⚙️ Features

### 🕒 Digital Clock
- Displays time in HH:MM:SS format
- 24-hour format support
- Automatic increment of seconds, minutes, and hours
- Reset functionality

### ⏱️ Stopwatch
- Start / Stop control
- Reset functionality
- Counts upward in seconds

### ⏲️ Countdown Timer
- User-defined time input
- Counts down to zero
- Alarm/flag when time reaches zero

---

## 🧠 Design Concepts Used
- Verilog HDL (RTL Design)
- Synchronous Counters
- Finite State Machine (FSM)
- Clock Division (conceptual for FPGA)
- Sequential Logic Design
- Multiplexed mode control

---

## 🏗️ System Architecture

The system operates in multiple modes:

- **Mode 0 → Digital Clock**
- **Mode 1 → Stopwatch**
- **Mode 2 → Timer**

A control FSM selects the active module based on user input.

---

## 📁 File Structure
