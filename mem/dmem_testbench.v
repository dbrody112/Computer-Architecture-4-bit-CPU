module dmem_test ();
    reg logic              clk, we,
    reg logic [DWIDTH-1:0] a, wd,
    output logic [DWIDTH-1:0] rd
    dmem_test # (
        .clk(clk),
        .we(we),
        .a(a),
        .wd(wd),
        .rd(rd)
    )


endmodule