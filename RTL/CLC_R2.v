module CLC_R2(
  input     [31:0]   g  ,
  input     [31:0]   p  ,
  input     [31:0]   y  ,
  input              st ,
  input              clk,
  input              rst,
  output reg[3:0]    r2
  );
  
//equ  >>> R1 = g^x mod p   
reg [31:0] value ;


  always@(posedge clk or negedge rst)
  begin
  if(!rst)
    begin
      r2    = 0;
      value = 0;
    end
    else if(st)
      begin
        value = (g**y)/p       ;  
        r2    = (g**y)-value*p ;
      end
    end
endmodule        
  
  
  
  
  
  

