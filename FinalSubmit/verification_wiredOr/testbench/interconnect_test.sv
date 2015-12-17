class interconnect_test ;

  virtual Core_Interface  core_intf ;
  virtual Cache_Interface cache_intf ;
  virtual Event_Interface event_intf ;
  mailbox#(CoreDriveStimulus) mbx ;
  static int  obj_queue[$];
  bit[2:0] obj_cnt ;

  int random_object_id ;

  //----------  TEST LIST  ------------
  //---(Keep ading Tests here)---------
      generic_test                     test_generic ;
  `ifdef  INTERCONNECT_SINGLE_REQUEST_TEST
  	  interconnect_single_request      test_interconnect_single_request ;
  `endif

  `ifdef INTERCONNECT_SINGLE_BANK_MULTIPLE_REQUEST_TEST
      interconnect_single_bank_multiple_request   test_interconnect_single_bank_multiple_request ;
   `endif
  //-----------------------------------
  

  function new (
     virtual Core_Interface core_intf ,
	 virtual Cache_Interface cache_intf ,
	 virtual Event_Interface event_intf ,
	 mailbox#(CoreDriveStimulus) mbx ,
	 int random_object_id
  );
	this.core_intf = core_intf ;
	this.cache_intf = cache_intf ;
	this.event_intf = event_intf ;
	this.mbx  =  mbx ;
	this.random_object_id = random_object_id ;
	obj_cnt  =  $random() ;
	obj_queue.push_back(random_object_id);
	if(obj_queue.size() <= MAX_TEST_COUNT)
		create_test_object(random_object_id);
	else 
	   $display("MSG: TEST COUNT EXCEEDED MAX TEST COUNT limt of %d",MAX_TEST_COUNT);
  endfunction

  static task clear_queue();
     do
	    begin
		   obj_queue.pop_front();
		end
	 while( obj_queue.size()!= 0);
  endtask 

  function create_test_object ( int test_index );

    if(test_index == 0) 
			test_generic   =  new(core_intf, cache_intf, event_intf, mbx);
	else if(test_index == 1) begin
	  `ifdef INTERCONNECT_SINGLE_REQUEST_TEST
	  		test_interconnect_single_request = new(core_intf, cache_intf, event_intf, mbx);
	  `endif
	end
	else if(test_index == 2) begin
	   `ifdef INTERCONNECT_SINGLE_BANK_MULTIPLE_REQUEST_TEST
	   		test_interconnect_single_bank_multiple_request = new(core_intf, cache_intf, event_intf, mbx);
	   `endif
	end
	else 
			test_generic   =  new(core_intf, cache_intf, event_intf, mbx);
  endfunction


  task  start(ref int diff_counter);
    if(obj_queue.size() <= MAX_TEST_COUNT) begin
		event_intf.test_num  =  random_object_id ;
		if(random_object_id == 0) begin
			test_generic.start(diff_counter);
		end
		else if(random_object_id == 1) begin
		  `ifdef INTERCONNECT_SINGLE_REQUEST_TEST
		   $display("INTERCONNECT_SINGLE_REQUEST_TEST -> Time => ", $time);
		   	test_interconnect_single_request.start(diff_counter);
		  `endif
		end
		else if(random_object_id == 2) begin
		  `ifdef INTERCONNECT_SINGLE_BANK_MULTIPLE_REQUEST_TEST
		   $display("INTERCONNECT_SINGLE_BANK_MULTIPLE_REQUEST_TEST -> Time => ", $time) ;
		   test_interconnect_single_bank_multiple_request.start(diff_counter);
		  `endif
		end
		else begin
		  @(core_intf.core_intf_pos) ;
		  -> event_intf.test_end ;
		end
	end
  endtask

  task  test_finish();
  	-> event_intf.finish_test ;
  endtask

endclass

