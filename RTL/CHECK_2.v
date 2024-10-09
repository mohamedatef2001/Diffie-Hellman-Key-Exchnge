module CHECK_2 (
  input [63:0] k_i   ,
  input [63:0] r_1  ,
  input [63:0] c_2_i ,
  input clk , rst   ,
  input done_i      ,
  output reg  true_2 
  );
  
  
  reg [63:0] r1_new ;
  
  always@(posedge clk or negedge rst )
  begin
    if(!rst)
      begin
      true_2 <= 0 ;
      r1_new <= 0 ;
      end
    else if(done_i)
      begin
      r1_new <= c_2_i ^ k_i ;
      if (r1_new == r_1 )
        true_2 <= 1 ;
      else
        true_2 <= 0 ;
      end
    end
endmodule
