module exponentiation (
    input             clk     ,
    input             rst     ,
    input             start   ,
    input      [31:0] base    ,
    input      [31:0] exponent,
    output reg [63:0] result  ,
    output reg        done
);
    reg [31:0] count;
    reg [31:0] temp ;

    always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
         begin
            result <= 1;
            temp   <= 0;
            count  <= 0;
            done   <= 0;
         end 
         
        else if (start) 
         begin
          if (count < exponent) 
             begin
                result <= result[31:0] * temp;
                count  <= count + 1;
             end 
           else 
              begin
                temp <= base;
                done <= 1;
            end
         end
         
        else
              begin
                result <= 1;
                temp   <= 0;
                count  <= 0;
                done   <= 0;
              end
    end
endmodule
