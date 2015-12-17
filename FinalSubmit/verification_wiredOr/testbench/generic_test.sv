class generic_test ;

	generator 	gseq ;
	CoreDriveStimulus  sti ;
	mailbox#(CoreDriveStimulus) mbx ;

	virtual Core_Interface core_intf ;
	virtual Cache_Interface cache_intf ;
	virtual Event_Interface event_intf ;

	static int   generic_id ;
	int    test_id ;
	bit[31:0] temp_req ;
	bit[31:0] temp_req_mask ;
	bit[31:0] temp_addr0 ;
	bit[31:0] temp_addr1 ;
	bit[31:0] temp_addr2 ;
	bit[31:0] temp_addr3 ;
	bit[31:0] temp_addr4 ;
	bit[31:0] temp_addr5 ;
	bit[31:0] temp_addr6 ;
	bit[31:0] temp_addr7 ;
	bit[31:0] temp_addr8 ;
	bit[31:0] temp_addr9 ;
	bit[31:0] temp_addr10 ;
	bit[31:0] temp_addr11 ;
	bit[31:0] temp_addr12 ;
	bit[31:0] temp_addr13 ;
	bit[31:0] temp_addr14 ;
	bit[31:0] temp_addr15 ;
	bit[31:0] temp_addr16 ;
	bit[31:0] temp_addr17 ;
	bit[31:0] temp_addr18 ;
	bit[31:0] temp_addr19 ;
	bit[31:0] temp_addr20 ;
	bit[31:0] temp_addr21 ;
	bit[31:0] temp_addr22 ;
	bit[31:0] temp_addr23 ;
	bit[31:0] temp_addr24 ;
	bit[31:0] temp_addr25 ;
	bit[31:0] temp_addr26 ;
	bit[31:0] temp_addr27 ;
	bit[31:0] temp_addr28 ;
	bit[31:0] temp_addr29 ;
	bit[31:0] temp_addr30 ;
	bit[31:0] temp_addr31 ;
	bit[31:0] temp_mask0 ;
	bit[31:0] temp_mask1 ;
	bit[31:0] temp_mask2 ;
	bit[31:0] temp_mask3 ;
	bit[31:0] temp_mask4 ;
	bit[31:0] temp_mask5 ;
	bit[31:0] temp_mask6 ;
	bit[31:0] temp_mask7 ;
	bit[31:0] temp_mask8 ;
	bit[31:0] temp_mask9 ;
	bit[31:0] temp_mask10 ;
	bit[31:0] temp_mask11 ;
	bit[31:0] temp_mask12 ;
	bit[31:0] temp_mask13 ;
	bit[31:0] temp_mask14 ;
	bit[31:0] temp_mask15 ;
	bit[31:0] temp_mask16 ;
	bit[31:0] temp_mask17 ;
	bit[31:0] temp_mask18 ;
	bit[31:0] temp_mask19 ;
	bit[31:0] temp_mask20 ;
	bit[31:0] temp_mask21 ;
	bit[31:0] temp_mask22 ;
	bit[31:0] temp_mask23 ;
	bit[31:0] temp_mask24 ;
	bit[31:0] temp_mask25 ;
	bit[31:0] temp_mask26 ;
	bit[31:0] temp_mask27 ;
	bit[31:0] temp_mask28 ;
	bit[31:0] temp_mask29 ;
	bit[31:0] temp_mask30 ;
	bit[31:0] temp_mask31 ;

	
	function new (
		virtual Core_Interface core_intf ,
		virtual Cache_Interface cache_intf ,
		virtual Event_Interface event_intf ,
		mailbox#(CoreDriveStimulus) mbx 
	);
		
		this.core_intf = core_intf ;
		this.cache_intf = cache_intf ;
		this.event_intf = event_intf ;
		this.mbx = mbx ;
		gseq = new(mbx, core_intf) ;
		generic_id = generic_id++ ;

	endfunction

	function temp_buf_reset();
	    temp_req   = 32'h00000000 ;
	    temp_req_mask = 32'h00000000 ;
	    temp_addr0    = 32'h00000000 ;  
	    temp_addr1    = 32'h00000000 ; 
        temp_addr2    = 32'h00000000 ;
        temp_addr3    = 32'h00000000 ;
        temp_addr4    = 32'h00000000 ;
        temp_addr5    = 32'h00000000 ;
        temp_addr6    = 32'h00000000 ;
        temp_addr7    = 32'h00000000 ;
        temp_addr8    = 32'h00000000 ;
        temp_addr9    = 32'h00000000 ;
        temp_addr10   = 32'h00000000  ;
        temp_addr11   = 32'h00000000  ;
        temp_addr12   = 32'h00000000  ;
        temp_addr13   = 32'h00000000  ;
        temp_addr14   = 32'h00000000  ;
        temp_addr15   = 32'h00000000  ;
        temp_addr16   = 32'h00000000  ;
        temp_addr17   = 32'h00000000  ;
        temp_addr18   = 32'h00000000  ;
        temp_addr19   = 32'h00000000  ;
        temp_addr20   = 32'h00000000  ;
        temp_addr21   = 32'h00000000  ;
        temp_addr22   = 32'h00000000  ;
        temp_addr23   = 32'h00000000  ;
        temp_addr24   = 32'h00000000  ;
        temp_addr25   = 32'h00000000  ;
        temp_addr26   = 32'h00000000  ;
        temp_addr27   = 32'h00000000  ;
        temp_addr28   = 32'h00000000  ;
        temp_addr29   = 32'h00000000  ;
        temp_addr30   = 32'h00000000  ;
        temp_addr31   = 32'h00000000  ;
        temp_mask0    = 32'h00000000 ;
        temp_mask1    = 32'h00000000 ;
        temp_mask2    = 32'h00000000 ;
        temp_mask3    = 32'h00000000 ;
        temp_mask4    = 32'h00000000 ;
        temp_mask5    = 32'h00000000 ;
        temp_mask6    = 32'h00000000 ;
        temp_mask7    = 32'h00000000 ;
        temp_mask8    = 32'h00000000 ;
        temp_mask9    = 32'h00000000 ;
        temp_mask10   = 32'h00000000  ;
        temp_mask11   = 32'h00000000  ;
        temp_mask12   = 32'h00000000  ;
        temp_mask13   = 32'h00000000  ;
        temp_mask14   = 32'h00000000  ;
        temp_mask15   = 32'h00000000  ;
        temp_mask16   = 32'h00000000  ;
        temp_mask17   = 32'h00000000  ;
        temp_mask18   = 32'h00000000  ;
        temp_mask19   = 32'h00000000  ;
        temp_mask20   = 32'h00000000  ;
        temp_mask21   = 32'h00000000  ;
        temp_mask22   = 32'h00000000  ;
        temp_mask23   = 32'h00000000  ;
        temp_mask24   = 32'h00000000  ;
        temp_mask25   = 32'h00000000  ;
        temp_mask26   = 32'h00000000  ;
        temp_mask27   = 32'h00000000  ;
        temp_mask28   = 32'h00000000  ;
        temp_mask29   = 32'h00000000  ;
        temp_mask30   = 32'h00000000  ;
        temp_mask31   = 32'h00000000  ;
  endfunction

  virtual task start(ref int diff_counter);
     gseq.reset_por();
	 temp_buf_reset();
  endtask

  task wait_on(ref int diff_counter);
  
  		#(WAIT_DELAY);

		wait(diff_counter == 0);

  endtask

  task wait_cycles(int cycles);

    repeat(cycles) begin
		@(core_intf.core_intf_pos);
	end

  endtask


endclass
