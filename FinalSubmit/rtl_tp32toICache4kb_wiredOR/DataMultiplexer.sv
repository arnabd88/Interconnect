
module DataDeMultiplexer(
  indata ,
  selection ,
  enable ,
  outdata0 , outdata1 , outdata2 , outdata3 , outdata4 , outdata5 ,
  outdata6 , outdata7 , outdata8 , outdata9 , outdata10, outdata11,
  outdata12, outdata13, outdata14, outdata15, outdata16, outdata17,
  outdata18, outdata19, outdata20, outdata21, outdata22, outdata23,
  outdata24, outdata25, outdata26, outdata27, outdata28, outdata29,
  outdata30, outdata31 ) ;


 input [31:0] indata ;
 input [4:0] selection ;
 input enable ;
 output [31:0] outdata0 , outdata1 , outdata2 , outdata3 , outdata4 , outdata5 ,
  outdata6 , outdata7 , outdata8 , outdata9 , outdata10, outdata11,
  outdata12, outdata13, outdata14, outdata15, outdata16, outdata17,
  outdata18, outdata19, outdata20, outdata21, outdata22, outdata23,
  outdata24, outdata25, outdata26, outdata27, outdata28, outdata29,
  outdata30, outdata31 ;


  assign outdata0    = ((selection === 5'b00000) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata1    = ((selection === 5'b00001) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata2    = ((selection === 5'b00010) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata3    = ((selection === 5'b00011) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata4    = ((selection === 5'b00100) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata5    = ((selection === 5'b00101) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata6    = ((selection === 5'b00110) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata7    = ((selection === 5'b00111) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata8    = ((selection === 5'b01000) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata9    = ((selection === 5'b01001) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata10   = ((selection === 5'b01010) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata11   = ((selection === 5'b01011) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata12   = ((selection === 5'b01100) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata13   = ((selection === 5'b01101) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata14   = ((selection === 5'b01110) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata15   = ((selection === 5'b01111) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata16   = ((selection === 5'b10000) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata17   = ((selection === 5'b10001) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata18   = ((selection === 5'b10010) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata19   = ((selection === 5'b10011) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata20   = ((selection === 5'b10100) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata21   = ((selection === 5'b10101) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata22   = ((selection === 5'b10110) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata23   = ((selection === 5'b10111) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata24   = ((selection === 5'b11000) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata25   = ((selection === 5'b11001) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata26   = ((selection === 5'b11010) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata27   = ((selection === 5'b11011) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata28   = ((selection === 5'b11100) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata29   = ((selection === 5'b11101) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata30   = ((selection === 5'b11110) && (enable==1)) ? indata : 32'h00000000 ;
  assign outdata31   = ((selection === 5'b11111) && (enable==1)) ? indata : 32'h00000000 ;

endmodule
