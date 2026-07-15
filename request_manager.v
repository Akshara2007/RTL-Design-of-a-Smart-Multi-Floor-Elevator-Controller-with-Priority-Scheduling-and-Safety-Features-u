`timescale 1ns/1ps

module request_manager(

    input clk,
    input reset,

    input request_valid,
    input [1:0] requested_floor,

    input clear_request,
    input [1:0] served_floor,

    output reg [3:0] requests

);

always @(posedge clk or posedge reset)
begin

    if(reset)
        requests <= 4'b0000;

    else
    begin

        if(request_valid)
            requests[requested_floor] <= 1'b1;

        if(clear_request)
            requests[served_floor] <= 1'b0;

    end

end

endmodule
