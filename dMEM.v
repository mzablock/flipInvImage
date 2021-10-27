module dMEM(input clk,
            input [23:0] addr,
            input dataIn,
            input memRD,
            input memWR,
            output reg dataOut);


    reg [23:0] memData [320][240];

    initial begin 
        dataOut <= 0; end

    always@( posedge clk )
    begin
        if (memWR)
            memData[addr] <= dataIn;
    end

    always@( * )
    begin
        if (memRD)
            dataOut <= memData[addr];
    end


endmodule