
module CLC_R1(
  input     [63:0]   exp,
  input     [31:0]   p  ,
  input              st ,
  input              clk,
  input              rst,
  output reg[31:0]    r1
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
        value = exp/p       ;  
        r1    = exp-value*p ;
      end
    else
      begin
        r1    = 0;
        value = 0;
      end
    end
endmodule        
  
  
  
  
  
  

