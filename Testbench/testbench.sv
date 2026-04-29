
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "pe_interface.sv"
`include "pe_seq_item.svh"
`include "pe_sequence.svh"
`include "pe_sequencer.svh"
`include "pe_monitor.svh"
`include "pe_driver.svh"
`include "pe_agent.svh"
`include "pe_scoreboard.svh"
`include "pe_environment.svh"
`include "pe_test.svh"

module priority_encoder_4to2_tb_top();
  
  // Instantiate the interface
  pe_interface vif();
  
  // Instantiate the DUT signals
  priority_encoder_4to2 dut(.clk(vif.clk), .rst(vif.rst), .in(vif.in), .out(vif.out), .valid(vif.valid));
  
  // Initializing interface signals
  initial begin
    vif.in = 0;
    vif.clk=1;
    vif.rst=1;
    #10 vif.rst=0;
  end
  
  
  always #5 vif.clk=~vif.clk;

  
  // Dumping waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, priority_encoder_4to2_tb_top);
  end
  
  // Setting the interface
  initial begin
    uvm_config_db#(virtual pe_interface)::set(null, "uvm_test_top", "vif", vif);
  end
  
  // Run test
  initial begin
    run_test("pe_test");
  end

endmodule

