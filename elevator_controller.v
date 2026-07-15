`timescale 1ns/1ps

module elevator_controller(

    input clk,
    input reset,
    input [3:0] requests,

    output reg [1:0] current_floor,
    output reg direction,
    output reg door_open,
    output reg clear_request,
    output reg [1:0] served_floor

);

    // FSM State Register
    reg [1:0] state;

    // Destination Register
    reg [1:0] destination;

    // FSM States
    parameter IDLE = 2'b00;
    parameter MOVE = 2'b01;
    parameter DOOR = 2'b10;

    always @(posedge clk or posedge reset)
    begin

        if(reset)
        begin
            current_floor <= 2'b00;
            direction <= 1'b0;
            door_open <= 1'b0;
            clear_request <= 1'b0;
            served_floor <= 2'b00;
            destination <= 2'b00;
            state <= IDLE;
        end

        else
        begin

            // Default values
            clear_request <= 1'b0;

            case(state)

            //========================
            // IDLE STATE
            //========================
            IDLE:
            begin

                door_open <= 1'b0;

                // Find first requested floor
                if(requests[0])
                    destination <= 2'b00;

                else if(requests[1])
                    destination <= 2'b01;

                else if(requests[2])
                    destination <= 2'b10;

                else if(requests[3])
                    destination <= 2'b11;

                // If any request exists
                if(requests != 4'b0000)
                    state <= MOVE;

            end

            //========================
            // MOVE STATE
            //========================
            MOVE:
            begin

                // Move Up
                if(destination > current_floor)
                begin
                    direction <= 1'b1;
                    current_floor <= current_floor + 2'b01;
                end

                // Move Down
                else if(destination < current_floor)
                begin
                    direction <= 1'b0;
                    current_floor <= current_floor - 2'b01;
                end

                // Destination reached
                else
                begin
                    state <= DOOR;
                end

            end

            //========================
            // DOOR STATE
            //========================
            DOOR:
            begin

                door_open <= 1'b1;

                clear_request <= 1'b1;

                served_floor <= current_floor;

                direction <= 1'b0;

                state <= IDLE;

            end

            default:
                state <= IDLE;

            endcase

        end

    end

endmodule
