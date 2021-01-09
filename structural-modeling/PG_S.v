module PG_S(iRSTn,
            iCLK,
            iX,
            oY);
    
    input iRSTn,iCLK,iX;
    output oY;
    wire Da,Db,a,b;
    
    assign Da = (b&~iX)|(a&~iX);
    assign Db = (~a)&(~b)&~iX;

    D_FF	U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a));
    D_FF	U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b));
    
    assign oY = b;
    
endmodule

