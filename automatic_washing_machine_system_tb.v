`timescale 10ns / 1ps

module automatic_washing_machine_tb;

  // -------------------------------------------------
  // Input signals (reg)
  // -------------------------------------------------
  reg  clk;
  reg  rst;
  reg  start;
  reg  door_close;
  reg  filled;
  reg  detergent_added;
  reg  cycle_timeout;
  reg  drained;
  reg  spin_timeout;

  // -------------------------------------------------
  // Output signals (wire)
  // -------------------------------------------------
  wire door_lock;
  wire motor_on;
  wire fill_valve_on;
  wire drain_valve_on;
  wire done;

  // -------------------------------------------------
  // DUT Instantiation
  // -------------------------------------------------
  automatic_washing_machine_system dut (
      .clk            (clk),
      .rst            (rst),
      .start          (start),
      .door_close     (door_close),
      .filled         (filled),
      .detergent_added(detergent_added),
      .cycle_timeout  (cycle_timeout),
      .drained        (drained),
      .spin_timeout   (spin_timeout),
      .door_lock      (door_lock),
      .motor_on       (motor_on),
      .fill_valve_on  (fill_valve_on),
      .drain_valve_on (drain_valve_on),
      .done           (done)
  );

  // -------------------------------------------------
  // Clock Generation (10 ns period)
  // -------------------------------------------------
  always #5 clk = ~clk;

  // -------------------------------------------------
  // Test Sequence
  // -------------------------------------------------
  initial begin
    // Initial values
    clk             = 0;
    rst             = 1;
    start           = 0;
    door_close      = 0;
    filled          = 0;
    detergent_added = 0;
    cycle_timeout   = 0;
    drained         = 0;
    spin_timeout    = 0;

    // Reset pulse
    #20 rst = 0;

    // Start machine & close door
    #10 start = 1;
    door_close = 1;

    // Water filled
    #20 filled = 1;

    // Detergent added
    #20 detergent_added = 1;

    // Washing completed
    #30 cycle_timeout = 1;

    // Drain completed
    #20 drained = 1;

    // Spin completed
    #30 spin_timeout = 1;

    // End simulation
    #50 $stop;
  end

endmodule

