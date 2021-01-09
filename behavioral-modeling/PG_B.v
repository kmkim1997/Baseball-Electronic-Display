module PG_B(iRST,
            iCLK,
            EN,
            oP);
    
    input iRST, iCLK, EN;
    output reg oP;
    reg Da, Db;
    wire a, b;
    
    always@(*)
        case({a, b, EN})
            3'b000:{Da, Db, oP} = 3'b000;
            3'b001:{Da, Db, oP} = 3'b010;
            3'b010:{Da, Db, oP} = 3'b001;
            3'b011:{Da, Db, oP} = 3'b101;
            3'b100:{Da, Db, oP} = 3'b000;
            3'b101:{Da, Db, oP} = 3'b100;
            3'b110:{Da, Db, oP} = 3'bxxx;
            3'b111:{Da, Db, oP} = 3'bxxx;
        endcase
    
    D_FF
    U0(
    .iRST(iRST),
    .iCLK(iCLK),
    .iD(Da),
    .oQ(a)
    );
    
    D_FF
    U1(
    .iRST(iRST),
    .iCLK(iCLK),
    .iD(Db),
    .oQ(b)
    );
    
endmodule

