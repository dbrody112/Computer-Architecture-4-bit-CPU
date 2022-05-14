`ifndef ADDER
`define ADDER

module adder #(parameter DWIDTH = 8)(
    input  logic [DWIDTH-1:0] a, b,
    output logic [DWIDTH-1:0] y
);

  assign y = a + b;
endmodule

`endif // ADDER