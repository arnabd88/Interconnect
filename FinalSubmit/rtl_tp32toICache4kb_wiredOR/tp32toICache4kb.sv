`include "DataMultiplexer.sv"
`include "AddressMultiplexer.sv"
`include "Demux.sv"
`include "Arbiter.sv"

//------- A crossbar interconnect implementation for interfacing 32 processors
//------- with a 16 banked 4 kb icache ----------

module tp32toICache4kb (
 CLK ,
 RSTn ,
 //----- Interface Core to Interconnect ------//
 Core0_Req , Core1_Req , Core2_Req , Core3_Req , Core4_Req , Core5_Req , Core6_Req , Core7_Req , Core8_Req , Core9_Req , 
 Core10_Req , Core11_Req , Core12_Req , Core13_Req , Core14_Req , Core15_Req , Core16_Req , Core17_Req , Core18_Req , Core19_Req , 
 Core20_Req , Core21_Req , Core22_Req , Core23_Req , Core24_Req , Core25_Req , Core26_Req , Core27_Req , Core28_Req , Core29_Req ,
 Core30_Req , Core31_Req , 

 Core0_Ack , Core1_Ack , Core2_Ack , Core3_Ack , Core4_Ack , Core5_Ack , Core6_Ack , Core7_Ack , Core8_Ack , Core9_Ack ,
 Core10_Ack , Core11_Ack , Core12_Ack , Core13_Ack , Core14_Ack , Core15_Ack , Core16_Ack , Core17_Ack , Core18_Ack , Core19_Ack ,
 Core20_Ack , Core21_Ack , Core22_Ack , Core23_Ack , Core24_Ack , Core25_Ack , Core26_Ack , Core27_Ack , Core28_Ack , Core29_Ack ,
 Core30_Ack , Core31_Ack ,

 Core0_AddressIn , Core1_AddressIn , Core2_AddressIn , Core3_AddressIn , Core4_AddressIn , Core5_AddressIn , Core6_AddressIn , Core7_AddressIn , Core8_AddressIn , Core9_AddressIn ,
 Core10_AddressIn , Core11_AddressIn , Core12_AddressIn , Core13_AddressIn , Core14_AddressIn , Core15_AddressIn , Core16_AddressIn , Core17_AddressIn , Core18_AddressIn , Core19_AddressIn ,
 Core20_AddressIn , Core21_AddressIn , Core22_AddressIn , Core23_AddressIn , Core24_AddressIn , Core25_AddressIn , Core26_AddressIn , Core27_AddressIn , Core28_AddressIn , Core29_AddressIn ,
 Core30_AddressIn , Core31_AddressIn ,

 Core0_DataOut , Core1_DataOut , Core2_DataOut , Core3_DataOut , Core4_DataOut , Core5_DataOut , Core6_DataOut , Core7_DataOut , Core8_DataOut , Core9_DataOut ,
 Core10_DataOut , Core11_DataOut , Core12_DataOut , Core13_DataOut , Core14_DataOut , Core15_DataOut , Core16_DataOut , Core17_DataOut , Core18_DataOut , Core19_DataOut ,
 Core20_DataOut , Core21_DataOut , Core22_DataOut , Core23_DataOut , Core24_DataOut , Core25_DataOut , Core26_DataOut , Core27_DataOut , Core28_DataOut , Core29_DataOut ,
 Core30_DataOut , Core31_DataOut ,

 //------- Interconnect to Cache Bank Interface ---------//
 Bank0_Req , Bank1_Req , Bank2_Req , Bank3_Req , Bank4_Req , Bank5_Req , Bank6_Req , Bank7_Req , Bank8_Req , Bank9_Req ,
 Bank10_Req , Bank11_Req , Bank12_Req , Bank13_Req , Bank14_Req , Bank15_Req ,

 Bank0_Ack , Bank1_Ack , Bank2_Ack , Bank3_Ack , Bank4_Ack , Bank5_Ack , Bank6_Ack , Bank7_Ack , Bank8_Ack , Bank9_Ack ,
 Bank10_Ack , Bank11_Ack , Bank12_Ack , Bank13_Ack , Bank14_Ack , Bank15_Ack ,

 Bank0_AddressOut , Bank1_AddressOut , Bank2_AddressOut , Bank3_AddressOut , Bank4_AddressOut , Bank5_AddressOut , Bank6_AddressOut , Bank7_AddressOut , Bank8_AddressOut , Bank9_AddressOut ,
 Bank10_AddressOut , Bank11_AddressOut , Bank12_AddressOut , Bank13_AddressOut , Bank14_AddressOut , Bank15_AddressOut ,

 Bank0_DataIn , Bank1_DataIn , Bank2_DataIn , Bank3_DataIn , Bank4_DataIn , Bank5_DataIn , Bank6_DataIn , Bank7_DataIn , Bank8_DataIn , Bank9_DataIn ,
 Bank10_DataIn , Bank11_DataIn , Bank12_DataIn , Bank13_DataIn , Bank14_DataIn , Bank15_DataIn );


 input CLK ;
 input RSTn ;
 //----- Interface Core to Interconnect ------//
 input Core0_Req , Core1_Req , Core2_Req , Core3_Req , Core4_Req , Core5_Req , Core6_Req , Core7_Req , Core8_Req , Core9_Req , 
 Core10_Req , Core11_Req , Core12_Req , Core13_Req , Core14_Req , Core15_Req , Core16_Req , Core17_Req , Core18_Req , Core19_Req , 
 Core20_Req , Core21_Req , Core22_Req , Core23_Req , Core24_Req , Core25_Req , Core26_Req , Core27_Req , Core28_Req , Core29_Req ,
 Core30_Req , Core31_Req ;

 output Core0_Ack , Core1_Ack , Core2_Ack , Core3_Ack , Core4_Ack , Core5_Ack , Core6_Ack , Core7_Ack , Core8_Ack , Core9_Ack ,
 Core10_Ack , Core11_Ack , Core12_Ack , Core13_Ack , Core14_Ack , Core15_Ack , Core16_Ack , Core17_Ack , Core18_Ack , Core19_Ack ,
 Core20_Ack , Core21_Ack , Core22_Ack , Core23_Ack , Core24_Ack , Core25_Ack , Core26_Ack , Core27_Ack , Core28_Ack , Core29_Ack ,
 Core30_Ack , Core31_Ack ;

 input [31:0] Core0_AddressIn , Core1_AddressIn , Core2_AddressIn , Core3_AddressIn , Core4_AddressIn , Core5_AddressIn , Core6_AddressIn , Core7_AddressIn , Core8_AddressIn , Core9_AddressIn ,
 Core10_AddressIn , Core11_AddressIn , Core12_AddressIn , Core13_AddressIn , Core14_AddressIn , Core15_AddressIn , Core16_AddressIn , Core17_AddressIn , Core18_AddressIn , Core19_AddressIn ,
 Core20_AddressIn , Core21_AddressIn , Core22_AddressIn , Core23_AddressIn , Core24_AddressIn , Core25_AddressIn , Core26_AddressIn , Core27_AddressIn , Core28_AddressIn , Core29_AddressIn ,
 Core30_AddressIn , Core31_AddressIn ;

 output [31:0] Core0_DataOut , Core1_DataOut , Core2_DataOut , Core3_DataOut , Core4_DataOut , Core5_DataOut , Core6_DataOut , Core7_DataOut , Core8_DataOut , Core9_DataOut ,
 Core10_DataOut , Core11_DataOut , Core12_DataOut , Core13_DataOut , Core14_DataOut , Core15_DataOut , Core16_DataOut , Core17_DataOut , Core18_DataOut , Core19_DataOut ,
 Core20_DataOut , Core21_DataOut , Core22_DataOut , Core23_DataOut , Core24_DataOut , Core25_DataOut , Core26_DataOut , Core27_DataOut , Core28_DataOut , Core29_DataOut ,
 Core30_DataOut , Core31_DataOut ;


 output Bank0_Req , Bank1_Req , Bank2_Req , Bank3_Req , Bank4_Req , Bank5_Req , Bank6_Req , Bank7_Req , Bank8_Req , Bank9_Req ,
 Bank10_Req , Bank11_Req , Bank12_Req , Bank13_Req , Bank14_Req , Bank15_Req ;

 input Bank0_Ack , Bank1_Ack , Bank2_Ack , Bank3_Ack , Bank4_Ack , Bank5_Ack , Bank6_Ack , Bank7_Ack , Bank8_Ack , Bank9_Ack ,
 Bank10_Ack , Bank11_Ack , Bank12_Ack , Bank13_Ack , Bank14_Ack , Bank15_Ack ;
 
 output [31:0] Bank0_AddressOut , Bank1_AddressOut , Bank2_AddressOut , Bank3_AddressOut , Bank4_AddressOut , Bank5_AddressOut , Bank6_AddressOut , Bank7_AddressOut , Bank8_AddressOut , Bank9_AddressOut ,
 Bank10_AddressOut , Bank11_AddressOut , Bank12_AddressOut , Bank13_AddressOut , Bank14_AddressOut , Bank15_AddressOut ;

 input [31:0] Bank0_DataIn , Bank1_DataIn , Bank2_DataIn , Bank3_DataIn , Bank4_DataIn , Bank5_DataIn , Bank6_DataIn , Bank7_DataIn , Bank8_DataIn , Bank9_DataIn ,
 Bank10_DataIn , Bank11_DataIn , Bank12_DataIn , Bank13_DataIn , Bank14_DataIn , Bank15_DataIn;




