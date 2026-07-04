`include "FrequencyDivider2.v"
`include "FrequencyDivider6.v"

module TB();
    reg clk_in;
    reg reset;
    wire clk_out2;
    wire clk_out6;
    
    FrequencyDivider2 TB_FrequencyDivider2 (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out2)
    );

    FrequencyDivider6 TB_FrequencyDivider6 (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out6)
    );

    always begin
        #10;
        clk_in <= ~clk_in;
    end

    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, TB);
    end

    initial begin
        clk_in = 0;
        reset  = 1;

        $display("in TB: clk_in, clk_out2, clk_out6");
        $monitor("%d, %d, %d", clk_in, clk_out2, clk_out6);

        @(negedge clk_in);
        reset = 0;

        #200;
        $finish;
    end
endmodule