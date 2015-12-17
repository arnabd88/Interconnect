

class interconnect_single_request extends generic_test;


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

	  for (int i=0; i<=31; i++) begin
	      temp_req = 32'h00000000 ;
		  temp_req[i] = 1 ;
		  temp_req_mask = 32'hFFFFFFFF ;
		  gseq.generate_write_packet(~temp_req_mask, temp_req);
	  end

	  wait_cycles(20);


	  -> event_intf.test_end ;

     endtask

endclass
