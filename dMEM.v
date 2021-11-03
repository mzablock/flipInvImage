module dMEM #(parameter WIDTH = 32, DEPTH = 240, COL = 320)
            (input clk,
             input [$clog2(DEPTH)-1:0] addr0, //row
             input [$clog2(COL)-1:0] addr1,   //col
             input [WIDTH-1:0] dataIn,
             input memRD,
             output reg [WIDTH-1:0] dataOut);


    reg [WIDTH-1:0] memData0 [0:COL-1][0:DEPTH-1];
    reg [WIDTH-1:0] memData1 [0:COL-1][0:DEPTH-1];

    always@( posedge clk )
        if (memRD)
            dataOut <= memData0[addr1][addr0];
        else
            memData1[addr1][addr0] <= dataIn;


endmodule