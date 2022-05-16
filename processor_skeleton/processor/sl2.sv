`ifndef SL2
`define SL2


//based on marano implementation of ottobit cpu

// Shift left 2 bits
module sl2 #(parameter DWIDTH = 8)(
    input  logic [DWIDTH-1:0] a,
    output logic [DWIDTH-1:0] y
);

  // shift left by 2
  assign y = {a[DWIDTH-3:0], 2'b00};
endmodule

`endif // SL2