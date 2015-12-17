interface Cache_Interface( input CLK );

  logic RSTn ;

  logic Bank0_Req ;
  logic Bank1_Req ;
  logic Bank2_Req ;
  logic Bank3_Req ;
  logic Bank4_Req ;
  logic Bank5_Req ;
  logic Bank6_Req ;
  logic Bank7_Req ;
  logic Bank8_Req ;
  logic Bank9_Req ;
  logic Bank10_Req ;
  logic Bank11_Req ;
  logic Bank12_Req ;
  logic Bank13_Req ;
  logic Bank14_Req ;
  logic Bank15_Req ;

  logic [31:0] Bank0_Addr  ;
  logic [31:0] Bank1_Addr  ;
  logic [31:0] Bank2_Addr  ;
  logic [31:0] Bank3_Addr  ;
  logic [31:0] Bank4_Addr  ;
  logic [31:0] Bank5_Addr  ;
  logic [31:0] Bank6_Addr  ;
  logic [31:0] Bank7_Addr  ;
  logic [31:0] Bank8_Addr  ;
  logic [31:0] Bank9_Addr  ;
  logic [31:0] Bank10_Addr ;
  logic [31:0] Bank11_Addr ;
  logic [31:0] Bank12_Addr ;
  logic [31:0] Bank13_Addr ;
  logic [31:0] Bank14_Addr ;
  logic [31:0] Bank15_Addr ;


  logic [31:0] Bank0_Data ;
  logic [31:0] Bank1_Data ;
  logic [31:0] Bank2_Data ;
  logic [31:0] Bank3_Data ;
  logic [31:0] Bank4_Data ;
  logic [31:0] Bank5_Data ;
  logic [31:0] Bank6_Data ;
  logic [31:0] Bank7_Data ;
  logic [31:0] Bank8_Data ;
  logic [31:0] Bank9_Data ;
  logic [31:0] Bank10_Data ;
  logic [31:0] Bank11_Data ;
  logic [31:0] Bank12_Data ;
  logic [31:0] Bank13_Data ;
  logic [31:0] Bank14_Data ;
  logic [31:0] Bank15_Data ;

  logic Bank0_Ack  ;
  logic Bank1_Ack  ;
  logic Bank2_Ack  ;
  logic Bank3_Ack  ;
  logic Bank4_Ack  ;
  logic Bank5_Ack  ;
  logic Bank6_Ack  ;
  logic Bank7_Ack  ;
  logic Bank8_Ack  ;
  logic Bank9_Ack  ;
  logic Bank10_Ack ;
  logic Bank11_Ack ;
  logic Bank12_Ack ;
  logic Bank13_Ack ;
  logic Bank14_Ack ;
  logic Bank15_Ack ;

  clocking cache_intf_pos@(posedge CLK);

  input RSTn ;
              
  input Bank0_Req  ;
  input Bank1_Req  ;
  input Bank2_Req  ;
  input Bank3_Req  ;
  input Bank4_Req  ;
  input Bank5_Req  ;
  input Bank6_Req  ;
  input Bank7_Req  ;
  input Bank8_Req  ;
  input Bank9_Req  ;
  input Bank10_Req ;
  input Bank11_Req ;
  input Bank12_Req ;
  input Bank13_Req ;
  input Bank14_Req ;
  input Bank15_Req ;
  output Bank0_Addr ;
  input Bank1_Addr ;
  input Bank2_Addr ;
  input Bank3_Addr ;
  input Bank4_Addr ;
  input Bank5_Addr ;
  input Bank6_Addr ;
  input Bank7_Addr ;
  input Bank8_Addr ;
  input Bank9_Addr ;
  input Bank10_Addr ;
  input Bank11_Addr ;
  input Bank12_Addr ;
  input Bank13_Addr ;
  input Bank14_Addr ;
  input Bank15_Addr ;


  output Bank0_Data  ;
  output Bank1_Data  ;
  output Bank2_Data  ;
  output Bank3_Data  ;
  output Bank4_Data  ;
  output Bank5_Data  ;
  output Bank6_Data  ;
  output Bank7_Data  ;
  output Bank8_Data  ;
  output Bank9_Data  ;
  output Bank10_Data ;
  output Bank11_Data ;
  output Bank12_Data ;
  output Bank13_Data ;
  output Bank14_Data ;
  output Bank15_Data ;

  output Bank0_Ack ;
  output Bank1_Ack ;
  output Bank2_Ack ;
  output Bank3_Ack ;
  output Bank4_Ack ;
  output Bank5_Ack ;
  output Bank6_Ack ;
  output Bank7_Ack ;
  output Bank8_Ack ;
  output Bank9_Ack ;
  output Bank10_Ack ;
  output Bank11_Ack ;
  output Bank12_Ack ;
  output Bank13_Ack ;
  output Bank14_Ack ;
  output Bank15_Ack ;

  endclocking

endinterface
