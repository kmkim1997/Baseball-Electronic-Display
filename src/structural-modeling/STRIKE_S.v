module STRIKE_S(iRSTn,
                iCLK,
                iSTRIKE,
                iRESET,
                oSTRIKE);
    
    input iRSTn, iCLK, iSTRIKE, iRESET;
    output [1:0] oSTRIKE;
    wire a,b,Da,Db;
    
    assign Da = ((~iSTRIKE&a)|(iSTRIKE&b))&iRESET;
    assign Db = ((iSTRIKE&~a&~b)|(~iSTRIKE&b))&iRESET;
    
    D_FF U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a));
    D_FF U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b));

    assign oSTRIKE[1] = a;
    assign oSTRIKE[0] = a|b;
    
endmodule

