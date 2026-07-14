`timescale  1ns/1ps
module  elevator_controller(
  input clk,
  input reset,
  input [3:0] requests,
  output reg[1:0] current_floor,
  output reg direction,
  output reg door_open'
  output reg clear_request,
  output reg served_floor
);
  //FSM  State Registers
  reg [1:0] state;
  // FSM States
parameter IDLE = 2'b00;
parameter MOVE = 2'b01;
parameter DOOR = 2'b10;
  
    // Destination register
  reg [1;0] destination;
  always @(posedge clk or posedge reset)
    begin 
      if (reset)
        begin 
          current_floor <= 2'b00;
          direction <= 1'b0;
          door_open <=1'b0;
          clear_request <=1'b0;
          served_foor <= 2'b00;
          destination <=2'b00;
          state <= IDLE;
        end
      else 
        begin 
          //default value 
          clear_request <=1'b0;
          case(state)
            //IDLE STATE
            IDLE:
              begin 
                door_open <=1'b0;
                //find destination
                 if(requests[0])
                    destination <= 2'b00;

                else if(requests[1])
                    destination <= 2'b01;

                else if(requests[2])
                    destination <= 2'b10;

                else if(requests[3])
                    destination <= 2'b11;
               // If request exists, start moving
              if(requests != 4'b0000)
                  state <= MOVE;
                
                end
            // MOVE STATE
            MOVE:
            begin
               // Move upward
                if(destination > current_floor)
                begin
                    direction <= 1'b1; 
                    current_floor <= current_floor + 2'b01;
                   end
                // Move downward
                else if(destination < current_floor)
                begin
                    direction <= 1'b0;
                    current_floor <= current_floor - 2'b01;
                end
            end
            // DOOR STATE
             DOOR:
            begin

                door_open <= 1'b1;

                clear_request <= 1'b1;

                state <= IDLE;

            end



            endcase

        end

    end


endmodule
            
              

              
            
          
                
          
    
  
  
