`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2025 22:55:57
// Design Name: 
// Module Name: traffic_light_controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_controller_tb();

// Declare input and outputs										
		reg clk,rst;
		wire MG1,MG2,MR1,MR2,MY1,MY2;
		wire SG1,SG2,SR1,SR2,SY1,SY2;
		wire MRT1,MRT2,SRT1,SRT2;
		reg blink;

 traffic_light_controller DUT( clk,rst,
											MG1,MG2,MR1,MR2,MY1,MY2,
											SG1,SG2,SR1,SR2,SY1,SY2,
											MRT1,MRT2,SRT1,SRT2,
											blink);	

initial begin
clk = 1'b0; rst = 1'b1; blink = 1'b0;
end
always   // 100Hz clock signal
 begin
  #5 clk= ~clk;
  //#5 clk=1'b0;
 end
 
 initial
  begin
	  #2000 rst=1'b0; // 2 secs.
	  #2000 rst=1'b1;  blink=1'b0;
	  
	  #350000 blink=1'b1; // 350 secs. 
	  #200000 blink=1'b0; // 200 secs. 
	  #200000 blink=1'b0; // 200 secs.
	  #100 ;//$finish;
	  end

endmodule
