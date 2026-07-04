module FrequencyDivider2 (
    input clk_in,
    input reset,
    output reg clk_out
);
    reg s;

    always @(posedge clk_in) begin
        if (reset) begin
            s <= 0;
        end
        else begin
            clk_out <= clk_in ^ s;
            s <= ~s;
        end
    end
endmodule