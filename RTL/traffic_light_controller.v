`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2025 22:05:11
// Design Name: 
// Module Name: traffic_light_controller
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

module traffic_light_controller( clk,rst,
									MG1,MG2,MR1,MR2,MY1,MY2,
									SG1,SG2,SR1,SR2,SY1,SY2,
									MRT1,MRT2,SRT1,SRT2,
									blink);
									
  // States for controller									
    parameter s0=4'd0;
    parameter s1=4'd1;
    parameter s2=4'd2;
    parameter s3=4'd3;
    parameter s4=4'd4;
    parameter s5=4'd5;
    parameter s6=4'd6;
    parameter s7=4'd7;
    parameter s8=4'd8;

//parameter time_base=24'd9; /* it is only for quick simulation i.e. Fclk=100Hz time_base=24'd9;.
             // For 100MHz operation, change it to 24'd9_999_999 before loading it in FPGA. 
               // value of time_base= [0.1*Fclk-1] */
 parameter time_base=24'd9_999_999;  //For 100MHz operation  value of time_base= [0.1*Fclk-1] 
                                        
    parameter load_cnt2=9'd449; //timer-1 for 45 secs.
    parameter load_cnt3=9'd49;  //timer-2 for 5 secs.
    parameter load_cnt4=8'd249;  //timer-3 for 25.
    parameter load_cnt5=8'd9	;  //timer-4 for 1 sec.											
											
// Declare inputs and outputs										
		input clk,rst;
		output MG1,MG2,MR1,MR2,MY1,MY2;
		output SG1,SG2,SR1,SR2,SY1,SY2;
		output MRT1,MRT2,SRT1,SRT2;
		input blink;

// Decalre nets for combinational ckts outputs
		wire adv_cnt2, adv_cnt3, adv_cnt4, adv_cnt5;
		wire res_cnt2, res_cnt3, res_cnt4, res_cnt5;
		
		wire [23:0] cnt1_next;
		wire [8:0] cnt2_next;
		wire [5:0] cnt3_next;
		wire [7:0] cnt4_next;
		wire [7:0] cnt5_next;
		
// Declare registered signals
		reg [23:0] cnt1_reg;
		reg [8:0] cnt2_reg;
		reg [5:0] cnt3_reg;
		reg [7:0] cnt4_reg;
		reg [7:0] cnt5_reg;	
		
		reg start_timer_1;
		reg start_timer_2;
		reg start_timer_3;
		reg start_timer_4;
		
		reg [3:0] state; // present state variable

		reg MG1,MG2,MR1,MR2,MY1,MY2;
		reg SG1,SG2,SR1,SR2,SY1,SY2;
		reg MRT1,MRT2,SRT1,SRT2;
		
/* The timer implementation start here, cnt1 is a free running counter which provides
  the time base of 0.1 sec for timer 1, 2 and 3.*/											
	assign cnt1_next=cnt1_reg+1;	// Pre-increment the counter
 
	always@(posedge clk, negedge rst)
	 begin
	  if(rst==1'b0)
	   cnt1_reg<= 24'd0; // initialize when reset is active
	   else if (cnt1_reg==time_base)
	    cnt1_reg<= 24'd0; // Reset if terminal count is reached
	     else
		    cnt1_reg<= cnt1_next; // next state value
	 end


/* This is the timer-1 (counter-2), programmed for 45 secs. delay 
	to facilitate smooth run of the main road traffic. */		
	assign adv_cnt2=(start_timer_1==1'b1) & (cnt1_reg==time_base);	// cond for pre-incrementing the counter
	
	assign res_cnt2=(cnt1_reg==time_base) & (cnt2_reg==load_cnt2);	// cond for resetting the counter
	
	assign cnt2_next=cnt2_reg+1;	// Pre-increment the counter


	/* Counter 2 is realized here */

	always@(posedge clk, negedge rst)
	 begin
	  if(rst==1'b0)
	   cnt2_reg<= 9'd0; // initialize when reset is active
	   else if (res_cnt2==1'b1)
	    cnt2_reg<= 9'd0; // Reset if terminal count is reached
	   else if (adv_cnt2==1'b1)
	    cnt2_reg<= cnt2_next;  // 45 sec timer-1 advances the count if the timer is still running
	     else
		    cnt2_reg<= cnt2_reg; // otherwise, don't disturb
	 end





/* This is the timer-2 (counter-3), programmed for 5 secs. delay 
	to activate the YELLOW light for smooth transition while switching from one traffic to another. */		
	assign adv_cnt3=(start_timer_2==1'b1) & (cnt1_reg==time_base);	// cond for pre-incrementing the counter
	
	assign res_cnt3=(cnt1_reg==time_base) & (cnt3_reg==load_cnt3);	// cond for resetting the counter
	
	assign cnt3_next=cnt3_reg+1;	// Pre-increment the counter


	/* Counter 3 is realized here */
	always@(posedge clk, negedge rst)
	 begin
	  if(rst==1'b0)
	   cnt3_reg<= 6'd0; // initialize when reset is active
	   else if (res_cnt3==1'b1)
	    cnt3_reg<= 6'd0; // Reset if terminal count is reached
	   else if (adv_cnt3==1'b1)
	    cnt3_reg<= cnt3_next;  // 5 sec timer-2 advances the count if the timer is still running
	     else
		    cnt3_reg<= cnt3_reg; // otherwise, don't disturb
	 end


/* This is the timer-3 (counter-4), programmed for 25 secs. delay 
	 for smooth run of side road traffic. */		
	assign adv_cnt4=(start_timer_3==1'b1) & (cnt1_reg==time_base);	// cond for pre-incrementing the counter
	
	assign res_cnt4=(cnt1_reg==time_base) & (cnt4_reg==load_cnt4);	// cond for resetting the counter
	
	assign cnt4_next=cnt4_reg+1;	// Pre-increment the counter


	/* Counter 4 is realized here */
	always@(posedge clk, negedge rst)
	 begin
	  if(rst==1'b0)
	   cnt4_reg<= 8'd0; // initialize when reset is active
	   else if (res_cnt4==1'b1)
	    cnt4_reg<= 8'd0; // Reset if terminal count is reached
	   else if (adv_cnt4==1'b1)
	    cnt4_reg<= cnt4_next;  // 5 sec timer-3 advances the count if the timer is still running
	     else
		    cnt4_reg<= cnt4_reg; // otherwise, don't disturb
	 end


/* This is the timer-4 (counter-5), programmed for 1 sec, 
  used for blinking all yellow lights after normal traffic hours */		
	assign adv_cnt5=(blink==1'b1) & (cnt1_reg==time_base);	// cond for pre-incrementing the counter
	
	assign res_cnt5=(cnt1_reg==time_base) & (cnt5_reg==load_cnt5);	// cond for resetting the counter
	
	assign cnt5_next=cnt5_reg+1;	// Pre-increment the counter


	/* Counter 5 is realized here */
	always@(posedge clk, negedge rst)
	 begin
	  if(rst==1'b0)
	   cnt5_reg<= 8'd0; // initialize when reset is active
	   else if (res_cnt5==1'b1)
	    cnt5_reg<= 8'd0; // Reset if terminal count is reached
	   else if (adv_cnt5==1'b1)
	    cnt5_reg<= cnt5_next;  // 1 sec timer-4 advances the count if the timer is still running
	     else
		    cnt5_reg<= cnt5_reg; // otherwise, don't disturb
	 end


// Traffic light state machine starts here
 always@(posedge clk, negedge rst)
   begin
		if (rst==1'b0)
		 begin
		 // Switch off all lights to startwith 		 
				MG1<=1'b0;
				MG2<=1'b0;
				MR1<=1'b0;
			   MR2<=1'b0;
				MY1<=1'b0;
				MY2<=1'b0;
				SG1<=1'b0;
				SG2<=1'b0;
				SR1<=1'b0;
				SR2<=1'b0;
				SY1<=1'b0;
				SY2<=1'b0;
				MRT1<=1'b0;
				MRT2<=1'b0;
				SRT1<=1'b0;
				SRT2<=1'b0;		 
		 
		 // Also switch off the timers
		 start_timer_1<=1'b0;
		 start_timer_2<=1'b0;
		 start_timer_3<=1'b0;
		 
		 state<=s0;		 
		end

 else 
  begin 
		case(state)
		 s0: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main Green lights and side red lights. OFF other lights
						MG1<=1'b1;
						MG2<=1'b1;
						MR1<=1'b0;
						MR2<=1'b0;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt2==1'b1) // this corresponds to 45 secs timing of timer-1
			  begin
					start_timer_1<=1'b0; // stop the timer if the terminal count is reached
					state<=s1;// Change the state
				  end
			
			else
			  begin
			   start_timer_1<=1'b1; // otherwise, let it run
				state<=s0; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else	 

	s1: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main Green lights and side red lights. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b0;
						MR2<=1'b0;
						MY1<=1'b1;
						MY2<=1'b1;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt3==1'b1) // this corresponds to 5 secs timing of timer-2
			  begin
					start_timer_2<=1'b0; // stop the timer if the terminal count is reached
					state<=s2;// Change the state
				  end
			
			else
			  begin
			   start_timer_2<=1'b1; // otherwise, let it run
				state<=s1; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else	 


	s2: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main Green lights and side red lights. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b1;
						MR2<=1'b1;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b1;
						MRT2<=1'b1;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt4==1'b1) // this corresponds to 25 secs timing of timer-3
			  begin
					start_timer_3<=1'b0; // stop the timer if the terminal count is reached
					state<=s3;// Change the state
				  end
			
			else
			  begin
			   start_timer_3<=1'b1; // otherwise, let it run
				state<=s2; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else

	s3: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main yellow  and side red lights. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b0;
						MR2<=1'b0;
						MY1<=1'b1;
						MY2<=1'b1;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt3==1'b1) // this corresponds to 5 secs timing of timer-2
			  begin
					start_timer_2<=1'b0; // stop the timer if the terminal count is reached
					state<=s4;// Change the state
				  end
			
			else
			  begin
			   start_timer_2<=1'b1; // otherwise, let it run
				state<=s3; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else


	s4: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main Green lights and side red lights. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b1;
						MR2<=1'b1;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b1;
						SG2<=1'b1;
						SR1<=1'b0;
						SR2<=1'b0;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt4==1'b1) // this corresponds to 25 secs timing of timer-3
			  begin
					start_timer_3<=1'b0; // stop the timer if the terminal count is reached
					state<=s5;// Change the state
				  end
			
			else
			  begin
			   start_timer_3<=1'b1; // otherwise, let it run
				state<=s4; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else


	s5: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main red lights and side yello lights. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b1;
						MR2<=1'b1;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b0;
						SR2<=1'b0;
						SY1<=1'b1;
						SY2<=1'b1;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt3==1'b1) // this corresponds to 5 secs timing of timer-2
			  begin
					start_timer_2<=1'b0; // stop the timer if the terminal count is reached
					state<=s6;// Change the state
				  end
			
			else
			  begin
			   start_timer_2<=1'b1; // otherwise, let it run
				state<=s5; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else

	s6: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main red lights and side red lights, side right turn. OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b1;
						MR2<=1'b1;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b0;
						SY2<=1'b0;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b1;
						SRT2<=1'b1;		 
		      
			 
			 if(res_cnt4==1'b1) // this corresponds to 25 secs timing of timer-3
			  begin
					start_timer_3<=1'b0; // stop the timer if the terminal count is reached
					state<=s7;// Change the state
				  end
			
			else
			  begin
			   start_timer_3<=1'b1; // otherwise, let it run
				state<=s6; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else

	s7: if(blink==1'b1)
				 state<=s8; // change to blink state;
				 
				else  // function in normal way 
				 begin
						// Switch ON main red lights and side yellow lights, side red . OFF other lights
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b1;
						MR2<=1'b1;
						MY1<=1'b0;
						MY2<=1'b0;
						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b1;
						SR2<=1'b1;
						SY1<=1'b1;
						SY2<=1'b1;
						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		 
		      
			 
			 if(res_cnt3==1'b1) // this corresponds to 5 secs timing of timer-2
			  begin
					start_timer_2<=1'b0; // stop the timer if the terminal count is reached
					state<=s0;// Change the state
				  end
			
			else
			  begin
			   start_timer_2<=1'b1; // otherwise, let it run
				state<=s7; // Remain in the same state until terminal count is reached
				end
				
		end // end of inner else


	s8: if(blink==1'b1) // timer 4 provides 1 sec delay
	      	 begin
						// turn oFF all lights except yellow
						MG1<=1'b0;
						MG2<=1'b0;
						MR1<=1'b0;
						MR2<=1'b0;

						SG1<=1'b0;
						SG2<=1'b0;
						SR1<=1'b0;
						SR2<=1'b0;

						MRT1<=1'b0;
						MRT2<=1'b0;
						SRT1<=1'b0;
						SRT2<=1'b0;		      
			 
					if((cnt1_reg==time_base)&&(cnt5_reg==load_cnt5)) // 1 sec delay timer 4
						  begin
								SY1<=~SY1;
								SY2<=~SY2;
								MY1<=~MY1;
								MY2<=~MY2;
							  end
			     state<=s8;// Remain in the same state until blink=1
				  end
			else
				state<=s0; 
				



endcase // end of case 	 
end // end of outer else	 
end // end of always		 	 
endmodule 
	 
	 
											
		

    

