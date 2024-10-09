module ENCRYPTION_R2 (
  input     [63:0] r2    ,
  input     [31:0]p     ,
  input     [63:0]exp   ,
  input           clk   ,
  input           rst   ,
  input           done_c_i   ,
  output reg      done_enc2  ,
  output reg[63:0] k_o  , 
  output reg[63:0] c1
  );
  
  reg [63:0] value ;
  reg [63:0] value_2;
  reg [63:0] k_2 ;
  
  always@(posedge clk or negedge rst)
  begin
   if(!rst)
     begin
      c1    <= 0 ;
      value_2 <= 0;
      k_o   <= 0 ;
      value <= 0 ;
      k_2   <= 0 ;
      done_enc2 <= 0 ;
     end
   else if (done_c_i)
     begin
      value <= exp/p       ;
      value_2   <= value*p     ;
      k_2   <= exp-value_2       ;
      c1    <=  k_2  ^ r2      ;
      k_o   <=  k_2            ;
      done_enc2 <= 1         ;
     end
   else
     begin
      c1    <= 0 ;
      k_o   <= 0 ;
      value <= 0 ;
      k_2   <= 0 ;
      done_enc2 <= 0 ;
     end
  end
endmodule
