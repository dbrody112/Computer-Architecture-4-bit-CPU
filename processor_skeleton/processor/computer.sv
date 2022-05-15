`ifndef COMPUTER
`define COMPUTER

// 4-bit computer with 16-bit instructions
module computer #(parameter DWIDTH = 4, IWIDTH = 16)(
  input  logic              clk, reset, 
  output logic [DWIDTH-1:0] writedata, dataadr, 
  output logic              memwrite
);

  logic [DWIDTH-1:0] pc, readdata;
  logic [IWIDTH-1:0] instr;
  
  // instantiate processor and memories
  cpu cpu(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
  imem imem(pc[DWIDTH-1:2], instr); // start at 2, since byte-addressable (2bits of addr per byte)
  dmem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule

`endif // COMPUTER