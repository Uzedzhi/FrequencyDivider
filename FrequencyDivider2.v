// ==============Делитель частоты на 2============================
// IN:          clk_in  - входной меандр
// OUT:         clk_out - меандр с частотой в два раза меньше
// ===============================================================
module FrequencyDivider2 (
    input clk_in,
    input reset,
    output reg clk_out
);

    always @(posedge clk_in) begin
        if (reset) begin
            clk_out <= 0;
        end
        else begin
            clk_out <= ~clk_out;
        end
    end
endmodule