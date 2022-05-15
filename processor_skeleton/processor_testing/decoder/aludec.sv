//modified start from https://gitlab.com/ric96/ice-core/-/blob/8bit/core.v

//R-Type

`define AND  4'd0  
`define OR  4'd1  
`define NOR 4'd2  
`define ADD   4'd3  
`define SUB   4'd4  
`define MOVZ   4'd5  
`define LSL  4'd6  
`define LSR  4'd7  
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

module aludec(input logic [3:0] op,
              input logic [1:0] aluop,
              output logic [3:0] alucontrol);
    always @*
    case(aluop)
        2'b00 : case(op)
                    `ADDI : alucontrol <= 3'b000;
                    `SUBI : alucontrol <= 3'b001;
        endcase
        2'b01 : alucontrol <= 3'b001; //sub for BEQ
        default: case(op)
            `ADD : alucontrol <=4'b0000;
            `SUB : alucontrol <=4'b0001;
            `AND : alucontrol <=4'b0010;
            `OR : alucontrol <= 4'b0011;
            `NOR : alucontrol <= 4'b0010;
            `MOVZ : alucontrol <= 4'b0100;
            `DIV : alucontrol <= 4'b0101;
            `SLT :alucontrol <= 4'b0110;
            `LSL : alucontrol <= 4'b1000;
            `LSR : alucontrol <= 4'b1001;
        endcase
    endcase
endmodule

