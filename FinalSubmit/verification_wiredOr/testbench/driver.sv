class driver ;

  CoreDriveStimulus sti ;

  virtual Core_Interface core_intf ;
  virtual Cache_Interface cache_intf ;
  virtual Event_Interface event_intf ;

  mailbox #(CoreDriveStimulus) mbx ;
  static int drv_counter ;

  function new (
    virtual Core_Interface core_intf ,
	virtual Cache_Interface cache_intf ,
	virtual Event_Interface event_intf ,
	mailbox #(CoreDriveStimulus) mbx 
	) ;
	this.core_intf  = core_intf ;
	this.cache_intf = cache_intf ;
	this.event_intf = event_intf ;
	this.mbx = mbx ;
  endfunction

  task start( ref int diff_counter );
    do
		begin
		  @(core_intf.core_intf_pos);
		  sequencer(diff_counter) ;
		end
	while(event_intf.signal_test_finish !== 1);
	#100 $finish ;
  endtask

  task reset();
  @(core_intf.core_intf_pos) ;
    core_intf.RSTn <= 0 ;
	core_intf.Core0_Req      <= 0 ;
	core_intf.Core1_Req      <= 0 ;
	core_intf.Core2_Req      <= 0 ;
	core_intf.Core3_Req      <= 0 ;
	core_intf.Core4_Req      <= 0 ;
	core_intf.Core5_Req      <= 0 ;
	core_intf.Core6_Req      <= 0 ;
	core_intf.Core7_Req      <= 0 ;
	core_intf.Core8_Req      <= 0 ;
	core_intf.Core9_Req      <= 0 ;
	core_intf.Core10_Req      <= 0 ;
	core_intf.Core11_Req      <= 0 ;
	core_intf.Core12_Req      <= 0 ;
	core_intf.Core13_Req      <= 0 ;
	core_intf.Core14_Req      <= 0 ;
	core_intf.Core15_Req      <= 0 ;
	core_intf.Core16_Req      <= 0 ;
	core_intf.Core17_Req      <= 0 ;
	core_intf.Core18_Req      <= 0 ;
	core_intf.Core19_Req      <= 0 ;
	core_intf.Core20_Req      <= 0 ;
	core_intf.Core21_Req      <= 0 ;
	core_intf.Core22_Req      <= 0 ;
	core_intf.Core23_Req      <= 0 ;
	core_intf.Core24_Req      <= 0 ;
	core_intf.Core25_Req      <= 0 ;
	core_intf.Core26_Req      <= 0 ;
	core_intf.Core27_Req      <= 0 ;
	core_intf.Core28_Req      <= 0 ;
	core_intf.Core29_Req      <= 0 ;
	core_intf.Core30_Req      <= 0 ;
	core_intf.Core31_Req      <= 0 ;
  endtask

  task sequencer (ref int diff_counter);
     if(diff_counter != 0) begin
	   for(int i=0; i<diff_counter; i++) begin
	      $display("\n\n\n\n~~~~~~~~~~~ DIFF_COUNTER = %d ~~~~~~~~~~~~\n", diff_counter);
		  i = 0 ;
		  @(core_intf.core_intf_pos);
		  mbx.get(sti);
		  if(sti.RSTn === 1'b0)
		       reset();
		  else begin
		     fork
			     core0_req(sti.CoreReq[0] ,sti.Addr0[31:0]);
			     core1_req(sti.CoreReq[1] ,sti.Addr1[31:0]);
			     core2_req(sti.CoreReq[2] ,sti.Addr2[31:0]);
			     core3_req(sti.CoreReq[3] ,sti.Addr3[31:0]);
			     core4_req(sti.CoreReq[4] ,sti.Addr4[31:0]);
			     core5_req(sti.CoreReq[5] ,sti.Addr5[31:0]);
			     core6_req(sti.CoreReq[6] ,sti.Addr6[31:0]);
			     core7_req(sti.CoreReq[7] ,sti.Addr7[31:0]);
			     core8_req(sti.CoreReq[8] ,sti.Addr8[31:0]);
			     core9_req(sti.CoreReq[9] ,sti.Addr9[31:0]);
			    core10_req(sti.CoreReq[10],sti.Addr10[31:0]);
			    core11_req(sti.CoreReq[11],sti.Addr11[31:0]);
			    core12_req(sti.CoreReq[12],sti.Addr12[31:0]);
			    core13_req(sti.CoreReq[13],sti.Addr13[31:0]);
			    core14_req(sti.CoreReq[14],sti.Addr14[31:0]);
			    core15_req(sti.CoreReq[15],sti.Addr15[31:0]);
			    core16_req(sti.CoreReq[16],sti.Addr16[31:0]);
			    core17_req(sti.CoreReq[17],sti.Addr17[31:0]);
			    core18_req(sti.CoreReq[18],sti.Addr18[31:0]);
			    core19_req(sti.CoreReq[19],sti.Addr19[31:0]);
			    core20_req(sti.CoreReq[20],sti.Addr20[31:0]);
			    core21_req(sti.CoreReq[21],sti.Addr21[31:0]);
			    core22_req(sti.CoreReq[22],sti.Addr22[31:0]);
			    core23_req(sti.CoreReq[23],sti.Addr23[31:0]);
			    core24_req(sti.CoreReq[24],sti.Addr24[31:0]);
			    core25_req(sti.CoreReq[25],sti.Addr25[31:0]);
			    core26_req(sti.CoreReq[26],sti.Addr26[31:0]);
			    core27_req(sti.CoreReq[27],sti.Addr27[31:0]);
			    core28_req(sti.CoreReq[28],sti.Addr28[31:0]);
			    core29_req(sti.CoreReq[29],sti.Addr29[31:0]);
			    core30_req(sti.CoreReq[30],sti.Addr30[31:0]);
			    core31_req(sti.CoreReq[31],sti.Addr31[31:0]);
			 join_none
		  end
		  drv_counter = drv_counter + 1 ;
	   end
	 end
  endtask : sequencer

  task core0_req( bit req, bit[31:0] Addr );
       if (core_intf.Core0_Req == 1) 
	       $display("MSG: Request from Core0 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_0 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core0_Req <= 1 ;
		   core_intf.Core0_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core0_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core0_Req <= 0 ;
	   end
  endtask
  task core1_req( bit req, bit[31:0] Addr );
       if (core_intf.Core1_Req == 1) 
	       $display("MSG: Request from Core1 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_0 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core1_Req <= 1 ;
		   core_intf.Core1_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core1_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core1_Req <= 0 ;
	   end
  endtask

  task core2_req( bit req, bit[31:0] Addr );
       if (core_intf.Core2_Req == 1) 
	       $display("MSG: Request from Core2 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_2 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core2_Req <= 1 ;
		   core_intf.Core2_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core2_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core2_Req <= 0 ;
	   end
  endtask

  task core3_req( bit req, bit[31:0] Addr );
       if (core_intf.Core3_Req == 1) 
	       $display("MSG: Request from Core3 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_3 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core3_Req <= 1 ;
		   core_intf.Core3_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core3_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core3_Req <= 0 ;
	   end
  endtask

  task core4_req( bit req, bit[31:0] Addr );
       if (core_intf.Core4_Req == 1) 
	       $display("MSG: Request from Core4 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_4 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core4_Req <= 1 ;
		   core_intf.Core4_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core4_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core4_Req <= 0 ;
	   end
  endtask

  task core5_req( bit req, bit[31:0] Addr );
       if (core_intf.Core5_Req == 1) 
	       $display("MSG: Request from Core5 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_5 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core5_Req <= 1 ;
		   core_intf.Core5_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core5_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core5_Req <= 0 ;
	   end
  endtask

  task core6_req( bit req, bit[31:0] Addr );
       if (core_intf.Core6_Req == 1) 
	       $display("MSG: Request from Core6 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_6 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core6_Req <= 1 ;
		   core_intf.Core6_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core6_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core6_Req <= 0 ;
	   end
  endtask

  task core7_req( bit req, bit[31:0] Addr );
       if (core_intf.Core7_Req == 1) 
	       $display("MSG: Request from Core7 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_7 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core7_Req <= 1 ;
		   core_intf.Core7_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core7_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core7_Req <= 0 ;
	   end
  endtask

  task core8_req( bit req, bit[31:0] Addr );
       if (core_intf.Core8_Req == 1) 
	       $display("MSG: Request from Core8 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_8 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core8_Req <= 1 ;
		   core_intf.Core8_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core8_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core8_Req <= 0 ;
	   end
  endtask

  task core9_req( bit req, bit[31:0] Addr );
       if (core_intf.Core9_Req == 1) 
	       $display("MSG: Request from Core9 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_9 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core9_Req <= 1 ;
		   core_intf.Core9_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core9_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core9_Req <= 0 ;
	   end
  endtask

  task core10_req( bit req, bit[31:0] Addr );
       if (core_intf.Core10_Req == 1) 
	       $display("MSG: Request from Core10 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_10 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core10_Req <= 1 ;
		   core_intf.Core10_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core10_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core10_Req <= 0 ;
	   end
  endtask

  task core11_req( bit req, bit[31:0] Addr );
       if (core_intf.Core11_Req == 1) 
	       $display("MSG: Request from Core11 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_11 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core11_Req <= 1 ;
		   core_intf.Core11_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core11_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core11_Req <= 0 ;
	   end
  endtask

  task core12_req( bit req, bit[31:0] Addr );
       if (core_intf.Core12_Req == 1) 
	       $display("MSG: Request from Core12 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_12 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core12_Req <= 1 ;
		   core_intf.Core12_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core12_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core12_Req <= 0 ;
	   end
  endtask

  task core13_req( bit req, bit[31:0] Addr );
       if (core_intf.Core13_Req == 1) 
	       $display("MSG: Request from Core13 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_13 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core13_Req <= 1 ;
		   core_intf.Core13_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core13_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core13_Req <= 0 ;
	   end
  endtask

  task core14_req( bit req, bit[31:0] Addr );
       if (core_intf.Core14_Req == 1) 
	       $display("MSG: Request from Core14 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_14 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core14_Req <= 1 ;
		   core_intf.Core14_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core14_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core14_Req <= 0 ;
	   end
  endtask

  task core15_req( bit req, bit[31:0] Addr );
       if (core_intf.Core15_Req == 1) 
	       $display("MSG: Request from Core15 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_15 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core15_Req <= 1 ;
		   core_intf.Core15_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core15_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core15_Req <= 0 ;
	   end
  endtask

  task core16_req( bit req, bit[31:0] Addr );
       if (core_intf.Core16_Req == 1) 
	       $display("MSG: Request from Core16 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_16 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core16_Req <= 1 ;
		   core_intf.Core16_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core16_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core16_Req <= 0 ;
	   end
  endtask

  task core17_req( bit req, bit[31:0] Addr );
       if (core_intf.Core17_Req == 1) 
	       $display("MSG: Request from Core17 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_17 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core17_Req <= 1 ;
		   core_intf.Core17_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core17_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core17_Req <= 0 ;
	   end
  endtask

  task core18_req( bit req, bit[31:0] Addr );
       if (core_intf.Core18_Req == 1) 
	       $display("MSG: Request from Core18 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_18 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core18_Req <= 1 ;
		   core_intf.Core18_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core18_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core18_Req <= 0 ;
	   end
  endtask

  task core19_req( bit req, bit[31:0] Addr );
       if (core_intf.Core0_Req == 1) 
	       $display("MSG: Request from Core0 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_19 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core0_Req <= 1 ;
		   core_intf.Core0_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core0_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core0_Req <= 0 ;
	   end
  endtask

  task core20_req( bit req, bit[31:0] Addr );
       if (core_intf.Core20_Req == 1) 
	       $display("MSG: Request from Core20 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_20 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core20_Req <= 1 ;
		   core_intf.Core20_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core20_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core20_Req <= 0 ;
	   end
  endtask

  task core21_req( bit req, bit[31:0] Addr );
       if (core_intf.Core21_Req == 1) 
	       $display("MSG: Request from Core21 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_21 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core21_Req <= 1 ;
		   core_intf.Core21_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core21_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core21_Req <= 0 ;
	   end
  endtask

  task core22_req( bit req, bit[31:0] Addr );
       if (core_intf.Core22_Req == 1) 
	       $display("MSG: Request from Core22 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_22 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core22_Req <= 1 ;
		   core_intf.Core22_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core22_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core22_Req <= 0 ;
	   end
  endtask

  task core23_req( bit req, bit[31:0] Addr );
       if (core_intf.Core23_Req == 1) 
	       $display("MSG: Request from Core23 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_23 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core23_Req <= 1 ;
		   core_intf.Core23_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core23_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core23_Req <= 0 ;
	   end
  endtask

  task core24_req( bit req, bit[31:0] Addr );
       if (core_intf.Core24_Req == 1) 
	       $display("MSG: Request from Core24 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_24 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core24_Req <= 1 ;
		   core_intf.Core24_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core24_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core24_Req <= 0 ;
	   end
  endtask

  task core25_req( bit req, bit[31:0] Addr );
       if (core_intf.Core25_Req == 1) 
	       $display("MSG: Request from Core25 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_25 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core25_Req <= 1 ;
		   core_intf.Core25_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core25_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core25_Req <= 0 ;
	   end
  endtask

  task core26_req( bit req, bit[31:0] Addr );
       if (core_intf.Core26_Req == 1) 
	       $display("MSG: Request from Core26 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_26 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core26_Req <= 1 ;
		   core_intf.Core26_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core26_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core26_Req <= 0 ;
	   end
  endtask

  task core27_req( bit req, bit[31:0] Addr );
       if (core_intf.Core27_Req == 1) 
	       $display("MSG: Request from Core27 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_27 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core27_Req <= 1 ;
		   core_intf.Core27_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core27_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core27_Req <= 0 ;
	   end
  endtask

  task core28_req( bit req, bit[31:0] Addr );
       if (core_intf.Core28_Req == 1) 
	       $display("MSG: Request from Core28 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_28 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core28_Req <= 1 ;
		   core_intf.Core28_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core28_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core28_Req <= 0 ;
	   end
  endtask

  task core29_req( bit req, bit[31:0] Addr );
       if (core_intf.Core29_Req == 1) 
	       $display("MSG: Request from Core29 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_29 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core29_Req <= 1 ;
		   core_intf.Core29_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core29_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core29_Req <= 0 ;
	   end
  endtask

  task core30_req( bit req, bit[31:0] Addr );
       if (core_intf.Core30_Req == 1) 
	       $display("MSG: Request from Core30 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_30 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core30_Req <= 1 ;
		   core_intf.Core30_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core30_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core30_Req <= 0 ;
	   end
  endtask

  task core31_req( bit req, bit[31:0] Addr );
       if (core_intf.Core31_Req == 1) 
	       $display("MSG: Request from Core31 already pending : time => ", $time);
	   else if(req === 1) begin
	       $display("MSG: Sending Access Request from CORE_31 : time => ", $time);
		   @(core_intf.core_intf_pos)

		   core_intf.Core31_Req <= 1 ;
		   core_intf.Core31_Addr <= Addr ;
           
		   //---- Wait for return A
		   wait(core_intf.Core31_Ack==1 || core_intf.RSTn==0) ;
		   core_intf.Core31_Req <= 0 ;
	   end
  endtask



endclass
