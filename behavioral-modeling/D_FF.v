module D_FF(iRST,
            iCLK,
            iD,
            oQ);
    
    input iRST, iCLK, iD;
    output oQ;
    reg oQ;
    
    always@ (posedge iCLK or negedge iRST)
        if (~iRST)
            oQ <= 1'b0;
        else
            oQ <= iD;
    
endmodule

