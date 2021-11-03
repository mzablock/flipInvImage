module testbench(); 
import "DPI" function read_image(output int rgb[] ); 
import "DPI" function gen_image(input int rgb[] ); 

reg clk=0;   always #5 clk = !clk ;
reg reset_n=0; 
wire done;
wire [31:0] dataIn, dataOut;
wire [$clog2(240)-1:0] address0;
wire [$clog2(320)-1:0] address1;
wire mRD;

int pict [320*240];
int pict2 [320*240];
int pictIndex = 0;
integer i,j; 
initial begin
 read_image(pict); 
 //for (i=0;i<320*240;i=i+1)
 for (i=0;i<320;i=i+1) begin
  for (j=0;j<240;j=j+1) begin
  //mem.mem_array[i*32+:31] = pict[i];
  dmem.memData0[i][j] = pict[pictIndex];
  pictIndex = pictIndex + 1; end end
 
// for (i=0;i<320*240;i=i+1)
//  $display("%b",pict[i]); 
// copy the original image to the memory
@done;
// copy the updated image to the local variable pict2
 //for (i=0;i<320*240;i=i+1)
 for (i=0;i<320;i=i+1) begin
  for (j=0;j<240;j=j+1) begin
   //pict2[i] = mem.mem_array[i*32+:31];
   pict2[pictIndex] = dmem.memData1[i][j];
   pictIndex = pictIndex - 1; end  end
 gen_image(pict2); 

end

  //flip_horizontal_and_invert_color dut(.clk(clk), .reset_n(reset_n), .done(done)); 
  //DW_ram_2r_2w_s_dff  #(32,17) mem ( );

//endmodule



//  fsm  fsm (  ); 
//  DW_ram_2r_2w_s_dff  #(32,17) mem ( ); 
  // You can create your own sdram ..
  invertMachine inv(.clk(clk),
                    .rst(reset_n),
                    .rdData(dataIn),
                    .done(done),
                    .memRD(mRD),
                    .addr0(address0),
                    .addr1(address1),
                    .wrData(dataOut));

  dMEM  dmem(.clk(clk),
             .addr0(address0),
             .addr1(address1),
             .dataIn(dataIn),
             .memRD(mRD),
             .dataOut(dataOut));
  
endmodule
//module fsm (); 
//endmodule
