module CONTROLKER (
  input             clk     ,
  input             rst     ,
  input             true_1  ,
  input             true_2  ,
  output reg [47:0] out
  );
  
  
  reg [1:0] curent_state , next_state ;
  
  
  
  localparam       ideal   =  0  ,
                   check_1 = 'b1 ,
                   check_2 = 'b11;
                     
  always@(posedge clk or negedge rst )
  begin
  if(!rst) 
      curent_state <= ideal ;
    else
      curent_state <= next_state ;
  end
  
  
  always@(*)
  begin
   case(curent_state)
       ideal  :
                begin
                  if(true_1)
                    next_state = check_1 ;
                  else
                    next_state = ideal   ;
                end
                
        
       check_1 : 
                 begin
                  if(true_2)
                    next_state = check_2 ;
                  else
                    next_state = check_1 ;
                 end
       
       check_2 :
                 begin
                  if(true_2)
                    next_state = check_2 ;
                  else
                    next_state = ideal   ;
                 end
                 
      default  :
                    next_state = ideal   ; 
                    
    endcase          
 end               
                    
 always@(*)
 begin
   case(curent_state)
       ideal   :   out = 0;
       check_1 :   out = 0;
       check_2 :   out = 'b010000010100001101000011010001010101000001010100; // ACCEPT
       default :   out = 0;
                    
   endcase
  end
endmodule
 
 
 
            