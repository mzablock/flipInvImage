module invertMachine(input clk,
                     input rst,
                     input [31:0] rdData,
                     output reg done = 0,
                     output reg memRD,
                     output reg [7:0] addr0,
                     output reg [8:0] addr1,
                     output reg [31:0] wrData);

parameter RESET = 0,
          INVERT = 1,
          STORE = 2;

reg [1:0] prState = 0, nxState = 0;
reg [7:0] row = 0;
reg [8:0] col = 0;
reg [31:0] invValue;

always@( posedge clk, negedge rst )
    prState <= nxState;

always@( prState )
    case(prState)
        RESET: begin
            if (!done)
                nxState = INVERT;
            else
                nxState = RESET; end
        INVERT: begin
            invValue = ~(dmem.memData0[col][row]);
            nxState = STORE; end
        STORE: begin
                dmem.memData1[col][row] = invValue;
                col = col + 1;

                if (col == 320 && row == 240)
                    done = 1;

                else if (col ==  320) begin
                    row = row + 1;
                    col = 0; end

                nxState = RESET; end
    endcase

endmodule
