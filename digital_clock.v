module digital_clock_stopwatch_timer(
    input clk,          // system clock
    input reset,        // async reset
    input mode,         // 0 = clock, 1 = stopwatch/timer toggle
    input start_stop,   // control stopwatch/timer
    input set_timer,    // load timer preset
    output reg [4:0] hour,
    output reg [5:0] minute,
    output reg [5:0] second
);

reg running;
reg timer_mode;   // 0 = stopwatch, 1 = countdown timer
reg [5:0] t_sec, t_min;
reg [4:0] t_hour;

// -------------------------
// MAIN SEQUENTIAL LOGIC
// -------------------------
always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        hour <= 0;
        minute <= 0;
        second <= 0;

        t_sec <= 0;
        t_min <= 0;
        t_hour <= 0;

        running <= 0;
        timer_mode <= 0;
    end
    else
    begin

        // -------------------------
        // MODE SELECT
        // -------------------------
        if(mode == 0)
        begin
            // CLOCK MODE
            if(second == 59)
            begin
                second <= 0;

                if(minute == 59)
                begin
                    minute <= 0;

                    if(hour == 23)
                        hour <= 0;
                    else
                        hour <= hour + 1;
                end
                else
                    minute <= minute + 1;
            end
            else
                second <= second + 1;
        end

        else
        begin
            // STOPWATCH / TIMER MODE

            if(start_stop)
                running <= ~running;

            // -------------------------
            // STOPWATCH MODE
            // -------------------------
            if(timer_mode == 0)
            begin
                if(running)
                begin
                    if(second == 59)
                    begin
                        second <= 0;

                        if(minute == 59)
                        begin
                            minute <= 0;
                            hour <= hour + 1;
                        end
                        else
                            minute <= minute + 1;
                    end
                    else
                        second <= second + 1;
                end
            end

            // -------------------------
            // TIMER MODE (COUNTDOWN)
            // -------------------------
            else
            begin
                if(set_timer)
                begin
                    // preset example: 1 minute
                    second <= 0;
                    minute <= 1;
                    hour <= 0;
                end

                if(running)
                begin
                    if(second == 0)
                    begin
                        if(minute == 0)
                        begin
                            running <= 0; // stop at zero
                        end
                        else
                        begin
                            second <= 59;
                            minute <= minute - 1;
                        end
                    end
                    else
                        second <= second - 1;
                end
            end

        end
    end
end

endmodule
endmodule
