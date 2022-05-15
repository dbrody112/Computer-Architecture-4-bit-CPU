module test #(parameter DWIDTH = 8, IWIDTH = 16)();

    reg clk;
    reg reset;
    reg memtoreg;
    reg branch;
    reg alusrc;
    reg regdst;
    reg regwrite;
    reg jump;
    reg [3:0] alucontrol;
    wire pcsrc;
    wire zero;
    wire [DWIDTH-1:0] pc;
    reg [IWIDTH-1:0] instr;
    wire [DWIDTH-1:0] aluout;
    wire [DWIDTH-1:0] writedata;
    reg [DWIDTH-1:0] readdata;

    datapath datapath(
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .pcsrc(pcsrc),
        .zero(zero),
        .pc(pc),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata));
    
      // generate the clock

  initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end

  // Generate the reset
  initial begin

   reset = 1'b1;
    #10
   reset = 1'b0;
  end
  // Test stimulus
  initial begin
    // Use the monitor task to display the FPGA IO

    $dumpfile("datapath_tb.vcd");
    $dumpvars(0, aluout, writedata,zero);

    $monitor("time=%3d, aluout=%b, writedata=%b, zero=%b \n",
              $time, aluout, writedata, zero);
 
    // Generate each input with a 20 ns delay between them

    //I-type - ADDI
    regwrite = 1'b1;
    regdst = 1'b0;
    memtoreg = 1'b0;
    branch = 1'b0;
    alusrc = 1'b1;
    jump = 1'b0;
    alucontrol = 4'b0000;
    readdata = 8'b00000000;
    instr = 16'b1100001000000001;

    #20;

    regwrite = 1'b1;
    regdst = 1'b0;
    memtoreg = 1'b0;
    branch = 1'b0;
    alusrc = 1'b1;
    jump = 1'b0;
    alucontrol = 4'b0000;
    readdata = 8'b00000000;
    instr = 16'b1100101100000010;

    
  end



endmodule