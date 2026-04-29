// PE AGENT

// Class declaration
class pe_agent extends uvm_agent;
  
  // Factory registration
  `uvm_component_utils(pe_agent)
  
  // Declaring agent components
  pe_monitor monitor_h;
  pe_driver driver_h;
  pe_sequencer sequencer_h;
  
  // Default constructor for the class
  function new(string name = "pe_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //----------------------------------Build phase-----------------------------------//
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor_h = pe_monitor::type_id::create("monitor_h", this);
    driver_h = pe_driver::type_id::create("driver_h", this);
    sequencer_h = pe_sequencer::type_id::create("sequencer_h", this);
  endfunction: build_phase
  //---------------------------------------------------------------------------------//
  
  //---------------- Connect phase for connecting driver <--- sequencer -------------//
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction: connect_phase
  //---------------------------------------------------------------------------------//

endclass: pe_agent
