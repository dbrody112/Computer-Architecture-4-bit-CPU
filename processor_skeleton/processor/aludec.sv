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

module aludec(input logic [3:0] op,
              input logic [1:0] aluop,
              output logic [3:0] alucontrol);
    always @*
    case(aluop)
        2'b00 : case(op)
                    `ADDI : alucontrol <= 4'b0000;
                    `SUBI : alucontrol <= 4'b0001;
                    default: alucontrol <= 4'bxxxx;
        endcase
        2'b01 : alucontrol <= 3'b001; //sub for BEQ
        default: case(op)
            `ADD : alucontrol <=4'b0000;
            `SUB : alucontrol <=4'b0001;
            `AND : alucontrol <=4'b0010;
            `OR : alucontrol <= 4'b0011;
            `NOR : alucontrol <= 4'b0100;
            `XOR : alucontrol <= 4'b0101;
            `DIV : alucontrol <= 4'b0110;
            `SLT :alucontrol <= 4'b0111;
            `LSL : alucontrol <= 4'b1000;
            `LSR : alucontrol <= 4'b1001;
        endcase
    endcase
endmodule