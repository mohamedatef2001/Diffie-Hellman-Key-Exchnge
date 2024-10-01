module CLC_R1_tb();
  reg   [31:0]   g_tb  ;
  reg   [31:0]   p_tb  ;
  reg   [31:0]   x_tb  ;
  reg            st_tb ;
  reg            clk_tb;
  reg            rst_tb;
  wire  [3:0]    r1_tb ;


test_32bits R1(
.g(g_tb)  ,
.p(p_tb)  ,
.x(x_tb)  ,
.st(st_tb),
.clk(clk_tb),
.rst(rst_tb),
.r1(r1_tb)
);


always #5 clk_tb = !clk_tb ;


initial
begin
  clk_tb = 0;
  g_tb   = 0;
  p_tb   = 0;
  x_tb   = 0;
  st_tb  = 0;
  rst_tb = 0;
  
  #10
  rst_tb = 1;
  #5
  
  g_tb   = 'd17;
  p_tb   = 'd5 ;
  x_tb   = 'd6 ; 
  st_tb  = 'd1 ;
  
  #10
  st_tb  = 'd0 ;
  
  #100
  $finish;
end
endmodule