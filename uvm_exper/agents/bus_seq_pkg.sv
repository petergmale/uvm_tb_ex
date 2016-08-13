package bus_seq_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class bus_seq #(int WIDTH = 1) extends uvm_sequence;

  `uvm_object_param_utils(bus_seq#(WIDTH))

  local int unsigned    duration[$];
  local bit [WIDTH-1:0] bus_val[$];


  function new(string name="");
    super.new(name);
  endfunction

  function void add_transition_bits(bit [WIDTH-1:0] val, int unsigned dur);
    bus_val.push_back(val);
    duration.push_back(dur);
    assert(bus_val.size() == duration.size())
    else `uvm_fatal(get_full_name(), $sformatf("val/dur sizes out of sync: %0d, %0d",
            bus_val.size(), duration.size()))

    `uvm_info(get_full_name(), $sformatf("add_transition_bits(%h, %0d)", val, dur), UVM_LOW)

  endfunction: add_transition_bits

  task body();
    assert(bus_val.size == duration.size)
    else `uvm_fatal(get_full_name(), $sformatf("val/dur sizes out of sync: %0d, %0d",
            bus_val.size(), duration.size()))

    foreach(duration[i]) begin
      `uvm_info(get_full_name(), $sformatf("dur: %0d, val: %h", duration[i], bus_val[i]), UVM_LOW) 
    end
  endtask : body

endclass : bus_seq

typedef bus_seq#(1) bus_seq_1_t;
typedef bus_seq#(8) bus_seq_8_t;

endpackage : bus_seq_pkg
