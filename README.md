# 16-Bit RISC Processor Design

A custom-designed 16-bit Reduced Instruction Set Computer (RISC) processor implemented in Verilog HDL. The processor follows a load–store architecture with fixed-length instructions, a register-based datapath, and a hardwired control unit. The design is modular and verified through simulation.

---

## Overview

This project implements a 16-bit RISC processor to demonstrate core concepts of computer architecture, including instruction set design, datapath organization, and control logic. The design emphasizes simplicity, modularity, and architectural clarity, while supporting a rich set of arithmetic, logical, memory, and control-flow operations.

All computational operations are performed on registers, and memory access is restricted to explicit load and store instructions, consistent with RISC principles.

---

## Processor Features

- 16-bit instruction and data width  
- Load–store RISC architecture  
- Fixed-length instruction format  
- Register-based execution model  
- Hardwired control unit  
- Support for multiple addressing modes  
- Modular Verilog RTL implementation  
- Simulation-based functional verification  

---

## Instruction Set Overview

The processor supports the following instruction categories:

### Arithmetic and Logical Instructions
ADD, SUB, INC, DEC, AND, OR, XOR, NOT, CMP

### Shift and Rotate Instructions
SHL, SHR, ROL, ROR,  
Arithmetic Shift Left (AHL), Arithmetic Shift Right (AHR)

### Control Flow Instructions
BEQ (Branch if Equal)  
BNE (Branch if Not Equal)  
JMP (Jump)

### Data Movement Instructions
LOD (Load Memory to Register)  
STR (Store Register to Memory)  
MOV (Register to Register)

### System and I/O Instructions
CLR (Clear), SET  

---

## Addressing Modes

The processor supports:
- Direct addressing  
- Indirect addressing  
- Immediate addressing (where applicable, including offset-based operations)

---

## Architecture Description

The processor consists of the following core components:

- Program Counter (PC)  
- Instruction Register  
- Register File  
- Arithmetic Logic Unit (ALU)  
- Control Unit  
- Instruction and Data Memory Interface  

Instruction execution is coordinated by a hardwired control unit that generates control signals for fetch, decode, execute, and write-back phases.

---
