module ENCRYPTION_R1 (
  input     [63:0] r2         ,
  input     [63:0] r1         ,
  input     [63:0] c1         ,
  input     [31:0] p          ,
  input     [63:0] exp        ,
  input            clk        ,
  input            done_i_enc2,
  input            rst        ,
  output reg       true       ,
  output reg[63:0] c2    
  );
  
  reg [63:0] value_1 , value_2;
  reg [63:0] k_1     ;
  reg [63:0] r2_new  ;
  
  always@(posedge clk or negedge rst)
  begin
   if(!rst)
     begin
      c2      <= 'hf ; 
      true    <= 0   ;
      value_1 <= 0   ;
      value_2 <= 0   ;
      k_1     <= 0   ;
      r2_new  <= 0   ; 
     end
     
   else if(done_i_enc2)
     begin
      value_1 <= exp/p         ;
      value_2 <= value_1*p     ;
      k_1     <= exp - value_2 ;
      r2_new  <= k_1 ^ c1      ;  
      if (r2_new != r2 )
       begin
        c2    <= 0 ;
        true  <= 0;
       end
      else
       begin
        c2    <= k_1 ^ r1 ;
        true  <= 1        ;
       end
      end
      
    else
     begin
      c2      <= 'hf ; 
      true    <= 0   ;
      value_1 <= 0   ;
      value_2 <= 0   ;
      k_1     <= 0   ;
      r2_new  <= 0   ; 
     end
    end
endmodule
 