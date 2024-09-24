module Diffe_TB ();
  reg CLK_tb      ;
  reg RST_tb      ;
  reg ST_tb       ;
  reg [31:0]G_tb  ;
  reg [31:0]P_tb  ;
  reg [31:0]Y_tb  ;
  reg [31:0]X_tb  ;
  wire[47:0]OUT_tb;



Diffe_TOP DUT (
.CLK(CLK_tb)   ,
.RST(RST_tb)   ,
.ST(ST_tb)     ,
.G(G_tb)       ,
.P(P_tb)       ,
.Y(Y_tb)       ,
.X(X_tb)       ,
.OUT(OUT_tb) 
);

always #5 CLK_tb = !CLK_tb ;


initial 
begin
   CLK_tb = 0    ;
   RST_tb = 0    ;
   ST_tb  = 0    ;
   G_tb   = 'd17 ;
   P_tb   = 'd5  ;
   Y_tb   = 'd8  ;
   X_tb   = 'd6 ;
   
   #10 
   
   RST_tb = 1  ;
    
   #10
   
   ST_tb  = 1    ;
   G_tb   = 'd17 ;
   P_tb   = 'd5  ;
   Y_tb   = 'd8  ;
   X_tb   = 'd6  ;
   /*
   #60
   
   ST_tb  = 0    ;
   */
   #200
   $finish ;
 end
 endmodule
   
    
   