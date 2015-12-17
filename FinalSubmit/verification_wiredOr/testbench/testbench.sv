
`include "tp32toICache4kb.sv"
`include "CoreDriveStimulus.sv"
`include "interconnect_defines.sv"
`include "EventInterface.sv"
`include "CoreInterface.sv"
`include "CacheInterface.sv"
`include "driver.sv"
`include "environment.sv"
`include "generator.sv"
`include "generic_test.sv"
`include "interconnect_single_request.sv"
`include "interconnect_single_bank_multiple_request.sv"
`include "interconnect_test.sv"
`include "Root_Test_Admin.sv"
`include "Cache4kb_ResponseModel.sv"

module testbench();

logic CLK ;
int diff_counter ;
mailbox#(CoreDriveStimulus) mbx ;

always #50 CLK = ~CLK ;

    Core_Interface      core_intf(.CLK(CLK));
	Cache_Interface    cache_intf(.CLK(CLK));
	Event_Interface    event_intf();

	tp32toICache4kb   u_dut (
                             .CLK(CLK) ,
							 .RSTn(core_intf.RSTn),
                             //----- Interface Core to Interconnect ------//
                            .Core0_Req  (core_intf.Core0_Req ),
							.Core1_Req  (core_intf.Core1_Req ),
							.Core2_Req  (core_intf.Core2_Req ),
							.Core3_Req  (core_intf.Core3_Req ),
							.Core4_Req  (core_intf.Core4_Req ),
							.Core5_Req  (core_intf.Core5_Req ),
							.Core6_Req  (core_intf.Core6_Req ),
							.Core7_Req  (core_intf.Core7_Req ),
							.Core8_Req  (core_intf.Core8_Req ),
							.Core9_Req  (core_intf.Core9_Req ), 
                            .Core10_Req (core_intf.Core10_Req),
							.Core11_Req (core_intf.Core11_Req),
							.Core12_Req (core_intf.Core12_Req),
							.Core13_Req (core_intf.Core13_Req),
							.Core14_Req (core_intf.Core14_Req),
							.Core15_Req (core_intf.Core15_Req),
							.Core16_Req (core_intf.Core16_Req),
							.Core17_Req (core_intf.Core17_Req),
							.Core18_Req (core_intf.Core18_Req),
							.Core19_Req (core_intf.Core19_Req), 
                            .Core20_Req (core_intf.Core20_Req),
							.Core21_Req (core_intf.Core21_Req),
							.Core22_Req (core_intf.Core22_Req),
							.Core23_Req (core_intf.Core23_Req),
							.Core24_Req (core_intf.Core24_Req),
							.Core25_Req (core_intf.Core25_Req),
							.Core26_Req (core_intf.Core26_Req),
							.Core27_Req (core_intf.Core27_Req),
							.Core28_Req (core_intf.Core28_Req),
							.Core29_Req (core_intf.Core29_Req),
                            .Core30_Req (core_intf.Core30_Req),
							.Core31_Req (core_intf.Core31_Req), 

                            .Core0_Ack  (core_intf.Core0_Ack ),
							.Core1_Ack  (core_intf.Core1_Ack ),
							.Core2_Ack  (core_intf.Core2_Ack ),
							.Core3_Ack  (core_intf.Core3_Ack ),
							.Core4_Ack  (core_intf.Core4_Ack ),
							.Core5_Ack  (core_intf.Core5_Ack ),
							.Core6_Ack  (core_intf.Core6_Ack ),
							.Core7_Ack  (core_intf.Core7_Ack ),
							.Core8_Ack  (core_intf.Core8_Ack ),
							.Core9_Ack  (core_intf.Core9_Ack ),
                            .Core10_Ack (core_intf.Core10_Ack),
							.Core11_Ack (core_intf.Core11_Ack),
							.Core12_Ack (core_intf.Core12_Ack),
							.Core13_Ack (core_intf.Core13_Ack),
							.Core14_Ack (core_intf.Core14_Ack),
							.Core15_Ack (core_intf.Core15_Ack),
							.Core16_Ack (core_intf.Core16_Ack),
							.Core17_Ack (core_intf.Core17_Ack),
							.Core18_Ack (core_intf.Core18_Ack),
							.Core19_Ack (core_intf.Core19_Ack),
                            .Core20_Ack (core_intf.Core20_Ack),
							.Core21_Ack (core_intf.Core21_Ack),
							.Core22_Ack (core_intf.Core22_Ack),
							.Core23_Ack (core_intf.Core23_Ack),
							.Core24_Ack (core_intf.Core24_Ack),
							.Core25_Ack (core_intf.Core25_Ack),
							.Core26_Ack (core_intf.Core26_Ack),
							.Core27_Ack (core_intf.Core27_Ack),
							.Core28_Ack (core_intf.Core28_Ack),
							.Core29_Ack (core_intf.Core29_Ack),
                            .Core30_Ack (core_intf.Core30_Ack),
							.Core31_Ack (core_intf.Core31_Ack),

                            .Core0_AddressIn  (core_intf.Core0_Addr ),
							.Core1_AddressIn  (core_intf.Core1_Addr ),
							.Core2_AddressIn  (core_intf.Core2_Addr ),
							.Core3_AddressIn  (core_intf.Core3_Addr ),
							.Core4_AddressIn  (core_intf.Core4_Addr ),
							.Core5_AddressIn  (core_intf.Core5_Addr ),
							.Core6_AddressIn  (core_intf.Core6_Addr ),
							.Core7_AddressIn  (core_intf.Core7_Addr ),
							.Core8_AddressIn  (core_intf.Core8_Addr ),
							.Core9_AddressIn  (core_intf.Core9_Addr ),
                            .Core10_AddressIn (core_intf.Core10_Addr),
							.Core11_AddressIn (core_intf.Core11_Addr),
							.Core12_AddressIn (core_intf.Core12_Addr),
							.Core13_AddressIn (core_intf.Core13_Addr),
							.Core14_AddressIn (core_intf.Core14_Addr),
							.Core15_AddressIn (core_intf.Core15_Addr),
							.Core16_AddressIn (core_intf.Core16_Addr),
							.Core17_AddressIn (core_intf.Core17_Addr),
							.Core18_AddressIn (core_intf.Core18_Addr),
							.Core19_AddressIn (core_intf.Core19_Addr),
                            .Core20_AddressIn (core_intf.Core20_Addr),
							.Core21_AddressIn (core_intf.Core21_Addr),
							.Core22_AddressIn (core_intf.Core22_Addr),
							.Core23_AddressIn (core_intf.Core23_Addr),
							.Core24_AddressIn (core_intf.Core24_Addr),
							.Core25_AddressIn (core_intf.Core25_Addr),
							.Core26_AddressIn (core_intf.Core26_Addr),
							.Core27_AddressIn (core_intf.Core27_Addr),
							.Core28_AddressIn (core_intf.Core28_Addr),
							.Core29_AddressIn (core_intf.Core29_Addr),
                            .Core30_AddressIn (core_intf.Core30_Addr),
							.Core31_AddressIn (core_intf.Core31_Addr),

                            .Core0_DataOut  (core_intf.Core0_Data ),
							.Core1_DataOut  (core_intf.Core1_Data ),
							.Core2_DataOut  (core_intf.Core2_Data ),
							.Core3_DataOut  (core_intf.Core3_Data ),
							.Core4_DataOut  (core_intf.Core4_Data ),
							.Core5_DataOut  (core_intf.Core5_Data ),
							.Core6_DataOut  (core_intf.Core6_Data ),
							.Core7_DataOut  (core_intf.Core7_Data ),
							.Core8_DataOut  (core_intf.Core8_Data ),
							.Core9_DataOut  (core_intf.Core9_Data ),
                            .Core10_DataOut (core_intf.Core10_Data),
							.Core11_DataOut (core_intf.Core11_Data),
							.Core12_DataOut (core_intf.Core12_Data),
							.Core13_DataOut (core_intf.Core13_Data),
							.Core14_DataOut (core_intf.Core14_Data),
							.Core15_DataOut (core_intf.Core15_Data),
							.Core16_DataOut (core_intf.Core16_Data),
							.Core17_DataOut (core_intf.Core17_Data),
							.Core18_DataOut (core_intf.Core18_Data),
							.Core19_DataOut (core_intf.Core19_Data),
                            .Core20_DataOut (core_intf.Core20_Data),
							.Core21_DataOut (core_intf.Core21_Data),
							.Core22_DataOut (core_intf.Core22_Data),
							.Core23_DataOut (core_intf.Core23_Data),
							.Core24_DataOut (core_intf.Core24_Data),
							.Core25_DataOut (core_intf.Core25_Data),
							.Core26_DataOut (core_intf.Core26_Data),
							.Core27_DataOut (core_intf.Core27_Data),
							.Core28_DataOut (core_intf.Core28_Data),
							.Core29_DataOut (core_intf.Core29_Data),
                            .Core30_DataOut (core_intf.Core30_Data),
							.Core31_DataOut (core_intf.Core31_Data),

 //------- Interconnect to Cache Bank Interface ---------//
                            .Bank0_Req  (cache_intf.Bank0_Req ),
							.Bank1_Req  (cache_intf.Bank1_Req ),
							.Bank2_Req  (cache_intf.Bank2_Req ),
							.Bank3_Req  (cache_intf.Bank3_Req ),
							.Bank4_Req  (cache_intf.Bank4_Req ),
							.Bank5_Req  (cache_intf.Bank5_Req ),
							.Bank6_Req  (cache_intf.Bank6_Req ),
							.Bank7_Req  (cache_intf.Bank7_Req ),
							.Bank8_Req  (cache_intf.Bank8_Req ),
							.Bank9_Req  (cache_intf.Bank9_Req ),
                            .Bank10_Req (cache_intf.Bank10_Req),
							.Bank11_Req (cache_intf.Bank11_Req),
							.Bank12_Req (cache_intf.Bank12_Req),
							.Bank13_Req (cache_intf.Bank13_Req),
							.Bank14_Req (cache_intf.Bank14_Req),
							.Bank15_Req (cache_intf.Bank15_Req),

                            .Bank0_Ack  (cache_intf.Bank0_Ack ),
							.Bank1_Ack  (cache_intf.Bank1_Ack ),
							.Bank2_Ack  (cache_intf.Bank2_Ack ),
							.Bank3_Ack  (cache_intf.Bank3_Ack ),
							.Bank4_Ack  (cache_intf.Bank4_Ack ),
							.Bank5_Ack  (cache_intf.Bank5_Ack ),
							.Bank6_Ack  (cache_intf.Bank6_Ack ),
							.Bank7_Ack  (cache_intf.Bank7_Ack ),
							.Bank8_Ack  (cache_intf.Bank8_Ack ),
							.Bank9_Ack  (cache_intf.Bank9_Ack ),
                            .Bank10_Ack (cache_intf.Bank10_Ack),
							.Bank11_Ack (cache_intf.Bank11_Ack),
							.Bank12_Ack (cache_intf.Bank12_Ack),
							.Bank13_Ack (cache_intf.Bank13_Ack),
							.Bank14_Ack (cache_intf.Bank14_Ack),
							.Bank15_Ack (cache_intf.Bank15_Ack),

                            .Bank0_AddressOut  (cache_intf.Bank0_Addr ),
							.Bank1_AddressOut  (cache_intf.Bank1_Addr ),
							.Bank2_AddressOut  (cache_intf.Bank2_Addr ),
							.Bank3_AddressOut  (cache_intf.Bank3_Addr ),
							.Bank4_AddressOut  (cache_intf.Bank4_Addr ),
							.Bank5_AddressOut  (cache_intf.Bank5_Addr ),
							.Bank6_AddressOut  (cache_intf.Bank6_Addr ),
							.Bank7_AddressOut  (cache_intf.Bank7_Addr ),
							.Bank8_AddressOut  (cache_intf.Bank8_Addr ),
							.Bank9_AddressOut  (cache_intf.Bank9_Addr ),
                            .Bank10_AddressOut (cache_intf.Bank10_Addr),
							.Bank11_AddressOut (cache_intf.Bank11_Addr),
							.Bank12_AddressOut (cache_intf.Bank12_Addr),
							.Bank13_AddressOut (cache_intf.Bank13_Addr),
							.Bank14_AddressOut (cache_intf.Bank14_Addr),
							.Bank15_AddressOut (cache_intf.Bank15_Addr),

                            .Bank0_DataIn  (cache_intf.Bank0_Data  ),
							.Bank1_DataIn  (cache_intf.Bank1_Data  ),
							.Bank2_DataIn  (cache_intf.Bank2_Data  ),
							.Bank3_DataIn  (cache_intf.Bank3_Data  ),
							.Bank4_DataIn  (cache_intf.Bank4_Data  ),
							.Bank5_DataIn  (cache_intf.Bank5_Data  ),
							.Bank6_DataIn  (cache_intf.Bank6_Data  ),
							.Bank7_DataIn  (cache_intf.Bank7_Data  ),
							.Bank8_DataIn  (cache_intf.Bank8_Data  ),
							.Bank9_DataIn  (cache_intf.Bank9_Data  ),
                            .Bank10_DataIn (cache_intf.Bank10_Data ),
							.Bank11_DataIn (cache_intf.Bank11_Data ),
							.Bank12_DataIn (cache_intf.Bank12_Data ),
							.Bank13_DataIn (cache_intf.Bank13_Data ),
							.Bank14_DataIn (cache_intf.Bank14_Data ),
							.Bank15_DataIn (cache_intf.Bank15_Data )
	                  ) ;


 Cache4kb_ResponseModel u_Cache4kb (
	                        .CLK(CLK), 
	                        .RSTn(core_intf.RSTn), 
	                        .Cache_Bank0_Req  (cache_intf.Bank0_Req ),
	                        .Cache_Bank1_Req  (cache_intf.Bank1_Req ),
	                        .Cache_Bank2_Req  (cache_intf.Bank2_Req ),
	                        .Cache_Bank3_Req  (cache_intf.Bank3_Req ),
	                        .Cache_Bank4_Req  (cache_intf.Bank4_Req ),
	                        .Cache_Bank5_Req  (cache_intf.Bank5_Req ),
	                        .Cache_Bank6_Req  (cache_intf.Bank6_Req ),
	                        .Cache_Bank7_Req  (cache_intf.Bank7_Req ),
	                        .Cache_Bank8_Req  (cache_intf.Bank8_Req ),
	                        .Cache_Bank9_Req  (cache_intf.Bank9_Req ),
	                        .Cache_Bank10_Req (cache_intf.Bank10_Req),
	                        .Cache_Bank11_Req (cache_intf.Bank11_Req),
	                        .Cache_Bank12_Req (cache_intf.Bank12_Req),
	                        .Cache_Bank13_Req (cache_intf.Bank13_Req),
	                        .Cache_Bank14_Req (cache_intf.Bank14_Req),
	                        .Cache_Bank15_Req (cache_intf.Bank15_Req),
	                        //---------------
	                        .Cache_Bank0_AddrIn  (cache_intf.Bank0_Addr ),
	                        .Cache_Bank1_AddrIn  (cache_intf.Bank1_Addr ),
	                        .Cache_Bank2_AddrIn  (cache_intf.Bank2_Addr ),
	                        .Cache_Bank3_AddrIn  (cache_intf.Bank3_Addr ),
	                        .Cache_Bank4_AddrIn  (cache_intf.Bank4_Addr ),
	                        .Cache_Bank5_AddrIn  (cache_intf.Bank5_Addr ),
	                        .Cache_Bank6_AddrIn  (cache_intf.Bank6_Addr ),
	                        .Cache_Bank7_AddrIn  (cache_intf.Bank7_Addr ),
	                        .Cache_Bank8_AddrIn  (cache_intf.Bank8_Addr ),
	                        .Cache_Bank9_AddrIn  (cache_intf.Bank9_Addr ),
	                        .Cache_Bank10_AddrIn (cache_intf.Bank10_Addr),
	                        .Cache_Bank11_AddrIn (cache_intf.Bank11_Addr),
	                        .Cache_Bank12_AddrIn (cache_intf.Bank12_Addr),
	                        .Cache_Bank13_AddrIn (cache_intf.Bank13_Addr),
	                        .Cache_Bank14_AddrIn (cache_intf.Bank14_Addr),
	                        .Cache_Bank15_AddrIn (cache_intf.Bank15_Addr),
	                        //---------------
	                        .Cache_Bank0_Ack  (cache_intf.Bank0_Ack ),
	                        .Cache_Bank1_Ack  (cache_intf.Bank1_Ack ),
	                        .Cache_Bank2_Ack  (cache_intf.Bank2_Ack ),
	                        .Cache_Bank3_Ack  (cache_intf.Bank3_Ack ),
	                        .Cache_Bank4_Ack  (cache_intf.Bank4_Ack ),
	                        .Cache_Bank5_Ack  (cache_intf.Bank5_Ack ),
	                        .Cache_Bank6_Ack  (cache_intf.Bank6_Ack ),
	                        .Cache_Bank7_Ack  (cache_intf.Bank7_Ack ),
	                        .Cache_Bank8_Ack  (cache_intf.Bank8_Ack ),
	                        .Cache_Bank9_Ack  (cache_intf.Bank9_Ack ),
	                        .Cache_Bank10_Ack (cache_intf.Bank10_Ack),
	                        .Cache_Bank11_Ack (cache_intf.Bank11_Ack),
	                        .Cache_Bank12_Ack (cache_intf.Bank12_Ack),
	                        .Cache_Bank13_Ack (cache_intf.Bank13_Ack),
	                        .Cache_Bank14_Ack (cache_intf.Bank14_Ack),
	                        .Cache_Bank15_Ack (cache_intf.Bank15_Ack),
	                        //--------------
	                        .Cache_Bank0_DataOut  (cache_intf.Bank0_Data ),
	                        .Cache_Bank1_DataOut  (cache_intf.Bank1_Data ),
	                        .Cache_Bank2_DataOut  (cache_intf.Bank2_Data ),
	                        .Cache_Bank3_DataOut  (cache_intf.Bank3_Data ),
	                        .Cache_Bank4_DataOut  (cache_intf.Bank4_Data ),
	                        .Cache_Bank5_DataOut  (cache_intf.Bank5_Data ),
	                        .Cache_Bank6_DataOut  (cache_intf.Bank6_Data ),
	                        .Cache_Bank7_DataOut  (cache_intf.Bank7_Data ),
	                        .Cache_Bank8_DataOut  (cache_intf.Bank8_Data ),
	                        .Cache_Bank9_DataOut  (cache_intf.Bank9_Data ),
	                        .Cache_Bank10_DataOut (cache_intf.Bank10_Data),
	                        .Cache_Bank11_DataOut (cache_intf.Bank11_Data),
	                        .Cache_Bank12_DataOut (cache_intf.Bank12_Data),
	                        .Cache_Bank13_DataOut (cache_intf.Bank13_Data),
	                        .Cache_Bank14_DataOut (cache_intf.Bank14_Data),
	                        .Cache_Bank15_DataOut (cache_intf.Bank15_Data)
                      ) ;


initial begin
	CLK = 1'b0 ;
	mbx = new();
	@(core_intf.core_intf_pos);
	-> event_intf.env_start ;
	fork
		Interconnect_Env::start(core_intf, cache_intf, event_intf, diff_counter, mbx) ;
		Root_Test_Admin::start(core_intf, cache_intf, event_intf, diff_counter, mbx);
	join
end

	always@(generator::gen_counter, Interconnect_Env::tp32Interconnect.u_core_driver.drv_counter) begin
	     diff_counter  =  (generator::gen_counter - driver::drv_counter);
		 $display("TESTBENCH: DIFF_COUNTER = %d", diff_counter, $time);
	end
endmodule
