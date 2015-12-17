
class Interconnect_Env ;

   static Interconnect_Env tp32Interconnect ;
   static int obj_cnt ;
   driver u_core_driver ;
   virtual Core_Interface core_intf ;
   virtual Cache_Interface cache_intf ;
   virtual Event_Interface event_intf ;

   mailbox #(CoreDriveStimulus) mbx ;

   protected function new(
      virtual Core_Interface core_intf ,
	  virtual Cache_Interface cache_intf ,
	  virtual Event_Interface event_intf ,
	  mailbox #(CoreDriveStimulus) mbx 
	);
	     this.core_intf = core_intf ;
		 this.cache_intf = cache_intf ;
		 this.event_intf = event_intf ;
		 this.mbx = mbx ;
		 u_core_driver = new(core_intf, cache_intf, event_intf, mbx);
   endfunction

   static function void print();
      $display("OBJECT COUNT = %d", obj_cnt, $time) ;
   endfunction

   static function void end_env();
      tp32Interconnect = null ;
   endfunction

   static task start (
           virtual Core_Interface core_intf    ,
		   virtual Cache_Interface cache_intf  ,
		   virtual Event_Interface event_intf  ,
		   ref int  diff_counter               ,
		   mailbox#(CoreDriveStimulus) mbx     
	);
		if(tp32Interconnect == null) begin
			tp32Interconnect = new(core_intf, cache_intf, event_intf, mbx);
			obj_cnt++ ;
		end
		else 
			$display("TP32INTERCONNECT Environment already alive !!");

		if(tp32Interconnect !== null && obj_cnt === 1)
			tp32Interconnect.u_core_driver.start(diff_counter);
		else 
			$display("ERROR: Root_Test_Admin: Redundant Trigger Call. Investigate !!! -> ", $time) ;

	endtask : start

endclass
