module CLC_R2(
  input     [31:0]   p  ,
  input     [63:0]   exp,
  input              st ,
  input              clk,
  input              rst,
  output reg[63:0]    r2
  );
  
//equ  >>> R1 = g^x mod p   
//reg [63:0] value ;


  always@(posedge clk or negedge rst)
  begin
  if(!rst)
    begin
      r2    = 1;
      //value = 1;
    end
    else if(st)
      begin
    //    value = exp/p       ;  
        r2    = exp-(exp/p)*p ;
      end
    else
       begin
        r2    = 1;
       // value = 1;
       end
    end
endmodule        
  
  
  
  
  
  

