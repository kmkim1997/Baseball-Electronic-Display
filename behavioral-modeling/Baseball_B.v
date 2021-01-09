module Baseball_B(iCLK,
                  iRSTn,
                  iSTRIKE,
                  iBALL,
                  iHIT,
                  iHIT_OUT,
                  oSTRIKE_LED,
                  oOUT_LED,
                  oBALL_LED,
                  oBASE);
    
    input iCLK, iRSTn, iSTRIKE, iBALL, iHIT, iHIT_OUT;
    output [1:0] oSTRIKE_LED, oOUT_LED;
    output [2:0] oBALL_LED, oBASE;
    wire i_STRIKE, i_BALL, i_HIT, i_OUT, RESET;
    reg [2:0] o_STRIKE, o_OUT;
    reg [3:0] o_BALL, o_BASE;
    
    assign oSTRIKE_LED = o_STRIKE[1:0];
    assign oOUT_LED    = o_OUT[1:0];
    assign oBALL_LED   = o_BALL[2:0];
    assign oBASE       = o_BASE[2:0];
    assign RESET       = (iRSTn & (~o_OUT[2]));
    
    PG_B U0(
    .iRST(iRSTn),
    .iCLK(iCLK),
    .EN(~iSTRIKE),
    .oP(i_STRIKE)
    );
    
    PG_B U1(
    .iRST(iRSTn),
    .iCLK(iCLK),
    .EN(~iBALL),
    .oP(i_BALL)
    );
    
    PG_B U2(
    .iRST(iRSTn),
    .iCLK(iCLK),
    .EN(~iHIT),
    .oP(i_HIT)
    );
    
    PG_B U3(
    .iRST(iRSTn),
    .iCLK(iCLK),
    .EN(~iHIT_OUT),
    .oP(i_OUT)
    );
    
    always@ (posedge iCLK, negedge RESET)
    begin
        if (~RESET)
            o_BALL <= 4'b0000;
        else if (~i_BALL)
        begin
            if (o_STRIKE[2] | o_BALL[3]|i_HIT|i_OUT)
                o_BALL <= 4'b0000;
            else
                o_BALL <= o_BALL;
        end
        else
        begin
            if (o_BALL[2:0] == 3'b111)
                o_BALL <= 4'b1000;
            else
                o_BALL <= {o_BALL[2:0], 1'b1};
        end
    end
    
    always@ (posedge iCLK, negedge RESET)
    begin
        if (~RESET)
            o_STRIKE <= 3'b000;
        else if (~i_STRIKE)
        begin
            if (o_STRIKE[2] | o_BALL[3]|i_HIT|i_OUT)
                o_STRIKE <= 3'b000;
            else
                o_STRIKE <= o_STRIKE;
        end
        else
        begin
            if (o_STRIKE[1:0] == 2'b11)
                o_STRIKE <= 3'b100;
            else
                o_STRIKE <= {o_STRIKE[1:0], 1'b1};
        end
    end
    
    
    always@ (posedge iCLK, negedge RESET)
    begin
        if (~RESET)
            o_OUT <= 3'b000;
        else if (~i_OUT)
        begin
            if (o_OUT == 3'b100)
                o_OUT <= 3'b000;
            else if (o_STRIKE[2])
                o_OUT <= {o_OUT[1:0], 1'b1};
            else
                o_OUT <= o_OUT;
        end
        else
        begin
            if (o_OUT[1:0] == 2'b11)
                o_OUT <= 3'b100;
            else
                o_OUT <= {o_OUT[1:0], 1'b1};
        end
    end
    
    always@ (posedge iCLK, negedge RESET)
    begin
        if (~RESET)
            o_BASE <= 4'b0000;
        else
        begin
            if (o_BALL[3] | i_HIT)
                o_BASE <= {o_BASE[2:0], 1'b1};
        end
    end
endmodule

