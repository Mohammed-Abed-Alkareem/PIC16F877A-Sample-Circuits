# PIC16F877A Sample Circuits Repository

Welcome to the **PIC16F877A Sample Circuits Repository**! This repository provides a collection of sample circuits and example codes to help developers and enthusiasts get started with the **PIC16F877A microcontroller**. Whether you are a beginner exploring microcontroller programming or an advanced user working on embedded system projects, this repository aims to be a valuable resource for you.

---

## Table of Contents
1. [Introduction to PIC16F877A](#introduction-to-pic16f877a)
2. [Repository Structure](#repository-structure)
3. [Getting Started](#getting-started)
4. [Circuit Examples](#circuit-examples)
5. [Software and Tools](#software-and-tools)
6. [Contributing](#contributing)
7. [License](#license)

---

## Introduction to PIC16F877A

The **PIC16F877A** is a powerful microcontroller developed by Microchip Technology. It is widely used in embedded systems due to its:
- 8-bit architecture
- 40-pin DIP/PDIP packaging
- Rich set of peripherals including ADC, PWM, UART, SPI, and I2C
- 368 bytes of RAM, 256 bytes of EEPROM, and 8K words of program memory

For more technical details, refer to the official [PIC16F877A Datasheet](https://www.microchip.com).

---

## Repository Structure

```plaintext
📂 PIC16F877A-Sample-Circuits
├── 📁 base
│   ├── protus_file
│   ├── 📁 assets
│   │   ├── circuit.jpg
│   │   └── other_files
├── 📁 7_segment
│   ├── protues_file
│   ├── asm_file
│   ├── hex_file
│   └── 📁 assets
│       ├── diagram.png
│       ├── demo.mp4
│       └── demo.gif
└── README.md
```

---


## Prerequisites

Before you begin, ensure you have the following:
- A **PIC16F877A** microcontroller and necessary hardware components
- A **PIC Programmer** (e.g., PICkit 3 or 4)
- Installed **MPLAB X IDE**
- Installed **MPASM Assembler** for working with ASM files
- Installed **Proteus** for circuit simulation

### Useful Links
- [MPLAB X IDE Download](https://www.microchip.com/mplab/mplab-x-ide)
- [MPASM Assembler Documentation](https://www.microchip.com/)
- [Proteus Demo Version](https://www.labcenter.com/downloads/)


---

## Circuit Examples

### Base Circuit: Connecting the Oscillator

![Oscillator Circuit](base/assets/circuit.jpg)

- **Description**: This example demonstrates how to connect an oscillator to the PIC16F877A microcontroller, ensuring stable clock operation for your projects.
- **Files**:
  - [Proteus File](base/protus_file)

---

### 7-Segment Display: Counting from 0 to 9
- **Description**: This example demonstrates interfacing a 7-segment display with the PIC16F877A microcontroller. The program loops through numbers 0 to 9 with approximately a 1-second delay between each count.

![7-Segment Circuit](7-segment/assets/circuit.jpg)

- **Files**:
  - [Proteus File](7-segment/protues_file)
  - [Assembly File](7-segment/asm_file)
  - [HEX File](7-segment/hex_file)

![Demo GIF](7-segment/assets/playback.gif)



- **Usage**: Load the HEX file into the microcontroller using Proteus or your PIC Programmer, and observe the counting sequence on the 7-segment display.

---




## Contributing

Contributions are welcome! If you have a circuit or example code to share, please:
1. Fork the repository.
2. Create a new branch: `git checkout -b feature/new-circuit`.
3. Commit your changes: `git commit -m 'Add new circuit example'`.
4. Push to the branch: `git push origin feature/new-circuit`.
5. Open a Pull Request.

---

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute the content with proper attribution.

---

