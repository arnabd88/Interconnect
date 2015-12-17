

//---- Simple 32 to 1 Demux -------------
module Demux (
  in, 
  sel,
  Out0 ,
  Out1 ,
  Out2 ,
  Out3 ,
  Out4 ,
  Out5 ,
  Out6 ,
  Out7 ,
  Out8 ,
  Out9 ,
  Out10,
  Out11,
  Out12,
  Out13,
  Out14,
  Out15
  ) ;

input in ;
input[3:0] sel ;
output Out0 , Out1 , Out2 , Out3 , Out4 , Out5 , Out6 , Out7 , Out8 ,
  Out9 , Out10, Out11, Out12, Out13, Out14, Out15 ;
 


assign Out0   =  (sel === 4'b0000) ? in : 1'b0 ;
assign Out1   =  (sel === 4'b0001) ? in : 1'b0 ;
assign Out2   =  (sel === 4'b0010) ? in : 1'b0 ;
assign Out3   =  (sel === 4'b0011) ? in : 1'b0 ;
assign Out4   =  (sel === 4'b0100) ? in : 1'b0 ;
assign Out5   =  (sel === 4'b0101) ? in : 1'b0 ;
assign Out6   =  (sel === 4'b0110) ? in : 1'b0 ;
assign Out7   =  (sel === 4'b0111) ? in : 1'b0 ;
assign Out8   =  (sel === 4'b1000) ? in : 1'b0 ;
assign Out9   =  (sel === 4'b1001) ? in : 1'b0 ;
assign Out10  =  (sel === 4'b1010) ? in : 1'b0 ;
assign Out11  =  (sel === 4'b1011) ? in : 1'b0 ;
assign Out12  =  (sel === 4'b1100) ? in : 1'b0 ;
assign Out13  =  (sel === 4'b1101) ? in : 1'b0 ;
assign Out14  =  (sel === 4'b1110) ? in : 1'b0 ;
assign Out15  =  (sel === 4'b1111) ? in : 1'b0 ;



endmodule
