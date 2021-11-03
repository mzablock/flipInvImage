module flip_horizontal_and_invert_color (input clk, reset_n, done); 
// this circuit should act as a finite state machine to read/write from the
// memory to flip and invert the color
// you can use as many ports of the memory as you want
parameter RESET = 0,
          INVERT = 1,
          FLIP = 2;

reg [1:0] prState = 0, nxState = 0;
reg [4:0] counter = 0;

  always@(posedge clk, negedge reset_n)
    if (!reset_n)
      prState <= 0; //reset
    else
      prState <= nxState;
  always@(prState)
    case(prState)
      RESET: 
        if (done)
          nxState = INVERT;
        else
          nxState = RESET;
      INVERT: begin
         invValue = ~dmem.memData[row]
        nxState = FLIP; end
      FLIP: begin
        mem.mem_array_next[76799-counter+:31] = mem.mem_array[counter+:31];
        counter = counter + 1;
        nxState = RESET; end
    endcase
    
endmodule
