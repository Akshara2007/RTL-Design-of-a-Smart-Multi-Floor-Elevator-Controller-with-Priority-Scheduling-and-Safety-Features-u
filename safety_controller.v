
`timescale 1ns/1ps

module safety_controller(

    input clk,
    input reset,

    input emergency,
    input overload_sensor,
    input door_open,

    input move_request,

    output reg emergency_stop,
    output reg overload_alarm,
    output reg allow_move

);


always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        emergency_stop <= 0;
        overload_alarm <= 0;
        allow_move <= 1;
    end


    else
    begin

        // Emergency handling
        if(emergency)
        begin
            emergency_stop <= 1;
        end

        else
        begin
            emergency_stop <= 0;
        end



        // Overload detection
        if(overload_sensor)
        begin
            overload_alarm <= 1;
        end

        else
        begin
            overload_alarm <= 0;
        end



        // Movement permission

        if(emergency || overload_sensor || door_open)
        begin
            allow_move <= 0;
        end

        else if(move_request)
        begin
            allow_move <= 1;
        end

        else
        begin
            allow_move <= 0;
        end


    end

end


endmodule
