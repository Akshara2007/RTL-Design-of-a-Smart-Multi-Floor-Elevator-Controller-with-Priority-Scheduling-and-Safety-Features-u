`timescale 1ns/1ps

module elevator_controller #(parameter FLOORS = 4)
(
    input clk,
    input reset,

    // Floor request
    input request_valid,
    input [1:0] requested_floor,

    // Safety Inputs
    input emergency,
    input overload,
    input obstruction,

    // Outputs
    output reg [1:0] current_floor,
    output reg direction,        //0 = Down, 1 = Up
    output reg moving,
    output reg door_open,
    output reg busy,
    output reg emergency_led
);

parameter IDLE        = 3'd0;
parameter MOVE_UP     = 3'd1;
parameter MOVE_DOWN   = 3'd2;
parameter OPEN_DOOR   = 3'd3;
parameter WAIT_DOOR   = 3'd4;
parameter CLOSE_DOOR  = 3'd5;
parameter EMERGENCY   = 3'd6;

reg [2:0] state;
reg [1:0] target_floor;
reg [2:0] door_timer;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        current_floor <= 0;
        target_floor <= 0;
        moving <= 0;
        busy <= 0;
        door_open <= 0;
        emergency_led <= 0;
        direction <= 0;
        door_timer <= 0;
    end

    else
    begin

        case(state)

        //-------------------------------------
        IDLE:
        //-------------------------------------
        begin
            moving <= 0;
            busy <= 0;

            if(emergency)
            begin
                state <= EMERGENCY;
            end

            else if(request_valid)
            begin
                target_floor <= requested_floor;
                busy <= 1;

                if(requested_floor > current_floor)
                begin
                    direction <= 1;
                    state <= MOVE_UP;
                end

                else if(requested_floor < current_floor)
                begin
                    direction <= 0;
                    state <= MOVE_DOWN;
                end

                else
                begin
                    state <= OPEN_DOOR;
                end
            end
        end

        //-------------------------------------
        MOVE_UP
        //-------------------------------------
        begin

            if(emergency)
            begin
                state <= EMERGENCY;
            end

            else
            begin
                moving <= 1;

                if(current_floor < target_floor)
                    current_floor <= current_floor + 1;
                else
                begin
                    moving <= 0;
                    state <= OPEN_DOOR;
                end
            end

        end

        //-------------------------------------
        MOVE_DOWN
        //-------------------------------------
        begin

            if(emergency)
            begin
                state <= EMERGENCY;
            end

            else
            begin
                moving <= 1;

                if(current_floor > target_floor)
                    current_floor <= current_floor - 1;
                else
                begin
                    moving <= 0;
                    state <= OPEN_DOOR;
                end
            end

        end

        //-------------------------------------
        OPEN_DOOR
        //-------------------------------------
        begin

            if(overload)
            begin
                door_open <= 1;
            end

            else
            begin
                door_open <= 1;
                door_timer <= 3;
                state <= WAIT_DOOR;
            end

        end

        //-------------------------------------
        WAIT_DOOR
        //-------------------------------------
        begin

            if(obstruction)
            begin
                door_open <= 1;
                door_timer <= 3;
            end

            else if(door_timer > 0)
            begin
                door_timer <= door_timer - 1;
            end

            else
            begin
                state <= CLOSE_DOOR;
            end

        end

        //-------------------------------------
        CLOSE_DOOR
        //-------------------------------------
        begin

            door_open <= 0;
            busy <= 0;
            state <= IDLE;

        end

        //-------------------------------------
        EMERGENCY
        //-------------------------------------
        begin

            moving <= 0;
            busy <= 0;
            emergency_led <= 1;

            if(!emergency)
            begin
                emergency_led <= 0;
                state <= IDLE;
            end

        end

        endcase

    end

end

endmodule
