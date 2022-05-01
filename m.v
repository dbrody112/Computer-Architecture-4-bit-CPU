//modified start from https://gitlab.com/ric96/ice-core/-/blob/8bit/core.v

`define SUBI  4'd0  //: R[dest] = R[op1] - const
`define LDUR  4'd1  // dest, op1, offset  : R[dest] = M[R[op1] + offset]
`define STUR 4'd2  // dest, src, offset  : M[R[op1] + offset] = R[src]
`define ADDI   4'd3  // dest, const        : : R[dest] = R[op1] + const
`define BL    4'd4  // dest, op1, op2     : R[dest] = PC + branch address
`define ANDI    4'd5  // dest, op1, op2     : R[dest] = R[op1] & const
`define BEQ   4'd6  // dest, op1, op2     : R[0] = R[op2] if (R[dest] == const ? 2 : 1)
`define BLT  4'd7  // dest, op1, op2     : R[0] = R[op2] if (R[dest] != const ? 2 : 1)
`define ADD   4'd8  // dest, op1, op2     : R[dest] = R[op1] + R[op2]
`define SUB   4'd9  // dest, op1, op2     : R[dest] = R[op1] - R[op2]
`define LSL   4'd10 // dest, op1, op2     : R[dest] = R[op1] << R[op2]
`define LSR   4'd11 // dest, op1, op2     : R[dest] = R[op1] >> R[op2]
`define AND   4'd12 // dest, op1, op2     : R[dest] = R[op1] & R[op2]
`define OR    4'd13 // dest, op1, op2     : R[dest] = R[op1] | R[op2]
`define NOT   4'd14 // dest, op1          : R[dest] = ~R[op1]
`define XOR   4'd15 // dest, op1, op2     : R[dest] = R[op1] ^ R[op2]

module tb;

    initial

        $display ("Hello World!");
endmodule

//modified start from https://github.com/robmarano/ece251_at_cooper/blob/mips_cpu-single_cycle/MIPS/mips_single_cycle_computer/mips_single_cycle.sv

module maindec(input logic [3:0] op, 
               output logic memread, memwrite, 
               output logic branch, alusrc,
               output logic regdst, regwrite,
               output logic aluop);
    
    logic [6:0] controls;

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg,aluop} = controls;
    
    always @*
    case(op)
        `ADD | `SUB | `LSL | `LSR | `AND | `OR | `NOT | `XOR : controls <= 7'b1100001; //R
        `LDUR : controls <= 7'b1000010; //load
        `STUR : controls <= 7'b0000100; // write
        `ADDI | `SUBI | `ANDI : controls <= 7'b1010001; // I
        `BEQ | `BLT : controls <= 7'b0101000; // CB
        `BL : controls <= 7'b0001000; // B
        default: controls <= 7'bxxxxxxx;
    endcase
endmodule

module generatefunc(input logic [3:0] op,
                    output logic [3:0] alucontrol);
    
    always @*
    case(op)
        `ADD | `ADDI : alucontrol <= 4'b0001;
        `SUB | `SUBI : alucontrol <= 4'b0010;
        `LSL : alucontrol <= 4'b0011;
        `LSR : alucontrol <= 4'b0100;
        `AND | `ANDI : alucontrol <= 4'b0101;
        `OR : alucontrol <= 4'b0110;
        `XOR : alucontrol <= 4'b0111;
        `NOT : alucontrol <= 4'b1000;
    endcase
endmodule


        

