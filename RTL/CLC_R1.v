
module CLC_R1(
  input     [31:0]   g  ,
  input     [31:0]   p  ,
  input     [31:0]   x  ,
  input              st ,
  input              clk,
  input              rst,
  output reg[3:0]    r1
  );
  
/*
equ  >>> R1 = g^x mod p  
5^3 mod 17

125 / 17 = 7.352...

125 - 7 x 17 = 6
*/ 
reg [63:0] value ;


  always@(posedge clk or negedge rst)
  begin
  if(!rst)
    begin
      r1    = 0;
      value = 0;
    end
    else if(st)
      begin
        value = (g**x)/p       ;  
        r1    = (g**x)-value*p ;
      end
    end
endmodule        
  
  
  
  
  
  

