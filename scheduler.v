`timescale 1ns/1ps

module scheduler(

    input  [1:0] current_floor,
    input        direction,          // 1 = UP, 0 = DOWN
    input  [3:0] requests,           // Pending floor requests

    output reg [1:0] next_floor,
    output reg       request_found,
    output reg       next_direction

);

integer i;

always @(*)
begin

    // Default values
    next_floor = current_floor;
    request_found = 0;
    next_direction = direction;


    // ---------------------------
    // Elevator moving UP
    // ---------------------------
    if(direction == 1'b1)
    begin

        // Search higher floors first
        for(i = current_floor + 1; i < 4; i = i + 1)
        begin
            if(requests[i] && !request_found)
            begin
                next_floor = i[1:0];
                request_found = 1'b1;
                next_direction = 1'b1;
            end
        end


        // If no request above, search below
        if(!request_found)
        begin

            for(i = current_floor - 1; i >= 0; i = i - 1)
            begin
                if(requests[i] && !request_found)
                begin
                    next_floor = i[1:0];
                    request_found = 1'b1;
                    next_direction = 1'b0;
                end
            end

        end

    end



    // ---------------------------
    // Elevator moving DOWN
    // ---------------------------
    else
    begin

        // Search lower floors first
        for(i = current_floor - 1; i >= 0; i = i - 1)
        begin
            if(requests[i] && !request_found)
            begin
                next_floor = i[1:0];
                request_found = 1'b1;
                next_direction = 1'b0;
            end
        end


        // If no request below, search above
        if(!request_found)
        begin

            for(i = current_floor + 1; i < 4; i = i + 1)
            begin
                if(requests[i] && !request_found)
                begin
                    next_floor = i[1:0];
                    request_found = 1'b1;
                    next_direction = 1'b1;
                end
            end

        end

    end

endmodule
