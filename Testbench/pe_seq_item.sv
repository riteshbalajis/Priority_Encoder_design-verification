// SEQUENCE ITEM

// Class declaration
class pe_seq_item extends uvm_sequence_item;

  // Factory registration
  `uvm_object_utils(pe_seq_item)

  // Declare all sequence items
  rand logic [7:0] in;  // 4-bit input
  logic [2:0] out;  // 2-bit output
  logic clk,rst;
  logic valid;   
  //Valid signal

  // Default constructor for class
  function new(string name = "pe_seq_item");
    super.new(name);
  endfunction

endclass: pe_seq_item
