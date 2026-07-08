`timescale 1ns/1ps

module elevator_top(

    input clk,
    input reset,

    // Floor request input
    input request_valid,
    input [1:0] requested_floor,

    // Safety inputs
    input emergency,
    input overload,
    input obstruction,

    // Outputs
    output [1:0] current_floor,
    output door_open,
    output emergency_led

);


wire [3:0] requests;

wire [1:0] next_floor;
wire request_found;

wire direction;
wire next_direction;

wire move;

wire arrived;

wire allow_move;

wire door_busy;



//----------------------------------
// Request Manager
//----------------------------------

request_manager RM(

    .clk(clk),
    .reset(reset),

    .request_valid(request_valid),
    .requested_floor(requested_floor),

    .clear_request(arrived),
    .served_floor(current_floor),

    .requests(requests)

);



//----------------------------------
// Scheduler
//----------------------------------

scheduler SCH(

    .current_floor(current_floor),

    .direction(next_direction),

    .requests(requests),

    .next_floor(next_floor),

    .request_found(request_found),

    .next_direction(direction)

);



//----------------------------------
// Elevator Controller FSM
//----------------------------------

elevator_controller FSM(

    .clk(clk),
    .reset(reset),

    .request_valid(request_found),
    .requested_floor(next_floor),

    .emergency(emergency),

    .overload(overload),

    .obstruction(obstruction),

    .current_floor(current_floor),

    .direction(direction),

    .moving(move),

    .door_open(door_open),

    .busy(),

    .emergency_led(emergency_led)

);



//----------------------------------
// Floor Counter
//----------------------------------

floor_counter FC(

    .clk(clk),
    .reset(reset),

    .move(move & allow_move),

    .direction(direction),

    .target_floor(next_floor),

    .current_floor(current_floor),

    .arrived(arrived)

);



//----------------------------------
// Door Controller
//----------------------------------

door_controller DC(

    .clk(clk),
    .reset(reset),

    .open_request(arrived),

    .obstruction(obstruction),

    .door_open(door_open),

    .door_close(),

    .door_busy(door_busy)

);



//----------------------------------
// Safety Controller
//----------------------------------

safety_controller SAFE(

    .clk(clk),
    .reset(reset),

    .emergency(emergency),

    .overload_sensor(overload),

    .door_open(door_open),

    .move_request(move),

    .emergency_stop(),

    .overload_alarm(),

    .allow_move(allow_move)

);


endmodule
