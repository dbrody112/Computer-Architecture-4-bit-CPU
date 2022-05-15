`ifndef MUX2
`define MUX2

module mux2 #(parameter DWIDTH = 8)(
    input  logic [DWIDTH-1:0] d0, d1, 
    input  logic              s, 
    output logic [DWIDTH-1:0] y
);

  assign y = s ? d0 : d1; 
endmodule

`endif // MUX2