# multi-cycle-processor-VHDL

This repository contains the VHDL code for a multi-cycle processor. The project is not fully completed due to time constraints and focus on the **[mono-cycle-processor](https://github.com/gregoiremahon/mono-cycle-processor-VHDL/tree/main)** . However, it provides a good starting point for understanding the design and operation of a multi-cycle processor.
This project was created as part of the Polytech Sorbonne EI2I-3 project by Grégoire Mahon and Armand Lelong.

## Components

The project includes the following components:

1. **Arithmetic Logic Unit (ALU)**: Performs arithmetic and logical operations based on the ALUOP command. It also provides flag indicators about the result, particularly the N flag.

2. **2-to-1 Multiplexer (MUX 2 vers 1)**: Selects one of the two 32-bit input data lines to pass to the output based on the control signal.

3. **4-to-1 Multiplexer (MUX 4 vers 1)**: Selects one of the four 32-bit input data lines to pass to the output based on the control signal.

4. **32-bit Register**: Stores the 32-bit input data. The content of the register is updated with the value of DATAIN at each rising edge of the clock.

5. **64x32 RAM Memory**: Stores 64 words of 32 bits. The word at the specified address is updated with the value of DATAIN at each rising edge of the clock if the write enable signal is high.

6. **DataPath**: (Details to be added)

7. **Vector Interrupt Controller (VIC)**: Allows the main program to be interrupted if one of the two interrupt requests (IRQ0 and IRQ1) is active.

8. **Register Bank (banc_registres)**: Contains 16 32-bit registers, accessible via two read ports and one write port.

9. **Control Unit**: (Details to be added)

10. **Sign Extension**: Performs sign extension of the 8 least significant bits and the 24 least significant bits of the IR register to 32 bits.

## Usage

coming soon...

## Contributing

This project was created by Grégoire Mahon and Armand Lelong [@armagrad]. Please feel free to contribute to the project by creating pull requests or reporting issues.
