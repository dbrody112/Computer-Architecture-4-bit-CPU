module test();

reg[3:0] rand1;
reg[3:0] op;
assign op = rand1;

reg[1:0] rand2;
reg [1:0] aluop;
assign aluop = rand2;

wire [3:0] alucontrol;

aludec aludec(
     .op(op),
     .aluop(aluop),
     .alucontrol(alucontrol));

initial begin
    rand1 = 4'bxxxx;
    rand2 = 2'bxx;
    #10;
    rand1 = 4'b0001;
    rand2 = 2'b10;
    #10;
    rand1 = 4'b0000;
    rand2 = 2'b10;
    #10;
    rand1 = 4'b1100;
    rand2 = 2'b00;
    #10;
    rand1 = 4'b1110 ;
    rand2 = 2'b00;
    #10;
    rand1 = 4'b1010;
    rand2 = 2'b00;
    #10;
end

initial begin
    $dumpfile("aludec_tb.vcd");
    $dumpvars(0, op, aluop, alucontrol);

end


endmodule