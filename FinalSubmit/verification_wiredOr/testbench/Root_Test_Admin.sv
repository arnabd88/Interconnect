class Root_Test_Admin ;

  static Root_Test_Admin    root_test ;
  static int                test_cnt ;

  virtual Core_Interface    core_intf ;
  virtual Cache_Interface   cache_intf ;
  virtual Event_Interface   event_intf ;

  mailbox#(CoreDriveStimulus) mbx ;

  interconnect_test        test ;
  interconnect_test        reset_test ;
  static  int              queue[$] ;

  protected function new (
      virtual  Core_Interface  core_intf   ,
	  virtual  Cache_Interface cache_intf  ,
	  virtual  Event_Interface event_intf  ,
	  mailbox#(CoreDriveStimulus) mbx      
  );
      this.core_intf = core_intf ;
	  this.cache_intf = cache_intf ;
	  this.event_intf = event_intf ;
	  this.mbx = mbx ;
  endfunction

  static task start (
       virtual Core_Interface  core_intf ,
	   virtual Cache_Interface cache_intf ,
	   virtual Event_Interface event_intf ,
	   ref int diff_counter ,
	   mailbox#(CoreDriveStimulus) mbx
  );

     if(root_test == null) begin
	    root_test = new(core_intf, cache_intf, event_intf, mbx);
		test_cnt++ ;
		$display("MSG: ROOT_TEST_ADMIN OBJECT ALIVE") ;
	 end
	 else
	   $display("MSG:REDUNDANT TRY to CREATE ANOTHER ROOT TEST ADMIN.\n\tROOT_TEST_ADMIN ALREADY ALIVE");

	 if(root_test !== null  && test_cnt === 1)
	 	root_test.trigger(diff_counter);
	 else
	 	$display("MSG:ROOT_TEST_ADMIN: REDUNDANT TRIGGER CALL");

		root_test.test.test_finish();
  endtask : start

  task trigger (ref int diff_counter);
     int random_object_id ;

	 reset_test = new(core_intf, cache_intf, event_intf, mbx, 0);
	 reset_test.start(diff_counter);
	//   random_object_id  =  (unique_randomize(1, MAX_TEST_COUNT,1)%(TEST_COUNT+1));

	 repeat(MAX_TEST_COUNT) begin
	   @(core_intf.core_intf_pos);
	   @(core_intf.core_intf_pos);
	   if(diff_counter != 0)  wait(diff_counter == 0);
	  // random_object_id  =  (unique_randomize(1, MAX_TEST_COUNT,0)%(TEST_COUNT+1));
	   random_object_id  =  (unique_randomize(1, MAX_TEST_COUNT));
	   $display("RANDOM_OBJECT_ID : = %d",random_object_id, $time);
	   test  =  new(core_intf, cache_intf, event_intf, mbx,  random_object_id);
	   fork
	     root_test.test.start(diff_counter);
	   join
	 end
	 root_test.test.clear_queue();

	 -> event_intf.Simulation_End ;
    
  endtask

    function automatic int unique_randomize(int start_range, int stop_range);
	   int rand_data ;
	   bit flag ;
	   rand_data = $urandom_range(start_range, stop_range)%(TEST_COUNT+1);
	   $display("RAND_DATA = %d",rand_data);
	   if(queue.size()==TEST_COUNT) begin
	      for(int j=0; j < queue.size(); j++) queue.pop_front();
	   end
	   if(queue.size()==0) begin queue.push_back(rand_data) ; return rand_data; end
	   else begin
	       for(int i=0; i< queue.size(); i++) begin
		       if(queue[i]==rand_data) flag = 1 ;
		   end
		   if(flag==0) begin
		    queue.push_back(rand_data);
		   	return rand_data ;
		   end
		   else return unique_randomize(start_range, stop_range) ;
	   end
	endfunction

	// function int unique_randomize (int start_range, int stop_range, int set_size);

	// 	//static int queue[]	;
	// 	int i = 0			;
	// 	int flag	= 0		;
	// 	int data			;
	// 	int size			;
	// 	int rand_data		;
	// 	static int check_size		;

	// 	if (start_range < stop_range) begin
	// 		int temp;
	// 		temp = start_range;
	// 		start_range = stop_range;
	// 		stop_range = temp;
	// 	end
	// 	size = start_range - stop_range;
	// 	if(set_size) begin
	// 	queue = new[size];
	// 	//static int queue[]	;
	// 	end
	// 	else begin
	// 	
	// 		rand_data = $urandom_range(start_range,stop_range);
	// 		for (int j = 0; j < i; j++) begin
	// 			if (rand_data == queue[j]) begin
	// 					flag = 1;
	// 			end
	// 		end
	// 		if (flag == 0) begin
	// 			queue[i] = rand_data;
	// 			data = rand_data;
	// 			i++;
	// 		end
	// 	end
	// 	return (data);

	// endfunction

endclass
