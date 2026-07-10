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
            // s==2 если мы прождали 3 такта, значит можно
            // сбрасывать состояние и переключать наш меандр
            s       <= (s == 2) ? 0 : s + 1;
            clk_out <= (s == 2) ? ~clk_out : clk_out;
        end
    end
endmodule