// ENVIRONMENT

// Class declaration
class pe_environment extends uvm_env;
  
  // Factory registration
  `uvm_component_utils(pe_environment)
  
  // Virtualize the interface
  virtual pe_interface vif;
  
  // Declaring the environment components
  pe_agent agent_h;
  pe_scoreboard scoreboard_h;
  
  // Default constructor for the class
  function new(string name = "pe_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Building agent and scoreboard
    agent_h = pe_agent::type_id::create("agent_h", this);
    scoreboard_h = pe_scoreboard::type_id::create("scoreboard", this);    
  endfunction: build_phase
  
  // Connect phase for connecting monitor ---> scoreboard
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    agent_h.monitor_h.mon_ap.connect(scoreboard_h.sb_port);	
  endfunction: connect_phase
 
endclass: pe_environment
