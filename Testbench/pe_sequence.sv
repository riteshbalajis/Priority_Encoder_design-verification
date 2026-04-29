// SEQUENCE

class pe_sequence extends uvm_sequence#(pe_seq_item);
  
  // Factory registration
  `uvm_object_utils(pe_sequence)
  
  pe_seq_item txn; // Transaction
  
  // Default constructor
  function new(string name = "pe_sequence");
    super.new(name);
  endfunction
  
  //-------------------------------body task----------------------------------------//
  task body();
    repeat (50) begin 
        txn = pe_seq_item::type_id::create("txn");
        start_item(txn);
        txn.randomize();
        finish_item(txn);
        // `uvm_info("SEQ", $sformatf("in = %b t = %0t", txn.in, $time), UVM_MEDIUM);
      end
  endtask
  //--------------------------------------------------------------------------------//
  
endclass: pe_sequence
