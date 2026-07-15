`timescale 1ns/1ps

module scheduler(

    input [3:0] requests,
    input [1:0] current_floor,

    output reg [1:0] target_floor,
    output reg request_available

);

always @(*)
begin

    request_available = 1'b0;
    target_floor = current_floor;

    if(requests[current_floor])
    begin
        target_floor = current_floor;
        request_available = 1'b1;
    end
    else if(requests[0])
    begin
        target_floor = 2'b00;
        request_available = 1'b1;
    end
    else if(requests[1])
    begin
        target_floor = 2'b01;
        request_available = 1'b1;
    end
    else if(requests[2])
    begin
        target_floor = 2'b10;
        request_available = 1'b1;
    end
    else if(requests[3])
    begin
        target_floor = 2'b11;
        request_available = 1'b1;
    end

end

endmodule
