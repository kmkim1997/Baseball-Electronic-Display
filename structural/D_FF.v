module D_FF(iRSTn,
            iCLK,
            iD,
            oQ);
    
    input iRSTn, iCLK, iD;
    output oQ;
    reg oQ;
    
    always@(negedge iRSTn or posedge iCLK)
    begin
        if (~iRSTn)
            oQ <= 1'b0;
        else
            oQ <= iD;
    end
    
endmodule

