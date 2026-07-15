`timescale 1ns/1ps

module door_controller(

    input clk,
    input reset,

    input open_request,

    output reg door_open

);

    // Door states
    parameter CLOSED = 2'b00;
    parameter OPEN   = 2'b01;
    parameter WAIT   = 2'b10;

    reg [1:0] state;
    reg [31:0] counter;

    always @(posedge clk or posedge reset)
    begin

        if(reset)
        begin
            state <= CLOSED;
            door_open <= 1'b0;
            counter <= 32'd0;
        end

        else
        begin

            case(state)

                // Door Closed
                CLOSED:
                begin
                    door_open <= 1'b0;
                    counter <= 32'd0;

                    if(open_request)
                        state <= OPEN;
                end

                // Open Door
                OPEN:
                begin
                    door_open <= 1'b1;
                    counter <= 32'd0;
                    state <= WAIT;
                end

                // Keep Door Open
                WAIT:
                begin
                    door_open <= 1'b1;
                    counter <= counter + 1;

                    // Simulation value
                    if(counter == 32'd20)
                    begin
                        door_open <= 1'b0;
                        counter <= 32'd0;
                        state <= CLOSED;
                    end
                end

                default:
                begin
                    state <= CLOSED;
                    door_open <= 1'b0;
                    counter <= 32'd0;
                end

            endcase

        end

    end

endmodule
