module BALL_S(iRSTn,
              iCLK,
              iBALL,
              iRESET,
              oBALL);
    
    input iRSTn, iCLK, iBALL, iRESET;
    output [2:0]oBALL;			
    wire a,b,Da,Db;
    
    assign Da = ((iBALL&~a&b)|(~iBALL&a)|(a&~b))&iRESET;
    assign Db = ((~iBALL&b)|(iBALL&~b))&iRESET;
    
    D_FF U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a));
    D_FF U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b));
    
    assign oBALL[2] = a&b;
    assign oBALL[1] = a;
    assign oBALL[0] = a|b;
    
endmodule

