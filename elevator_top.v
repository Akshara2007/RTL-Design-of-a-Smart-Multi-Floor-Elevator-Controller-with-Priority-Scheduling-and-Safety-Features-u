`timescale 1ns/1ps

module elevator_top(

    input clk,
    input reset,

    // Floor request
    input request_valid,
    input [1:0] requested_floor,

    // Outputs
    output [1:0] current_floor,
    output door_open

);

wire [3:0] requests;
wire [1:0] target_floor;
wire request_available;
wire moving;
wire clear_request;
wire open_request;


// Request Manager
request_manager RM(

    .clk(clk),
    .reset(reset),

    .request_valid(request_valid),
    .requested_floor(requested_floor),

    .clear_request(clear_request),
    .served_floor(current_floor),

    .requests(requests)

);


// Scheduler
scheduler SCH(

    .requests(requests),
    .current_floor(current_floor),

    .target_floor(target_floor),
    .request_available(request_available)

);


// Elevator Controller
elevator_controller EC(

    .clk(clk),
    .reset(reset),

    .request_available(request_available),
    .target_floor(target_floor),

    .current_floor(current_floor),
    .moving(moving),
    .clear_request(clear_request),
    .open_request(open_request)

);


// Door Controller
door_controller DC(

    .clk(clk),
    .reset(reset),

    .open_request(open_request),

    .door_open(door_open)

);

endmodule
