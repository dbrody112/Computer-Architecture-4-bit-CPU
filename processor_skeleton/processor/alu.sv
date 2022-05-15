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

  logic [WIDTH-1:0] condinvb, sum;
  reg [WIDTH-1: 0] Rzero = 0;

  assign condinvb = alucontrol[2] ? ~b : b;
  assign sum = a + condinvb + alucontrol[2];

  always @*
    case (alucontrol[1:0])
      2'b00: result = a & b;
      2'b01: result = a | b;
      2'b10: result = sum;
      2'b11: result = sum[WIDTH-1];
    endcase

  assign zero = (result == Rzero); // similar to 32'b0
endmodule

`endif // ALU