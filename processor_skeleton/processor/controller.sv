`ifndef CONTROLLER
`define CONTROLLER

module controller(
  input  logic [2:0] op,    // opcode in 3 bits
  input  logic [3:0] funct, // function in 4 bits
  input  logic       zero,
  output logic       memtoreg, memwrite,
  output logic       pcsrc, alusrc,
  output logic       regdst, regwrite,
  output logic       jump,
  output logic [2:0] alucontrol
);

  logic [1:0] aluop;
  logic       branch;

  assign pcsrc = branch & zero;
endmodule

`endif // CONTROLLER