module CONTROLKER (
  input clk     ,
  input rst     ,
  input true_1  ,
  input true_2  ,
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
                    curent_state = check_1 ;
                  else
                    curent_state = ideal   ;
                end
                
        
       check_1 : 
                 begin
                  if(true_2)
                    curent_state = check_2 ;
                  else
                    curent_state = ideal   ;
                 end
       
       check_2 :
                 begin
                  if(true_2)
                    curent_state = check_2 ;
                  else
                    curent_state = ideal   ;
                 end
                 
      default  :
                    curent_state = ideal   ; 
                    
    endcase          
 end               
                    
 always@(*)
 begin
   case(curent_state)
       ideal   :   out = 0;
       check_1 :   out = 0;
       check_2 :   out = 'b01000001-01000011-01000011-01000101-01010000-01010100; // ACCEPT
     endcase
  end
endmodule
 
 
 
            