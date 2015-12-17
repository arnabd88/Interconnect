
class generator ;

  CoreDriveStimulus  sti ;
  mailbox#(CoreDriveStimulus) mbx ;
  static int gen_counter ;
  virtual Core_Interface core_intf ;

  function new (
       mailbox#(CoreDriveStimulus) mbx ,
	   virtual Core_Interface core_intf
	);

 	this.mbx  =  mbx  ;
	this.core_intf = core_intf ;
  endfunction

  task reset_por();
    @(core_intf.core_intf_pos);
	  core_intf.RSTn <= 1'b0 ;
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
	@(core_intf.core_intf_pos);
	  core_intf.RSTn <= 1'b1 ;
  endtask

  function void put_packet();
     sti = new();
	 mbx.put(sti);
	 gen_counter = gen_counter + 1 ;
	 $display("GEN_COUNTER = %d", gen_counter, $time);
  endfunction : put_packet

  function void generate_write_packet(
         bit[31:0] req_mask = 32'hFFFFFFFF ,
		 bit[31:0] req_stim = 32'h00000000 ,
		 bit[31:0] addr0_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr0_stim  = 32'h00000000 ,
		 bit[31:0] addr1_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr1_stim  = 32'h00000000 ,
		 bit[31:0] addr2_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr2_stim  = 32'h00000000 ,
		 bit[31:0] addr3_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr3_stim  = 32'h00000000 ,
		 bit[31:0] addr4_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr4_stim  = 32'h00000000 ,
		 bit[31:0] addr5_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr5_stim  = 32'h00000000 ,
		 bit[31:0] addr6_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr6_stim  = 32'h00000000 ,
		 bit[31:0] addr7_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr7_stim  = 32'h00000000 ,
		 bit[31:0] addr8_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr8_stim  = 32'h00000000 ,
		 bit[31:0] addr9_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr9_stim  = 32'h00000000 ,
		 bit[31:0] addr10_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr10_stim  = 32'h00000000 ,
		 bit[31:0] addr11_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr11_stim  = 32'h00000000 ,
		 bit[31:0] addr12_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr12_stim  = 32'h00000000 ,
		 bit[31:0] addr13_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr13_stim  = 32'h00000000 ,
		 bit[31:0] addr14_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr14_stim  = 32'h00000000 ,
		 bit[31:0] addr15_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr15_stim  = 32'h00000000 ,
		 bit[31:0] addr16_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr16_stim  = 32'h00000000 ,
		 bit[31:0] addr17_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr17_stim  = 32'h00000000 ,
		 bit[31:0] addr18_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr18_stim  = 32'h00000000 ,
		 bit[31:0] addr19_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr19_stim  = 32'h00000000 ,
		 bit[31:0] addr20_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr20_stim  = 32'h00000000 ,
		 bit[31:0] addr21_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr21_stim  = 32'h00000000 ,
		 bit[31:0] addr22_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr22_stim  = 32'h00000000 ,
		 bit[31:0] addr23_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr23_stim  = 32'h00000000 ,
		 bit[31:0] addr24_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr24_stim  = 32'h00000000 ,
		 bit[31:0] addr25_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr25_stim  = 32'h00000000 ,
		 bit[31:0] addr26_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr26_stim  = 32'h00000000 ,
		 bit[31:0] addr27_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr27_stim  = 32'h00000000 ,
		 bit[31:0] addr28_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr28_stim  = 32'h00000000 ,
		 bit[31:0] addr29_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr29_stim  = 32'h00000000 ,
		 bit[31:0] addr30_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr30_stim  = 32'h00000000 ,
		 bit[31:0] addr31_mask  = 32'hFFFFFFFF ,
		 bit[31:0] addr31_stim  = 32'h00000000 );
	
	put_packet();
	sti.randomize() with
		{
			RSTn == 1'b1 ;
		} ;
	sti.CoreReq = ((sti.CoreReq | ~req_mask)&(req_stim | req_mask));
	sti.Addr0   = ((sti.Addr0  | ~addr0_mask) &(addr0_stim  | addr0_mask)) ;
	sti.Addr1   = ((sti.Addr1  | ~addr1_mask) &(addr1_stim  | addr1_mask)) ;
	sti.Addr2   = ((sti.Addr2  | ~addr2_mask) &(addr2_stim  | addr2_mask)) ;
	sti.Addr3   = ((sti.Addr3  | ~addr3_mask) &(addr3_stim  | addr3_mask)) ;
	sti.Addr4   = ((sti.Addr4  | ~addr4_mask) &(addr4_stim  | addr4_mask)) ;
	sti.Addr5   = ((sti.Addr5  | ~addr5_mask) &(addr5_stim  | addr5_mask)) ;
	sti.Addr6   = ((sti.Addr6  | ~addr6_mask) &(addr6_stim  | addr6_mask)) ;
	sti.Addr7   = ((sti.Addr7  | ~addr7_mask) &(addr7_stim  | addr7_mask)) ;
	sti.Addr8   = ((sti.Addr8  | ~addr8_mask) &(addr8_stim  | addr8_mask)) ;
	sti.Addr9   = ((sti.Addr9  | ~addr9_mask) &(addr9_stim  | addr9_mask)) ;
	sti.Addr10  = ((sti.Addr10 | ~addr10_mask)&(addr10_stim | addr10_mask)) ;
	sti.Addr11  = ((sti.Addr11 | ~addr11_mask)&(addr11_stim | addr11_mask)) ;
	sti.Addr12  = ((sti.Addr12 | ~addr12_mask)&(addr12_stim | addr12_mask)) ;
	sti.Addr13  = ((sti.Addr13 | ~addr13_mask)&(addr13_stim | addr13_mask)) ;
	sti.Addr14  = ((sti.Addr14 | ~addr14_mask)&(addr14_stim | addr14_mask)) ;
	sti.Addr15  = ((sti.Addr15 | ~addr15_mask)&(addr15_stim | addr15_mask)) ;
	sti.Addr16  = ((sti.Addr16 | ~addr16_mask)&(addr16_stim | addr16_mask)) ;
	sti.Addr17  = ((sti.Addr17 | ~addr17_mask)&(addr17_stim | addr17_mask)) ;
	sti.Addr18  = ((sti.Addr18 | ~addr18_mask)&(addr18_stim | addr18_mask)) ;
	sti.Addr19  = ((sti.Addr19 | ~addr19_mask)&(addr19_stim | addr19_mask)) ;
	sti.Addr20  = ((sti.Addr20 | ~addr20_mask)&(addr20_stim | addr20_mask)) ;
	sti.Addr21  = ((sti.Addr21 | ~addr21_mask)&(addr21_stim | addr21_mask)) ;
	sti.Addr22  = ((sti.Addr22 | ~addr22_mask)&(addr22_stim | addr22_mask)) ;
	sti.Addr23  = ((sti.Addr23 | ~addr23_mask)&(addr23_stim | addr23_mask)) ;
	sti.Addr24  = ((sti.Addr24 | ~addr24_mask)&(addr24_stim | addr24_mask)) ;
	sti.Addr25  = ((sti.Addr25 | ~addr25_mask)&(addr25_stim | addr25_mask)) ;
	sti.Addr26  = ((sti.Addr26 | ~addr26_mask)&(addr26_stim | addr26_mask)) ;
	sti.Addr27  = ((sti.Addr27 | ~addr27_mask)&(addr27_stim | addr27_mask)) ;
	sti.Addr28  = ((sti.Addr28 | ~addr28_mask)&(addr28_stim | addr28_mask)) ;
	sti.Addr29  = ((sti.Addr29 | ~addr29_mask)&(addr29_stim | addr29_mask)) ;
	sti.Addr30  = ((sti.Addr30 | ~addr30_mask)&(addr30_stim | addr30_mask)) ;
	sti.Addr31  = ((sti.Addr31 | ~addr31_mask)&(addr31_stim | addr31_mask)) ;
endfunction

function void generate_reset_packet();
  put_packet();
  sti.randomize() with
  	{
		RSTn == 1'b0 ;
	};
endfunction
                                      

endclass
