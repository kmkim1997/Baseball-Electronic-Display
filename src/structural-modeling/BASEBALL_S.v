module BASEBALL_S(iRSTn,
                  iCLK,
                  iSTRIKE,
                  iBALL,
                  iHIT_OUT,
                  iHIT,
                  oSTRIKE_LED,
                  oBALL_LED,
                  oOUT_LED,
                  oBASE);

    input iRSTn,iCLK,iSTRIKE,iBALL,iHIT_OUT,iHIT;
    output [2:0] oBALL_LED,oBASE;
    output [1:0] oSTRIKE_LED,oOUT_LED;
    wire i_STRIKE, i_BALL, i_OUT, i_HIT;
    wire [2:0] o_BALL, o_BASE;
    wire [1:0] o_STRIKE, o_OUT;
    wire BALL_3, BALL_4, STRIKE_2,STRIKE_3,OUT_2, OUT_3, OUT_C, BASE_C,RESET_SB, RESET_OB;
    
    PG_S U0(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iX(iSTRIKE),
    .oY(i_STRIKE));
    PG_S U1(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iX(iBALL),
    .oY(i_BALL));
    PG_S U2(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iX(iHIT_OUT),
    .oY(i_OUT));
    PG_S U3(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iX(iHIT),
    .oY(i_HIT));

    BALL_S U4(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iBALL(i_BALL),
    .iRESET(~RESET_SB),
    .oBALL(o_BALL));
    
    STRIKE_S U5(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iSTRIKE(i_STRIKE),
    .iRESET(~RESET_SB),
    .oSTRIKE(o_STRIKE));
    
    OUT_S U6(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iOUT(OUT_C),
    .iRESET(~RESET_OB),
    .oOUT(o_OUT));
    
    BASE_S U7(.iRSTn(iRSTn),
    .iCLK(iCLK),
    .iBASE(BASE_C),
    .iRESET(~RESET_OB),
    .oBASE(o_BASE));
    
    assign BALL_3 = (o_BALL == 3'b111)?1'b1:1'b0;
    assign BALL_4 = BALL_3&i_BALL;
    assign STRIKE_2 = (o_STRIKE == 2'b11)?1'b1:1'b0;
    assign STRIKE_3 = STRIKE_2&i_STRIKE;
    assign OUT_2 = (o_OUT == 2'b11)?1'b1:1'b0;
    assign OUT_3       = OUT_2&(i_OUT | STRIKE_3);
    assign OUT_C       = STRIKE_3|i_OUT;
    assign BASE_C      = BALL_4|i_HIT;
    assign RESET_SB    = BALL_4|STRIKE_3|i_HIT|i_OUT;
    assign RESET_OB    = OUT_3;
    assign oSTRIKE_LED = o_STRIKE;
    assign oBALL_LED   = o_BALL;
    assign oOUT_LED    = o_OUT;
    assign oBASE       = o_BASE;
    
endmodule

