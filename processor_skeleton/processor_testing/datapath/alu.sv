`ifndef ALU
`define ALU

// ALU with 4-bit operands
module alu #(parameter WIDTH = 8)(
    input  logic clk,
    input  logic [WIDTH-1:0] a, b,
    input  logic [2:0] alucontrol,      // alucontrol signal is 3 bits
    output logic [WIDTH-1:0] result,    // ALUout of WIDTH bits
    output logic       zero             // ZERO flag
);

  
  reg [WIDTH-1: 0] Rzero = 0;
  

  

  always @*
    case (alucontrol)
      4'b0000: result = a + b; //and
      4'b0001: result = a - b; //sub
      4'b0010: result = a & b; //and
      4'b0011: result = a | b; //or
      4'b0100: result = !(a | b); //nor
      4'b0101: result = a ^ b; //xor
      4'b0110 : result = a / b ; //div
      4'b0111 : result = (a < b) ? 1'b1:1'b0; //slt
      4'b1000: result = a << b; //LSL
      4'b1001 : result = a >> b; //LSR
    endcase

  assign zero = (result == Rzero); // similar to 32'b0
endmodule

`endif // ALU