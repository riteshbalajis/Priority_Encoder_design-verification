// MONITOR

// Class declaration
class pe_monitor extends uvm_monitor;
  
  // Factory registration
  `uvm_component_utils(pe_monitor)
  
  // Virtualize the interface
  virtual pe_interface vif;
  
  pe_seq_item txn;
  
  // Declaring analysis port
  // Used to send the transaction to the connected components, such as scoreboard
  uvm_analysis_port#(pe_seq_item) mon_ap;
  
  // Default constructor for the class
  function new(string name = "pe_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
    
  //----------------------------Build phase----------------------------//
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    txn = pe_seq_item::type_id::create("txn", this); // Create a transaction
    
    if (!(uvm_config_db#(virtual pe_interface)::get(this, "", "vif", vif))) begin
      `uvm_info("MONITOR", "Unable to get virtual interface", UVM_MEDIUM);
    end
    
    mon_ap = new("mon_ap", this);
  endfunction: build_phase
  //----------------------------------------------------------------------------------//
  
  //----------------------Run phase (Monitoring DUT signals) -------------------------//
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    //forever begin
    forever @(posedge vif.clk) begin
     
      txn.in = vif.in;
      txn.out = vif.out;
      txn.valid = vif.valid;
      txn.clk=vif.clk;
      txn.rst=vif.rst;
      mon_ap.write(txn);
      
      // `uvm_info("MONITOR", $sformatf("txn.in = %0b, vif.in = %0b", txn.in, vif.in), UVM_MEDIUM);
    end
  endtask
  //----------------------------------------------------------------------------------//
    
endclass: pe_monitor
