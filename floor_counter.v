`timescale 1ns/1ps

module floor_counter(

    input clk,
    input reset,

    input move,
    input direction,          //1 = UP, 0 = DOWN
    input [1:0] target_floor,

    output reg [1:0] current_floor,
    output reg arrived

);


always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        current_floor <= 2'b00;
        arrived <= 1'b0;
    end


    else
    begin

        arrived <= 1'b0;


        if(move)
        begin

            // Moving UP
            if(direction == 1'b1)
            begin

                if(current_floor < target_floor)
                begin
                    current_floor <= current_floor + 1'b1;
                end

                else
                begin
                    arrived <= 1'b1;
                end

            end



            // Moving DOWN
            else
            begin

                if(current_floor > target_floor)
                begin
                    current_floor <= current_floor - 1'b1;
                end

                else
                begin
                    arrived <= 1'b1;
                end

            end

        end

    end

end

endmodule
