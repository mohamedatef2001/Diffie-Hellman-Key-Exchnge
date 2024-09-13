module ENCRYPTION_R2 (
  input     [3:0] r1    ,
  input     [3:0] r2    ,
  input     [31:0]p     ,
  input     [31:0]y     ,
  input           clk   ,
  input           rst   ,
  output reg[3:0] c1
  );
  
  reg [31:0] value ;
  reg [3:0] k_2 ;
  
  always@(posedge clk or negedge rst)
  begin
   if(!rst)
     begin
      c1    = 0 ;
      value = 0 ;
      k_2   = 0 ;
     end
   else
     begin
      value = (r1**y)/p       ;
      k_2   = (r1**y)-value*p ;
      c1    =  k_2  ^ r2      ;
     end
  end
endmodule