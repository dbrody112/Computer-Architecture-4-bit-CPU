`ifndef CPU
`define CPU

module cpu #(parameter DWIDTH = 8, IWIDTH = 16)(
    input  logic              clk, reset,
    output logic [DWIDTH-1:0] pc,
    input  logic [IWIDTH-1:0] instr,
    output logic              memwrite,
    output logic [DWIDTH-1:0] aluout, writedata,
    input  logic [DWIDTH-1:0] readdata
);

  logic       memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;
  logic [2:0] alucontrol; 

  controller c(instr[15:12], // opcode in 3 bits
               zero,
               memtoreg, memwrite, pcsrc,
               alusrc, regdst, regwrite, jump,
               alucontrol);
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump,
              alucontrol,
              zero, pc, instr,
              aluout, writedata, readdata);
endmodule

`endif // CPU