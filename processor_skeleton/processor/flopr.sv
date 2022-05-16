`ifndef FLOPR
`define FLOPR


//based on marano implementation of ottobit cpu

module flopr #(parameter DWIDTH = 8)(
    input  logic             clk, reset,
    input  logic [DWIDTH-1:0] d, 
    output logic [DWIDTH-1:0] q
);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule

`endif // FLOPR