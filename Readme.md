<h1 align="center">ECE-251 - Computer Architecture - 4-bit Computer <br /> by Colin Hwang and Dan Brody <br />





## <u>Design Decisions</u>
<p>
  For our project, we decided to build a 4-bit CPU using verilog. Therefore, we have a 4 bit ALU operand bit width and and a 4 bit address bus. We also decided that we will be using 16 registers sinc we register address is 4 bits (2^4 = 16). We will have a register for the return address (LR), the stack pointer (SP), the frame pointer (FP) and for the zero register (XZR). The remaining 12 registers are divided equally between temporary, saved, and argument registers. Instructions will be 16 bits and they will be byte addressable, meaning it will take 4 PC (program counter) increments to retrieve and instruction. More on the instruction set architecture will be in the next section.
  </p>


## <u>Instruction Set Architecture</u>

![](https://github.com/dbrody112/Computer-Architecture-4-bit-CPU/blob/Colin/Images/ISA.png?raw=true)

<p>
  Instructions are byte addressable.

## <u>Memory Map</u>





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
