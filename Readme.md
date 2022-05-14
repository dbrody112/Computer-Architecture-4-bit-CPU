<h1 align="center">ECE-251 - Computer Architecture - 8-bit Computer <br /> by Colin Hwang and Dan Brody <br />





## <u>Design Decisions</u>
<p>
  For our project, we decided to build a 8-bit CPU using verilog. Therefore, we have a 8 bit ALU operand bit width and and a 8 bit address bus. We also decided that we will be using 16 registers sinc we register address is 4 bits (2^4 = 16). We will have a register for the return address (LR), the stack pointer (SP), the frame pointer (FP) and for the zero register (XZR). The remaining registers will be split up between one saved register and three general purpose registers. Instructions will be 16 bits and they will be byte addressable in memory. This means it will take 2 PC (program counter) increments to retrieve and instruction. More on the instruction set architecture will be in the next section.
  </p>


## <u>Instruction Set Architecture</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/ISA.png?raw=true)

<p>
  Instructions are byte addressable.

## <u>Memory Map</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/memory.png?raw=true)

<p>
  Our 8-bit CPU utilizes a Von Neumann memory layout. Since a Von Neumann memory architecture is being used, both Imem (instruction memory) and Dmem (data memory) will be combined into one holistic memory unit but will be modeled as two separate units. Imem will load up the instruction from the unified memory while Dmem is the memory that you read and write from.
  </p>
  <p>
  Since we are using 16 bit width instructions, each instruction will require 2 bytes to be represented in memory. As seen in the model above, since the address width is 8 bits, we can represent 2^8 = 256 bits in memory. This design is also byte addressable. Therefore, each instruction will take up 2 address numbers in memory. We decided to let both Imem and Dmem to take up 2^6 = 128 bits in memory. Therefore, Imem addresses will go from 0x00 to 0x3E while Dmem addresses will go from where Imem left off from to 0xFe. 


## <u>Memory</u>

### **Imem:**




### Dmem:



## <u>Controller</u>

### Main Decoder:





### ALU Decoder:





## <u>Datapath</u>





## <u>Von Neumann Design</u>





## <u>Instruction Programs</u>





## <u>GTKwave Timing Diagram for Instructions</u> 

### RType (register type):





### IType (immediate type)





### Jtype (jump type):





## <u>Conclusion and Results</u>









### 
