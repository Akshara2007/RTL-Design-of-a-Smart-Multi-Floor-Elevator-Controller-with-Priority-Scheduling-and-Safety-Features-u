module digital_clock(
    input clk,
    input reset,
    output reg [5:0] seconds,
    output reg [5:0] minutes,
    output reg [4:0] hours
);

reg [25:0] count;

always @(posedge clk)
begin
    if(reset)
    begin
        count <= 0;
        seconds <= 0;
        minutes <= 0;
        hours <= 0;
    end

    else if(count == 50000000-1)
    begin
        count <= 0;

        if(seconds == 59)
        begin
            seconds <= 0;

            if(minutes == 59)
            begin
                minutes <= 0;

                if(hours == 23)
                    hours <= 0;
                else
                    hours <= hours + 1;
            end

            else
                minutes <= minutes + 1;
        end

        else
            seconds <= seconds + 1;
    end

    else
    begin
        count <= count + 1;
    end
end

endmodule
