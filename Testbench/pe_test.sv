

class pe_test extends uvm_test;
  
  // Factory registration
  `uvm_component_utils(pe_test)
  
  pe_environment environment_h;
  pe_sequence sequence_h;
  
  // Interface
  virtual pe_interface vif;
  
  // ----------------------------------Declare constructor ------------------------------//
  function new(string name = "pe_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  //-------------------------------------------------------------------------------------//
  
  //------------------------------- Build phase -----------------------------------------//
  function void build_phase(uvm_phase phase);
    environment_h = pe_environment::type_id::create("environment_h", this);
    
    // Getting vif from testbench
    if (!(uvm_config_db#(virtual pe_interface)::get(this, "", "vif", vif))) begin
      `uvm_info("TEST", "Unable to get vif from tb", UVM_NONE);
    end
    
    // Setting the virtual interface to driver and monitor
    uvm_config_db#(virtual pe_interface)::set(this, "environment_h.agent_h.driver_h", "vif", vif);
    uvm_config_db#(virtual pe_interface)::set(this, "environment_h.agent_h.monitor_h", "vif", vif);
    
  endfunction: build_phase
  //--------------------------------------------------------------------------------------//
  
  //----------------------------------------------Run phase-------------------------------//
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    sequence_h = pe_sequence::type_id::create("pe_sequence", this);
    // Raise objection and drop objection
    phase.raise_objection(this);
    sequence_h.start(environment_h.agent_h.sequencer_h);
    phase.drop_objection(this);
  endtask
  //----------------------------------------------------------------------------------------//
  
endclass: pe_test
