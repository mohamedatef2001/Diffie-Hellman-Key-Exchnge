module ENCRYPTION_R1 (
  input     [3:0] r2    ,
  input     [31:0] r1   ,
  input     [3:0] c1    ,
  input     [31:0]p     ,
  input     [31:0]x     ,
  input           clk   ,
  input           done_i_enc2,
  input           rst   ,
  output reg      true  ,
  output reg [3:0]c2    
  );
  
  reg [31:0] value ;
  reg [3:0] k_1   ;
  reg [31:0] r2_new  ;
  
  always@(posedge clk or negedge rst)
  begin
   if(!rst)
     begin
      c2    = 'hf ;
      true  = 0   ;
      value = 0   ;
      k_1   = 0   ;
      r2_new= 0   ; 
     end
   else if(done_i_enc2)
     begin
    value = (r2**x)/p       ;
    k_1   = (r2**x)-value*p ;
    r2_new= k_1 ^ c1        ;
    
    if (r2_new != r2 )
      begin
      c2   = 0 ;
      true = 0;
      end
    else
      begin
      c2   = k_1 ^ r1 ;
      true = 1        ;
      end
    end
  end
endmodule
