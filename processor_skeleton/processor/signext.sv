`ifndef SIGNEXT
`define SIGNEXT

module signext #(parameter DWIDTH = 8)(
    input  logic [6:0] a,
    output logic [DWIDTH-1:0] y
);
              
  assign y = {{DWIDTH{a[6]}}, a};
endmodule

`endif // SIGNEXT