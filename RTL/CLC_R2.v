module CLC_R2(
  input     [31:0]   p  ,
  input     [63:0]   exp, // input from U1_exponentiation (g^y)
  input              st , // input from U0_exponentiation 
  input              clk,
  input              rst,
  output reg[63:0]   r2
  );
  
//equ  >>> R1 = g^x mod p   
reg [63:0] value_1 , value_2; // to divide operations to multiple steps 


  always@(posedge clk or negedge rst)
  begin
  if(!rst)
    begin
      r2      <= 1;
      value_1 <= 1;
      value_2 <= 1;
    end
    else if(st)
      begin
        value_1 <= exp/p         ; 
        value_2 <= value_1*p     ;
        r2      <= exp - value_2 ;
      end
    else
      begin
        r2      <= 1;
        value_1 <= 1;
        value_2 <= 1;
      end
    end
endmodule        
  
  
  
  
  
  