//  `include "MiscTask.sv"
  wire [31:0] Core0_B0_DataOut , Core0_B1_DataOut , Core0_B2_DataOut , Core0_B3_DataOut , Core0_B4_DataOut , Core0_B5_DataOut , Core0_B6_DataOut , Core0_B7_DataOut ,
              Core0_B8_DataOut , Core0_B9_DataOut , Core0_B10_DataOut, Core0_B11_DataOut, Core0_B12_DataOut, Core0_B13_DataOut, Core0_B14_DataOut, Core0_B15_DataOut;
  wire [31:0] Core1_B0_DataOut , Core1_B1_DataOut , Core1_B2_DataOut , Core1_B3_DataOut , Core1_B4_DataOut , Core1_B5_DataOut , Core1_B6_DataOut , Core1_B7_DataOut ,
              Core1_B8_DataOut , Core1_B9_DataOut , Core1_B10_DataOut, Core1_B11_DataOut, Core1_B12_DataOut, Core1_B13_DataOut, Core1_B14_DataOut, Core1_B15_DataOut;
  wire [31:0] Core2_B0_DataOut , Core2_B1_DataOut , Core2_B2_DataOut , Core2_B3_DataOut , Core2_B4_DataOut , Core2_B5_DataOut , Core2_B6_DataOut , Core2_B7_DataOut ,
              Core2_B8_DataOut , Core2_B9_DataOut , Core2_B10_DataOut, Core2_B11_DataOut, Core2_B12_DataOut, Core2_B13_DataOut, Core2_B14_DataOut, Core2_B15_DataOut;
  wire [31:0] Core3_B0_DataOut , Core3_B1_DataOut , Core3_B2_DataOut , Core3_B3_DataOut , Core3_B4_DataOut , Core3_B5_DataOut , Core3_B6_DataOut , Core3_B7_DataOut ,
              Core3_B8_DataOut , Core3_B9_DataOut , Core3_B10_DataOut, Core3_B11_DataOut, Core3_B12_DataOut, Core3_B13_DataOut, Core3_B14_DataOut, Core3_B15_DataOut;
  wire [31:0] Core4_B0_DataOut , Core4_B1_DataOut , Core4_B2_DataOut , Core4_B3_DataOut , Core4_B4_DataOut , Core4_B5_DataOut , Core4_B6_DataOut , Core4_B7_DataOut ,
              Core4_B8_DataOut , Core4_B9_DataOut , Core4_B10_DataOut, Core4_B11_DataOut, Core4_B12_DataOut, Core4_B13_DataOut, Core4_B14_DataOut, Core4_B15_DataOut;
  wire [31:0] Core5_B0_DataOut , Core5_B1_DataOut , Core5_B2_DataOut , Core5_B3_DataOut , Core5_B4_DataOut , Core5_B5_DataOut , Core5_B6_DataOut , Core5_B7_DataOut ,
              Core5_B8_DataOut , Core5_B9_DataOut , Core5_B10_DataOut, Core5_B11_DataOut, Core5_B12_DataOut, Core5_B13_DataOut, Core5_B14_DataOut, Core5_B15_DataOut;
  wire [31:0] Core6_B0_DataOut , Core6_B1_DataOut , Core6_B2_DataOut , Core6_B3_DataOut , Core6_B4_DataOut , Core6_B5_DataOut , Core6_B6_DataOut , Core6_B7_DataOut ,
              Core6_B8_DataOut , Core6_B9_DataOut , Core6_B10_DataOut, Core6_B11_DataOut, Core6_B12_DataOut, Core6_B13_DataOut, Core6_B14_DataOut, Core6_B15_DataOut;
  wire [31:0] Core7_B0_DataOut , Core7_B1_DataOut , Core7_B2_DataOut , Core7_B3_DataOut , Core7_B4_DataOut , Core7_B5_DataOut , Core7_B6_DataOut , Core7_B7_DataOut ,
              Core7_B8_DataOut , Core7_B9_DataOut , Core7_B10_DataOut, Core7_B11_DataOut, Core7_B12_DataOut, Core7_B13_DataOut, Core7_B14_DataOut, Core7_B15_DataOut;
  wire [31:0] Core8_B0_DataOut , Core8_B1_DataOut , Core8_B2_DataOut , Core8_B3_DataOut , Core8_B4_DataOut , Core8_B5_DataOut , Core8_B6_DataOut , Core8_B7_DataOut ,
              Core8_B8_DataOut , Core8_B9_DataOut , Core8_B10_DataOut, Core8_B11_DataOut, Core8_B12_DataOut, Core8_B13_DataOut, Core8_B14_DataOut, Core8_B15_DataOut;
  wire [31:0] Core9_B0_DataOut , Core9_B1_DataOut , Core9_B2_DataOut , Core9_B3_DataOut , Core9_B4_DataOut , Core9_B5_DataOut , Core9_B6_DataOut , Core9_B7_DataOut ,
              Core9_B8_DataOut , Core9_B9_DataOut , Core9_B10_DataOut, Core9_B11_DataOut, Core9_B12_DataOut, Core9_B13_DataOut, Core9_B14_DataOut, Core9_B15_DataOut;
  wire [31:0] Core10_B0_DataOut , Core10_B1_DataOut , Core10_B2_DataOut , Core10_B3_DataOut , Core10_B4_DataOut , Core10_B5_DataOut , Core10_B6_DataOut , Core10_B7_DataOut ,
              Core10_B8_DataOut , Core10_B9_DataOut , Core10_B10_DataOut, Core10_B11_DataOut, Core10_B12_DataOut, Core10_B13_DataOut, Core10_B14_DataOut, Core10_B15_DataOut;
  wire [31:0] Core11_B0_DataOut , Core11_B1_DataOut , Core11_B2_DataOut , Core11_B3_DataOut , Core11_B4_DataOut , Core11_B5_DataOut , Core11_B6_DataOut , Core11_B7_DataOut ,
              Core11_B8_DataOut , Core11_B9_DataOut , Core11_B10_DataOut, Core11_B11_DataOut, Core11_B12_DataOut, Core11_B13_DataOut, Core11_B14_DataOut, Core11_B15_DataOut;
  wire [31:0] Core12_B0_DataOut , Core12_B1_DataOut , Core12_B2_DataOut , Core12_B3_DataOut , Core12_B4_DataOut , Core12_B5_DataOut , Core12_B6_DataOut , Core12_B7_DataOut ,
              Core12_B8_DataOut , Core12_B9_DataOut , Core12_B10_DataOut, Core12_B11_DataOut, Core12_B12_DataOut, Core12_B13_DataOut, Core12_B14_DataOut, Core12_B15_DataOut;
  wire [31:0] Core13_B0_DataOut , Core13_B1_DataOut , Core13_B2_DataOut , Core13_B3_DataOut , Core13_B4_DataOut , Core13_B5_DataOut , Core13_B6_DataOut , Core13_B7_DataOut ,
              Core13_B8_DataOut , Core13_B9_DataOut , Core13_B10_DataOut, Core13_B11_DataOut, Core13_B12_DataOut, Core13_B13_DataOut, Core13_B14_DataOut, Core13_B15_DataOut;
  wire [31:0] Core14_B0_DataOut , Core14_B1_DataOut , Core14_B2_DataOut , Core14_B3_DataOut , Core14_B4_DataOut , Core14_B5_DataOut , Core14_B6_DataOut , Core14_B7_DataOut ,
              Core14_B8_DataOut , Core14_B9_DataOut , Core14_B10_DataOut, Core14_B11_DataOut, Core14_B12_DataOut, Core14_B13_DataOut, Core14_B14_DataOut, Core14_B15_DataOut;
  wire [31:0] Core15_B0_DataOut , Core15_B1_DataOut , Core15_B2_DataOut , Core15_B3_DataOut , Core15_B4_DataOut , Core15_B5_DataOut , Core15_B6_DataOut , Core15_B7_DataOut ,
              Core15_B8_DataOut , Core15_B9_DataOut , Core15_B10_DataOut, Core15_B11_DataOut, Core15_B12_DataOut, Core15_B13_DataOut, Core15_B14_DataOut, Core15_B15_DataOut;
  wire [31:0] Core16_B0_DataOut , Core16_B1_DataOut , Core16_B2_DataOut , Core16_B3_DataOut , Core16_B4_DataOut , Core16_B5_DataOut , Core16_B6_DataOut , Core16_B7_DataOut ,
              Core16_B8_DataOut , Core16_B9_DataOut , Core16_B10_DataOut, Core16_B11_DataOut, Core16_B12_DataOut, Core16_B13_DataOut, Core16_B14_DataOut, Core16_B15_DataOut;
  wire [31:0] Core17_B0_DataOut , Core17_B1_DataOut , Core17_B2_DataOut , Core17_B3_DataOut , Core17_B4_DataOut , Core17_B5_DataOut , Core17_B6_DataOut , Core17_B7_DataOut ,
              Core17_B8_DataOut , Core17_B9_DataOut , Core17_B10_DataOut, Core17_B11_DataOut, Core17_B12_DataOut, Core17_B13_DataOut, Core17_B14_DataOut, Core17_B15_DataOut;
  wire [31:0] Core18_B0_DataOut , Core18_B1_DataOut , Core18_B2_DataOut , Core18_B3_DataOut , Core18_B4_DataOut , Core18_B5_DataOut , Core18_B6_DataOut , Core18_B7_DataOut ,
              Core18_B8_DataOut , Core18_B9_DataOut , Core18_B10_DataOut, Core18_B11_DataOut, Core18_B12_DataOut, Core18_B13_DataOut, Core18_B14_DataOut, Core18_B15_DataOut;
  wire [31:0] Core19_B0_DataOut , Core19_B1_DataOut , Core19_B2_DataOut , Core19_B3_DataOut , Core19_B4_DataOut , Core19_B5_DataOut , Core19_B6_DataOut , Core19_B7_DataOut ,
              Core19_B8_DataOut , Core19_B9_DataOut , Core19_B10_DataOut, Core19_B11_DataOut, Core19_B12_DataOut, Core19_B13_DataOut, Core19_B14_DataOut, Core19_B15_DataOut;
  wire [31:0] Core20_B0_DataOut , Core20_B1_DataOut , Core20_B2_DataOut , Core20_B3_DataOut , Core20_B4_DataOut , Core20_B5_DataOut , Core20_B6_DataOut , Core20_B7_DataOut ,
              Core20_B8_DataOut , Core20_B9_DataOut , Core20_B10_DataOut, Core20_B11_DataOut, Core20_B12_DataOut, Core20_B13_DataOut, Core20_B14_DataOut, Core20_B15_DataOut;
  wire [31:0] Core21_B0_DataOut , Core21_B1_DataOut , Core21_B2_DataOut , Core21_B3_DataOut , Core21_B4_DataOut , Core21_B5_DataOut , Core21_B6_DataOut , Core21_B7_DataOut ,
              Core21_B8_DataOut , Core21_B9_DataOut , Core21_B10_DataOut, Core21_B11_DataOut, Core21_B12_DataOut, Core21_B13_DataOut, Core21_B14_DataOut, Core21_B15_DataOut;
  wire [31:0] Core22_B0_DataOut , Core22_B1_DataOut , Core22_B2_DataOut , Core22_B3_DataOut , Core22_B4_DataOut , Core22_B5_DataOut , Core22_B6_DataOut , Core22_B7_DataOut ,
              Core22_B8_DataOut , Core22_B9_DataOut , Core22_B10_DataOut, Core22_B11_DataOut, Core22_B12_DataOut, Core22_B13_DataOut, Core22_B14_DataOut, Core22_B15_DataOut;
  wire [31:0] Core23_B0_DataOut , Core23_B1_DataOut , Core23_B2_DataOut , Core23_B3_DataOut , Core23_B4_DataOut , Core23_B5_DataOut , Core23_B6_DataOut , Core23_B7_DataOut ,
              Core23_B8_DataOut , Core23_B9_DataOut , Core23_B10_DataOut, Core23_B11_DataOut, Core23_B12_DataOut, Core23_B13_DataOut, Core23_B14_DataOut, Core23_B15_DataOut;
  wire [31:0] Core24_B0_DataOut , Core24_B1_DataOut , Core24_B2_DataOut , Core24_B3_DataOut , Core24_B4_DataOut , Core24_B5_DataOut , Core24_B6_DataOut , Core24_B7_DataOut ,
              Core24_B8_DataOut , Core24_B9_DataOut , Core24_B10_DataOut, Core24_B11_DataOut, Core24_B12_DataOut, Core24_B13_DataOut, Core24_B14_DataOut, Core24_B15_DataOut;
  wire [31:0] Core25_B0_DataOut , Core25_B1_DataOut , Core25_B2_DataOut , Core25_B3_DataOut , Core25_B4_DataOut , Core25_B5_DataOut , Core25_B6_DataOut , Core25_B7_DataOut ,
              Core25_B8_DataOut , Core25_B9_DataOut , Core25_B10_DataOut, Core25_B11_DataOut, Core25_B12_DataOut, Core25_B13_DataOut, Core25_B14_DataOut, Core25_B15_DataOut;
  wire [31:0] Core26_B0_DataOut , Core26_B1_DataOut , Core26_B2_DataOut , Core26_B3_DataOut , Core26_B4_DataOut , Core26_B5_DataOut , Core26_B6_DataOut , Core26_B7_DataOut ,
              Core26_B8_DataOut , Core26_B9_DataOut , Core26_B10_DataOut, Core26_B11_DataOut, Core26_B12_DataOut, Core26_B13_DataOut, Core26_B14_DataOut, Core26_B15_DataOut;
  wire [31:0] Core27_B0_DataOut , Core27_B1_DataOut , Core27_B2_DataOut , Core27_B3_DataOut , Core27_B4_DataOut , Core27_B5_DataOut , Core27_B6_DataOut , Core27_B7_DataOut ,
              Core27_B8_DataOut , Core27_B9_DataOut , Core27_B10_DataOut, Core27_B11_DataOut, Core27_B12_DataOut, Core27_B13_DataOut, Core27_B14_DataOut, Core27_B15_DataOut;
  wire [31:0] Core28_B0_DataOut , Core28_B1_DataOut , Core28_B2_DataOut , Core28_B3_DataOut , Core28_B4_DataOut , Core28_B5_DataOut , Core28_B6_DataOut , Core28_B7_DataOut ,
              Core28_B8_DataOut , Core28_B9_DataOut , Core28_B10_DataOut, Core28_B11_DataOut, Core28_B12_DataOut, Core28_B13_DataOut, Core28_B14_DataOut, Core28_B15_DataOut;
  wire [31:0] Core29_B0_DataOut , Core29_B1_DataOut , Core29_B2_DataOut , Core29_B3_DataOut , Core29_B4_DataOut , Core29_B5_DataOut , Core29_B6_DataOut , Core29_B7_DataOut ,
              Core29_B8_DataOut , Core29_B9_DataOut , Core29_B10_DataOut, Core29_B11_DataOut, Core29_B12_DataOut, Core29_B13_DataOut, Core29_B14_DataOut, Core29_B15_DataOut;
  wire [31:0] Core30_B0_DataOut , Core30_B1_DataOut , Core30_B2_DataOut , Core30_B3_DataOut , Core30_B4_DataOut , Core30_B5_DataOut , Core30_B6_DataOut , Core30_B7_DataOut ,
              Core30_B8_DataOut , Core30_B9_DataOut , Core30_B10_DataOut, Core30_B11_DataOut, Core30_B12_DataOut, Core30_B13_DataOut, Core30_B14_DataOut, Core30_B15_DataOut;
  wire [31:0] Core31_B0_DataOut , Core31_B1_DataOut , Core31_B2_DataOut , Core31_B3_DataOut , Core31_B4_DataOut , Core31_B5_DataOut , Core31_B6_DataOut , Core31_B7_DataOut ,
              Core31_B8_DataOut , Core31_B9_DataOut , Core31_B10_DataOut, Core31_B11_DataOut, Core31_B12_DataOut, Core31_B13_DataOut, Core31_B14_DataOut, Core31_B15_DataOut;

  wire Core0_Req_Bank0, Core0_Req_Bank1, Core0_Req_Bank2, Core0_Req_Bank3, Core0_Req_Bank4, Core0_Req_Bank5, Core0_Req_Bank6, Core0_Req_Bank7, 
       Core0_Req_Bank8, Core0_Req_Bank9, Core0_Req_Bank10, Core0_Req_Bank11, Core0_Req_Bank12, Core0_Req_Bank13, Core0_Req_Bank14, Core0_Req_Bank15 ;
  wire Core1_Req_Bank0, Core1_Req_Bank1, Core1_Req_Bank2, Core1_Req_Bank3, Core1_Req_Bank4, Core1_Req_Bank5, Core1_Req_Bank6, Core1_Req_Bank7, 
       Core1_Req_Bank8, Core1_Req_Bank9, Core1_Req_Bank10, Core1_Req_Bank11, Core1_Req_Bank12, Core1_Req_Bank13, Core1_Req_Bank14, Core1_Req_Bank15 ;
  wire Core2_Req_Bank0, Core2_Req_Bank1, Core2_Req_Bank2, Core2_Req_Bank3, Core2_Req_Bank4, Core2_Req_Bank5, Core2_Req_Bank6, Core2_Req_Bank7, 
       Core2_Req_Bank8, Core2_Req_Bank9, Core2_Req_Bank10, Core2_Req_Bank11, Core2_Req_Bank12, Core2_Req_Bank13, Core2_Req_Bank14, Core2_Req_Bank15 ;
  wire Core3_Req_Bank0, Core3_Req_Bank1, Core3_Req_Bank2, Core3_Req_Bank3, Core3_Req_Bank4, Core3_Req_Bank5, Core3_Req_Bank6, Core3_Req_Bank7, 
       Core3_Req_Bank8, Core3_Req_Bank9, Core3_Req_Bank10, Core3_Req_Bank11, Core3_Req_Bank12, Core3_Req_Bank13, Core3_Req_Bank14, Core3_Req_Bank15 ;
  wire Core4_Req_Bank0, Core4_Req_Bank1, Core4_Req_Bank2, Core4_Req_Bank3, Core4_Req_Bank4, Core4_Req_Bank5, Core4_Req_Bank6, Core4_Req_Bank7, 
       Core4_Req_Bank8, Core4_Req_Bank9, Core4_Req_Bank10, Core4_Req_Bank11, Core4_Req_Bank12, Core4_Req_Bank13, Core4_Req_Bank14, Core4_Req_Bank15 ;
  wire Core5_Req_Bank0, Core5_Req_Bank1, Core5_Req_Bank2, Core5_Req_Bank3, Core5_Req_Bank4, Core5_Req_Bank5, Core5_Req_Bank6, Core5_Req_Bank7, 
       Core5_Req_Bank8, Core5_Req_Bank9, Core5_Req_Bank10, Core5_Req_Bank11, Core5_Req_Bank12, Core5_Req_Bank13, Core5_Req_Bank14, Core5_Req_Bank15 ;
  wire Core6_Req_Bank0, Core6_Req_Bank1, Core6_Req_Bank2, Core6_Req_Bank3, Core6_Req_Bank4, Core6_Req_Bank5, Core6_Req_Bank6, Core6_Req_Bank7, 
       Core6_Req_Bank8, Core6_Req_Bank9, Core6_Req_Bank10, Core6_Req_Bank11, Core6_Req_Bank12, Core6_Req_Bank13, Core6_Req_Bank14, Core6_Req_Bank15 ;
  wire Core7_Req_Bank0, Core7_Req_Bank1, Core7_Req_Bank2, Core7_Req_Bank3, Core7_Req_Bank4, Core7_Req_Bank5, Core7_Req_Bank6, Core7_Req_Bank7, 
       Core7_Req_Bank8, Core7_Req_Bank9, Core7_Req_Bank10, Core7_Req_Bank11, Core7_Req_Bank12, Core7_Req_Bank13, Core7_Req_Bank14, Core7_Req_Bank15 ;
  wire Core8_Req_Bank0, Core8_Req_Bank1, Core8_Req_Bank2, Core8_Req_Bank3, Core8_Req_Bank4, Core8_Req_Bank5, Core8_Req_Bank6, Core8_Req_Bank7, 
       Core8_Req_Bank8, Core8_Req_Bank9, Core8_Req_Bank10, Core8_Req_Bank11, Core8_Req_Bank12, Core8_Req_Bank13, Core8_Req_Bank14, Core8_Req_Bank15 ;
  wire Core9_Req_Bank0, Core9_Req_Bank1, Core9_Req_Bank2, Core9_Req_Bank3, Core9_Req_Bank4, Core9_Req_Bank5, Core9_Req_Bank6, Core9_Req_Bank7, 
       Core9_Req_Bank8, Core9_Req_Bank9, Core9_Req_Bank10, Core9_Req_Bank11, Core9_Req_Bank12, Core9_Req_Bank13, Core9_Req_Bank14, Core9_Req_Bank15 ;
  wire Core10_Req_Bank0, Core10_Req_Bank1, Core10_Req_Bank2, Core10_Req_Bank3, Core10_Req_Bank4, Core10_Req_Bank5, Core10_Req_Bank6, Core10_Req_Bank7, 
       Core10_Req_Bank8, Core10_Req_Bank9, Core10_Req_Bank10, Core10_Req_Bank11, Core10_Req_Bank12, Core10_Req_Bank13, Core10_Req_Bank14, Core10_Req_Bank15 ;
  wire Core11_Req_Bank0, Core11_Req_Bank1, Core11_Req_Bank2, Core11_Req_Bank3, Core11_Req_Bank4, Core11_Req_Bank5, Core11_Req_Bank6, Core11_Req_Bank7, 
       Core11_Req_Bank8, Core11_Req_Bank9, Core11_Req_Bank10, Core11_Req_Bank11, Core11_Req_Bank12, Core11_Req_Bank13, Core11_Req_Bank14, Core11_Req_Bank15 ;
  wire Core12_Req_Bank0, Core12_Req_Bank1, Core12_Req_Bank2, Core12_Req_Bank3, Core12_Req_Bank4, Core12_Req_Bank5,Core12_Req_Bank6,Core12_Req_Bank7, 
       Core12_Req_Bank8, Core12_Req_Bank9, Core12_Req_Bank10, Core12_Req_Bank11, Core12_Req_Bank12, Core12_Req_Bank13,Core12_Req_Bank14,Core12_Req_Bank15 ;
  wire Core13_Req_Bank0, Core13_Req_Bank1, Core13_Req_Bank2, Core13_Req_Bank3, Core13_Req_Bank4, Core13_Req_Bank5,Core13_Req_Bank6,Core13_Req_Bank7, 
       Core13_Req_Bank8, Core13_Req_Bank9, Core13_Req_Bank10, Core13_Req_Bank11, Core13_Req_Bank12, Core13_Req_Bank13,Core13_Req_Bank14,Core13_Req_Bank15 ;
  wire Core14_Req_Bank0, Core14_Req_Bank1, Core14_Req_Bank2, Core14_Req_Bank3, Core14_Req_Bank4, Core14_Req_Bank5,Core14_Req_Bank6,Core14_Req_Bank7, 
       Core14_Req_Bank8, Core14_Req_Bank9, Core14_Req_Bank10, Core14_Req_Bank11, Core14_Req_Bank12, Core14_Req_Bank13,Core14_Req_Bank14,Core14_Req_Bank15 ;
  wire Core15_Req_Bank0, Core15_Req_Bank1, Core15_Req_Bank2, Core15_Req_Bank3, Core15_Req_Bank4, Core15_Req_Bank5,Core15_Req_Bank6,Core15_Req_Bank7, 
       Core15_Req_Bank8, Core15_Req_Bank9, Core15_Req_Bank10, Core15_Req_Bank11, Core15_Req_Bank12, Core15_Req_Bank13,Core15_Req_Bank14,Core15_Req_Bank15 ;
  wire Core16_Req_Bank0, Core16_Req_Bank1, Core16_Req_Bank2, Core16_Req_Bank3, Core16_Req_Bank4, Core16_Req_Bank5,Core16_Req_Bank6,Core16_Req_Bank7, 
       Core16_Req_Bank8, Core16_Req_Bank9, Core16_Req_Bank10, Core16_Req_Bank11, Core16_Req_Bank12, Core16_Req_Bank13,Core16_Req_Bank14,Core16_Req_Bank15 ;
  wire Core17_Req_Bank0, Core17_Req_Bank1, Core17_Req_Bank2, Core17_Req_Bank3, Core17_Req_Bank4, Core17_Req_Bank5,Core17_Req_Bank6,Core17_Req_Bank7, 
       Core17_Req_Bank8, Core17_Req_Bank9, Core17_Req_Bank10, Core17_Req_Bank11, Core17_Req_Bank12, Core17_Req_Bank13,Core17_Req_Bank14,Core17_Req_Bank15 ;
  wire Core18_Req_Bank0, Core18_Req_Bank1, Core18_Req_Bank2, Core18_Req_Bank3, Core18_Req_Bank4, Core18_Req_Bank5,Core18_Req_Bank6,Core18_Req_Bank7, 
       Core18_Req_Bank8, Core18_Req_Bank9, Core18_Req_Bank10, Core18_Req_Bank11, Core18_Req_Bank12, Core18_Req_Bank13,Core18_Req_Bank14,Core18_Req_Bank15 ;
  wire Core19_Req_Bank0, Core19_Req_Bank1, Core19_Req_Bank2, Core19_Req_Bank3, Core19_Req_Bank4, Core19_Req_Bank5,Core19_Req_Bank6,Core19_Req_Bank7, 
       Core19_Req_Bank8, Core19_Req_Bank9, Core19_Req_Bank10, Core19_Req_Bank11, Core19_Req_Bank12, Core19_Req_Bank13,Core19_Req_Bank14,Core19_Req_Bank15 ;
  wire Core20_Req_Bank0, Core20_Req_Bank1, Core20_Req_Bank2, Core20_Req_Bank3, Core20_Req_Bank4, Core20_Req_Bank5,Core20_Req_Bank6,Core20_Req_Bank7, 
       Core20_Req_Bank8, Core20_Req_Bank9, Core20_Req_Bank10, Core20_Req_Bank11, Core20_Req_Bank12, Core20_Req_Bank13,Core20_Req_Bank14,Core20_Req_Bank15 ;
  wire Core21_Req_Bank0, Core21_Req_Bank1, Core21_Req_Bank2, Core21_Req_Bank3, Core21_Req_Bank4, Core21_Req_Bank5,Core21_Req_Bank6,Core21_Req_Bank7, 
       Core21_Req_Bank8, Core21_Req_Bank9, Core21_Req_Bank10, Core21_Req_Bank11, Core21_Req_Bank12, Core21_Req_Bank13,Core21_Req_Bank14,Core21_Req_Bank15 ;
  wire Core22_Req_Bank0, Core22_Req_Bank1, Core22_Req_Bank2, Core22_Req_Bank3, Core22_Req_Bank4, Core22_Req_Bank5,Core22_Req_Bank6,Core22_Req_Bank7, 
       Core22_Req_Bank8, Core22_Req_Bank9, Core22_Req_Bank10, Core22_Req_Bank11, Core22_Req_Bank12, Core22_Req_Bank13,Core22_Req_Bank14,Core22_Req_Bank15 ;
  wire Core23_Req_Bank0, Core23_Req_Bank1, Core23_Req_Bank2, Core23_Req_Bank3, Core23_Req_Bank4, Core23_Req_Bank5,Core23_Req_Bank6,Core23_Req_Bank7, 
       Core23_Req_Bank8, Core23_Req_Bank9, Core23_Req_Bank10, Core23_Req_Bank11, Core23_Req_Bank12, Core23_Req_Bank13,Core23_Req_Bank14,Core23_Req_Bank15 ;
  wire Core24_Req_Bank0, Core24_Req_Bank1, Core24_Req_Bank2, Core24_Req_Bank3, Core24_Req_Bank4, Core24_Req_Bank5,Core24_Req_Bank6,Core24_Req_Bank7, 
       Core24_Req_Bank8, Core24_Req_Bank9, Core24_Req_Bank10, Core24_Req_Bank11, Core24_Req_Bank12, Core24_Req_Bank13,Core24_Req_Bank14,Core24_Req_Bank15 ;
  wire Core25_Req_Bank0, Core25_Req_Bank1, Core25_Req_Bank2, Core25_Req_Bank3, Core25_Req_Bank4, Core25_Req_Bank5,Core25_Req_Bank6,Core25_Req_Bank7, 
       Core25_Req_Bank8, Core25_Req_Bank9, Core25_Req_Bank10, Core25_Req_Bank11, Core25_Req_Bank12, Core25_Req_Bank13,Core25_Req_Bank14,Core25_Req_Bank15 ;
  wire Core26_Req_Bank0, Core26_Req_Bank1, Core26_Req_Bank2, Core26_Req_Bank3, Core26_Req_Bank4, Core26_Req_Bank5,Core26_Req_Bank6,Core26_Req_Bank7, 
       Core26_Req_Bank8, Core26_Req_Bank9, Core26_Req_Bank10, Core26_Req_Bank11, Core26_Req_Bank12, Core26_Req_Bank13,Core26_Req_Bank14,Core26_Req_Bank15 ;
  wire Core27_Req_Bank0, Core27_Req_Bank1, Core27_Req_Bank2, Core27_Req_Bank3, Core27_Req_Bank4, Core27_Req_Bank5,Core27_Req_Bank6,Core27_Req_Bank7, 
       Core27_Req_Bank8, Core27_Req_Bank9, Core27_Req_Bank10, Core27_Req_Bank11, Core27_Req_Bank12, Core27_Req_Bank13,Core27_Req_Bank14,Core27_Req_Bank15 ;
  wire Core28_Req_Bank0, Core28_Req_Bank1, Core28_Req_Bank2, Core28_Req_Bank3, Core28_Req_Bank4, Core28_Req_Bank5,Core28_Req_Bank6,Core28_Req_Bank7, 
       Core28_Req_Bank8, Core28_Req_Bank9, Core28_Req_Bank10, Core28_Req_Bank11, Core28_Req_Bank12, Core28_Req_Bank13,Core28_Req_Bank14,Core28_Req_Bank15 ;
  wire Core29_Req_Bank0, Core29_Req_Bank1, Core29_Req_Bank2, Core29_Req_Bank3, Core29_Req_Bank4, Core29_Req_Bank5,Core29_Req_Bank6,Core29_Req_Bank7, 
       Core29_Req_Bank8, Core29_Req_Bank9, Core29_Req_Bank10, Core29_Req_Bank11, Core29_Req_Bank12, Core29_Req_Bank13,Core29_Req_Bank14,Core29_Req_Bank15 ;
  wire Core30_Req_Bank0, Core30_Req_Bank1, Core30_Req_Bank2, Core30_Req_Bank3, Core30_Req_Bank4, Core30_Req_Bank5,Core30_Req_Bank6,Core30_Req_Bank7, 
       Core30_Req_Bank8, Core30_Req_Bank9, Core30_Req_Bank10, Core30_Req_Bank11, Core30_Req_Bank12, Core30_Req_Bank13,Core30_Req_Bank14,Core30_Req_Bank15 ;
  wire Core31_Req_Bank0, Core31_Req_Bank1, Core31_Req_Bank2, Core31_Req_Bank3, Core31_Req_Bank4, Core31_Req_Bank5,Core31_Req_Bank6,Core31_Req_Bank7, 
       Core31_Req_Bank8, Core31_Req_Bank9, Core31_Req_Bank10, Core31_Req_Bank11, Core31_Req_Bank12, Core31_Req_Bank13,Core31_Req_Bank14,Core31_Req_Bank15 ;

  wire Core0_Ack_Bank0, Core0_Ack_Bank1, Core0_Ack_Bank2, Core0_Ack_Bank3, Core0_Ack_Bank4, Core0_Ack_Bank5, Core0_Ack_Bank6, Core0_Ack_Bank7, 
       Core0_Ack_Bank8, Core0_Ack_Bank9, Core0_Ack_Bank10, Core0_Ack_Bank11, Core0_Ack_Bank12, Core0_Ack_Bank13, Core0_Ack_Bank14, Core0_Ack_Bank15 ;
  wire Core1_Ack_Bank0, Core1_Ack_Bank1, Core1_Ack_Bank2, Core1_Ack_Bank3, Core1_Ack_Bank4, Core1_Ack_Bank5, Core1_Ack_Bank6, Core1_Ack_Bank7, 
       Core1_Ack_Bank8, Core1_Ack_Bank9, Core1_Ack_Bank10, Core1_Ack_Bank11, Core1_Ack_Bank12, Core1_Ack_Bank13, Core1_Ack_Bank14, Core1_Ack_Bank15 ;
  wire Core2_Ack_Bank0, Core2_Ack_Bank1, Core2_Ack_Bank2, Core2_Ack_Bank3, Core2_Ack_Bank4, Core2_Ack_Bank5, Core2_Ack_Bank6, Core2_Ack_Bank7, 
       Core2_Ack_Bank8, Core2_Ack_Bank9, Core2_Ack_Bank10, Core2_Ack_Bank11, Core2_Ack_Bank12, Core2_Ack_Bank13, Core2_Ack_Bank14, Core2_Ack_Bank15 ;
  wire Core3_Ack_Bank0, Core3_Ack_Bank1, Core3_Ack_Bank2, Core3_Ack_Bank3, Core3_Ack_Bank4, Core3_Ack_Bank5, Core3_Ack_Bank6, Core3_Ack_Bank7, 
       Core3_Ack_Bank8, Core3_Ack_Bank9, Core3_Ack_Bank10, Core3_Ack_Bank11, Core3_Ack_Bank12, Core3_Ack_Bank13, Core3_Ack_Bank14, Core3_Ack_Bank15 ;
  wire Core4_Ack_Bank0, Core4_Ack_Bank1, Core4_Ack_Bank2, Core4_Ack_Bank3, Core4_Ack_Bank4, Core4_Ack_Bank5, Core4_Ack_Bank6, Core4_Ack_Bank7, 
       Core4_Ack_Bank8, Core4_Ack_Bank9, Core4_Ack_Bank10, Core4_Ack_Bank11, Core4_Ack_Bank12, Core4_Ack_Bank13, Core4_Ack_Bank14, Core4_Ack_Bank15 ;
  wire Core5_Ack_Bank0, Core5_Ack_Bank1, Core5_Ack_Bank2, Core5_Ack_Bank3, Core5_Ack_Bank4, Core5_Ack_Bank5, Core5_Ack_Bank6, Core5_Ack_Bank7, 
       Core5_Ack_Bank8, Core5_Ack_Bank9, Core5_Ack_Bank10, Core5_Ack_Bank11, Core5_Ack_Bank12, Core5_Ack_Bank13, Core5_Ack_Bank14, Core5_Ack_Bank15 ;
  wire Core6_Ack_Bank0, Core6_Ack_Bank1, Core6_Ack_Bank2, Core6_Ack_Bank3, Core6_Ack_Bank4, Core6_Ack_Bank5, Core6_Ack_Bank6, Core6_Ack_Bank7, 
       Core6_Ack_Bank8, Core6_Ack_Bank9, Core6_Ack_Bank10, Core6_Ack_Bank11, Core6_Ack_Bank12, Core6_Ack_Bank13, Core6_Ack_Bank14, Core6_Ack_Bank15 ;
  wire Core7_Ack_Bank0, Core7_Ack_Bank1, Core7_Ack_Bank2, Core7_Ack_Bank3, Core7_Ack_Bank4, Core7_Ack_Bank5, Core7_Ack_Bank6, Core7_Ack_Bank7, 
       Core7_Ack_Bank8, Core7_Ack_Bank9, Core7_Ack_Bank10, Core7_Ack_Bank11, Core7_Ack_Bank12, Core7_Ack_Bank13, Core7_Ack_Bank14, Core7_Ack_Bank15 ;
  wire Core8_Ack_Bank0, Core8_Ack_Bank1, Core8_Ack_Bank2, Core8_Ack_Bank3, Core8_Ack_Bank4, Core8_Ack_Bank5, Core8_Ack_Bank6, Core8_Ack_Bank7, 
       Core8_Ack_Bank8, Core8_Ack_Bank9, Core8_Ack_Bank10, Core8_Ack_Bank11, Core8_Ack_Bank12, Core8_Ack_Bank13, Core8_Ack_Bank14, Core8_Ack_Bank15 ;
  wire Core9_Ack_Bank0, Core9_Ack_Bank1, Core9_Ack_Bank2, Core9_Ack_Bank3, Core9_Ack_Bank4, Core9_Ack_Bank5, Core9_Ack_Bank6, Core9_Ack_Bank7, 
       Core9_Ack_Bank8, Core9_Ack_Bank9, Core9_Ack_Bank10, Core9_Ack_Bank11, Core9_Ack_Bank12, Core9_Ack_Bank13, Core9_Ack_Bank14, Core9_Ack_Bank15 ;
  wire Core10_Ack_Bank0, Core10_Ack_Bank1, Core10_Ack_Bank2, Core10_Ack_Bank3, Core10_Ack_Bank4, Core10_Ack_Bank5, Core10_Ack_Bank6, Core10_Ack_Bank7, 
       Core10_Ack_Bank8, Core10_Ack_Bank9, Core10_Ack_Bank10, Core10_Ack_Bank11, Core10_Ack_Bank12, Core10_Ack_Bank13, Core10_Ack_Bank14, Core10_Ack_Bank15 ;
  wire Core11_Ack_Bank0, Core11_Ack_Bank1, Core11_Ack_Bank2, Core11_Ack_Bank3, Core11_Ack_Bank4, Core11_Ack_Bank5, Core11_Ack_Bank6, Core11_Ack_Bank7, 
       Core11_Ack_Bank8, Core11_Ack_Bank9, Core11_Ack_Bank10, Core11_Ack_Bank11, Core11_Ack_Bank12, Core11_Ack_Bank13, Core11_Ack_Bank14, Core11_Ack_Bank15 ;
  wire Core12_Ack_Bank0, Core12_Ack_Bank1, Core12_Ack_Bank2, Core12_Ack_Bank3, Core12_Ack_Bank4, Core12_Ack_Bank5, Core12_Ack_Bank6, Core12_Ack_Bank7, 
       Core12_Ack_Bank8, Core12_Ack_Bank9, Core12_Ack_Bank10, Core12_Ack_Bank11, Core12_Ack_Bank12, Core12_Ack_Bank13, Core12_Ack_Bank14, Core12_Ack_Bank15 ;
  wire Core13_Ack_Bank0, Core13_Ack_Bank1, Core13_Ack_Bank2, Core13_Ack_Bank3, Core13_Ack_Bank4, Core13_Ack_Bank5, Core13_Ack_Bank6, Core13_Ack_Bank7, 
       Core13_Ack_Bank8, Core13_Ack_Bank9, Core13_Ack_Bank10, Core13_Ack_Bank11, Core13_Ack_Bank12, Core13_Ack_Bank13, Core13_Ack_Bank14, Core13_Ack_Bank15 ;
  wire Core14_Ack_Bank0, Core14_Ack_Bank1, Core14_Ack_Bank2, Core14_Ack_Bank3, Core14_Ack_Bank4, Core14_Ack_Bank5, Core14_Ack_Bank6, Core14_Ack_Bank7, 
       Core14_Ack_Bank8, Core14_Ack_Bank9, Core14_Ack_Bank10, Core14_Ack_Bank11, Core14_Ack_Bank12, Core14_Ack_Bank13, Core14_Ack_Bank14, Core14_Ack_Bank15 ;
  wire Core15_Ack_Bank0, Core15_Ack_Bank1, Core15_Ack_Bank2, Core15_Ack_Bank3, Core15_Ack_Bank4, Core15_Ack_Bank5, Core15_Ack_Bank6, Core15_Ack_Bank7, 
       Core15_Ack_Bank8, Core15_Ack_Bank9, Core15_Ack_Bank10, Core15_Ack_Bank11, Core15_Ack_Bank12, Core15_Ack_Bank13, Core15_Ack_Bank14, Core15_Ack_Bank15 ;
  wire Core16_Ack_Bank0, Core16_Ack_Bank1, Core16_Ack_Bank2, Core16_Ack_Bank3, Core16_Ack_Bank4, Core16_Ack_Bank5, Core16_Ack_Bank6, Core16_Ack_Bank7, 
       Core16_Ack_Bank8, Core16_Ack_Bank9, Core16_Ack_Bank10, Core16_Ack_Bank11, Core16_Ack_Bank12, Core16_Ack_Bank13, Core16_Ack_Bank14, Core16_Ack_Bank15 ;
  wire Core17_Ack_Bank0, Core17_Ack_Bank1, Core17_Ack_Bank2, Core17_Ack_Bank3, Core17_Ack_Bank4, Core17_Ack_Bank5, Core17_Ack_Bank6, Core17_Ack_Bank7, 
       Core17_Ack_Bank8, Core17_Ack_Bank9, Core17_Ack_Bank10, Core17_Ack_Bank11, Core17_Ack_Bank12, Core17_Ack_Bank13, Core17_Ack_Bank14, Core17_Ack_Bank15 ;
  wire Core18_Ack_Bank0, Core18_Ack_Bank1, Core18_Ack_Bank2, Core18_Ack_Bank3, Core18_Ack_Bank4, Core18_Ack_Bank5, Core18_Ack_Bank6, Core18_Ack_Bank7, 
       Core18_Ack_Bank8, Core18_Ack_Bank9, Core18_Ack_Bank10, Core18_Ack_Bank11, Core18_Ack_Bank12, Core18_Ack_Bank13, Core18_Ack_Bank14, Core18_Ack_Bank15 ;
  wire Core19_Ack_Bank0, Core19_Ack_Bank1, Core19_Ack_Bank2, Core19_Ack_Bank3, Core19_Ack_Bank4, Core19_Ack_Bank5, Core19_Ack_Bank6, Core19_Ack_Bank7, 
       Core19_Ack_Bank8, Core19_Ack_Bank9, Core19_Ack_Bank10, Core19_Ack_Bank11, Core19_Ack_Bank12, Core19_Ack_Bank13, Core19_Ack_Bank14, Core19_Ack_Bank15 ;
  wire Core20_Ack_Bank0, Core20_Ack_Bank1, Core20_Ack_Bank2, Core20_Ack_Bank3, Core20_Ack_Bank4, Core20_Ack_Bank5, Core20_Ack_Bank6, Core20_Ack_Bank7, 
       Core20_Ack_Bank8, Core20_Ack_Bank9, Core20_Ack_Bank10, Core20_Ack_Bank11, Core20_Ack_Bank12, Core20_Ack_Bank13, Core20_Ack_Bank14, Core20_Ack_Bank15 ;
  wire Core21_Ack_Bank0, Core21_Ack_Bank1, Core21_Ack_Bank2, Core21_Ack_Bank3, Core21_Ack_Bank4, Core21_Ack_Bank5, Core21_Ack_Bank6, Core21_Ack_Bank7, 
       Core21_Ack_Bank8, Core21_Ack_Bank9, Core21_Ack_Bank10, Core21_Ack_Bank11, Core21_Ack_Bank12, Core21_Ack_Bank13, Core21_Ack_Bank14, Core21_Ack_Bank15 ;
  wire Core22_Ack_Bank0, Core22_Ack_Bank1, Core22_Ack_Bank2, Core22_Ack_Bank3, Core22_Ack_Bank4, Core22_Ack_Bank5, Core22_Ack_Bank6, Core22_Ack_Bank7, 
       Core22_Ack_Bank8, Core22_Ack_Bank9, Core22_Ack_Bank10, Core22_Ack_Bank11, Core22_Ack_Bank12, Core22_Ack_Bank13, Core22_Ack_Bank14, Core22_Ack_Bank15 ;
  wire Core23_Ack_Bank0, Core23_Ack_Bank1, Core23_Ack_Bank2, Core23_Ack_Bank3, Core23_Ack_Bank4, Core23_Ack_Bank5, Core23_Ack_Bank6, Core23_Ack_Bank7, 
       Core23_Ack_Bank8, Core23_Ack_Bank9, Core23_Ack_Bank10, Core23_Ack_Bank11, Core23_Ack_Bank12, Core23_Ack_Bank13, Core23_Ack_Bank14, Core23_Ack_Bank15 ;
  wire Core24_Ack_Bank0, Core24_Ack_Bank1, Core24_Ack_Bank2, Core24_Ack_Bank3, Core24_Ack_Bank4, Core24_Ack_Bank5, Core24_Ack_Bank6, Core24_Ack_Bank7, 
       Core24_Ack_Bank8, Core24_Ack_Bank9, Core24_Ack_Bank10, Core24_Ack_Bank11, Core24_Ack_Bank12, Core24_Ack_Bank13, Core24_Ack_Bank14, Core24_Ack_Bank15 ;
  wire Core25_Ack_Bank0, Core25_Ack_Bank1, Core25_Ack_Bank2, Core25_Ack_Bank3, Core25_Ack_Bank4, Core25_Ack_Bank5, Core25_Ack_Bank6, Core25_Ack_Bank7, 
       Core25_Ack_Bank8, Core25_Ack_Bank9, Core25_Ack_Bank10, Core25_Ack_Bank11, Core25_Ack_Bank12, Core25_Ack_Bank13, Core25_Ack_Bank14, Core25_Ack_Bank15 ;
  wire Core26_Ack_Bank0, Core26_Ack_Bank1, Core26_Ack_Bank2, Core26_Ack_Bank3, Core26_Ack_Bank4, Core26_Ack_Bank5, Core26_Ack_Bank6, Core26_Ack_Bank7, 
       Core26_Ack_Bank8, Core26_Ack_Bank9, Core26_Ack_Bank10, Core26_Ack_Bank11, Core26_Ack_Bank12, Core26_Ack_Bank13, Core26_Ack_Bank14, Core26_Ack_Bank15 ;
  wire Core27_Ack_Bank0, Core27_Ack_Bank1, Core27_Ack_Bank2, Core27_Ack_Bank3, Core27_Ack_Bank4, Core27_Ack_Bank5, Core27_Ack_Bank6, Core27_Ack_Bank7, 
       Core27_Ack_Bank8, Core27_Ack_Bank9, Core27_Ack_Bank10, Core27_Ack_Bank11, Core27_Ack_Bank12, Core27_Ack_Bank13, Core27_Ack_Bank14, Core27_Ack_Bank15 ;
  wire Core28_Ack_Bank0, Core28_Ack_Bank1, Core28_Ack_Bank2, Core28_Ack_Bank3, Core28_Ack_Bank4, Core28_Ack_Bank5, Core28_Ack_Bank6, Core28_Ack_Bank7, 
       Core28_Ack_Bank8, Core28_Ack_Bank9, Core28_Ack_Bank10, Core28_Ack_Bank11, Core28_Ack_Bank12, Core28_Ack_Bank13, Core28_Ack_Bank14, Core28_Ack_Bank15 ;
  wire Core29_Ack_Bank0, Core29_Ack_Bank1, Core29_Ack_Bank2, Core29_Ack_Bank3, Core29_Ack_Bank4, Core29_Ack_Bank5, Core29_Ack_Bank6, Core29_Ack_Bank7, 
       Core29_Ack_Bank8, Core29_Ack_Bank9, Core29_Ack_Bank10, Core29_Ack_Bank11, Core29_Ack_Bank12, Core29_Ack_Bank13, Core29_Ack_Bank14, Core29_Ack_Bank15 ;
  wire Core30_Ack_Bank0, Core30_Ack_Bank1, Core30_Ack_Bank2, Core30_Ack_Bank3, Core30_Ack_Bank4, Core30_Ack_Bank5, Core30_Ack_Bank6, Core30_Ack_Bank7, 
       Core30_Ack_Bank8, Core30_Ack_Bank9, Core30_Ack_Bank10, Core30_Ack_Bank11, Core30_Ack_Bank12, Core30_Ack_Bank13, Core30_Ack_Bank14, Core30_Ack_Bank15 ;
  wire Core31_Ack_Bank0, Core31_Ack_Bank1, Core31_Ack_Bank2, Core31_Ack_Bank3, Core31_Ack_Bank4, Core31_Ack_Bank5, Core31_Ack_Bank6, Core31_Ack_Bank7, 
       Core31_Ack_Bank8, Core31_Ack_Bank9, Core31_Ack_Bank10, Core31_Ack_Bank11, Core31_Ack_Bank12, Core31_Ack_Bank13, Core31_Ack_Bank14, Core31_Ack_Bank15 ;

  wire[4:0] SelectCore_to_Bank0, SelectCore_to_Bank1, SelectCore_to_Bank2, SelectCore_to_Bank3, SelectCore_to_Bank4, SelectCore_to_Bank5, SelectCore_to_Bank6,
       SelectCore_to_Bank7, SelectCore_to_Bank8, SelectCore_to_Bank9, SelectCore_to_Bank10, SelectCore_to_Bank11, SelectCore_to_Bank12,
       SelectCore_to_Bank13, SelectCore_to_Bank14, SelectCore_to_Bank15 ;

  wire Done_Bank0, Done_Bank1, Done_Bank2, Done_Bank3, Done_Bank4, Done_Bank5, Done_Bank6, Done_Bank7, Done_Bank8,
       Done_Bank9, Done_Bank10, Done_Bank11, Done_Bank12, Done_Bank13, Done_Bank14, Done_Bank15 ;

 wire Grant_Bank0 , Grant_Bank1 , Grant_Bank2 , Grant_Bank3 , Grant_Bank4 , Grant_Bank5 , Grant_Bank6 , Grant_Bank7 ,
 Grant_Bank8 , Grant_Bank9 , Grant_Bank10, Grant_Bank11, Grant_Bank12, Grant_Bank13, Grant_Bank14, Grant_Bank15 ;

  //---- Set forth the access requests to the cache banks ----
  assign Bank0_Req   =  Grant_Bank0 ;
  assign Bank1_Req   =  Grant_Bank1 ;
  assign Bank2_Req   =  Grant_Bank2 ;
  assign Bank3_Req   =  Grant_Bank3 ;
  assign Bank4_Req   =  Grant_Bank4 ;
  assign Bank5_Req   =  Grant_Bank5 ;
  assign Bank6_Req   =  Grant_Bank6 ;
  assign Bank7_Req   =  Grant_Bank7 ;
  assign Bank8_Req   =  Grant_Bank8 ;
  assign Bank9_Req   =  Grant_Bank9 ;
  assign Bank10_Req  =  Grant_Bank10 ;
  assign Bank11_Req  =  Grant_Bank11 ;
  assign Bank12_Req  =  Grant_Bank12 ;
  assign Bank13_Req  =  Grant_Bank13 ;
  assign Bank14_Req  =  Grant_Bank14 ;
  assign Bank15_Req  =  Grant_Bank15 ;

  assign Done_Bank0   =   Bank0_Ack ;
  assign Done_Bank1   =   Bank1_Ack ;
  assign Done_Bank2   =   Bank2_Ack ;
  assign Done_Bank3   =   Bank3_Ack ;
  assign Done_Bank4   =   Bank4_Ack ;
  assign Done_Bank5   =   Bank5_Ack ;
  assign Done_Bank6   =   Bank6_Ack ;
  assign Done_Bank7   =   Bank7_Ack ;
  assign Done_Bank8   =   Bank8_Ack ;
  assign Done_Bank9   =   Bank9_Ack ;
  assign Done_Bank10  =   Bank10_Ack ;
  assign Done_Bank11  =   Bank11_Ack ;
  assign Done_Bank12  =   Bank12_Ack ;
  assign Done_Bank13  =   Bank13_Ack ;
  assign Done_Bank14  =   Bank14_Ack ;
  assign Done_Bank15  =   Bank15_Ack ;

  assign Core0_Ack = Core0_Ack_Bank0  | Core0_Ack_Bank1  | Core0_Ack_Bank2  | Core0_Ack_Bank3  | Core0_Ack_Bank4  | Core0_Ack_Bank5  | Core0_Ack_Bank6  |
                     Core0_Ack_Bank7  | Core0_Ack_Bank8  | Core0_Ack_Bank9  | Core0_Ack_Bank10 | Core0_Ack_Bank11 | Core0_Ack_Bank12 | Core0_Ack_Bank13 |
					 Core0_Ack_Bank14 | Core0_Ack_Bank15  ;

  assign Core1_Ack = Core1_Ack_Bank0  | Core1_Ack_Bank1  | Core1_Ack_Bank2  | Core1_Ack_Bank3  | Core1_Ack_Bank4  | Core1_Ack_Bank5  | Core1_Ack_Bank6  |
                     Core1_Ack_Bank7  | Core1_Ack_Bank8  | Core1_Ack_Bank9  | Core1_Ack_Bank10 | Core1_Ack_Bank11 | Core1_Ack_Bank12 | Core1_Ack_Bank13 |
					 Core1_Ack_Bank14 | Core1_Ack_Bank15  ;

  assign Core2_Ack = Core2_Ack_Bank0  | Core2_Ack_Bank1  | Core2_Ack_Bank2  | Core2_Ack_Bank3  | Core2_Ack_Bank4  | Core2_Ack_Bank5  | Core2_Ack_Bank6  |
                     Core2_Ack_Bank7  | Core2_Ack_Bank8  | Core2_Ack_Bank9  | Core2_Ack_Bank10 | Core2_Ack_Bank11 | Core2_Ack_Bank12 | Core2_Ack_Bank13 |
					 Core2_Ack_Bank14 | Core2_Ack_Bank15  ;

  assign Core3_Ack = Core3_Ack_Bank0  | Core3_Ack_Bank1  | Core3_Ack_Bank2  | Core3_Ack_Bank3  | Core3_Ack_Bank4  | Core3_Ack_Bank5  | Core3_Ack_Bank6  |
                     Core3_Ack_Bank7  | Core3_Ack_Bank8  | Core3_Ack_Bank9  | Core3_Ack_Bank10 | Core3_Ack_Bank11 | Core3_Ack_Bank12 | Core3_Ack_Bank13 |
					 Core3_Ack_Bank14 | Core3_Ack_Bank15  ;

  assign Core4_Ack = Core4_Ack_Bank0  | Core4_Ack_Bank1  | Core4_Ack_Bank2  | Core4_Ack_Bank3  | Core4_Ack_Bank4  | Core4_Ack_Bank5  | Core4_Ack_Bank6  |
                     Core4_Ack_Bank7  | Core4_Ack_Bank8  | Core4_Ack_Bank9  | Core4_Ack_Bank10 | Core4_Ack_Bank11 | Core4_Ack_Bank12 | Core4_Ack_Bank13 |
					 Core4_Ack_Bank14 | Core4_Ack_Bank15  ;

  assign Core5_Ack = Core5_Ack_Bank0  | Core5_Ack_Bank1  | Core5_Ack_Bank2  | Core5_Ack_Bank3  | Core5_Ack_Bank4  | Core5_Ack_Bank5  | Core5_Ack_Bank6  |
                     Core5_Ack_Bank7  | Core5_Ack_Bank8  | Core5_Ack_Bank9  | Core5_Ack_Bank10 | Core5_Ack_Bank11 | Core5_Ack_Bank12 | Core5_Ack_Bank13 |
					 Core5_Ack_Bank14 | Core5_Ack_Bank15  ;

  assign Core6_Ack = Core6_Ack_Bank0  | Core6_Ack_Bank1  | Core6_Ack_Bank2  | Core6_Ack_Bank3  | Core6_Ack_Bank4  | Core6_Ack_Bank5  | Core6_Ack_Bank6  |
                     Core6_Ack_Bank7  | Core6_Ack_Bank8  | Core6_Ack_Bank9  | Core6_Ack_Bank10 | Core6_Ack_Bank11 | Core6_Ack_Bank12 | Core6_Ack_Bank13 |
					 Core6_Ack_Bank14 | Core6_Ack_Bank15  ;

  assign Core7_Ack = Core7_Ack_Bank0  | Core7_Ack_Bank1  | Core7_Ack_Bank2  | Core7_Ack_Bank3  | Core7_Ack_Bank4  | Core7_Ack_Bank5  | Core7_Ack_Bank6  |
                     Core7_Ack_Bank7  | Core7_Ack_Bank8  | Core7_Ack_Bank9  | Core7_Ack_Bank10 | Core7_Ack_Bank11 | Core7_Ack_Bank12 | Core7_Ack_Bank13 |
					 Core7_Ack_Bank14 | Core7_Ack_Bank15  ;

  assign Core8_Ack = Core8_Ack_Bank0  | Core8_Ack_Bank1  | Core8_Ack_Bank2  | Core8_Ack_Bank3  | Core8_Ack_Bank4  | Core8_Ack_Bank5  | Core8_Ack_Bank6  |
                     Core8_Ack_Bank7  | Core8_Ack_Bank8  | Core8_Ack_Bank9  | Core8_Ack_Bank10 | Core8_Ack_Bank11 | Core8_Ack_Bank12 | Core8_Ack_Bank13 |
					 Core8_Ack_Bank14 | Core8_Ack_Bank15  ;

  assign Core9_Ack = Core9_Ack_Bank0  | Core9_Ack_Bank1  | Core9_Ack_Bank2  | Core9_Ack_Bank3  | Core9_Ack_Bank4  | Core9_Ack_Bank5  | Core9_Ack_Bank6  |
                     Core9_Ack_Bank7  | Core9_Ack_Bank8  | Core9_Ack_Bank9  | Core9_Ack_Bank10 | Core9_Ack_Bank11 | Core9_Ack_Bank12 | Core9_Ack_Bank13 |
					 Core9_Ack_Bank14 | Core9_Ack_Bank15  ;

  assign Core10_Ack = Core10_Ack_Bank0  | Core10_Ack_Bank1  | Core10_Ack_Bank2  | Core10_Ack_Bank3  | Core10_Ack_Bank4  | Core10_Ack_Bank5  | Core10_Ack_Bank6  |
                     Core10_Ack_Bank7  | Core10_Ack_Bank8  | Core10_Ack_Bank9  | Core10_Ack_Bank10 | Core10_Ack_Bank11 | Core10_Ack_Bank12 | Core10_Ack_Bank13 |
					 Core10_Ack_Bank14 | Core10_Ack_Bank15 ;

  assign Core11_Ack = Core11_Ack_Bank0  | Core11_Ack_Bank1  | Core11_Ack_Bank2  | Core11_Ack_Bank3  | Core11_Ack_Bank4  | Core11_Ack_Bank5  | Core11_Ack_Bank6  |
                     Core11_Ack_Bank7  | Core11_Ack_Bank8  | Core11_Ack_Bank9  | Core11_Ack_Bank10 | Core11_Ack_Bank11 | Core11_Ack_Bank12 | Core11_Ack_Bank13 |
					 Core11_Ack_Bank14 | Core11_Ack_Bank15  ;

  assign Core12_Ack = Core12_Ack_Bank0  | Core12_Ack_Bank1  | Core12_Ack_Bank2  | Core12_Ack_Bank3  | Core12_Ack_Bank4  | Core12_Ack_Bank5  | Core12_Ack_Bank6  |
                     Core12_Ack_Bank7  | Core12_Ack_Bank8  | Core12_Ack_Bank9  | Core12_Ack_Bank10 | Core12_Ack_Bank11 | Core12_Ack_Bank12 | Core12_Ack_Bank13 |
					 Core12_Ack_Bank14 | Core12_Ack_Bank15  ;

  assign Core13_Ack = Core13_Ack_Bank0  | Core13_Ack_Bank1  | Core13_Ack_Bank2  | Core13_Ack_Bank3  | Core13_Ack_Bank4  | Core13_Ack_Bank5  | Core13_Ack_Bank6  |
                     Core13_Ack_Bank7  | Core13_Ack_Bank8  | Core13_Ack_Bank9  | Core13_Ack_Bank10 | Core13_Ack_Bank11 | Core13_Ack_Bank12 | Core13_Ack_Bank13 |
					 Core13_Ack_Bank14 | Core13_Ack_Bank15  ;

  assign Core14_Ack = Core14_Ack_Bank0  | Core14_Ack_Bank1  | Core14_Ack_Bank2  | Core14_Ack_Bank3  | Core14_Ack_Bank4  | Core14_Ack_Bank5  | Core14_Ack_Bank6  |
                     Core14_Ack_Bank7  | Core14_Ack_Bank8  | Core14_Ack_Bank9  | Core14_Ack_Bank10 | Core14_Ack_Bank11 | Core14_Ack_Bank12 | Core14_Ack_Bank13 |
					 Core14_Ack_Bank14 | Core14_Ack_Bank15  ;

  assign Core15_Ack = Core15_Ack_Bank0  | Core15_Ack_Bank1  | Core15_Ack_Bank2  | Core15_Ack_Bank3  | Core15_Ack_Bank4  | Core15_Ack_Bank5  | Core15_Ack_Bank6  |
                     Core15_Ack_Bank7  | Core15_Ack_Bank8  | Core15_Ack_Bank9  | Core15_Ack_Bank10 | Core15_Ack_Bank11 | Core15_Ack_Bank12 | Core15_Ack_Bank13 |
					 Core15_Ack_Bank14 | Core15_Ack_Bank15  ;

  assign Core16_Ack = Core16_Ack_Bank0  | Core16_Ack_Bank1  | Core16_Ack_Bank2  | Core16_Ack_Bank3  | Core16_Ack_Bank4  | Core16_Ack_Bank5  | Core16_Ack_Bank6  |
                     Core16_Ack_Bank7  | Core16_Ack_Bank8  | Core16_Ack_Bank9  | Core16_Ack_Bank10 | Core16_Ack_Bank11 | Core16_Ack_Bank12 | Core16_Ack_Bank13 |
					 Core16_Ack_Bank14 | Core16_Ack_Bank15  ;

  assign Core17_Ack = Core17_Ack_Bank0  | Core17_Ack_Bank1  | Core17_Ack_Bank2  | Core17_Ack_Bank3  | Core17_Ack_Bank4  | Core17_Ack_Bank5  | Core17_Ack_Bank6  |
                     Core17_Ack_Bank7  | Core17_Ack_Bank8  | Core17_Ack_Bank9  | Core17_Ack_Bank10 | Core17_Ack_Bank11 | Core17_Ack_Bank12 | Core17_Ack_Bank13 |
					 Core17_Ack_Bank14 | Core17_Ack_Bank15  ;

  assign Core18_Ack = Core18_Ack_Bank0  | Core18_Ack_Bank1  | Core18_Ack_Bank2  | Core18_Ack_Bank3  | Core18_Ack_Bank4  | Core18_Ack_Bank5  | Core18_Ack_Bank6  |
                     Core18_Ack_Bank7  | Core18_Ack_Bank8  | Core18_Ack_Bank9  | Core18_Ack_Bank10 | Core18_Ack_Bank11 | Core18_Ack_Bank12 | Core18_Ack_Bank13 |
					 Core18_Ack_Bank14 | Core18_Ack_Bank15  ;

  assign Core19_Ack = Core19_Ack_Bank0  | Core19_Ack_Bank1  | Core19_Ack_Bank2  | Core19_Ack_Bank3  | Core19_Ack_Bank4  | Core19_Ack_Bank5  | Core19_Ack_Bank6  |
                     Core19_Ack_Bank7  | Core19_Ack_Bank8  | Core19_Ack_Bank9  | Core19_Ack_Bank10 | Core19_Ack_Bank11 | Core19_Ack_Bank12 | Core19_Ack_Bank13 |
					 Core19_Ack_Bank14 | Core19_Ack_Bank15  ;

  assign Core20_Ack = Core20_Ack_Bank0  | Core20_Ack_Bank1  | Core20_Ack_Bank2  | Core20_Ack_Bank3  | Core20_Ack_Bank4  | Core20_Ack_Bank5  | Core20_Ack_Bank6  |
                     Core20_Ack_Bank7  | Core20_Ack_Bank8  | Core20_Ack_Bank9  | Core20_Ack_Bank10 | Core20_Ack_Bank11 | Core20_Ack_Bank12 | Core20_Ack_Bank13 |
					 Core20_Ack_Bank14 | Core20_Ack_Bank15  ;

  assign Core21_Ack = Core21_Ack_Bank0  | Core21_Ack_Bank1  | Core21_Ack_Bank2  | Core21_Ack_Bank3  | Core21_Ack_Bank4  | Core21_Ack_Bank5  | Core21_Ack_Bank6  |
                     Core21_Ack_Bank7  | Core21_Ack_Bank8  | Core21_Ack_Bank9  | Core21_Ack_Bank10 | Core21_Ack_Bank11 | Core21_Ack_Bank12 | Core21_Ack_Bank13 |
					 Core21_Ack_Bank14 | Core21_Ack_Bank15  ;

  assign Core22_Ack = Core22_Ack_Bank0  | Core22_Ack_Bank1  | Core22_Ack_Bank2  | Core22_Ack_Bank3  | Core22_Ack_Bank4  | Core22_Ack_Bank5  | Core22_Ack_Bank6  |
                     Core22_Ack_Bank7  | Core22_Ack_Bank8  | Core22_Ack_Bank9  | Core22_Ack_Bank10 | Core22_Ack_Bank11 | Core22_Ack_Bank12 | Core22_Ack_Bank13 |
					 Core22_Ack_Bank14 | Core22_Ack_Bank15  ;

  assign Core23_Ack = Core23_Ack_Bank0  | Core23_Ack_Bank1  | Core23_Ack_Bank2  | Core23_Ack_Bank3  | Core23_Ack_Bank4  | Core23_Ack_Bank5  | Core23_Ack_Bank6  |
                     Core23_Ack_Bank7  | Core23_Ack_Bank8  | Core23_Ack_Bank9  | Core23_Ack_Bank10 | Core23_Ack_Bank11 | Core23_Ack_Bank12 | Core23_Ack_Bank13 |
					 Core23_Ack_Bank14 | Core23_Ack_Bank15  ;

  assign Core24_Ack = Core24_Ack_Bank0  | Core24_Ack_Bank1  | Core24_Ack_Bank2  | Core24_Ack_Bank3  | Core24_Ack_Bank4  | Core24_Ack_Bank5  | Core24_Ack_Bank6  |
                     Core24_Ack_Bank7  | Core24_Ack_Bank8  | Core24_Ack_Bank9  | Core24_Ack_Bank10 | Core24_Ack_Bank11 | Core24_Ack_Bank12 | Core24_Ack_Bank13 |
					 Core24_Ack_Bank14 | Core24_Ack_Bank15  ;

  assign Core25_Ack = Core25_Ack_Bank0  | Core25_Ack_Bank1  | Core25_Ack_Bank2  | Core25_Ack_Bank3  | Core25_Ack_Bank4  | Core25_Ack_Bank5  | Core25_Ack_Bank6  |
                     Core25_Ack_Bank7  | Core25_Ack_Bank8  | Core25_Ack_Bank9  | Core25_Ack_Bank10 | Core25_Ack_Bank11 | Core25_Ack_Bank12 | Core25_Ack_Bank13 |
					 Core25_Ack_Bank14 | Core25_Ack_Bank15  ;

  assign Core26_Ack = Core26_Ack_Bank0  | Core26_Ack_Bank1  | Core26_Ack_Bank2  | Core26_Ack_Bank3  | Core26_Ack_Bank4  | Core26_Ack_Bank5  | Core26_Ack_Bank6  |
                     Core26_Ack_Bank7  | Core26_Ack_Bank8  | Core26_Ack_Bank9  | Core26_Ack_Bank10 | Core26_Ack_Bank11 | Core26_Ack_Bank12 | Core26_Ack_Bank13 |
					 Core26_Ack_Bank14 | Core26_Ack_Bank15  ;

  assign Core27_Ack = Core27_Ack_Bank0  | Core27_Ack_Bank1  | Core27_Ack_Bank2  | Core27_Ack_Bank3  | Core27_Ack_Bank4  | Core27_Ack_Bank5  | Core27_Ack_Bank6  |
                     Core27_Ack_Bank7  | Core27_Ack_Bank8  | Core27_Ack_Bank9  | Core27_Ack_Bank10 | Core27_Ack_Bank11 | Core27_Ack_Bank12 | Core27_Ack_Bank13 |
					 Core27_Ack_Bank14 | Core27_Ack_Bank15  ;

  assign Core28_Ack = Core28_Ack_Bank0  | Core28_Ack_Bank1  | Core28_Ack_Bank2  | Core28_Ack_Bank3  | Core28_Ack_Bank4  | Core28_Ack_Bank5  | Core28_Ack_Bank6  |
                     Core28_Ack_Bank7  | Core28_Ack_Bank8  | Core28_Ack_Bank9  | Core28_Ack_Bank10 | Core28_Ack_Bank11 | Core28_Ack_Bank12 | Core28_Ack_Bank13 |
					 Core28_Ack_Bank14 | Core28_Ack_Bank15  ;

  assign Core29_Ack = Core29_Ack_Bank0  | Core29_Ack_Bank1  | Core29_Ack_Bank2  | Core29_Ack_Bank3  | Core29_Ack_Bank4  | Core29_Ack_Bank5  | Core29_Ack_Bank6  |
                     Core29_Ack_Bank7  | Core29_Ack_Bank8  | Core29_Ack_Bank9  | Core29_Ack_Bank10 | Core29_Ack_Bank11 | Core29_Ack_Bank12 | Core29_Ack_Bank13 |
					 Core29_Ack_Bank14 | Core29_Ack_Bank15  ;

  assign Core30_Ack = Core30_Ack_Bank0  | Core30_Ack_Bank1  | Core30_Ack_Bank2  | Core30_Ack_Bank3  | Core30_Ack_Bank4  | Core30_Ack_Bank5  | Core30_Ack_Bank6  |
                     Core30_Ack_Bank7  | Core30_Ack_Bank8  | Core30_Ack_Bank9  | Core30_Ack_Bank10 | Core30_Ack_Bank11 | Core30_Ack_Bank12 | Core30_Ack_Bank13 |
					 Core30_Ack_Bank14 | Core30_Ack_Bank15  ;

  assign Core31_Ack = Core31_Ack_Bank0  | Core31_Ack_Bank1  | Core31_Ack_Bank2  | Core31_Ack_Bank3  | Core31_Ack_Bank4  | Core31_Ack_Bank5  | Core31_Ack_Bank6  |
                     Core31_Ack_Bank7  | Core31_Ack_Bank8  | Core31_Ack_Bank9  | Core31_Ack_Bank10 | Core31_Ack_Bank11 | Core31_Ack_Bank12 | Core31_Ack_Bank13 |
					 Core31_Ack_Bank14 | Core31_Ack_Bank15  ;



  
  assign Core0_DataOut = Core0_B0_DataOut | Core0_B1_DataOut | Core0_B2_DataOut | Core0_B3_DataOut | Core0_B4_DataOut | Core0_B5_DataOut | Core0_B6_DataOut | Core0_B7_DataOut |
              Core0_B8_DataOut | Core0_B9_DataOut | Core0_B10_DataOut| Core0_B11_DataOut| Core0_B12_DataOut| Core0_B13_DataOut| Core0_B14_DataOut| Core0_B15_DataOut;
  assign Core1_DataOut = Core1_B0_DataOut | Core1_B1_DataOut | Core1_B2_DataOut | Core1_B3_DataOut | Core1_B4_DataOut | Core1_B5_DataOut | Core1_B6_DataOut | Core1_B7_DataOut |
              Core1_B8_DataOut | Core1_B9_DataOut | Core1_B10_DataOut| Core1_B11_DataOut| Core1_B12_DataOut| Core1_B13_DataOut| Core1_B14_DataOut| Core1_B15_DataOut;
  assign Core2_DataOut = Core2_B0_DataOut | Core2_B1_DataOut | Core2_B2_DataOut | Core2_B3_DataOut | Core2_B4_DataOut | Core2_B5_DataOut | Core2_B6_DataOut | Core2_B7_DataOut |
              Core2_B8_DataOut | Core2_B9_DataOut | Core2_B10_DataOut| Core2_B11_DataOut| Core2_B12_DataOut| Core2_B13_DataOut| Core2_B14_DataOut| Core2_B15_DataOut;
  assign Core3_DataOut = Core3_B0_DataOut | Core3_B1_DataOut | Core3_B2_DataOut | Core3_B3_DataOut | Core3_B4_DataOut | Core3_B5_DataOut | Core3_B6_DataOut | Core3_B7_DataOut |
              Core3_B8_DataOut | Core3_B9_DataOut | Core3_B10_DataOut| Core3_B11_DataOut| Core3_B12_DataOut| Core3_B13_DataOut| Core3_B14_DataOut| Core3_B15_DataOut;
  assign Core4_DataOut = Core4_B0_DataOut | Core4_B1_DataOut | Core4_B2_DataOut | Core4_B3_DataOut | Core4_B4_DataOut | Core4_B5_DataOut | Core4_B6_DataOut | Core4_B7_DataOut |
              Core4_B8_DataOut | Core4_B9_DataOut | Core4_B10_DataOut| Core4_B11_DataOut| Core4_B12_DataOut| Core4_B13_DataOut| Core4_B14_DataOut| Core4_B15_DataOut;
  assign Core5_DataOut = Core5_B0_DataOut | Core5_B1_DataOut | Core5_B2_DataOut | Core5_B3_DataOut | Core5_B4_DataOut | Core5_B5_DataOut | Core5_B6_DataOut | Core5_B7_DataOut |
              Core5_B8_DataOut | Core5_B9_DataOut | Core5_B10_DataOut| Core5_B11_DataOut| Core5_B12_DataOut| Core5_B13_DataOut| Core5_B14_DataOut| Core5_B15_DataOut;
  assign Core6_DataOut = Core6_B0_DataOut | Core6_B1_DataOut | Core6_B2_DataOut | Core6_B3_DataOut | Core6_B4_DataOut | Core6_B5_DataOut | Core6_B6_DataOut | Core6_B7_DataOut |
              Core6_B8_DataOut | Core6_B9_DataOut | Core6_B10_DataOut| Core6_B11_DataOut| Core6_B12_DataOut| Core6_B13_DataOut| Core6_B14_DataOut| Core6_B15_DataOut;
  assign Core7_DataOut = Core7_B0_DataOut | Core7_B1_DataOut | Core7_B2_DataOut | Core7_B3_DataOut | Core7_B4_DataOut | Core7_B5_DataOut | Core7_B6_DataOut | Core7_B7_DataOut |
              Core7_B8_DataOut | Core7_B9_DataOut | Core7_B10_DataOut| Core7_B11_DataOut| Core7_B12_DataOut| Core7_B13_DataOut| Core7_B14_DataOut| Core7_B15_DataOut;
  assign Core8_DataOut = Core8_B0_DataOut | Core8_B1_DataOut | Core8_B2_DataOut | Core8_B3_DataOut | Core8_B4_DataOut | Core8_B5_DataOut | Core8_B6_DataOut | Core8_B7_DataOut |
              Core8_B8_DataOut | Core8_B9_DataOut | Core8_B10_DataOut| Core8_B11_DataOut| Core8_B12_DataOut| Core8_B13_DataOut| Core8_B14_DataOut| Core8_B15_DataOut;
  assign Core9_DataOut = Core9_B0_DataOut | Core9_B1_DataOut | Core9_B2_DataOut | Core9_B3_DataOut | Core9_B4_DataOut | Core9_B5_DataOut | Core9_B6_DataOut | Core9_B7_DataOut |
              Core9_B8_DataOut | Core9_B9_DataOut | Core9_B10_DataOut| Core9_B11_DataOut| Core9_B12_DataOut| Core9_B13_DataOut| Core9_B14_DataOut| Core9_B15_DataOut;
  assign Core10_DataOut = Core10_B0_DataOut | Core10_B1_DataOut | Core10_B2_DataOut | Core10_B3_DataOut | Core10_B4_DataOut | Core10_B5_DataOut | Core10_B6_DataOut | Core10_B7_DataOut |
              Core10_B8_DataOut | Core10_B9_DataOut | Core10_B10_DataOut| Core10_B11_DataOut| Core10_B12_DataOut| Core10_B13_DataOut| Core10_B14_DataOut| Core10_B15_DataOut;
  assign Core11_DataOut = Core11_B0_DataOut | Core11_B1_DataOut | Core11_B2_DataOut | Core11_B3_DataOut | Core11_B4_DataOut | Core11_B5_DataOut | Core11_B6_DataOut | Core11_B7_DataOut |
              Core11_B8_DataOut | Core11_B9_DataOut | Core11_B10_DataOut| Core11_B11_DataOut| Core11_B12_DataOut| Core11_B13_DataOut| Core11_B14_DataOut| Core11_B15_DataOut;
  assign Core12_DataOut = Core12_B0_DataOut | Core12_B1_DataOut | Core12_B2_DataOut | Core12_B3_DataOut | Core12_B4_DataOut | Core12_B5_DataOut | Core12_B6_DataOut | Core12_B7_DataOut |
              Core12_B8_DataOut | Core12_B9_DataOut | Core12_B10_DataOut| Core12_B11_DataOut| Core12_B12_DataOut| Core12_B13_DataOut| Core12_B14_DataOut| Core12_B15_DataOut;
  assign Core13_DataOut = Core13_B0_DataOut | Core13_B1_DataOut | Core13_B2_DataOut | Core13_B3_DataOut | Core13_B4_DataOut | Core13_B5_DataOut | Core13_B6_DataOut | Core13_B7_DataOut |
              Core13_B8_DataOut | Core13_B9_DataOut | Core13_B10_DataOut| Core13_B11_DataOut| Core13_B12_DataOut| Core13_B13_DataOut| Core13_B14_DataOut| Core13_B15_DataOut;
  assign Core14_DataOut = Core14_B0_DataOut | Core14_B1_DataOut | Core14_B2_DataOut | Core14_B3_DataOut | Core14_B4_DataOut | Core14_B5_DataOut | Core14_B6_DataOut | Core14_B7_DataOut |
              Core14_B8_DataOut | Core14_B9_DataOut | Core14_B10_DataOut| Core14_B11_DataOut| Core14_B12_DataOut| Core14_B13_DataOut| Core14_B14_DataOut| Core14_B15_DataOut;
  assign Core15_DataOut = Core15_B0_DataOut | Core15_B1_DataOut | Core15_B2_DataOut | Core15_B3_DataOut | Core15_B4_DataOut | Core15_B5_DataOut | Core15_B6_DataOut | Core15_B7_DataOut |
              Core15_B8_DataOut | Core15_B9_DataOut | Core15_B10_DataOut| Core15_B11_DataOut| Core15_B12_DataOut| Core15_B13_DataOut| Core15_B14_DataOut| Core15_B15_DataOut;
  assign Core16_DataOut = Core16_B0_DataOut | Core16_B1_DataOut | Core16_B2_DataOut | Core16_B3_DataOut | Core16_B4_DataOut | Core16_B5_DataOut | Core16_B6_DataOut | Core16_B7_DataOut |
              Core16_B8_DataOut | Core16_B9_DataOut | Core16_B10_DataOut| Core16_B11_DataOut| Core16_B12_DataOut| Core16_B13_DataOut| Core16_B14_DataOut| Core16_B15_DataOut;
  assign Core17_DataOut = Core17_B0_DataOut | Core17_B1_DataOut | Core17_B2_DataOut | Core17_B3_DataOut | Core17_B4_DataOut | Core17_B5_DataOut | Core17_B6_DataOut | Core17_B7_DataOut |
              Core17_B8_DataOut | Core17_B9_DataOut | Core17_B10_DataOut| Core17_B11_DataOut| Core17_B12_DataOut| Core17_B13_DataOut| Core17_B14_DataOut| Core17_B15_DataOut;
  assign Core18_DataOut = Core18_B0_DataOut | Core18_B1_DataOut | Core18_B2_DataOut | Core18_B3_DataOut | Core18_B4_DataOut | Core18_B5_DataOut | Core18_B6_DataOut | Core18_B7_DataOut |
              Core18_B8_DataOut | Core18_B9_DataOut | Core18_B10_DataOut| Core18_B11_DataOut| Core18_B12_DataOut| Core18_B13_DataOut| Core18_B14_DataOut| Core18_B15_DataOut;
  assign Core19_DataOut = Core19_B0_DataOut | Core19_B1_DataOut | Core19_B2_DataOut | Core19_B3_DataOut | Core19_B4_DataOut | Core19_B5_DataOut | Core19_B6_DataOut | Core19_B7_DataOut |
              Core19_B8_DataOut | Core19_B9_DataOut | Core19_B10_DataOut| Core19_B11_DataOut| Core19_B12_DataOut| Core19_B13_DataOut| Core19_B14_DataOut| Core19_B15_DataOut;
  assign Core20_DataOut = Core20_B0_DataOut | Core20_B1_DataOut | Core20_B2_DataOut | Core20_B3_DataOut | Core20_B4_DataOut | Core20_B5_DataOut | Core20_B6_DataOut | Core20_B7_DataOut |
              Core20_B8_DataOut | Core20_B9_DataOut | Core20_B10_DataOut| Core20_B11_DataOut| Core20_B12_DataOut| Core20_B13_DataOut| Core20_B14_DataOut| Core20_B15_DataOut;
  assign Core21_DataOut = Core21_B0_DataOut | Core21_B1_DataOut | Core21_B2_DataOut | Core21_B3_DataOut | Core21_B4_DataOut | Core21_B5_DataOut | Core21_B6_DataOut | Core21_B7_DataOut |
              Core21_B8_DataOut | Core21_B9_DataOut | Core21_B10_DataOut| Core21_B11_DataOut| Core21_B12_DataOut| Core21_B13_DataOut| Core21_B14_DataOut| Core21_B15_DataOut;
  assign Core22_DataOut = Core22_B0_DataOut | Core22_B1_DataOut | Core22_B2_DataOut | Core22_B3_DataOut | Core22_B4_DataOut | Core22_B5_DataOut | Core22_B6_DataOut | Core22_B7_DataOut |
              Core22_B8_DataOut | Core22_B9_DataOut | Core22_B10_DataOut| Core22_B11_DataOut| Core22_B12_DataOut| Core22_B13_DataOut| Core22_B14_DataOut| Core22_B15_DataOut;
  assign Core23_DataOut = Core23_B0_DataOut | Core23_B1_DataOut | Core23_B2_DataOut | Core23_B3_DataOut | Core23_B4_DataOut | Core23_B5_DataOut | Core23_B6_DataOut | Core23_B7_DataOut |
              Core23_B8_DataOut | Core23_B9_DataOut | Core23_B10_DataOut| Core23_B11_DataOut| Core23_B12_DataOut| Core23_B13_DataOut| Core23_B14_DataOut| Core23_B15_DataOut;
  assign Core24_DataOut = Core24_B0_DataOut | Core24_B1_DataOut | Core24_B2_DataOut | Core24_B3_DataOut | Core24_B4_DataOut | Core24_B5_DataOut | Core24_B6_DataOut | Core24_B7_DataOut |
              Core24_B8_DataOut | Core24_B9_DataOut | Core24_B10_DataOut| Core24_B11_DataOut| Core24_B12_DataOut| Core24_B13_DataOut| Core24_B14_DataOut| Core24_B15_DataOut;
  assign Core25_DataOut = Core25_B0_DataOut | Core25_B1_DataOut | Core25_B2_DataOut | Core25_B3_DataOut | Core25_B4_DataOut | Core25_B5_DataOut | Core25_B6_DataOut | Core25_B7_DataOut |
              Core25_B8_DataOut | Core25_B9_DataOut | Core25_B10_DataOut| Core25_B11_DataOut| Core25_B12_DataOut| Core25_B13_DataOut| Core25_B14_DataOut| Core25_B15_DataOut;
  assign Core26_DataOut = Core26_B0_DataOut | Core26_B1_DataOut | Core26_B2_DataOut | Core26_B3_DataOut | Core26_B4_DataOut | Core26_B5_DataOut | Core26_B6_DataOut | Core26_B7_DataOut |
              Core26_B8_DataOut | Core26_B9_DataOut | Core26_B10_DataOut| Core26_B11_DataOut| Core26_B12_DataOut| Core26_B13_DataOut| Core26_B14_DataOut| Core26_B15_DataOut;
  assign Core27_DataOut = Core27_B0_DataOut | Core27_B1_DataOut | Core27_B2_DataOut | Core27_B3_DataOut | Core27_B4_DataOut | Core27_B5_DataOut | Core27_B6_DataOut | Core27_B7_DataOut |
              Core27_B8_DataOut | Core27_B9_DataOut | Core27_B10_DataOut| Core27_B11_DataOut| Core27_B12_DataOut| Core27_B13_DataOut| Core27_B14_DataOut| Core27_B15_DataOut;
  assign Core28_DataOut = Core28_B0_DataOut | Core28_B1_DataOut | Core28_B2_DataOut | Core28_B3_DataOut | Core28_B4_DataOut | Core28_B5_DataOut | Core28_B6_DataOut | Core28_B7_DataOut |
              Core28_B8_DataOut | Core28_B9_DataOut | Core28_B10_DataOut| Core28_B11_DataOut| Core28_B12_DataOut| Core28_B13_DataOut| Core28_B14_DataOut| Core28_B15_DataOut;
  assign Core29_DataOut = Core29_B0_DataOut | Core29_B1_DataOut | Core29_B2_DataOut | Core29_B3_DataOut | Core29_B4_DataOut | Core29_B5_DataOut | Core29_B6_DataOut | Core29_B7_DataOut |
              Core29_B8_DataOut | Core29_B9_DataOut | Core29_B10_DataOut| Core29_B11_DataOut| Core29_B12_DataOut| Core29_B13_DataOut| Core29_B14_DataOut| Core29_B15_DataOut;
  assign Core30_DataOut = Core30_B0_DataOut | Core30_B1_DataOut | Core30_B2_DataOut | Core30_B3_DataOut | Core30_B4_DataOut | Core30_B5_DataOut | Core30_B6_DataOut | Core30_B7_DataOut |
              Core30_B8_DataOut | Core30_B9_DataOut | Core30_B10_DataOut| Core30_B11_DataOut| Core30_B12_DataOut| Core30_B13_DataOut| Core30_B14_DataOut| Core30_B15_DataOut;
  assign Core31_DataOut = Core31_B0_DataOut | Core31_B1_DataOut | Core31_B2_DataOut | Core31_B3_DataOut | Core31_B4_DataOut | Core31_B5_DataOut | Core31_B6_DataOut | Core31_B7_DataOut |
              Core31_B8_DataOut | Core31_B9_DataOut | Core31_B10_DataOut| Core31_B11_DataOut| Core31_B12_DataOut| Core31_B13_DataOut| Core31_B14_DataOut| Core31_B15_DataOut;



  //---- Demux the request to chanelize the banks(31 x 16) ----
   Demux u0_demux (
              .in(Core0_Req), 
              .sel(Core0_AddressIn[3:0]),
              .Out0 (Core0_Req_Bank0),  .Out1 (Core0_Req_Bank1),  .Out2 (Core0_Req_Bank2),  .Out3 (Core0_Req_Bank3),  .Out4 (Core0_Req_Bank4),
              .Out5 (Core0_Req_Bank5),  .Out6 (Core0_Req_Bank6),  .Out7 (Core0_Req_Bank7),  .Out8 (Core0_Req_Bank8),  .Out9 (Core0_Req_Bank9),
              .Out10(Core0_Req_Bank10), .Out11(Core0_Req_Bank11), .Out12(Core0_Req_Bank12), .Out13(Core0_Req_Bank13), .Out14(Core0_Req_Bank14),
              .Out15(Core0_Req_Bank15)
          ) ;
   Demux u1_demux (
              .in(Core1_Req), 
              .sel(Core1_AddressIn[3:0]),
              .Out0 (Core1_Req_Bank0),  .Out1 (Core1_Req_Bank1),  .Out2 (Core1_Req_Bank2),  .Out3 (Core1_Req_Bank3),  .Out4 (Core1_Req_Bank4),
              .Out5 (Core1_Req_Bank5),  .Out6 (Core1_Req_Bank6),  .Out7 (Core1_Req_Bank7),  .Out8 (Core1_Req_Bank8),  .Out9 (Core1_Req_Bank9),
              .Out10(Core1_Req_Bank10), .Out11(Core1_Req_Bank11), .Out12(Core1_Req_Bank12), .Out13(Core1_Req_Bank13), .Out14(Core1_Req_Bank14),
              .Out15(Core1_Req_Bank15)
          ) ;
   Demux u2_demux (
              .in(Core2_Req), 
              .sel(Core2_AddressIn[3:0]),
              .Out0 (Core2_Req_Bank0),  .Out1 (Core2_Req_Bank1),  .Out2 (Core2_Req_Bank2),  .Out3 (Core2_Req_Bank3),  .Out4 (Core2_Req_Bank4),
              .Out5 (Core2_Req_Bank5),  .Out6 (Core2_Req_Bank6),  .Out7 (Core2_Req_Bank7),  .Out8 (Core2_Req_Bank8),  .Out9 (Core2_Req_Bank9),
              .Out10(Core2_Req_Bank10), .Out11(Core2_Req_Bank11), .Out12(Core2_Req_Bank12), .Out13(Core2_Req_Bank13), .Out14(Core2_Req_Bank14),
              .Out15(Core2_Req_Bank15)
          ) ;
   Demux u3_demux (
              .in(Core3_Req), 
              .sel(Core3_AddressIn[3:0]),
              .Out0 (Core3_Req_Bank0),  .Out1 (Core3_Req_Bank1),  .Out2 (Core3_Req_Bank2),  .Out3 (Core3_Req_Bank3),  .Out4 (Core3_Req_Bank4),
              .Out5 (Core3_Req_Bank5),  .Out6 (Core3_Req_Bank6),  .Out7 (Core3_Req_Bank7),  .Out8 (Core3_Req_Bank8),  .Out9 (Core3_Req_Bank9),
              .Out10(Core3_Req_Bank10), .Out11(Core3_Req_Bank11), .Out12(Core3_Req_Bank12), .Out13(Core3_Req_Bank13), .Out14(Core3_Req_Bank14),
              .Out15(Core3_Req_Bank15)
          ) ;
   Demux u4_demux (
              .in(Core4_Req), 
              .sel(Core4_AddressIn[3:0]),
              .Out0 (Core4_Req_Bank0),  .Out1 (Core4_Req_Bank1),  .Out2 (Core4_Req_Bank2),  .Out3 (Core4_Req_Bank3),  .Out4 (Core4_Req_Bank4),
              .Out5 (Core4_Req_Bank5),  .Out6 (Core4_Req_Bank6),  .Out7 (Core4_Req_Bank7),  .Out8 (Core4_Req_Bank8),  .Out9 (Core4_Req_Bank9),
              .Out10(Core4_Req_Bank10), .Out11(Core4_Req_Bank11), .Out12(Core4_Req_Bank12), .Out13(Core4_Req_Bank13), .Out14(Core4_Req_Bank14),
              .Out15(Core4_Req_Bank15)
          ) ;

   Demux u5_demux (
              .in(Core5_Req), 
              .sel(Core5_AddressIn[3:0]),
              .Out0 (Core5_Req_Bank0),  .Out1 (Core5_Req_Bank1),  .Out2 (Core5_Req_Bank2),  .Out3 (Core5_Req_Bank3),  .Out4 (Core5_Req_Bank4),
              .Out5 (Core5_Req_Bank5),  .Out6 (Core5_Req_Bank6),  .Out7 (Core5_Req_Bank7),  .Out8 (Core5_Req_Bank8),  .Out9 (Core5_Req_Bank9),
              .Out10(Core5_Req_Bank10), .Out11(Core5_Req_Bank11), .Out12(Core5_Req_Bank12), .Out13(Core5_Req_Bank13), .Out14(Core5_Req_Bank14),
              .Out15(Core5_Req_Bank15)
          ) ;
   Demux u6_demux (
              .in(Core6_Req), 
              .sel(Core6_AddressIn[3:0]),
              .Out0 (Core6_Req_Bank0),  .Out1 (Core6_Req_Bank1),  .Out2 (Core6_Req_Bank2),  .Out3 (Core6_Req_Bank3),  .Out4 (Core6_Req_Bank4),
              .Out5 (Core6_Req_Bank5),  .Out6 (Core6_Req_Bank6),  .Out7 (Core6_Req_Bank7),  .Out8 (Core6_Req_Bank8),  .Out9 (Core6_Req_Bank9),
              .Out10(Core6_Req_Bank10), .Out11(Core6_Req_Bank11), .Out12(Core6_Req_Bank12), .Out13(Core6_Req_Bank13), .Out14(Core6_Req_Bank14),
              .Out15(Core6_Req_Bank15)
          ) ;
   Demux u7_demux (
              .in(Core7_Req), 
              .sel(Core7_AddressIn[3:0]),
              .Out0 (Core7_Req_Bank0),  .Out1 (Core7_Req_Bank1),  .Out2 (Core7_Req_Bank2),  .Out3 (Core7_Req_Bank3),  .Out4 (Core7_Req_Bank4),
              .Out5 (Core7_Req_Bank5),  .Out6 (Core7_Req_Bank6),  .Out7 (Core7_Req_Bank7),  .Out8 (Core7_Req_Bank8),  .Out9 (Core7_Req_Bank9),
              .Out10(Core7_Req_Bank10), .Out11(Core7_Req_Bank11), .Out12(Core7_Req_Bank12), .Out13(Core7_Req_Bank13), .Out14(Core7_Req_Bank14),
              .Out15(Core7_Req_Bank15)
          ) ;
   Demux u8_demux (
              .in(Core8_Req), 
              .sel(Core8_AddressIn[3:0]),
              .Out0 (Core8_Req_Bank0),  .Out1 (Core8_Req_Bank1),  .Out2 (Core8_Req_Bank2),  .Out3 (Core8_Req_Bank3),  .Out4 (Core8_Req_Bank4),
              .Out5 (Core8_Req_Bank5),  .Out6 (Core8_Req_Bank6),  .Out7 (Core8_Req_Bank7),  .Out8 (Core8_Req_Bank8),  .Out9 (Core8_Req_Bank9),
              .Out10(Core8_Req_Bank10), .Out11(Core8_Req_Bank11), .Out12(Core8_Req_Bank12), .Out13(Core8_Req_Bank13), .Out14(Core8_Req_Bank14),
              .Out15(Core8_Req_Bank15)
          ) ;
   Demux u9_demux (
              .in(Core9_Req), 
              .sel(Core9_AddressIn[3:0]),
              .Out0 (Core9_Req_Bank0),  .Out1 (Core9_Req_Bank1),  .Out2 (Core9_Req_Bank2),  .Out3 (Core9_Req_Bank3),  .Out4 (Core9_Req_Bank4),
              .Out5 (Core9_Req_Bank5),  .Out6 (Core9_Req_Bank6),  .Out7 (Core9_Req_Bank7),  .Out8 (Core9_Req_Bank8),  .Out9 (Core9_Req_Bank9),
              .Out10(Core9_Req_Bank10), .Out11(Core9_Req_Bank11), .Out12(Core9_Req_Bank12), .Out13(Core9_Req_Bank13), .Out14(Core9_Req_Bank14),
              .Out15(Core9_Req_Bank15)
          ) ;
   Demux u10_demux (
              .in(Core10_Req), 
              .sel(Core10_AddressIn[3:0]),
              .Out0 (Core10_Req_Bank0),  .Out1 (Core10_Req_Bank1),  .Out2 (Core10_Req_Bank2),  .Out3 (Core10_Req_Bank3),  .Out4 (Core10_Req_Bank4),
              .Out5 (Core10_Req_Bank5),  .Out6 (Core10_Req_Bank6),  .Out7 (Core10_Req_Bank7),  .Out8 (Core10_Req_Bank8),  .Out9 (Core10_Req_Bank9),
              .Out10(Core10_Req_Bank10), .Out11(Core10_Req_Bank11), .Out12(Core10_Req_Bank12), .Out13(Core10_Req_Bank13), .Out14(Core10_Req_Bank14),
              .Out15(Core10_Req_Bank15)
          ) ;
   Demux u11_demux (
              .in(Core11_Req), 
              .sel(Core11_AddressIn[3:0]),
              .Out0 (Core11_Req_Bank0),  .Out1 (Core11_Req_Bank1),  .Out2 (Core11_Req_Bank2),  .Out3 (Core11_Req_Bank3),  .Out4 (Core11_Req_Bank4),
              .Out5 (Core11_Req_Bank5),  .Out6 (Core11_Req_Bank6),  .Out7 (Core11_Req_Bank7),  .Out8 (Core11_Req_Bank8),  .Out9 (Core11_Req_Bank9),
              .Out10(Core11_Req_Bank10), .Out11(Core11_Req_Bank11), .Out12(Core11_Req_Bank12), .Out13(Core11_Req_Bank13), .Out14(Core11_Req_Bank14),
              .Out15(Core11_Req_Bank15)
          ) ;
   Demux u12_demux (
              .in(Core12_Req), 
              .sel(Core12_AddressIn[3:0]),
              .Out0 (Core12_Req_Bank0),  .Out1 (Core12_Req_Bank1),  .Out2 (Core12_Req_Bank2),  .Out3 (Core12_Req_Bank3),  .Out4 (Core12_Req_Bank4),
              .Out5 (Core12_Req_Bank5),  .Out6 (Core12_Req_Bank6),  .Out7 (Core12_Req_Bank7),  .Out8 (Core12_Req_Bank8),  .Out9 (Core12_Req_Bank9),
              .Out10(Core12_Req_Bank10), .Out11(Core12_Req_Bank11), .Out12(Core12_Req_Bank12), .Out13(Core12_Req_Bank13), .Out14(Core12_Req_Bank14),
              .Out15(Core12_Req_Bank15)
          ) ;
    Demux u13_demux (
              .in(Core13_Req), 
              .sel(Core13_AddressIn[3:0]),
              .Out0 (Core13_Req_Bank0),  .Out1 (Core13_Req_Bank1),  .Out2 (Core13_Req_Bank2),  .Out3 (Core13_Req_Bank3),  .Out4 (Core13_Req_Bank4),
              .Out5 (Core13_Req_Bank5),  .Out6 (Core13_Req_Bank6),  .Out7 (Core13_Req_Bank7),  .Out8 (Core13_Req_Bank8),  .Out9 (Core13_Req_Bank9),
              .Out10(Core13_Req_Bank10), .Out11(Core13_Req_Bank11), .Out12(Core13_Req_Bank12), .Out13(Core13_Req_Bank13), .Out14(Core13_Req_Bank14),
              .Out15(Core13_Req_Bank15)
          ) ;
  
   Demux u14_demux (
              .in(Core14_Req), 
              .sel(Core14_AddressIn[3:0]),
              .Out0 (Core14_Req_Bank0),  .Out1 (Core14_Req_Bank1),  .Out2 (Core14_Req_Bank2),  .Out3 (Core14_Req_Bank3),  .Out4 (Core14_Req_Bank4),
              .Out5 (Core14_Req_Bank5),  .Out6 (Core14_Req_Bank6),  .Out7 (Core14_Req_Bank7),  .Out8 (Core14_Req_Bank8),  .Out9 (Core14_Req_Bank9),
              .Out10(Core14_Req_Bank10), .Out11(Core14_Req_Bank11), .Out12(Core14_Req_Bank12), .Out13(Core14_Req_Bank13), .Out14(Core14_Req_Bank14),
              .Out15(Core14_Req_Bank15)
          ) ;
  
   Demux u15_demux (
              .in(Core15_Req), 
              .sel(Core15_AddressIn[3:0]),
              .Out0 (Core15_Req_Bank0),  .Out1 (Core15_Req_Bank1),  .Out2 (Core15_Req_Bank2),  .Out3 (Core15_Req_Bank3),  .Out4 (Core15_Req_Bank4),
              .Out5 (Core15_Req_Bank5),  .Out6 (Core15_Req_Bank6),  .Out7 (Core15_Req_Bank7),  .Out8 (Core15_Req_Bank8),  .Out9 (Core15_Req_Bank9),
              .Out10(Core15_Req_Bank10), .Out11(Core15_Req_Bank11), .Out12(Core15_Req_Bank12), .Out13(Core15_Req_Bank13), .Out14(Core15_Req_Bank14),
              .Out15(Core15_Req_Bank15)
          ) ;
  
   Demux u16_demux (
              .in(Core16_Req), 
              .sel(Core16_AddressIn[3:0]),
              .Out0 (Core16_Req_Bank0),  .Out1 (Core16_Req_Bank1),  .Out2 (Core16_Req_Bank2),  .Out3 (Core16_Req_Bank3),  .Out4 (Core16_Req_Bank4),
              .Out5 (Core16_Req_Bank5),  .Out6 (Core16_Req_Bank6),  .Out7 (Core16_Req_Bank7),  .Out8 (Core16_Req_Bank8),  .Out9 (Core16_Req_Bank9),
              .Out10(Core16_Req_Bank10), .Out11(Core16_Req_Bank11), .Out12(Core16_Req_Bank12), .Out13(Core16_Req_Bank13), .Out14(Core16_Req_Bank14),
              .Out15(Core16_Req_Bank15)
          ) ;
  
   Demux u17_demux (
              .in(Core17_Req), 
              .sel(Core17_AddressIn[3:0]),
              .Out0 (Core17_Req_Bank0),  .Out1 (Core17_Req_Bank1),  .Out2 (Core17_Req_Bank2),  .Out3 (Core17_Req_Bank3),  .Out4 (Core17_Req_Bank4),
              .Out5 (Core17_Req_Bank5),  .Out6 (Core17_Req_Bank6),  .Out7 (Core17_Req_Bank7),  .Out8 (Core17_Req_Bank8),  .Out9 (Core17_Req_Bank9),
              .Out10(Core17_Req_Bank10), .Out11(Core17_Req_Bank11), .Out12(Core17_Req_Bank12), .Out13(Core17_Req_Bank13), .Out14(Core17_Req_Bank14),
              .Out15(Core17_Req_Bank15)
          ) ;
  
   Demux u18_demux (
              .in(Core18_Req), 
              .sel(Core18_AddressIn[3:0]),
              .Out0 (Core18_Req_Bank0),  .Out1 (Core18_Req_Bank1),  .Out2 (Core18_Req_Bank2),  .Out3 (Core18_Req_Bank3),  .Out4 (Core18_Req_Bank4),
              .Out5 (Core18_Req_Bank5),  .Out6 (Core18_Req_Bank6),  .Out7 (Core18_Req_Bank7),  .Out8 (Core18_Req_Bank8),  .Out9 (Core18_Req_Bank9),
              .Out10(Core18_Req_Bank10), .Out11(Core18_Req_Bank11), .Out12(Core18_Req_Bank12), .Out13(Core18_Req_Bank13), .Out14(Core18_Req_Bank14),
              .Out15(Core18_Req_Bank15)
          ) ;
  
   Demux u19_demux (
              .in(Core19_Req), 
              .sel(Core19_AddressIn[3:0]),
              .Out0 (Core19_Req_Bank0),  .Out1 (Core19_Req_Bank1),  .Out2 (Core19_Req_Bank2),  .Out3 (Core19_Req_Bank3),  .Out4 (Core19_Req_Bank4),
              .Out5 (Core19_Req_Bank5),  .Out6 (Core19_Req_Bank6),  .Out7 (Core19_Req_Bank7),  .Out8 (Core19_Req_Bank8),  .Out9 (Core19_Req_Bank9),
              .Out10(Core19_Req_Bank10), .Out11(Core19_Req_Bank11), .Out12(Core19_Req_Bank12), .Out13(Core19_Req_Bank13), .Out14(Core19_Req_Bank14),
              .Out15(Core19_Req_Bank15)
          ) ;
  
   Demux u20_demux (
              .in(Core20_Req), 
              .sel(Core20_AddressIn[3:0]),
              .Out0 (Core20_Req_Bank0),  .Out1 (Core20_Req_Bank1),  .Out2 (Core20_Req_Bank2),  .Out3 (Core20_Req_Bank3),  .Out4 (Core20_Req_Bank4),
              .Out5 (Core20_Req_Bank5),  .Out6 (Core20_Req_Bank6),  .Out7 (Core20_Req_Bank7),  .Out8 (Core20_Req_Bank8),  .Out9 (Core20_Req_Bank9),
              .Out10(Core20_Req_Bank10), .Out11(Core20_Req_Bank11), .Out12(Core20_Req_Bank12), .Out13(Core20_Req_Bank13), .Out14(Core20_Req_Bank14),
              .Out15(Core20_Req_Bank15)
          ) ;
  
   Demux u21_demux (
              .in(Core21_Req), 
              .sel(Core21_AddressIn[3:0]),
              .Out0 (Core21_Req_Bank0),  .Out1 (Core21_Req_Bank1),  .Out2 (Core21_Req_Bank2),  .Out3 (Core21_Req_Bank3),  .Out4 (Core21_Req_Bank4),
              .Out5 (Core21_Req_Bank5),  .Out6 (Core21_Req_Bank6),  .Out7 (Core21_Req_Bank7),  .Out8 (Core21_Req_Bank8),  .Out9 (Core21_Req_Bank9),
              .Out10(Core21_Req_Bank10), .Out11(Core21_Req_Bank11), .Out12(Core21_Req_Bank12), .Out13(Core21_Req_Bank13), .Out14(Core21_Req_Bank14),
              .Out15(Core21_Req_Bank15)
          ) ;
  
   Demux u22_demux (
              .in(Core22_Req), 
              .sel(Core22_AddressIn[3:0]),
              .Out0 (Core22_Req_Bank0),  .Out1 (Core22_Req_Bank1),  .Out2 (Core22_Req_Bank2),  .Out3 (Core22_Req_Bank3),  .Out4 (Core22_Req_Bank4),
              .Out5 (Core22_Req_Bank5),  .Out6 (Core22_Req_Bank6),  .Out7 (Core22_Req_Bank7),  .Out8 (Core22_Req_Bank8),  .Out9 (Core22_Req_Bank9),
              .Out10(Core22_Req_Bank10), .Out11(Core22_Req_Bank11), .Out12(Core22_Req_Bank12), .Out13(Core22_Req_Bank13), .Out14(Core22_Req_Bank14),
              .Out15(Core22_Req_Bank15)
          ) ;
  
   Demux u23_demux (
              .in(Core23_Req), 
              .sel(Core23_AddressIn[3:0]),
              .Out0 (Core23_Req_Bank0),  .Out1 (Core23_Req_Bank1),  .Out2 (Core23_Req_Bank2),  .Out3 (Core23_Req_Bank3),  .Out4 (Core23_Req_Bank4),
              .Out5 (Core23_Req_Bank5),  .Out6 (Core23_Req_Bank6),  .Out7 (Core23_Req_Bank7),  .Out8 (Core23_Req_Bank8),  .Out9 (Core23_Req_Bank9),
              .Out10(Core23_Req_Bank10), .Out11(Core23_Req_Bank11), .Out12(Core23_Req_Bank12), .Out13(Core23_Req_Bank13), .Out14(Core23_Req_Bank14),
              .Out15(Core23_Req_Bank15)
          ) ;
  
   Demux u24_demux (
              .in(Core24_Req), 
              .sel(Core24_AddressIn[3:0]),
              .Out0 (Core24_Req_Bank0),  .Out1 (Core24_Req_Bank1),  .Out2 (Core24_Req_Bank2),  .Out3 (Core24_Req_Bank3),  .Out4 (Core24_Req_Bank4),
              .Out5 (Core24_Req_Bank5),  .Out6 (Core24_Req_Bank6),  .Out7 (Core24_Req_Bank7),  .Out8 (Core24_Req_Bank8),  .Out9 (Core24_Req_Bank9),
              .Out10(Core24_Req_Bank10), .Out11(Core24_Req_Bank11), .Out12(Core24_Req_Bank12), .Out13(Core24_Req_Bank13), .Out14(Core24_Req_Bank14),
              .Out15(Core24_Req_Bank15)
          ) ;
  
   Demux u25_demux (
              .in(Core25_Req), 
              .sel(Core25_AddressIn[3:0]),
              .Out0 (Core25_Req_Bank0),  .Out1 (Core25_Req_Bank1),  .Out2 (Core25_Req_Bank2),  .Out3 (Core25_Req_Bank3),  .Out4 (Core25_Req_Bank4),
              .Out5 (Core25_Req_Bank5),  .Out6 (Core25_Req_Bank6),  .Out7 (Core25_Req_Bank7),  .Out8 (Core25_Req_Bank8),  .Out9 (Core25_Req_Bank9),
              .Out10(Core25_Req_Bank10), .Out11(Core25_Req_Bank11), .Out12(Core25_Req_Bank12), .Out13(Core25_Req_Bank13), .Out14(Core25_Req_Bank14),
              .Out15(Core25_Req_Bank15)
          ) ;
    Demux u26_demux (
              .in(Core26_Req), 
              .sel(Core26_AddressIn[3:0]),
              .Out0 (Core26_Req_Bank0),  .Out1 (Core26_Req_Bank1),  .Out2 (Core26_Req_Bank2),  .Out3 (Core26_Req_Bank3),  .Out4 (Core26_Req_Bank4),
              .Out5 (Core26_Req_Bank5),  .Out6 (Core26_Req_Bank6),  .Out7 (Core26_Req_Bank7),  .Out8 (Core26_Req_Bank8),  .Out9 (Core26_Req_Bank9),
              .Out10(Core26_Req_Bank10), .Out11(Core26_Req_Bank11), .Out12(Core26_Req_Bank12), .Out13(Core26_Req_Bank13), .Out14(Core26_Req_Bank14),
              .Out15(Core26_Req_Bank15)
          ) ;
  
   Demux u27_demux (
              .in(Core27_Req), 
              .sel(Core27_AddressIn[3:0]),
              .Out0 (Core27_Req_Bank0),  .Out1 (Core27_Req_Bank1),  .Out2 (Core27_Req_Bank2),  .Out3 (Core27_Req_Bank3),  .Out4 (Core27_Req_Bank4),
              .Out5 (Core27_Req_Bank5),  .Out6 (Core27_Req_Bank6),  .Out7 (Core27_Req_Bank7),  .Out8 (Core27_Req_Bank8),  .Out9 (Core27_Req_Bank9),
              .Out10(Core27_Req_Bank10), .Out11(Core27_Req_Bank11), .Out12(Core27_Req_Bank12), .Out13(Core27_Req_Bank13), .Out14(Core27_Req_Bank14),
              .Out15(Core27_Req_Bank15)
          ) ;
  
   Demux u28_demux (
              .in(Core28_Req), 
              .sel(Core28_AddressIn[3:0]),
              .Out0 (Core28_Req_Bank0),  .Out1 (Core28_Req_Bank1),  .Out2 (Core28_Req_Bank2),  .Out3 (Core28_Req_Bank3),  .Out4 (Core28_Req_Bank4),
              .Out5 (Core28_Req_Bank5),  .Out6 (Core28_Req_Bank6),  .Out7 (Core28_Req_Bank7),  .Out8 (Core28_Req_Bank8),  .Out9 (Core28_Req_Bank9),
              .Out10(Core28_Req_Bank10), .Out11(Core28_Req_Bank11), .Out12(Core28_Req_Bank12), .Out13(Core28_Req_Bank13), .Out14(Core28_Req_Bank14),
              .Out15(Core28_Req_Bank15)
          ) ;
  
   Demux u29_demux (
              .in(Core29_Req), 
              .sel(Core29_AddressIn[3:0]),
              .Out0 (Core29_Req_Bank0),  .Out1 (Core29_Req_Bank1),  .Out2 (Core29_Req_Bank2),  .Out3 (Core29_Req_Bank3),  .Out4 (Core29_Req_Bank4),
              .Out5 (Core29_Req_Bank5),  .Out6 (Core29_Req_Bank6),  .Out7 (Core29_Req_Bank7),  .Out8 (Core29_Req_Bank8),  .Out9 (Core29_Req_Bank9),
              .Out10(Core29_Req_Bank10), .Out11(Core29_Req_Bank11), .Out12(Core29_Req_Bank12), .Out13(Core29_Req_Bank13), .Out14(Core29_Req_Bank14),
              .Out15(Core29_Req_Bank15)
          ) ;
  
   Demux u30_demux (
              .in(Core30_Req), 
              .sel(Core30_AddressIn[3:0]),
              .Out0 (Core30_Req_Bank0),  .Out1 (Core30_Req_Bank1),  .Out2 (Core30_Req_Bank2),  .Out3 (Core30_Req_Bank3),  .Out4 (Core30_Req_Bank4),
              .Out5 (Core30_Req_Bank5),  .Out6 (Core30_Req_Bank6),  .Out7 (Core30_Req_Bank7),  .Out8 (Core30_Req_Bank8),  .Out9 (Core30_Req_Bank9),
              .Out10(Core30_Req_Bank10), .Out11(Core30_Req_Bank11), .Out12(Core30_Req_Bank12), .Out13(Core30_Req_Bank13), .Out14(Core30_Req_Bank14),
              .Out15(Core30_Req_Bank15)
          ) ;
  
   Demux u31_demux (
              .in(Core31_Req), 
              .sel(Core31_AddressIn[3:0]),
              .Out0 (Core31_Req_Bank0),  .Out1 (Core31_Req_Bank1),  .Out2 (Core31_Req_Bank2),  .Out3 (Core31_Req_Bank3),  .Out4 (Core31_Req_Bank4),
              .Out5 (Core31_Req_Bank5),  .Out6 (Core31_Req_Bank6),  .Out7 (Core31_Req_Bank7),  .Out8 (Core31_Req_Bank8),  .Out9 (Core31_Req_Bank9),
              .Out10(Core31_Req_Bank10), .Out11(Core31_Req_Bank11), .Out12(Core31_Req_Bank12), .Out13(Core31_Req_Bank13), .Out14(Core31_Req_Bank14),
              .Out15(Core31_Req_Bank15)
          ) ;
  
  
  
  

  //---- Arbiter Instances -------
   arbiter  u_arbiter0 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0(Core0_Req_Bank0),.Req1 (Core1_Req_Bank0 ),.Req2 (Core2_Req_Bank0),.Req3 (Core3_Req_Bank0 ),.Req4 (Core4_Req_Bank0), 
						.Req5 (Core5_Req_Bank0 ), .Req6 (Core6_Req_Bank0 ), .Req7 (Core7_Req_Bank0 ), .Req8 (Core8_Req_Bank0 ), .Req9 (Core9_Req_Bank0 ),
                        .Req10(Core10_Req_Bank0), .Req11(Core11_Req_Bank0), .Req12(Core12_Req_Bank0), .Req13(Core13_Req_Bank0), .Req14(Core14_Req_Bank0),
						.Req15(Core15_Req_Bank0), .Req16(Core16_Req_Bank0), .Req17(Core17_Req_Bank0), .Req18(Core18_Req_Bank0), .Req19(Core19_Req_Bank0),
                        .Req20(Core20_Req_Bank0), .Req21(Core21_Req_Bank0), .Req22(Core22_Req_Bank0), .Req23(Core23_Req_Bank0), .Req24(Core24_Req_Bank0), 
						.Req25(Core25_Req_Bank0), .Req26(Core26_Req_Bank0), .Req27(Core27_Req_Bank0), .Req28(Core28_Req_Bank0), .Req29(Core29_Req_Bank0),
                        .Req30(Core30_Req_Bank0), .Req31(Core31_Req_Bank0),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank0 ), .Ack1 (Core1_Ack_Bank0 ), .Ack2 (Core2_Ack_Bank0 ), .Ack3 (Core3_Ack_Bank0 ), .Ack4 (Core4_Ack_Bank0 ), 
						.Ack5 (Core5_Ack_Bank0 ), .Ack6 (Core6_Ack_Bank0 ), .Ack7 (Core7_Ack_Bank0 ), .Ack8 (Core8_Ack_Bank0 ), .Ack9 (Core9_Ack_Bank0 ),
                        .Ack10(Core10_Ack_Bank0), .Ack11(Core11_Ack_Bank0), .Ack12(Core12_Ack_Bank0), .Ack13(Core13_Ack_Bank0), .Ack14(Core14_Ack_Bank0), 
						.Ack15(Core15_Ack_Bank0), .Ack16(Core16_Ack_Bank0), .Ack17(Core17_Ack_Bank0), .Ack18(Core18_Ack_Bank0), .Ack19(Core19_Ack_Bank0),
                        .Ack20(Core20_Ack_Bank0), .Ack21(Core21_Ack_Bank0), .Ack22(Core22_Ack_Bank0), .Ack23(Core23_Ack_Bank0), .Ack24(Core24_Ack_Bank0),
						.Ack25(Core25_Ack_Bank0), .Ack26(Core26_Ack_Bank0), .Ack27(Core27_Ack_Bank0), .Ack28(Core28_Ack_Bank0), .Ack29(Core29_Ack_Bank0),
                        .Ack30(Core30_Ack_Bank0), .Ack31(Core31_Ack_Bank0),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank0),
                        .Select(SelectCore_to_Bank0),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank0)
                        ); 

    arbiter  u_arbiter1 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank1 ), .Req1 (Core1_Req_Bank1 ), .Req2 (Core2_Req_Bank1 ), .Req3 (Core3_Req_Bank1 ), .Req4 (Core4_Req_Bank1 ), 
						.Req5 (Core5_Req_Bank1 ), .Req6 (Core6_Req_Bank1 ), .Req7 (Core7_Req_Bank1 ), .Req8 (Core8_Req_Bank1 ), .Req9 (Core9_Req_Bank1 ),
                        .Req10(Core10_Req_Bank1), .Req11(Core11_Req_Bank1), .Req12(Core12_Req_Bank1), .Req13(Core13_Req_Bank1), .Req14(Core14_Req_Bank1),
						.Req15(Core15_Req_Bank1), .Req16(Core16_Req_Bank1), .Req17(Core17_Req_Bank1), .Req18(Core18_Req_Bank1), .Req19(Core19_Req_Bank1),
                        .Req20(Core20_Req_Bank1), .Req21(Core21_Req_Bank1), .Req22(Core22_Req_Bank1), .Req23(Core23_Req_Bank1), .Req24(Core24_Req_Bank1), 
						.Req25(Core25_Req_Bank1), .Req26(Core26_Req_Bank1), .Req27(Core27_Req_Bank1), .Req28(Core28_Req_Bank1), .Req29(Core29_Req_Bank1),
                        .Req30(Core30_Req_Bank1), .Req31(Core31_Req_Bank1),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank1 ), .Ack1 (Core1_Ack_Bank1 ), .Ack2 (Core2_Ack_Bank1 ), .Ack3 (Core3_Ack_Bank1 ), .Ack4 (Core4_Ack_Bank1 ), 
						.Ack5 (Core5_Ack_Bank1 ), .Ack6 (Core6_Ack_Bank1 ), .Ack7 (Core7_Ack_Bank1 ), .Ack8 (Core8_Ack_Bank1 ), .Ack9 (Core9_Ack_Bank1 ),
                        .Ack10(Core10_Ack_Bank1), .Ack11(Core11_Ack_Bank1), .Ack12(Core12_Ack_Bank1), .Ack13(Core13_Ack_Bank1), .Ack14(Core14_Ack_Bank1), 
						.Ack15(Core15_Ack_Bank1), .Ack16(Core16_Ack_Bank1), .Ack17(Core17_Ack_Bank1), .Ack18(Core18_Ack_Bank1), .Ack19(Core19_Ack_Bank1),
                        .Ack20(Core20_Ack_Bank1), .Ack21(Core21_Ack_Bank1), .Ack22(Core22_Ack_Bank1), .Ack23(Core23_Ack_Bank1), .Ack24(Core24_Ack_Bank1),
						.Ack25(Core25_Ack_Bank1), .Ack26(Core26_Ack_Bank1), .Ack27(Core27_Ack_Bank1), .Ack28(Core28_Ack_Bank1), .Ack29(Core29_Ack_Bank1),
                        .Ack30(Core30_Ack_Bank1), .Ack31(Core31_Ack_Bank1),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank1),
                        .Select(SelectCore_to_Bank1),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank1)
                        ); 

   arbiter  u_arbiter2 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank2 ), .Req1 (Core1_Req_Bank2 ), .Req2 (Core2_Req_Bank2 ), .Req3 (Core3_Req_Bank2 ), .Req4 (Core4_Req_Bank2 ), 
						.Req5 (Core5_Req_Bank2 ), .Req6 (Core6_Req_Bank2 ), .Req7 (Core7_Req_Bank2 ), .Req8 (Core8_Req_Bank2 ), .Req9 (Core9_Req_Bank2 ),
                        .Req10(Core10_Req_Bank2), .Req11(Core11_Req_Bank2), .Req12(Core12_Req_Bank2), .Req13(Core13_Req_Bank2), .Req14(Core14_Req_Bank2),
						.Req15(Core15_Req_Bank2), .Req16(Core16_Req_Bank2), .Req17(Core17_Req_Bank2), .Req18(Core18_Req_Bank2), .Req19(Core19_Req_Bank2),
                        .Req20(Core20_Req_Bank2), .Req21(Core21_Req_Bank2), .Req22(Core22_Req_Bank2), .Req23(Core23_Req_Bank2), .Req24(Core24_Req_Bank2), 
						.Req25(Core25_Req_Bank2), .Req26(Core26_Req_Bank2), .Req27(Core27_Req_Bank2), .Req28(Core28_Req_Bank2), .Req29(Core29_Req_Bank2),
                        .Req30(Core30_Req_Bank2), .Req31(Core31_Req_Bank2),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank2 ), .Ack1 (Core1_Ack_Bank2 ), .Ack2 (Core2_Ack_Bank2 ), .Ack3 (Core3_Ack_Bank2 ), .Ack4 (Core4_Ack_Bank2 ), 
						.Ack5 (Core5_Ack_Bank2 ), .Ack6 (Core6_Ack_Bank2 ), .Ack7 (Core7_Ack_Bank2 ), .Ack8 (Core8_Ack_Bank2 ), .Ack9 (Core9_Ack_Bank2 ),
                        .Ack10(Core10_Ack_Bank2), .Ack11(Core11_Ack_Bank2), .Ack12(Core12_Ack_Bank2), .Ack13(Core13_Ack_Bank2), .Ack14(Core14_Ack_Bank2), 
						.Ack15(Core15_Ack_Bank2), .Ack16(Core16_Ack_Bank2), .Ack17(Core17_Ack_Bank2), .Ack18(Core18_Ack_Bank2), .Ack19(Core19_Ack_Bank2),
                        .Ack20(Core20_Ack_Bank2), .Ack21(Core21_Ack_Bank2), .Ack22(Core22_Ack_Bank2), .Ack23(Core23_Ack_Bank2), .Ack24(Core24_Ack_Bank2),
						.Ack25(Core25_Ack_Bank2), .Ack26(Core26_Ack_Bank2), .Ack27(Core27_Ack_Bank2), .Ack28(Core28_Ack_Bank2), .Ack29(Core29_Ack_Bank2),
                        .Ack30(Core30_Ack_Bank2), .Ack31(Core31_Ack_Bank2),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank2),
                        .Select(SelectCore_to_Bank2),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank2)
                        ); 

   arbiter  u_arbiter3 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank3 ), .Req1 (Core1_Req_Bank3 ), .Req2 (Core2_Req_Bank3 ), .Req3 (Core3_Req_Bank3 ), .Req4 (Core4_Req_Bank3 ), 
						.Req5 (Core5_Req_Bank3 ), .Req6 (Core6_Req_Bank3 ), .Req7 (Core7_Req_Bank3 ), .Req8 (Core8_Req_Bank3 ), .Req9 (Core9_Req_Bank3 ),
                        .Req10(Core10_Req_Bank3), .Req11(Core11_Req_Bank3), .Req12(Core12_Req_Bank3), .Req13(Core13_Req_Bank3), .Req14(Core14_Req_Bank3),
						.Req15(Core15_Req_Bank3), .Req16(Core16_Req_Bank3), .Req17(Core17_Req_Bank3), .Req18(Core18_Req_Bank3), .Req19(Core19_Req_Bank3),
                        .Req20(Core20_Req_Bank3), .Req21(Core21_Req_Bank3), .Req22(Core22_Req_Bank3), .Req23(Core23_Req_Bank3), .Req24(Core24_Req_Bank3), 
						.Req25(Core25_Req_Bank3), .Req26(Core26_Req_Bank3), .Req27(Core27_Req_Bank3), .Req28(Core28_Req_Bank3), .Req29(Core29_Req_Bank3),
                        .Req30(Core30_Req_Bank3), .Req31(Core31_Req_Bank3),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank3 ), .Ack1 (Core1_Ack_Bank3 ), .Ack2 (Core2_Ack_Bank3 ), .Ack3 (Core3_Ack_Bank3 ), .Ack4 (Core4_Ack_Bank3 ), 
						.Ack5 (Core5_Ack_Bank3 ), .Ack6 (Core6_Ack_Bank3 ), .Ack7 (Core7_Ack_Bank3 ), .Ack8 (Core8_Ack_Bank3 ), .Ack9 (Core9_Ack_Bank3 ),
                        .Ack10(Core10_Ack_Bank3), .Ack11(Core11_Ack_Bank3), .Ack12(Core12_Ack_Bank3), .Ack13(Core13_Ack_Bank3), .Ack14(Core14_Ack_Bank3), 
						.Ack15(Core15_Ack_Bank3), .Ack16(Core16_Ack_Bank3), .Ack17(Core17_Ack_Bank3), .Ack18(Core18_Ack_Bank3), .Ack19(Core19_Ack_Bank3),
                        .Ack20(Core20_Ack_Bank3), .Ack21(Core21_Ack_Bank3), .Ack22(Core22_Ack_Bank3), .Ack23(Core23_Ack_Bank3), .Ack24(Core24_Ack_Bank3),
						.Ack25(Core25_Ack_Bank3), .Ack26(Core26_Ack_Bank3), .Ack27(Core27_Ack_Bank3), .Ack28(Core28_Ack_Bank3), .Ack29(Core29_Ack_Bank3),
                        .Ack30(Core30_Ack_Bank3), .Ack31(Core31_Ack_Bank3),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank3),
                        .Select(SelectCore_to_Bank3),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank3)
                        ); 

   arbiter  u_arbiter4 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank4 ), .Req1 (Core1_Req_Bank4 ), .Req2 (Core2_Req_Bank4 ), .Req3 (Core3_Req_Bank4 ), .Req4 (Core4_Req_Bank4 ), 
						.Req5 (Core5_Req_Bank4 ), .Req6 (Core6_Req_Bank4 ), .Req7 (Core7_Req_Bank4 ), .Req8 (Core8_Req_Bank4 ), .Req9 (Core9_Req_Bank4 ),
                        .Req10(Core10_Req_Bank4), .Req11(Core11_Req_Bank4), .Req12(Core12_Req_Bank4), .Req13(Core13_Req_Bank4), .Req14(Core14_Req_Bank4),
						.Req15(Core15_Req_Bank4), .Req16(Core16_Req_Bank4), .Req17(Core17_Req_Bank4), .Req18(Core18_Req_Bank4), .Req19(Core19_Req_Bank4),
                        .Req20(Core20_Req_Bank4), .Req21(Core21_Req_Bank4), .Req22(Core22_Req_Bank4), .Req23(Core23_Req_Bank4), .Req24(Core24_Req_Bank4), 
						.Req25(Core25_Req_Bank4), .Req26(Core26_Req_Bank4), .Req27(Core27_Req_Bank4), .Req28(Core28_Req_Bank4), .Req29(Core29_Req_Bank4),
                        .Req30(Core30_Req_Bank4), .Req31(Core31_Req_Bank4),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank4 ), .Ack1 (Core1_Ack_Bank4 ), .Ack2 (Core2_Ack_Bank4 ), .Ack3 (Core3_Ack_Bank4 ), .Ack4 (Core4_Ack_Bank4 ), 
						.Ack5 (Core5_Ack_Bank4 ), .Ack6 (Core6_Ack_Bank4 ), .Ack7 (Core7_Ack_Bank4 ), .Ack8 (Core8_Ack_Bank4 ), .Ack9 (Core9_Ack_Bank4 ),
                        .Ack10(Core10_Ack_Bank4), .Ack11(Core11_Ack_Bank4), .Ack12(Core12_Ack_Bank4), .Ack13(Core13_Ack_Bank4), .Ack14(Core14_Ack_Bank4), 
						.Ack15(Core15_Ack_Bank4), .Ack16(Core16_Ack_Bank4), .Ack17(Core17_Ack_Bank4), .Ack18(Core18_Ack_Bank4), .Ack19(Core19_Ack_Bank4),
                        .Ack20(Core20_Ack_Bank4), .Ack21(Core21_Ack_Bank4), .Ack22(Core22_Ack_Bank4), .Ack23(Core23_Ack_Bank4), .Ack24(Core24_Ack_Bank4),
						.Ack25(Core25_Ack_Bank4), .Ack26(Core26_Ack_Bank4), .Ack27(Core27_Ack_Bank4), .Ack28(Core28_Ack_Bank4), .Ack29(Core29_Ack_Bank4),
                        .Ack30(Core30_Ack_Bank4), .Ack31(Core31_Ack_Bank4),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank4),
                        .Select(SelectCore_to_Bank4),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank4)
                        ); 

   arbiter  u_arbiter5 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank5 ), .Req1 (Core1_Req_Bank5 ), .Req2 (Core2_Req_Bank5 ), .Req3 (Core3_Req_Bank5 ), .Req4 (Core4_Req_Bank5 ), 
						.Req5 (Core5_Req_Bank5 ), .Req6 (Core6_Req_Bank5 ), .Req7 (Core7_Req_Bank5 ), .Req8 (Core8_Req_Bank5 ), .Req9 (Core9_Req_Bank5 ),
                        .Req10(Core10_Req_Bank5), .Req11(Core11_Req_Bank5), .Req12(Core12_Req_Bank5), .Req13(Core13_Req_Bank5), .Req14(Core14_Req_Bank5),
						.Req15(Core15_Req_Bank5), .Req16(Core16_Req_Bank5), .Req17(Core17_Req_Bank5), .Req18(Core18_Req_Bank5), .Req19(Core19_Req_Bank5),
                        .Req20(Core20_Req_Bank5), .Req21(Core21_Req_Bank5), .Req22(Core22_Req_Bank5), .Req23(Core23_Req_Bank5), .Req24(Core24_Req_Bank5), 
						.Req25(Core25_Req_Bank5), .Req26(Core26_Req_Bank5), .Req27(Core27_Req_Bank5), .Req28(Core28_Req_Bank5), .Req29(Core29_Req_Bank5),
                        .Req30(Core30_Req_Bank5), .Req31(Core31_Req_Bank5),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank5 ), .Ack1 (Core1_Ack_Bank5 ), .Ack2 (Core2_Ack_Bank5 ), .Ack3 (Core3_Ack_Bank5 ), .Ack4 (Core4_Ack_Bank5 ), 
						.Ack5 (Core5_Ack_Bank5 ), .Ack6 (Core6_Ack_Bank5 ), .Ack7 (Core7_Ack_Bank5 ), .Ack8 (Core8_Ack_Bank5 ), .Ack9 (Core9_Ack_Bank5 ),
                        .Ack10(Core10_Ack_Bank5), .Ack11(Core11_Ack_Bank5), .Ack12(Core12_Ack_Bank5), .Ack13(Core13_Ack_Bank5), .Ack14(Core14_Ack_Bank5), 
						.Ack15(Core15_Ack_Bank5), .Ack16(Core16_Ack_Bank5), .Ack17(Core17_Ack_Bank5), .Ack18(Core18_Ack_Bank5), .Ack19(Core19_Ack_Bank5),
                        .Ack20(Core20_Ack_Bank5), .Ack21(Core21_Ack_Bank5), .Ack22(Core22_Ack_Bank5), .Ack23(Core23_Ack_Bank5), .Ack24(Core24_Ack_Bank5),
						.Ack25(Core25_Ack_Bank5), .Ack26(Core26_Ack_Bank5), .Ack27(Core27_Ack_Bank5), .Ack28(Core28_Ack_Bank5), .Ack29(Core29_Ack_Bank5),
                        .Ack30(Core30_Ack_Bank5), .Ack31(Core31_Ack_Bank5),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank5),
                        .Select(SelectCore_to_Bank5),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank5)
                        ); 

   arbiter  u_arbiter6 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank6 ), .Req1 (Core1_Req_Bank6 ), .Req2 (Core2_Req_Bank6 ), .Req3 (Core3_Req_Bank6 ), .Req4 (Core4_Req_Bank6 ), 
						.Req5 (Core5_Req_Bank6 ), .Req6 (Core6_Req_Bank6 ), .Req7 (Core7_Req_Bank6 ), .Req8 (Core8_Req_Bank6 ), .Req9 (Core9_Req_Bank6 ),
                        .Req10(Core10_Req_Bank6), .Req11(Core11_Req_Bank6), .Req12(Core12_Req_Bank6), .Req13(Core13_Req_Bank6), .Req14(Core14_Req_Bank6),
						.Req15(Core15_Req_Bank6), .Req16(Core16_Req_Bank6), .Req17(Core17_Req_Bank6), .Req18(Core18_Req_Bank6), .Req19(Core19_Req_Bank6),
                        .Req20(Core20_Req_Bank6), .Req21(Core21_Req_Bank6), .Req22(Core22_Req_Bank6), .Req23(Core23_Req_Bank6), .Req24(Core24_Req_Bank6), 
						.Req25(Core25_Req_Bank6), .Req26(Core26_Req_Bank6), .Req27(Core27_Req_Bank6), .Req28(Core28_Req_Bank6), .Req29(Core29_Req_Bank6),
                        .Req30(Core30_Req_Bank6), .Req31(Core31_Req_Bank6),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank6 ), .Ack1 (Core1_Ack_Bank6 ), .Ack2 (Core2_Ack_Bank6 ), .Ack3 (Core3_Ack_Bank6 ), .Ack4 (Core4_Ack_Bank6 ), 
						.Ack5 (Core5_Ack_Bank6 ), .Ack6 (Core6_Ack_Bank6 ), .Ack7 (Core7_Ack_Bank6 ), .Ack8 (Core8_Ack_Bank6 ), .Ack9 (Core9_Ack_Bank6 ),
                        .Ack10(Core10_Ack_Bank6), .Ack11(Core11_Ack_Bank6), .Ack12(Core12_Ack_Bank6), .Ack13(Core13_Ack_Bank6), .Ack14(Core14_Ack_Bank6), 
						.Ack15(Core15_Ack_Bank6), .Ack16(Core16_Ack_Bank6), .Ack17(Core17_Ack_Bank6), .Ack18(Core18_Ack_Bank6), .Ack19(Core19_Ack_Bank6),
                        .Ack20(Core20_Ack_Bank6), .Ack21(Core21_Ack_Bank6), .Ack22(Core22_Ack_Bank6), .Ack23(Core23_Ack_Bank6), .Ack24(Core24_Ack_Bank6),
						.Ack25(Core25_Ack_Bank6), .Ack26(Core26_Ack_Bank6), .Ack27(Core27_Ack_Bank6), .Ack28(Core28_Ack_Bank6), .Ack29(Core29_Ack_Bank6),
                        .Ack30(Core30_Ack_Bank6), .Ack31(Core31_Ack_Bank6),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank6),
                        .Select(SelectCore_to_Bank6),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank6)
                        ); 

   arbiter  u_arbiter7 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank7 ), .Req1 (Core1_Req_Bank7 ), .Req2 (Core2_Req_Bank7 ), .Req3 (Core3_Req_Bank7 ), .Req4 (Core4_Req_Bank7 ), 
						.Req5 (Core5_Req_Bank7 ), .Req6 (Core6_Req_Bank7 ), .Req7 (Core7_Req_Bank7 ), .Req8 (Core8_Req_Bank7 ), .Req9 (Core9_Req_Bank7 ),
                        .Req10(Core10_Req_Bank7), .Req11(Core11_Req_Bank7), .Req12(Core12_Req_Bank7), .Req13(Core13_Req_Bank7), .Req14(Core14_Req_Bank7),
						.Req15(Core15_Req_Bank7), .Req16(Core16_Req_Bank7), .Req17(Core17_Req_Bank7), .Req18(Core18_Req_Bank7), .Req19(Core19_Req_Bank7),
                        .Req20(Core20_Req_Bank7), .Req21(Core21_Req_Bank7), .Req22(Core22_Req_Bank7), .Req23(Core23_Req_Bank7), .Req24(Core24_Req_Bank7), 
						.Req25(Core25_Req_Bank7), .Req26(Core26_Req_Bank7), .Req27(Core27_Req_Bank7), .Req28(Core28_Req_Bank7), .Req29(Core29_Req_Bank7),
                        .Req30(Core30_Req_Bank7), .Req31(Core31_Req_Bank7),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank7 ), .Ack1 (Core1_Ack_Bank7 ), .Ack2 (Core2_Ack_Bank7 ), .Ack3 (Core3_Ack_Bank7 ), .Ack4 (Core4_Ack_Bank7 ), 
						.Ack5 (Core5_Ack_Bank7 ), .Ack6 (Core6_Ack_Bank7 ), .Ack7 (Core7_Ack_Bank7 ), .Ack8 (Core8_Ack_Bank7 ), .Ack9 (Core9_Ack_Bank7 ),
                        .Ack10(Core10_Ack_Bank7), .Ack11(Core11_Ack_Bank7), .Ack12(Core12_Ack_Bank7), .Ack13(Core13_Ack_Bank7), .Ack14(Core14_Ack_Bank7), 
						.Ack15(Core15_Ack_Bank7), .Ack16(Core16_Ack_Bank7), .Ack17(Core17_Ack_Bank7), .Ack18(Core18_Ack_Bank7), .Ack19(Core19_Ack_Bank7),
                        .Ack20(Core20_Ack_Bank7), .Ack21(Core21_Ack_Bank7), .Ack22(Core22_Ack_Bank7), .Ack23(Core23_Ack_Bank7), .Ack24(Core24_Ack_Bank7),
						.Ack25(Core25_Ack_Bank7), .Ack26(Core26_Ack_Bank7), .Ack27(Core27_Ack_Bank7), .Ack28(Core28_Ack_Bank7), .Ack29(Core29_Ack_Bank7),
                        .Ack30(Core30_Ack_Bank7), .Ack31(Core31_Ack_Bank7),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank7),
                        .Select(SelectCore_to_Bank7),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank7)
                        ); 

   arbiter  u_arbiter8 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank8 ), .Req1 (Core1_Req_Bank8 ), .Req2 (Core2_Req_Bank8 ), .Req3 (Core3_Req_Bank8 ), .Req4 (Core4_Req_Bank8 ), 
						.Req5 (Core5_Req_Bank8 ), .Req6 (Core6_Req_Bank8 ), .Req7 (Core7_Req_Bank8 ), .Req8 (Core8_Req_Bank8 ), .Req9 (Core9_Req_Bank8 ),
                        .Req10(Core10_Req_Bank8), .Req11(Core11_Req_Bank8), .Req12(Core12_Req_Bank8), .Req13(Core13_Req_Bank8), .Req14(Core14_Req_Bank8),
						.Req15(Core15_Req_Bank8), .Req16(Core16_Req_Bank8), .Req17(Core17_Req_Bank8), .Req18(Core18_Req_Bank8), .Req19(Core19_Req_Bank8),
                        .Req20(Core20_Req_Bank8), .Req21(Core21_Req_Bank8), .Req22(Core22_Req_Bank8), .Req23(Core23_Req_Bank8), .Req24(Core24_Req_Bank8), 
						.Req25(Core25_Req_Bank8), .Req26(Core26_Req_Bank8), .Req27(Core27_Req_Bank8), .Req28(Core28_Req_Bank8), .Req29(Core29_Req_Bank8),
                        .Req30(Core30_Req_Bank8), .Req31(Core31_Req_Bank8),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank8 ), .Ack1 (Core1_Ack_Bank8 ), .Ack2 (Core2_Ack_Bank8 ), .Ack3 (Core3_Ack_Bank8 ), .Ack4 (Core4_Ack_Bank8 ), 
						.Ack5 (Core5_Ack_Bank8 ), .Ack6 (Core6_Ack_Bank8 ), .Ack7 (Core7_Ack_Bank8 ), .Ack8 (Core8_Ack_Bank8 ), .Ack9 (Core9_Ack_Bank8 ),
                        .Ack10(Core10_Ack_Bank8), .Ack11(Core11_Ack_Bank8), .Ack12(Core12_Ack_Bank8), .Ack13(Core13_Ack_Bank8), .Ack14(Core14_Ack_Bank8), 
						.Ack15(Core15_Ack_Bank8), .Ack16(Core16_Ack_Bank8), .Ack17(Core17_Ack_Bank8), .Ack18(Core18_Ack_Bank8), .Ack19(Core19_Ack_Bank8),
                        .Ack20(Core20_Ack_Bank8), .Ack21(Core21_Ack_Bank8), .Ack22(Core22_Ack_Bank8), .Ack23(Core23_Ack_Bank8), .Ack24(Core24_Ack_Bank8),
						.Ack25(Core25_Ack_Bank8), .Ack26(Core26_Ack_Bank8), .Ack27(Core27_Ack_Bank8), .Ack28(Core28_Ack_Bank8), .Ack29(Core29_Ack_Bank8),
                        .Ack30(Core30_Ack_Bank8), .Ack31(Core31_Ack_Bank8),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank8),
                        .Select(SelectCore_to_Bank8),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank8)
                        ); 

   arbiter  u_arbiter9 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank9 ), .Req1 (Core1_Req_Bank9 ), .Req2 (Core2_Req_Bank9 ), .Req3 (Core3_Req_Bank9 ), .Req4 (Core4_Req_Bank9 ), 
						.Req5 (Core5_Req_Bank9 ), .Req6 (Core6_Req_Bank9 ), .Req7 (Core7_Req_Bank9 ), .Req8 (Core8_Req_Bank9 ), .Req9 (Core9_Req_Bank9 ),
                        .Req10(Core10_Req_Bank9), .Req11(Core11_Req_Bank9), .Req12(Core12_Req_Bank9), .Req13(Core13_Req_Bank9), .Req14(Core14_Req_Bank9),
						.Req15(Core15_Req_Bank9), .Req16(Core16_Req_Bank9), .Req17(Core17_Req_Bank9), .Req18(Core18_Req_Bank9), .Req19(Core19_Req_Bank9),
                        .Req20(Core20_Req_Bank9), .Req21(Core21_Req_Bank9), .Req22(Core22_Req_Bank9), .Req23(Core23_Req_Bank9), .Req24(Core24_Req_Bank9), 
						.Req25(Core25_Req_Bank9), .Req26(Core26_Req_Bank9), .Req27(Core27_Req_Bank9), .Req28(Core28_Req_Bank9), .Req29(Core29_Req_Bank9),
                        .Req30(Core30_Req_Bank9), .Req31(Core31_Req_Bank9),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank9 ), .Ack1 (Core1_Ack_Bank9 ), .Ack2 (Core2_Ack_Bank9 ), .Ack3 (Core3_Ack_Bank9 ), .Ack4 (Core4_Ack_Bank9 ), 
						.Ack5 (Core5_Ack_Bank9 ), .Ack6 (Core6_Ack_Bank9 ), .Ack7 (Core7_Ack_Bank9 ), .Ack8 (Core8_Ack_Bank9 ), .Ack9 (Core9_Ack_Bank9 ),
                        .Ack10(Core10_Ack_Bank9), .Ack11(Core11_Ack_Bank9), .Ack12(Core12_Ack_Bank9), .Ack13(Core13_Ack_Bank9), .Ack14(Core14_Ack_Bank9), 
						.Ack15(Core15_Ack_Bank9), .Ack16(Core16_Ack_Bank9), .Ack17(Core17_Ack_Bank9), .Ack18(Core18_Ack_Bank9), .Ack19(Core19_Ack_Bank9),
                        .Ack20(Core20_Ack_Bank9), .Ack21(Core21_Ack_Bank9), .Ack22(Core22_Ack_Bank9), .Ack23(Core23_Ack_Bank9), .Ack24(Core24_Ack_Bank9),
						.Ack25(Core25_Ack_Bank9), .Ack26(Core26_Ack_Bank9), .Ack27(Core27_Ack_Bank9), .Ack28(Core28_Ack_Bank9), .Ack29(Core29_Ack_Bank9),
                        .Ack30(Core30_Ack_Bank9), .Ack31(Core31_Ack_Bank9),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank9),
                        .Select(SelectCore_to_Bank9),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank9)
                        ); 

   arbiter  u_arbiter10 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank10 ), .Req1 (Core1_Req_Bank10 ), .Req2 (Core2_Req_Bank10 ), .Req3 (Core3_Req_Bank10 ), .Req4 (Core4_Req_Bank10 ), 
						.Req5 (Core5_Req_Bank10 ), .Req6 (Core6_Req_Bank10 ), .Req7 (Core7_Req_Bank10 ), .Req8 (Core8_Req_Bank10 ), .Req9 (Core9_Req_Bank10 ),
                        .Req10(Core10_Req_Bank10), .Req11(Core11_Req_Bank10), .Req12(Core12_Req_Bank10), .Req13(Core13_Req_Bank10), .Req14(Core14_Req_Bank10),
						.Req15(Core15_Req_Bank10), .Req16(Core16_Req_Bank10), .Req17(Core17_Req_Bank10), .Req18(Core18_Req_Bank10), .Req19(Core19_Req_Bank10),
                        .Req20(Core20_Req_Bank10), .Req21(Core21_Req_Bank10), .Req22(Core22_Req_Bank10), .Req23(Core23_Req_Bank10), .Req24(Core24_Req_Bank10), 
						.Req25(Core25_Req_Bank10), .Req26(Core26_Req_Bank10), .Req27(Core27_Req_Bank10), .Req28(Core28_Req_Bank10), .Req29(Core29_Req_Bank10),
                        .Req30(Core30_Req_Bank10), .Req31(Core31_Req_Bank10),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank10 ), .Ack1 (Core1_Ack_Bank10 ), .Ack2 (Core2_Ack_Bank10 ), .Ack3 (Core3_Ack_Bank10 ), .Ack4 (Core4_Ack_Bank10 ), 
						.Ack5 (Core5_Ack_Bank10 ), .Ack6 (Core6_Ack_Bank10 ), .Ack7 (Core7_Ack_Bank10 ), .Ack8 (Core8_Ack_Bank10 ), .Ack9 (Core9_Ack_Bank10 ),
                        .Ack10(Core10_Ack_Bank10), .Ack11(Core11_Ack_Bank10), .Ack12(Core12_Ack_Bank10), .Ack13(Core13_Ack_Bank10), .Ack14(Core14_Ack_Bank10), 
						.Ack15(Core15_Ack_Bank10), .Ack16(Core16_Ack_Bank10), .Ack17(Core17_Ack_Bank10), .Ack18(Core18_Ack_Bank10), .Ack19(Core19_Ack_Bank10),
                        .Ack20(Core20_Ack_Bank10), .Ack21(Core21_Ack_Bank10), .Ack22(Core22_Ack_Bank10), .Ack23(Core23_Ack_Bank10), .Ack24(Core24_Ack_Bank10),
						.Ack25(Core25_Ack_Bank10), .Ack26(Core26_Ack_Bank10), .Ack27(Core27_Ack_Bank10), .Ack28(Core28_Ack_Bank10), .Ack29(Core29_Ack_Bank10),
                        .Ack30(Core30_Ack_Bank10), .Ack31(Core31_Ack_Bank10),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank10),
                        .Select(SelectCore_to_Bank10),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank10)
                        ); 

   arbiter  u_arbiter11 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank11 ), .Req1 (Core1_Req_Bank11 ), .Req2 (Core2_Req_Bank11 ), .Req3 (Core3_Req_Bank11 ), .Req4 (Core4_Req_Bank11 ), 
						.Req5 (Core5_Req_Bank11 ), .Req6 (Core6_Req_Bank11 ), .Req7 (Core7_Req_Bank11 ), .Req8 (Core8_Req_Bank11 ), .Req9 (Core9_Req_Bank11 ),
                        .Req10(Core10_Req_Bank11), .Req11(Core11_Req_Bank11), .Req12(Core12_Req_Bank11), .Req13(Core13_Req_Bank11), .Req14(Core14_Req_Bank11),
						.Req15(Core15_Req_Bank11), .Req16(Core16_Req_Bank11), .Req17(Core17_Req_Bank11), .Req18(Core18_Req_Bank11), .Req19(Core19_Req_Bank11),
                        .Req20(Core20_Req_Bank11), .Req21(Core21_Req_Bank11), .Req22(Core22_Req_Bank11), .Req23(Core23_Req_Bank11), .Req24(Core24_Req_Bank11), 
						.Req25(Core25_Req_Bank11), .Req26(Core26_Req_Bank11), .Req27(Core27_Req_Bank11), .Req28(Core28_Req_Bank11), .Req29(Core29_Req_Bank11),
                        .Req30(Core30_Req_Bank11), .Req31(Core31_Req_Bank11),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank11 ), .Ack1 (Core1_Ack_Bank11 ), .Ack2 (Core2_Ack_Bank11 ), .Ack3 (Core3_Ack_Bank11 ), .Ack4 (Core4_Ack_Bank11 ), 
						.Ack5 (Core5_Ack_Bank11 ), .Ack6 (Core6_Ack_Bank11 ), .Ack7 (Core7_Ack_Bank11 ), .Ack8 (Core8_Ack_Bank11 ), .Ack9 (Core9_Ack_Bank11 ),
                        .Ack10(Core10_Ack_Bank11), .Ack11(Core11_Ack_Bank11), .Ack12(Core12_Ack_Bank11), .Ack13(Core13_Ack_Bank11), .Ack14(Core14_Ack_Bank11), 
						.Ack15(Core15_Ack_Bank11), .Ack16(Core16_Ack_Bank11), .Ack17(Core17_Ack_Bank11), .Ack18(Core18_Ack_Bank11), .Ack19(Core19_Ack_Bank11),
                        .Ack20(Core20_Ack_Bank11), .Ack21(Core21_Ack_Bank11), .Ack22(Core22_Ack_Bank11), .Ack23(Core23_Ack_Bank11), .Ack24(Core24_Ack_Bank11),
						.Ack25(Core25_Ack_Bank11), .Ack26(Core26_Ack_Bank11), .Ack27(Core27_Ack_Bank11), .Ack28(Core28_Ack_Bank11), .Ack29(Core29_Ack_Bank11),
                        .Ack30(Core30_Ack_Bank11), .Ack31(Core31_Ack_Bank11),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank11),
                        .Select(SelectCore_to_Bank11),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank11)
                        ); 

   arbiter  u_arbiter12 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank12 ), .Req1 (Core1_Req_Bank12 ), .Req2 (Core2_Req_Bank12 ), .Req3 (Core3_Req_Bank12 ), .Req4 (Core4_Req_Bank12 ), 
						.Req5 (Core5_Req_Bank12 ), .Req6 (Core6_Req_Bank12 ), .Req7 (Core7_Req_Bank12 ), .Req8 (Core8_Req_Bank12 ), .Req9 (Core9_Req_Bank12 ),
                        .Req10(Core10_Req_Bank12), .Req11(Core11_Req_Bank12), .Req12(Core12_Req_Bank12), .Req13(Core13_Req_Bank12), .Req14(Core14_Req_Bank12),
						.Req15(Core15_Req_Bank12), .Req16(Core16_Req_Bank12), .Req17(Core17_Req_Bank12), .Req18(Core18_Req_Bank12), .Req19(Core19_Req_Bank12),
                        .Req20(Core20_Req_Bank12), .Req21(Core21_Req_Bank12), .Req22(Core22_Req_Bank12), .Req23(Core23_Req_Bank12), .Req24(Core24_Req_Bank12), 
						.Req25(Core25_Req_Bank12), .Req26(Core26_Req_Bank12), .Req27(Core27_Req_Bank12), .Req28(Core28_Req_Bank12), .Req29(Core29_Req_Bank12),
                        .Req30(Core30_Req_Bank12), .Req31(Core31_Req_Bank12),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank12 ), .Ack1 (Core1_Ack_Bank12 ), .Ack2 (Core2_Ack_Bank12 ), .Ack3 (Core3_Ack_Bank12 ), .Ack4 (Core4_Ack_Bank12 ), 
						.Ack5 (Core5_Ack_Bank12 ), .Ack6 (Core6_Ack_Bank12 ), .Ack7 (Core7_Ack_Bank12 ), .Ack8 (Core8_Ack_Bank12 ), .Ack9 (Core9_Ack_Bank12 ),
                        .Ack10(Core10_Ack_Bank12), .Ack11(Core11_Ack_Bank12), .Ack12(Core12_Ack_Bank12), .Ack13(Core13_Ack_Bank12), .Ack14(Core14_Ack_Bank12), 
						.Ack15(Core15_Ack_Bank12), .Ack16(Core16_Ack_Bank12), .Ack17(Core17_Ack_Bank12), .Ack18(Core18_Ack_Bank12), .Ack19(Core19_Ack_Bank12),
                        .Ack20(Core20_Ack_Bank12), .Ack21(Core21_Ack_Bank12), .Ack22(Core22_Ack_Bank12), .Ack23(Core23_Ack_Bank12), .Ack24(Core24_Ack_Bank12),
						.Ack25(Core25_Ack_Bank12), .Ack26(Core26_Ack_Bank12), .Ack27(Core27_Ack_Bank12), .Ack28(Core28_Ack_Bank12), .Ack29(Core29_Ack_Bank12),
                        .Ack30(Core30_Ack_Bank12), .Ack31(Core31_Ack_Bank12),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank12),
                        .Select(SelectCore_to_Bank12),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank12)
                        ); 

   arbiter  u_arbiter13 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank13 ), .Req1 (Core1_Req_Bank13 ), .Req2 (Core2_Req_Bank13 ), .Req3 (Core3_Req_Bank13 ), .Req4 (Core4_Req_Bank13 ), 
						.Req5 (Core5_Req_Bank13 ), .Req6 (Core6_Req_Bank13 ), .Req7 (Core7_Req_Bank13 ), .Req8 (Core8_Req_Bank13 ), .Req9 (Core9_Req_Bank13 ),
                        .Req10(Core10_Req_Bank13), .Req11(Core11_Req_Bank13), .Req12(Core12_Req_Bank13), .Req13(Core13_Req_Bank13), .Req14(Core14_Req_Bank13),
						.Req15(Core15_Req_Bank13), .Req16(Core16_Req_Bank13), .Req17(Core17_Req_Bank13), .Req18(Core18_Req_Bank13), .Req19(Core19_Req_Bank13),
                        .Req20(Core20_Req_Bank13), .Req21(Core21_Req_Bank13), .Req22(Core22_Req_Bank13), .Req23(Core23_Req_Bank13), .Req24(Core24_Req_Bank13), 
						.Req25(Core25_Req_Bank13), .Req26(Core26_Req_Bank13), .Req27(Core27_Req_Bank13), .Req28(Core28_Req_Bank13), .Req29(Core29_Req_Bank13),
                        .Req30(Core30_Req_Bank13), .Req31(Core31_Req_Bank13),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank13 ), .Ack1 (Core1_Ack_Bank13 ), .Ack2 (Core2_Ack_Bank13 ), .Ack3 (Core3_Ack_Bank13 ), .Ack4 (Core4_Ack_Bank13 ), 
						.Ack5 (Core5_Ack_Bank13 ), .Ack6 (Core6_Ack_Bank13 ), .Ack7 (Core7_Ack_Bank13 ), .Ack8 (Core8_Ack_Bank13 ), .Ack9 (Core9_Ack_Bank13 ),
                        .Ack10(Core10_Ack_Bank13), .Ack11(Core11_Ack_Bank13), .Ack12(Core12_Ack_Bank13), .Ack13(Core13_Ack_Bank13), .Ack14(Core14_Ack_Bank13), 
						.Ack15(Core15_Ack_Bank13), .Ack16(Core16_Ack_Bank13), .Ack17(Core17_Ack_Bank13), .Ack18(Core18_Ack_Bank13), .Ack19(Core19_Ack_Bank13),
                        .Ack20(Core20_Ack_Bank13), .Ack21(Core21_Ack_Bank13), .Ack22(Core22_Ack_Bank13), .Ack23(Core23_Ack_Bank13), .Ack24(Core24_Ack_Bank13),
						.Ack25(Core25_Ack_Bank13), .Ack26(Core26_Ack_Bank13), .Ack27(Core27_Ack_Bank13), .Ack28(Core28_Ack_Bank13), .Ack29(Core29_Ack_Bank13),
                        .Ack30(Core30_Ack_Bank13), .Ack31(Core31_Ack_Bank13),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank13),
                        .Select(SelectCore_to_Bank13),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank13)
                        ); 

   arbiter  u_arbiter14 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank14 ), .Req1 (Core1_Req_Bank14 ), .Req2 (Core2_Req_Bank14 ), .Req3 (Core3_Req_Bank14 ), .Req4 (Core4_Req_Bank14 ), 
						.Req5 (Core5_Req_Bank14 ), .Req6 (Core6_Req_Bank14 ), .Req7 (Core7_Req_Bank14 ), .Req8 (Core8_Req_Bank14 ), .Req9 (Core9_Req_Bank14 ),
                        .Req10(Core10_Req_Bank14), .Req11(Core11_Req_Bank14), .Req12(Core12_Req_Bank14), .Req13(Core13_Req_Bank14), .Req14(Core14_Req_Bank14),
						.Req15(Core15_Req_Bank14), .Req16(Core16_Req_Bank14), .Req17(Core17_Req_Bank14), .Req18(Core18_Req_Bank14), .Req19(Core19_Req_Bank14),
                        .Req20(Core20_Req_Bank14), .Req21(Core21_Req_Bank14), .Req22(Core22_Req_Bank14), .Req23(Core23_Req_Bank14), .Req24(Core24_Req_Bank14), 
						.Req25(Core25_Req_Bank14), .Req26(Core26_Req_Bank14), .Req27(Core27_Req_Bank14), .Req28(Core28_Req_Bank14), .Req29(Core29_Req_Bank14),
                        .Req30(Core30_Req_Bank14), .Req31(Core31_Req_Bank14),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank14 ), .Ack1 (Core1_Ack_Bank14 ), .Ack2 (Core2_Ack_Bank14 ), .Ack3 (Core3_Ack_Bank14 ), .Ack4 (Core4_Ack_Bank14 ), 
						.Ack5 (Core5_Ack_Bank14 ), .Ack6 (Core6_Ack_Bank14 ), .Ack7 (Core7_Ack_Bank14 ), .Ack8 (Core8_Ack_Bank14 ), .Ack9 (Core9_Ack_Bank14 ),
                        .Ack10(Core10_Ack_Bank14), .Ack11(Core11_Ack_Bank14), .Ack12(Core12_Ack_Bank14), .Ack13(Core13_Ack_Bank14), .Ack14(Core14_Ack_Bank14), 
						.Ack15(Core15_Ack_Bank14), .Ack16(Core16_Ack_Bank14), .Ack17(Core17_Ack_Bank14), .Ack18(Core18_Ack_Bank14), .Ack19(Core19_Ack_Bank14),
                        .Ack20(Core20_Ack_Bank14), .Ack21(Core21_Ack_Bank14), .Ack22(Core22_Ack_Bank14), .Ack23(Core23_Ack_Bank14), .Ack24(Core24_Ack_Bank14),
						.Ack25(Core25_Ack_Bank14), .Ack26(Core26_Ack_Bank14), .Ack27(Core27_Ack_Bank14), .Ack28(Core28_Ack_Bank14), .Ack29(Core29_Ack_Bank14),
                        .Ack30(Core30_Ack_Bank14), .Ack31(Core31_Ack_Bank14),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank14),
                        .Select(SelectCore_to_Bank14),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank14)
                        ); 

   arbiter  u_arbiter15 (.CLK(CLK) , .RSTn(RSTn) ,
                        .Req0 (Core0_Req_Bank15 ), .Req1 (Core1_Req_Bank15 ), .Req2 (Core2_Req_Bank15 ), .Req3 (Core3_Req_Bank15 ), .Req4 (Core4_Req_Bank15 ), 
						.Req5 (Core5_Req_Bank15 ), .Req6 (Core6_Req_Bank15 ), .Req7 (Core7_Req_Bank15 ), .Req8 (Core8_Req_Bank15 ), .Req9 (Core9_Req_Bank15 ),
                        .Req10(Core10_Req_Bank15), .Req11(Core11_Req_Bank15), .Req12(Core12_Req_Bank15), .Req13(Core13_Req_Bank15), .Req14(Core14_Req_Bank15),
						.Req15(Core15_Req_Bank15), .Req16(Core16_Req_Bank15), .Req17(Core17_Req_Bank15), .Req18(Core18_Req_Bank15), .Req19(Core19_Req_Bank15),
                        .Req20(Core20_Req_Bank15), .Req21(Core21_Req_Bank15), .Req22(Core22_Req_Bank15), .Req23(Core23_Req_Bank15), .Req24(Core24_Req_Bank15), 
						.Req25(Core25_Req_Bank15), .Req26(Core26_Req_Bank15), .Req27(Core27_Req_Bank15), .Req28(Core28_Req_Bank15), .Req29(Core29_Req_Bank15),
                        .Req30(Core30_Req_Bank15), .Req31(Core31_Req_Bank15),
                        //--------------------------------
                        .Ack0 (Core0_Ack_Bank15 ), .Ack1 (Core1_Ack_Bank15 ), .Ack2 (Core2_Ack_Bank15 ), .Ack3 (Core3_Ack_Bank15 ), .Ack4 (Core4_Ack_Bank15 ), 
						.Ack5 (Core5_Ack_Bank15 ), .Ack6 (Core6_Ack_Bank15 ), .Ack7 (Core7_Ack_Bank15 ), .Ack8 (Core8_Ack_Bank15 ), .Ack9 (Core9_Ack_Bank15 ),
                        .Ack10(Core10_Ack_Bank15), .Ack11(Core11_Ack_Bank15), .Ack12(Core12_Ack_Bank15), .Ack13(Core13_Ack_Bank15), .Ack14(Core14_Ack_Bank15), 
						.Ack15(Core15_Ack_Bank15), .Ack16(Core16_Ack_Bank15), .Ack17(Core17_Ack_Bank15), .Ack18(Core18_Ack_Bank15), .Ack19(Core19_Ack_Bank15),
                        .Ack20(Core20_Ack_Bank15), .Ack21(Core21_Ack_Bank15), .Ack22(Core22_Ack_Bank15), .Ack23(Core23_Ack_Bank15), .Ack24(Core24_Ack_Bank15),
						.Ack25(Core25_Ack_Bank15), .Ack26(Core26_Ack_Bank15), .Ack27(Core27_Ack_Bank15), .Ack28(Core28_Ack_Bank15), .Ack29(Core29_Ack_Bank15),
                        .Ack30(Core30_Ack_Bank15), .Ack31(Core31_Ack_Bank15),
                        //-------- Grant Lines ----------
                        .Grant (Grant_Bank15),
                        .Select(SelectCore_to_Bank15),  // This line should go as select line for muxing of address and 
                        //------ Done ------
                        .Done (Done_Bank15)
                        ); 

    //------- Forwards Address bus to the Bank0 based on select lines provided by arbiter0
	AddressMultiplexer  u_AddressMultiplexer0 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank0) , .enable(Grant_Bank0), .outdata(Bank0_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer1 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank1) , .enable(Grant_Bank1), .outdata(Bank1_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer2 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank2) , .enable(Grant_Bank2), .outdata(Bank2_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer3 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank3) , .enable(Grant_Bank3), .outdata(Bank3_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer4 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank4) , .enable(Grant_Bank4), .outdata(Bank4_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer5 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank5) , .enable(Grant_Bank5), .outdata(Bank5_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer6 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank6) , .enable(Grant_Bank6), .outdata(Bank6_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer7 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank7) , .enable(Grant_Bank7), .outdata(Bank7_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer8 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank8) , .enable(Grant_Bank8), .outdata(Bank8_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer9 ( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank9) , .enable(Grant_Bank9), .outdata(Bank9_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer10( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank10) , .enable(Grant_Bank10), .outdata(Bank10_AddressOut)) ;

 	AddressMultiplexer  u_AddressMultiplexer11( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank11) , .enable(Grant_Bank11), .outdata(Bank11_AddressOut)) ;


 	AddressMultiplexer  u_AddressMultiplexer12( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank12) , .enable(Grant_Bank12), .outdata(Bank12_AddressOut)) ;


 	AddressMultiplexer  u_AddressMultiplexer13( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank13) , .enable(Grant_Bank13), .outdata(Bank13_AddressOut)) ;


 	AddressMultiplexer  u_AddressMultiplexer14( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank14) , .enable(Grant_Bank14), .outdata(Bank14_AddressOut)) ;


 	AddressMultiplexer  u_AddressMultiplexer15( .inaddr0 (Core0_AddressIn[31:0]),  .inaddr1 (Core1_AddressIn[31:0]),  .inaddr2 (Core2_AddressIn[31:0]), 
	                                    .inaddr3 (Core3_AddressIn[31:0]),  .inaddr4 (Core4_AddressIn[31:0]),  .inaddr5 (Core5_AddressIn[31:0]), 
										.inaddr6 (Core6_AddressIn[31:0]),  .inaddr7 (Core7_AddressIn[31:0]),  .inaddr8 (Core8_AddressIn[31:0]), 
										.inaddr9 (Core9_AddressIn[31:0]),  .inaddr10(Core10_AddressIn[31:0]), .inaddr11(Core11_AddressIn[31:0]), 
										.inaddr12(Core12_AddressIn[31:0]), .inaddr13(Core13_AddressIn[31:0]), .inaddr14(Core14_AddressIn[31:0]), 
										.inaddr15(Core15_AddressIn[31:0]), .inaddr16(Core16_AddressIn[31:0]), .inaddr17(Core17_AddressIn[31:0]), 
										.inaddr18(Core18_AddressIn[31:0]), .inaddr19(Core19_AddressIn[31:0]), .inaddr20(Core20_AddressIn[31:0]),
                                        .inaddr21(Core21_AddressIn[31:0]), .inaddr22(Core22_AddressIn[31:0]), .inaddr23(Core23_AddressIn[31:0]), 
										.inaddr24(Core24_AddressIn[31:0]), .inaddr25(Core25_AddressIn[31:0]), .inaddr26(Core26_AddressIn[31:0]), 
										.inaddr27(Core27_AddressIn[31:0]), .inaddr28(Core28_AddressIn[31:0]), .inaddr29(Core29_AddressIn[31:0]), 
										.inaddr30(Core30_AddressIn[31:0]), .inaddr31(Core31_AddressIn[31:0]), 
										.selectLine(SelectCore_to_Bank15) , .enable(Grant_Bank15), .outdata(Bank15_AddressOut)) ;


   DataDeMultiplexer  u_DataDeMultiplexer0( .indata   (Bank0_DataIn), .selection(SelectCore_to_Bank0), .enable(Done_Bank0) ,
                                            .outdata0 (Core0_B0_DataOut),  .outdata1 (Core1_B0_DataOut),  .outdata2 (Core2_B0_DataOut),  .outdata3 (Core3_B0_DataOut),  
											.outdata4 (Core4_B0_DataOut),  .outdata5 (Core5_B0_DataOut), .outdata6 (Core6_B0_DataOut),  .outdata7 (Core7_B0_DataOut), 
											.outdata8 (Core8_B0_DataOut),  .outdata9 (Core9_B0_DataOut),  .outdata10(Core10_B0_DataOut), .outdata11(Core11_B0_DataOut),
                                            .outdata12(Core12_B0_DataOut), .outdata13(Core13_B0_DataOut), .outdata14(Core14_B0_DataOut), .outdata15(Core15_B0_DataOut), 
											.outdata16(Core16_B0_DataOut), .outdata17(Core17_B0_DataOut), .outdata18(Core18_B0_DataOut), .outdata19(Core19_B0_DataOut),
											.outdata20(Core20_B0_DataOut), .outdata21(Core21_B0_DataOut), .outdata22(Core22_B0_DataOut), .outdata23(Core23_B0_DataOut),
                                            .outdata24(Core24_B0_DataOut), .outdata25(Core25_B0_DataOut), .outdata26(Core26_B0_DataOut), .outdata27(Core27_B0_DataOut), 
											.outdata28(Core28_B0_DataOut), .outdata29(Core29_B0_DataOut), .outdata30(Core30_B0_DataOut), .outdata31(Core31_B0_DataOut) ) ;



   DataDeMultiplexer  u_DataDeMultiplexer1( .indata   (Bank1_DataIn), .selection(SelectCore_to_Bank1), .enable(Done_Bank1) ,
                                            .outdata0 (Core0_B1_DataOut),  .outdata1 (Core1_B1_DataOut),  .outdata2 (Core2_B1_DataOut),  .outdata3 (Core3_B1_DataOut),  
											.outdata4 (Core4_B1_DataOut),  .outdata5 (Core5_B1_DataOut), .outdata6 (Core6_B1_DataOut),  .outdata7 (Core7_B1_DataOut), 
											.outdata8 (Core8_B1_DataOut),  .outdata9 (Core9_B1_DataOut),  .outdata10(Core10_B1_DataOut), .outdata11(Core11_B1_DataOut),
                                            .outdata12(Core12_B1_DataOut), .outdata13(Core13_B1_DataOut), .outdata14(Core14_B1_DataOut), .outdata15(Core15_B1_DataOut), 
											.outdata16(Core16_B1_DataOut), .outdata17(Core17_B1_DataOut), .outdata18(Core18_B1_DataOut), .outdata19(Core19_B1_DataOut),
											.outdata20(Core20_B1_DataOut), .outdata21(Core21_B1_DataOut), .outdata22(Core22_B1_DataOut), .outdata23(Core23_B1_DataOut),
                                            .outdata24(Core24_B1_DataOut), .outdata25(Core25_B1_DataOut), .outdata26(Core26_B1_DataOut), .outdata27(Core27_B1_DataOut), 
											.outdata28(Core28_B1_DataOut), .outdata29(Core29_B1_DataOut), .outdata30(Core30_B1_DataOut), .outdata31(Core31_B1_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer2( .indata   (Bank2_DataIn), .selection(SelectCore_to_Bank2), .enable(Done_Bank2) ,
                                            .outdata0 (Core0_B2_DataOut),  .outdata1 (Core1_B2_DataOut),  .outdata2 (Core2_B2_DataOut),  .outdata3 (Core3_B2_DataOut),  
											.outdata4 (Core4_B2_DataOut),  .outdata5 (Core5_B2_DataOut), .outdata6 (Core6_B2_DataOut),  .outdata7 (Core7_B2_DataOut), 
											.outdata8 (Core8_B2_DataOut),  .outdata9 (Core9_B2_DataOut),  .outdata10(Core10_B2_DataOut), .outdata11(Core11_B2_DataOut),
                                            .outdata12(Core12_B2_DataOut), .outdata13(Core13_B2_DataOut), .outdata14(Core14_B2_DataOut), .outdata15(Core15_B2_DataOut), 
											.outdata16(Core16_B2_DataOut), .outdata17(Core17_B2_DataOut), .outdata18(Core18_B2_DataOut), .outdata19(Core19_B2_DataOut),
											.outdata20(Core20_B2_DataOut), .outdata21(Core21_B2_DataOut), .outdata22(Core22_B2_DataOut), .outdata23(Core23_B2_DataOut),
                                            .outdata24(Core24_B2_DataOut), .outdata25(Core25_B2_DataOut), .outdata26(Core26_B2_DataOut), .outdata27(Core27_B2_DataOut), 
											.outdata28(Core28_B2_DataOut), .outdata29(Core29_B2_DataOut), .outdata30(Core30_B2_DataOut), .outdata31(Core31_B2_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer3( .indata   (Bank3_DataIn), .selection(SelectCore_to_Bank3), .enable(Done_Bank3) ,
                                            .outdata0 (Core0_B3_DataOut),  .outdata1 (Core1_B3_DataOut),  .outdata2 (Core2_B3_DataOut),  .outdata3 (Core3_B3_DataOut),  
											.outdata4 (Core4_B3_DataOut),  .outdata5 (Core5_B3_DataOut), .outdata6 (Core6_B3_DataOut),  .outdata7 (Core7_B3_DataOut), 
											.outdata8 (Core8_B3_DataOut),  .outdata9 (Core9_B3_DataOut),  .outdata10(Core10_B3_DataOut), .outdata11(Core11_B3_DataOut),
                                            .outdata12(Core12_B3_DataOut), .outdata13(Core13_B3_DataOut), .outdata14(Core14_B3_DataOut), .outdata15(Core15_B3_DataOut), 
											.outdata16(Core16_B3_DataOut), .outdata17(Core17_B3_DataOut), .outdata18(Core18_B3_DataOut), .outdata19(Core19_B3_DataOut),
											.outdata20(Core20_B3_DataOut), .outdata21(Core21_B3_DataOut), .outdata22(Core22_B3_DataOut), .outdata23(Core23_B3_DataOut),
                                            .outdata24(Core24_B3_DataOut), .outdata25(Core25_B3_DataOut), .outdata26(Core26_B3_DataOut), .outdata27(Core27_B3_DataOut), 
											.outdata28(Core28_B3_DataOut), .outdata29(Core29_B3_DataOut), .outdata30(Core30_B3_DataOut), .outdata31(Core31_B3_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer4( .indata   (Bank4_DataIn), .selection(SelectCore_to_Bank4), .enable(Done_Bank4) ,
                                            .outdata0 (Core0_B4_DataOut),  .outdata1 (Core1_B4_DataOut),  .outdata2 (Core2_B4_DataOut),  .outdata3 (Core3_B4_DataOut),  
											.outdata4 (Core4_B4_DataOut),  .outdata5 (Core5_B4_DataOut), .outdata6 (Core6_B4_DataOut),  .outdata7 (Core7_B4_DataOut), 
											.outdata8 (Core8_B4_DataOut),  .outdata9 (Core9_B4_DataOut),  .outdata10(Core10_B4_DataOut), .outdata11(Core11_B4_DataOut),
                                            .outdata12(Core12_B4_DataOut), .outdata13(Core13_B4_DataOut), .outdata14(Core14_B4_DataOut), .outdata15(Core15_B4_DataOut), 
											.outdata16(Core16_B4_DataOut), .outdata17(Core17_B4_DataOut), .outdata18(Core18_B4_DataOut), .outdata19(Core19_B4_DataOut),
											.outdata20(Core20_B4_DataOut), .outdata21(Core21_B4_DataOut), .outdata22(Core22_B4_DataOut), .outdata23(Core23_B4_DataOut),
                                            .outdata24(Core24_B4_DataOut), .outdata25(Core25_B4_DataOut), .outdata26(Core26_B4_DataOut), .outdata27(Core27_B4_DataOut), 
											.outdata28(Core28_B4_DataOut), .outdata29(Core29_B4_DataOut), .outdata30(Core30_B4_DataOut), .outdata31(Core31_B4_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer5( .indata   (Bank5_DataIn), .selection(SelectCore_to_Bank5), .enable(Done_Bank5) ,
                                            .outdata0 (Core0_B5_DataOut),  .outdata1 (Core1_B5_DataOut),  .outdata2 (Core2_B5_DataOut),  .outdata3 (Core3_B5_DataOut),  
											.outdata4 (Core4_B5_DataOut),  .outdata5 (Core5_B5_DataOut), .outdata6 (Core6_B5_DataOut),  .outdata7 (Core7_B5_DataOut), 
											.outdata8 (Core8_B5_DataOut),  .outdata9 (Core9_B5_DataOut),  .outdata10(Core10_B5_DataOut), .outdata11(Core11_B5_DataOut),
                                            .outdata12(Core12_B5_DataOut), .outdata13(Core13_B5_DataOut), .outdata14(Core14_B5_DataOut), .outdata15(Core15_B5_DataOut), 
											.outdata16(Core16_B5_DataOut), .outdata17(Core17_B5_DataOut), .outdata18(Core18_B5_DataOut), .outdata19(Core19_B5_DataOut),
											.outdata20(Core20_B5_DataOut), .outdata21(Core21_B5_DataOut), .outdata22(Core22_B5_DataOut), .outdata23(Core23_B5_DataOut),
                                            .outdata24(Core24_B5_DataOut), .outdata25(Core25_B5_DataOut), .outdata26(Core26_B5_DataOut), .outdata27(Core27_B5_DataOut), 
											.outdata28(Core28_B5_DataOut), .outdata29(Core29_B5_DataOut), .outdata30(Core30_B5_DataOut), .outdata31(Core31_B5_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer6( .indata   (Bank6_DataIn), .selection(SelectCore_to_Bank6), .enable(Done_Bank6) ,
                                            .outdata0 (Core0_B6_DataOut),  .outdata1 (Core1_B6_DataOut),  .outdata2 (Core2_B6_DataOut),  .outdata3 (Core3_B6_DataOut),  
											.outdata4 (Core4_B6_DataOut),  .outdata5 (Core5_B6_DataOut), .outdata6 (Core6_B6_DataOut),  .outdata7 (Core7_B6_DataOut), 
											.outdata8 (Core8_B6_DataOut),  .outdata9 (Core9_B6_DataOut),  .outdata10(Core10_B6_DataOut), .outdata11(Core11_B6_DataOut),
                                            .outdata12(Core12_B6_DataOut), .outdata13(Core13_B6_DataOut), .outdata14(Core14_B6_DataOut), .outdata15(Core15_B6_DataOut), 
											.outdata16(Core16_B6_DataOut), .outdata17(Core17_B6_DataOut), .outdata18(Core18_B6_DataOut), .outdata19(Core19_B6_DataOut),
											.outdata20(Core20_B6_DataOut), .outdata21(Core21_B6_DataOut), .outdata22(Core22_B6_DataOut), .outdata23(Core23_B6_DataOut),
                                            .outdata24(Core24_B6_DataOut), .outdata25(Core25_B6_DataOut), .outdata26(Core26_B6_DataOut), .outdata27(Core27_B6_DataOut), 
											.outdata28(Core28_B6_DataOut), .outdata29(Core29_B6_DataOut), .outdata30(Core30_B6_DataOut), .outdata31(Core31_B6_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer7( .indata   (Bank7_DataIn), .selection(SelectCore_to_Bank7), .enable(Done_Bank7) ,
                                            .outdata0 (Core0_B7_DataOut),  .outdata1 (Core1_B7_DataOut),  .outdata2 (Core2_B7_DataOut),  .outdata3 (Core3_B7_DataOut),  
											.outdata4 (Core4_B7_DataOut),  .outdata5 (Core5_B7_DataOut), .outdata6 (Core6_B7_DataOut),  .outdata7 (Core7_B7_DataOut), 
											.outdata8 (Core8_B7_DataOut),  .outdata9 (Core9_B7_DataOut),  .outdata10(Core10_B7_DataOut), .outdata11(Core11_B7_DataOut),
                                            .outdata12(Core12_B7_DataOut), .outdata13(Core13_B7_DataOut), .outdata14(Core14_B7_DataOut), .outdata15(Core15_B7_DataOut), 
											.outdata16(Core16_B7_DataOut), .outdata17(Core17_B7_DataOut), .outdata18(Core18_B7_DataOut), .outdata19(Core19_B7_DataOut),
											.outdata20(Core20_B7_DataOut), .outdata21(Core21_B7_DataOut), .outdata22(Core22_B7_DataOut), .outdata23(Core23_B7_DataOut),
                                            .outdata24(Core24_B7_DataOut), .outdata25(Core25_B7_DataOut), .outdata26(Core26_B7_DataOut), .outdata27(Core27_B7_DataOut), 
											.outdata28(Core28_B7_DataOut), .outdata29(Core29_B7_DataOut), .outdata30(Core30_B7_DataOut), .outdata31(Core31_B7_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer8( .indata   (Bank8_DataIn), .selection(SelectCore_to_Bank8), .enable(Done_Bank8) ,
                                            .outdata0 (Core0_B8_DataOut),  .outdata1 (Core1_B8_DataOut),  .outdata2 (Core2_B8_DataOut),  .outdata3 (Core3_B8_DataOut),  
											.outdata4 (Core4_B8_DataOut),  .outdata5 (Core5_B8_DataOut), .outdata6 (Core6_B8_DataOut),  .outdata7 (Core7_B8_DataOut), 
											.outdata8 (Core8_B8_DataOut),  .outdata9 (Core9_B8_DataOut),  .outdata10(Core10_B8_DataOut), .outdata11(Core11_B8_DataOut),
                                            .outdata12(Core12_B8_DataOut), .outdata13(Core13_B8_DataOut), .outdata14(Core14_B8_DataOut), .outdata15(Core15_B8_DataOut), 
											.outdata16(Core16_B8_DataOut), .outdata17(Core17_B8_DataOut), .outdata18(Core18_B8_DataOut), .outdata19(Core19_B8_DataOut),
											.outdata20(Core20_B8_DataOut), .outdata21(Core21_B8_DataOut), .outdata22(Core22_B8_DataOut), .outdata23(Core23_B8_DataOut),
                                            .outdata24(Core24_B8_DataOut), .outdata25(Core25_B8_DataOut), .outdata26(Core26_B8_DataOut), .outdata27(Core27_B8_DataOut), 
											.outdata28(Core28_B8_DataOut), .outdata29(Core29_B8_DataOut), .outdata30(Core30_B8_DataOut), .outdata31(Core31_B8_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer9( .indata   (Bank9_DataIn), .selection(SelectCore_to_Bank9), .enable(Done_Bank9) ,
                                            .outdata0 (Core0_B9_DataOut),  .outdata1 (Core1_B9_DataOut),  .outdata2 (Core2_B9_DataOut),  .outdata3 (Core3_B9_DataOut),  
											.outdata4 (Core4_B9_DataOut),  .outdata5 (Core5_B9_DataOut), .outdata6 (Core6_B9_DataOut),  .outdata7 (Core7_B9_DataOut), 
											.outdata8 (Core8_B9_DataOut),  .outdata9 (Core9_B9_DataOut),  .outdata10(Core10_B9_DataOut), .outdata11(Core11_B9_DataOut),
                                            .outdata12(Core12_B9_DataOut), .outdata13(Core13_B9_DataOut), .outdata14(Core14_B9_DataOut), .outdata15(Core15_B9_DataOut), 
											.outdata16(Core16_B9_DataOut), .outdata17(Core17_B9_DataOut), .outdata18(Core18_B9_DataOut), .outdata19(Core19_B9_DataOut),
											.outdata20(Core20_B9_DataOut), .outdata21(Core21_B9_DataOut), .outdata22(Core22_B9_DataOut), .outdata23(Core23_B9_DataOut),
                                            .outdata24(Core24_B9_DataOut), .outdata25(Core25_B9_DataOut), .outdata26(Core26_B9_DataOut), .outdata27(Core27_B9_DataOut), 
											.outdata28(Core28_B9_DataOut), .outdata29(Core29_B9_DataOut), .outdata30(Core30_B9_DataOut), .outdata31(Core31_B9_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer10( .indata   (Bank10_DataIn), .selection(SelectCore_to_Bank10), .enable(Done_Bank10) ,
                                            .outdata0 (Core0_B10_DataOut),  .outdata1 (Core1_B10_DataOut),  .outdata2 (Core2_B10_DataOut),  .outdata3 (Core3_B10_DataOut),  
											.outdata4 (Core4_B10_DataOut),  .outdata5 (Core5_B10_DataOut), .outdata6 (Core6_B10_DataOut),  .outdata7 (Core7_B10_DataOut), 
											.outdata8 (Core8_B10_DataOut),  .outdata9 (Core9_B10_DataOut),  .outdata10(Core10_B10_DataOut), .outdata11(Core11_B10_DataOut),
                                            .outdata12(Core12_B10_DataOut), .outdata13(Core13_B10_DataOut), .outdata14(Core14_B10_DataOut), .outdata15(Core15_B10_DataOut), 
											.outdata16(Core16_B10_DataOut), .outdata17(Core17_B10_DataOut), .outdata18(Core18_B10_DataOut), .outdata19(Core19_B10_DataOut),
											.outdata20(Core20_B10_DataOut), .outdata21(Core21_B10_DataOut), .outdata22(Core22_B10_DataOut), .outdata23(Core23_B10_DataOut),
                                            .outdata24(Core24_B10_DataOut), .outdata25(Core25_B10_DataOut), .outdata26(Core26_B10_DataOut), .outdata27(Core27_B10_DataOut), 
											.outdata28(Core28_B10_DataOut), .outdata29(Core29_B10_DataOut), .outdata30(Core30_B10_DataOut), .outdata31(Core31_B10_DataOut) ) ;


   DataDeMultiplexer  u_DataDeMultiplexer11( .indata   (Bank11_DataIn), .selection(SelectCore_to_Bank11), .enable(Done_Bank11) ,
                                            .outdata0 (Core0_B11_DataOut),  .outdata1 (Core1_B11_DataOut),  .outdata2 (Core2_B11_DataOut),  .outdata3 (Core3_B11_DataOut),  
											.outdata4 (Core4_B11_DataOut),  .outdata5 (Core5_B11_DataOut), .outdata6 (Core6_B11_DataOut),  .outdata7 (Core7_B11_DataOut), 
											.outdata8 (Core8_B11_DataOut),  .outdata9 (Core9_B11_DataOut),  .outdata10(Core10_B11_DataOut), .outdata11(Core11_B11_DataOut),
                                            .outdata12(Core12_B11_DataOut), .outdata13(Core13_B11_DataOut), .outdata14(Core14_B11_DataOut), .outdata15(Core15_B11_DataOut), 
											.outdata16(Core16_B11_DataOut), .outdata17(Core17_B11_DataOut), .outdata18(Core18_B11_DataOut), .outdata19(Core19_B11_DataOut),
											.outdata20(Core20_B11_DataOut), .outdata21(Core21_B11_DataOut), .outdata22(Core22_B11_DataOut), .outdata23(Core23_B11_DataOut),
                                            .outdata24(Core24_B11_DataOut), .outdata25(Core25_B11_DataOut), .outdata26(Core26_B11_DataOut), .outdata27(Core27_B11_DataOut), 
											.outdata28(Core28_B11_DataOut), .outdata29(Core29_B11_DataOut), .outdata30(Core30_B11_DataOut), .outdata31(Core31_B11_DataOut) ) ;



   DataDeMultiplexer  u_DataDeMultiplexer12( .indata   (Bank12_DataIn), .selection(SelectCore_to_Bank12), .enable(Done_Bank12) ,
                                            .outdata0 (Core0_B12_DataOut),  .outdata1 (Core1_B12_DataOut),  .outdata2 (Core2_B12_DataOut),  .outdata3 (Core3_B12_DataOut),  
											.outdata4 (Core4_B12_DataOut),  .outdata5 (Core5_B12_DataOut), .outdata6 (Core6_B12_DataOut),  .outdata7 (Core7_B12_DataOut), 
											.outdata8 (Core8_B12_DataOut),  .outdata9 (Core9_B12_DataOut),  .outdata10(Core10_B12_DataOut), .outdata11(Core11_B12_DataOut),
                                            .outdata12(Core12_B12_DataOut), .outdata13(Core13_B12_DataOut), .outdata14(Core14_B12_DataOut), .outdata15(Core15_B12_DataOut), 
											.outdata16(Core16_B12_DataOut), .outdata17(Core17_B12_DataOut), .outdata18(Core18_B12_DataOut), .outdata19(Core19_B12_DataOut),
											.outdata20(Core20_B12_DataOut), .outdata21(Core21_B12_DataOut), .outdata22(Core22_B12_DataOut), .outdata23(Core23_B12_DataOut),
                                            .outdata24(Core24_B12_DataOut), .outdata25(Core25_B12_DataOut), .outdata26(Core26_B12_DataOut), .outdata27(Core27_B12_DataOut), 
											.outdata28(Core28_B12_DataOut), .outdata29(Core29_B12_DataOut), .outdata30(Core30_B12_DataOut), .outdata31(Core31_B12_DataOut) ) ;



   DataDeMultiplexer  u_DataDeMultiplexer13( .indata   (Bank13_DataIn), .selection(SelectCore_to_Bank13), .enable(Done_Bank13) ,
                                            .outdata0 (Core0_B13_DataOut),  .outdata1 (Core1_B13_DataOut),  .outdata2 (Core2_B13_DataOut),  .outdata3 (Core3_B13_DataOut),  
											.outdata4 (Core4_B13_DataOut),  .outdata5 (Core5_B13_DataOut), .outdata6 (Core6_B13_DataOut),  .outdata7 (Core7_B13_DataOut), 
											.outdata8 (Core8_B13_DataOut),  .outdata9 (Core9_B13_DataOut),  .outdata10(Core10_B13_DataOut), .outdata11(Core11_B13_DataOut),
                                            .outdata12(Core12_B13_DataOut), .outdata13(Core13_B13_DataOut), .outdata14(Core14_B13_DataOut), .outdata15(Core15_B13_DataOut), 
											.outdata16(Core16_B13_DataOut), .outdata17(Core17_B13_DataOut), .outdata18(Core18_B13_DataOut), .outdata19(Core19_B13_DataOut),
											.outdata20(Core20_B13_DataOut), .outdata21(Core21_B13_DataOut), .outdata22(Core22_B13_DataOut), .outdata23(Core23_B13_DataOut),
                                            .outdata24(Core24_B13_DataOut), .outdata25(Core25_B13_DataOut), .outdata26(Core26_B13_DataOut), .outdata27(Core27_B13_DataOut), 
											.outdata28(Core28_B13_DataOut), .outdata29(Core29_B13_DataOut), .outdata30(Core30_B13_DataOut), .outdata31(Core31_B13_DataOut) ) ;



   DataDeMultiplexer  u_DataDeMultiplexer14( .indata   (Bank14_DataIn), .selection(SelectCore_to_Bank14), .enable(Done_Bank14) ,
                                            .outdata0 (Core0_B14_DataOut),  .outdata1 (Core1_B14_DataOut),  .outdata2 (Core2_B14_DataOut),  .outdata3 (Core3_B14_DataOut),  
											.outdata4 (Core4_B14_DataOut),  .outdata5 (Core5_B14_DataOut), .outdata6 (Core6_B14_DataOut),  .outdata7 (Core7_B14_DataOut), 
											.outdata8 (Core8_B14_DataOut),  .outdata9 (Core9_B14_DataOut),  .outdata10(Core10_B14_DataOut), .outdata11(Core11_B14_DataOut),
                                            .outdata12(Core12_B14_DataOut), .outdata13(Core13_B14_DataOut), .outdata14(Core14_B14_DataOut), .outdata15(Core15_B14_DataOut), 
											.outdata16(Core16_B14_DataOut), .outdata17(Core17_B14_DataOut), .outdata18(Core18_B14_DataOut), .outdata19(Core19_B14_DataOut),
											.outdata20(Core20_B14_DataOut), .outdata21(Core21_B14_DataOut), .outdata22(Core22_B14_DataOut), .outdata23(Core23_B14_DataOut),
                                            .outdata24(Core24_B14_DataOut), .outdata25(Core25_B14_DataOut), .outdata26(Core26_B14_DataOut), .outdata27(Core27_B14_DataOut), 
											.outdata28(Core28_B14_DataOut), .outdata29(Core29_B14_DataOut), .outdata30(Core30_B14_DataOut), .outdata31(Core31_B14_DataOut) ) ;



   DataDeMultiplexer  u_DataDeMultiplexer15( .indata   (Bank15_DataIn), .selection(SelectCore_to_Bank15), .enable(Done_Bank15) ,
                                            .outdata0 (Core0_B15_DataOut),  .outdata1 (Core1_B15_DataOut),  .outdata2 (Core2_B15_DataOut),  .outdata3 (Core3_B15_DataOut),  
											.outdata4 (Core4_B15_DataOut),  .outdata5 (Core5_B15_DataOut), .outdata6 (Core6_B15_DataOut),  .outdata7 (Core7_B15_DataOut), 
											.outdata8 (Core8_B15_DataOut),  .outdata9 (Core9_B15_DataOut),  .outdata10(Core10_B15_DataOut), .outdata11(Core11_B15_DataOut),
                                            .outdata12(Core12_B15_DataOut), .outdata13(Core13_B15_DataOut), .outdata14(Core14_B15_DataOut), .outdata15(Core15_B15_DataOut), 
											.outdata16(Core16_B15_DataOut), .outdata17(Core17_B15_DataOut), .outdata18(Core18_B15_DataOut), .outdata19(Core19_B15_DataOut),
											.outdata20(Core20_B15_DataOut), .outdata21(Core21_B15_DataOut), .outdata22(Core22_B15_DataOut), .outdata23(Core23_B15_DataOut),
                                            .outdata24(Core24_B15_DataOut), .outdata25(Core25_B15_DataOut), .outdata26(Core26_B15_DataOut), .outdata27(Core27_B15_DataOut), 
											.outdata28(Core28_B15_DataOut), .outdata29(Core29_B15_DataOut), .outdata30(Core30_B15_DataOut), .outdata31(Core31_B15_DataOut) ) ;





endmodule

