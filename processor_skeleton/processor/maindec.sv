//modified start from https://gitlab.com/ric96/ice-core/-/blob/8bit/core.v

//R-Type

`define AND  4'd0  
`define OR  4'd1  
`define NOR 4'd2  
`define ADD   4'd3  
`define SUB   4'd4  
`define MUL   4'd5  
`define MFHI  4'd6  
`define MFLO  4'd7  
`define DIV   4'd8  
`define SLT   4'd9  

//I-type

`define LOAD   4'd10 
`define STORE  4'd11 
`define ADDI  4'd12 
`define SUBI  4'd13 
`define BEQ   4'd14 

// J-Type

`define B     4'd15 

//modified start from https://github.com/robmarano/ece251_at_cooper/blob/mips_cpu-single_cycle/MIPS/mips_single_cycle_computer/mips_single_cycle.sv

module maindec(input logic [3:0] op, 
               output logic memread, memwrite, 
               output logic branch, alusrc,
               output logic regdst, regwrite,
               output logic [1:0] aluop, jump);
    
    logic [8:0] controls;

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg,jump,aluop} = controls;
    
    always @*
    case(op)
        `AND | `OR | `NOR | `ADD | `SUB | `MUL | `MFHI | `MFLO | `DIV | `SLT : controls <= 9'b110000010; //R
        `LOAD : controls <= 9'b101001000; //load
        `STORE : controls <= 9'b001010000; // write
        `ADDI | `SUBI : controls <= 9'101000000; // I
        `BEQ : controls <= 9'b000100001; // CB
        `B : controls <= 9'b000000100; // J-type
        default: controls <= 9'bxxxxxxxxx;
    endcase
endmodule




        