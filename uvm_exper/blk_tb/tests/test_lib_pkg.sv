
package test_lib_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import bus_seq_pkg::*;
  import sv_example_seq_pkg::*;

class test_base extends uvm_test;
  `uvm_component_utils(test_base);

  typedef bus_seq_pkg::bus_seq#(8) bus_seq_t;

  function new(string name="", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "DBG: build_phase", UVM_LOW)
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    bus_seq_t bus_seq;
    sv_example_seq_pkg::abc_patt_seq patt_seq;

    `uvm_info(get_full_name(), "run_phase()", UVM_LOW)

    phase.raise_objection(this);
    bus_seq = bus_seq_t::type_id::create("bus_seq", this);
    bus_seq.add_transition_bits('h00, 0);
    bus_seq.add_transition_bits('h01, 5);
    bus_seq.start(null);

    patt_seq = sv_example_seq_pkg::abc_patt_seq::type_id::create("patt_seq", this);
    patt_seq.start(null);

    #(1000ns);
    `uvm_info(get_full_name(), "run_phase()..DONE", UVM_LOW)
    phase.drop_objection(this);

  endtask : run_phase

endclass : test_base

endpackage : test_lib_pkg
