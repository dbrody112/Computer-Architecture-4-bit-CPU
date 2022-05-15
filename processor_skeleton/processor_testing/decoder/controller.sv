`ifndef CONTROLLER
`define CONTROLLER

module controller(
  input  logic [2:0] op,    // opcode in 4 bits
  input  logic       zero,
  output logic       memtoreg, memwrite,
  output logic       branch, alusrc,
  output logic       regdst, regwrite,
  output logic       jump,
  output logic [3:0] alucontrol
);

  logic [1:0] aluop;
  

  //add main decoder

  maindec maindec(op,memread, memwrite,branch, alusrc,regdst, regwrite,aluop, jump);
  aludec aludec(op,aluop,alucontrol)

  
endmodule

`endif // CONTROLLER