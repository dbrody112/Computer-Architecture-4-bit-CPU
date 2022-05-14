`ifndef CONTROLLER
`define CONTROLLER

module controller(
  input  logic [2:0] op,    // opcode in 4 bits
  input  logic       zero,
  output logic       memtoreg, memwrite,
  output logic       pcsrc, alusrc,
  output logic       regdst, regwrite,
  output logic       jump,
  output logic [2:0] alucontrol
);

  logic [1:0] aluop;
  logic       branch;

  //add main decoder

  maindec maindec(op,memread, memwrite,branch, alusrc,regdst, regwrite,aluop, jump);

  assign pcsrc = branch & zero;
endmodule

`endif // CONTROLLER