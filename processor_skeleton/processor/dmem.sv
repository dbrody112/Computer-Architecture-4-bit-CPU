`ifndef DMEM
`define DMEM

module dmem #(parameter DWIDTH = 8)(
  input  logic              clk, we,
  input  logic [DWIDTH-1:0] a, wd,
  output logic [DWIDTH-1:0] rd
);

  logic [DWIDTH-1:0] RAM[0:63];

  assign rd = RAM[a[DWIDTH-1:2]]; // word aligned, lowest 2 bits represent byte

  always @(posedge clk)
    if (we) RAM[a[DWIDTH-1:2]] <= wd;
endmodule

`endif // DMEM