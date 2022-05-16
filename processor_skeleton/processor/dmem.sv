
`ifndef DMEM
`define DMEM


//based on marano implementation of ottobit cpu

// Modeled after Professor Marano's dmem design for ottobit architecture
module dmem #(parameter DWIDTH = 8)(
  input  logic              clk, we,
  input  logic [DWIDTH-1:0] a, wd,
  output logic [DWIDTH-1:0] rd
);

  logic [DWIDTH-1:0] RAM[0:127]; 
  assign rd = RAM[a[DWIDTH-1:2]];

  always@(posedge clk)
    $display("data address : %b",a);

  always @(posedge clk)
    if (we) RAM[a[DWIDTH-1:2]] <= wd;
endmodule

`endif // DMEM