`timescale 10ns / 1ps

module automatic_washing_machine_system (
    input clk,
    input rst,
    input start,
    input door_close,
    input filled,
    input detergent_added,
    input cycle_timeout,
    input drained,
    input spin_timeout,

    output reg door_lock,
    output reg motor_on,
    output reg fill_valve_on,
    output reg drain_valve_on,
    output reg done
);

  // State declaration
  parameter check_door = 3'b000;
  parameter fill_water = 3'b001;
  parameter add_detergent = 3'b010;
  parameter wash = 3'b011;
  parameter drain = 3'b100;
  parameter spin = 3'b101;

  reg [2:0] current_state_reg;
  reg [2:0] next_state_reg;

  reg soap_wash;
  reg water_wash;

  // State register
  always @(posedge clk or posedge rst) begin
    if (rst) current_state_reg <= check_door;
    else current_state_reg <= next_state_reg;
  end

  // Next-state logic and output logic
  always @(*) begin
    // Default assignments (avoid latches)
    next_state_reg = current_state_reg;
    door_lock      = 0;
    motor_on       = 0;
    fill_valve_on  = 0;
    drain_valve_on = 0;
    done           = 0;
    soap_wash      = 0;
    water_wash     = 0;

    case (current_state_reg)

      check_door: begin
        if (start && door_close) begin
          next_state_reg = fill_water;
          door_lock      = 1;
        end
      end

      fill_water: begin
        fill_valve_on = 1;
        door_lock     = 1;

        if (filled) begin
          if (soap_wash == 0) begin
            next_state_reg = add_detergent;
            soap_wash      = 1;
          end else begin
            next_state_reg = wash;
            water_wash     = 1;
          end
        end
      end

      add_detergent: begin
        door_lock = 1;

        if (detergent_added) next_state_reg = wash;
      end

      wash: begin
        motor_on  = 1;
        door_lock = 1;

        if (cycle_timeout) next_state_reg = drain;
      end

      drain: begin
        drain_valve_on = 1;
        door_lock      = 1;

        if (drained) next_state_reg = spin;
      end

      spin: begin
        motor_on  = 1;
        door_lock = 1;

        if (spin_timeout) begin
          next_state_reg = check_door;
          done           = 1;
        end
      end

      default: begin
        next_state_reg = check_door;
      end

    endcase
  end

endmodule
