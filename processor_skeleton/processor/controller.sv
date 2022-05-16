`ifndef CONTROLLER
`define CONTROLLER

module controller(
  input  logic [3:0] op,    // opcode in 4 bits
  input  logic       zero,
  output logic       memtoreg, memwrite, 
  output logic       pcsrc,alusrc,
  output logic       regdst, regwrite,
  output logic       jump,
  output logic [3:0] alucontrol
);

  logic [1:0] aluop;
  

  //add main decoder

  maindec maindec(op,zero, memtoreg, memwrite, pcsrc, alusrc,regdst, regwrite,aluop, jump);
  aludec aludec(op,aluop,alucontrol);

  always @(alucontrol)
    $display("alucontrol: %b, op: %b, aluop : %b", alucontrol, op, aluop);

  
endmodule

`endif // CONTROLLER