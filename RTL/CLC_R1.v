
module CLC_R1(
  input     [63:0]   exp, // input from U0_exponentiation (g^x) 
  input     [31:0]   p  , 
  input              st , // input from U0_exponentiation 
  input              clk,
  input              rst,
  output reg[63:0]   r1
  );
  
/*
equ  >>> R1 = g^x mod p  
5^3 mod 17

125 / 17 = 7.352...

125 - 7 x 17 = 6
*/ 

reg [63:0] value_1 , value_2 ; // to divide operations to multiple steps 


  always@(posedge clk or negedge rst)
  begin
  if(!rst)
    begin
      r1      <= 0;
      value_1 <= 0;
      value_2 <= 1;
    end
    else if(st)
      begin
        value_1 <= exp/p          ;  
        value_2 <= value_1*p      ;
        r1      <= exp - value_2  ;
      end
    else
      begin
        r1      <= 0;
        value_1 <= 0;
        value_2 <= 1;
      end
    end
endmodule        
  
  
  
  
  
  
