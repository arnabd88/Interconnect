interface Event_Interface();

bit signal_test_finish ;
event Simulation_End ;
int test_num ;
event test_end ;
event finish_test ;
event start_test ;
event env_start ;

always@(finish_test) begin
	  wait( ~core_intf.Core0_Req  &&
	        ~core_intf.Core1_Req  &&
	        ~core_intf.Core2_Req  &&
	        ~core_intf.Core3_Req  &&
	        ~core_intf.Core4_Req  &&
	        ~core_intf.Core5_Req  &&
	        ~core_intf.Core6_Req  &&
	        ~core_intf.Core7_Req  &&
	        ~core_intf.Core8_Req  &&
	        ~core_intf.Core9_Req  &&
	        ~core_intf.Core10_Req &&
	        ~core_intf.Core11_Req &&
	        ~core_intf.Core12_Req &&
	        ~core_intf.Core13_Req &&
	        ~core_intf.Core14_Req &&
	        ~core_intf.Core15_Req &&
	        ~core_intf.Core16_Req &&
	        ~core_intf.Core17_Req &&
	        ~core_intf.Core18_Req &&
	        ~core_intf.Core19_Req &&
	        ~core_intf.Core20_Req &&
	        ~core_intf.Core21_Req &&
	        ~core_intf.Core22_Req &&
	        ~core_intf.Core23_Req &&
	        ~core_intf.Core24_Req &&
	        ~core_intf.Core25_Req &&
	        ~core_intf.Core26_Req &&
	        ~core_intf.Core27_Req &&
	        ~core_intf.Core28_Req &&
	        ~core_intf.Core29_Req &&
	        ~core_intf.Core30_Req &&
	        ~core_intf.Core31_Req ) ;
	signal_test_finish <= 1'b1 ;
end

endinterface
