module OUT_S(iRSTn,
             iCLK,
             iOUT,
             iRESET,
             oOUT);
    
    input iRSTn, iCLK, iOUT, iRESET;
    output [1:0] oOUT;
    wire a,b,Da,Db;
    
    assign Da = ((~iOUT&a)|(iOUT&b))&iRESET;
    assign Db = ((iOUT&~a&~b)|(~iOUT&b))&iRESET;
    
    D_FF U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a));
    D_FF U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b));

    assign oOUT[1] = a;
    assign oOUT[0] = a|b;
    
endmodule

