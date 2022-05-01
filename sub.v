module sub(a, b, bin, sum, bout);
    input a, b, bin;
    output bout, sum;

    wire t1, t2, t3, t4, t5;
    // sub = A XOR B XOR Bin
    // bout = !A & Bin + !A & B + B & Bin
    assign t1 = a ^ b;
    assign t2 = !a & b;
    assign t3 = !a & bin;
    assign t4 = t2 | t3;
    assign t5 = b & bin;

    assign bout = t4 | t5; 
    assign sum = t1 ^ bin;
endmodule