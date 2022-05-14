`ifndef DATAPATH
`define DATAPATH

module datapath #(parameter DWIDTH = 8, IWIDTH = 16)(
    input  logic              clk, reset,
    input  logic              memtoreg, pcsrc,
    input  logic              alusrc, regdst,
    input  logic              regwrite, jump,
    input  logic [2:0]        alucontrol,
    output logic              zero,
    output logic [DWIDTH-1:0] pc,
    input  logic [IWIDTH-1:0] instr,
    output logic [DWIDTH-1:0] aluout, writedata,
    input  logic [DWIDTH-1:0] readdata
);

  logic [2:0]  writereg; // we have 8 registers addressed by 3 bits
  logic [DWIDTH-1:0] pcnext, pcnextbr, pcplus2, pcbranch;
  logic [DWIDTH-1:0] signimm, signimmsh;
  logic [DWIDTH-1:0] srca, srcb;
  logic [DWIDTH-1:0] result;
  logic [DWIDTH-1:0] addTwoBytesToPC = {DWIDTH{1'b0}} + 2; 

  // next PC logic
  flopr #(DWIDTH) pcreg(clk, reset, pcnext, pc);
  adder #(DWIDTH) pcadd1(pc, addTwoBytesToPC, pcplus2);
  sl2   #(DWIDTH) immsh(signimm, signimmsh);
  adder #(DWIDTH) pcadd2(pcplus2, signimmsh, pcbranch);
  mux2  #(DWIDTH) pcbrmux(pcplus2, pcbranch, pcsrc, pcnextbr);
  mux2  #(DWIDTH) pcmux(pcnextbr, {instr[7:0]}, jump, pcnext);
  // instr[7:0] according to ISA should be instr[11:0] for the 13-bit jump address BUT
  // instr[11:0] means 12-bit address to do an unconditional jump; PC = jump address
  // FYI we do not have enough memory with an 8-bit CPU with byte addressing to use this.

endmodule

`endif // DATAPATH