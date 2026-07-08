`timescale 1ns/1ps

module door_controller(

    input clk,
    input reset,

    input open_request,
    input obstruction,

    output reg door_open,
    output reg door_close,
    output reg door_busy

);


parameter CLOSED = 2'b00;
parameter OPEN   = 2'b01;
parameter WAIT   = 2'b10;
parameter CLOSE  = 2'b11;


reg [1:0] state;
reg [2:0] timer;


always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= CLOSED;
        door_open <= 0;
        door_close <= 0;
        door_busy <= 0;
        timer <= 0;
    end


    else
    begin

        case(state)


        // Door closed
        CLOSED:
        begin

            door_open <= 0;
            door_close <= 0;
            door_busy <= 0;


            if(open_request)
            begin
                state <= OPEN;
            end

        end



        // Opening door
        OPEN:
        begin

            door_open <= 1;
            door_busy <= 1;

            timer <= 3;

            state <= WAIT;

        end



        // Door waiting state
        WAIT:
        begin

            door_open <= 1;

            if(obstruction)
            begin
                timer <= 3;
            end


            else if(timer > 0)
            begin
                timer <= timer - 1;
            end


            else
            begin
                state <= CLOSE;
            end

        end



        // Closing door
        CLOSE:
        begin

            door_close <= 1;
            door_open <= 0;
            door_busy <= 0;


            if(obstruction)
            begin
                state <= OPEN;
            end


            else
            begin
                state <= CLOSED;
            end

        end


        endcase

    end

end


endmodule
