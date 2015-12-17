
class interconnect_single_bank_multiple_request extends generic_test;

    int local_count ;

	function new (
		virtual Core_Interface core_intf ,
		virtual Cache_Interface cache_intf ,
		virtual Event_Interface event_intf ,
		mailbox#(CoreDriveStimulus) mbx
	);
		super.new(core_intf, cache_intf, event_intf, mbx);
		test_id = generic_id ;

	endfunction

	task  start(ref int diff_counter) ;

	  -> event_intf.start_test ;
	  gseq.reset_por();
	  @(core_intf.core_intf_pos);

	  temp_buf_reset();

	  //-------Select a random pair of requesting core and a common bank------
	  for (int i=0; i<16; i++) begin
	     local_count  = $urandom_range(1,20);
	     temp_req[local_count] = 1'b1 ;
	     temp_req[$urandom_range(local_count+1,31)] = 1'b1 ;
	     temp_req_mask = 32'hFFFFFFFF ;
	     //---- Both requests generated for the same bank ---------------------
	     gseq.generate_write_packet(~temp_req_mask, temp_req) ;
	     @(core_intf.core_intf_pos);
	     wait_on(diff_counter);
	     wait_cycles(200);
	     wait (~core_intf.Core0_Req  && ~core_intf.Core1_Req  &&
	           ~core_intf.Core2_Req  && ~core_intf.Core3_Req  &&
	           ~core_intf.Core4_Req  && ~core_intf.Core5_Req  &&
	           ~core_intf.Core6_Req  && ~core_intf.Core7_Req  &&
	           ~core_intf.Core8_Req  && ~core_intf.Core9_Req  &&
	           ~core_intf.Core10_Req && ~core_intf.Core11_Req &&
	           ~core_intf.Core12_Req && ~core_intf.Core13_Req &&
	           ~core_intf.Core14_Req && ~core_intf.Core15_Req &&
	           ~core_intf.Core16_Req && ~core_intf.Core17_Req &&
	           ~core_intf.Core18_Req && ~core_intf.Core19_Req &&
	           ~core_intf.Core20_Req && ~core_intf.Core21_Req &&
	           ~core_intf.Core22_Req && ~core_intf.Core23_Req &&
	           ~core_intf.Core24_Req && ~core_intf.Core25_Req &&
	           ~core_intf.Core26_Req && ~core_intf.Core27_Req &&
	           ~core_intf.Core28_Req && ~core_intf.Core29_Req &&
	           ~core_intf.Core30_Req && ~core_intf.Core31_Req);
	end


	  -> event_intf.test_end ;

     endtask

endclass


