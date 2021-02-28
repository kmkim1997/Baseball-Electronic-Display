module BASE_S(iRSTn,
              iCLK,
              iBASE,
              iRESET,
              oBASE);
    
    input iRSTn, iCLK, iBASE, iRESET;
    output [2:0]oBASE;
    wire a,b,Da,Db;
    
    assign Da = (a|(iBASE&b))&iRESET;
    assign Db = ((~iBASE&b)|(iBASE&~b)|(a&b))&iRESET;
    
    D_FF U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a));
    D_FF U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b));
    
    assign oBASE[2] = a&b;
    assign oBASE[1] = a;
    assign oBASE[0] = a|b;
    
endmodule

