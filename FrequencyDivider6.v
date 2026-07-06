// ==============Делитель частоты на 6============================
// IN:          clk_in  - входной меандр
// OUT:         clk_out - меандр с частотой в шесть раз меньше
// ===============================================================
module FrequencyDivider6 (
    input clk_in,
    input reset,
    output reg clk_out
);
    // внутреннее состояние (3 состояния)
    reg [1:0] s;

    always @(posedge clk_in) begin
        if (reset) begin
            s <= 0;
            clk_out <= 0;
        end
        else begin 
            if (s == 2) begin // если мы прождали 3 такта, то меняем состояние на противоположное
                s <= 0;
                clk_out <= ~clk_out;
            end
            else begin // иначе оставляем то же состояние
                s <= s + 1;
                clk_out <= clk_out;
            end
        end
    end
endmodule