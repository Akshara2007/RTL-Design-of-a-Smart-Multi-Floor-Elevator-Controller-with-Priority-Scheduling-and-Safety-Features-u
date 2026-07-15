`timescale 1ns/1ps

module elevator_controller(

    input clk,
    input reset,

    input request_available,
    input [1:0] target_floor,

    output reg [1:0] current_floor,
    output reg moving,
    output reg clear_request,
    output reg open_request

);

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        current_floor <= 2'b00;
        moving <= 1'b0;
        clear_request <= 1'b0;
        open_request <= 1'b0;
    end

    else
    begin

        clear_request <= 1'b0;
        open_request <= 1'b0;

        if(request_available)
        begin

            if(current_floor < target_floor)
            begin
                current_floor <= current_floor + 1'b1;
                moving <= 1'b1;
            end

            else if(current_floor > target_floor)
            begin
                current_floor <= current_floor - 1'b1;
                moving <= 1'b1;
            end

            else
            begin
                moving <= 1'b0;
                clear_request <= 1'b1;
                open_request <= 1'b1;
            end

        end

        else
        begin
            moving <= 1'b0;
        end

    end

end

endmodule
