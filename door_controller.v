`timescale 1ns/1ps

module door_controller(

    input clk,
    input reset,

    input open_request,

    output reg door_open

);


    reg [1:0] state;
    reg [31:0] counter;


    // Door states
    parameter CLOSED = 2'b00;
    parameter OPEN   = 2'b01;
    parameter WAIT   = 2'b10;



    always @(posedge clk or posedge reset)
    begin

        if(reset)
        begin
            door_open <= 1'b0;
            counter <= 32'd0;
            state <= CLOSED;
        end


        else
        begin

            case(state)



            // Door closed state
            CLOSED:
            begin

                door_open <= 1'b0;
                counter <= 32'd0;


                if(open_request)
                    state <= OPEN;

            end



            // Door opening state
            OPEN:
            begin

                door_open <= 1'b1;

                state <= WAIT;

            end



            // Door open for 5 seconds
            WAIT:
            begin

                door_open <= 1'b1;

                counter <= counter + 1;


                if(counter == 32'd250000000)
                begin

                    door_open <= 1'b0;

                    counter <= 32'd0;

                    state <= CLOSED;

                end

            end



            endcase

        end

    end


endmodule
