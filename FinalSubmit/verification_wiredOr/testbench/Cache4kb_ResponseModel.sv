///----------- This is a dummy cache response model whioch provides a latency-----------------------------
//------------ return value between 1 cycle to a max latency cycleon receiving a request one one of-------
//------------ its input lines ---------------------------------------------------------------------------

`define MAX_CACHE_LATENCY 2

module Cache4kb_ResponseModel (
	CLK, 
	RSTn, 
	Cache_Bank0_Req  ,
	Cache_Bank1_Req  ,
	Cache_Bank2_Req  ,
	Cache_Bank3_Req  ,
	Cache_Bank4_Req  ,
	Cache_Bank5_Req  ,
	Cache_Bank6_Req  ,
	Cache_Bank7_Req  ,
	Cache_Bank8_Req  ,
	Cache_Bank9_Req  ,
	Cache_Bank10_Req ,
	Cache_Bank11_Req ,
	Cache_Bank12_Req ,
	Cache_Bank13_Req ,
	Cache_Bank14_Req ,
	Cache_Bank15_Req ,
	//---------------
	Cache_Bank0_AddrIn  ,
	Cache_Bank1_AddrIn  ,
	Cache_Bank2_AddrIn  ,
	Cache_Bank3_AddrIn  ,
	Cache_Bank4_AddrIn  ,
	Cache_Bank5_AddrIn  ,
	Cache_Bank6_AddrIn  ,
	Cache_Bank7_AddrIn  ,
	Cache_Bank8_AddrIn  ,
	Cache_Bank9_AddrIn  ,
	Cache_Bank10_AddrIn ,
	Cache_Bank11_AddrIn ,
	Cache_Bank12_AddrIn ,
	Cache_Bank13_AddrIn ,
	Cache_Bank14_AddrIn ,
	Cache_Bank15_AddrIn ,
	//---------------
	Cache_Bank0_Ack  ,
	Cache_Bank1_Ack  ,
	Cache_Bank2_Ack  ,
	Cache_Bank3_Ack  ,
	Cache_Bank4_Ack  ,
	Cache_Bank5_Ack  ,
	Cache_Bank6_Ack  ,
	Cache_Bank7_Ack  ,
	Cache_Bank8_Ack  ,
	Cache_Bank9_Ack  ,
	Cache_Bank10_Ack ,
	Cache_Bank11_Ack ,
	Cache_Bank12_Ack ,
	Cache_Bank13_Ack ,
	Cache_Bank14_Ack ,
	Cache_Bank15_Ack ,
	//--------------
	Cache_Bank0_DataOut  ,
	Cache_Bank1_DataOut  ,
	Cache_Bank2_DataOut  ,
	Cache_Bank3_DataOut  ,
	Cache_Bank4_DataOut  ,
	Cache_Bank5_DataOut  ,
	Cache_Bank6_DataOut  ,
	Cache_Bank7_DataOut  ,
	Cache_Bank8_DataOut  ,
	Cache_Bank9_DataOut  ,
	Cache_Bank10_DataOut ,
	Cache_Bank11_DataOut ,
	Cache_Bank12_DataOut ,
	Cache_Bank13_DataOut ,
	Cache_Bank14_DataOut ,
	Cache_Bank15_DataOut 
);


	input CLK, RSTn ;
	input Cache_Bank0_Req  ;
	input Cache_Bank1_Req  ;
	input Cache_Bank2_Req  ;
	input Cache_Bank3_Req  ;
	input Cache_Bank4_Req  ;
	input Cache_Bank5_Req  ;
	input Cache_Bank6_Req  ;
	input Cache_Bank7_Req  ;
	input Cache_Bank8_Req  ;
	input Cache_Bank9_Req  ;
	input Cache_Bank10_Req ;
	input Cache_Bank11_Req ;
	input Cache_Bank12_Req ;
	input Cache_Bank13_Req ;
	input Cache_Bank14_Req ;
	input Cache_Bank15_Req ;
	//---------------
	input [31:0] Cache_Bank0_AddrIn  ;
	input [31:0] Cache_Bank1_AddrIn  ;
	input [31:0] Cache_Bank2_AddrIn  ;
	input [31:0] Cache_Bank3_AddrIn  ;
	input [31:0] Cache_Bank4_AddrIn  ;
	input [31:0] Cache_Bank5_AddrIn  ;
	input [31:0] Cache_Bank6_AddrIn  ;
	input [31:0] Cache_Bank7_AddrIn  ;
	input [31:0] Cache_Bank8_AddrIn  ;
	input [31:0] Cache_Bank9_AddrIn  ;
	input [31:0] Cache_Bank10_AddrIn ;
	input [31:0] Cache_Bank11_AddrIn ;
	input [31:0] Cache_Bank12_AddrIn ;
	input [31:0] Cache_Bank13_AddrIn ;
	input [31:0] Cache_Bank14_AddrIn ;
	input [31:0] Cache_Bank15_AddrIn ;
	//---------------
	output reg Cache_Bank0_Ack  ;
	output reg Cache_Bank1_Ack  ;
	output reg Cache_Bank2_Ack  ;
	output reg Cache_Bank3_Ack  ;
	output reg Cache_Bank4_Ack  ;
	output reg Cache_Bank5_Ack  ;
	output reg Cache_Bank6_Ack  ;
	output reg Cache_Bank7_Ack  ;
	output reg Cache_Bank8_Ack  ;
	output reg Cache_Bank9_Ack  ;
	output reg Cache_Bank10_Ack ;
	output reg Cache_Bank11_Ack ;
	output reg Cache_Bank12_Ack ;
	output reg Cache_Bank13_Ack ;
	output reg Cache_Bank14_Ack ;
	output reg Cache_Bank15_Ack ;
	//--------------
	output reg[31:0] Cache_Bank0_DataOut  ;
	output reg[31:0] Cache_Bank1_DataOut  ;
	output reg[31:0] Cache_Bank2_DataOut  ;
	output reg[31:0] Cache_Bank3_DataOut  ;
	output reg[31:0] Cache_Bank4_DataOut  ;
	output reg[31:0] Cache_Bank5_DataOut  ;
	output reg[31:0] Cache_Bank6_DataOut  ;
	output reg[31:0] Cache_Bank7_DataOut  ;
	output reg[31:0] Cache_Bank8_DataOut  ;
	output reg[31:0] Cache_Bank9_DataOut  ;
	output reg[31:0] Cache_Bank10_DataOut ;
	output reg[31:0] Cache_Bank11_DataOut ;
	output reg[31:0] Cache_Bank12_DataOut ;
	output reg[31:0] Cache_Bank13_DataOut ;
	output reg[31:0] Cache_Bank14_DataOut ;
	output reg[31:0] Cache_Bank15_DataOut ;

	event Bank0_task ;


	always@(posedge CLK) if(Cache_Bank0_Req==1)  Bank0_Response() ;
	always@(posedge CLK) if(Cache_Bank1_Req==1)  Bank1_Response() ;
	always@(posedge CLK) if(Cache_Bank2_Req==1)  Bank2_Response() ;
	always@(posedge CLK) if(Cache_Bank3_Req==1)  Bank3_Response() ;
	always@(posedge CLK) if(Cache_Bank4_Req==1)  Bank4_Response() ;
	always@(posedge CLK) if(Cache_Bank5_Req==1)  Bank5_Response() ;
	always@(posedge CLK) if(Cache_Bank6_Req==1)  Bank6_Response() ;
	always@(posedge CLK) if(Cache_Bank7_Req==1)  Bank7_Response() ;
	always@(posedge CLK) if(Cache_Bank8_Req==1)  Bank8_Response() ;
	always@(posedge CLK) if(Cache_Bank9_Req==1)  Bank9_Response() ;
	always@(posedge CLK) if(Cache_Bank10_Req==1) Bank10_Response();
	always@(posedge CLK) if(Cache_Bank11_Req==1) Bank11_Response();
	always@(posedge CLK) if(Cache_Bank12_Req==1) Bank12_Response();
	always@(posedge CLK) if(Cache_Bank13_Req==1) Bank13_Response();
	always@(posedge CLK) if(Cache_Bank14_Req==1) Bank14_Response();
	always@(posedge CLK) if(Cache_Bank15_Req==1) Bank15_Response();


	task Bank0_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	    -> Bank0_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank0_DataOut <= $random();
		Cache_Bank0_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank0_Ack     <= 1'b0 ;
	endtask

	task Bank1_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank1_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank1_DataOut <= $random();
		Cache_Bank1_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank1_Ack     <= 1'b0 ;
	endtask

	task Bank2_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank2_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank2_DataOut <= $random();
		Cache_Bank2_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank2_Ack     <= 1'b0 ;
	endtask
	task Bank3_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank3_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank3_DataOut <= $random();
		Cache_Bank3_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank3_Ack     <= 1'b0 ;
	endtask
	task Bank4_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank4_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank4_DataOut <= $random();
		Cache_Bank4_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank4_Ack     <= 1'b0 ;
	endtask
	task Bank5_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank5_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank5_DataOut <= $random();
		Cache_Bank5_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank5_Ack     <= 1'b0 ;
	endtask
	task Bank6_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank6_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank6_DataOut <= $random();
		Cache_Bank6_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank6_Ack     <= 1'b0 ;
	endtask

	task Bank7_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank7_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank7_DataOut <= $random();
		Cache_Bank7_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank7_Ack     <= 1'b0 ;
	endtask
	task Bank8_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank8_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank8_DataOut <= $random();
		Cache_Bank8_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank8_Ack     <= 1'b0 ;
	endtask
	task Bank9_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank9_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank9_DataOut <= $random();
		Cache_Bank9_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank9_Ack     <= 1'b0 ;
	endtask
	task Bank10_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank10_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank10_DataOut <= $random();
		Cache_Bank10_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank10_Ack     <= 1'b0 ;
	endtask
	task Bank11_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank11_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank11_DataOut <= $random();
		Cache_Bank11_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank11_Ack     <= 1'b0 ;
	endtask
	task Bank12_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank12_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank12_DataOut <= $random();
		Cache_Bank12_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank12_Ack     <= 1'b0 ;
	endtask
	task Bank13_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank13_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank13_DataOut <= $random();
		Cache_Bank13_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank13_Ack     <= 1'b0 ;
	endtask
	task Bank14_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank14_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank14_DataOut <= $random();
		Cache_Bank14_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank14_Ack     <= 1'b0 ;
	endtask
	task Bank15_Response();
	    int cycle ;
		cycle = $urandom_range(1,3);
	   // -> Bank15_task ;
		repeat(cycle) @(posedge CLK);
		Cache_Bank15_DataOut <= $random();
		Cache_Bank15_Ack     <= 1'b1 ;
		@(posedge CLK);
		Cache_Bank15_Ack     <= 1'b0 ;
	endtask

endmodule
