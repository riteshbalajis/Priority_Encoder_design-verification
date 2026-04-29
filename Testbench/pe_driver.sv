// DRIVER

// Class declaration
class pe_driver extends uvm_driver#(pe_seq_item);
  
  // Factory registration
  `uvm_component_utils(pe_driver)
  
  // Virtualize the interface
  virtual pe_interface vif;
  
  // Transaction
  pe_seq_item txn;
  
  // Default constructor for the class
  function new(string name = "pe_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //-------------------------------build phase----------------------------------------//
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (!uvm_config_db#(virtual pe_interface)::get(this, "", "vif", vif)) begin
      `uvm_info("DRIVER", "Unable to get virtual interface", UVM_MEDIUM);
    end
  endfunction: build_phase
  //----------------------------------------------------------------------------------//
  
  // Run phase  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  
    txn = pe_seq_item::type_id::create("txn");
    
    //forever begin
    forever @(posedge vif.clk) begin
  
      seq_item_port.get_next_item(txn); // Get the next available transaction
      drive(txn);  // Drive/update the interface signals
      seq_item_port.item_done();  // Done. Send next transaction.
    end
  endtask
  
  // Drive item task
  task drive(pe_seq_item txn);
    
    // `uvm_info("DRIVER", $sformatf("vif.in = %0b, txn.in = %0b", vif.in, txn.in), UVM_NONE);
    
    vif.in = txn.in;
    vif.clk=txn.clk;
    vif.rst=txn.rst;
    // We shouldn't drive 'out' and 'valid' because they are outputs from the DUT
    
    // `uvm_info("DRIVER", $sformatf("vif.in = %0b, txn.in = %0b", vif.in, txn.in), UVM_NONE);
    
  endtask
  
endclass: pe_driver
