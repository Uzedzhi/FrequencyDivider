module FrequencyDivider6 (
    input clk_in,
    input reset,
    output reg clk_out
);
    reg [1:0] s;

    always @(posedge clk_in) begin
        if (reset) begin
            s <= 0;
            clk_out <= 0;
        end
        else begin
            if (s == 2) begin
                s <= 0;
                clk_out <= ~clk_out;
            end
            else begin
                s <= s + 1;
                clk_out <= clk_out;
            end
        end
    end
endmodule