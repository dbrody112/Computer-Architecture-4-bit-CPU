//modified start from https://gitlab.com/ric96/ice-core/-/blob/8bit/core.v

//R-Type

`define AND  4'b0000  
`define OR  4'b0001  
`define NOR 4'b0010  
`define ADD   4'b0011  
`define SUB   4'b0100  
`define XOR   4'b0101  
`define LSL  4'b0110  
`define LSR  4'b0111  
`define DIV   4'b1000 
`define SLT   4'b1001 

//I-type

`define LOAD   4'b1010 
`define STORE  4'b1011 
`define ADDI  4'b1100 
`define SUBI  4'b1101 
`define BEQ   4'b1110 

// J-Type

`define B     4'b1111 

//modified start from https://github.com/robmarano/ece251_at_cooper/blob/mips_cpu-single_cycle/MIPS/mips_single_cycle_computer/mips_single_cycle.sv

module maindec(input logic [3:0] op,
               input logic zero,
               output logic memread, memwrite, 
               output logic pcsrc, alusrc,
               output logic regdst, regwrite,
               output logic [1:0] aluop,
               output logic jump);
    
    logic [8:0] controls;
    logic branch;

    assign {regwrite, regdst, alusrc, branch, memwrite, memread,jump,aluop} = controls;
    
    

    always @*
    
    case(op)

    //R-type
        
        `AND: controls <= 9'b110000010; //R
        `OR: controls <= 9'b110000010; //R
        `NOR: controls <= 9'b110000010; //R
        `ADD: controls <= 9'b110000010; //R
        `SUB: controls <= 9'b110000010; //R
        `XOR: controls <= 9'b110000010; //R
        `LSL: controls <= 9'b110000010; //R
        `LSR: controls <= 9'b110000010; //R
        `DIV: controls <= 9'b110000010; //R
        `SLT : controls <= 9'b110000010; //R

    //load
        `LOAD : controls <= 9'b101001000; //load

    //write
        `STORE : controls <= 9'b001010000; // write

    //I-type
        `ADDI : controls <= 9'b101000000; // I
        `SUBI : controls <= 9'b101000000; // I

    //CB
        `BEQ : controls <= 9'b000100001; // CB

    //J
        `B : controls <= 9'b000000100; // J-type
        default: controls <= 9'bxxxxxxxxx; 

    endcase

    assign pcsrc = branch & zero;

    

endmodule