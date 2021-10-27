module testbench(); 
import "DPI" function read_image(output int rgb[] ); 
import "DPI" function gen_image(input int rgb[] ); 

reg clk=0;   always #5 clk = !clk ;
reg reset_n=0; 
reg done=0; 
int pict [320*240];
int pict2 [320*240];
integer i,j; 
initial begin
 read_image(pict); 
 for (i=0;i<320*240;i=i+1)
   dut.mem.mem_array[i*32+:31] = pict[i]; 
// for (i=0;i<320*240;i=i+1)
//  $display("%b",pict[i]); 
// copy the original image to the memory
 @done; 
// copy the updated image to the local variable pict2
 for (i=0;i<320*240;i=i+1)
   pict2[i] = dut.mem.mem_array[i*32+:31]; 
 gen_image(pict2); 

end

  flip_horizontal_and_invert_color dut(.clk(clk), .reset_n(reset_n), .done(done)); 

endmodule


module flip_horizontal_and_invert_color (input clk, reset_n, done); 
// this circuit should act as a finite state machine to read/write from the
// memory to flip and invert the color
// you can use as many ports of the memory as you want
//
//
//

  fsm  fsm (  ); 
  DW_ram_2r_2w_s_dff  #(32,17) mem ( ); 
  // You can create your own sdram .. 
  //memory memory_inst ( ); 
  
endmodule
module fsm (); 
endmodule
