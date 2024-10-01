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
  
  
  
  wire [63:0] R1_C     ;
  wire [63:0] R2_C     ;
  wire [63:0] C1_C      ;
  wire [63:0] C2_C      ;
  wire [63:0] KEY_C     ;
  wire [63:0]RESULT_C1 ;
  wire [63:0]RESULT_C2 ;
  wire [63:0]EXP_C2    ;
  wire [63:0]EXP_C1    ;
  wire TRUE_1 , TRUE_2 , DONE_ENC2 , DONE_ENC1 , DONE_CLC1 , DONE_CLC2   ;


CLC_R1 U0_CLC_R1 (
.p(P)           ,
.exp(RESULT_C1)  ,
.st(DONE_CLC1)  ,
.clk(CLK)       ,
.rst(RST)       ,
.r1(R1_C)     
);


ENCRYPTION_R2 U0_ENCRYPTION_R2(
.r2(R2_C)       ,
.p(P)           ,
.exp(EXP_C2)    ,
.clk(CLK)       ,
.rst(RST)       ,
//.done_enc2(DONE_ENC2) ,
.k_o(KEY_C)     ,
.done_c_i(DONE_CLC2),
.c1(C1_C) 
);


CLC_R2 U0_CLC_R2 (
.p(P)           ,
.exp(RESULT_C2) ,
.st(DONE_CLC1)  ,
.clk(CLK)       ,
.rst(RST)       ,
.r2(R2_C)
);


ENCRYPTION_R1 U0_ENCRYPTION_R1 (
.r2(R2_C)       ,
.r1(R1_C)       ,
.c1(C1_C)       ,
.p(P)           ,
.exp(EXP_C1)    ,
.clk(CLK)       ,
.done_i_enc2(DONE_ENC2),
.rst(RST)       ,
.true(TRUE_1)   ,
//.done(DONE_C)   ,
//.k_o(KEY_C)     ,
.c2(C2_C)
);


CHECK_2 U0_CHECK_2 (
.k_i(KEY_C)     ,
.r_1(R1_C)      ,
.c_2_i(C2_C)    ,
.clk(CLK)       ,
.rst(RST)       ,
.done_i(DONE_ENC1) ,
.true_2(TRUE_2) 
);


CONTROLKER U0_CONTROLKER (
.clk(CLK)       ,
.rst(RST)       ,
.true_1(TRUE_1) ,
.true_2(TRUE_2) ,
.out(OUT)
);

exponentiation U0_exponentiation (
 .clk(CLK)        ,
 .rst(RST)        ,
 .start(ST)       ,
 .base(G)         ,
 .exponent(X)     ,
 .result(RESULT_C1),
 .done(DONE_CLC1)
 );
 
 exponentiation U1_exponentiation (
 .clk(CLK)        ,
 .rst(RST)        ,
 .start(ST)       ,
 .base(G)         ,
 .exponent(Y)     ,
 .result(RESULT_C2),
 .done(DONE_CLC2)
 );
 
 exponentiation_R U2_exponentiation_r (
 .clk(CLK)        ,
 .rst(RST)        ,
 .start(DONE_CLC2),
 .base(R1_C)      ,
 .exponent(Y)     ,
 .result(EXP_C2)  ,
 .done(DONE_ENC2)
 ); 


exponentiation_R U3_exponentiation_r (
 .clk(CLK)        ,
 .rst(RST)        ,
 .start(DONE_ENC2),
 .base(R2_C)      ,
 .exponent(X)     ,
 .result(EXP_C1)  ,
 .done(DONE_ENC1)
 ); 
endmodule

