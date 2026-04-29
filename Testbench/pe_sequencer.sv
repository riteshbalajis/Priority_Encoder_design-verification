// SEQUENCER

// Class declaration
class pe_sequencer extends uvm_sequencer#(pe_seq_item);
  
  // Factory registration
  `uvm_component_utils(pe_sequencer)
  
  // Default constructor for the class
  function new(string name = "pe_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass: pe_sequencer
