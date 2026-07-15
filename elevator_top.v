`timescale 1ns/1ps

module elevator_top(

    input clk,
    input reset,

    input request_valid,
    input [1:0] requested_floor,

    output [1:0] current_floor,
    output direction,
    output door_open,
    output door_close

);

wire [3:0] requests;
wire clear_request;
wire [1:0] served_floor;
wire open_request;


//-----------------------------
// Request Manager
//-----------------------------
request_manager RM(

    .clk(clk),
    .reset(reset),

    .request_valid(request_valid),
    .requested_floor(requested_floor),

    .clear_request(clear_request),
    .served_floor(served_floor),

    .requests(requests)

);


//-----------------------------
// Elevator Controller
//-----------------------------
elevator_controller EC(

    .clk(clk),
    .reset(reset),

    .requests(requests),

    .current_floor(current_floor),

    .direction(direction),

    .clear_request(clear_request),

    .served_floor(served_floor),

    .open_request(open_request)

);


//-----------------------------
// Door Controller
//-----------------------------
door_controller DC(

    .clk(clk),
    .reset(reset),

    .open_request(open_request),

    .door_open(door_open),

    .door_close(door_close)

);

endmodule
