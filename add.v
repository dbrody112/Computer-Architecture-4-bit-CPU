module add(a, b, cin, sum, cout);
    input a, b, cin;
    output cout, sum;

    wire t1, t2, t3, t4, t5;
    // sum = a XOR b XOR cin
    // carry in = (A&B) | (B&C) | (C&A)
    assign t1 = a ^ b;
    assign t2 = a & b;
    assign t3 = b & cin;
    assign t4 = cin & a;
    assign t5 = t2 | t3;

    assign cout = t5 | t4; 
    assign sum = cin ^ t1;
endmodule