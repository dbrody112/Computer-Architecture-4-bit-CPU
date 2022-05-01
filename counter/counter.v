/**
 * 4-bit counter
 */
module counter
(
    input  clk,      // posedge clock
    input  clr,      // synchronous clear
    input  en,       // enable: if high, increment counter
    output [3:0] cnt // counter value
);
    reg [3:0] cnt_reg, cnt_next;
    assign cnt = cnt_reg;
    always @(*) begin
        cnt_next = cnt_reg;
        if (clr) begin
            cnt_next = 4'd0;
        end else if (en) begin
            cnt_next = cnt_reg + 1;
        end
    end
    always @(posedge clk) begin
        cnt_reg <= cnt_next;
    end
endmodule
