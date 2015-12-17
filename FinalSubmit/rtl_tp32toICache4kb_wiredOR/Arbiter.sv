  typedef enum {
   Evaluate=0,
   State0 , State1 , State2 , State3 , State4 , State5 , State6 , State7 , State8 , State9 ,
   State10, State11, State12, State13, State14, State15, State16, State17, State18, State19,
   State20, State21, State22, State23, State24, State25, State26, State27, State28, State29,
   State30, State31, EndState } arbiterState ;
module arbiter (
  CLK , RSTn ,
  Req0 , Req1,  Req2 , Req3 , Req4 , Req5 , Req6 , Req7 , Req8 , Req9 ,
  Req10, Req11, Req12, Req13, Req14, Req15, Req16, Req17, Req18, Req19,
  Req20, Req21, Req22, Req23, Req24, Req25, Req26, Req27, Req28, Req29,
  Req30, Req31,
  //--------------------------------
  Ack0 , Ack1 , Ack2 , Ack3 , Ack4 , Ack5 , Ack6 , Ack7 , Ack8 , Ack9 ,
  Ack10, Ack11, Ack12, Ack13, Ack14, Ack15, Ack16, Ack17, Ack18, Ack19,
  Ack20, Ack21, Ack22, Ack23, Ack24, Ack25, Ack26, Ack27, Ack28, Ack29,
  Ack30, Ack31,
  Grant ,
  Select,
  Done
) ;

  input CLK ;
  input RSTn ;
  input Req0 , Req1,  Req2 , Req3 , Req4 , Req5 , Req6 , Req7 , Req8 , Req9 ,
  Req10, Req11, Req12, Req13, Req14, Req15, Req16, Req17, Req18, Req19,
  Req20, Req21, Req22, Req23, Req24, Req25, Req26, Req27, Req28, Req29,
  Req30, Req31;
  //--------------------------------
  output reg Ack0 , Ack1 , Ack2 , Ack3 , Ack4 , Ack5 , Ack6 , Ack7 , Ack8 , Ack9 ,
  Ack10, Ack11, Ack12, Ack13, Ack14, Ack15, Ack16, Ack17, Ack18, Ack19,
  Ack20, Ack21, Ack22, Ack23, Ack24, Ack25, Ack26, Ack27, Ack28, Ack29,
  Ack30, Ack31;
  output reg Grant ;
  output reg [4:0] Select ;
  input Done ;

  wire [31:0] Request_Buffer ;
  bit[31:0]  temp_var ;

  assign Request_Buffer[31] = Req31 | 1'b0 ; 
  assign Request_Buffer[30] = Req30 | 1'b0 ; 
  assign Request_Buffer[29] = Req29 | 1'b0 ; 
  assign Request_Buffer[28] = Req28 | 1'b0 ; 
  assign Request_Buffer[27] = Req27 | 1'b0 ; 
  assign Request_Buffer[26] = Req26 | 1'b0 ; 
  assign Request_Buffer[25] = Req25 | 1'b0 ; 
  assign Request_Buffer[24] = Req24 | 1'b0 ; 
  assign Request_Buffer[23] = Req23 | 1'b0 ; 
  assign Request_Buffer[22] = Req22 | 1'b0 ; 
  assign Request_Buffer[21] = Req21 | 1'b0 ; 
  assign Request_Buffer[20] = Req20 | 1'b0 ; 
  assign Request_Buffer[19] = Req19 | 1'b0 ; 
  assign Request_Buffer[18] = Req18 | 1'b0 ; 
  assign Request_Buffer[17] = Req17 | 1'b0 ; 
  assign Request_Buffer[16] = Req16 | 1'b0 ; 
  assign Request_Buffer[15] = Req15 | 1'b0 ; 
  assign Request_Buffer[14] = Req14 | 1'b0 ; 
  assign Request_Buffer[13] = Req13 | 1'b0 ; 
  assign Request_Buffer[12] = Req12 | 1'b0 ; 
  assign Request_Buffer[11] = Req11 | 1'b0 ; 
  assign Request_Buffer[10] = Req10 | 1'b0 ; 
  assign Request_Buffer[9]  = Req9  | 1'b0 ;
  assign Request_Buffer[8]  = Req8  | 1'b0 ;
  assign Request_Buffer[7]  = Req7  | 1'b0 ;
  assign Request_Buffer[6]  = Req6  | 1'b0 ;
  assign Request_Buffer[5]  = Req5  | 1'b0 ;
  assign Request_Buffer[4]  = Req4  | 1'b0 ;
  assign Request_Buffer[3]  = Req3  | 1'b0 ;
  assign Request_Buffer[2]  = Req2  | 1'b0 ;
  assign Request_Buffer[1]  = Req1  | 1'b0 ;
  assign Request_Buffer[0]  = Req0  | 1'b0 ;



   arbiterState StateMC, next_StateMC ;
   int local_priority_reg, local_priority_val , local_index;

   always@(posedge CLK or negedge RSTn) begin
     if(RSTn == 0) begin
	   local_priority_reg <=  0 ;
	   StateMC <= Evaluate ;
	 end
	 else begin
       local_priority_reg <= local_priority_val ;
       StateMC <= next_StateMC ;
	 end
   end

   always@(*) begin
      case(StateMC)
	      Evaluate   :  begin
		                  Grant = 0 ;
						{Ack0 , Ack1 , Ack2 , Ack3 , Ack4 , Ack5 , Ack6 , Ack7 , Ack8 , Ack9 ,
						 Ack10, Ack11, Ack12, Ack13, Ack14, Ack15, Ack16, Ack17, Ack18, Ack19,
						 Ack20, Ack21, Ack22, Ack23, Ack24, Ack25, Ack26, Ack27, Ack28, Ack29,
						 Ack30, Ack31}  =  32'h00000000 ;
						 Select = 5'b0000 ;
						 //local_priority_val = 0 ;						  
		                  if(|Request_Buffer !=0) begin
						       local_index = (getNextInPriority(Request_Buffer) + local_priority_reg +1)%32 + 1 ;
							   next_StateMC = arbiterState'(local_index) ;
							   local_priority_val = local_index ;
							   if(Request_Buffer=='h00000040) begin
							   $display("LOCAL_INDEX = %d", local_index, $time);
							   $display("local_priority_reg = %d", local_priority_reg, $time);
							   end
						  end
						  else next_StateMC = Evaluate ;
		                end
		State0       :  begin
		                  if(Req0 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant  = 1 ;
							  Select = 5'b00000 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack0 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State0 ;
						  end		               
						end
		State1       :  begin
		                  if(Req1 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00001 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack1 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State1 ;
						  end
		                end
		State2       :  begin
		                  if(Req2 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00010 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack2 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State2 ;
						  end
		                end
		State3       :  begin
		                  if(Req3 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00011 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack3 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State3 ;
						  end
		                end
		State4       :  begin
		                  if(Req4 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00100 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack4 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State4 ;
						  end
		                end
		State5       :  begin
		                  if(Req5 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00101 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack5 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State5 ;
						  end
		                end
		State6       :  begin
		                  if(Req6 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00110 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack6 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State6 ;
						  end
		                end
		State7       :  begin
		                  if(Req7 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b00111 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack7 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State7 ;
						  end
		                end
		State8       :  begin
		                  if(Req8 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01000 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack8 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State8 ;
						  end
		                end
		State9       :  begin
		                  if(Req9 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01001 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack9 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State9 ;
						  end
		                end
		State10      :  begin
		                  if(Req10 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01010 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack10 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State10 ;
						  end
		                end
		State11       :  begin
		                  if(Req11 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01011 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack11 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State11 ;
						  end
		                end
		State12       :  begin
		                  if(Req12 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01100 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack12 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State12 ;
						  end
		                end
		State13       :  begin
		                  if(Req13 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01101 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack13 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State13 ;
						  end
		                end
		State14       :  begin
		                  if(Req14 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01110 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack14 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State14 ;
						  end
		                end
		State15       :  begin
		                  if(Req15 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b01111 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack15 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State15 ;
						  end
		                end
		State16       :  begin
		                  if(Req16 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10000 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack16 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State16 ;
						  end
		                end
		State17       :  begin
		                  if(Req17 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10001 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack17 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State17 ;
						  end
		                end
		State18       :  begin
		                  if(Req18 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10010 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack18 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State18 ;
						  end
		                end
		State19       :  begin
		                  if(Req19 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10011 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack19 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State19 ;
						  end
		                end
		State20      :  begin
		                  if(Req20 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10100 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack20 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State20 ;
						  end
		                end
		State21       :  begin
		                  if(Req21 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10101 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack21 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State21 ;
						  end
		                end
		State22       :  begin
		                  if(Req22 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10110 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack22 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State22 ;
						  end
		                end
		State23       :  begin
		                  if(Req23 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b10111 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack23 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State23 ;
						  end
		                end
		State24       :  begin
		                  if(Req24 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11000 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack24 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State24 ;
						  end
		                end
		State25       :  begin
		                  if(Req25 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11001 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack25 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State25 ;
						  end
		                end
		State26       :  begin
		                  if(Req26 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11010 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack26 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State26 ;
						  end
		                end
		State27       :  begin
		                  if(Req27 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11011 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack27 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State27 ;
						  end
		                end
		State28       :  begin
		                  if(Req28 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11100 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack28 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State28 ;
						  end
		                end
		State29       :  begin
		                  if(Req29 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11101 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack29 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State29 ;
						  end
		                end
		State30      :  begin
		                  if(Req30 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11110 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack30 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State30 ;
						  end
						end
		State31      :  begin
		                  if(Req31 != 1) next_StateMC = Evaluate ;
						  else begin
						      Grant = 1 ;
							  Select = 5'b11111 ;
							  if(Done == 1) begin
							       Grant = 0 ;
								   Ack31 = 1 ;
								   next_StateMC = EndState ;
							  end
							  else next_StateMC = State31 ;
						  end
		                end
		EndState    :   begin
		                //----- Release all Acks -------
						{Ack0 , Ack1 , Ack2 , Ack3 , Ack4 , Ack5 , Ack6 , Ack7 , Ack8 , Ack9 ,
						 Ack10, Ack11, Ack12, Ack13, Ack14, Ack15, Ack16, Ack17, Ack18, Ack19,
						 Ack20, Ack21, Ack22, Ack23, Ack24, Ack25, Ack26, Ack27, Ack28, Ack29,
						 Ack30, Ack31}  =  32'h00000000 ;
						 next_StateMC = Evaluate ;
		                end
	  endcase
   end

function automatic int getNextInPriority (bit[31:0] Request_Buffer);
  temp_var = Request_Buffer ;
  for(int i=0; i<= local_priority_reg; i++) begin
     temp_var = {temp_var[0],temp_var[31:1]};
  end
  for(int j=0; j< 32; j++) begin
	     if (temp_var[j]==1) begin   $display("DAMN_J = %d", j, $time) ;return j ;  end
  end
  return 0 ;
endfunction


endmodule

