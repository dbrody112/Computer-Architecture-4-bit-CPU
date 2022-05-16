`ifndef REGFILE
`define REGFILE

module regfile #(parameter DWIDTH = 8, RWIDTH = 3, REGNUM = 8)(
    input  logic              clk, 
    input  logic              we3, 
    input  logic [RWIDTH-1:0] ra1, ra2, wa3, 
    input  logic [DWIDTH-1:0] wd3, 
    output logic [DWIDTH-1:0] rd1, rd2
);

  logic [DWIDTH-1:0] rf[REGNUM-1:0]; // REGNUM registers of data of DWIDTH bits wide

  initial
    rf[0] = {REGNUM{1'b0}}; // Rz (Zero Register) is constant value of 0
                            // setting value of zero using Verilog concatenation.

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clk
  // register 0 hardwired to 0
  // note: for pipelined processor, write third port
  // on falling edge of clk


//based on marano implementation of ottobit cpu
  

  always @(posedge clk)
    if (we3)
    begin
      $display("writing to register %h value %d",wa3,wd3);
      $display("result: %b",wd3);
      $display("writedata at %b : %b", ra2,rf[ra2]);
      if (wa3 != 0)
      begin
        rf[wa3] <= wd3;
      end
    end

  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

`endif //REGFILE