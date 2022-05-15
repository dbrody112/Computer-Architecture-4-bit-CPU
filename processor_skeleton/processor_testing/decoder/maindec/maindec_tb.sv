module test();

reg[3:0] rand1;
reg[3:0] op;
assign op = rand1;
wire memread;
wire memwrite;
wire branch;
wire alusrc;
wire regdst;
wire regwrite;
wire [1:0] aluop;
wire jump;

assign jump_1 = 1'b1;

reg [15:0] data [0:3];

maindec maindec(
     .op(op),
     .memread(memread),
     .memwrite(memwrite),
     .branch(branch),
     .alusrc(alusrc),
     .regdst(regdst),
     .regwrite(regwrite),
     .aluop(aluop),
     .jump(jump));

initial begin
    rand1 = 4'bxxxx;
    #10;
    rand1 = 4'b0001;
    #10;
    rand1 = 4'b0000;
    #10;
    rand1 = 4'b1100;
    #10;
    rand1 = 4'b1110 ;
    #10;
    rand1 = 4'b1010;
    #10;
end

initial begin
    $dumpfile("decoder_tb.vcd");
    $dumpvars(0, op, rand1, regwrite, regdst, alusrc, branch, memwrite, memread,jump,aluop);

end


endmodule