
module AddressMultiplexer (
 inaddr0  , inaddr1  , inaddr2  , inaddr3  , inaddr4  , inaddr5  , inaddr6  ,
 inaddr7  , inaddr8  , inaddr9  , inaddr10 , inaddr11 , inaddr12 , inaddr13 ,
 inaddr14 , inaddr15 , inaddr16 , inaddr17 , inaddr18 , inaddr19 , inaddr20 ,
 inaddr21 , inaddr22 , inaddr23 , inaddr24 , inaddr25 , inaddr26 , inaddr27 ,
 inaddr28 , inaddr29 , inaddr30 , inaddr31 , selectLine , enable, outdata) ;

 input [31:0] inaddr0  , inaddr1  , inaddr2  , inaddr3  , inaddr4  , inaddr5  , inaddr6  ,
              inaddr7  , inaddr8  , inaddr9  , inaddr10 , inaddr11 , inaddr12 , inaddr13 ,
              inaddr14 , inaddr15 , inaddr16 , inaddr17 , inaddr18 , inaddr19 , inaddr20 ,
              inaddr21 , inaddr22 , inaddr23 , inaddr24 , inaddr25 , inaddr26 , inaddr27 ,
              inaddr28 , inaddr29 , inaddr30 , inaddr31 ;
 input [4:0] selectLine ;
 input enable ;
 output [31:0] outdata ;
 wire [31:0] outdata_buf ;


 assign outdata_buf = (selectLine === 5'b00000) ? inaddr0  :
                  (selectLine === 5'b00001) ? inaddr1  :
                  (selectLine === 5'b00010) ? inaddr2  :
                  (selectLine === 5'b00011) ? inaddr3  :
                  (selectLine === 5'b00100) ? inaddr4  :
                  (selectLine === 5'b00101) ? inaddr5  :
                  (selectLine === 5'b00110) ? inaddr6  :
                  (selectLine === 5'b00111) ? inaddr7  :
                  (selectLine === 5'b01000) ? inaddr8  :
                  (selectLine === 5'b01001) ? inaddr9  :
                  (selectLine === 5'b01010) ? inaddr10 :
                  (selectLine === 5'b01011) ? inaddr11 :
                  (selectLine === 5'b01100) ? inaddr12 :
                  (selectLine === 5'b01101) ? inaddr13 :
                  (selectLine === 5'b01110) ? inaddr14 :
                  (selectLine === 5'b01111) ? inaddr15 :
                  (selectLine === 5'b10000) ? inaddr16 :
                  (selectLine === 5'b10001) ? inaddr17 :
                  (selectLine === 5'b10010) ? inaddr18 :
                  (selectLine === 5'b10011) ? inaddr19 :
                  (selectLine === 5'b10100) ? inaddr20 :
                  (selectLine === 5'b10101) ? inaddr21 :
                  (selectLine === 5'b10110) ? inaddr22 :
                  (selectLine === 5'b10111) ? inaddr23 :
                  (selectLine === 5'b11000) ? inaddr24 :
                  (selectLine === 5'b11001) ? inaddr25 :
                  (selectLine === 5'b11010) ? inaddr26 :
                  (selectLine === 5'b11011) ? inaddr27 :
                  (selectLine === 5'b11100) ? inaddr28 :
                  (selectLine === 5'b11101) ? inaddr29 :
                  (selectLine === 5'b11110) ? inaddr30 :
                  (selectLine === 5'b11111) ? inaddr31 : 32'hzzzzzzzz ;

 assign outdata = enable ? outdata_buf : 32'hzzzzzzzz ;


 endmodule
