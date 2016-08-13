
import uvm_pkg::*;
`include "uvm_macros.svh"

import test_lib_pkg::*;

module top;

  logic tb_clk;
  wire clk;
  reg rstn;

  // reset
  initial begin
    rstn = 1'b0;
    #(100ns);
    rstn = 1'b1;
  end

  // clocks
  initial begin
    tb_clk  = 1'b0;
    forever #10 tb_clk = ~tb_clk;
  end

  assign clk = tb_clk;

  //------------------
  // DUT
  //------------------
  DUT dut();


  //------------------
  // TB
  //------------------
  initial begin
    // save virtual interfaces...
    // TODO:
  
    // inflate tb...
    run_test();
    //NOTE: nothing gets caled after run_test()!!

  end

endmodule : top
