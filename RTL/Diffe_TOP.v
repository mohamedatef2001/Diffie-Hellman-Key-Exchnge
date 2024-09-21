module Diffe_TOP (
  input CLK      ,
  input RST      ,
  input ST       ,
  input [31:0]G  ,
  input [31:0]P  ,
  input [31:0]Y  ,
  input [31:0]X  ,
  output[47:0]OUT
  );
  
  
  
  wire [3:0] R1_C      
  ;
  wire [3:0] R2_C      ;
  wire [3:0] C1_C      ;
  wire [3:0] C2_C      ;
  wire [3:0] KEY_C     ;
  wire TRUE_1 , TRUE_2 ;


CLC_R1 U0_CLC_R1 (
.g(G)           ,
.p(P)           ,
.x(X)           ,
.st(ST)         ,
.clk(CLK)       ,
.rst(RST)       ,
.r1(R1_C)     
);


ENCRYPTION_R2 U0_ENCRYPTION_R2(
.r1(R1_C)       ,
.r2(R2_C)       ,
.p(P)           ,
.y(Y)           ,
.clk(CLK)       ,
.rst(RST)       ,
.c1(C1_C) 
);


CLC_R2 U0_CLC_R2 (
.g(G)           ,
.p(P)           ,
.y(Y)           ,
.st(ST)         ,
.clk(CLK)       ,
.rst(RST)       ,
.r2(R2_C)
);


ENCRYPTION_R1 U0_ENCRYPTION_R1 (
.r2(R2_C)       ,
.r1(R1_C)       ,
.c1(C1_C)       ,
.p(P)           ,
.x(X)           ,
.clk(CLK)       ,
.rst(RST)       ,
.true(TRUE_1)   ,
.k_o(KEY_C)     ,
.c2(C2_C)
);


CHECK_2 U0_CHECK_2 (
.k_i(KEY_C)     ,
.r_1(R1_C)      ,
.c_2_i(C2_C)    ,
.clk(CLK)       ,
.rst(RST)       ,
.true_2(TRUE_2) 
);


CONTROLKER U0_CONTROLKER (
.clk(CLK)       ,
.rst(RST)       ,
.true_1(TRUE_1) ,
.true_2(TRUE_2) ,
.out(OUT)
);


endmodule

