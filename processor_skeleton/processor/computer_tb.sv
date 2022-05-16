`ifndef COMPUTER_TB
`define COMPUTER_TB

`timescale 1ms/100us // 1ms period, 10us precision

//8 bit computer with 16-but instructions

module computer_tb #(parameter DWIDTH = 8, IWIDTH = 16)();

  logic        clk, reset, memwrite;
  logic [DWIDTH-1:0] writedata, dataadr;
  logic firstTest, secondTest;

  // instantiate device to be tested
  computer comp(clk, reset, writedata, dataadr, memwrite);
  
  initial
  begin
      firstTest = 1'b0;
      secondTest = 1'b0;
      $dumpfile("computer_tb.vcd");
      $dumpvars(0,clk,reset,writedata,dataadr,memwrite,comp.instr);
      $monitor("0x%h\t0x%h\t0x%h\t%d\t%d",comp.pc,comp.instr,writedata,dataadr,memwrite);
  end

  // run circuit for 100 time units
  initial
  begin
    #300 $finish;
  end

  // initialize test
  // reset for 22 time units
  initial
    begin
      reset <= 1; # 20; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  always @(posedge clk)
  begin
      $display("+");
      $display("\t+instr = 0x%8h",comp.instr);
  end

  // check results
  always @(negedge clk)
    begin
      $display("-");
      $display("\t-instr = 0x%8h",comp.instr);
    end
endmodule

`endif // COMPUTER_TB