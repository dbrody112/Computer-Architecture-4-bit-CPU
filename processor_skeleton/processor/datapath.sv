`ifndef DATAPATH
`define DATAPATH

module datapath #(parameter DWIDTH = 8, IWIDTH = 16)(
    input  logic              clk, reset,
    input  logic              memtoreg,pcsrc,
    input  logic              alusrc, regdst,
    input  logic              regwrite, jump,
    input  logic [3:0]        alucontrol,
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

  
  //alu logic

 

  mux2 wrmux(instr[7:6], instr[9:8], regdst,writereg); //set write for R-type or I-type (regdst true for r)
  regfile rf(clk, regwrite, instr[11:10],instr[9:8],writereg, result, srca, writedata);
  mux2 resmux(readdata,aluout,memtoreg,result);
  signext se(instr[7:0],signimm); //I or R

  mux2 srcbmux (signimm,writedata,alusrc,srcb); //I or R

 always @(posedge clk)
  $display("aluout : %b", aluout);
 always @(posedge clk)
  $display("srca : %b", srca);
 always @(posedge clk)
  $display("srcb : %b", srcb);
always @(posedge clk)
  $display("pc : %b", pc);
    
    

  alu alu(clk,srca,srcb,alucontrol, aluout,zero);

  

  // next PC logic

  flopr #(DWIDTH) pcreg(clk, reset, pcnext, pc);
  adder #(DWIDTH) pcadd1(pc, addTwoBytesToPC, pcplus2);
  
  sl2   #(DWIDTH) immsh(signimm, signimmsh);
  adder #(DWIDTH) pcadd2(pcplus2, signimmsh, pcbranch);
  mux2  #(DWIDTH) pcbrmux(pcbranch,pcplus2, pcsrc, pcnextbr);
  mux2  #(DWIDTH) pcmux({instr[7:0]}, pcnextbr, jump, pcnext);
  //jump
  // instr[7:0] according to ISA should be instr[11:0] for the 13-bit jump address BUT
  // instr[11:0] means 12-bit address to do an unconditional jump; PC = jump address
  // FYI we do not have enough memory with an 8-bit CPU with byte addressing to use this.

endmodule

`endif // DATAPATH