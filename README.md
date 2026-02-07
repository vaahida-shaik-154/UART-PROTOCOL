# UART Design and Verification

## 📌 Overview
This repository contains a **Universal Asynchronous Receiver/Transmitter (UART)** design implemented in Verilog, along with a structured **testbench** for functional verification.  
The project demonstrates digital design fundamentals, simulation methodology, and verification planning.

## 🛠 Features
- **UART Transmitter & Receiver** modules  
- Configurable baud rate and data width  
- Support for start/stop bits and parity (optional)  
- Synthesizable RTL design
  
- **Verilog Testbench** with stimulus generation and result checking  
- Structured simulation phases:
  1. Reset and initialization  
  2. Transmission of single character  
  3. Continuous data stream  
  4. Error injection and recovery  

## 📂 Repository Structure
```
├── src/
│   ├── uart_tx.v        # UART Transmitter
│   ├── uart_rx.v        # UART Receiver
│   └── uart_top.v       # Top-level integration
├── tb/
│   ├── uart_tb.v        # Testbench
│   └── stimulus.v       # Stimulus generation
├── docs/
│   └── waveform.png     # Example simulation waveform
└── README.md
```

## ✅ Verification Strategy
- **Directed tests** for basic functionality  
- **Randomized stimulus** for robustness  
- **Error injection** to validate recovery mechanisms  
- **Waveform analysis** for timing and protocol compliance  

## 📈 Example Results
- Successful transmission and reception of 8-bit data  
- Correct handling of start/stop bits  
- Error detection when parity mismatch occurs  

## 🚀 Future Work
- Add configurable FIFO buffers  
- Support for multiple baud rates dynamically  
- Extend verification with SystemVerilog assertions  
