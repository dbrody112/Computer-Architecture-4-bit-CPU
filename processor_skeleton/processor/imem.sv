`ifndef IMEM
`define IMEM

module imem #(parameter DWIDTH = 8, IWIDTH = 16)(
  input  logic [5:0] a, // .text is limited to 2^6 (64 or 6 bits) instructions
  output logic [IWIDTH-1:0] rd
);

  logic [IWIDTH-1:0] RAM[0:63]; // .text is limited to 2^6 (64 or 6 bits) instructions
  integer j;
  logic [5:0] addr;

  initial
  begin
    // clear the 64 instruction lines (2bytes/instr*64instrs=128bytes)
    addr = 6'b0;
    for(j=0;j<64;j=j+1)
    begin
      RAM[addr] = {DWIDTH{1'b0}};
      // $display("RAM[0x%2h] = 0x%2h",addr,RAM[addr]);
      addr = addr + 6'b10;
    end
    $readmemh("memfile.dat",RAM);
    addr = 6'b0;
    for(j=0;j<64;j=j+1)
    begin
      $display("RAM[0x%2h] = 0x%2h",addr,RAM[addr]);
      addr = addr + 6'b10;
    end
  end

  assign rd = RAM[a]; // word aligned

  always @(a)
    $display("RAM[0x%2h] = 0x%2h",a,rd);
endmodule

`endif // IMEM