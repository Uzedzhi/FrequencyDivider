`include "FrequencyDivider_h.v"

`include "FrequencyDivider2.v"
`include "FrequencyDivider6.v"
module TB();
// -------------Initialize clock-------------
    reg  clk_in;
    initial begin
        clk_in = 0;
    end

    always begin
        #10;
        clk_in <= ~clk_in;
    end
// ------------------------------------------

// -----------Instantiate Testing Modules------------
    reg  reset;
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
// ---------------------------------------------------

    // Dump for waveform
    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, TB);
    end

    reg AllCorrect  = 1;
    integer count6  = 0;
    integer count2  = 0;
    reg exp_6   = 0;
    reg exp_2   = 0;
    
    initial begin: Tests
        @(posedge clk_in);
        reset = 1;

        @(negedge clk_in);
        reset = 0;

        for (integer i = 0; i < `NUM_OF_TICKS; i = i + 1) begin
            count6 = count6 + 1;
            count2 = count2 + 1;

            if (exp_6 != clk_out6) begin
                $write("%c[1;31m[ОШИБКА]%c[0m в меандре делителя частоты на 6 в %d такте\n", `ESC, `ESC, i + 1);
                $write("\tОжидаемое состояние: %d, текущее: %d\n", exp_6, clk_out6); 
                AllCorrect = 0;
            end

            if (exp_2 != clk_out2) begin
                $write("%c[1;31m[ОШИБКА]%c[0m в меандре делителя частоты на 2 в %d такте\n", `ESC, `ESC, i + 1);
                $write("\tОжидаемое состояние: %d, текущее: %d\n", exp_2, clk_out2); 
                AllCorrect = 0;
            end

            if (count6 % 3 == 0)
                exp_6 = ~exp_6;
            exp_2 = ~exp_2;

            @(negedge clk_in);
        end

        if (AllCorrect) begin
            $display("%c[1;32mВсе тесты пройдены успешно!%c[0m", `ESC, `ESC);
        end
        $finish;
    end
endmodule