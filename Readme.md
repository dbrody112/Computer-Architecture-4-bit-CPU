<h1 align="center">ECE-251 - Computer Architecture - 8-bit CPU <br /> by Colin Hwang and Dan Brody <br />





## <u>Design Decisions</u>
<p>
  For our project, we decided to build a 8-bit CPU using verilog. Therefore, we have a 8 bit ALU operand bit width and a 8 bit address bus. We also decided that we will be using four registers: 1 zero register and 3 general purpose registers. Instructions will be 16 bits and they will be byte addressable in memory. This means it will take 2 PC (program counter) increments to retrieve and instruction. More on the instruction set architecture will be in the next section.
  </p>


## <u>Instruction Set Architecture</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/isa2.png?raw=true)

<p>
  For our ISA, we used 16 bit instructions with three main instruction types: R (register) type, I (immediate) type, and J (jump) type.
</p>
<p>
  For R types, we allocated 4 bits for opcode, two bits for Rs, 6 bits for shamt (shift amount), 2 bits for Rt and 1 bit for Rd. All instructions use 4 bits for opcode, and each will have their own unique opcode (2^4 = 16 "unique" opcodes). Note that shamt is only useful for 3 bits since our processor is 8-bit but to fill the space we needed a 6-bit shamt
</p>
<p>
  For I types, we allocated 4 bits for opcode, 2 bits for Rs, 2 bits for Rt, and 8 bits for the immediate. This will allow us to represent the immediate with values up to 255.
</p>
<p>
   Lastly, for our J type, we allocated 4 bits for the opcode and 12 bits for the address. 12 bits is more than enough the jump instruction since there are 256 (2^8) memory addresses implemented in our memory architecture so in referencing addresses we only use the first 8 bits.
</p>

## <u>Memory Map</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/memory.png?raw=true)

<p>
  Our 8-bit CPU utilizes a Von Neumann memory layout. Since a Von Neumann memory architecture is being used, both Imem (instruction memory) and Dmem (data memory) will be combined into one holistic memory unit but will be modeled as two separate units. Imem will load up the instruction from the unified memory while Dmem is the memory that you read and write from.
  </p>
  <p>
  Since we are using 16 bit width instructions, each instruction will require 2 bytes to be represented in imem. As seen in the memory map above, since the address width is 8 bits, we can represent 2^8 = 256 bits in memory. This design is also byte addressable. Therefore, each instruction will take up 2 address numbers in memory. We decided to let both Imem and Dmem to each a size of 128 bits. Therefore, Imem addresses will take up the bottom 128 bits while Dmem addresses will take up the top 128 bits. Dmem will be given address a, what data to write from memory (wd), and what data to read from memory (rd). When write enabled goes high and is on a positive clock edge, the address and data will be written to dmem. 

## <u>Controller</u>    
    
    
![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/main/Images/control_signals.png?raw=true)
    
    
### Main Decoder:
    
![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/main_dec.png?raw=true)
    
<p>
  Our ISA defines each instruction as having a different opcode. Using 4 bits for our opcode allows for the assignment of 2^4 = 16 unique opcodes for the 16 address we will use. Therefore, we define each instruction and assign the opcode given to the instruction from the ISA. The decoder uses the first four bits of the instruction (the opcode) loaded from imem to determine which control signals are used. The control signals for each instruction are defined under the section labeled "Controller Signals". After identifying the control signals for the given instruction, the main decoder will output each control signal. We particarly care about outputing the aluop for the ALU decoder.
  
</p>

### ALU Decoder:

  ![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/main/Images/ALU_deco.png?raw=true)
<p>
  The output of the main decoder is the input of the ALU decoder. The ALU decoder takes in two inputs: the opcode of the instruction and aluop. Just as we did in the main decoder, we must define each register and assign the appropriate 4-bit opcode. Using the aluop input, instructions are assigned an ALU control 4-bit binary number so the ALU will know which operation to use when it recieves the instruction. 
</p>

## <u>Datapath</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/main/Images/datapath.png?raw=true)
  
 The datapath is where the bits outside of the opcode are decoded into register 1, register 2, etc. and ALU operations occur. The datapath also serves to act as logic for the next instruction. If no branching /jumping occurs, since the length of our address bus is 8 bits and the addresses are byte-addressable, then the next instruction is PC + 2. If any branching/jumping occurs however the program counter can be traced back or moved forward. (refer to the block diagram).


  
## <u>Wired-up Block Diagram</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/main/Images/blockdiagram.png?raw=true)

  <p>
    Block diagram design derived from figure 4.23 in the textbook used for ECE-251.
  </p>


## <u>Functionality Demonstration</u>
  
```
Assembly Language             Machine Code
  
ADDI X3, XZR, #0              1100110000000000     //count
ADDI X1, XZR, n               1100010000000101    (n = 5)
ADDI X2, XZR, #1              1100100000000001     //#1
BEQ X1, X2, #28                1110011000000111      //cond

SUBI X1, X1, #1               1101010100000001     
ADDI X3, X3, #1               1100111100000001
B    #8                       1111000000001000
ADD XZR, XZR, XZR             0000000000000000
```
<p>
  <ul>
    <li>During the first clock cycle, all registers will be set to arbitrary values xxxxxxxx in imem.
      <li> During the third, fifth, and seventh time cycles, registers X1, X2, and X3 will be set to 0,1, and n respectively. Recall that it will take two clock cycles to retrieve an instruction.
    <li> During the ninth time cycle, X1 and X2 will be compared, and if the two values are not equal, BEQ is not satisfied and the code will continue.
    <li> During the eleventh time cycle, X1 will be subtracted by the immediate value of one.
    <li> During the thirteenth time cycle, branch will retrieve the instruction at the second memory address.
    <li> During the fifteenth time cycle X3 will be incremented
    <li> time cycles three through thirteen will be repeated until X1 and X2 are equal and satisfy the BEQ instruction.
      When they do the loop will be exited.
  </p>
  
  
## <u>GTKwave Timing Diagram Results</u> 

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/main/Images/gtkwave.png?raw=true)








### 
